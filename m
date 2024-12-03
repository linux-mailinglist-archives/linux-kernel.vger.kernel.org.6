Return-Path: <linux-kernel+bounces-429249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3B59E1B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1CAB3CE9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C01E32BC;
	Tue,  3 Dec 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QitswnL5"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B31E285D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222271; cv=none; b=CwC+bEuUE/GSw9+KzKzew2vuflcM2677nIilu8CvUuUJL4w68H57mVyVkKfhGUPZClPpnYXvKglYBeKz+NULAibh8XP1jcJhIUUEYMQDDsubDMgeXzLSYU0EfYMSvdj/Bo+DnDegIc08EQYghHhdjfw4Aya06d/lSqpjcM0S6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222271; c=relaxed/simple;
	bh=qRSE158UB3ySKdQmoqWg+ZyQkKR3Q4ghX7q2nVjU9O8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rHNUqQv8R/rKHGbkxugUbjQtPMN/jgF2dn5DfugvpMh5JIhdk1bOb6cXxVN8pdDD0Mv/1ylvqp2lWZXWgP4gEpIPK5GpbKJWjPlpnsay2Vnv2gmEAm2w3yrLQg8yLTsLZtD6NbJeqp/SpdHxImqtpguElCMBvsQIM1NIE4+y+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QitswnL5; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0cd8a0ec5so2256359a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222268; x=1733827068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7tOYZxQzwS2lgtsj/R92cF0vRMD/ffbTmBJ2Qyy7h8=;
        b=QitswnL5Eq44NT+s65Nq0DJ/6Jt82tZ3P34U19fjHIMCNfoY4icXqBXZfzSWStbJOT
         nVvxDcf9FG8N/Nx3jHJNhlPhW86JwfTcdCZhjeXBqPOS+zHJ7pb5fQ+BoLMt+H/OLhv/
         iGyGcRXPxmnal78S/T5gGTWKA67akHjlDtczJX3m+J7hOXmsJIN506VuTuHZQ76entko
         pc1K8DgTtz93AgysiW0nl1wx7cSxV0sqX+chZBNPS5moCnhwBQXm4MFR1j4IySSI/We6
         9Wlz0xS3hYAPBxmHzSVweb7vxWsWwyBAomiY6lihu/9pgtVLssmlOUpy3i+C4xAmzk13
         CFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222268; x=1733827068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7tOYZxQzwS2lgtsj/R92cF0vRMD/ffbTmBJ2Qyy7h8=;
        b=PM5G5eTFIXLnfNRw6UPUXEEzPnFwWQ/DMxtNog01hbXX+RasFMR7n985fCbiiDuhQp
         aAIzZFGlBY8D9Oo/3lc5jHct+PtuDvs7smSrvXkPQop7k9FaTRSP4x/jx2sVKLYpCBvi
         wf9AT9COOYh8u7mZ3UJbKQaNHcjMQoXdhaZhcTq3r1xeaWA3SR5U5eTw6Xh6DOeaM0ZC
         eFFsYxh/ZFqNWYhfQfYGtVue33nHBYGKNCXxcuOyk5I5JgH9sZgDb7RyjohOVoIrnrM7
         03VHNQK4Si8wIu0d8fQm0rjnZPoV2fr/QvQvFms0TbGwtLa6s40aMLZgRSV1AgQjpO8I
         ScSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9eBPKouf2EiDXrvgJyW4Mfcx83n91TniBE2bvzc/5m9y5Th12sQVp2+8yoHzDgTMEEObUetKNrawIwfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLx9MJHuQvIFe60qK3HyuncoVJePdX6hE5Xpp4y7e20wZa0ptE
	Px3EF5aXaaukciGz8JwXVhv9QzMxXTb5Jn9sXgDRUOfy//q1C9FeZPiiypLhggrpmW3BydjGDTu
	KM2imKQ==
X-Google-Smtp-Source: AGHT+IE3xpes1v/Uc0j4pgJbHyJYCsHa1apqosK00O3zWfydKbAfCY5SFFSiIVSJTroNQjdKlzcHSaGmBrZh
X-Received: from edrt5.prod.google.com ([2002:aa7:d4c5:0:b0:5cf:cc2d:7de4])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:40d3:b0:5d0:c8f4:d1d5
 with SMTP id 4fb4d7f45d1cf-5d10cb553f0mr1671471a12.12.1733222268055; Tue, 03
 Dec 2024 02:37:48 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:22 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-6-qperret@google.com>
Subject: [PATCH v2 05/18] KVM: arm64: Pass walk flags to kvm_pgtable_stage2_mkyoung
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

kvm_pgtable_stage2_mkyoung currently assumes that it is being called
from a 'shared' walker, which will not be true once called from pKVM.
To allow for the re-use of that function, make the walk flags one of
its parameters.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 4 +++-
 arch/arm64/kvm/hyp/pgtable.c         | 7 +++----
 arch/arm64/kvm/mmu.c                 | 3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index aab04097b505..38b7ec1c8614 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -669,13 +669,15 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
  * kvm_pgtable_stage2_mkyoung() - Set the access flag in a page-table entry.
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().
  * @addr:	Intermediate physical address to identify the page-table entry.
+ * @flags:	Flags to control the page-table walk (ex. a shared walk)
  *
  * The offset of @addr within a page is ignored.
  *
  * If there is a valid, leaf page-table entry used to translate @addr, then
  * set the access flag in that entry.
  */
-void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
+void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr,
+				enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_stage2_test_clear_young() - Test and optionally clear the access
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 40bd55966540..0470aedb4bf4 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1245,14 +1245,13 @@ int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
 					NULL, NULL, 0);
 }
 
-void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
+void kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr,
+				enum kvm_pgtable_walk_flags flags)
 {
 	int ret;
 
 	ret = stage2_update_leaf_attrs(pgt, addr, 1, KVM_PTE_LEAF_ATTR_LO_S2_AF, 0,
-				       NULL, NULL,
-				       KVM_PGTABLE_WALK_HANDLE_FAULT |
-				       KVM_PGTABLE_WALK_SHARED);
+				       NULL, NULL, flags);
 	if (!ret)
 		dsb(ishst);
 }
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c9d46ad57e52..a2339b76c826 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1718,13 +1718,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 /* Resolve the access fault by making the page young again. */
 static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 {
+	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED;
 	struct kvm_s2_mmu *mmu;
 
 	trace_kvm_access_fault(fault_ipa);
 
 	read_lock(&vcpu->kvm->mmu_lock);
 	mmu = vcpu->arch.hw_mmu;
-	kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa);
+	kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa, flags);
 	read_unlock(&vcpu->kvm->mmu_lock);
 }
 
-- 
2.47.0.338.g60cca15819-goog


