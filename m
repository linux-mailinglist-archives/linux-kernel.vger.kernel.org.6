Return-Path: <linux-kernel+bounces-245503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D86392B382
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541981C2178F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08BA154BE0;
	Tue,  9 Jul 2024 09:17:34 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB115444F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516654; cv=none; b=F7caG1YGmCrXitd2BuOzhFyF9toMmrWd+aaDPC/3RNPsGGgsDUWSFtRvRNmBDwWhJAeAQR6mg1iVHBQKDb5I6k+lvypETfqyQr9A7skrwQHRekb1DQnrjktOqdx7WFMCAda0DUvMEQ2tx7/vbnlZ5k1Ah5TTPuXhiwAeywt9Cnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516654; c=relaxed/simple;
	bh=4heESET2KVeH0IIj6LOX+jW+Y9bGLGe40FXDtpMD/lU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PELvikdylPhZbW1GF1x9XpD68klJkNHUepWXPErByOfLwxZRc2wD2WlPbxKh23INP6SCIDPCKsnLmSFmjIh/LXQQy62N1IPNRv4d/aYaWTYKNw32nYwED6cqVuCcR8dfP3rGUou7VbQed4xJpshYq1GSIVxfe+EXZKasWJg+iDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4699GLTr005458;
	Tue, 9 Jul 2024 17:16:21 +0800 (GMT-8)
	(envelope-from zhang.chunA@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
	by mail.maildlp.com (Postfix) with ESMTP id 64CB22302CD1;
	Tue,  9 Jul 2024 17:20:36 +0800 (CST)
Received: from localhost.localdomain.com (10.99.206.13) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Tue, 9 Jul 2024 17:16:23 +0800
From: zhangchun <zhang.chuna@h3c.com>
To: <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <jiaoxupo@h3c.com>,
        <zhang.zhengming@h3c.com>, <zhang.zhansheng@h3c.com>,
        <shaohaojize@126.com>, zhangchun <zhang.chuna@h3c.com>
Subject: [PATCH] =?UTF-8?q?mm:=20Give=20kmap=5Flock=20before=20call=20flus?= =?UTF-8?q?h=5Ftlb=5Fkernel=5Frang=EF=BC=8Cavoid=20kmap=5Fhigh=20deadlock.?=
Date: Tue, 9 Jul 2024 17:17:38 +0800
Message-ID: <1720516658-50434-1-git-send-email-zhang.chuna@h3c.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 4699GLTr005458

Use kmap_high and kmap_XXX or kumap_xxx among differt cores at the same
time may cause deadlock. The issue is like this：

 CPU 0:                                                 CPU 1:
 kmap_high(){                                           kmap_xxx() {
               ...                                        irq_disable();
        spin_lock(&kmap_lock)
               ...
        map_new_virtual                                     ...
           flush_all_zero_pkmaps
              flush_tlb_kernel_range         /* CPU0 holds the kmap_lock */
                      smp_call_function_many         spin_lock(&kmap_lock)
                      ...                                   ....
        spin_unlock(&kmap_lock)
               ...

CPU 0 holds the kmap_lock, waiting for CPU 1 respond to IPI. But CPU 1
has disabled irqs, waiting for kmap_lock, cannot answer the IPI. Fix
this by releasing  kmap_lock before call flush_tlb_kernel_range,
avoid kmap_lock deadlock.

Fixes: 3297e760776a ("highmem: atomic highmem kmap page pinning")
Signed-off-by: zhangchun <zhang.chuna@h3c.com>
Co-developed-by: zhangzhansheng <zhang.zhansheng@h3c.com>
Signed-off-by: zhangzhansheng <zhang.zhansheng@h3c.com>
Reviewed-by: zhangzhengming <zhang.zhengming@h3c.com>
---
 mm/highmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index bd48ba4..841b370 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -220,8 +220,11 @@ static void flush_all_zero_pkmaps(void)
 		set_page_address(page, NULL);
 		need_flush = 1;
 	}
-	if (need_flush)
+	if (need_flush) {
+		spin_unlock(&kmap_lock);
 		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
+		spin_lock(&kmap_lock);
+	}
 }
 
 void __kmap_flush_unused(void)
-- 
1.8.3.1


