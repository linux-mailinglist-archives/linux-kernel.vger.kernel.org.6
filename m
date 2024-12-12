Return-Path: <linux-kernel+bounces-442747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01929EE11C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EB016680C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433E20CCD5;
	Thu, 12 Dec 2024 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHD60eAR"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C434620E03B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991548; cv=none; b=anw/9+zw3oHIbcYeJ88UkmvpBwacaUwV4dnqnkP+F0pfHqqH+X4exIRSNN30B/L0vRgwLcyyW4Lv+bDgw9my8bmq4e8R533OTR9YBElJJzB0wDeDFaEoJc7WJ7FZO11VsQcpwB0d/9OHxgPeadlbaRUlEozBXq/Kb/XAOqX1VYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991548; c=relaxed/simple;
	bh=BSTbUB5aX34dwDYPRsloc7L4ndSO8jVihR1HUgb7228=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WCzZqAPaeFSCeXERF8NtMzDt8pp7zRD8CwKh8Me+t1DZjX9n+vYc0tErK0uhh3V1YKZ6CE/0PdbJqzFqKCLczrwTZVAfceGyM1nMvnSVPlklOml0Amv32lWs5Ye8iOu/FRq6+8C1XvskW6MolLoKQJd+Z29nH6c20aUmu/sg2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cHD60eAR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-436248d1240so1967695e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733991545; x=1734596345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6isFNd8zHOf41Of/wjxlI+b9qTAIYvxlEpDr2EkvB3U=;
        b=cHD60eAREOV+wjzTAbZaxvLZ4WQhXHhg1AocX2wpDCFAaxRAp+GceT2L5Amzj8N7uH
         YN6eD4Pl8AnWiZn7ZN6KbWtWPN4F3aQguNZAHzHAnPTqia5X3pd2IXrl0LUo4VblmGZ8
         mkL2RRbdrPrCQCZc8yesVn2emTFnUmUURYRRnrvm8kFOSg92X7rMnV9xHOKluwanilBo
         YI8uq4FCqs6DjOeG+vdWTVBpDflbf3rGPa3svgivSST+Is7QUyJSDcXQ3N0p6IES+3kw
         UhNbYAzcTxgD/fXA1nOgk7oPfTcv8m09ZTfRJmZs+muZpYv0tZsL7K8XXv2+kVgDmMob
         4Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991545; x=1734596345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6isFNd8zHOf41Of/wjxlI+b9qTAIYvxlEpDr2EkvB3U=;
        b=KPD7GD+SRoGyZ0/eStY680T8x4VRmrTK39OupWQ3mUDsdX7J4vMHrAiHiJJnWQfPPz
         IRZpH4EPdrjcsP5j65zOZGxZt890kHoRZs2fh1bfe/0VwbNOvzO14IuUnNQgt5rJ7IQl
         86L3nE45/6uAo5+SMcdS0OkehwA8eGt8S9+xS2klE5duotqJidtg30l/QBrcoMoQmO+8
         dmiXUxyI/5s/DQLqnlefPuqztvn2jEfUeYbBGb4zbzD9GnJRDH+3DzekZH+ao91pmje4
         pulNVtl/XI5tubvq8p6dakJuC1BhSGxRtfgOzddxyWbm/pD0gzEqeBmZks4DAGi5Ihq4
         OH5Q==
X-Gm-Message-State: AOJu0YyvX3VGQz6cJM3dPzqGU0h5Y3+qh6wyiFtobXv5DhuMBkXY8xzA
	3dzEUHNQZW8gLE7PT/t0Jxqap7od0xAG2u/pr8nU8OXx/N3qY6eTYT/GSJdIG7jId8c1vw==
