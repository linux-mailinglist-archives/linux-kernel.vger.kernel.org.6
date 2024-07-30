Return-Path: <linux-kernel+bounces-267051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A4940BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DBE285142
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE8F18FDD2;
	Tue, 30 Jul 2024 08:36:44 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E75339AB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328603; cv=none; b=aiHcZ7ceSpdmL1Lv1FXT71FOL89EUR6REjRVHnpA83ibX2KgdokrfqX6rNddTtVaIZy2pxh6ZyWYurZ3AdVsPdnD7gp0AQkDianMGHCu+CjTQaOW7oxKt1bhRFM3oyia4DIIoAO0vzD9eDAVJkxPolhMOyv0bK4FDUApFUyz3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328603; c=relaxed/simple;
	bh=Gtvs2j6gsG8Dds+NensU4nD2u3p10WBGAJH3UzBdy2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EBRSQOwcShfTTY5YMS/0bgQXGxh/qrmYXGudR3fwpVyiUxi57/tq9AsyF6Um2/UoPpPPdM80dJ1obAJ3twJ1hKaGPONCG5Lz3XYAHhE3GONhK4ciRbAO1msUi1OWVqm4vnHuKhzS2pv1JYC/EvvUAK45TRr3od1WhTjMCE+Mm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866a8a60c9e6-01a12;
	Tue, 30 Jul 2024 16:36:28 +0800 (CST)
X-RM-TRANSID:2ee866a8a60c9e6-01a12
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166a8a60bd36-d94c1;
	Tue, 30 Jul 2024 16:36:28 +0800 (CST)
X-RM-TRANSID:2ee166a8a60bd36-d94c1
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH v2] char: misc: add missing #ifdef CONFIG_PROC_FS
Date: Tue, 30 Jul 2024 16:03:12 +0800
Message-Id: <20240730080312.3430-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <bbb597df-5bd8-487a-8b5c-9118814632e8@app.fastmail.com>
References: <bbb597df-5bd8-487a-8b5c-9118814632e8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>

Since misc_seq_ops is defined under CONFIG_PROC_FS in this file,
it also need under CONFIG_PROC_FS when use. 

v1->v2: not check proc_creat_seq returns

Signed-off-by: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/char/misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..e1e8cd09c34a 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -286,9 +286,11 @@ EXPORT_SYMBOL(misc_deregister);
 static int __init misc_init(void)
 {
 	int err;
+#ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *ret;
 
 	ret = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
+#endif
 	err = class_register(&misc_class);
 	if (err)
 		goto fail_remove;
@@ -302,8 +304,10 @@ static int __init misc_init(void)
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




