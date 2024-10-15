Return-Path: <linux-kernel+bounces-364967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EEF99DBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5F4287DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5196189B8A;
	Tue, 15 Oct 2024 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEESqLlX"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E797170A30
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956068; cv=none; b=nHXtNZwErQiEjsHSoAuIwn/9I3KBuRJcKGAGG7MoGp0gn/fxq6vXtaKFDTnwDAetKS+KIa0QA2nLy50VmQlS0jzpkXira8Tv1i9MIqJZnmYHO4aO7xQKZJAIniuVcPTp2CvxqXYr2Q82BIoGGdV2JR52qtwNljXzRaPIBn6RX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956068; c=relaxed/simple;
	bh=R968dba8OE7cCpOttgpeILQbdzMZ+6PWqhvC1JS2Eaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pie0OUOZSYCPPGdXhWxxZ31xOi7/9ohVwNrMvfGKh+ZrxjWzBQIKRdm9Zbp8/0Eo3BqYcfHUcIxV57JBslhKY2NXeknWVi/0Pup6dZ8t0Lhw2vRmyf5buj1D3YMsO6RGv6TpWnjgW4eNFJF/3B8zA0NNQoQYPpFV6ddL31c5mJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEESqLlX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea7d509e61so690165a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956066; x=1729560866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ww6ZbzhcNbPuRWG0GzwKnAEreEL780mKVa0cmRg0+f0=;
        b=YEESqLlXYbtbq/nueHrwq8DF9vCW4juriEETVQBrOxArQWrUAagIUaUzuAi4S/ly/Z
         Rlt2OvLGBmWhKBcnbESGKF+jyrTmHkj5ErZ/nQ8VbioEYTQl65tqEFXgOEeGUsaR93Ht
         LxrW+KlQbpIIu2CO+BQKfvtL793mKeNzAN7me9rQoalUx3oqlwHGIWjhGyPlmx4qxLYv
         2GOZBzSjnQf8lyu/EeLFdUWPKWeL43XzFnU7lKO0X0qA18lJj4DVGd50KsBR1HiVleZg
         FUlc8iy3EJ1v2LohoATACP7YaBpt0Azx4euV6Jj3IhWsjlHCw0vghaI+4r+l1NUhinH0
         Y2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956066; x=1729560866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ww6ZbzhcNbPuRWG0GzwKnAEreEL780mKVa0cmRg0+f0=;
        b=eRUZIonc0IntkWL9bvGyX1/fHKaLCEVz/8V7b7DegTVurFOdwvSU26AZHYebn2zgkL
         I/SlIA0ogwbpgHCYRpDoTz7I2/aarDnoRakA0zUTDPGi3Omud5AQYEuxrrlrhb5Xg+xB
         degfg/aIWyzRpxCw+5wG+a0kJysKtOkrW+8vSJIOAwl3TlI644FFCO4ml3kIMLgQt92d
         m4946wWGEzw7CexAb6tH59t+B2pkdMTPnJ9l/5lqQNOehcmTLl2J5lP4a3ExkrWv2Xgj
         p5TWU6QhWzW2bUOTUI8RPvNgR0xVEVhCHrAEXquDfYZOTWXTFPu3TW7vxy6R4gBtGiYK
         DzWw==
X-Forwarded-Encrypted: i=1; AJvYcCUwqAMgm1/Lw49w/46gNVg4WS8++4+OhbpZOASIyoVbHPtNEdbtlTkh510bvxFXjj0gih6+GHzy9nmNzcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUsQmWTY1eH+NCQEKXdEctGiBYXb/Tya9FJwPv5dZwW3kfD1i
	1cmUe/mbyM6peh4rrJT5x0vhnUjw/AYduyi7chmN+fofuzXJ9LVR
X-Google-Smtp-Source: AGHT+IHGZTaTUSSUJMjQoBpL1FZpf4KVi65Lqy7OyMEzvzFSJ0mjrxB0rW6XRaLy1i6Ch9oXLcIlMw==
X-Received: by 2002:a05:6a20:2d0b:b0:1d8:b060:37c6 with SMTP id adf61e73a8af0-1d8bce4272amr19010970637.0.1728956065840;
        Mon, 14 Oct 2024 18:34:25 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:25 -0700 (PDT)
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
Subject: [RFC RESEND v2 08/13] book3s64/hash: Make kernel_map_linear_page() generic
Date: Tue, 15 Oct 2024 07:03:31 +0530
Message-ID: <0ecad6f4f0d71fd8eb92b437315e981d23a14bca.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
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
index da9b089c8e8b..cc2eaa97982c 100644
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