X-Google-Smtp-Source: AGHT+IGiNwt46ersFJk8J3W4FvXc0YIFm/aDF3p261C7M4Bc1ps+NMc5UV9QpUddAEBdOk7TXMj8hL3G
X-Received: from wmfv7.prod.google.com ([2002:a05:600c:15c7:b0:431:1903:8a3e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:468a:b0:434:f0df:a14
 with SMTP id 5b1f17b1804b1-4361c34623dmr48042095e9.2.1733991545427; Thu, 12
 Dec 2024 00:19:05 -0800 (PST)
Date: Thu, 12 Dec 2024 09:18:46 +0100
In-Reply-To: <20241212081841.2168124-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212081841.2168124-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4036; i=ardb@kernel.org;
 h=from:subject; bh=wxQBa7Qia0zG9OkBtRYf+Ymgq0cT+W+pOrTZLi6s8yQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT1qTnpY6bHtf7P6ePhaAiaXMSobvfSe5hBzWDJBMM308
 rUKv7COUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMBHLpQz/lAy4y1iv/gk7c5Pf
 43HPlMeTvzDt/SSVFRO2fd8xC+01JQz/6w49Ovvy3pzpBR22RWy3irYtb9G3Wc7Xs3NS0IHlk67 eYgQA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212081841.2168124-12-ardb+git@google.com>
Subject: [PATCH v3 4/6] arm64/kvm: Avoid invalid physical addresses to signal
 owner updates
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The pKVM stage2 mapping code relies on an invalid physical address to
signal to the internal API that only the annotations of descriptors
should be updated, and these are stored in the high bits of invalid
descriptors covering memory that has been donated to protected guests,
and is therefore unmapped from the host stage-2 page tables.

Given that these invalid PAs are never stored into the descriptors, it
is better to rely on an explicit flag, to clarify the API and to avoid
confusion regarding whether or not the output address of a descriptor
can ever be invalid to begin with (which is not the case with LPA2).

That removes a dependency on the logic that reasons about the maximum PA
range, which differs on LPA2 capable CPUs based on whether LPA2 is
enabled or not, and will be further clarified in subsequent patches.

Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kvm/hyp/pgtable.c | 33 ++++++--------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 40bd55966540..ed600126161a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -35,14 +35,6 @@ static bool kvm_pgtable_walk_skip_cmo(const struct kvm_pgtable_visit_ctx *ctx)
 	return unlikely(ctx->flags & KVM_PGTABLE_WALK_SKIP_CMO);
 }
 
-static bool kvm_phys_is_valid(u64 phys)
-{
-	u64 parange_max = kvm_get_parange_max();
-	u8 shift = id_aa64mmfr0_parange_to_phys_shift(parange_max);
-
-	return phys < BIT(shift);
-}
-
 static bool kvm_block_mapping_supported(const struct kvm_pgtable_visit_ctx *ctx, u64 phys)
 {
 	u64 granule = kvm_granule_size(ctx->level);
@@ -53,7 +45,7 @@ static bool kvm_block_mapping_supported(const struct kvm_pgtable_visit_ctx *ctx,
 	if (granule > (ctx->end - ctx->addr))
 		return false;
 
-	if (kvm_phys_is_valid(phys) && !IS_ALIGNED(phys, granule))
+	if (!IS_ALIGNED(phys, granule))
 		return false;
 
 	return IS_ALIGNED(ctx->addr, granule);
@@ -587,6 +579,9 @@ struct stage2_map_data {
 
 	/* Force mappings to page granularity */
 	bool				force_pte;
+
+	/* Walk should update owner_id only */
+	bool				annotation;
 };
 
 u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
@@ -885,18 +880,7 @@ static u64 stage2_map_walker_phys_addr(const struct kvm_pgtable_visit_ctx *ctx,
 {
 	u64 phys = data->phys;
 
-	/*
-	 * Stage-2 walks to update ownership data are communicated to the map
-	 * walker using an invalid PA. Avoid offsetting an already invalid PA,
-	 * which could overflow and make the address valid again.
-	 */
-	if (!kvm_phys_is_valid(phys))
-		return phys;
-
-	/*
-	 * Otherwise, work out the correct PA based on how far the walk has
-	 * gotten.
-	 */
+	/* Work out the correct PA based on how far the walk has gotten */
 	return phys + (ctx->addr - ctx->start);
 }
 
@@ -908,6 +892,9 @@ static bool stage2_leaf_mapping_allowed(const struct kvm_pgtable_visit_ctx *ctx,
 	if (data->force_pte && ctx->level < KVM_PGTABLE_LAST_LEVEL)
 		return false;
 
+	if (data->annotation && ctx->level == KVM_PGTABLE_LAST_LEVEL)
+		return true;
+
 	return kvm_block_mapping_supported(ctx, phys);
 }
 
@@ -923,7 +910,7 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	if (!stage2_leaf_mapping_allowed(ctx, data))
 		return -E2BIG;
 
-	if (kvm_phys_is_valid(phys))
+	if (!data->annotation)
 		new = kvm_init_valid_leaf_pte(phys, data->attr, ctx->level);
 	else
 		new = kvm_init_invalid_leaf_owner(data->owner_id);
@@ -1085,11 +1072,11 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 {
 	int ret;
 	struct stage2_map_data map_data = {
-		.phys		= KVM_PHYS_INVALID,
 		.mmu		= pgt->mmu,
 		.memcache	= mc,
 		.owner_id	= owner_id,
 		.force_pte	= true,
+		.annotation	= true,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
-- 
2.47.1.613.gc27f4b7a9f-goog


