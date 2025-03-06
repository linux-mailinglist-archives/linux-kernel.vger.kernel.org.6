Return-Path: <linux-kernel+bounces-548724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF1DA548A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B6F3ABAB0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044F120B1E3;
	Thu,  6 Mar 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdfBfBBN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BEE20AF64
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258857; cv=none; b=C0V1DDcXIYmc94k3XGr2tb/7UzM9F8M7YNEZwLouhXvvexp/LE7pwty4tBhsEqdKI5g1LpIHEQxDcx3vq2CM1mUuI87rwcbqPIHeS5Q04YzpClMl3V69+N6sUmrOBJupXQQhRJ9lEs12FvHo+Iw00CxPclbk2gQRzYPuZ5Zv1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258857; c=relaxed/simple;
	bh=I0XY+A2V0Q5w7oHyDeXZMWplb/dvx/ssTKzTKtfDPnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xg8sJxVDU46fS/dyaflJXv9+yQYDhzry/u9rxkg2nVG5atO7BQ0uiHNqNunT2EfgslMppDDQXuSQ56NpKVjE0zKYNClD/tMkwa56UjQsVZkFFboyrsU6wEGRXuCmdyTyhxzXQV4DSBGfu0tNkx+s8rQUi6lpExtUrSz0L7yQ48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdfBfBBN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43935e09897so3508205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741258854; x=1741863654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SUHezARLgNy4M/thAGHMxOGZWlACt+jxmQ+nWznSE4=;
        b=sdfBfBBNlazthcrgsTvcLwKzbqP/e3ZaomupRGZxCj1Ny/4KXwH0U/cHZZpQffbJ6i
         JIIOfTuP851mJk6cvhKRMCOeayU95im4y8yN708TlXyBHTeGs+ABDjf3lG0c2NSKGvLz
         MwKy08NYD3TLYL1i+z5UfBhmocY80Fq2PSfN5U1S2jyJZkLNX6IFo1e6ozA+Sa3stCQT
         6TBfMhc5dY0LHBT9CLlgaOMtT5LK81VF3tO5hG8DiA6BWLAUyHAFl1TX+w5V/G0xYZkL
         u5Dal7Ji+i2Jj9x1ztdpF8u0sI4c3QhKQhwK1T3kBGCY1xIGADTPbqzl71Ktq99YyvnM
         mwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258854; x=1741863654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SUHezARLgNy4M/thAGHMxOGZWlACt+jxmQ+nWznSE4=;
        b=ojDzZPdirGnitl6qH0Hx1Qvsfyvg3WgZNDXlA7PI7YUl9KT6tLNpXLHrp+D22rye1Z
         FUB7fbSzxRCvrcHSrftNBHoNa6+AhPy2NsNhXvmP2leL/zqo5RvJyH/1djAHOEReNld9
         xDwdFjIjTzKGvDN9xXaPbKfaK+5Q7fS3ldhre+WYIO7R/amqvMZ3999buQzajw6R9Uic
         Nky/dTW87VB86IlPuw+vIo1VuC9+vRxDOMftgNhLwmqqx2ulq7UxiVzTiMmQidtyj84+
         VrY0JpipSQEVIHWHA4hNv8dQY3ljBXMzScrwrq2HYTIkHz1tlW3LDDM+zE7vtBlRueqe
         19UA==
X-Forwarded-Encrypted: i=1; AJvYcCUtjIyFRXANiV7M/thAipn0iERt33/YuhMd7uowy0hMaO3Q7nqpL3phjN84G6BRr92BZuRG+z42gS9x56Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsngcX3TAd1uX8l4ZUIcDJFM+uULSYCb4C3Dw2a8Dujv0mIo4J
	YjfiKCOQe8Y/FjWiyQU0vWmnvmfTytb7LEYgNF2CCQKiOdtcTXLSG0vQIdDIlKnfOrhpj5y11I7
	+zRsSOmy+V8An9WaSJg==
