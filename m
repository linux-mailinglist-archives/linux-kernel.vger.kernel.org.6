Return-Path: <linux-kernel+bounces-512837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D3A33E46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EA6188B3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAEC21422A;
	Thu, 13 Feb 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="naKAqAbs"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F48B227E83
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446894; cv=none; b=B8FyHKY9uAbXkXPCVw+9B0nEB0orkIcd+lzJ1YyOMYhCyvhvvmJI/oPy1MA9cfcCOrR0I+P5qhxYlQkrPW3ElQYwEX1FdumJ1CpfQORBEITYUMQdqUjdMDYj+TgVdTjUrdIeNdQHuVU2GUcZAfAJqn6MT+bZ3vO380Aty3Fd/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446894; c=relaxed/simple;
	bh=+qKUAWjFc48ziEJIkUk+8ESw3UmXJzNOpYUOg1HgaSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IA77Zt1CBzRqFDvKzDk0oTfH4D8b0RkCj3QppGxhaWAgFNyYaizCwZZmrTIGha9YQeq9vuvEFSi/ee3D7uQfzlZvXtx9AzdvNMIUNUHAQyeh1GfT8V4qB8TB5CH1HbL3GrvLE9j/O/D8Rp8KnlWtpHIeUS6LsbAbiiLGIkXVQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=naKAqAbs; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739446880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ML720xXgLDVS1KuIyxe6zn7F10AobIzF856LOQXCS0o=;
	b=naKAqAbsp+YtigXKI1sWgYo5jQhp7EUIniFG0D5o7qPUY9f+wlVu6JZVYie6SAddb5woy2
	3cpyd5IKgTpUiBonCbEIwS7X4o4CoMZUvj6pNOwQdV+dU10C/lIPYFXqv/3ervuT9zNySV
	iVGnZjzJvyPevBl1yjpwc84DSM3gsd4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: hpsa: Replace deprecated strncpy() with strscpy_pad()
Date: Thu, 13 Feb 2025 12:40:48 +0100
Message-ID: <20250213114047.2366-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Replace
memset() and strncpy() with strscpy_pad() to copy the version string and
fill the remaining bytes in the destination buffer with NUL bytes. This
avoids zeroing the memory before copying the string.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use len instead of len - 1
- Link to v1: https://lore.kernel.org/r/20250212224352.86583-3-thorsten.blum@linux.dev/
---
 drivers/scsi/hpsa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index c7ebae24b09f..968cefb497eb 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -7236,8 +7236,7 @@ static int hpsa_controller_hard_reset(struct pci_dev *pdev,
 
 static void init_driver_version(char *driver_version, int len)
 {
-	memset(driver_version, 0, len);
-	strncpy(driver_version, HPSA " " HPSA_DRIVER_VERSION, len - 1);
+	strscpy_pad(driver_version, HPSA " " HPSA_DRIVER_VERSION, len);
 }
 
 static int write_driver_ver_to_cfgtable(struct CfgTable __iomem *cfgtable)
-- 
2.48.1


