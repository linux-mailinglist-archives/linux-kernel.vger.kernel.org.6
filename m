Return-Path: <linux-kernel+bounces-257471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5FF937A83
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218701C21B17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF2C14A4C6;
	Fri, 19 Jul 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PnYQIHlL"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556A14A0A2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405413; cv=none; b=DFpsxPZ0v8hgPZ8XthNjLudwf7+2Lo+vE+n8BK8hzCpt/m9E8HvZOouGcnTBy+V0nNOwazXvI8CuDEeXfAZuapVfO2UT67ZbzpIUu5WktdJn6bA65CCYUTUYADWyK4rtCTGhzWHWXnzHLJPlmLFnMXBHzAau7k/C3MJ11izfqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405413; c=relaxed/simple;
	bh=B+1xZ9fR6tSoT6mL74KtYbAEPB8W5QhktsEz3iQNGNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EOc++uNbhieGEoanPemibqYzh4izGGZbZhzg9oGwt87UADmYp4rM+cLdKux9Wk/y7JnvUwDk3fXryfOC5TY6y20+dVjQ0PbBOzAJrLISD0ZLIcRDz5UenKSGbUyZb/bhz0l0K2XicvTQfFNKv0oDBABfFe11H+TA5H1MRERTkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PnYQIHlL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb4a807708so19529255ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721405410; x=1722010210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qyi9hrGfVRmOD1WpD5vxj3JpORinviXBA5VC8Qc3Jso=;
        b=PnYQIHlLcEXdgivrQevf6GbVBv4/LmkgKzC+4tOQ0qO8qQ4XdhJZ32iQSmBvrmwpLq
         5v0q8yu30aS6nGXRFutEQnQKHExmsl7E6fBrhWw5ctrRFdGq/hY2JOlw3KxL6U63Hy8W
         URi4vc4tA8oEfzfq5PXzBtobGUv4SBrD0FYqZrKw6gCuNsorOwELfyt7KFZHs9do7eS4
         /qobMZ8Lkl/kvnteYPugdpeVQTLutalfRZRyM+/+VNkGF8EL2MXQriYKaq9szk4pHSBp
         p07aPww3Nx92eGHm8s85RtF9OGiZ4u/bznWGJbw4k8J8WtBDJMYSR9okhbzfUgJ6fh6H
         /tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405410; x=1722010210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qyi9hrGfVRmOD1WpD5vxj3JpORinviXBA5VC8Qc3Jso=;
        b=RjzRBKNVgp6HEor8KHkM9m1Tr+kQlWQLkLw5nB9N8A2oaAfdjGrr06Q3x1WF4iog4K
         G25BdY3V2+WtLu6U46aIqB+IiRzXCjcjZSU0kekBA+WCEPm8EcsMIoSYSB32jwlNREUe
         xV+gKAmGjuV89W/rDMurUj5yQBiEa2XRGAkmPU2B11L1gTQWzmm/E1H4GmJj+mCniPMn
         rXrJzIxWLk8QeZ9L+lZTODdJXkKLqAVNGoSHJ6RinVUcpwfJucMQQYUfnLZpJGcRKOe6
         9o2Xdk+pl1FP/S9ht9LjHL/uo2W5Mf/ksyMXtQjzu7nSq8VYhdWgLKOqlzKZUy8mw+0/
         uKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE0yKd3dtH98qaO7s8KSa+u4QG1k0fh3Kfd31ZK9fv591OHkvXXykKSkKcb8HR8mkPlURy0RYp19qFYegaTHEoOER3javJUOopSobG
X-Gm-Message-State: AOJu0YyK0HF6SQ+VU9cY4ZU75YvbVbqrfJaYj/S+tzM5GVBOcXCNQXFz
	3Qox6Izutenp/Pkj3NhJs8x/Iv+4nrrktHv/RWnkQPCcqtc2SV8qFQv+PvBnJuE=
