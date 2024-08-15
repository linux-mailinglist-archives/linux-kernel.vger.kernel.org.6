Return-Path: <linux-kernel+bounces-287935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AEF952E58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1182855B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38FD19F467;
	Thu, 15 Aug 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaOvJ/GT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D019E7E6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725271; cv=none; b=uUErqxB2UfX1azzd2d+1qosrW1ichwkeTIO6acFaMwNP9G3BY2BWmkxT7i0vYo1RJKea2DQbq18N3x/v9j8Tcs+tw+Ds9p9gMr6/8VBzyXRCZ87UK5MccUt7bxqhJehBF71jjn6sFyu4JXLLblTJ+DrP2fEvQotCk2iqAuktUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725271; c=relaxed/simple;
	bh=BTvU0V68JrnBD9SFtmnXCAvdby6njq93GN+eVWG61RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VcOuhomNkKJb4UBLwX83BPNwjeweB/cRkT+vxWo/Jhc8m5La/flnFU/A4bi6w5lHFNtKucdfiImQmqWchx4hQRcS/XqXYcA5LdJEb6WADZpJrV1N73Ftxb5eQv+hZvO7RHXEeqdbLT85MoUQwyPiyE2J4ybjAR8ES3V+2uYQve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaOvJ/GT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723725268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQ9h83Jg9BQD71lxH7Tpfr7UezhIycA5sCHmxT4jZac=;
	b=DaOvJ/GTF828T5wIw7/ONU+XOcUEpxEwXQlEXLUcNFrGFU11we9s/Bmj20UPvZB/iukIg0
	pX6vxmm8H9LgDzWBvETpgaIedW4IPcHEb39fpmHl1GQAWd3DAP7Knu4W6RJA9chWIzM9mE
	N9N5AnHCs5MbJirX94mp6H0kn+WF5tY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-ilBqPnsNNMqnkiMqFmwjTA-1; Thu,
 15 Aug 2024 08:34:21 -0400
X-MC-Unique: ilBqPnsNNMqnkiMqFmwjTA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E96B91955D4C;
	Thu, 15 Aug 2024 12:34:19 +0000 (UTC)
Received: from intellaptop.lan (unknown [10.47.238.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E73E8300019C;
	Thu, 15 Aug 2024 12:34:15 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v3 3/4] KVM: nVMX: relax canonical checks on some x86 registers in vmx host state
Date: Thu, 15 Aug 2024 15:33:48 +0300
Message-Id: <20240815123349.729017-4-mlevitsk@redhat.com>
In-Reply-To: <20240815123349.729017-1-mlevitsk@redhat.com>
References: <20240815123349.729017-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Several x86's architecture registers contain a linear base, and thus must
contain a canonical address.

This includes segment and segment like bases (FS/GS base, GDT,IDT,LDT,TR),
addresses used for SYSENTER and SYSCALL instructions and probably more.

As it turns out, when x86 architecture was updated to 5 level paging /
57 bit virtual addresses, these fields were allowed to contain a full
57 bit address regardless of the state of CR4.LA57.

The main reason behind this decision is that 5 level paging, and even
paging itself can be temporarily disabled (e.g by SMM entry) leaving non
canonical values in these fields.
Another reason is that OS might prepare these fields before it switches to
5 level paging.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2392a7ef254d..3f18edff80ac 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2969,6 +2969,22 @@ static int nested_vmx_check_address_space_size(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static bool is_l1_noncanonical_address_static(u64 la, struct kvm_vcpu *vcpu)
+{
+	u8 max_guest_address_bits = guest_can_use(vcpu, X86_FEATURE_LA57) ? 57 : 48;
+	/*
+	 * Most x86 arch registers which contain linear addresses like
+	 * segment bases, addresses that are used in instructions (e.g SYSENTER),
+	 * have static canonicality checks,
+	 * size of whose depends only on CPU's support for 5-level
+	 * paging, rather than state of CR4.LA57.
+	 *
+	 * In other words the check only depends on the CPU model,
+	 * rather than on runtime state.
+	 */
+	return !__is_canonical_address(la, max_guest_address_bits);
+}
+
 static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 				       struct vmcs12 *vmcs12)
 {
@@ -2979,8 +2995,8 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 	    CC(!kvm_vcpu_is_legal_cr3(vcpu, vmcs12->host_cr3)))
 		return -EINVAL;
 
-	if (CC(is_noncanonical_address(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_ia32_sysenter_eip, vcpu)))
+	if (CC(is_l1_noncanonical_address_static(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
+	    CC(is_l1_noncanonical_address_static(vmcs12->host_ia32_sysenter_eip, vcpu)))
 		return -EINVAL;
 
 	if ((vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_PAT) &&
@@ -3014,11 +3030,11 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 	    CC(vmcs12->host_ss_selector == 0 && !ia32e))
 		return -EINVAL;
 
-	if (CC(is_noncanonical_address(vmcs12->host_fs_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_gs_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_gdtr_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_idtr_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_tr_base, vcpu)) ||
+	if (CC(is_l1_noncanonical_address_static(vmcs12->host_fs_base, vcpu)) ||
+	    CC(is_l1_noncanonical_address_static(vmcs12->host_gs_base, vcpu)) ||
+	    CC(is_l1_noncanonical_address_static(vmcs12->host_gdtr_base, vcpu)) ||
+	    CC(is_l1_noncanonical_address_static(vmcs12->host_idtr_base, vcpu)) ||
+	    CC(is_l1_noncanonical_address_static(vmcs12->host_tr_base, vcpu)) ||
 	    CC(is_noncanonical_address(vmcs12->host_rip, vcpu)))
 		return -EINVAL;
 
-- 
2.40.1


