Return-Path: <linux-kernel+bounces-358741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2406A998306
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C6C282219
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B81BFE17;
	Thu, 10 Oct 2024 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xy+jETAc"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6C1BF810
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554310; cv=none; b=FrM1Y/Xx6WPKn40QhbkVYeaypXA82EwSOyS8F54DLKAXLybv8FxrMV5UqOUS1iMKhoyZWynyQgQEoKAOnYDBO7yIfXYmlQH3FSalV7s/t8Nu6AMh/TX6n/0ltzsKq8/nML6aVMidXKDpP7cNYw1K7jxE0TOh05fcQeHAG1ondwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554310; c=relaxed/simple;
	bh=aW+mk2ePZEaHmiZzVO05BzffwyUJkOfhEC+jcUFwaoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWoqYRtR6uFRDlk2dlkuxxY9q/Vp6z6SVBy5Bu3uz9J/v+Ssc0E6YAJiqiLVyh5j5kM+Mb0HBPMWGTQiHuXg0a7HsL9UiXbDSpNa1i/jLVqauH1mhId9Lp5d3BsfG/cHN6FanfdcjS1shlBMu1PRUk28svCvZPaOmrKZrS5f7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xy+jETAc; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728554300; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GjeDj7oC1iiZ/gkwEo4XJZE2Kubqr3JwCuLq6Y0HOAU=;
	b=Xy+jETAcI31K/++s8bwE1Q96Nr06WGfscMPMiMRzKj5dO9zg2qeAWkOqhF2frMQYp1zojA9Pavh/WBGSZ+jrDwA0siqKNCxghp5D0iFByplhyIK3J3j8Cl9Mh0dSdFKEHOnft+Ng6fEHgYsOm/sQlLr3JC4gcSq416/OjWHk1kc=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGm1Wg-_1728554298 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:58:19 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/4] mm: factor out the order calculation into a new helper
Date: Thu, 10 Oct 2024 17:58:11 +0800
Message-Id: <382e820c4805dcac80723d8f1707088dbcea2e85.1728548374.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the order calculation into a new helper, which can be reused
by shmem in the following patch.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/pagemap.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bcf0865a38ae..d796c8a33647 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -727,6 +727,16 @@ typedef unsigned int __bitwise fgf_t;
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
 
+static inline unsigned int filemap_get_order(size_t size)
+{
+	unsigned int shift = ilog2(size);
+
+	if (shift <= PAGE_SHIFT)
+		return 0;
+
+	return shift - PAGE_SHIFT;
+}
+
 /**
  * fgf_set_order - Encode a length in the fgf_t flags.
  * @size: The suggested size of the folio to create.
@@ -740,11 +750,11 @@ typedef unsigned int __bitwise fgf_t;
  */
 static inline fgf_t fgf_set_order(size_t size)
 {
-	unsigned int shift = ilog2(size);
+	unsigned int order = filemap_get_order(size);
 
-	if (shift <= PAGE_SHIFT)
+	if (!order)
 		return 0;
-	return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
+	return (__force fgf_t)(order << 26);
 }
 
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
-- 
2.39.3


