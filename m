Return-Path: <linux-kernel+bounces-447876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E109F383B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8362A1893180
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147E20B1F4;
	Mon, 16 Dec 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rY1oa6Cg"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41C20A5FA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371894; cv=none; b=jlmB3I6//wjRSmW9kIO0p6yx8n6Tbor8qAgCXyr3/n9auCwVAJNVyzQFsl0OYZH0GuT9qemsin4BW3BCZMUGF+sFShVErgdFwcANT6tRCU/dqEGmg4fQxKlejwKb+lxhXeXoFVQ2P3igUVCUXFugbjrW0G/Dj3ZckXmWYiK3Ou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371894; c=relaxed/simple;
	bh=5rIXTy5TPuGoLMiV0oXvNDVO3dkl9RGtMRlZct7bt+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kiNyoQFIdnA0Era2prbWk4BKoCUALBap3oFBm4ja5r9T8LZ8UTTaEYRO+0T58tPek6VztdZPAkgP3bIu1ua7r6Y81S/a3ws03dC5yPkHk9QnUHrisB7avntKhg+2TFLUsGuCwc6BEZaQrQrsFaW7bXJR569tir+kBmrNvWQRYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rY1oa6Cg; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3dbddb891so6337644a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371892; x=1734976692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9U+p93j/YN41MEZx68FsDZhowuKIrUGiMwA9+JFupUA=;
        b=rY1oa6CgFsayyh0e1GYodWAfolJhtPwSbFX62RLB0Sh2EV7tTonR9/96ySZ6t8150n
         FVXznlDLoigI1tDQwlyOpBEUz4QyZPXWvF4EL9+O36P1N26jdEQnXLRAKtOtGFv0Hx9m
         kcWXs/qnsxNqn/MCd9Wl0/8p7d7jOeigbzLcz3CcxE6Gf51INaCNx3WUfrSHsuHnuB1h
         jhZ0+TenJAkr/NNSKZn+6xX4mqA9SQFOpth67Ou3VXp2Kpr2QIcVUwaP1ziWxfwSPfio
         ZS5jIB8wiJ3OGfC9VpSKecP0FkmreH/6RBRT8lDG8rIrs9sG6EP38///6xTsxPL2Oehx
         Gd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371892; x=1734976692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9U+p93j/YN41MEZx68FsDZhowuKIrUGiMwA9+JFupUA=;
        b=Hwd0RejdsNtj5a5uKZSvknHcvOXYz8CnpSwfsmxN4fl4cQx2q+ZTtTlZW6WFo03teE
         Dk8vnBOsM2ugu7tFH3glt1mQmOcmwJJ6HBuxgOwRK71QhlNfyA0613H0rNiD7IyMvPpO
         wIJXypiIQ0pQ7us/mPNPEavb3ooer2P7qHxGxvCugCSULXPdw1bb4JTPljj6u+XyB9kg
         XqbJtHLuTSihX3YQnL3kOGeRADl2kGxBlXRBKUnL9tEhHSrl7WzNzHJOGtTh8P/4uFNp
         7gpH/HzEC+TQXOAmhsm+RwZPNx05XlJ7+bhQWJWMdP9Op+J70AietNS5B78FeZSNdjeD
         /nxg==
X-Forwarded-Encrypted: i=1; AJvYcCUnnT55guHITppu3ssy7V5bhHvhFXlBsUobfnf5iJhyrjLnLYmzFE/+l7yh0h7/1BUUoV7Vc5NNVoIlakY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy913ZpeClz51+pGumEZngpYq4qLPN5cqOPCSpcjYG9/UrHS1Ri
	E0yWv5exSTB83R7bhYuxUnf7tGO89JUXMqwluLro2jCvLsQ9IvLaQQ3hYV9SU2VFjVWnuHewW9b
	c+ketgQ==
X-Google-Smtp-Source: AGHT+IG7st/yyJqIhpv2xQBIuWlDy4uU3mEKGGddfO0WV9zfYHQl4j73x0bTTMfU7vqe5be5/q+MEgxQCPxJ
X-Received: from edbet14.prod.google.com ([2002:a05:6402:378e:b0:5d0:a9a6:5abc])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:354d:b0:5d0:7282:6f22
 with SMTP id 4fb4d7f45d1cf-5d7d56175c1mr253568a12.14.1734371891718; Mon, 16
 Dec 2024 09:58:11 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:48 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-4-qperret@google.com>
Subject: [PATCH v3 03/18] KVM: arm64: Make hyp_page::order a u8
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
index c84b24234ac7..45b8d1840aa4 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -41,8 +41,9 @@ static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
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
2.47.1.613.gc27f4b7a9f-goog


