Return-Path: <linux-kernel+bounces-447887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E229F384A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5690016CDA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC020E02B;
	Mon, 16 Dec 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3oIF6D3g"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907822080C5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371915; cv=none; b=mZyKo5kRV6V22sEaetRP93HDblaomxGIwgunoTTJdI+67eO9gv9VKvrxWOg1A9xN0RoA7A6/y5pMJcrMPS8RSwILZakoAqvFnwiNh0n34+hC42xOANjVN8tpb6zMKG/lu7XgSq26UhMl/JAOZUXhxNy2Sm5yQ5Ivf0RobV2xayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371915; c=relaxed/simple;
	bh=x7+FYuhLRSc4489GTUBhq7A0rSYck1JVWFO7Y19Rgzo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IUWeC/HtqRLeDAg4GqmObxUeTxv/+gDQv5G8HImvNgCW0KkPegnG+rD6vR7EphFlb9Ulwr1/L2ua4BjelIlyJTcWsPtZmWrEs7VHn87WXaL84cU6D2P02wKsSwuUR2+rLl1WColgV3GyJkrpSXDstN5edeuFygxtbUpjUrJ+w04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3oIF6D3g; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3e4e09ae7so5078536a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371912; x=1734976712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyP52yXMvdCG/qeO/nxD7I5lO2ep30nuHc1XdZd9lVE=;
        b=3oIF6D3goZZTEXbWSh0xRbQkbHAueUEFneQWrbYvRukbh3Yx7KkN/dEeml0RbbBVav
         ZrNGfjgg3hcIw06N43wfXwoJQxO381v2/znbUjvoIoHInfO+as/nhH9600Z/MB+v6hG/
         roUEK37wmhDrOnP9Owy26U+BByrSRvPEUQKba+qXHeAZpmSwYQhpPO/SInKqux6a6nLS
         L+uyKZVGzE+y9VMXZuZe9+QayK1gtr7HFV/kIjEcZcOaKu1dd9mjyS2fFtXEwC3/BKhO
         iun74XthlB6pmip1M6+rSOsT8Ez08B9mq13Y5KLKvUApEA097+/IDl9KwAbzQfkd3VPt
         rosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371912; x=1734976712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyP52yXMvdCG/qeO/nxD7I5lO2ep30nuHc1XdZd9lVE=;
        b=uIRBCRRW8Ya0GTWSK/sZ5W73ZDqW9bztbFhimbI2yqeR/gjYnkIIhdodd83ytQXg+Y
         2DBIwvu5vZiyLbQgHWBP6X0CSChEi5v7V2YGNKZdDZ3DIn8yXdzJsnDFr7mt3LvXCsd8
         OLkILOQyXTJOBcmCj07+10eLzJe+vpGrI0rTgAjYTRYQzjVWd1pCrGZhhOwj5Gro9mz2
         hA+Ph01oN2r3VMBeMUNN9hFTvWf/0cqjA7hyyIGvajE1yckQdwSaPby//QjP9ov1NEC/
         YlSmP8nB5b79O3NeTmOLvm1+WDpv3RAn/9ma9IPxrtiTs956LnagQldXfkJ8/0fD+eW2
         KWig==
X-Forwarded-Encrypted: i=1; AJvYcCW1rBtJVM88hgoqeUMhed0Jrsf3VAKXaXigmL6AEJB97whA/Te4dgBBBVx51oc9CtHutlu1GbdG5gGjLy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsvx+q8XJnjGVz7D2zw24cV/nJNG8c50LQnlp4ej7JBicnWMjU
	zSOkkBqjfZBeZs6zFNgITN1H+UfwpqlT3qSZqiwjyHiScAoAmK1YMkOzEymtfHWJydgOVIQEXTp
	OTtivyg==
X-Google-Smtp-Source: AGHT+IFP4nw4MedeF204ACC4I+mIvh9+F0wuQVKyEpLyYdXQPbpwYFvSWf+Gws8g2zlegmkHbaKOYI4g0Iku
X-Received: from edbek21.prod.google.com ([2002:a05:6402:3715:b0:5d6:570c:dae5])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5191:b0:5cf:bb9e:cca7
 with SMTP id 4fb4d7f45d1cf-5d63c3c0697mr13666506a12.28.1734371910915; Mon, 16
 Dec 2024 09:58:30 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:57 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-13-qperret@google.com>
Subject: [PATCH v3 12/18] KVM: arm64: Introduce __pkvm_host_relax_guest_perms()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a new hypercall allowing the host to relax the stage-2
permissions of mappings in a non-protected guest page-table. It will be
used later once we start allowing RO memslots and dirty logging.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 20 ++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 23 +++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 0b6c4d325134..66ee8542dcc9 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -67,6 +67,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_relax_perms_guest,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index e528a42ed60e..a308dcd3b5b8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -41,6 +41,7 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
 int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
+int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 3c3a27c985a2..287e4ee93ef2 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -264,6 +264,25 @@ static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) =  ret;
 }
 
+static void handle___pkvm_host_relax_perms_guest(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, gfn, host_ctxt, 1);
+	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 2);
+	struct pkvm_hyp_vcpu *hyp_vcpu;
+	int ret = -EINVAL;
+
+	if (!is_protected_kvm_enabled())
+		goto out;
+
+	hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
+	if (!hyp_vcpu || pkvm_hyp_vcpu_is_protected(hyp_vcpu))
+		goto out;
+
+	ret = __pkvm_host_relax_perms_guest(gfn, hyp_vcpu, prot);
+out:
+	cpu_reg(host_ctxt, 1) = ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -475,6 +494,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_unshare_hyp),
 	HANDLE_FUNC(__pkvm_host_share_guest),
 	HANDLE_FUNC(__pkvm_host_unshare_guest),
+	HANDLE_FUNC(__pkvm_host_relax_perms_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 30243b7922f1..aa8e0408aebb 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1488,3 +1488,26 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *vm)
 
 	return ret;
 }
+
+int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot)
+{
+	struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
+	u64 ipa = hyp_pfn_to_phys(gfn);
+	u64 phys;
+	int ret;
+
+	if (prot & ~KVM_PGTABLE_PROT_RWX)
+		return -EINVAL;
+
+	host_lock_component();
+	guest_lock_component(vm);
+
+	ret = __check_host_shared_guest(vm, &phys, ipa);
+	if (!ret)
+		ret = kvm_pgtable_stage2_relax_perms(&vm->pgt, ipa, prot, 0);
+
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.1.613.gc27f4b7a9f-goog


