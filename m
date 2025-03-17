Return-Path: <linux-kernel+bounces-564298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4AA65234
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56B43BA1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD10524166A;
	Mon, 17 Mar 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hKbHApAq"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17523F422
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220005; cv=none; b=Qvk273wswINO3BYMARS4Ycm0nxrdX82zfdbPTWUuCI87XDgl3Rt4bNqd7y9aD1fk3kiQU2Aeo0ciWzjfgSrSaJff3NXmcM8y/fJfklv/1zNYroWLkm7yfTblAneWMLgCczPtPttXVm2AUhNGkibcMO9n/DnmaKbMbAN+qW8iS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220005; c=relaxed/simple;
	bh=ymyjoRPJMcdgvc0kCRsHYHBbOg2KFPig2f5PgqMCl+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AwEBqNvpDrrGRUNO8mLcyZOyaSKu27xxA9CSJIP7Sjmf4PMxtrfFYUh6i9f4F7bljcVM4mktF+W/KHcSk57VHK6CTg0NQ94Nz7k+NHLoe3fmAzE+xACPUT0hHRCgrPPk4fqUtXA7IArptdZbTPWKqrW3zlrca/mU+kRXoGUB0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hKbHApAq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uejaEzJgm4AKmoazWPbdXJYFspuSptSDKXB+HI9ayM0=; b=hKbHApAqWuu7jFRF/VJSzV2WNz
	2aPgcNOPaMLYjeDai8XTbuEqs592BlukVvCavhUnaQI4hQ6EBJu3qpZv+9+8yaTrf8ym7nVJJLJ5m
	92Dnx9tKAtJSrK9Nv6BpEMUCN2ZNWpFbq9Zzwdsq2z1+crECa2LHpTTZHfKQSNqtux1I73pCOA1qT
	FlwR2TA5cXspyo3q4jWbOc8aT5Dc5z4O989O2//LYNfIAq6qd2zsY8XzXpFt1QiJXNOMlLfZ34UBw
	j2mBdzLENFUkNKCUjcIlcItDLBQwEv5TFTGi6poKfAObXo/9bJH/wUaJwroPkbERjEZfHXSSV/f/U
	nLLRJNfg==;
Received: from 179-125-64-250-dinamico.pombonet.net.br ([179.125.64.250] helo=[192.168.67.187])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tuB0S-002FgL-Df; Mon, 17 Mar 2025 14:59:52 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 17 Mar 2025 10:59:55 -0300
Subject: [PATCH] char: misc: register chrdev region with all possible
 minors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-misc-chrdev-v1-1-6cd05da11aef@igalia.com>
X-B4-Tracking: v=1; b=H4sIANoq2GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Nz3dzM4mTd5IyilNQy3SQjsyRTc6NEE/O0ZCWgjoKi1LTMCrBp0bG
 1tQC4FUrSXQAAAA==
X-Change-ID: 20250317-misc-chrdev-b26b572a47fc
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 D Scott Phillips <scott@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 kernel test robot <oliver.sang@intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2

register_chrdev will only register the first 256 minors of a major chrdev.
That means that dynamically allocated misc devices with minor above 255
will fail to open with -ENXIO.

This was found by kernel test robot when testing a different change that
makes all dynamically allocated minors be above 255. This has, however,
been separately tested by creating 256 serio_raw devices with the help of
userio driver.

Ever since allowing misc devices with minors above 128, this has been
possible.

Fix it by registering all minor numbers from 0 to MINORMASK + 1 for
MISC_MAJOR.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503171507.6c8093d0-lkp@intel.com
Fixes: ab760791c0cf ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/char/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index f7dd455dd0dd3c7c9956e772b5ab8bd83a67a4a6..dda466f9181acf76564b5e41ed6e858928e56182 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -315,7 +315,7 @@ static int __init misc_init(void)
 		goto fail_remove;
 
 	err = -EIO;
-	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
+	if (__register_chrdev(MISC_MAJOR, 0, MINORMASK + 1, "misc", &misc_fops))
 		goto fail_printk;
 	return 0;
 

---
base-commit: 2dc25093218f5d42391549de6fe45e1aa9325676
change-id: 20250317-misc-chrdev-b26b572a47fc

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


