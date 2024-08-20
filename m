Return-Path: <linux-kernel+bounces-293136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A134E957B33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF81A1C22E86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4740E1BC4E;
	Tue, 20 Aug 2024 01:52:53 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378417740
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118772; cv=none; b=pJ/ZQB2IY0PW1GRqIa5eBGcmV6iBBDN2THIplGf2oC3VKbhcQ/mAYelWbHx35Owv1EKdS9p+P0dRdtQOQUN1pigRTwKgp+Rm2cevBOrWxVzU/SuFwTAlC85FnVYfJVqj2RW5ZofNi6nrwx2hTDvE0I6mfPYuZXI+2TiMHIHO0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118772; c=relaxed/simple;
	bh=N63UMnlnjky1J5PrRUMacQHV9Oy5I/IgyUiV/whwCJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qOMD45dP8Uf983nU8qBLIbJIzZDvFDSVDhrDewNoW/pPWgRhc3KB/YyKD7JD45p217xCYt/bkyzz/JLmsIqLi0/HVvR9Ic7ZTURGn90Bn3T104ISkASZSXeweU2Zt6wJciyzvrdYgXL9jaHbT7323Nsl6xS8zudnEvWSCxyGhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 47K1pcAO049571;
	Tue, 20 Aug 2024 09:51:38 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id EA668200474C;
	Tue, 20 Aug 2024 09:56:48 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 20 Aug 2024 09:51:38 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <jiaoxupo@h3c.com>,
        <shaohaojize@126.com>, <zhang.chuna@h3c.com>
Subject: [PATCH] use might_sleep check if kmap_high is called from atomic context
Date: Tue, 20 Aug 2024 09:53:11 +0800
Message-ID: <1724118791-51554-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 47K1pcAO049571

kmap_high is defined as EXPORT_SYMBOL, and cannot be called from atomic
context. Add might_sleep check is necessary.
Signed-off-by: zhangchun <zhang.chuna@h3c.com>
---
 mm/highmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/highmem.c b/mm/highmem.c
index 07f2c67..5cfb5a9 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -319,6 +319,11 @@ void *kmap_high(struct page *page)
 	unsigned long vaddr;
 
 	/*
+	 * Use might_sleep to check if kmap_high is called
+	 * from atomic context.
+	 */
+	might_sleep();
+	/*
 	 * For highmem pages, we can't trust "virtual" until
 	 * after we have the lock.
 	 */
-- 
1.8.3.1


