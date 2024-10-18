Return-Path: <linux-kernel+bounces-372129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29609A44C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB8C1C22E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA14204942;
	Fri, 18 Oct 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owap3dec"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978120694D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272684; cv=none; b=Ad5+gtqLi0tzeFCHhUcXC4RaIrfPRBYbpjklnX69uloLAuAbrDMvyZPJRw19cDml2nkeH0H5tXmqS0fiCBDRga8r6r4azfp8JuFUeHJ7MpV1g9f2mv6MXc8YPqBNQe2dMxzQCZpTGh8lpMPnrgNLbMYl36JldUnzuoKvvT2sTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272684; c=relaxed/simple;
	bh=91fYtR+ANu7O/Y5U9VPeZVNe/1K1yAoWvPLfU0bA2lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUESKLro39jny0xLiBONZsajT4A1B2LjGsQZUcMAvmKXU66rxO8bUSfjmuWwqHmebIoGUvSm13R0XCmHW80XKCUEkE90Rmq+C4k2DXOxZ5NtpjFu1gxcbpwNHk5tL4Yp6n+zXhBwjyOQ7KdAQRTA8g9HNKRoIQvwpPJw81qxxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owap3dec; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e93d551a3so1607556b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272682; x=1729877482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QLaMyzhWv0h56bpJNLe2thoYBckgfAdM8HvqGdr41M=;
        b=Owap3decxqfrICg1DHETviJCxqOstxFhcH4Lrb06+YTMul4uoJT02FK5zdI0CjR4/J
         hdkeV+JUQsDcse89h6+mvsK4y652x1cMREraYDxwdWF3lzXX0SL9lI/bnxZpMmQi8UW8
         BYjVdfm9/s7UlsuGqUdC3W3ZOr8rIKg9wlrHJe8e+C0ul03ltaC5R/wzWMa0xNHOxVIl
         SLDO1dgeDyEZYr/1ObB6vfc6rXGrV7PHiFpl8YkZ5RUFkR42rhOpjdTNs+jnVO2M1UYM
         AJ6IJV9u/+xbtHw7jkyh/Pd8h7ktZFc6ksO7jzfD62HoRiLZwe+lqXIw4SJZl9FRX9f/
         lHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272682; x=1729877482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QLaMyzhWv0h56bpJNLe2thoYBckgfAdM8HvqGdr41M=;
        b=dHosBWQfd3pIlFkpb4EaLHuKCl82uT1Gs+u+45i2p0GqNsf+dFm8phuOaECgbk69Pa
         FwaLo/GiytEEjADU4HUNe3+pruqGEiBd9Z9XWLhJqiEUFBUuVTd9Co1eL07QHPJyB9NO
         ZRyyPcvz4rNtyLxEHjWfk+AWvZ1F2xr9qfAapDu5iGuu+Gt2g+xklAl4wIRwp4HcFka/
         VfGlvmWgAFzoFmqQVpwPDsT/cKfTh5vnMcNWYM4JNrNU+dTKRSEHNpekigCOjVr1FVlW
         7TOnY/iXpIludi0yXnpVMFfwnGdJvxdb8FFmYHU4L7nQWGZIkZeG8tAhS7ezhYwrDb6f
         Gcyg==
X-Forwarded-Encrypted: i=1; AJvYcCUSjozEv1B8tFG4yTHoTLTg1UYw5pHXdWBTiwHJ+JclVrcjzjBDGWyHwLvhUDU7NEKEPduueT4cwVk8mFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48wwhG6EKhavPIzy+LqvC/JKxJVRa2tVj836W4tmgNrmDI9Gv
	dL1aZvArZziUuVhOFBoXH4ntu2RCcCcepARavJd2K2AxrOq50xdI
X-Google-Smtp-Source: AGHT+IFTSMl8QW5ycN4XEBU+MJ3K9NfWvdEojOEp7QlJ+1fDl8flZ96NMrdY+IbWH9uWHYWgBiWu4A==
X-Received: by 2002:a05:6a00:cd4:b0:71e:cf8:d6f1 with SMTP id d2e1a72fcca58-71ea316bf4emr3925702b3a.14.1729272682003;
        Fri, 18 Oct 2024 10:31:22 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:31:21 -0700 (PDT)
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
Subject: [PATCH v3 12/12] book3s64/hash: Early detect debug_pagealloc size requirement
Date: Fri, 18 Oct 2024 22:59:53 +0530
Message-ID: <c33c6691b2a2cf619cc74ac100118ca4dbf21a48.1729271995.git.ritesh.list@gmail.com>
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
index 2f5dd6310a8f..2674f763f5db 100644
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


