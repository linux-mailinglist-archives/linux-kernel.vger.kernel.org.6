Return-Path: <linux-kernel+bounces-265409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F9A93F0B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B731F231F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C941420D5;
	Mon, 29 Jul 2024 09:12:57 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A613D63D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244377; cv=none; b=SQYnXTOSesn6X6lyUMV1tATq/Us7twq9gAjZtVG8IC23BDjAsuy0c+pqCBmTiWZGX/NI3wSmKCuuaMl6RYUSUAajP6UH0dyAUfB0ydy2q9eUvlejSmwFsYkskbzyCmFUstltfHtixefR6MCakHeEF3zAiS9KcVO/hKB+NT/Dgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244377; c=relaxed/simple;
	bh=x5i/OhGn/UUNPKSCcSmMPZnHMORxPTdVIGi7FRie25U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utZDPXTyWsB3TNygNvYnO+WIgpwcPIypBb0KMrVOw6lo1Q3MkDL7RJVcBlwRgZRC1fESkhamO4rX3FYM5pxO2/TYe/hyasaJ9O0+fr8zfEW8/xg/t1M91M/38y1gNzNlsTsTtfLY7WAbaXT3+ekqDGVjC11Nutv215WCubZKvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166a75d05509-8de03;
	Mon, 29 Jul 2024 17:12:38 +0800 (CST)
X-RM-TRANSID:2ee166a75d05509-8de03
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66a75d06807-a4faf;
	Mon, 29 Jul 2024 17:12:38 +0800 (CST)
X-RM-TRANSID:2eea66a75d06807-a4faf
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] char: misc: add missing #ifdef CONFIG_PROC_FS and error checking
Date: Mon, 29 Jul 2024 15:35:11 +0800
Message-Id: <20240729073511.61935-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>

Add "#ifdef CONFIG_PROC_FS" to control misc proc create 
and give some error checking.

Signed-off-by: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/char/misc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..0370d53f368a 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -286,9 +286,15 @@ EXPORT_SYMBOL(misc_deregister);
 static int __init misc_init(void)
 {
 	int err;
+#ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *ret;
 
 	ret = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
+	if (!ret) {
+		pr_err("Cannot create /proc/misc\n");
+		return -ENOMEM;
+	}
+#endif
 	err = class_register(&misc_class);
 	if (err)
 		goto fail_remove;
@@ -302,8 +308,10 @@ static int __init misc_init(void)
 	pr_err("unable to get major %d for misc devices\n", MISC_MAJOR);
 	class_unregister(&misc_class);
 fail_remove:
+#ifdef CONFIG_PROC_FS
 	if (ret)
 		remove_proc_entry("misc", NULL);
+#endif
 	return err;
 }
 subsys_initcall(misc_init);
-- 
2.33.0




