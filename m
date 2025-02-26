Return-Path: <linux-kernel+bounces-534639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A4CA46966
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA003A9A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BA424BBF7;
	Wed, 26 Feb 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTx0gEBC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF02405E9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593728; cv=none; b=X89RwuB3iM3zW6QeFaj5UFC3pQ1HQIisMc6THYG73DW4oUAilwCnYW6bjHEvMr+8/1kEzbXyVQEH6g2VigcYm1ebqG9ZA+1Ir00f8yLgC7pgY+TM8Njeoe6cibG+lcAEOUFjfRH5p3Y38BeXBKyqIjX64hVyWlJZffwMqAXmaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593728; c=relaxed/simple;
	bh=icjSmhgPFStnbRyA4WYaOU0vRUDRbVJz/bGa7RLscpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjOlsqo9K2JjNqoO8WdXLjZ3TilYmicvPgN+ZRX1jbafCiv2tEggFAjigpr1Ry5UiH7l70ko7wMZYigDr2MDeI1pXfrhdS3833eSQAhXkgtE5a784Vt05Ty7mmy9gTrDR0xvph69e0LfmALviU9yxZJzKc+QYbJh8muLYjUMcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTx0gEBC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740593723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05c5BPt8MNpSjxU+rl+LAMkTS2Bxf0RZmafFNTbklaQ=;
	b=CTx0gEBCBIA+OImDPHlmmtGCIhir9v7SBG2QqepT6hhHZwJHy39wYwIYIIXXfZ5HV/zC3l
	7YbrEiA8oPFxrPhtYhYpjHIHh/TuOWRWxWgwtLcJpFapxBg5z1ZGwLh3SLSsxgyIinHeWw
	uQ7hvB6we/I5Z8amZAlq5QMwB0fl/cU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-twfcRpmnP86DFa7eIrtoZA-1; Wed,
 26 Feb 2025 13:15:21 -0500
X-MC-Unique: twfcRpmnP86DFa7eIrtoZA-1
X-Mimecast-MFC-AGG-ID: twfcRpmnP86DFa7eIrtoZA_1740593720
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D7D619560BC;
	Wed, 26 Feb 2025 18:15:20 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BDA21954B01;
	Wed, 26 Feb 2025 18:15:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH 17/33] KVM: TDX: Add placeholders for TDX VM/vCPU structures
Date: Wed, 26 Feb 2025 13:14:36 -0500
Message-ID: <20250226181453.2311849-18-pbonzini@redhat.com>
In-Reply-To: <20250226181453.2311849-1-pbonzini@redhat.com>
References: <20250226181453.2311849-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Isaku Yamahata <isaku.yamahata@intel.com>

Add TDX's own VM and vCPU structures as placeholder to manage and run
TDX guests.  Also add helper functions to check whether a VM/vCPU is
TDX or normal VMX one, and add helpers to convert between TDX VM/vCPU
and KVM VM/vCPU.

TDX protects guest VMs from malicious host.  Unlike VMX guests, TDX
guests are crypto-protected.  KVM cannot access TDX guests' memory and
vCPU states directly.  Instead, TDX requires KVM to use a set of TDX
architecture-defined firmware APIs (a.k.a TDX module SEAMCALLs) to
manage and run TDX guests.

In fact, the way to manage and run TDX guests and normal VMX guests are
quite different.  Because of that, the current structures
('struct kvm_vmx' and 'struct vcpu_vmx') to manage VMX guests are not
quite suitable for TDX guests.  E.g., the majority of the members of
'struct vcpu_vmx' don't apply to TDX guests.

Introduce TDX's own VM and vCPU structures ('struct kvm_tdx' and 'struct
vcpu_tdx' respectively) for KVM to manage and run TDX guests.  And
instead of building TDX's VM and vCPU structures based on VMX's, build
them directly based on 'struct kvm'.

As a result, TDX and VMX guests will have different VM size and vCPU
size/alignment.

Currently, kvm_arch_alloc_vm() uses 'kvm_x86_ops::vm_size' to allocate
enough space for the VM structure when creating guest.  With TDX guests,
ideally, KVM should allocate the VM structure based on the VM type so
that the precise size can be allocated for VMX and TDX guests.  But this
requires more extensive code change.  For now, simply choose the maximum
size of 'struct kvm_tdx' and 'struct kvm_vmx' for VM structure
allocation for both VMX and TDX guests.  This would result in small
memory waste for each VM which has smaller VM structure size but this is
acceptable.

For simplicity, use the same way for vCPU allocation too.  Otherwise KVM
would need to maintain a separate 'kvm_vcpu_cache' for each VM type.

