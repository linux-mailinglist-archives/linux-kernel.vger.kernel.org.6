Return-Path: <linux-kernel+bounces-319527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C60DC96FDE6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51EE5B26A84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447A15D5C5;
	Fri,  6 Sep 2024 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDrv7B0o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B515C15F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661125; cv=none; b=aiBVp7pbnxFCFSECZwkEVArVqbfoyVfiJy5zRLbtsAKy1Y0ELdVDvMpmbvQdRqvFVpD6IJlhyvUf/ke87iiOmfifhd+sPVUDFgwLjVBuCvTeHYSuMAAtIJiwJsdr1kVm4OsbQVJwhUyEJV6IJprOsROvVQ6jX9xK/WMkEDmVvkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661125; c=relaxed/simple;
	bh=6tQZjmV/dvfRxF9Li6PheFfIYhVI74ziIhgSAvvVHBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lxv0AV+AI3aYKzjWJM6F1HcpbI8Md5E5OTkI2jKUde1xSV8KIE91tbS5oxJqq/4YpUjmDLYMYKrRSb+T7iomp4n61iVI6HRxLoOcp1QMhO/O3DGonV15V5mMbvpDqsw8mhaWaY6z5UMRUZPcvsBfcfo4RM9wuIv0k/NCv3xt2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDrv7B0o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725661123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0h7tDFpwf6rA/v9oZ6Iu/uTgVzCCOgBsTcrjPUAZ4Jg=;
	b=WDrv7B0oZ8ULKfO3FzncRbapRwaHwLvBg/DDTG1+0tWtqn2LcsHhADUvxToJBFe2oO5ttq
	gJchXt5wcK11zXcOAC8THhJwde0W3KTlkTwSImbODxBBrFjKOmFpwJcoBG5FLtyvi71FMe
	hTHxOPdUygJeylHxp3FKpXplYz5C16Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-zx0tJ60dNVO2KPtU0Q28dg-1; Fri,
 06 Sep 2024 18:18:40 -0400
X-MC-Unique: zx0tJ60dNVO2KPtU0Q28dg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61B1B19560B2;
	Fri,  6 Sep 2024 22:18:38 +0000 (UTC)
Received: from starship.lan (unknown [10.22.65.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CB2C19560AA;
	Fri,  6 Sep 2024 22:18:35 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v4 4/4] KVM: nVMX: fix canonical check of vmcs12 HOST_RIP
Date: Fri,  6 Sep 2024 18:18:24 -0400
Message-Id: <20240906221824.491834-5-mlevitsk@redhat.com>
In-Reply-To: <20240906221824.491834-1-mlevitsk@redhat.com>
References: <20240906221824.491834-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

HOST_RIP canonical check should check the L1 of CR4.LA57 stored in
the vmcs12 rather than the current L1's because it is legal to change
the CR4.LA57 value during VM exit from L2 to L1.

This is a theoretical bug though, because it is highly unlikely that a
VM exit will change the CR4.LA57 from the value it had on VM entry.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a7b0674094473..38c9d3077d17a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2969,6 +2969,17 @@ static int nested_vmx_check_address_space_size(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static bool is_l1_noncanonical_address_on_vmexit(u64 la, struct vmcs12 *vmcs12)
+{
+	/*
+	 * Check that the given linear address is canonical after a VM exit
+	 * from L2, based on HOST_CR4.LA57 value that will be loaded then.
+	 */
+	u8 l1_address_bits_on_exit = (vmcs12->host_cr4 & X86_CR4_LA57) ? 57 : 48;
+
+	return !__is_canonical_address(la, l1_address_bits_on_exit);
+}
+
 static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 				       struct vmcs12 *vmcs12)
 {
@@ -3019,7 +3030,7 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 	    CC(is_noncanonical_base_address(vmcs12->host_gdtr_base, vcpu)) ||
 	    CC(is_noncanonical_base_address(vmcs12->host_idtr_base, vcpu)) ||
 	    CC(is_noncanonical_base_address(vmcs12->host_tr_base, vcpu)) ||
-	    CC(is_noncanonical_address(vmcs12->host_rip, vcpu, 0)))
+	    CC(is_l1_noncanonical_address_on_vmexit(vmcs12->host_rip, vmcs12)))
 		return -EINVAL;
 
 	/*
-- 
2.26.3


