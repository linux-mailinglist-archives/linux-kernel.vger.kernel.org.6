Return-Path: <linux-kernel+bounces-433500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ED69E5949
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA49284F94
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06EF221442;
	Thu,  5 Dec 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kV8nzbDr"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1321D5A8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411009; cv=none; b=cTNJE9FVxJ3eG8sUME/wWCnDFzwIhVp3ptrPe/eAAjDXkhrsfy1UihjLDYw0AJKMYSC8PC8MZwi8N5lNejIdfsoc9rtkFv57E2i0H2v++SNnNAht+vOSAFgEKwReaCgE8f4NrltEyyU1vfnCdtGCQtH7XcP2/YNWJIyDlunlzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411009; c=relaxed/simple;
	bh=wQQNyevkdRisHY9P0lkKKy64rBDjstgt3+OHAT9VWt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QnOJO9TxJDlmPtjIMODHAHTzwYOcyYy4G/IGqSbFEAvXfQ2maxTXMSdgEMN1McQejjqWviYmEQE9VP2xbsBsS+sZRVWW7vfhDJ8TIoud8zcxt4FljlmyczZpN+gCYL7LJJ1IvjH50RVut1klCnBUiVhkPB+njpBj6J1EcixPhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kV8nzbDr; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434a195814fso8678825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733411005; x=1734015805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=slhXHLrcA4lnMI4mcoJ78dsh1V1y/MQiAPdO/CifUdE=;
        b=kV8nzbDrJhSOq8RhwBtH9lSMGGFbf9FObAPGovWtDj3exdUsbq9F8afpWrl+pIH35h
         HmRFnG2w4zejQ2kBjg0N/u20oBVivuHy1roXUp7MDZSO/2XK2MTD7MksTisAkvyjbiTS
         sNL+r662puDSJ59NgAtEtFqwxrlwiDMTebZGEvvIP1V7LI+Fl53C1Uffyjv1GbR+AQXo
         o+dyS+WsndsPFADGE3Ok65PYrfn12nl8v0iV8XSeIPbsUjS7cqQS6cSAjMuLMCphJLM2
         A5gHKGfsAaYVhrUGnl9cE0VFlR+ixFZ+9BC3YsfN2ytpk8jT6wg4mqqLGWJ/ZOT37Xem
         /mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411005; x=1734015805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slhXHLrcA4lnMI4mcoJ78dsh1V1y/MQiAPdO/CifUdE=;
        b=j+DRjGMUu2rnUGUE4FfJcZhtQEFT8Kx2HrEuiUX/ilKhRRVbpIF39h5gLvL7dWOSlh
         rTpQubyaW8vEwURGZB0E/xgoZrkbCMYFJ4xeFtRjEINNGNEDgr0wtRE9ki79+maUXepd
         PQX3O2xUHIwpc10MfhDylcvSnokHxE7pAmOLMCtpViLMtBFVTy5WXFnQe+GHJICliZS+
         5FmDEXTpBkgH3i3hFgn3k+nswOy1E4ig6Cx5TaBjQsimBZOiOBVMKU8sODHMNusQVhB4
         MI4rULcLdYqY+zNaZuSMDo/oscqS6GQtx5s8tLBXAWSVamtX0g7rCXzxyHmZo3Fo1NFO
         gIrA==
X-Gm-Message-State: AOJu0YxahIOYIHavtTogMWxuZZhrupJSKVL9PGVt3P2CNnXLvITTXCXs
	DCHU51ZdTrF37DB71nf7UJ2bTCqYhGKfDACUMjKd8UWSX76Q+FAeKetzMUZxx3Wq4zEQew==
X-Google-Smtp-Source: AGHT+IErGDMyoNEYHKdtQJ6HM76Rh0wVhjISU3TsZyJvd34+AxRKANhdtUS2dFF3NpSngDONw8BYuky4
X-Received: from wmap8.prod.google.com ([2002:a7b:cc88:0:b0:434:a98d:6a1c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:138a:b0:431:52da:9d67
 with SMTP id 5b1f17b1804b1-434d09b1831mr105644975e9.3.1733411005512; Thu, 05
 Dec 2024 07:03:25 -0800 (PST)
Date: Thu,  5 Dec 2024 16:02:34 +0100
In-Reply-To: <20241205150229.3510177-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205150229.3510177-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4048; i=ardb@kernel.org;
 h=from:subject; bh=VbEZrG51fuTH0v9uDoNKILnxrXNsrpIhK9DKU+UIPRo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3wQE+L6sedXZ5yJg+VTgT9CFzu0uz17I6W0Jk+Jc6Oc
 8ZhR7M7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQW8zL84dq2VW6meKX7c+ao
 P7npe27eN/73/uBeCT2mUPWAeUcf8zD8Mz73zqPWPsxO9D2LcpuNSq7+lCXyvFcXHt99L+Yt975 NzAA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205150229.3510177-12-ardb+git@google.com>
Subject: [PATCH v2 4/6] arm64/kvm: Avoid invalid physical addresses to signal
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
signal to the internal API that only the owner_id fields of descriptors
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
index 40bd55966540..0569e1d97c38 100644
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
+	bool				owner_update;
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
 
+	if (data->owner_update && ctx->level == KVM_PGTABLE_LAST_LEVEL)
+		return true;
+
 	return kvm_block_mapping_supported(ctx, phys);
 }
 
@@ -923,7 +910,7 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	if (!stage2_leaf_mapping_allowed(ctx, data))
 		return -E2BIG;
 
-	if (kvm_phys_is_valid(phys))
+	if (!data->owner_update)
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
+		.owner_update	= true,
 	};
 	struct kvm_pgtable_walker walker = {
 		.cb		= stage2_map_walker,
-- 
2.47.0.338.g60cca15819-goog


