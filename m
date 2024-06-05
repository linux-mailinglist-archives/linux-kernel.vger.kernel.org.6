Return-Path: <linux-kernel+bounces-203397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77548FDA4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B580282979
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE43E16EC15;
	Wed,  5 Jun 2024 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWuOum8U"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC71667F6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629574; cv=none; b=mZK+yI41LS70BlZFYCSNEs20KTTGvEocQHuk1fL1wPaHyrd897xn9KtoUO7XNz66BCUPJSC23xQu/jQXcnCJFkWhDi+ioAGL5bW1isCnpjr80eZlHXqa5764wP4Ry8SNlljv7KV6NOwGHLnaJ3f9MMYUADtNT1xE9qkV+iwIuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629574; c=relaxed/simple;
	bh=o4TU5aSMsDtgX9oPElesHgr1ttHkW1FxVkZR5HkFqdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I8frpKsS7J6gmbu0IxnBFvR7auV2RinSG4OMzWK5kYGcrc/GZllk1IKcjb1LIT906Rgq7AO1fMd8sl9mU/PEQwt79zdIYkSWi9nElGMbiy/n2p2CSj3VpfSZEwURm7ow1lxWnBT8cEvgKtfuPDdJ+EFluvZl2l4emkwfjYoIA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWuOum8U; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627f20cff42so4998707b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717629571; x=1718234371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=x0ovJhNxRk771BF46FJnhH05FDemF9LzKryIAxmt7ys=;
        b=JWuOum8U1N72zdNtBmcAye3osLDDntMf8e7IgACJNu9eSyTvPLvsw0qoCk5txyTD1w
         URhCBkyqmfhp7ie6QBSAdCvXRC/o1ptivaOl41KjYpu5vac9FEtGo5wxMRr7t19uQawb
         778sA6I4GB8k/bzEf2NadAID1PA+p0pDLx9OEK+KiQ5RuH+/Q8AuDuzMfYZ3lPjw07zz
         z/OMae+UmPVHoVbQOMZPh8QqjHNxMooKU8tylGOYu6CubdRHSwtyQabUg+0bfMCXLXeJ
         wbRUhW76PpB4Oi0/RmtRgBRmIhaVW6KlK5rYTfTWmBZ/+GzES4kwD1LVmhptC8WqBdCb
         h+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717629571; x=1718234371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0ovJhNxRk771BF46FJnhH05FDemF9LzKryIAxmt7ys=;
        b=PVSWXvlgaQsoowZzvINATRqsyHa78qmpamdTMPLwDp8eUeC7gbedGE4HN7esHcU7td
         h5p+vBKzEugnwA++WNv/CqaHYkLpvv5h7xf88SSMv453bwsFxohJ+uAzCrVy/mcw5eXm
         ER4K6B+w/ELkmFRM/9owBxL7VL2Jw8+WSPEUDGWugkB8pJnnH8XkqgLL/+fVWVGr5Y/5
         C7ld8oPWfnIA0S3+5I91TgHjq59JVr5Zlhk3DzcEh/ygKRYRswhplpuhFr3DtKreUNwj
         yolcSS59y+Y31JTAQrJ60Bfs1eRfwcI6Zp54JsFNOUsuxDVeKIokUw9J1/W1e1CD6oZN
         Jufg==
X-Gm-Message-State: AOJu0Yy/4LXpgWTmKNqHKGd5tAS1xN9iHecnT/G0SNbCZrFwuScuP4NM
	kePNBffXKG+xWHqUeHptitZqi5ctFotxdlDd7xGiztAB57V+HVH90lVM+zsG+vvGuYzVlNUMcJn
	OBw==
X-Google-Smtp-Source: AGHT+IHepOEEIycwfROwgwHXcMOucIQZybnv3dylhX3B+i0r0x9Gwt1yiflyLOPSGdHk1wMWKBMD31XgaMU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:95:b0:61b:e73d:bea2 with SMTP id
 00721157ae682-62cbb5923bfmr12052037b3.5.1717629571505; Wed, 05 Jun 2024
 16:19:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  5 Jun 2024 16:19:13 -0700
In-Reply-To: <20240605231918.2915961-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605231918.2915961-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605231918.2915961-6-seanjc@google.com>
Subject: [PATCH v8 05/10] KVM: VMX: Track CPU's MSR_IA32_VMX_BASIC as a single
 64-bit value
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Jim Mattson <jmattson@google.com>, Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Xin Li <xin3.li@intel.com>

Track the "basic" capabilities VMX MSR as a single u64 in vmcs_config
instead of splitting it across three fields, that obviously don't combine
into a single 64-bit value, so that KVM can use the macros that define MSR
bits using their absolute position.  Replace all open coded shifts and
masks, many of which are relative to the "high" half, with the appropriate
macro.

Opportunistically use VMX_BASIC_32BIT_PHYS_ADDR_ONLY instead of an open
coded equivalent, and clean up the related comment to not reference a
specific SDM section (to the surprise of no one, the comment is stale).

No functional change intended (though obviously the code generation will
be quite different).

Cc: Shan Kang <shan.kang@intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
[sean: split to separate patch, write changelog]
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/vmx.h      |  5 +++++
 arch/x86/kvm/vmx/capabilities.h |  6 ++----
 arch/x86/kvm/vmx/vmx.c          | 28 ++++++++++++++--------------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 81b986e501a9..90963b14afaa 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -152,6 +152,11 @@ static inline u32 vmx_basic_vmcs_size(u64 vmx_basic)
 	return (vmx_basic & GENMASK_ULL(44, 32)) >> 32;
 }
 
