Return-Path: <linux-kernel+bounces-538331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B2A49734
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA29F1883BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375F25FA3B;
	Fri, 28 Feb 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAkOl9c/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049225F7BE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738365; cv=none; b=PV+uZwlyxlIgvuchSgVE8y6bustW4282Rz8tfYZkZ3PvciwrFnqV3HlOIaKyA5fbvPDkbliG345fnN7oHtcz42YaWGQLsZaMX2+l0HAOg1QHl3S+dEcXlcnN6zv/fUp3uWqErlq4hW5sQdBBmgpMADYwzPub/QM+bIybP0Ch/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738365; c=relaxed/simple;
	bh=wBKVapIrznQwAOlM6sIqN9ynrRTg73Po2MAdoOcT1v0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RDSHMrITE9/vDUuC8ecX95LBqe3ozjzDCcziMWOjnFCu67R5gWP8pSG7dxufH9lPB/pDz+FkH6rP5huQ4EH/jHTWYqnNqKyBT99O7Zf+f5SsAIPxXgBTrBoJBYAlUSeWFPCh++EV9CrTYtvuON7pA1LbwKvUQWceC8/37CekBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nAkOl9c/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ab4563323so10528055e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740738362; x=1741343162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBFHvME4v7wAoT7habVFSIRXDLX0Fgacd+7YWwIrSSE=;
        b=nAkOl9c/Yv2mrDNpK2lJaB7Rc1SuMw7i8mxD7YoVxlk7YkTT1aqv8iYVfi0GmIqppA
         Y1Ga+92HFw2d7Q3aEeOgLREj0KOYRYkKk6jxeCkM6CeZTUmcDZ8lEsPM6Y4ijOOwmpmP
         RnRK7plpyPHq0M+++xFD9Z2yjrO9A4tncFmsFyesrFjB6fhvIAlz6ayz6b0+Q9py8SeF
         0UE9hsNTVyu8/UU08EvQdn3F1irjI3BU/759djbABwRnS+8IMKYLJtaY5ZlNe0Qp9K5j
         ue7IfsA6nLgoXR4ao8CG4FrNpXSww7XgaiXqlWtKEwb9m/9Ly/hqQt4Wy23ICNi15zvZ
         Ug/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738362; x=1741343162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBFHvME4v7wAoT7habVFSIRXDLX0Fgacd+7YWwIrSSE=;
        b=LOgr+wtE7Aoj7OyGazsYb7LpQXaZu2QlowbYB9MiI5ZP9O0eMkMMwbuilYIOIQZo33
         x4/JHZjypZeOPad7PQW7qBvUOPftRQG1Sr7itITrFgEf0MSpnvK4YPmK+X1Tg+rFySia
         xtnIoOLHnvCbtFa5jYk9hBYY8ZlkNdXpy2VGZEKwZVD+rKGQAsCEACkZdH5XGeaoavPX
         PAnYsHFwwS76xV5f7QQsu1bm+px/qllRQAcg0RikOxCmaknChrZNPKZi19pnyN492/p0
         amIrILHoZjwxI7H8H85Q3W98uLUWxBdliglqhQuwZP+8ShhuE3EnAZmdD7h9ojbnmT0H
         DO0g==
X-Forwarded-Encrypted: i=1; AJvYcCWgcMYiQurIHsU2TP6Le64OeHeJ6B78s4Kzez2TyCuwNdryj4pX7BsOS7YM3hdeiWAbHau/gQF9Lyp3hjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXpOkOxtVTdbMKbhMl7X/9TUSr3qYSEYETfg9zG3/NEYwLZVF
	1OGAeiHWsViJSG0o7FdvcJPlJFB0r6OpVdELOJZF6tdiyMuwHLmpEgeZf4DXB+ydk7rW19lVuAr
	pTxPViYbyFnTvPDlI4Q==
X-Google-Smtp-Source: AGHT+IEwHls1BLgdvt5KFxyshaKSutUV2RLW38Q+fbEdSBaFOyihQeFxU0qCKw+zxyowZaUN4jkoWQg3AuWNfSEu
X-Received: from wrbce9.prod.google.com ([2002:a5d:5e09:0:b0:390:e493:b594])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a8d:b0:38d:d0ca:fbd5 with SMTP id ffacd0b85a97d-390ec9bbc4cmr2282409f8f.22.1740738362092;
 Fri, 28 Feb 2025 02:26:02 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:24 +0000
