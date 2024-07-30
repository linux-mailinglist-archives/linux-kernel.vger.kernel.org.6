Return-Path: <linux-kernel+bounces-267119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B85940CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306A0285FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFE193091;
	Tue, 30 Jul 2024 09:03:15 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842BF18FDB5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330194; cv=none; b=WWJNMwOlb7uDzNxfte6rN03jqjnELbmCbQOwM19zJROo+kKYNrR6RuHkCXeGCNC39+rthnfDaQOtWuqS28dXr/Sa2Jy1/0t5Jt0DWbSh+ZlWQYHf3tOVTJdSp8zCfn9+asB8MvLAl70QOtTtzdxg3HIa000MznacR6JEUie0d44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330194; c=relaxed/simple;
	bh=6Of9gFpnfrWrMGpVb8mH2562Q2P0lZ/Skp4YOhixeBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHVJoPBxbxoADOgqkwko1aDt4R9BQbV4dByaTy4jgxDLCvgG9mnurGWXKt6X8oBC7opK7arfvB+dXWuvv8K1pHRJKRmERMBHNV3qerXc50cll1eyRA7ka6Fm5mKFaZMWekJmYSKXwAd4+rWHHfeTgSu0v+BlYj11rPMo07eOc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366a8ac3d702-95f0d;
	Tue, 30 Jul 2024 17:03:02 +0800 (CST)
X-RM-TRANSID:2ee366a8ac3d702-95f0d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366a8ac46d56-da6ad;
	Tue, 30 Jul 2024 17:03:02 +0800 (CST)
X-RM-TRANSID:2ee366a8ac46d56-da6ad
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH v2] char: misc: add missing #ifdef CONFIG_PROC_FS
Date: Tue, 30 Jul 2024 16:31:58 +0800
Message-Id: <20240730083158.3583-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <2024073042-observer-overflow-cd04@gregkh>
References: <2024073042-observer-overflow-cd04@gregkh>
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

>Again, why is a #ifdef ok in this .c file?  What changed to suddenly
>require this?
There is another #ifdef in this file, in there "misc_seq_ops" is defined.
If CONFIG_PROC_FS is not defined, proc_create_seq is using an 
undefined variable "misc_seq_ops", this may cause compile error.

Signed-off-by: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
---
v1->v2: not check proc_creat_seq returns

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




