Return-Path: <linux-kernel+bounces-447891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333429F385A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B34F18938BE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A653820FAA0;
	Mon, 16 Dec 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnmgLIUZ"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98E20E003
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371920; cv=none; b=VNa3SQGKg80It3FW6MuzkHjennB6bcf1Dk34LEpYQ6AD+LRqI7rE3/rzh3QUTK0h1+mDqVX/PpKhUlFiDJI1X581XFHG3awJNCljBBuWtNIl/Nr304+SXh+nX5YqI+BXzaDLxfjd66OpjAkcJyIIXCOrdmOmhpaO+O4jtchR3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371920; c=relaxed/simple;
	bh=rcoYPmb/53S8Gvor6OWXTcnIDC6gvecrrUk8ZXPefhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YqvxQrVXYnNDSezV84rEk5PajGnR2yTO4icgs0/F+2BJ20MHoEiuA9uj68TYB1ZT+7Cpq1KE0aSi3RQuNiVrgnZneMjdADAfkrJBY1OkwE5VpSXEaXiuO+u+a8GoGTFcFQw3DOQ5eCpJ7KQXwbSHwKa+UTgsCMpHxGca3bKtIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dnmgLIUZ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3e77fd3b3so5297636a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371915; x=1734976715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5r7yCnkAiK5kyLrxO0D/txvshFXcnr6nZkeqCQZICw=;
        b=dnmgLIUZpfWnzUEbr0UdNv5wWtDRGwPsz5OODmJ2N6xXLeeRjBr27v7HTsDCEF8cbV
         7O+OnN+zlJ0+1vMTJEJIkv4wPa3nMqLBzNasenGyQvOPk6SQViCw0pkD4X7wpzM49a/V
         mHOjnL6h/P4w2SL7EgzzVkEu0hPCQTqW1zBri+HpIoYxlZ7zuJay134yRKMTvaH/6O3n
         lB0N+6cDwKt+BVpp0V8maKGudynRI52KrIvnAbOPf3902SgClVpXZxRGmMQlB0I2Qmsh
         FJUEaSsDUggOTAf9Bn5sI9BLT2G11/piamYuRotFKoMq3Mz7LlMb6Tf+AdeCgiCjLKAV
         zwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371915; x=1734976715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5r7yCnkAiK5kyLrxO0D/txvshFXcnr6nZkeqCQZICw=;
        b=aPfqgo3oW/5De88Ch/Rq2WaNqrnZOeelHX/YpaWM43pRkJqek/YP+fB12p7SEx9Pd1
         5vUMmE91wAq9FvPpAwRcMZy9L1MCfid8sXpu1k++gxnUg0rHLbrD8aBEeqOh5490AmZ0
         vumZk+KJVtktefHBhc3ENKsowJF/F+04vBYbJLQV4WCTvAcwP3JRhOrpND3BbSUXDG5s
         lPMYOJjqyzOnt6yNEUxEJMwNSmYmROaGW/lee0USLxG0/MCNy6qW+W9rAhVc91necIzo
         9aODM0jaFGiGqMvaEEQaobwSbCKPq/RZWPHSpqnm2y0YvYd38w8qpDsD0NFil7oqvjU5
         9XYg==
X-Forwarded-Encrypted: i=1; AJvYcCVXZMqTmhsoyqVJlppueBIWhjiUnDiEMgcOxkmmqYHn3z99nqYAd2A32o/9KoXtpxJkA0MJih5Xemma/v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPSE99nESfz6T5IPb5H0DmNg7scchnIXfZaZuWUGEouza9s7J
	4Qmk928XyKIfRuM/sdehOP/wKY5TZ+Ff/JwEeuBxG505D8NWIitGgM7EAveayc03MyJRwv8m7bx
	qns63tQ==
X-Google-Smtp-Source: AGHT+IETu+O3p1iOBFO9EmhBHTULF9iIkYmes1FbMSi6hvoepqbMqPvqpSwnKmEI7JcKZIr1ZyErBddwlhp2
X-Received: from edbek12.prod.google.com ([2002:a05:6402:370c:b0:5d0:225b:ed39])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4584:b0:5d4:5e4:1555
 with SMTP id 4fb4d7f45d1cf-5d63c3200acmr13094867a12.19.1734371915059; Mon, 16
 Dec 2024 09:58:35 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:59 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-15-qperret@google.com>
Subject: [PATCH v3 14/18] KVM: arm64: Introduce __pkvm_host_test_clear_young_guest()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Plumb the kvm_stage2_test_clear_young() callback into pKVM for
non-protected guest. It will be later be called from MMU notifiers.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 22 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 19 ++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 8663a588cf34..4f97155d6323 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -69,6 +69,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_relax_perms_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_test_clear_young_guest,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index fc9fdd5b0a52..b3aaad150b3e 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -43,6 +43,7 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum k
 int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
 int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
+int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 98d317735107..616e172a9c48 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -303,6 +303,27 @@ static void handle___pkvm_host_wrprotect_guest(struct kvm_cpu_context *host_ctxt
 	cpu_reg(host_ctxt, 1) = ret;
 }
 
+static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
+	DECLARE_REG(u64, gfn, host_ctxt, 2);
+	DECLARE_REG(bool, mkold, host_ctxt, 3);
+	struct pkvm_hyp_vm *hyp_vm;
+	int ret = -EINVAL;
+
+	if (!is_protected_kvm_enabled())
+		goto out;
+
+	hyp_vm = get_np_pkvm_hyp_vm(handle);
+	if (!hyp_vm)
+		goto out;
+
+	ret = __pkvm_host_test_clear_young_guest(gfn, mkold, hyp_vm);
+	put_pkvm_hyp_vm(hyp_vm);
+out:
+	cpu_reg(host_ctxt, 1) = ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -516,6 +537,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_unshare_guest),
 	HANDLE_FUNC(__pkvm_host_relax_perms_guest),
 	HANDLE_FUNC(__pkvm_host_wrprotect_guest),
+	HANDLE_FUNC(__pkvm_host_test_clear_young_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 94e4251b5077..0e42c3baaf4b 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1530,3 +1530,22 @@ int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *vm)
 
 	return ret;
 }
+
+int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm)
+{
+	u64 ipa = hyp_pfn_to_phys(gfn);
+	u64 phys;
+	int ret;
+
+	host_lock_component();
+	guest_lock_component(vm);
+
+	ret = __check_host_shared_guest(vm, &phys, ipa);
+	if (!ret)
+		ret = kvm_pgtable_stage2_test_clear_young(&vm->pgt, ipa, PAGE_SIZE, mkold);
+
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.1.613.gc27f4b7a9f-goog


