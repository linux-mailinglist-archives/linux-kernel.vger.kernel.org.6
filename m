Return-Path: <linux-kernel+bounces-277467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CFC94A1C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D0DB243D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911731C4610;
	Wed,  7 Aug 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uhltO+8+"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFE1C9DFB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015901; cv=none; b=t/ZNLp/hk5jdsvx8VBv51ueibYE1tYFS7rn87rsc1B2oZJstO2dAA+BP792sHmBfM9196q4yG3rAwd1VQoXXMdUvkhBkbHVEzGvLFCH4TjsWuzU0N+M2aNzMM2nXKgbJidQn5pp0eY+As93QK72v8q15HDa5RqGerhlNPGt7WP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015901; c=relaxed/simple;
	bh=dSE5A1i/0Mslp7rR8GV63PP8IIVhz1+IlrL/SE1zme0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukbyjQAaCO9vp1vxrbkTpdfMSGzrOGb75MgIOfqoy7jj3zG3xLhSnhVpmtlOWXftlvrMEs79eGDoWKmsW/B5aPsJGRtOH2OgeU8poChUixthMJ7BMyU5m+EjdJqMEMsVYh8iKguKQOuvDQ7IwGHThMVhpV4rqKHAcJHd7e/u1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uhltO+8+; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723015892; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2cIcVzSoLVgPRYlybE3t8RKibMfrcxZj8JgqApi1OSo=;
	b=uhltO+8+NVKmhasLJD9G+lf0M8NGTlTNfyyRqb5yiJAwaPGAIhzV1PkDzsHyF0tR5O2uvxsc4sYSgXTo6mIuXunS/7NHbcWKeLR0pR7rkrew9HdLR5v4ryG5wGch6Qt7T9zkwmez1OU47BsmTU44fI2T0jxIjBK071+q3ZWfC2w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0WCI1Szl_1723015889;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCI1Szl_1723015889)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:31:30 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] mm: shmem: extend shmem_partial_swap_usage() to support large folio swap
Date: Wed,  7 Aug 2024 15:31:08 +0800
Message-Id: <2e0b4bc7877784348409900f81cb4b8bdafd7b57.1723012159.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support shmem large folio swapout in the following patches, using
xa_get_order() to get the order of the swap entry to calculate the swap
usage of shmem.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 22cdc10f27ea..02fb188d627f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -890,7 +890,7 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 		if (xas_retry(&xas, page))
 			continue;
 		if (xa_is_value(page))
-			swapped++;
+			swapped += 1 << xa_get_order(xas.xa, xas.xa_index);
 		if (xas.xa_index == max)
 			break;
 		if (need_resched()) {
-- 
2.39.3


