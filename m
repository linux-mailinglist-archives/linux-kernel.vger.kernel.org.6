Return-Path: <linux-kernel+bounces-268070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3B942004
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABB6285C38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3FE18CBE9;
	Tue, 30 Jul 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB49LOJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A018C93B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365464; cv=none; b=OW0Zbdo/dBiGphJ5NKRp9GzLeprNI5lfrVIiKlXqcLSiiej/T2VU51Z8CfU0jOlI49hK6fCHr/GmqLQnM0eucY0GuXtsh9da4FRyOo5nADNEec0vDoYtN+CfwvlsGwNCNGQh+pvR0OdaLTHJPgt4GNNezX1A3FmH19/JzDN20vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365464; c=relaxed/simple;
	bh=BHHTORiqnQEnevgg1pb2AO84I1O2tlm7LAzk7DzpiX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdPk69qnpGfw6xpJwkZ3NIeXd61Bm8Wy+sH7P1KkWftlQBLNF/p8MjTalbcwHEQKEUmzKxcUu2tTNxiQQSjw9EmPIHzSJUScqdHlzrvzds73TXqYs+NTCvFXpEc8QXduCNgzfaf6X8xznjttd7Zahdc9Wj4AmUakCohRJyuJxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB49LOJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8A7C4AF15;
	Tue, 30 Jul 2024 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365464;
	bh=BHHTORiqnQEnevgg1pb2AO84I1O2tlm7LAzk7DzpiX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MB49LOJnSd0dC4i1DwOZpB6+J6dWDCYVb4aSAN6rq0/ja5W5I7SYG+wE1+aCIUFzd
	 qLTmTZJeY7DM4oAUSLBwxmJlYBSkMKJ4Lgy38nAr8xtUz3tDqG7PFRd9EkHPTSsXgp
	 uiNANAfLVkyCrv++Py4nHn2Qc70r9BsXtBvAYYGIYrcGRd9Gbx5rbHEMA/NjfAJIHg
	 oiAan8YjdJEtq65lpESfuPIXm/LAHoAVVCpWsYBypKKRkqiKCSs3nOxmd7zcttkvdy
	 WjHTBWA9p73oJdDGNxRP4CgozeSPolMLJrOFaVt0O5mDaoLu5lsAtRrn0K9LPNHYm8
	 FkwzOtJa9/qqg==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	vbabka@suse.cz
Cc: mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 4/4] mm: kvrealloc: properly document __GFP_ZERO behavior
Date: Tue, 30 Jul 2024 20:49:44 +0200
Message-ID: <20240730185049.6244-5-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730185049.6244-1-dakr@kernel.org>
References: <20240730185049.6244-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properly document that if __GFP_ZERO logic is requested, callers must
ensure that, starting with the initial memory allocation, every
subsequent call to this API for the same memory allocation is flagged
with __GFP_ZERO. Otherwise, it is possible that __GFP_ZERO is not fully
honored by this API.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 mm/util.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index bfb2d69b6434..f899b0f984a0 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -726,12 +726,17 @@ EXPORT_SYMBOL(kvfree_sensitive);
  * @size: the size to reallocate
  * @flags: the flags for the page level allocator
  *
- * The contents of the object pointed to are preserved up to the lesser of the
- * new and old size (__GFP_ZERO flag is effectively ignored).
- *
  * If @p is %NULL, kvrealloc() behaves exactly like kvmalloc(). If @size is 0
  * and @p is not a %NULL pointer, the object pointed to is freed.
  *
+ * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
+ * initial memory allocation, every subsequent call to this API for the same
+ * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
+ * __GFP_ZERO is not fully honored by this API.
+ *
+ * In any case, the contents of the object pointed to are preserved up to the
+ * lesser of the new and old sizes.
+ *
  * This function must not be called concurrently with itself or kvfree() for the
  * same memory allocation.
  *
-- 
2.45.2


