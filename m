Return-Path: <linux-kernel+bounces-372124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF09A44BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE4DB23200
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41BB203710;
	Fri, 18 Oct 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPP/10/0"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5C205122
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272659; cv=none; b=jgLyALLMTJG8XHtlUlTBUQrOKy4NWecf873ISRNBhk5pdNRPe2SXNCLrqTf81Td3dFi0+RgCfP5eNjqh+RKcTqdXxWtrGWVKFykA40EdQuFvo6a3Y8ZrFcbcHukT5fbPvfCjRoJFF8EPjme6penetem7B2ZjzNx3w3UREi9qr3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272659; c=relaxed/simple;
	bh=vwo5Vjz6fiE2bBnN6H3uBn6axl3BU1PmSdcjm6+/cIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAFFx7mHz1pCJ80T9H+dUDBY0hJmoq/53ITrqGSfRlNCLsTKrbFQS6c0Lnq+yT23AKVsWiefalwCRCG3irtRroNEO43ndrV0d3vbWdeBGSVgJYBJ/EBSUG2qVvfNTQVkRyckpRZ0NCli5b5qDxJzgyUPzQty0IMt9u6515FpUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPP/10/0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1549447a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272657; x=1729877457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYv3qxbJ8XzSYVM3O5y7o2xiEmCUj8b+8LHRXlL50QE=;
        b=gPP/10/0EIieVyt3uWCYCSk2KK7uc3covXIWsnNR0PTVitBfGgxLeX7NV0qRQOqnki
         Kc/Atjrl0ax8nmQhYJRqEfXk5SKUTHQCK4CZWoHYHNyJBEbwWFg9L+uR4BD57E1TaWHj
         rO702iOrqBB7YHmb2vUbXifFf7A9VgQVTLvG8wcjXcY6mY5jjGrqfA8jbG1bfuqxAoUl
         lmPCfOjpqTMTQy2SlChqZHtDb8aWfpin7qbCSCkWiLQ6S6Y8Sg+cRpBp/viVzhqwlIpq
         kaxeZGVUQNvSJlO+UOJX5kFS9CbaUxXZGFkEvSxMLjqbRI7U7FWymuZTIaN0hv2C553h
         w89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272657; x=1729877457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYv3qxbJ8XzSYVM3O5y7o2xiEmCUj8b+8LHRXlL50QE=;
        b=lUUn21w27rcSi9nFRj8rJs8pqbXSykVvbGjKWy61ZFm7h9CDi3gb/vCO56nb7sL5cE
         9GQZxPEVf8PbqppdKaORPOvemq+q1EqQ5CnxZ5ZAD+/8lUexAPEGjz6TJ7SVm2vK8ubt
         BIqlj4i4Apr49QqZEQN25slLx+Hb8PwaQ2gLhOwuRojlJwee4CQWIFuuotvJwpNc+Hij
         Q/B76F7fBZTSztl6MjlKNCtPgJmDu8PcubnXJIHQ+10/iEbrmSSKIUQCBJHmDzAmm45r
         W7tY/NUaMw9ZMwVGd1IFw0anbwWEB82+VvzyAaH37Bj2UhTmWgiBAN5I9xqPVxvQd+po
         PYnw==
X-Forwarded-Encrypted: i=1; AJvYcCW2CQuoO5IXhLYZkRMMS7zRR5VFNYssMQrbGczq8ZBAXcpSFghJZAoJbFcSuZEw/8Rh5BQdljqU+pA+J8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0G5Q9f439Ek0ONUhVKoJ8W1fUxIsrrWjdSEvVIM6PwlvAhsG
	TvFEtIH1i6cV9CVePk6BQbh8oFJQ9r0q8prRo2LEYPm665MJJ00M
X-Google-Smtp-Source: AGHT+IGzdUgXGWS3Rnfne00N0lzoqmJmv13oE/GEcsOOigglv7dM20Xc4zaopt4Axws81Q8JXv67zw==
X-Received: by 2002:a05:6a21:a4c1:b0:1d8:f1f4:f4ee with SMTP id adf61e73a8af0-1d92c4baaaemr4986521637.8.1729272656623;
        Fri, 18 Oct 2024 10:30:56 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:30:55 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 07/12] book3s64/hash: Make kernel_map_linear_page() generic
