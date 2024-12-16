Return-Path: <linux-kernel+bounces-447888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D09F384C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5B216D64A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365620E30F;
	Mon, 16 Dec 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3o00qR5Y"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123120E018
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371917; cv=none; b=uveVEYxbBnPZqhh9py8iVNZDYQsLObcBe0VKZwQF03oKezO3EcoHn6Wxmtgi2EFTZokNKafDVHXZi4aWK2Pc+Hm/1ZR47P2OZUigZ1RXi6o1x0+hlblJ+o6XVqFwBeSTMd1SUwGx9/L0e189vhFurqdcGLiZl8ng3OK/wRjMmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371917; c=relaxed/simple;
	bh=OuhtjcErD0FcNX24WgQpNP6nBjfTyxTNub7mKvq3CIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDeAAPzJ0wGB4AfQkv64I+gz24bTQowlD3BM9O03eWz33ACSNvbNlgXDrFmj1Hs5AG++xyCPu+hQHKuUK/8b8mboeoySiErnXYn0wl99Uur3lMPH5wbbP9z13EFcjnSa4/WrRK34KbovP4wBveQrGwB5z9fjfkUCJ0PfyyZdhpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3o00qR5Y; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa683e90dd3so159668566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371914; x=1734976714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDq9DwaPgsqNr2tHpW+bdhvyfIZgJqiuY6uN4axqGiQ=;
        b=3o00qR5Yzua9+drxPnLbYDDFAtAOTNc5HrAq7IGPIXr8mxhlsfAxURF7MJcTVFTAJM
         BYObqDGfzpjhYcmFsDV3pJ5lBaj2YFBIaFrJXMmSHiGLTPEMKYQc0mBcwmjBw0S0bsS8
         zFlBg3XU6Rl1TQIlRCsVBynPtztL9oS7YsaexCJ/pQp86gG/YoZa5RAla8k7ph/odLuf
         MxlAYUkuSxkqn+mbYG5PlnkQ8LMANCAQNxcaUUkj1GCqxVHH4v6eAI6QwooxU0v98RiI
         lESxNJWuzoFBJpoNsZ0CCi1XibBcX1T4CobzH4sbgw6qlUYOAXWtM6qbCGMHoYNI7ACP
         3gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371914; x=1734976714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDq9DwaPgsqNr2tHpW+bdhvyfIZgJqiuY6uN4axqGiQ=;
        b=QJ66fYzf/Ka8QyV5JRQGPRb63z5IoYTtejw34Y2GDGioupd10PjMZal0/oHS53WTh6
         7YuOqEaFP64flOwSVcbMdbJq2VeMqGwTstp+FptsGs9M9YtZk+Kl7kH7aFKsQ0p9bKHv
         nXIPZrZqO7uF+FXCcgp5r0U4Mky8ZUWiwcDZwOT+n7xL/6qNueFksWViPCOqpGy8W5Sf
         A7rbdEe54ghfBtYb5LKTxoRD+hLmzKQ5cc6E++GeRjnc0MPnY4T4XwXhMfBaDdsvwwjP
         Pedc6XLKJdU8e25dYclbNaUg77g8ZBUxsuWFDPqAvhmtanCqpyrEAtCxZnbELuWkwFvr
         YFvw==
X-Forwarded-Encrypted: i=1; AJvYcCWt6XR9EEg7aDuIxkzArUi/oup58K+do4SAj6HzFZvqd8Ac89K4t6pucj49VceiYLykaWNfMJt4ztdemZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1b01UJiKL+zGvX0q0XmikGk1I9TL69bDjG9ACV6CI5PP91FU4
	eBK+3VMsE7YZ7ZgnttUIXa7sZE+e0ZZKheL/scOTNQln9nOeKC6W0HIx61kJ7h1M8ocokOXrjme
	A8CVdtQ==
X-Google-Smtp-Source: AGHT+IHI3UoYT3X+iYsCFbInDPhwRbeEU1+XXddDdVe8vSqsWTG70vyDHz/YcjLxXIwMarrVkYcdz5XXC6so
X-Received: from edaq23.prod.google.com ([2002:a05:6402:2497:b0:5d1:229d:1ee5])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:311a:b0:aab:70d3:af43
 with SMTP id a640c23a62f3a-aab779aae4cmr1377079866b.27.1734371912986; Mon, 16
 Dec 2024 09:58:32 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:58 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-14-qperret@google.com>
Subject: [PATCH v3 13/18] KVM: arm64: Introduce __pkvm_host_wrprotect_guest()
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a new hypercall to remove the write permission from a
non-protected guest stage-2 mapping. This will be used for e.g. enabling
dirty logging.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |  1 +
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 21 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 19 +++++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 66ee8542dcc9..8663a588cf34 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -68,6 +68,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_relax_perms_guest,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
 	__KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
 	__KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
 	__KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index a308dcd3b5b8..fc9fdd5b0a52 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -42,6 +42,7 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
 int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
+int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
 
 bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 287e4ee93ef2..98d317735107 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -283,6 +283,26 @@ static void handle___pkvm_host_relax_perms_guest(struct kvm_cpu_context *host_ct
 	cpu_reg(host_ctxt, 1) = ret;
 }
 
+static void handle___pkvm_host_wrprotect_guest(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
+	DECLARE_REG(u64, gfn, host_ctxt, 2);
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
+	ret = __pkvm_host_wrprotect_guest(gfn, hyp_vm);
+	put_pkvm_hyp_vm(hyp_vm);
+out:
+	cpu_reg(host_ctxt, 1) = ret;
+}
+
 static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
@@ -495,6 +515,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_share_guest),
 	HANDLE_FUNC(__pkvm_host_unshare_guest),
 	HANDLE_FUNC(__pkvm_host_relax_perms_guest),
+	HANDLE_FUNC(__pkvm_host_wrprotect_guest),
 	HANDLE_FUNC(__kvm_adjust_pc),
 	HANDLE_FUNC(__kvm_vcpu_run),
 	HANDLE_FUNC(__kvm_flush_vm_context),
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index aa8e0408aebb..94e4251b5077 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -1511,3 +1511,22 @@ int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_
 
 	return ret;
 }
+
+int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *vm)
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
+		ret = kvm_pgtable_stage2_wrprotect(&vm->pgt, ipa, PAGE_SIZE);
+
+	guest_unlock_component(vm);
+	host_unlock_component();
+
+	return ret;
+}
-- 
2.47.1.613.gc27f4b7a9f-goog


