Return-Path: <linux-kernel+bounces-429247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752A49E197C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF81280A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E61E2840;
	Tue,  3 Dec 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0cjv4J2"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9B1E2834
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222267; cv=none; b=SPGqFQacjMzhrCSgSYczK3amte/IufkU0rcm0wMPEI53osldexiNs9z21+qZKuAQmbWkQOBxUMXFoLYhtOf96d9KjEOnba8cEJ/VTuR8u399Eeh99WeTRIWYse60eBmFYRT9CSRoWY5Ak0s0JUDgqqoU/s+k9RUNuRrSOKSXBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222267; c=relaxed/simple;
	bh=xJhsEPialpMSQVCnlCgLVWaAFxIPGZNZJG2yIthGfFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kkMBzPGT/XnHsL+j9WST5DU2Gx91z3edSbFT0IiGVJknPEX2Qypc/JBAtPXykfhtRmiqM9EWYJaiLbk5SnSglYaGimDoKSkk7qTXxiu//OjaFjxts4Of8ZVE8bcCsppitpnCZc0yby2GSd8N3a/spm+QDeoyEiyrl3PHwkI5sTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0cjv4J2; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa53fe66a10so196370766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222264; x=1733827064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2InjsufEFntOTn6gngou7a+5/1DcqO5mqDCh0ChGiQ=;
        b=L0cjv4J2vMa6hqV2tjOj0sTLWcRnIU3CUWZACIEhPDb9lvezin3qNLUnw8ZxPWqqev
         0lfwMsnt1Qxxb7K/h1rrvnVWf6ZsQKjeWLL6vigPPx28wjhIp4pBxDRQ3HdpUxbo4B4o
         OzQcNwSu+KNfpyDdRyEgDoVcG+z2n0KSPiG8ve3AwFjXMbGOG95w++HFakXD8loxicev
         jqW7TXc8nrVJ2dMbW+vzy9yjaPiauwT/2F2qtkFKCk/Emd9Dz/CwdTv4vriUeuTWkL6R
         meK4c+nsEwDkd9taDcNs3PYDIIjdrEh06AwwKlrBZi5z2UHN5OdRXJOgWZ0WZ/koyGx+
         qXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222264; x=1733827064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2InjsufEFntOTn6gngou7a+5/1DcqO5mqDCh0ChGiQ=;
        b=J4+fSz+EZjMINJx/YxGunzkhjE706sRUjZ6pceB4FSBk5yVm5qBZ/9q2G66oDS7kMR
         K0m3/8ZKVxilXiQt3Yq1vemBKy1NJTp2Clb4LwTHWQCSKia7kCHbAquykqQ0aI5x6W3a
         MFpNXEObNhbTxleH+H/weI707U9H4hXHPVi35jY2Ldt2ADmcLjEKBxyktvJKpJDN4FsU
         u9+BoVITSonbPnxpY00l95fqriS0YbbOwSnSqDPfvUgIhFOW6FWsGt75Fh0+A+lDnaZg
         Whw70OeKq3Vpgx0KqruWrVkI7WIj6JARWpeiM/eDchFhFP1LiV1+3GjKCNgMnpgoiWsw
         5SJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSMCQ2uG17umx8wn42NxcZ3PTUN15c1quuEp9x3fW4U7kbLJiC05A/YyZ5ehlBFlv9FmQU9uVB2Cgp6XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjWZcH88Xbltg2UFf0oEB5whiGP9GxR4xKhk5TPToacEdwbsRb
	olY5xmSySdn6kza+095bJhi47UGhy23HxLLqYaccNMwEYzu1NcuVuSZYro/xX6wtP74hrJLGBVL
	KUzWCzA==
X-Google-Smtp-Source: AGHT+IHSSZV41AorJLfo/1p2l1Qb/DDlm6YrY9d8yFrAzAEDYWvvckpC9yFrYjhtgszoT38Flr2x4P1q4kIY
X-Received: from edty16.prod.google.com ([2002:aa7:ccd0:0:b0:5d0:adc6:6843])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:274d:b0:5d0:e73c:b7f0
 with SMTP id 4fb4d7f45d1cf-5d10cb99c5dmr1943009a12.28.1733222263766; Tue, 03
 Dec 2024 02:37:43 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:20 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-4-qperret@google.com>
Subject: [PATCH v2 03/18] KVM: arm64: Make hyp_page::order a u8
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
2.47.0.338.g60cca15819-goog