Date: Fri, 18 Oct 2024 22:59:48 +0530
Message-ID: <5b67df7b29e68d7c78d6fc1f42d41137299bac6b.1729271995.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729271995.git.ritesh.list@gmail.com>
References: <cover.1729271995.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently kernel_map_linear_page() function assumes to be working on
linear_map_hash_slots array. But since in later patches we need a
separate linear map array for kfence, hence make
kernel_map_linear_page() take a linear map array and lock in it's
function argument.

This is needed to separate out kfence from debug_pagealloc
infrastructure.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 47 ++++++++++++++-------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index ab50bb33a390..11975a2f7403 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -272,11 +272,8 @@ void hash__tlbiel_all(unsigned int action)
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-static u8 *linear_map_hash_slots;
-static unsigned long linear_map_hash_count;
-static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
-
-static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
+static void kernel_map_linear_page(unsigned long vaddr, unsigned long idx,
+				   u8 *slots, raw_spinlock_t *lock)
 {
 	unsigned long hash;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
@@ -290,7 +287,7 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 	if (!vsid)
 		return;
 
-	if (linear_map_hash_slots[lmi] & 0x80)
+	if (slots[idx] & 0x80)
 		return;
 
 	ret = hpte_insert_repeating(hash, vpn, __pa(vaddr), mode,
@@ -298,36 +295,40 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 				    mmu_linear_psize, mmu_kernel_ssize);
 
 	BUG_ON (ret < 0);
-	raw_spin_lock(&linear_map_hash_lock);
-	BUG_ON(linear_map_hash_slots[lmi] & 0x80);
-	linear_map_hash_slots[lmi] = ret | 0x80;
-	raw_spin_unlock(&linear_map_hash_lock);
+	raw_spin_lock(lock);
+	BUG_ON(slots[idx] & 0x80);
+	slots[idx] = ret | 0x80;
+	raw_spin_unlock(lock);
 }
 
-static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
+static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long idx,
+				     u8 *slots, raw_spinlock_t *lock)
 {
-	unsigned long hash, hidx, slot;
+	unsigned long hash, hslot, slot;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
 	unsigned long vpn = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
 
 	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
-	raw_spin_lock(&linear_map_hash_lock);
-	if (!(linear_map_hash_slots[lmi] & 0x80)) {
-		raw_spin_unlock(&linear_map_hash_lock);
+	raw_spin_lock(lock);
+	if (!(slots[idx] & 0x80)) {
+		raw_spin_unlock(lock);
 		return;
 	}
-	hidx = linear_map_hash_slots[lmi] & 0x7f;
-	linear_map_hash_slots[lmi] = 0;
-	raw_spin_unlock(&linear_map_hash_lock);
-	if (hidx & _PTEIDX_SECONDARY)
+	hslot = slots[idx] & 0x7f;
+	slots[idx] = 0;
+	raw_spin_unlock(lock);
+	if (hslot & _PTEIDX_SECONDARY)
 		hash = ~hash;
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-	slot += hidx & _PTEIDX_GROUP_IX;
+	slot += hslot & _PTEIDX_GROUP_IX;
 	mmu_hash_ops.hpte_invalidate(slot, vpn, mmu_linear_psize,
 				     mmu_linear_psize,
 				     mmu_kernel_ssize, 0);
 }
 
+static u8 *linear_map_hash_slots;
+static unsigned long linear_map_hash_count;
+static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
 static inline void hash_debug_pagealloc_alloc_slots(void)
 {
 	if (!debug_pagealloc_enabled())
@@ -362,9 +363,11 @@ static int hash_debug_pagealloc_map_pages(struct page *page, int numpages,
 		if (lmi >= linear_map_hash_count)
 			continue;
 		if (enable)
-			kernel_map_linear_page(vaddr, lmi);
+			kernel_map_linear_page(vaddr, lmi,
+				linear_map_hash_slots, &linear_map_hash_lock);
 		else
-			kernel_unmap_linear_page(vaddr, lmi);
+			kernel_unmap_linear_page(vaddr, lmi,
+				linear_map_hash_slots, &linear_map_hash_lock);
 	}
 	local_irq_restore(flags);
 	return 0;
-- 
2.46.0


