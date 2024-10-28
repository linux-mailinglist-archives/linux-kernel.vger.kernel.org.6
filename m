Return-Path: <linux-kernel+bounces-385593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FA59B392B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE70D280FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8756C1DF966;
	Mon, 28 Oct 2024 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VBWZosyv"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97B1DDC36
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140174; cv=none; b=qzB5anfi3U/Z/m3cZpRuV+dhxBYqQ5851zTgl0oXSXO1QQSP7Fa+Z/+zJanhS5EBpokmZ7CkEzaFZZ0tbQXiRU35GX0MNN/LLGFdt8ObaVE8MllGsmm5DhEa02qVTuR3vdM6f33cCpbdsaFMAgSL6vYEzpU3FhBOuM4rdMjEFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140174; c=relaxed/simple;
	bh=xc/5rk7yA/8D72pwAEE2DYn4i4Tr4pZA01coa+mCMiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JVY445bwRJTw8efXP4xYyAGkmya4vbFlQvka3J0tBoP+xxt3B38gOOgKHPyyk3dS7XWMEkQSmjUFjUKuMzZmmeR6lvSK07Y1WCg6++a+zmKOKKLlfUI8/El1wJPQAxs3BAC2PhPxM43FfmeQa2Yq5osQLqIUq+Sg9khrMEgCXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VBWZosyv; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730140168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ydnssr3n8sPSW3dssobBGKzcYiq5vxNbU7RccfcxEns=;
	b=VBWZosyv1D9zdSYBIq/GDrG/p9LrQjXfyaOauVc60S3bgMXnbF1JLOwXcCJq1ED/KAcT0X
	0FLUkxdYU1pZl03Xtuy3aszxLgJIFSKmMVAU3TGvAU1nGt4T17utH60uAFIrvBgcBwjgH0
	CaXDYxNw7M9CI8FeML5yWtMLwwfDxzs=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org (open list:LIBRARY CODE),
	dri-devel@lists.freedesktop.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] lib/scatterlist: Use sg_phys() helper
Date: Tue, 29 Oct 2024 02:29:20 +0800
Message-Id: <20241028182920.1025819-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This shorten the length of code in horizential direction, therefore is
easier to read.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 lib/scatterlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 473b2646f71c..5bb6b8aff232 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -474,14 +474,14 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 		return -EOPNOTSUPP;
 
 	if (sgt_append->prv) {
-		unsigned long next_pfn = (page_to_phys(sg_page(sgt_append->prv)) +
-			sgt_append->prv->offset + sgt_append->prv->length) / PAGE_SIZE;
+		unsigned long next_pfn;
 
 		if (WARN_ON(offset))
 			return -EINVAL;
 
 		/* Merge contiguous pages into the last SG */
 		prv_len = sgt_append->prv->length;
+		next_pfn = (sg_phys(sgt_append->prv) + prv_len) / PAGE_SIZE;
 		if (page_to_pfn(pages[0]) == next_pfn) {
 			last_pg = pfn_to_page(next_pfn - 1);
 			while (n_pages && pages_are_mergeable(pages[0], last_pg)) {
-- 
2.34.1


