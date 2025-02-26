Return-Path: <linux-kernel+bounces-534641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E8A4696C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EB9188434A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B8A236423;
	Wed, 26 Feb 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAdaFmUf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3E250C0F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593736; cv=none; b=gg/mfTI4Q9lneg8G7H7ucXeXA6R9f9tP+8RAE9MSgjIZmCHRVPqmMC+jn3osXmwlXbFqNz6b2Bld2+SqlQCZF2kY7BUdBD9lWC0+uxr35FOb45NxyDxk86CVHLCzh2+K3f2RLdaq5Cy95vKMIOELTkNbD2EKehJDAWHmOQWtx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593736; c=relaxed/simple;
	bh=Y1pciOjnF+fn7UAHJsrV9a2NJf5VFcUNjXILS4FDdI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+Ubgeg70gIJJqoJ5Uxs90suwgH+iqR5A1txmmWxZfm79vejm2XvPi1wx8TxAhwiApit/Z2LiKghU3Mb9Ong5lz8VetGkZz1OdwtZUewc+lToUTAC1CE6LAvBt9NeSMosjp4pwWK6xna1Jo8xjeAZ896i+lSEU1S1wyqb3lRloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAdaFmUf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740593733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6BsNy0V6FDrte9ve0UF9Q+C+3UwT2Up0HWRIDzN71c=;
	b=SAdaFmUf124MKvsps9SqAuv3RMZWZ8MrwVjWKSw2lh6BocpVczvWDyhXLP2HT9j7JDnJyh
	umdQXZKs1r7Yj5phvb0YpHfllYT6/a8BIFMS7PG68pimr5BOk9koVR/GcjnYKYF1+CXJBx
	E/35RBTPG2bF8Sw55uz1dRyqA+JJlyw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-mNhteFr0PgO8uO1ciVv3XA-1; Wed,
 26 Feb 2025 13:15:30 -0500
X-MC-Unique: mNhteFr0PgO8uO1ciVv3XA-1
X-Mimecast-MFC-AGG-ID: mNhteFr0PgO8uO1ciVv3XA_1740593728
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F1A519039CA;
	Wed, 26 Feb 2025 18:15:28 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3675519560AE;
	Wed, 26 Feb 2025 18:15:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH 22/33] KVM: TDX: Get system-wide info about TDX module on initialization
