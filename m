Return-Path: <linux-kernel+bounces-429260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114219E1BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E0EB44822
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670841E503C;
	Tue,  3 Dec 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqCi7kqo"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8911E5021
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222294; cv=none; b=NeMQUsTtUssA+ESbHFb3xln8FGJHJWrVyh+3FzOBxxhuTJ/9TrL4k/whRc81jdY9Lv0pxWubyv4xdW9RRsUXjJMGHWzGxzCTcwxkvd5xspJS6u5U1LTpeW6zZ9lt1+y8b3wj5U90LEEFz3gTZpfA0azbTRUQoYywGMPZAtfhcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222294; c=relaxed/simple;
	bh=C7bckg4iK+Kx8bfAXOZsZZOVRcvYB+OWUiAnJRxcvxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m7e/MYTJa0hczzvBUcYfnsGQE/8h6UgtdoUqdiREAGieWwRwMmkLDPqEx8gkQ9APJdXrYlFTQJzoGlLU08kSvWk1Q7WaoyVCYyDQCU73n35ZXylM890Ev4A/S3hLmyBYUiFYROFVH+fHypyan1ueZnhVFxYmytqymZxVQvtxUws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqCi7kqo; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa543b13532so307758566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222292; x=1733827092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYizfs5ugNIRCne9WipVM8NnIjcJOlVcRn/zTXEmfg0=;
        b=FqCi7kqolGHkqwv0LDYEM21bKw9bo4JB/b5U6aF1Xurcb3Psb+eVFJ1+Gd5fsCksVA
         6daf0XB14/8j7VFhWO1/PM1n6komwj/FHsFLX008v+sqxphzTshBelHtmBoI6wiaYelM
         pxM6fvO69yjSDZzwiycBEmpUJ73MIJXlBoiQd0prtXFRHjuRDqcrKUCuk/xqhOA+/5DH
         dY8APX7vSZV5Zh65ydniKYZWNZUr6UTUZJUCpgrvmNJY/luHKRglW1B1pHWWc0P/bjyY
         63nyeeP3TVrEEy9DFKY4rOQzRv07DiH1AP8px2xKn9x3b7CXnzL2mkZvhJPD/XXQCxpT
         6YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222292; x=1733827092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYizfs5ugNIRCne9WipVM8NnIjcJOlVcRn/zTXEmfg0=;
        b=f4Ts7ZP2sbe1jwae2RVACVkHZFqsdgVmIW6Sdp0oZEr1oVESNnpkU4WUofF5Qk/ZgM
         3aN5y1iXzD9nfKJijKi3eQidXdR2tZerzcABIRrGmcsNoe6UFjXngqfL1goRt4BOACrD
         wDq71bwYCYh0vPxAFCDHVqgKQx3KD9hz/3kgRj9qjYB+/EQ06dS5EhlXBCgsb7iA1nwf
         ONfqPU73OMZ5+nYCNRv1U/45eqwg6BAo+0JpfWybqHI0bSMpOzOoyyTNv0ctvkUdDZBP
         3LCSb/MbE996UXvDkuMN48kC5jevLQ2ffvvIcbSYw9iPbbWoZI+9nLQ7k1mq1O29H5Cc
         l1iA==
X-Forwarded-Encrypted: i=1; AJvYcCVMY8t+E7w8AjJCq0u3eOgrVRR7s6bHBIwDrqn38WOOlv4nOQEAcYuvYky1N2T7aYXs9lCLT5iHyncnukg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/u5HAxdVOCY5CathmUKuuoXHlmI1d7PawtFWpZlE+lE9erq/0
	4PRu8bBxm7U6iWozQVAA/flO1rG7EygDeIsZ79gPmhmgkzQ26n6teXuhiVK+UvlfbGEWyAut1c7
	ukRi8vw==
X-Google-Smtp-Source: AGHT+IHy5ejf0OiCrkEdWE2fH7ml0DEW+PK/xc+o7UbY9Xx9O7ZNOT6ubaPhP/xD9o/HpxIVzCb6WRgnDi57
X-Received: from edix21.prod.google.com ([2002:a50:d615:0:b0:5d0:a9a6:5abc])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7703:b0:aa5:1a75:dcd9
 with SMTP id a640c23a62f3a-aa5f7f1ad71mr161678366b.48.1733222291421; Tue, 03
 Dec 2024 02:38:11 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:33 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-17-qperret@google.com>
Subject: [PATCH v2 16/18] KVM: arm64: Introduce __pkvm_tlb_flush_vmid()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a new hypercall to flush the TLBs of non-protected guests. The
host kernel will be responsible for issuing this hypercall after changing
stage-2 permissions using the __pkvm_host_relax_guest_perms() or
__pkvm_host_wrprotect_guest() paths. This is left under the host's
responsibility for performance reasons.

Note however that the TLB maintenance for all *unmap* operations still
remains entirely under the hypervisor's responsibility for security
reasons -- an unmapped page may be donated to another entity, so a stale
TLB entry could be used to leak private data.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h   |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 6178e12a0dbc..df6237d0459c 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -87,6 +87,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
+	__KVM_HOST_SMCCC_FUNC___pkvm_tlb_flush_vmid,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index de0012a75827..219d7fb850ec 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -398,6 +398,22 @@ static void handle___kvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
 	__kvm_tlb_flush_vmid(kern_hyp_va(mmu));
 }
 
+static void handle___pkvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
+	struct pkvm_hyp_vm *hyp_vm;
+
+	if (!is_protected_kvm_enabled())
+		return;
+
+	hyp_vm = get_pkvm_hyp_vm(handle);
+	if (!hyp_vm)
+		return;
+
+	__kvm_tlb_flush_vmid(&hyp_vm->kvm.arch.mmu);
+	put_pkvm_hyp_vm(hyp_vm);
+}
+
 static void handle___kvm_flush_cpu_context(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_s2_mmu *, mmu, host_ctxt, 1);
@@ -582,6 +598,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_teardown_vm),
 	HANDLE_FUNC(__pkvm_vcpu_load),
 	HANDLE_FUNC(__pkvm_vcpu_put),
+	HANDLE_FUNC(__pkvm_tlb_flush_vmid),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
-- 
2.47.0.338.g60cca15819-goog


