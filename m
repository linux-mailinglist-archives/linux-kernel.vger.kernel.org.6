Return-Path: <linux-kernel+bounces-538332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C66FA49740
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA923AA645
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BD625E81E;
	Fri, 28 Feb 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htEwiioE"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBEB26138F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738367; cv=none; b=LZOKZe9JIKfwdz+5BOK/nR1uxPRgYepTeX51BS4fFIO6tie4Xu3dQa62PHtyurAXNvBuBXW/tWxjq97IMdkDc+o+Wb4Z5IhwodhiUD01qboJ3Fe8LPSlXcdk5tW+ubXpqapwoAeJK/xM+WVBsybpxRoUbptmVNg/Y9dUI4w09xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738367; c=relaxed/simple;
	bh=c1CjUHd1LkuAdVuDk2RFGH/LeKa2cYSLQB9PFu9Lo1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IGNhOo0RGThqMhkTXoaP9G8yrNOTWRBoCF3IwZm9RKLVhNk1NRoXFTLR6eu859U4LK2ZyKfUmODcUb+U3cyj4/roOX62oMh4ECZAaaLduhK5hPawxK0eRIaA6xpF3G98zHBOyVOYhZWWSx5fiGFxsM6uFwF1AfH5opoo5VTW478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htEwiioE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4398ed35b10so10296435e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740738364; x=1741343164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ8YKtq6hiI77A4ivZTnaB9Ne+xlMbNHdkfYD+3eEfk=;
        b=htEwiioEqF9QBfSGEyH7Q8dcZRJZzlyR2pWQxKSAXFZjMMgYDZ7eLIsN+hpGwN4X+V
         SziZYnRMWubEbcwgoi+FDmflFdf9RUUTyTr6ifyrTeepcetTn9cwrnbBLqNwe07J006p
         5NYUluXswH/GmPlufvJF/1tEt6R9OXkDxGxMRBfSOiiD659IE7n2GsV564G/1TVaOOWR
         KC7uMhPbOXTxASo5pcCVdd+Uo8u2WDHV6LzVbcKJLmKA/j7vE0GIlIu1qLGi4GMApty7
         cjBpz9Jax5JU8b7DqGgc/YNw30XmN42z3kASNY2Ptmz0HqSa34W0QwSkGEetjfhtvQr4
         hBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738364; x=1741343164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ8YKtq6hiI77A4ivZTnaB9Ne+xlMbNHdkfYD+3eEfk=;
        b=W1QHpzdr7Y862PVFrLrAwAOftGM+2UR0kX0QYz9mfsTBpqCCG10wKqpUDsbhNob8SG
         djFciBI6Rvix+V8yUgLqup7dZwZtsx36t2oswF8zo9gWFxsyds3z3XC5u793OY9CEYnu
         r+jKBJOL0f3E9TgrCVb3KFYVeGP3VBrG2y0ImvRvtMfjTSDzXm/p9Tj0zIhq8mpH+hrP
         cue7gUvmYbGMFveNB26vDgkMY90fWUkV9hqbINeiVFXmFLO3wmzzLDW1BWWzaN/P3axn
         h2hPvZ7KLgXa9J1EvdgNARMY9Mmp3AdRRr02lWMP/3nl+R11Tn0FejFK2N6WPNcWWRjU
         58aA==
X-Forwarded-Encrypted: i=1; AJvYcCUEXrJIdvFEZYxQD/TNbMvrBdTgTUygz8cw1fgrzZRZR7hMyTy9Xp2QN4MGkpsAYHOBj1RkZVErx0s9rUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFC4rXCmIryykiMiXHdpeFXvK25RYw9LlHVxzmbZZp7Jmek2f7
	w9x2ELFb1SunFcfbjxD1tKMrsEXTQc8xfQk2P7QJ/pm7CCGhU3cP/O1/2ILa0yWhKOpPvNBC+30
	NzZdpHHk1WaWCs5xrKQ==
X-Google-Smtp-Source: AGHT+IF7RliymnqyVqI2LxMXafp0QAO3saYMD0WdzwsnhK9hIXHApQBnwQLte7rc3DZHMIaauPQxquwj982tRnHP
X-Received: from wmbfm22.prod.google.com ([2002:a05:600c:c16:b0:439:5636:735f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5123:b0:439:9274:81d0 with SMTP id 5b1f17b1804b1-43ba66da2a9mr17359265e9.1.1740738364175;
 Fri, 28 Feb 2025 02:26:04 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:25 +0000
In-Reply-To: <20250228102530.1229089-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228102530.1229089-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228102530.1229089-10-vdonnefort@google.com>
Subject: [PATCH 5/9] KVM: arm64: Add range to __pkvm_host_test_clear_young_guest()
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