Date: Wed, 26 Feb 2025 13:14:41 -0500
Message-ID: <20250226181453.2311849-23-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDX KVM needs system-wide information about the TDX module. Generate the
data based on tdx_sysinfo td_conf CPUID data.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Co-developed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 - Clarify comment about EAX[23:16] in td_init_cpuid_entry2() (Xiaoyao)
 - Add comment for configurable CPUID bits (Xiaoyao)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/uapi/asm/kvm.h |  11 +++
 arch/x86/kvm/vmx/tdx.c          | 137 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/tdx_arch.h     |   2 +
 3 files changed, 150 insertions(+)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 2b0317b47e47..8a4633cdb247 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -929,6 +929,8 @@ struct kvm_hyperv_eventfd {
 
 /* Trust Domain eXtension sub-ioctl() commands. */
 enum kvm_tdx_cmd_id {
+	KVM_TDX_CAPABILITIES = 0,
+
 	KVM_TDX_CMD_NR_MAX,
 };
 
@@ -950,4 +952,13 @@ struct kvm_tdx_cmd {
 	__u64 hw_error;
 };
 
+struct kvm_tdx_capabilities {
+	__u64 supported_attrs;
+	__u64 supported_xfam;
+	__u64 reserved[254];
+
+	/* Configurable CPUID bits for userspace */
+	struct kvm_cpuid2 cpuid;
+};
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index a20de9db315f..3e7dc251e5e0 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -33,6 +33,8 @@ static enum cpuhp_state tdx_cpuhp_state;
 
 static const struct tdx_sys_info *tdx_sysinfo;
 
+#define KVM_SUPPORTED_TD_ATTRS (TDX_TD_ATTR_SEPT_VE_DISABLE)
+
 static __always_inline struct kvm_tdx *to_kvm_tdx(struct kvm *kvm)
 {
 	return container_of(kvm, struct kvm_tdx, kvm);
@@ -43,6 +45,129 @@ static __always_inline struct vcpu_tdx *to_tdx(struct kvm_vcpu *vcpu)
 	return container_of(vcpu, struct vcpu_tdx, vcpu);
 }
 
+static u64 tdx_get_supported_attrs(const struct tdx_sys_info_td_conf *td_conf)
+{
+	u64 val = KVM_SUPPORTED_TD_ATTRS;
+
+	if ((val & td_conf->attributes_fixed1) != td_conf->attributes_fixed1)
+		return 0;
+
+	val &= td_conf->attributes_fixed0;
+
+	return val;
+}
+
+static u64 tdx_get_supported_xfam(const struct tdx_sys_info_td_conf *td_conf)
+{
+	u64 val = kvm_caps.supported_xcr0 | kvm_caps.supported_xss;
+
+	if ((val & td_conf->xfam_fixed1) != td_conf->xfam_fixed1)
+		return 0;
+
+	val &= td_conf->xfam_fixed0;
+
+	return val;
+}
+
+static u32 tdx_set_guest_phys_addr_bits(const u32 eax, int addr_bits)
+{
+	return (eax & ~GENMASK(23, 16)) | (addr_bits & 0xff) << 16;
+}
+
+#define KVM_TDX_CPUID_NO_SUBLEAF	((__u32)-1)
+
+static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char idx)
+{
+	const struct tdx_sys_info_td_conf *td_conf = &tdx_sysinfo->td_conf;
+
+	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
+	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
+	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
+	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
+	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
+	entry->edx = td_conf->cpuid_config_values[idx][1] >> 32;
+
+	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
+		entry->index = 0;
+
+	/*
+	 * The TDX module doesn't allow configuring the guest phys addr bits
+	 * (EAX[23:16]).  However, KVM uses it as an interface to the userspace
+	 * to configure the GPAW.  Report these bits as configurable.
+	 */
+	if (entry->function == 0x80000008)
+		entry->eax = tdx_set_guest_phys_addr_bits(entry->eax, 0xff);
+}
+
+static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
+			     struct kvm_tdx_capabilities *caps)
+{
+	int i;
+
+	caps->supported_attrs = tdx_get_supported_attrs(td_conf);
+	if (!caps->supported_attrs)
+		return -EIO;
+
+	caps->supported_xfam = tdx_get_supported_xfam(td_conf);
+	if (!caps->supported_xfam)
+		return -EIO;
+
+	caps->cpuid.nent = td_conf->num_cpuid_config;
+
+	for (i = 0; i < td_conf->num_cpuid_config; i++)
+		td_init_cpuid_entry2(&caps->cpuid.entries[i], i);
+
+	return 0;
+}
+
+static int tdx_get_capabilities(struct kvm_tdx_cmd *cmd)
+{
+	const struct tdx_sys_info_td_conf *td_conf = &tdx_sysinfo->td_conf;
+	struct kvm_tdx_capabilities __user *user_caps;
+	struct kvm_tdx_capabilities *caps = NULL;
+	int ret = 0;
+
+	/* flags is reserved for future use */
+	if (cmd->flags)
+		return -EINVAL;
+
+	caps = kmalloc(sizeof(*caps) +
+		       sizeof(struct kvm_cpuid_entry2) * td_conf->num_cpuid_config,
+		       GFP_KERNEL);
+	if (!caps)
+		return -ENOMEM;
+
+	user_caps = u64_to_user_ptr(cmd->data);
+	if (copy_from_user(caps, user_caps, sizeof(*caps))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (caps->cpuid.nent < td_conf->num_cpuid_config) {
+		ret = -E2BIG;
+		goto out;
+	}
+
+	ret = init_kvm_tdx_caps(td_conf, caps);
+	if (ret)
+		goto out;
+
+	if (copy_to_user(user_caps, caps, sizeof(*caps))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (copy_to_user(user_caps->cpuid.entries, caps->cpuid.entries,
+			 caps->cpuid.nent *
+			 sizeof(caps->cpuid.entries[0])))
+		ret = -EFAULT;
+
+out:
+	/* kfree() accepts NULL. */
+	kfree(caps);
+	return ret;
+}
+
 int tdx_vm_ioctl(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_tdx_cmd tdx_cmd;
@@ -61,6 +186,9 @@ int tdx_vm_ioctl(struct kvm *kvm, void __user *argp)
 	mutex_lock(&kvm->lock);
 
 	switch (tdx_cmd.id) {
+	case KVM_TDX_CAPABILITIES:
+		r = tdx_get_capabilities(&tdx_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
@@ -160,11 +288,20 @@ static int __init __tdx_bringup(void)
 		goto get_sysinfo_err;
 	}
 
+	/* Check TDX module and KVM capabilities */
+	if (!tdx_get_supported_attrs(&tdx_sysinfo->td_conf) ||
+	    !tdx_get_supported_xfam(&tdx_sysinfo->td_conf))
+		goto get_sysinfo_err;
+
+	if (!(tdx_sysinfo->features.tdx_features0 & MD_FIELD_ID_FEATURES0_TOPOLOGY_ENUM))
+		goto get_sysinfo_err;
+
 	/*
 	 * Leave hardware virtualization enabled after TDX is enabled
 	 * successfully.  TDX CPU hotplug depends on this.
 	 */
 	return 0;
+
 get_sysinfo_err:
 	__tdx_cleanup();
 tdx_bringup_err:
diff --git a/arch/x86/kvm/vmx/tdx_arch.h b/arch/x86/kvm/vmx/tdx_arch.h
index fb7abe9fef8e..cb9a638fa398 100644
--- a/arch/x86/kvm/vmx/tdx_arch.h
+++ b/arch/x86/kvm/vmx/tdx_arch.h
@@ -120,4 +120,6 @@ struct td_params {
 #define TDX_MIN_TSC_FREQUENCY_KHZ		(100 * 1000)
 #define TDX_MAX_TSC_FREQUENCY_KHZ		(10 * 1000 * 1000)
 
+#define MD_FIELD_ID_FEATURES0_TOPOLOGY_ENUM	BIT_ULL(20)
+
 #endif /* __KVM_X86_TDX_ARCH_H */
-- 
2.43.5