X-Google-Smtp-Source: AGHT+IFxxJQJMT1yPV9iBgyfcleth8inhyBwlA3lhunIDQ81CpWWGH98IspVcY6bKB19yLGgqpEUJg==
X-Received: by 2002:a17:902:ecc5:b0:1fb:7978:6b1 with SMTP id d9443c01a7336-1fd74578fb2mr4074945ad.31.1721405410214;
        Fri, 19 Jul 2024 09:10:10 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([223.185.135.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28f518sm6632615ad.69.2024.07.19.09.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:10:09 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 13/13] RISC-V: KVM: Use NACL HFENCEs for KVM request based HFENCEs
Date: Fri, 19 Jul 2024 21:39:13 +0530
Message-Id: <20240719160913.342027-14-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240719160913.342027-1-apatel@ventanamicro.com>
References: <20240719160913.342027-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running under some other hypervisor, use SBI NACL based HFENCEs
for TLB shoot-down via KVM requests. This makes HFENCEs faster whenever
SBI nested acceleration is available.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/tlb.c | 57 +++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 23c0e82b5103..2f91ea5f8493 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -14,6 +14,7 @@
 #include <asm/csr.h>
 #include <asm/cpufeature.h>
 #include <asm/insn-def.h>
+#include <asm/kvm_nacl.h>
 
 #define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
 
@@ -186,18 +187,24 @@ void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu)
 
 void kvm_riscv_hfence_gvma_vmid_all_process(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vmid *vmid;
+	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
+	unsigned long vmid = READ_ONCE(v->vmid);
 
-	vmid = &vcpu->kvm->arch.vmid;
-	kvm_riscv_local_hfence_gvma_vmid_all(READ_ONCE(vmid->vmid));
+	if (kvm_riscv_nacl_available())
+		nacl_hfence_gvma_vmid_all(nacl_shmem(), vmid);
+	else
+		kvm_riscv_local_hfence_gvma_vmid_all(vmid);
 }
 
 void kvm_riscv_hfence_vvma_all_process(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vmid *vmid;
+	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
+	unsigned long vmid = READ_ONCE(v->vmid);
 
-	vmid = &vcpu->kvm->arch.vmid;
-	kvm_riscv_local_hfence_vvma_all(READ_ONCE(vmid->vmid));
+	if (kvm_riscv_nacl_available())
+		nacl_hfence_vvma_all(nacl_shmem(), vmid);
+	else
+		kvm_riscv_local_hfence_vvma_all(vmid);
 }
 
 static bool vcpu_hfence_dequeue(struct kvm_vcpu *vcpu,
@@ -251,6 +258,7 @@ static bool vcpu_hfence_enqueue(struct kvm_vcpu *vcpu,
 
 void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu)
 {
+	unsigned long vmid;
 	struct kvm_riscv_hfence d = { 0 };
 	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
 
@@ -259,26 +267,41 @@ void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu)
 		case KVM_RISCV_HFENCE_UNKNOWN:
 			break;
 		case KVM_RISCV_HFENCE_GVMA_VMID_GPA:
-			kvm_riscv_local_hfence_gvma_vmid_gpa(
-						READ_ONCE(v->vmid),
-						d.addr, d.size, d.order);
+			vmid = READ_ONCE(v->vmid);
+			if (kvm_riscv_nacl_available())
+				nacl_hfence_gvma_vmid(nacl_shmem(), vmid,
+						      d.addr, d.size, d.order);
+			else
+				kvm_riscv_local_hfence_gvma_vmid_gpa(vmid, d.addr,
+								     d.size, d.order);
 			break;
 		case KVM_RISCV_HFENCE_VVMA_ASID_GVA:
 			kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD);
-			kvm_riscv_local_hfence_vvma_asid_gva(
-						READ_ONCE(v->vmid), d.asid,
-						d.addr, d.size, d.order);
+			vmid = READ_ONCE(v->vmid);
+			if (kvm_riscv_nacl_available())
+				nacl_hfence_vvma_asid(nacl_shmem(), vmid, d.asid,
+						      d.addr, d.size, d.order);
+			else
+				kvm_riscv_local_hfence_vvma_asid_gva(vmid, d.asid, d.addr,
+								     d.size, d.order);
 			break;
 		case KVM_RISCV_HFENCE_VVMA_ASID_ALL:
 			kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD);
-			kvm_riscv_local_hfence_vvma_asid_all(
-						READ_ONCE(v->vmid), d.asid);
+			vmid = READ_ONCE(v->vmid);
+			if (kvm_riscv_nacl_available())
+				nacl_hfence_vvma_asid_all(nacl_shmem(), vmid, d.asid);
+			else
+				kvm_riscv_local_hfence_vvma_asid_all(vmid, d.asid);
 			break;
 		case KVM_RISCV_HFENCE_VVMA_GVA:
 			kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_RCVD);
-			kvm_riscv_local_hfence_vvma_gva(
-						READ_ONCE(v->vmid),
-						d.addr, d.size, d.order);
+			vmid = READ_ONCE(v->vmid);
+			if (kvm_riscv_nacl_available())
+				nacl_hfence_vvma(nacl_shmem(), vmid,
+						 d.addr, d.size, d.order);
+			else
+				kvm_riscv_local_hfence_vvma_gva(vmid, d.addr,
+								d.size, d.order);
 			break;
 		default:
 			break;
-- 
2.34.1


