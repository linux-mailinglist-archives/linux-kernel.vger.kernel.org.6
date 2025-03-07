Return-Path: <linux-kernel+bounces-551967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB56A57381
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BC418992DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017625B66C;
	Fri,  7 Mar 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGlDntaq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275325A322
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382473; cv=none; b=RKChrWIeMS7TSaDySyAcdbjq3oYPZsfzOR/ud8rmDtiKn/TvMIPbJ+OVRIsbTRNIpRkrE4MnmA/hOHUnIxPUu/dZS37jwrus6ubfyUD+up6EikQEwS49SwVjRLv6lyi2tqlI2xYNOjk7c596IowWxsR+rKKLELO+qRyFQ4KZBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382473; c=relaxed/simple;
	bh=q7Glpxlg610EEIiFyoQN8EDiz9n8zJa6Uia0lh7xLvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEnAzqeyMcBD4Olam0kJc7gsjf2Bfh4hzR9O6ohEZNWOcTtoVM1ZHigt1Qizs1J/2MT3CfkTMTklqpDKnTLA3j1h6iNyBautSYRB35czl+eF3gdhWqlqIrcHtcsxDIEYHNoaW0vYPyYfcEnTFQ6MlF/UgS217KEBDqT6tvglyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGlDntaq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741382471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BlJw8j3K8cDMA/p6YPAw1OD5bEMQ1TGBjpONE/PRmg=;
	b=gGlDntaqoMuBlRuisHs8+3GhXk0Zq+lhHeEwvR60RxEnT4IANIrCLjYQ7iasaMTdIK/KsN
	pSJ+TZWqgn7JONa5hl4OVarYmuf+ELPSXjsCGZ8/rdcy4v5U9n4iuF/32HKjNxNQ1mksnH
	d7/gO+lGWPwxA+tUJSejg3KjnGCZtxk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-U6nnK0bzMj6OdwHtfTOS3A-1; Fri,
 07 Mar 2025 16:21:07 -0500
X-MC-Unique: U6nnK0bzMj6OdwHtfTOS3A-1
X-Mimecast-MFC-AGG-ID: U6nnK0bzMj6OdwHtfTOS3A_1741382466
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41E881800258;
	Fri,  7 Mar 2025 21:21:06 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADE2C1956095;
	Fri,  7 Mar 2025 21:21:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: xiaoyao.li@intel.com,
	adrian.hunter@intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>
Subject: [PATCH v3 07/10] KVM: TDX: restore user ret MSRs
Date: Fri,  7 Mar 2025 16:20:49 -0500
Message-ID: <20250307212053.2948340-8-pbonzini@redhat.com>
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

Several user ret MSRs are clobbered on TD exit.  Ensure the MSR cache is
updated on vcpu_put, and the MSRs themselves before returning to ring 3.

Co-developed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20250129095902.16391-10-adrian.hunter@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/tdx.c | 51 +++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/tdx.h |  1 +
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b2948318cd8b..5819ed926166 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -646,9 +646,32 @@ void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	vt->guest_state_loaded = true;
 }
 
+struct tdx_uret_msr {
+	u32 msr;
+	unsigned int slot;
+	u64 defval;
+};
+
+static struct tdx_uret_msr tdx_uret_msrs[] = {
+	{.msr = MSR_SYSCALL_MASK, .defval = 0x20200 },
+	{.msr = MSR_STAR,},
+	{.msr = MSR_LSTAR,},
+	{.msr = MSR_TSC_AUX,},
+};
+
+static void tdx_user_return_msr_update_cache(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tdx_uret_msrs); i++)
+		kvm_user_return_msr_update_cache(tdx_uret_msrs[i].slot,
+						 tdx_uret_msrs[i].defval);
+}
+
 static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt = to_vt(vcpu);
+	struct vcpu_tdx *tdx = to_tdx(vcpu);
 
 	if (!vt->guest_state_loaded)
 		return;
@@ -656,6 +679,11 @@ static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
 	++vcpu->stat.host_state_reload;
 	wrmsrl(MSR_KERNEL_GS_BASE, vt->msr_host_kernel_gs_base);
 
+	if (tdx->guest_entered) {
+		tdx_user_return_msr_update_cache();
+		tdx->guest_entered = false;
+	}
+
 	vt->guest_state_loaded = false;
 }
 
@@ -762,6 +790,8 @@ EXPORT_SYMBOL_GPL(kvm_load_host_xsave_state);
 
 fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 {
+	struct vcpu_tdx *tdx = to_tdx(vcpu);
+
 	/*
 	 * force_immediate_exit requires vCPU entering for events injection with
 	 * an immediately exit followed. But The TDX module doesn't guarantee
@@ -777,6 +807,7 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	tdx_vcpu_enter_exit(vcpu);
 
 	tdx_load_host_xsave_state(vcpu);
+	tdx->guest_entered = true;
 
 	vcpu->arch.regs_avail &= TDX_REGS_AVAIL_SET;
 
@@ -2236,7 +2267,25 @@ static int __init __do_tdx_bringup(void)
 static int __init __tdx_bringup(void)
 {
 	const struct tdx_sys_info_td_conf *td_conf;
-	int r;
+	int r, i;
+
+	for (i = 0; i < ARRAY_SIZE(tdx_uret_msrs); i++) {
+		/*
+		 * Check if MSRs (tdx_uret_msrs) can be saved/restored
+		 * before returning to user space.
+		 *
+		 * this_cpu_ptr(user_return_msrs)->registered isn't checked
+		 * because the registration is done at vcpu runtime by
+		 * tdx_user_return_msr_update_cache().
+		 */
+		tdx_uret_msrs[i].slot = kvm_find_user_return_msr(tdx_uret_msrs[i].msr);
+		if (tdx_uret_msrs[i].slot == -1) {
+			/* If any MSR isn't supported, it is a KVM bug */
+			pr_err("MSR %x isn't included by kvm_find_user_return_msr\n",
+				tdx_uret_msrs[i].msr);
+			return -EIO;
+		}
+	}
 
 	/*
 	 * Enabling TDX requires enabling hardware virtualization first,
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index 6eb24bbacccc..55af3d866ff6 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -56,6 +56,7 @@ struct vcpu_tdx {
 	u64 vp_enter_ret;
 
 	enum vcpu_tdx_state state;
+	bool guest_entered;
 };
 
 void tdh_vp_rd_failed(struct vcpu_tdx *tdx, char *uclass, u32 field, u64 err);
-- 
2.43.5