+static inline u32 vmx_basic_vmcs_mem_type(u64 vmx_basic)
+{
+	return (vmx_basic & GENMASK_ULL(53, 50)) >> 50;
+}
+
 static inline int vmx_misc_preemption_timer_rate(u64 vmx_misc)
 {
 	return vmx_misc & VMX_MISC_PREEMPTION_TIMER_RATE_MASK;
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 41a4533f9989..86ce8bb96bed 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -54,9 +54,7 @@ struct nested_vmx_msrs {
 };
 
 struct vmcs_config {
-	int size;
-	u32 basic_cap;
-	u32 revision_id;
+	u64 basic;
 	u32 pin_based_exec_ctrl;
 	u32 cpu_based_exec_ctrl;
 	u32 cpu_based_2nd_exec_ctrl;
@@ -76,7 +74,7 @@ extern struct vmx_capability vmx_capability __ro_after_init;
 
 static inline bool cpu_has_vmx_basic_inout(void)
 {
-	return	(((u64)vmcs_config.basic_cap << 32) & VMX_BASIC_INOUT);
+	return	vmcs_config.basic & VMX_BASIC_INOUT;
 }
 
 static inline bool cpu_has_virtual_nmis(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e495a8b28314..3141ef8679e2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2569,13 +2569,13 @@ static u64 adjust_vmx_controls64(u64 ctl_opt, u32 msr)
 static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 			     struct vmx_capability *vmx_cap)
 {
-	u32 vmx_msr_low, vmx_msr_high;
 	u32 _pin_based_exec_control = 0;
 	u32 _cpu_based_exec_control = 0;
 	u32 _cpu_based_2nd_exec_control = 0;
 	u64 _cpu_based_3rd_exec_control = 0;
 	u32 _vmexit_control = 0;
 	u32 _vmentry_control = 0;
+	u64 basic_msr;
 	u64 misc_msr;
 	int i;
 
@@ -2698,29 +2698,29 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		_vmexit_control &= ~x_ctrl;
 	}
 
-	rdmsr(MSR_IA32_VMX_BASIC, vmx_msr_low, vmx_msr_high);
+	rdmsrl(MSR_IA32_VMX_BASIC, basic_msr);
 
 	/* IA-32 SDM Vol 3B: VMCS size is never greater than 4kB. */
-	if ((vmx_msr_high & 0x1fff) > PAGE_SIZE)
+	if (vmx_basic_vmcs_size(basic_msr) > PAGE_SIZE)
 		return -EIO;
 
 #ifdef CONFIG_X86_64
-	/* IA-32 SDM Vol 3B: 64-bit CPUs always have VMX_BASIC_MSR[48]==0. */
-	if (vmx_msr_high & (1u<<16))
+	/*
+	 * KVM expects to be able to shove all legal physical addresses into
+	 * VMCS fields for 64-bit kernels, and per the SDM, "This bit is always
+	 * 0 for processors that support Intel 64 architecture".
+	 */
+	if (basic_msr & VMX_BASIC_32BIT_PHYS_ADDR_ONLY)
 		return -EIO;
 #endif
 
 	/* Require Write-Back (WB) memory type for VMCS accesses. */
-	if (((vmx_msr_high >> 18) & 15) != X86_MEMTYPE_WB)
+	if (vmx_basic_vmcs_mem_type(basic_msr) != X86_MEMTYPE_WB)
 		return -EIO;
 
 	rdmsrl(MSR_IA32_VMX_MISC, misc_msr);
 
-	vmcs_conf->size = vmx_msr_high & 0x1fff;
-	vmcs_conf->basic_cap = vmx_msr_high & ~0x1fff;
-
-	vmcs_conf->revision_id = vmx_msr_low;
-
+	vmcs_conf->basic = basic_msr;
 	vmcs_conf->pin_based_exec_ctrl = _pin_based_exec_control;
 	vmcs_conf->cpu_based_exec_ctrl = _cpu_based_exec_control;
 	vmcs_conf->cpu_based_2nd_exec_ctrl = _cpu_based_2nd_exec_control;
@@ -2870,13 +2870,13 @@ struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags)
 	if (!pages)
 		return NULL;
 	vmcs = page_address(pages);
-	memset(vmcs, 0, vmcs_config.size);
+	memset(vmcs, 0, vmx_basic_vmcs_size(vmcs_config.basic));
 
 	/* KVM supports Enlightened VMCS v1 only */
 	if (kvm_is_using_evmcs())
 		vmcs->hdr.revision_id = KVM_EVMCS_VERSION;
 	else
-		vmcs->hdr.revision_id = vmcs_config.revision_id;
+		vmcs->hdr.revision_id = vmx_basic_vmcs_revision_id(vmcs_config.basic);
 
 	if (shadow)
 		vmcs->hdr.shadow_vmcs = 1;
@@ -2969,7 +2969,7 @@ static __init int alloc_kvm_area(void)
 		 * physical CPU.
 		 */
 		if (kvm_is_using_evmcs())
-			vmcs->hdr.revision_id = vmcs_config.revision_id;
+			vmcs->hdr.revision_id = vmx_basic_vmcs_revision_id(vmcs_config.basic);
 
 		per_cpu(vmxarea, cpu) = vmcs;
 	}
-- 
2.45.1.467.gbab1589fc0-goog