Note, updating the 'vt_x86_ops::vm_size' needs to be done before calling
kvm_ops_update(), which copies vt_x86_ops to kvm_x86_ops.  However this
happens before TDX module initialization.  Therefore theoretically it is
possible that 'kvm_x86_ops::vm_size' is set to size of 'struct kvm_tdx'
(when it's larger) but TDX actually fails to initialize at a later time.

Again the worst case of this is wasting couple of bytes memory for each
VM.  KVM could choose to update 'kvm_x86_ops::vm_size' at a later time
depending on TDX's status but that would require base KVM module to
export either kvm_x86_ops or kvm_ops_update().

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 - Make to_kvm_tdx() and to_tdx() private to tdx.c (Francesco, Tony)
 - Add pragma poison for to_vmx() (Paolo)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/main.c | 53 ++++++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/vmx/tdx.c  | 14 ++++++++++-
 arch/x86/kvm/vmx/tdx.h  | 37 ++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 97c453187cc1..5c1acc88feef 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -8,6 +8,39 @@
 #include "posted_intr.h"
 #include "tdx.h"
 
+static __init int vt_hardware_setup(void)
+{
+	int ret;
+
+	ret = vmx_hardware_setup();
+	if (ret)
+		return ret;
+
+	/*
+	 * Update vt_x86_ops::vm_size here so it is ready before
+	 * kvm_ops_update() is called in kvm_x86_vendor_init().
+	 *
+	 * Note, the actual bringing up of TDX must be done after
+	 * kvm_ops_update() because enabling TDX requires enabling
+	 * hardware virtualization first, i.e., all online CPUs must
+	 * be in post-VMXON state.  This means the @vm_size here
+	 * may be updated to TDX's size but TDX may fail to enable
+	 * at later time.
+	 *
+	 * The VMX/VT code could update kvm_x86_ops::vm_size again
+	 * after bringing up TDX, but this would require exporting
+	 * either kvm_x86_ops or kvm_ops_update() from the base KVM
+	 * module, which looks overkill.  Anyway, the worst case here
+	 * is KVM may allocate couple of more bytes than needed for
+	 * each VM.
+	 */
+	if (enable_tdx)
+		vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size,
+				sizeof(struct kvm_tdx));
+
+	return 0;
+}
+
 #define VMX_REQUIRED_APICV_INHIBITS				\
 	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
 	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
@@ -163,7 +196,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 };
 
 struct kvm_x86_init_ops vt_init_ops __initdata = {
-	.hardware_setup = vmx_hardware_setup,
+	.hardware_setup = vt_hardware_setup,
 	.handle_intel_pt_intr = NULL,
 
 	.runtime_ops = &vt_x86_ops,
@@ -180,6 +213,7 @@ module_exit(vt_exit);
 
 static int __init vt_init(void)
 {
+	unsigned vcpu_size, vcpu_align;
 	int r;
 
 	r = vmx_init();
@@ -191,12 +225,25 @@ static int __init vt_init(void)
 	if (r)
 		goto err_tdx_bringup;
 
+	/*
+	 * TDX and VMX have different vCPU structures.  Calculate the
+	 * maximum size/align so that kvm_init() can use the larger
+	 * values to create the kmem_vcpu_cache.
+	 */
+	vcpu_size = sizeof(struct vcpu_vmx);
+	vcpu_align = __alignof__(struct vcpu_vmx);
+	if (enable_tdx) {
+		vcpu_size = max_t(unsigned, vcpu_size,
+				sizeof(struct vcpu_tdx));
+		vcpu_align = max_t(unsigned, vcpu_align,
+				__alignof__(struct vcpu_tdx));
+	}
+
 	/*
 	 * Common KVM initialization _must_ come last, after this, /dev/kvm is
 	 * exposed to userspace!
 	 */
-	r = kvm_init(sizeof(struct vcpu_vmx), __alignof__(struct vcpu_vmx),
-		     THIS_MODULE);
+	r = kvm_init(vcpu_size, vcpu_align, THIS_MODULE);
 	if (r)
 		goto err_kvm_init;
 
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b74a50e8d086..c319eb44d9f9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -5,16 +5,28 @@
 #include "capabilities.h"
 #include "tdx.h"
 
+#pragma GCC poison to_vmx
+
 #undef pr_fmt
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-static bool enable_tdx __ro_after_init;
+bool enable_tdx __ro_after_init;
 module_param_named(tdx, enable_tdx, bool, 0444);
 
 static enum cpuhp_state tdx_cpuhp_state;
 
 static const struct tdx_sys_info *tdx_sysinfo;
 
+static __always_inline struct kvm_tdx *to_kvm_tdx(struct kvm *kvm)
+{
+	return container_of(kvm, struct kvm_tdx, kvm);
+}
+
+static __always_inline struct vcpu_tdx *to_tdx(struct kvm_vcpu *vcpu)
+{
+	return container_of(vcpu, struct vcpu_tdx, vcpu);
+}
+
 static int tdx_online_cpu(unsigned int cpu)
 {
 	unsigned long flags;
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index 8aee938a968f..fc013c8816f1 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -5,9 +5,46 @@
 #ifdef CONFIG_INTEL_TDX_HOST
 int tdx_bringup(void);
 void tdx_cleanup(void);
+
+extern bool enable_tdx;
+
+struct kvm_tdx {
+	struct kvm kvm;
+	/* TDX specific members follow. */
+};
+
+struct vcpu_tdx {
+	struct kvm_vcpu	vcpu;
+	/* TDX specific members follow. */
+};
+
+static inline bool is_td(struct kvm *kvm)
+{
+	return kvm->arch.vm_type == KVM_X86_TDX_VM;
+}
+
+static inline bool is_td_vcpu(struct kvm_vcpu *vcpu)
+{
+	return is_td(vcpu->kvm);
+}
+
 #else
 static inline int tdx_bringup(void) { return 0; }
 static inline void tdx_cleanup(void) {}
+
+#define enable_tdx	0
+
+struct kvm_tdx {
+	struct kvm kvm;
+};
+
+struct vcpu_tdx {
+	struct kvm_vcpu	vcpu;
+};
+
+static inline bool is_td(struct kvm *kvm) { return false; }
+static inline bool is_td_vcpu(struct kvm_vcpu *vcpu) { return false; }
+
 #endif
 
 #endif
-- 
2.43.5



