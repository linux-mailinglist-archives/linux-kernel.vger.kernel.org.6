Return-Path: <linux-kernel+bounces-548725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F7EA548A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E99172DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3038A20B209;
	Thu,  6 Mar 2025 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yrw5M/9G"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE120AF9C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258859; cv=none; b=jNu2W0S9WPA2IFpB6m1bVrooTrk6eRdWXJeRpvQIULQyhNXreBXVQzD5+6r1LmQOUaXa3eJ/AvTkHGBPo7BGjie6d3MVRSclnmuQ8UpexpFFJHS/sanVoS4fi9BREWCphSS42yod++y+X2MYJphtTw26J5NPqC+v3RD3otD93Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258859; c=relaxed/simple;
	bh=4GxbZZ8KDx9FpZt0envBnAfk7dVLQTyfBHEd21OXXd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K0bDEpNjMQRpmd6xwcJUJpOLWkq+c6ycW9sWWH9G1YbQJgPGJx7S5hYKJwgpMojT5DFu7SGJMwTWxojQrw0kv6VAYBu2oXgECwyYpcGESLy2bGXA6KV/IUc7euTvlBnJ6EmU8lAsdjo7IcLNJM8Y8h+HnRaFCgxhOatwfwHDnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yrw5M/9G; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-390eefb2913so372075f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741258856; x=1741863656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nY53fsjf1Gqi90zwwkjs/Ss31wicoUxN0lBzPVMQZ48=;
        b=yrw5M/9Gjb7N0u+uQGqqLjqn9KlwjQ08zFRjvLImHO2rqup5kysS+h0flP8rgwTZk5
         Ip4oVPPOLOM1/nSPJVAroti3dK46CW5zv+IfwruX3f1sFkHFImroM+7dOIdlwryt4/hX
         sPJDWpyTQ9NqRfGReyfVJaw5AYRphgR6zSPmZW8E7JB2UXGwz90k/m70JpRTSnP1nWkJ
         h5U72k3mhwoaArf5XHMbjCKV9OVBIQZ8qutHmjFy0hgcz0WxngXytZ3N6UIVY4rey+sM
         ExGtWtRuTvs6W7IidfS4wTwkx8yv7/FLH9xuMzfbq14+c7r2UKBd+Kv0mGoyC9Kj8MFf
         DGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258856; x=1741863656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nY53fsjf1Gqi90zwwkjs/Ss31wicoUxN0lBzPVMQZ48=;
        b=UhiaPr2/DHMpmEojNZNOfUdY9aPAwcTmmAPe/8TxFWz8MMKhe2etS7NP1R5pADJkAH
         Z3zwPew6ptShTSHs+9+GXPk81nRHxlCAeFB2ZRYVWwxOCJiIPZvbwGCP4eVkFwI9uyqb
         hQUvuqiIKMzkJHnRt2u+9AisQfxOZdO55t8+YefdbeEZ0UU9yIW8ovYBZe7pxfXaVzKS
         BR4X2CBurVS8MyVfCAbdLmd+QwUK4r6mNcgNq5tuJZE8G+q/z+ojcRnVtBsxlt/NSC2/
         HGMmpJju4xLXDNcPro6hLcf9WQzSwGEF0eatuYzuOI2OgU0Rx3ADa2DH+7RN2CRBFcOG
         0v9A==
X-Forwarded-Encrypted: i=1; AJvYcCWv7ZXOYxpjI311u7WRGXQH+38WHSCQxeOxJWZ8flQHz7zlUal0iJAWgjritWPbEmY9DdQtdi46gCKhBko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvjpLNd6nhKrtkxY2EKAqkr9101+hDzcDQ0dTm5Vv4NWROO9Fm
	qgXkEqmJ1EEW+kf83LZ79TxHx0Zs7PMCeV2tA/eITW+1VooMfvd57N/G8vMmA/TAm2cnJR7ZzRd
	7NI9oYk4sRYY7UJyRrQ==
X-Google-Smtp-Source: AGHT+IGmQeadGZM6t/fuvRDJiBZnTtGUTvo721CNjh1/3loduEsrkWUlmN6OyAD3MtikSnlm82gvqe/Rikhd5Zkg
X-Received: from wmbbh11.prod.google.com ([2002:a05:600c:3d0b:b0:43b:c0cf:b8e2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:59ae:0:b0:391:2995:5ef2 with SMTP id ffacd0b85a97d-3912995602cmr2172678f8f.37.1741258856189;
 Thu, 06 Mar 2025 03:00:56 -0800 (PST)
Date: Thu,  6 Mar 2025 11:00:34 +0000
In-Reply-To: <20250306110038.3733649-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250306110038.3733649-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306110038.3733649-6-vdonnefort@google.com>
Subject: [PATCH v2 5/9] KVM: arm64: Add a range to __pkvm_host_test_clear_young_guest()
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
index e113ece1b759..61bf26a911e6 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1124,17 +1124,21 @@ int __pkvm_host_wrprotect_guest(u64 gfn, u64 nr_pages, struct pkvm_hyp_vm *vm)
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


