Return-Path: <linux-kernel+bounces-447893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC5F9F385F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148AE18946DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A723211495;
	Mon, 16 Dec 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zXVX60f"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4EB20FAA7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371922; cv=none; b=dsjSIKOxE0/n2txf0ChXRg+67DAVcCpg2Mn3bWpijgCJf9+4vTVuqURxsL60/MyKqx+Mq2j9MO3WJ2KKRLzV8SH7mVvk766vRFeXVFoOKgD8sZcj82Uvf2MApqnPKdFxZLZTDayb0rQHm5v814MKIZMvcq277+Glg6n6gaM0dTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371922; c=relaxed/simple;
	bh=S5C7PA49mbBbYP0VC8WHfs83VKenKobir8rsTzZpXTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kPij2P5WuBLsgQVmKIPl+AtpQVbOZGlk0ve8+q6BZdehf06IqKB+1qZmaZMMrwSst+tlZKOMt/0yAtf5sj3F5guQjmYzmNY+B6PKfW0uTQJ4y9gUbsZp4N/TlUarG6upuEXpeu/WQekS30sTEqoOY7GH+3Dkrw9rVjjW7w8HBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zXVX60f; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3cef3ed56so3931308a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371919; x=1734976719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLkxU7WF3J5Qh0Edw4/qg3eGiYkLZ2iXz4JSY5pi8io=;
        b=0zXVX60fzBTtnMLd4lvPJroPPfiIpJb6ZD6zMOphw5jhPpPeJH5de+O8tUq1UQawIr
         ZOpR0HuiGKv7pVf2lShNBk0eFVvQ6DL8eaJCQ/S0xjxn51BHuNV46ahYp/p6kTt7zJ04
         EBHs8/z5CaEFOWl70mi7R0fJ179Hcw1HdgLGH2Injf1a4qrbJGo+lipHKO7gezslFMi0
         Ji75ywrbp4wKUpXxdP+EVCxxhpjDDJWPyGOX6mybDjnFXtKMWMs+Dl9wvQFmcuUNFelc
         h1FepcWTja/MOWxkYoKVR3gFDC196d0umWC/WBcFDkYkFnyxqQcUEsDepxpl21+Do42Q
         dUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371919; x=1734976719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLkxU7WF3J5Qh0Edw4/qg3eGiYkLZ2iXz4JSY5pi8io=;
        b=gnuv4ZG0w2oDAZbiVag6+ZzZYMWst8msM229myYrEBO3XURa1naaDadFvvgW2UOwaD
         Pg7iaDQBazRiSOzWBoAoJhE/YtqhDJQdBOibEWe/S44ZE02mi2xWqBSBlqzNsZR8zE2a
         RAK8wcVG0+aDwC1rjpa845Grz0RpwHlhT2M9hepMzSPMIWM8w8q0f3trEzzJp1LSx4Da
         Os5YkjTFvMcEcDIQQ8Vx/lg91poi7cHB5UJOeGyh4uxLr/C45mA0S5WwKlrrJ/DqRzkR
         /SEIL1mBHY2WoHq5o5QAkJ3gots5nXA7lyGY+kysh00UEk9hSna666CPVyfwYomhbIrW
         bIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8coiq0/udkr8fPXaFHfPBnW2r3w6ZLKlQwUvgT7SHrdrYpugggTFEOd7Kiz3iUt/ZUmQgLkC1yqCb0oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEU+/oDzUsaaUUjASCi0NsrO8m+Mz9CvxGBwG7iZNa3/cmMSBh
	PbUQ3sAninooZVLDuMVyYFmc43lHB747f97zja+xH8B2TnD2wNRaaJINXLvEOJPYNK+zqt/31zz
	gCmgTqQ==
X-Google-Smtp-Source: AGHT+IGbIEoG5vbn6iQy08UEUu36i7r1jxdCnom039llyQo30KhKhUU2a+YhuuCdj1YaRdinsIVQTfjkxghQ
X-Received: from edvu14.prod.google.com ([2002:a05:6402:110e:b0:5cf:ca3f:365])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2807:b0:5d0:d610:caa2
 with SMTP id 4fb4d7f45d1cf-5d63c3ad29cmr12773175a12.26.1734371919408; Mon, 16
 Dec 2024 09:58:39 -0800 (PST)
Date: Mon, 16 Dec 2024 17:58:01 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-17-qperret@google.com>
Subject: [PATCH v3 16/18] KVM: arm64: Introduce __pkvm_tlb_flush_vmid()
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
index a3b07db2776c..002088c6e297 100644
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
index 32c4627b5b5b..130f5f23bcb5 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -389,6 +389,22 @@ static void handle___kvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
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
+	hyp_vm = get_np_pkvm_hyp_vm(handle);
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
@@ -573,6 +589,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_teardown_vm),
 	HANDLE_FUNC(__pkvm_vcpu_load),
 	HANDLE_FUNC(__pkvm_vcpu_put),
+	HANDLE_FUNC(__pkvm_tlb_flush_vmid),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
-- 
2.47.1.613.gc27f4b7a9f-goog