In-Reply-To: <20250228102530.1229089-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228102530.1229089-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228102530.1229089-9-vdonnefort@google.com>
Subject: [PATCH 5/9] KVM: arm64: Add a range to __pkvm_host_test_clear_young_guest()
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for supporting stage-2 huge mappings for np-guest. Add a
nr_pages argument to the __pkvm_host_test_clear_young_guest hypercall.
This range supports only two values: 1 or PMD_SIZE / PAGE_SIZE (that is
512 on a 4K-pages system).

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index ad6131033114..0c88c92fc3a2 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -43,8 +43,8 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
 			    enum kvm_pgtable_prot prot);
 int __pkvm_host_unshare_guest(u64 gfn, u64 nr_pages, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
-int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
 int __pkvm_host_wrprotect_guest(u64 gfn, u64 nr_pages, struct pkvm_hyp_vm *hyp_vm);
+int __pkvm_host_test_clear_young_guest(u64 gfn, u64 nr_pages, bool mkold, struct pkvm_hyp_vm *vm);
 int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu);
 
 bool addr_is_memory(phys_addr_t phys);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index e13771a67827..a6353aacc36c 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -335,7 +335,8 @@ static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *ho
 {
 	DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
 	DECLARE_REG(u64, gfn, host_ctxt, 2);
-	DECLARE_REG(bool, mkold, host_ctxt, 3);
+	DECLARE_REG(u64, nr_pages, host_ctxt, 3);
+	DECLARE_REG(bool, mkold, host_ctxt, 4);
 	struct pkvm_hyp_vm *hyp_vm;
 	int ret = -EINVAL;
 
@@ -346,7 +347,7 @@ static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *ho
 	if (!hyp_vm)
 		goto out;
 
-	ret = __pkvm_host_test_clear_young_guest(gfn, mkold, hyp_vm);
+	ret = __pkvm_host_test_clear_young_guest(gfn, nr_pages, mkold, hyp_vm);
 	put_pkvm_hyp_vm(hyp_vm);
 out:
 	cpu_reg(host_ctxt, 1) = ret;
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index c273b9c46e11..25944d3f8203 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1110,17 +1110,21 @@ int __pkvm_host_wrprotect_guest(u64 gfn, u64 nr_pages, struct pkvm_hyp_vm *vm)
 	return ret;
 }
 
-int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm)
+int __pkvm_host_test_clear_young_guest(u64 gfn, u64 nr_pages, bool mkold, struct pkvm_hyp_vm *vm)
 {
-	u64 ipa = hyp_pfn_to_phys(gfn);
+	u64 size, ipa = hyp_pfn_to_phys(gfn);
 	int ret;
 
 	if (pkvm_hyp_vm_is_protected(vm))
 		return -EPERM;
 
-	assert_host_shared_guest(vm, ipa, PAGE_SIZE);
+	ret = __guest_check_transition_size(0, ipa, nr_pages, &size);
+	if (ret)
+		return ret;
+
+	assert_host_shared_guest(vm, ipa, size);
 	guest_lock_component(vm);
-	ret = kvm_pgtable_stage2_test_clear_young(&vm->pgt, ipa, PAGE_SIZE, mkold);
+	ret = kvm_pgtable_stage2_test_clear_young(&vm->pgt, ipa, size, mkold);
 	guest_unlock_component(vm);
 
 	return ret;
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 3ea92bb79e8c..2eb1cc30124e 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -434,7 +434,7 @@ bool pkvm_pgtable_stage2_test_clear_young(struct kvm_pgtable *pgt, u64 addr, u64
 	lockdep_assert_held(&kvm->mmu_lock);
 	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping)
 		young |= kvm_call_hyp_nvhe(__pkvm_host_test_clear_young_guest, handle, mapping->gfn,
-					   mkold);
+					   1, mkold);
 
 	return young;
 }
-- 
2.48.1.711.g2feabab25a-goog


