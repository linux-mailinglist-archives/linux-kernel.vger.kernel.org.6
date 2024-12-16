Return-Path: <linux-kernel+bounces-447880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB04B9F3846
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E251893D08
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980F20C47F;
	Mon, 16 Dec 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gl2EJSpR"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00920C00F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371901; cv=none; b=r9JhDrO+bQQii+wNKwlwoSTbA4PQmnc6Mb/sstlfRjmktV92bRXuAT9mbWnbHgamPNueEGKvhJYEIybBw/F3H9UaerWTvwzdJIqTvtf/6TCczGifQC5kt1J/hYVw8aptkdHPQMGYh+JplTcow0mbm9ybDUlmVY30A/GLJK7ZR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371901; c=relaxed/simple;
	bh=Pu9tKXL90m4hHLgJh+PJUU+2uRo8c/dROvim4hY2yzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d0vpymEVmva7kMv5CkvxJ91FyC52lp1xhLcZS2eW3sOPZ16f2f3AxXnjk7lidCkC6CfjB6CsK4TVsT+GJSWaag/t+NLoRvDz7tO9ZBp4ngLjcF8pVr0qVoByjJikVIcsVuzZS0ZQ2e2wcqTax4mZQtsfXyA8/418H1pEeJA+m/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gl2EJSpR; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3c284eba0so6275565a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371898; x=1734976698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6dFW7RUrUetXxVFNK2ULy2Fjq1gVFLFzwOzuHDurHwY=;
        b=gl2EJSpROTNrWJWhBIOLCi3ZxZJL5mWLRPukobL/iXk8bhkADlhL+AF/KMjZX+8zi8
         8F87qbQbOEeLoj2TIhOFlh42qt6YVUbUguKTqHKZyemuIDEojSYVBomr2Xb5oCM21ufQ
         FBG9EHE0mw6MnxIw1H+Y9cnvtvEaINsecJwvfWLc8K5rEDwkqGh6ZtgnXeTfogPRvUrR
         UfHBhzixkZBaPPNn6HA9R1EtY0AfIiyhP1dH+ynS0OPRPQMVxJUkbQvSKLnymdYyeXc4
         MDPA4IrU5ykKEUNoslC0ho96qAD+1NtRjKaQ4Yt8SAdGwu6dB5g0bMn8WuBXwrfiDe0j
         YvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371898; x=1734976698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dFW7RUrUetXxVFNK2ULy2Fjq1gVFLFzwOzuHDurHwY=;
        b=A0SPzNgfc/u2hn2kB9kX3vEPzZjqbB4fQKJA8YAojzShj5ug5L5IjPO8Nb/kK3AZZj
         aIAyQ9g3pA1JQDnppG4Q5ZYdHHEsNCv0v8URq3QAaKkr4aTJxxqTcd4WE1MKTi82uPWn
         3JVeLKpP3BqqMI9fDOe+FDF71/nmJ8iNCl08X9C1nYctsFQA65Otbn4ywLZjT7t+2sXh
         KSglBJ6qdwmFOuhmC5LQs1IG4f/lZgVZ888fFMKbvtrJQpxGWJiPHBs9KbzIyfCg1B9A
         KDjiLZaQ/xYrdOjoJ6HtMcqZ/YGyYJpPweXHDh3ryUu7204SSHqqgGE6Scl7kISNnZe2
         mlGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnWUXs0JGchbKqvN/oH46NdG1mBZ80SxJRRaheNi/P3dl1cY6OlsKnNJXcchtoRyYYUQ3uV2t5b24zFLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZie48Se8SOFkCTXwi8COZ7WQHRL/fmWXjr57zjxWT9/QR3nUI
	WRwYm3k7cQsO6CZeIs7H+k8S3UVGVCgsCTs9+WJopLMhA4uMw9pmN8j2p0goIBXe7PMNMU38Cy7
	Zw8MWVQ==
