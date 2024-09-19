Return-Path: <linux-kernel+bounces-333068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C197C309
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373B01F22A53
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A274433CB;
	Thu, 19 Sep 2024 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC84Ppyx"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4541746
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714648; cv=none; b=gX/HGIOW9bxvlow49oHUKbe1TQQCVeUeSY1m7ZDxn+e73GR8224d2Fpv8jRvsRi1Jf5rcRnIWR/20jL+y6FOMr+b1v3plUwaWwKhalUy1OIIjrdZ+8YwWFsSkV1s5tSEJiMCuH33Nqp6udvnZqIjGLWgjKZAiH/0yNw15KZsZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714648; c=relaxed/simple;
	bh=7O0Fesye+x8XRmHWMdz8FpcQFaEIlQURErbev6IpoRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW5Qvx4/t0zaZ0WBaSHRAJc17XswYdW4FTv7PyfvIyEUdyrsPL6q84yuKRkKbEvdNl9vCAElh9Qq4h5i15pg51N+nbscFoP3ZeushkkypuGabKlt23wcAW0Sj34cqFR3EnnNpyYcpvCwFlHeKNgdm/NshkCGrVLVTiwmTI3vsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC84Ppyx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-206bd1c6ccdso4157385ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714646; x=1727319446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG0rlJ7RpNnGy840avhtCY+OIP6FbV4qxEoUkbOoVC0=;
        b=AC84Ppyxhw9If8DjXcoKQQosyP54fVWwcqB7lDFxdbLw3aL7GLa/tUZvunR43LsllI
         a9WkX7/OefDA9aRWtVLdENz2BHPcu9KwxrJl33hUOlxqn1+T9XtII82MwAs17lqVxgyL
         fgvkB5QxwVo0fjyyeAkZjM3DyJx/YVjbmubbnaba+AEx+Uq4uuE41gOOgjcIXfOs3vit
         7ji2xUxcLIvKMISVINTVJjf5paiiHYTkhPJs0qaBp2VTKat1gRRszPYn8w6qcDrzfxUs
         kNz8cSy2vSYK1jjF6A5CjjnngUFpCNRGNcC1nwBkdzGxh5LppgO4/BGfmXkifIgLfK4e
         M6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714646; x=1727319446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG0rlJ7RpNnGy840avhtCY+OIP6FbV4qxEoUkbOoVC0=;
        b=khEv/dYE2DdzyCZbkdt8hXH0F0HekWD30OSatnEE1uLydjRsJDl8PdS/h4b2s58ycX
         Fpusi/x7OIrfpd1DrxDERUWsR9N+LXVU4CpQq42oQ5pb/NARrsrakD42LKRBuZosaYfW
         ghu54FxuZwjnaJBPzfcZybArMerPL/LW8fbZhWjE2ji2hOZ39XBXu8jNnnUPhJvkriTx
         TcF56SzjCQkw19K+loqsLfgGtwY+3PRk3//ec3c75TiwUXJWroDGnXSrEj9By5VZ29tC
         yLqGFwmQFxXh54sWep66pHbxvbx8D023Ib13iBo0pTqf5CecswiLQ2a7vbLOjbVIJaZw
         oHkg==
X-Forwarded-Encrypted: i=1; AJvYcCU8r5EnbDyXwFLs4f/L1bsG9ofv1e4uYdrVJ/XLdRkjYSdN0RxuKWUnCtX1EpCJ3++Rn4Z8rqOi0gqn288=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQUWK2LeYtxLwEolsnAi+wdGEfbARMi5BXVuQQVkiguC8Zi23
	FlFKoiHAKbAxDkLK/cfVHt9Hl60BDPCqfS10Ep9m5ilq3kYBkjI/
X-Google-Smtp-Source: AGHT+IE34eW0PHWVkirCwr75sAQsAEQKWo1G+ukba10mNkf/9dp+AGD30+GUy1tuone82B+yBz345Q==
X-Received: by 2002:a17:903:32c9:b0:206:ae39:9f4 with SMTP id d9443c01a7336-20781d5f6fcmr301143135ad.20.1726714646433;
        Wed, 18 Sep 2024 19:57:26 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:57:25 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 13/13] book3s64/hash: Early detect debug_pagealloc size requirement
Date: Thu, 19 Sep 2024 08:26:11 +0530
Message-ID: <616bf94910b0c77323ea9ccb86571f78ebfd421b.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726571179.git.ritesh.list@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hash_supports_debug_pagealloc() helper to detect whether
debug_pagealloc can be supported on hash or not. This checks for both,
whether debug_pagealloc config is enabled and the linear map should
fit within rma_size/4 region size.

This can then be used early during htab_init_page_sizes() to decide
linear map pagesize if hash supports either debug_pagealloc or
kfence.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index b6da25719e37..3ffc98b3deb1 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -329,25 +329,26 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long idx,
 }
 #endif

+static inline bool hash_supports_debug_pagealloc(void)
+{
+	unsigned long max_hash_count = ppc64_rma_size / 4;
+	unsigned long linear_map_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
+
+	if (!debug_pagealloc_enabled() || linear_map_count > max_hash_count)
+		return false;
+	return true;
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static u8 *linear_map_hash_slots;
 static unsigned long linear_map_hash_count;
 static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
 static void hash_debug_pagealloc_alloc_slots(void)
 {
-	unsigned long max_hash_count = ppc64_rma_size / 4;
-
-	if (!debug_pagealloc_enabled())
-		return;
-	linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
-	if (unlikely(linear_map_hash_count > max_hash_count)) {
-		pr_info("linear map size (%llu) greater than 4 times RMA region (%llu). Disabling debug_pagealloc\n",
-			((u64)linear_map_hash_count << PAGE_SHIFT),
-			ppc64_rma_size);
-		linear_map_hash_count = 0;
+	if (!hash_supports_debug_pagealloc())
 		return;
-	}

+	linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
 	linear_map_hash_slots = memblock_alloc_try_nid(
 			linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
 			ppc64_rma_size,	NUMA_NO_NODE);
@@ -1076,7 +1077,7 @@ static void __init htab_init_page_sizes(void)
 	bool aligned = true;
 	init_hpte_page_sizes();

-	if (!debug_pagealloc_enabled() && !kfence_early_init_enabled()) {
+	if (!hash_supports_debug_pagealloc() && !kfence_early_init_enabled()) {
 		/*
 		 * Pick a size for the linear mapping. Currently, we only
 		 * support 16M, 1M and 4K which is the default
--
2.46.0


