Return-Path: <linux-kernel+bounces-185663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5098CB895
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7621F23578
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426DF1D543;
	Wed, 22 May 2024 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgYaxdIS"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6C17556
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716342022; cv=none; b=bjbpPqnQSLjj09W9+ZVewl8XL/5FbISbaQDVi6mq34/yLoENiJz+0Cz+Hz6dKFmI8lTGzkAQw7lZpSNGPBidNys6wbzvVpfDdblSGmqt6++x5WGk9t9GSEJyImQvWLaxfNoJiorCbIHgcTHyF8jniQeGmPMX8tWBTFnOuvks2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716342022; c=relaxed/simple;
	bh=a3/l+BJfoA/G/28RbhkAW1tXtxlUYPuy/d4D+LgwoZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4BngfE8ESBpTGVxEWFgncV4HImQ61hUaUkwkgY0Gkf6wyDB4+rvAzoimIxPMGixAVBMkmcfyv0A6fJTrzj58UJo51LZcWOW7HBi/TmL+IpNiyg+2moNKifpkgbZejTC/bM/sP1/oPaf397ybJhLV50vORPP/rNJP3e3oMC5Fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TgYaxdIS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6256bc244b7so5337567b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716342020; x=1716946820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RHSd/NUpLA+qEQZ24Usoansq2bi58Ee8oOJzhOJ4pNg=;
        b=TgYaxdISmyZDw09b+yhTo9D4kjNP98X+q+pEZ8fFnuqu36J46RgbMVXCkwOtzeh7d/
         1Tbyq3M816qXa8YRexIlj497IAm8vM2lv3j27GWZpdPBEKP6s9pphJmGIC3umYeqxk6w
         pKK8esdZZxJ14RQLML3m/kUEBNzKTq0qI3x0S5w4Pvv7S80qKV+R9BV0xAF65mTBPXWp
         R6128rG4gbfk6PqCS5EcxWD+30ZAR47BpaLlfA/zN+G1d45Xv3qkZei4iKZUG8rJDR5k
         OUkGrhTu000s4qlEpy32P5imIdxuPqSyID1EBzHanMiUkprL6i0AO4RmJxv7m4x7RAqv
         BjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716342020; x=1716946820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHSd/NUpLA+qEQZ24Usoansq2bi58Ee8oOJzhOJ4pNg=;
        b=M0D3rXWfBr+q5NHd4t7C34vpDCQQg6+BeLwoyk4PMdnwSWEJt0r9aQpLZCiSdFd5b7
         rKu6cbkqZ8mR99b5+r06y48DO+yQwNTUiWk81/+XI+XB4eLeFfburbRCp9xtods8+tCH
         2HPQeWiOCoPZ5ha8wrvaO9p0ezW7bvDCdXmfK0WHEynVP59oe09vQYfad4hkP84I7aAZ
         wlx8qYHxzdzpmM0s8w9FPu80Fsp8KiycY5zCXOqDVH5gT6R3gJ/jOt8/fzegs8az+sB3
         tPXHmXG/jv4w6qUMviYkoUNp1CjGSdsjl56CpU4zDt5APByB3PBxddy/+CtL+RK/Erh8
         9cOw==
X-Forwarded-Encrypted: i=1; AJvYcCV80a1p6oFzLGCrY7lMgl/8WRmKgcS18QMrOplF2Tx1ru7+xYA7e3I9jFVCINaFbcA0TPuHx7fnXTN8M6aOcKBfaEWl4FE1sG+ayKMF
X-Gm-Message-State: AOJu0Yzcf45/WdUeVCTeiO/0hWewNGoeYY6PXHZ+eevj+hvteQgjOngj
	BB/V3uL91mtIAn/wXVo5XKgdb6kNR0Lwupz5BTvByWUadZGfmhX1doSXKjlakneISUtrbA3pXqY
	z8w==
X-Google-Smtp-Source: AGHT+IE9wMBEKwP41aGLYHN5gIBbi7welOi0G93+qj4AotHFqdz8JFE0XRpN5nX1Yz+N7pw0xKG3cBx+pVY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ca57:0:b0:61b:e53e:c7ae with SMTP id
 00721157ae682-627e46aa2e9mr2093257b3.2.1716342019957; Tue, 21 May 2024
 18:40:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 21 May 2024 18:40:09 -0700
In-Reply-To: <20240522014013.1672962-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522014013.1672962-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240522014013.1672962-3-seanjc@google.com>
Subject: [PATCH v2 2/6] KVM: VMX: Move PLE grow/shrink helpers above vmx_vcpu_load()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move VMX's {grow,shrink}_ple_window() above vmx_vcpu_load() in preparation
of moving the sched_in logic, which handles shrinking the PLE window, into
vmx_vcpu_load().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 64 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 51b2cd13250a..07a4d6a3a43e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1410,6 +1410,38 @@ static void vmx_write_guest_kernel_gs_base(struct vcpu_vmx *vmx, u64 data)
 }
 #endif
 
+static void grow_ple_window(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned int old = vmx->ple_window;
+
+	vmx->ple_window = __grow_ple_window(old, ple_window,
+					    ple_window_grow,
+					    ple_window_max);
+
+	if (vmx->ple_window != old) {
+		vmx->ple_window_dirty = true;
+		trace_kvm_ple_window_update(vcpu->vcpu_id,
+					    vmx->ple_window, old);
+	}
+}
+
+static void shrink_ple_window(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned int old = vmx->ple_window;
+
+	vmx->ple_window = __shrink_ple_window(old, ple_window,
+					      ple_window_shrink,
+					      ple_window);
+
+	if (vmx->ple_window != old) {
+		vmx->ple_window_dirty = true;
+		trace_kvm_ple_window_update(vcpu->vcpu_id,
+					    vmx->ple_window, old);
+	}
+}
+
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 			struct loaded_vmcs *buddy)
 {
@@ -5889,38 +5921,6 @@ int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static void grow_ple_window(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned int old = vmx->ple_window;
-
-	vmx->ple_window = __grow_ple_window(old, ple_window,
-					    ple_window_grow,
-					    ple_window_max);
-
-	if (vmx->ple_window != old) {
-		vmx->ple_window_dirty = true;
-		trace_kvm_ple_window_update(vcpu->vcpu_id,
-					    vmx->ple_window, old);
-	}
-}
-
-static void shrink_ple_window(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned int old = vmx->ple_window;
-
-	vmx->ple_window = __shrink_ple_window(old, ple_window,
-					      ple_window_shrink,
-					      ple_window);
-
-	if (vmx->ple_window != old) {
-		vmx->ple_window_dirty = true;
-		trace_kvm_ple_window_update(vcpu->vcpu_id,
-					    vmx->ple_window, old);
-	}
-}
-
 /*
  * Indicate a busy-waiting vcpu in spinlock. We do not enable the PAUSE
  * exiting, so only get here on cpu with PAUSE-Loop-Exiting.
-- 
2.45.0.215.g3402c0e53f-goog