X-Google-Smtp-Source: AGHT+IGc0SKdQx4fRg/2UZZOEnFM7Ob6WE6YJF9bkeGHxvuSwv02bVDmCemOOlGDIUPuD02qJQBB9v2MqSc7
X-Received: from edxk18.prod.google.com ([2002:a05:6402:12d2:b0:5d0:2300:5be])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3551:b0:5d0:d84c:abb3
 with SMTP id 4fb4d7f45d1cf-5d63c3b1c3bmr12340959a12.26.1734371898142; Mon, 16
 Dec 2024 09:58:18 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:51 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-7-qperret@google.com>
Subject: [PATCH v3 06/18] KVM: arm64: Pass walk flags to kvm_pgtable_stage2_relax_perms
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

kvm_pgtable_stage2_relax_perms currently assumes that it is being called
from a 'shared' walker, which will not be true once called from pKVM. To
allow for the re-use of that function, make the walk flags one of its
parameters.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 4 +++-
 arch/arm64/kvm/hyp/pgtable.c         | 6 ++----
 arch/arm64/kvm/mmu.c                 | 7 +++----
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 38b7ec1c8614..c2f4149283ef 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -707,6 +707,7 @@ bool kvm_pgtable_stage2_test_clear_young(struct kvm_pgtable *pgt, u64 addr,
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Intermediate physical address to identify the page-table entry.
  * @prot:	Additional permissions to grant for the mapping.
+ * @flags:	Flags to control the page-table walk (ex. a shared walk)
  *
  * The offset of @addr within a page is ignored.
  *
@@ -719,7 +720,8 @@ bool kvm_pgtable_stage2_test_clear_young(struct kvm_pgtable *pgt, u64 addr,
  * Return: 0 on success, negative error code on failure.
  */
 int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
-				   enum kvm_pgtable_prot prot);
+				   enum kvm_pgtable_prot prot,
+				   enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_stage2_flush_range() - Clean and invalidate data cache to Point
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 0470aedb4bf4..b7a3b5363235 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1307,7 +1307,7 @@ bool kvm_pgtable_stage2_test_clear_young(struct kvm_pgtable *pgt, u64 addr,
 }
 
 int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
-				   enum kvm_pgtable_prot prot)
+				   enum kvm_pgtable_prot prot, enum kvm_pgtable_walk_flags flags)
 {
 	int ret;
 	s8 level;
@@ -1325,9 +1325,7 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
 	if (prot & KVM_PGTABLE_PROT_X)
 		clr |= KVM_PTE_LEAF_ATTR_HI_S2_XN;
 
-	ret = stage2_update_leaf_attrs(pgt, addr, 1, set, clr, NULL, &level,
-				       KVM_PGTABLE_WALK_HANDLE_FAULT |
-				       KVM_PGTABLE_WALK_SHARED);
+	ret = stage2_update_leaf_attrs(pgt, addr, 1, set, clr, NULL, &level, flags);
 	if (!ret || ret == -EAGAIN)
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa_nsh, pgt->mmu, addr, level);
 	return ret;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a2339b76c826..641e4fec1659 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1452,6 +1452,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt;
 	struct page *page;
+	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED;
 
 	if (fault_is_perm)
 		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
@@ -1695,13 +1696,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		 * PTE, which will be preserved.
 		 */
 		prot &= ~KVM_NV_GUEST_MAP_SZ;
-		ret = kvm_pgtable_stage2_relax_perms(pgt, fault_ipa, prot);
+		ret = kvm_pgtable_stage2_relax_perms(pgt, fault_ipa, prot, flags);
 	} else {
 		ret = kvm_pgtable_stage2_map(pgt, fault_ipa, vma_pagesize,
 					     __pfn_to_phys(pfn), prot,
-					     memcache,
-					     KVM_PGTABLE_WALK_HANDLE_FAULT |
-					     KVM_PGTABLE_WALK_SHARED);
+					     memcache, flags);
 	}
 
 out_unlock:
-- 
2.47.1.613.gc27f4b7a9f-goog


