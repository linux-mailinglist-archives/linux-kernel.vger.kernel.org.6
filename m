Return-Path: <linux-kernel+bounces-531696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E1CA443C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A26B86110D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B43121ABC9;
	Tue, 25 Feb 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVZan0fV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0AA21ABC6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495328; cv=none; b=V3zeMe1OOVcBvSLJ/SYDW2FP7mR4mA61aVbz0qcgftPAF5Av0ajghkezNgB003+knAokV05OUPH8Li156BZbWrtLI4OvMP1FEwU/9kCAEgwMc33LIz7gvQ10v15a02/ocWe7H5m5JaX9HkdDmL6PDBgpH/sZnS15E399FNRqyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495328; c=relaxed/simple;
	bh=N7cXk0xwkxHLyp46KrkCrfl8x3DEFXzKxkNNdsktsZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dvophu42LZ9OPctE/lp3+Bx42RkG+rjAckQR7FZU9WbI3VOcOHMEoH0fzuTZX7bNi17ppQjXeee2x5dJ3lTtgksNm7xi9a24rm8KPaoLUjqQdgSPOfavT3icsl+s4a+qB/K5M+4S/1uDT6ybOZ4jBHR7habJC7mdCmRmKfBmxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVZan0fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5041C4CEDD;
	Tue, 25 Feb 2025 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740495328;
	bh=N7cXk0xwkxHLyp46KrkCrfl8x3DEFXzKxkNNdsktsZo=;
	h=From:To:Cc:Subject:Date:From;
	b=dVZan0fVJsecmsulx83oIUJIB5qetsUe6hLw9ehObVSx1I2iUmgPKjLcGk0vFJYPQ
	 UqaObFVnVDV87Hw+QLEqcKpsCfcX9smN1x3rsgT8AbXwi67gaWvmfy799njlwat7D6
	 5VxsVQy1iqhrjnTA3H4VejEasXkDscHSx+vXCHAiOz1nrRms2z8sWMKFIMSyS27HJE
	 UlQ66u4lS+bzdoLDDHt1px+sb7y0gZz66rkEBUfWL1k2iQCuU03fBJ8+KSDGOCbglF
	 YQb9FrVC/dNJhkZdzF0TofsdaGMLKc6wpiZUeYIYvxxEyKJF6zJECA8synDV2ktC6b
	 DS963AfrUoxmQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Kosina <jkosina@suse.com>,
	Jiri Kosina <jikos@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] apm-emulation: hide an unused variable
Date: Tue, 25 Feb 2025 15:55:14 +0100
Message-Id: <20250225145524.1154444-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver_version variable is only used inside of an #ifdef block, which
leads to a W=1 warning:

drivers/char/apm-emulation.c:144:19: error: 'driver_version' defined but not used [-Werror=unused-const-variable=]

Move this into the function using it.

Fixes: 7726942fb15e ("[APM] Add shared version of APM emulation")
Acked-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found while looking through my patch backlog, still applies
---
 drivers/char/apm-emulation.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/apm-emulation.c b/drivers/char/apm-emulation.c
index e795390b070f..53ce352f7197 100644
--- a/drivers/char/apm-emulation.c
+++ b/drivers/char/apm-emulation.c
@@ -141,9 +141,6 @@ static struct apm_queue kapmd_queue;
 
 static DEFINE_MUTEX(state_lock);
 
-static const char driver_version[] = "1.13";	/* no spaces */
-
-
 
 /*
  * Compatibility cruft until the IPAQ people move over to the new
@@ -435,6 +432,8 @@ static struct miscdevice apm_device = {
  */
 static int proc_apm_show(struct seq_file *m, void *v)
 {
+	static const char driver_version[] = "1.13";	/* no spaces */
+
 	struct apm_power_info info;
 	char *units;
 
-- 
2.39.5


