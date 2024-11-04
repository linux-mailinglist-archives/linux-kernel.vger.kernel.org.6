Return-Path: <linux-kernel+bounces-394940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF659BB640
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867B71F21073
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781B21C1ADE;
	Mon,  4 Nov 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4LwWZFcW"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8F1C1ABC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727169; cv=none; b=sHvYuODnFm0zBG6oP6NJCuc+M8SSKHGhbLXCZHBkZjDRvwLE4bhCOUjnbtglZSbTxoBFH5JT2iqnNAsfn3A46YQ+F6bWb7iLcHy65SzVLVcfZBvjIo66PjeyqI3sgy3Yu9t8M/iwxfLcsvrh7+TsfQvF0/l0Ce3GsEyFLee5yZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727169; c=relaxed/simple;
	bh=ku4yYhSRmdVla3VIfq3sTP3ec1Je+nU+DhLa+IVQGS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiRhEgZ/dBQvFdTW5dthzg6gXabzKrVXlP9H3A0kGtHZnF0ob7zV1mQE71SAujtVBU2k+Yj6wolRCNPENBqKxY3xwcmAtsMz61+S0d/nzDW9I5SpSgNUgeIpiUku260Yqanyc5Ylyzqb4A1Jih5dqqpDUjetjGdCp2TvR6cEdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4LwWZFcW; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a9a2ae49a32so344705466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727166; x=1731331966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YA9nOaF/CPva03eUOIXNUH1DNhxgj/qlCLjHWmvoHj8=;
        b=4LwWZFcWGDklkcXPwDrwsjyUFVnLn7spg/O6QJCfYhcvyb5BfPV0O9J9MF20G4+FQj
         XhZ7G+b7uMyJDPhb7CN4/QWLDjwHg+wgFmdXlrlPLgdn/C5JUROp2DFJcIXa96EixYMv
         ufi7E8UkdlFVimkTeMX9h7tqiCS8W2T4hWTj5Mlg/xbeaXONzw/IBFbqY2lhvXl1pmh6
         510jJNQUddjzciJXElmO1obQvdm+NCn1U/Pe8flJ64YJLoorOni8I0PeuRN0heeRVJG/
         WEwRk8Td1m36dbFIfeUgWkvcbWVlDVxsQza5ojngkT9SvNR+sWeX9N7jsLCs8rp9LONJ
         kCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727166; x=1731331966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YA9nOaF/CPva03eUOIXNUH1DNhxgj/qlCLjHWmvoHj8=;
        b=j6imrcM6ZzC+SVNmKRn97ATqhLUPn2iB+JYPvJSKZyad8fkgmQZjk8nsvBDSljvh3R
         Tq/lX5r6EAvwfWbXKga48h4m6AM8wxVMA4tVRafmwpxJwhJvUv8ZKdMd69I4Yrn+HAYA
         73dMEbYS2XnBObhmE3wO51wnM01G+RjmDoB0WQBwBR0i6sDO4XH8mO/zC5Siln0nLAEZ
         WUzykKumc4UgIF1fdVPm/DtmRVg72WeKreiSVbziov2Gu70AWgLrZExfV9VGShUzZOTq
         lCt2ZFGYnVG8WpqJa1pjxlzx8Ub+P4CeECUpKFQgwJRk3gZcqvlqf2xQvsMYuZaVmkU+
         7o1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhb/smlZskzjmdRYFFHk70pwVOtpkBoAKYT5ym4dpz+u9PW0DzRlojUSXYymZktZOzwh8bHgTrhHVsQwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYtjhBEKL9EnKvRaT+Fo9gnmYYP3BblRiDep9eKxoyRsjeA8zQ
	qw5xOIiJaXepMbZWYM83VClzr6kgN+F7b3r6QWMzFVsftYJ79BvJ7t1EQFPIMK4SnBtYME3tOeL
	x2d1q7g==
X-Google-Smtp-Source: AGHT+IHKDJEbkEfKj/R2W9nSJpi/mLwlZYh9Ih88dIXHNCkRftaPK88SGfUQc4OzczUSSCQEg5KywaFPE6uv
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a17:906:c20a:b0:a99:fa8a:9772 with SMTP id
 a640c23a62f3a-a9e50868dd1mr396366b.2.1730727166509; Mon, 04 Nov 2024 05:32:46
 -0800 (PST)
Date: Mon,  4 Nov 2024 13:32:02 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-17-qperret@google.com>
Subject: [PATCH 16/18] KVM: arm64: Introduce __pkvm_tlb_flush_vmid()
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
index 4b93fb3a9a96..1bf7bc51f50f 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -88,6 +88,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
+	__KVM_HOST_SMCCC_FUNC___pkvm_tlb_flush_vmid,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 904f6b1edced..1d8baa14ff1c 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -396,6 +396,22 @@ static void handle___kvm_tlb_flush_vmid(struct kvm_cpu_context *host_ctxt)
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
@@ -588,6 +604,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_teardown_vm),
 	HANDLE_FUNC(__pkvm_vcpu_load),
 	HANDLE_FUNC(__pkvm_vcpu_put),
+	HANDLE_FUNC(__pkvm_tlb_flush_vmid),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
-- 
2.47.0.163.g1226f6d8fa-goog


