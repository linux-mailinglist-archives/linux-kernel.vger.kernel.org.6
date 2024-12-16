Return-Path: <linux-kernel+bounces-447879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F159F3841
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD64818842A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8E206F27;
	Mon, 16 Dec 2024 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gxsCuUD"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF420B7EC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371899; cv=none; b=sIBarygE+nUAHjmYAOYDMIghYCC/VCF2yAGwUrxuAQFl4oJ2DDAVuB8HV1b5DLqFHYNmL/vx0rgqwhAYtfGmS5zL3gKGCqs/kdqPAqxHR/bxUOLPRGt48KZsy54ZNzd8Lc/2j3aBFOXanvxg57boO9B4y8fwqiC1cZwXCWFs9io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371899; c=relaxed/simple;
	bh=Es7cr26j70mP+64KpnhVcXIimoA87KfgbKi9ahJYCeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XxYSVSKF8qciICnIZdEkKZqvrvT2lvgBjovCuuncQ3O9UDSqyPdlNoMxqQdR+ZHggubb2t6QJo47/8Kt8M8HW/cc80wGtoQYwSbRH7/ALAjMLQlMPgPthJbri7qEX9ZV7orDJZPwbqG5XiHfwp8au3u67YMwXhE9s/YPSa6kzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gxsCuUD; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3fe991854so4648270a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371896; x=1734976696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMBJ8qv477+/KhCtyqixNk1hTPuipFTJvx4sNjSPhX0=;
        b=2gxsCuUDtOleiNFkCdcuiNTD8JyhGEAV4h430hdCbO8GuWXR45pfhlKz6YC6x+Zlin
         3AxuzB5uLHnwL31Ny8fRDOO/0o6u4HS5QvGgnXu2hDCwfAK7G61ew/+Dpd9VbtJjJbyf
         fMYgDACSUdjdIrpHbhyKRakCNSlkZwiXiKcxYr4MkFauVSs5RagYfmhxgOfYkHpmaXdV
         cU1UhybHzoi+UoLabAUWHOKdb4efM438noxgz2Tk3u7jsmwQT1OGlJI4TwGoHpnEqeJp
         3OBX3XhTpT0YkXdzzoig0KepK3vEbniaeYZI9//pBQStUj29TFDac0tTvGquDaGEZUxk
         gh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371896; x=1734976696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMBJ8qv477+/KhCtyqixNk1hTPuipFTJvx4sNjSPhX0=;
        b=UhDaXbU5En/xyTp8cNoHPrClzA/fbydAL6llFkVNb66ijyZ6exnhj5q/j1d1l9aUWj
         LrypdCecZNIHJUq3pvr5eZ/DqM26ufNboUD5OfoRGQUpxRAXlpV9B8o22XAyc+wOO59i
         +gBrhWdBEZKtbrdXfesp67ht9eNxTsQbLHEXQMkBlHcFQBe3yIrt8RXsBUEkmegcdyo7
         887yYFvo09OPUonghmjpQTqzCksc1EwhBBqGDQgYRKIO1OuVYI28pLcf+rNgJwvfrUB5
         HWQ7XcwQ/xgrmhjEXlwh7aVY/0so1aUWsntM20WqvA+3kS3hXzjFjXfhWk7brvQSKjSv
         vOqg==
X-Forwarded-Encrypted: i=1; AJvYcCUKetfbUJLjFJCN/3bYX5r1tdcVwgmeV/vMwdM3jUODILciu04CRNoAG0wlTfcCnvPhq6l0/Qm9RBKAbIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo30Kk1BhSBplFWzn2SxIIXsPw3jgI3miRBf0Dg+FR27il7sdI
	BSnomMloi1kG6IEI8MWelbTaU/BgU1KzSfIuSg6L2vH8muAKlXG0YNgfR/1eXvBj324a5v+G0bW
	SoohNdw==
X-Google-Smtp-Source: AGHT+IG78GpSrIyP8EQZsymolUELoZAfYkZfqZ5uAr74kYA6Of93xC43jJPtt/eSfM7J/zSOVAI94LqFwgRU
X-Received: from edber15.prod.google.com ([2002:a05:6402:448f:b0:5d6:3c96:bb82])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2695:b0:5cf:e71c:ff88
 with SMTP id 4fb4d7f45d1cf-5d7d4053910mr586302a12.4.1734371895963; Mon, 16
 Dec 2024 09:58:15 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:50 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-6-qperret@google.com>
Subject: [PATCH v3 05/18] KVM: arm64: Pass walk flags to kvm_pgtable_stage2_mkyoung
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
2.47.1.613.gc27f4b7a9f-goog


