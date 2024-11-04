Return-Path: <linux-kernel+bounces-394927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE329BB630
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEC6283803
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A12AE77;
	Mon,  4 Nov 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDUCe8Zu"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541012DD8A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727137; cv=none; b=SkIZlYP+qtux6WGVHoKnMvB5zCELgj7Y9qANOCiaccIe50mPdZAxzTlhSRRd+Hu9LUSeYEbnE1FsdlJwHkCMwtHUwnbGbyG5zL4OUD/J35ptR7Yz7HAjVBoWpglbWlyBjBleNgvL2+ulB6l3W5/+/tJHFajluC9bqdD2FM7fLGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727137; c=relaxed/simple;
	bh=REnepbOcmsv0k7th+LSpXXbICi7vnDjh1RvcN0Yje7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ArmkkJDvt4J8xQzMp3NtuXh8yhzX8dJ5TLlqX5jwp9ONGTYm0YD6vVe8y6scFOojRaHIoqBK+q53KjLzVqvKy8LJo1M2McaMBPxrEWDjmKjLdfD/kERsnmo9Qrm5H1t/nGf1cUD5HsSUiiLx24ht0fS0GhxlqruyEdsvc/+51fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDUCe8Zu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30ba241e7eso7606515276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727135; x=1731331935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjUYluJ7thLERHfqDAbw880QNuSB0DBGhk0tN16op68=;
        b=ZDUCe8ZuXyWX7V/8/RVUU+qk5bqMoi15Xcx1Xqm5mGfQxjoD02kiCAD7hZ2rY20UN8
         x48GxQ19b4p5A8llU9h2NKYv6E3ETnqeg/swN0MLfUA5iRRrMjunhZVJtRyCOzXkMOwW
         iiaNvaBmoPACceWrvPlMH4EAJ33JrvFLQh9EbdFr63VAnXgt2n5XH1Nro9Cn/n/OY1un
         vIzE3/zwiCczegHwCcUkfTJL83heky4JWbY6naSj9s0ldD6whGKSpPPoN5tws+r3zeL6
         YsL8lEfXT4XQZzu4DinoqUcyD4d3MbmePl10BpHM5QjsIjMfHPUsx4Jrnm+Y2yCzg9R+
         kjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727135; x=1731331935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjUYluJ7thLERHfqDAbw880QNuSB0DBGhk0tN16op68=;
        b=QbZ7YCnlb1sXOTl1TBfIACqog98dtM99JcHLE390qOkt1q0RQO0wbpvKp/DHxaWhua
         E/EOj0VRDY+p47sxR3xVq7NNgaWvyMGCrYYwbCZnz5K6+IPLxE2D5+ulBmR0B69m67lJ
         0KO2VEk8NFQhuTP5LEkLpj0xCMSzSI74RwPZcDoiU+m28lgkjeLFotD23LMr6/Eov3vZ
         OPLJFrpUpzA0QNWgNBtpAVuarolGZQMb8ZJzhXhAxYpiaXWLROCaI/Q4fs5CWyjhfNBC
         jrswoN1WOj7On/jnH7HXC1f347Bv7+PFh4X5JDf1wxTWJA5zwjCOxoPwAk+1ptG6ljeQ
         IZow==
X-Forwarded-Encrypted: i=1; AJvYcCVysnpkNK60qEkjVlSZzG8m4kbMw3VYXMznHBzEjdCQXYdEpyyczyFO/CL8x5d+ZM0a/1dt+Tp/v70we2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yhaoUVQZGT1REd+r/Trt9mYzDxx0aypd/cYsnX12e7WnGoNk
	X/eTYDMckgEoAwW3VhmZ31hYBjOuPG7khOgn143e9BfqTt+EaDAvqXc+8LJiLwwJCXv/13rXD0l
	tRw6VWQ==
