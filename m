Return-Path: <linux-kernel+bounces-373429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93329A5689
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0606C1C24DD2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B019DF48;
	Sun, 20 Oct 2024 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ktSkex3t"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5719CC11
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453691; cv=none; b=bVPDoKjagris0vVh83JxlKIDIhxmw0rMJatxFG/2tOvIfln3gqaMld4jHZOIiQtZhZRyL0B5syEFoWnpiRgoYzFywnpQ67n+GWa/JomsD1DGRA8x/4CVbJSgHbkbBq9wqQxPqBzSAAG+qsF+mPSW6wUP+KgxoI6Z6SI9Q8fyrUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453691; c=relaxed/simple;
	bh=kyOQZveDrOSNJx1NEZtx5mOVCaXh/vOSdCiBaW04TNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlEhaKB8rFJZYreMZdq9lOegow1hU829lTNznUCGCdR+tuyajvAvBnk9ET0fAO4UpsLoQ/aaxGe5ZqUZ4LRCtBJIbqBd58e3gagXDkz904vppJP0h12qJ+HiTtbjzQiPvsx7nIYOkooO/nohcgjItbW1tcTzC0HHirCqPWNVkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ktSkex3t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cb47387ceso31858405ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1729453688; x=1730058488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jpt4DbIfoiuDWJOlua/tAIaTx6f+U6YQBxkTpe5jPP4=;
        b=ktSkex3thXMEhP3+erwMZhK76nrqVHrBt+YM1RJaBP0EBdqgVQZgpkvKYNL25utKfJ
         sRGOR9KGInaOpd/4ujukN3ufGmtCmuvJGP4V2m/bhesQYb/8hb2n+ECwRSgmRDUyFCcb
         2IGRfefrUA23mGlcBVt0qFS8sP+kel624RuajOXnpJTqDQyaZX8zfqjzWZNtVzLNYtOR
         FQVN7OSTBsyF3SiW1W/8E3G8IXnU/uQaiI6MRKMx31YvNJNA0WBa94ZtTB/MNqT9MELI
         u2O0dVX9Ez1YKU4OAYV4Ohb8hm3lHgQQ0vZvDNb8tCwDgVAEy7lpj+w8N1PSnAH0YZlV
         O4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453688; x=1730058488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jpt4DbIfoiuDWJOlua/tAIaTx6f+U6YQBxkTpe5jPP4=;
        b=e82VH5pck92PjfInFd+0kJyi/lldWa3wSFCBtafsw87KoZvhJxXIb36RAjSB95oJwy
         lRXYeDJWFh/gTXjBOLljXE6+NOUiY1IdUp5HyELAGfLwMEHlx2dp5Ma7EH7fpuszPf7l
         b6Wm+lM/DXcYa5gk2ksN8t+qRW0VrulA3XIGfGJexZcg1F6AM/gP+LNzeIop1VZcIgMe
         x+0vLI9aKt57X0IzV87iPF6A/aWsSMsvS0jc7kOCiHstoDGmhQIfk10CbdWeV51CfVvO
         E+LVMCFJUsm99n8Rf5RECUhs7WqXlDTMHwwhxo17rjTiqBgaCEEIHe18hnsXZ4lNWGBC
         oEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHhOMgh7KKCxlCjzXdvEFWE9AuuyrIT/yEcXtP0gc2g9cahCQg/HSq29yeVURAFNsfN96O+6CCcCT/HYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49uHoNV3dXfnvRy0Rq8XdTB1cEW+1GUVCGE3alAoiH//Ve/jD
	sPAimZzI9TlQIMNVB6l5bbevlFatDpLATt5tV5EZ3/3vHW7N8HKRGt5U8tN+mxs=
X-Google-Smtp-Source: AGHT+IFBmef3AeMvYK7vRhNOkgHPNp9TfRjR+EjTOWv2i/hsD5eBK3uDXWFjXdE3v54cHEOsNVWYNw==
X-Received: by 2002:a17:90a:17cc:b0:2e0:5748:6ea1 with SMTP id 98e67ed59e1d1-2e56172aad1mr11159778a91.37.1729453688471;
        Sun, 20 Oct 2024 12:48:08 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([50.238.223.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad365d4dsm1933188a91.14.2024.10.20.12.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:48:07 -0700 (PDT)
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
Subject: [PATCH v2 13/13] RISC-V: KVM: Use NACL HFENCEs for KVM request based HFENCEs
Date: Mon, 21 Oct 2024 01:17:34 +0530
Message-ID: <20241020194734.58686-14-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020194734.58686-1-apatel@ventanamicro.com>
References: <20241020194734.58686-1-apatel@ventanamicro.com>
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
2.43.0


