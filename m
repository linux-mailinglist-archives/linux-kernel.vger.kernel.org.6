Return-Path: <linux-kernel+bounces-253259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3E931EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511C01C210B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F02134A9;
	Tue, 16 Jul 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYxv5JjB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9CD6FC1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096430; cv=none; b=K2zTWjPVUEqYwpZT83g3cuXQsHVOL256IiNXMvD13LVWBaWsOdvdc/Tg59kIY7eFQDjkIBBZP7zRcR88u8w5BWMFt2omuPRKtItRNbuq2BuwyZYUn/D4oqXHYtgmOFKUHYsbINad6UkcHVtmecDtBCtaSjVCjsiOjhi558o7RrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096430; c=relaxed/simple;
	bh=Efhe9urfMft9oi0jZu7f2pCSZUo+qOd30iufUI8lVAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POG3io+NVB9e61KYCwl1a61MRGlO3AeMOQJG1fvw/+DbUQ/fOU7xRs43WmQxioUaAARcFExHONya+zGwfRLzYLBEsbfydL8h+vHaXIjmHD16euYz/rQG+qDdajK+mYX+/4ytxwpjSVkFFrtziYBpp/C4pH9lh+BhRQHhYjKbyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYxv5JjB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721096427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=of9I7xvSvBaWtba7lyO/bYSyy6ehuMmJgdbcS7kyTbw=;
	b=FYxv5JjB/gD+0DEZ/UM6X6iEyyJQOPu+f9D7vfXcQTqOfV1TTg4GjgxycVoU0lEwkFD+sy
	iCHoy4xAlY6mR8PjHPUktJgDC0yrcXpocjo+kqi41AD4gRWp9Ewz1p97q2oxrLXhGsUawo
	+lleV3xh9ls4hj9XOJuYI/6dkCVYfXY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-UrnacVnVNSawSMISG38QzQ-1; Mon,
 15 Jul 2024 22:20:21 -0400
X-MC-Unique: UrnacVnVNSawSMISG38QzQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0700A195609E;
	Tue, 16 Jul 2024 02:20:20 +0000 (UTC)
Received: from starship.lan (unknown [10.22.8.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6F601955F66;
	Tue, 16 Jul 2024 02:20:17 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 1/2] KVM: nVMX: use vmx_segment_cache_clear
Date: Mon, 15 Jul 2024 22:20:13 -0400
Message-Id: <20240716022014.240960-2-mlevitsk@redhat.com>
In-Reply-To: <20240716022014.240960-1-mlevitsk@redhat.com>
References: <20240716022014.240960-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In prepare_vmcs02_rare, call vmx_segment_cache_clear, instead
of setting the segment_cache.bitmask directly.

No functional change intended.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 5 +++--
 arch/x86/kvm/vmx/vmx.c    | 4 ----
 arch/x86/kvm/vmx/vmx.h    | 5 +++++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 643935a0f70ab..d3ca1a772ae67 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2469,6 +2469,9 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 
 	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
 			   HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
+
+		vmx_segment_cache_clear(vmx);
+
 		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
 		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
 		vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
@@ -2505,8 +2508,6 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
 		vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
 		vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
-
-		vmx->segment_cache.bitmask = 0;
 	}
 
 	if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b3c83c06f8265..fa9f307d9b18b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -524,10 +524,6 @@ static const struct kvm_vmx_segment_field {
 	VMX_SEGMENT_FIELD(LDTR),
 };
 
-static inline void vmx_segment_cache_clear(struct vcpu_vmx *vmx)
-{
-	vmx->segment_cache.bitmask = 0;
-}
 
 static unsigned long host_idt_base;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 7b64e271a9319..1689f0d59f435 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -755,4 +755,9 @@ static inline bool vmx_can_use_ipiv(struct kvm_vcpu *vcpu)
 	return  lapic_in_kernel(vcpu) && enable_ipiv;
 }
 
+static inline void vmx_segment_cache_clear(struct vcpu_vmx *vmx)
+{
+	vmx->segment_cache.bitmask = 0;
+}
+
 #endif /* __KVM_X86_VMX_H */
-- 
2.26.3