X-Google-Smtp-Source: AGHT+IGCwsvypUWNk6RlNMRAjdWFDm97ufr3Hg3Q8v/EOjc5GY5BaJQCKOeF2R4oR705NB7B1GCdCKn9Vkg0
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a25:ba0d:0:b0:e28:fb8b:9155 with SMTP id
 3f1490d57ef6-e3087bfc93amr63281276.9.1730727135113; Mon, 04 Nov 2024 05:32:15
 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:49 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-4-qperret@google.com>
Subject: [PATCH 03/18] KVM: arm64: Make hyp_page::order a u8
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We don't need 16 bits to store the hyp page order, and we'll need some
bits to store page ownership data soon, so let's reduce the order
member.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  6 +++---
 arch/arm64/kvm/hyp/include/nvhe/memory.h |  5 +++--
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 14 +++++++-------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index 97c527ef53c2..f1725bad6331 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -7,7 +7,7 @@
 #include <nvhe/memory.h>
 #include <nvhe/spinlock.h>
 
-#define HYP_NO_ORDER	USHRT_MAX
+#define HYP_NO_ORDER	0xff
 
 struct hyp_pool {
 	/*
@@ -19,11 +19,11 @@ struct hyp_pool {
 	struct list_head free_area[NR_PAGE_ORDERS];
 	phys_addr_t range_start;
 	phys_addr_t range_end;
-	unsigned short max_order;
+	u8 max_order;
 };
 
 /* Allocation */
-void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order);
+void *hyp_alloc_pages(struct hyp_pool *pool, u8 order);
 void hyp_split_page(struct hyp_page *page);
 void hyp_get_page(struct hyp_pool *pool, void *addr);
 void hyp_put_page(struct hyp_pool *pool, void *addr);
diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 6dfeb000371c..88cb8ff9e769 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -42,8 +42,9 @@ static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
 }
 
 struct hyp_page {
-	unsigned short refcount;
-	unsigned short order;
+	u16 refcount;
+	u8 order;
+	u8 reserved;
 };
 
 extern u64 __hyp_vmemmap;
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index e691290d3765..a1eb27a1a747 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -32,7 +32,7 @@ u64 __hyp_vmemmap;
  */
 static struct hyp_page *__find_buddy_nocheck(struct hyp_pool *pool,
 					     struct hyp_page *p,
-					     unsigned short order)
+					     u8 order)
 {
 	phys_addr_t addr = hyp_page_to_phys(p);
 
@@ -51,7 +51,7 @@ static struct hyp_page *__find_buddy_nocheck(struct hyp_pool *pool,
 /* Find a buddy page currently available for allocation */
 static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
 					   struct hyp_page *p,
-					   unsigned short order)
+					   u8 order)
 {
 	struct hyp_page *buddy = __find_buddy_nocheck(pool, p, order);
 
@@ -94,7 +94,7 @@ static void __hyp_attach_page(struct hyp_pool *pool,
 			      struct hyp_page *p)
 {
 	phys_addr_t phys = hyp_page_to_phys(p);
-	unsigned short order = p->order;
+	u8 order = p->order;
 	struct hyp_page *buddy;
 
 	memset(hyp_page_to_virt(p), 0, PAGE_SIZE << p->order);
@@ -129,7 +129,7 @@ static void __hyp_attach_page(struct hyp_pool *pool,
 
 static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 					   struct hyp_page *p,
-					   unsigned short order)
+					   u8 order)
 {
 	struct hyp_page *buddy;
 
@@ -183,7 +183,7 @@ void hyp_get_page(struct hyp_pool *pool, void *addr)
 
 void hyp_split_page(struct hyp_page *p)
 {
-	unsigned short order = p->order;
+	u8 order = p->order;
 	unsigned int i;
 
 	p->order = 0;
@@ -195,10 +195,10 @@ void hyp_split_page(struct hyp_page *p)
 	}
 }
 
-void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order)
+void *hyp_alloc_pages(struct hyp_pool *pool, u8 order)
 {
-	unsigned short i = order;
 	struct hyp_page *p;
+	u8 i = order;
 
 	hyp_spin_lock(&pool->lock);
 
-- 
2.47.0.163.g1226f6d8fa-goog


