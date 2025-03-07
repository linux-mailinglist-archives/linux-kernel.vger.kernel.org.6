Return-Path: <linux-kernel+bounces-551965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C46A5737B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D36189940A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3456225A2CC;
	Fri,  7 Mar 2025 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+NNLPEI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB645257455
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382470; cv=none; b=VkZLfRLoKMiiSjwPMDO6ZMqfu6U6ngqOMoPW+PijNWqv2CmkUGUhoGR8LGsj2dE1yb51AI9tssvlDm4pwIksvMgMK4Fhdbyj5XI7RbeMEoJ6V6o5uiwhcIxZ2iFl35z9yRH/jukIvHXW6nNiJbVxSJfwwirwku85HwZMA4nJ4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382470; c=relaxed/simple;
	bh=Iu90uo91gZmR9eP41bSNt7VgXBYPgN/mCxsGj4sNyy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnxcAkAsFrEBtvA9mMRZW6Nemlfh4pbFnOL6JXEk4AWnXox5StrfzdU7zcbXSL49eLb8b0B1s5DD9Mrs6f8Kl+6ZZ5y29/3zglop+rGglZWsZQO+NshIU1Y+knIjpzzXz1JKExgscdZ51b+HVs3iISE+txTzI0fM+Rj168YPtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+NNLPEI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741382467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhqxOCdwpm3SjcmNIEQYMzT7VbZwzQWwLf0OE0usH3Y=;
	b=V+NNLPEIKh7N80sHsI75p4Hizs5pDZmTH53o/u7mcfTcvyLgm1XygDf257zCHsZkehU2pL
	ez2sGi8WxqibJacLEYz48xtFgf59pz7BXBenf2CocBxq8IFws1NSzsZwoiLSY7M7zc44pI
	UF3hGPjiHGZJlEqG9Pnztea57LxBBDs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-5ZfgNgnCOLyde2Niruxu-Q-1; Fri,
 07 Mar 2025 16:21:04 -0500
X-MC-Unique: 5ZfgNgnCOLyde2Niruxu-Q-1
X-Mimecast-MFC-AGG-ID: 5ZfgNgnCOLyde2Niruxu-Q_1741382463
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01FB51800257;
	Fri,  7 Mar 2025 21:21:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCB001956095;
	Fri,  7 Mar 2025 21:21:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	adrian.hunter@intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH v3 05/10] KVM: TDX: restore host xsave state when exit from the guest TD
Date: Fri,  7 Mar 2025 16:20:47 -0500
Message-ID: <20250307212053.2948340-6-pbonzini@redhat.com>
In-Reply-To: <20250307212053.2948340-1-pbonzini@redhat.com>
References: <20250307212053.2948340-1-pbonzini@redhat.com>
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

On exiting from the guest TD, xsave state is clobbered; restore it.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <20250129095902.16391-8-adrian.hunter@intel.com>
[Rewrite to not use kvm_load_host_xsave_state. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/tdx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 94e08fdcb775..b2948318cd8b 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2,6 +2,7 @@
 #include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <asm/cpufeature.h>
+#include <asm/fpu/xcr.h>
 #include <linux/misc_cgroup.h>
 #include <linux/mmu_context.h>
 #include <asm/tdx.h>
@@ -735,6 +736,30 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 				 BIT_ULL(VCPU_REGS_R14) | \
 				 BIT_ULL(VCPU_REGS_R15))
 
+static void tdx_load_host_xsave_state(struct kvm_vcpu *vcpu)
+{
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
+
+	/*
+	 * All TDX hosts support PKRU; but even if they didn't,
+	 * vcpu->arch.host_pkru would be 0 and the wrpkru would be
+	 * skipped.
+	 */
+	if (vcpu->arch.host_pkru != 0)
+		wrpkru(vcpu->arch.host_pkru);
+
+	if (kvm_host.xcr0 != (kvm_tdx->xfam & kvm_caps.supported_xcr0))
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, kvm_host.xcr0);
+
+	/*
+	 * Likewise, even if a TDX hosts didn't support XSS both arms of
+	 * the comparison would be 0 and the wrmsrl would be skipped.
+	 */
+	if (kvm_host.xss != (kvm_tdx->xfam & kvm_caps.supported_xss))
+		wrmsrl(MSR_IA32_XSS, kvm_host.xss);
+}
+EXPORT_SYMBOL_GPL(kvm_load_host_xsave_state);
+
 fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 {
 	/*
@@ -751,6 +776,8 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 
 	tdx_vcpu_enter_exit(vcpu);
 
+	tdx_load_host_xsave_state(vcpu);
+
 	vcpu->arch.regs_avail &= TDX_REGS_AVAIL_SET;
 
 	trace_kvm_exit(vcpu, KVM_ISA_VMX);
@@ -2326,6 +2353,11 @@ int __init tdx_bringup(void)
 		goto success_disable_tdx;
 	}
 
+	if (!cpu_feature_enabled(X86_FEATURE_OSXSAVE)) {
+		pr_err("tdx: OSXSAVE is required for TDX\n");
+		goto success_disable_tdx;
+	}
+
 	if (!cpu_feature_enabled(X86_FEATURE_MOVDIR64B)) {
 		pr_err("tdx: MOVDIR64B is required for TDX\n");
 		goto success_disable_tdx;
-- 
2.43.5