X-Google-Smtp-Source: AGHT+IF6cBYpJoNeFh9z8abT4JT8Lu/iLr3ILSFRx27w0PV32EPVnLrrgtC4Mtm0Y1G3MzlzdEBEE6shWor6mMCw
X-Received: from wmqb9.prod.google.com ([2002:a05:600c:4e09:b0:43b:d42e:35b9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fd0:b0:439:6118:c188 with SMTP id 5b1f17b1804b1-43bd2adab55mr51000745e9.19.1741258853873;
 Thu, 06 Mar 2025 03:00:53 -0800 (PST)
Date: Thu,  6 Mar 2025 11:00:33 +0000
In-Reply-To: <20250306110038.3733649-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250306110038.3733649-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306110038.3733649-5-vdonnefort@google.com>
Subject: [PATCH v2 4/9] KVM: arm64: Add a range to __pkvm_host_wrprotect_guest()
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for supporting stage-2 huge mappings for np-guest. Add a
nr_pages argument to the __pkvm_host_wrprotect_guest hypercall. This
range supports only two values: 1 or PMD_SIZE / PAGE_SIZE (that is 512
on a 4K-pages system).

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 343569e4bdeb..ad6131033114 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -43,8 +43,8 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, u64 nr_pages, struct pkvm_hyp_vcpu
 			    enum kvm_pgtable_prot prot);
 int __pkvm_host_unshare_guest(u64 gfn, u64 nr_pages, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
-int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
+int __pkvm_host_wrprotect_guest(u64 gfn, u64 nr_pages, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu);
 
 bool addr_is_memory(phys_addr_t phys);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 7f22d104c1f1..e13771a67827 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -314,6 +314,7 @@ static void handle___pkvm_host_wrprotect_guest(struct kvm_cpu_context *host_ctxt
 {
 	DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
 	DECLARE_REG(u64, gfn, host_ctxt, 2);
+	DECLARE_REG(u64, nr_pages, host_ctxt, 3);
 	struct pkvm_hyp_vm *hyp_vm;
 	int ret = -EINVAL;
 
@@ -324,7 +325,7 @@ static void handle___pkvm_host_wrprotect_guest(struct kvm_cpu_context *host_ctxt
 	if (!hyp_vm)
 		goto out;
 
-	ret = __pkvm_host_wrprotect_guest(gfn, hyp_vm);
+	ret = __pkvm_host_wrprotect_guest(gfn, nr_pages, hyp_vm);
 	put_pkvm_hyp_vm(hyp_vm);
 out:
 	cpu_reg(host_ctxt, 1) = ret;
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 7b9b112e3ebf..e113ece1b759 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1065,7 +1065,7 @@ int __pkvm_host_unshare_guest(u64 gfn, u64 nr_pages, struct pkvm_hyp_vm *vm)
 	return ret;
 }
 
-static void assert_host_shared_guest(struct pkvm_hyp_vm *vm, u64 ipa)
+static void assert_host_shared_guest(struct pkvm_hyp_vm *vm, u64 ipa, u64 size)
 {
 	u64 phys;
 	int ret;
@@ -1076,7 +1076,7 @@ static void assert_host_shared_guest(struct pkvm_hyp_vm *vm, u64 ipa)
 	host_lock_component();
 	guest_lock_component(vm);
 
-	ret = __check_host_shared_guest(vm, &phys, ipa, PAGE_SIZE);
+	ret = __check_host_shared_guest(vm, &phys, ipa, size);
 
 	guest_unlock_component(vm);
 	host_unlock_component();
@@ -1096,7 +1096,7 @@ int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_
 	if (prot & ~KVM_PGTABLE_PROT_RWX)
 		return -EINVAL;
 
-	assert_host_shared_guest(vm, ipa);
+	assert_host_shared_guest(vm, ipa, PAGE_SIZE);
 	guest_lock_component(vm);
 	ret = kvm_pgtable_stage2_relax_perms(&vm->pgt, ipa, prot, 0);
 	guest_unlock_component(vm);
@@ -1104,17 +1104,21 @@ int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_
 	return ret;
 }
 
-int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *vm)
+int __pkvm_host_wrprotect_guest(u64 gfn, u64 nr_pages, struct pkvm_hyp_vm *vm)
 {
-	u64 ipa = hyp_pfn_to_phys(gfn);
+	u64 size, ipa = hyp_pfn_to_phys(gfn);
 	int ret;
 
 	if (pkvm_hyp_vm_is_protected(vm))
 		return -EPERM;
 
-	assert_host_shared_guest(vm, ipa);
+	ret = __guest_check_transition_size(0, ipa, nr_pages, &size);
+	if (ret)
+		return ret;
+
+	assert_host_shared_guest(vm, ipa, size);
 	guest_lock_component(vm);
-	ret = kvm_pgtable_stage2_wrprotect(&vm->pgt, ipa, PAGE_SIZE);
+	ret = kvm_pgtable_stage2_wrprotect(&vm->pgt, ipa, size);
 	guest_unlock_component(vm);
 
 	return ret;
@@ -1128,7 +1132,7 @@ int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *
 	if (pkvm_hyp_vm_is_protected(vm))
 		return -EPERM;
 
-	assert_host_shared_guest(vm, ipa);
+	assert_host_shared_guest(vm, ipa, PAGE_SIZE);
 	guest_lock_component(vm);
 	ret = kvm_pgtable_stage2_test_clear_young(&vm->pgt, ipa, PAGE_SIZE, mkold);
 	guest_unlock_component(vm);
@@ -1144,7 +1148,7 @@ int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu)
 	if (pkvm_hyp_vm_is_protected(vm))
 		return -EPERM;
 
-	assert_host_shared_guest(vm, ipa);
+	assert_host_shared_guest(vm, ipa, PAGE_SIZE);
 	guest_lock_component(vm);
 	kvm_pgtable_stage2_mkyoung(&vm->pgt, ipa, 0);
 	guest_unlock_component(vm);
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index b65fcf245fc9..3ea92bb79e8c 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -404,7 +404,7 @@ int pkvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
 
 	lockdep_assert_held(&kvm->mmu_lock);
 	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping) {
-		ret = kvm_call_hyp_nvhe(__pkvm_host_wrprotect_guest, handle, mapping->gfn);
+		ret = kvm_call_hyp_nvhe(__pkvm_host_wrprotect_guest, handle, mapping->gfn, 1);
 		if (WARN_ON(ret))
 			break;
 	}
-- 
2.48.1.711.g2feabab25a-goog


