Return-Path: <linux-kernel+bounces-429250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DC39E197E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05911161B7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB991E32DD;
	Tue,  3 Dec 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34+nst4r"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EE1E32BA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222273; cv=none; b=psQUPhnGKT0bXVpNB1TTnb0KxRz/UdYl8TzvnTNrlU8ksrVcmI/Wa8tPBom6y4VxX3mGNNg1Qk9/iDB+hzocS/xiGYKF7+fsgVSBTCj9JcuIFFhDUGxYgt1EpyE28FfAfBDtw0sS5XagthGWWD/cTdWgBbuCHsuGEc+QMmc9k1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222273; c=relaxed/simple;
	bh=XksbjYbcE1NqtMF0vk/s2rTUbbEHjEBgtZwZqvpH3DE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FyaKop7/ZOctwLgTykUfw3c7jzXSaU5MOLSuiFlsq7PQYiHmeV7PNYa7F2brxapeCHRvTniX3UviYJEP60K2xuYxwFVABn+SPbu03hakLXI+hIhji9XgNi9NueJsFifyDOUaeiSMHQ+xhEdKg0MLKcWBhYW8vGjnnbUiQ8Ai7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34+nst4r; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d0d186962fso2045822a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222270; x=1733827070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+RnTOcmNRxXwhtm+wQBKlKgN7Eb65VjOuEvF6hfgqY=;
        b=34+nst4rNdzc5iSIfEqM1ovAJXOO1jjrDCucF5I/0rsA+Y5WTtwqi0dqozbwxEXCEd
         0cmW1PJo/B6s8nWUXpMqeck9D8dNAq/3WFl0P2iVuJ4zM+NpAW33+nnsir3pLNtLhlog
         xlpyMAhIjpCsi+1zlNnPy23gQSTeFZ5HW12g2H8/+qy/1cW71kp7JI6DFj9upH//vH/e
         hYhOcE9O2fXQ3gOm6NAT9NTq+OPWa58nWfyyaiaA5fEfWYIgb7LinhBg19xlclhqUNXY
         f6XIBnIpmSo/Rv/7zjXmupiufp5oWRKitgRSt+G0ybjT+CtMvQk3yz1o0sEsXWSA9IlK
         bu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222270; x=1733827070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+RnTOcmNRxXwhtm+wQBKlKgN7Eb65VjOuEvF6hfgqY=;
        b=KYPy7Rtd5V6lK77LXOZiYKaaoSItM4mMWzfBHTErLNyt18nvuAEXxIMtWyyEIX0fUf
         inzg2pTU5LXHxaNzPNp7msTeeufNIQ+nMGg+Dtt/odnmjhdQ+0JR4SJQfpQvaAO/1V25
         bTfthTUp8g/WLCS0nnuNHwgSjDAJ2K+ldBLANnY1nMgY/yel+KT8/TZAWOP6hiqRe3xk
         JRXl4rnWmzNxI1PP+WL/P2ZQqFbuI5RdAY6++qOdpmrVZ2J4TGh1o5KGmNBAplDGhHFh
         sklYLM9fQuBtAB/ArUHfKLPVVdn2Das16FY1DxCMJpe30neePHR6rlZ6KcLRvPDpRzQr
         7LYg==
X-Forwarded-Encrypted: i=1; AJvYcCVhOLh+tN18CdwNllgvlzS4+tCNaRJ+8S/ZM15aqJaNoVNTQhWMEDocDQw2CFGuAn3CkGlDuarWegLUT3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0L0Ht9Jskl6W+yvHaxkyNgYp1HxbBaAcSRnGdcjGvPueSgaLH
	BBIKVkRqUVTwC0X1xnxShumWdnoQdGmpHpokaww+tq2vcZfx/fip9z8p73uzr/soXf07J0zSLPB
	CfqtLwQ==
X-Google-Smtp-Source: AGHT+IEkCh4976H9zoeMRqzwAu1itMZtieMRxRM0H0hSSBC62K8xa96o6pizViFqZkrAm2FM/BgncFwuslk8
X-Received: from edrm26.prod.google.com ([2002:aa7:d35a:0:b0:5cd:564f:2e8c])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:b73:b0:5d1:11b6:2246
 with SMTP id 4fb4d7f45d1cf-5d111b624b2mr138127a12.32.1733222270207; Tue, 03
 Dec 2024 02:37:50 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:23 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-7-qperret@google.com>
Subject: [PATCH v2 06/18] KVM: arm64: Pass walk flags to kvm_pgtable_stage2_relax_perms
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
2.47.0.338.g60cca15819-goog


