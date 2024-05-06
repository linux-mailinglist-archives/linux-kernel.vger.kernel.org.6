Return-Path: <linux-kernel+bounces-169518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C29D8BC9DF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F91C21A50
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9136C1422A6;
	Mon,  6 May 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="niS9UOjU"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C91411CE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985210; cv=none; b=F+MVNNH/wLXNrIR5Fuy/i+9/mZPI0M1XnhFGmgf9lnUlqfBFE9j5Z5MdOt8oog41rcr1lDaZ0V1bEuL+/J+HD4rViTGCraIKkFiwGteePNkfkcNf9WrxDq4dUM3kSwzTYM+Dj+FV+JKVAyHZ2J+ec6UJX0dEyB24IWPN3tlTFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985210; c=relaxed/simple;
	bh=rApUqYVsVt9Lmm4m+jmthQspAsl2swdyFeKQOkOm8b0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFdidOZugT8WRNKo0gC4KPnQVAcf0o24YLBf4ugguPWMpd3Af5ezzigrZsnbudLH+AhffdbNJhAWAXZwmF10PLPd0yCuUqVZymiQ4JHZY7gmdzjhUzLEfDEymNO2eQEWiaMSsocJQTTmnNYYNFI2sR2wdkGPcCMOMNrW1V1gF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=niS9UOjU; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714985206; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=p4+ojbN485lnDhEdHj7u8+ldhF5xWmY9Y6UtO0qnCFI=;
	b=niS9UOjU7LndqDhtzwDcEt+Nfw0URVg8yrCSFEALpmc3Vm5xcN/riz/NmlSyJqe7ND5+tiPqsKIzdFgV+vDpQ79KB5m6B03drAkW/amtl07eFjEmIzsvbwN3S0oWNkQzZDEC8NQG86j27UDgMD78jvNe1hRIBb1uP7LXmR7Wk3Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W5weiJg_1714985203;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5weiJg_1714985203)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 16:46:44 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] mm: move highest_order() and next_order() out of the THP config
Date: Mon,  6 May 2024 16:46:25 +0800
Message-Id: <d9c0ac9df6f6e6176b09fc1ae58146ec4f8d73f5.1714978902.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move highest_order() and next_order() out of the CONFIG_TRANSPARENT_HUGEPAGE
macro, which can be common functions to be used.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/huge_mm.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 017cee864080..e49b56c40a11 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -106,6 +106,17 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 
+static inline int highest_order(unsigned long orders)
+{
+	return fls_long(orders) - 1;
+}
+
+static inline int next_order(unsigned long *orders, int prev)
+{
+	*orders &= ~BIT(prev);
+	return highest_order(*orders);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 extern unsigned long transparent_hugepage_flags;
@@ -138,17 +149,6 @@ static inline bool hugepage_flags_enabled(void)
 	       huge_anon_orders_madvise;
 }
 
-static inline int highest_order(unsigned long orders)
-{
-	return fls_long(orders) - 1;
-}
-
-static inline int next_order(unsigned long *orders, int prev)
-{
-	*orders &= ~BIT(prev);
-	return highest_order(*orders);
-}
-
 /*
  * Do the below checks:
  *   - For file vma, check if the linear page offset of vma is
-- 
2.39.3


