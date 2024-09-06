Return-Path: <linux-kernel+bounces-319525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1009F96FDE1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918E31F22742
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03E15B12A;
	Fri,  6 Sep 2024 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5Iwj3x1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAF15A87C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661119; cv=none; b=WdCMeiMTh05YzMXkDfHJQ8hDV+2d3oQF0frWIrZ+J91q8sJH2nqYJyk1F5o3xILbiVuG1FDvvzqj81i7D0gAO4GxGAO66Qlr9XnqBVS4jsa+GGkC45YEbZDvUAYzg71bdWK4BiTQrWzTUchYRQwcc3H6b7451GIPELRV9+ddeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661119; c=relaxed/simple;
	bh=RS7D6mC4Da90DJpRr6QUg5QrkEyp0IY6qq6xuCpONVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAJbmKBzYkOXP8c8HC1OrRr/OhjsB5EFKr3rGcBbxcM1xwRF5Py04pyvueccTqc9Mwa2MgK0vF/b6iT6hUWF2V8jJaaYcOMqKrYf5NoCjsAQCbDQXQ1iDOV/h37OXNX1xjaTLYnniArZ3zbiwKy+Vo8ZN0oKq8NtQ2h4txqVvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5Iwj3x1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725661116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LI5BD+pBOFIg79aPAmGwcLGYrtd2fLuNLyhnq+3LnKk=;
	b=L5Iwj3x1D2rkToN2+7HKdnFg2WMHoklAninHVvlnl4QLtxBKkdfoblrt2ALXR5y6OUj9SM
	JGuTxN1qu90j2Af4NgdX1bYCFw1viNMN+QQIjouzGZ6Zz3o2q7yizRIQuJS6Y/PlNawn0/
	SLBUfu9piQKLho6Fv1yZO351dOJ11vY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-1t18F8_JMZGW5uTg1IDnng-1; Fri,
 06 Sep 2024 18:18:35 -0400
X-MC-Unique: 1t18F8_JMZGW5uTg1IDnng-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50A5F1956077;
	Fri,  6 Sep 2024 22:18:33 +0000 (UTC)
Received: from starship.lan (unknown [10.22.65.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E2B019560AA;
	Fri,  6 Sep 2024 22:18:30 +0000 (UTC)
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
Subject: [PATCH v4 2/4] KVM: x86: implement emul_is_noncanonical_address using is_noncanonical_address
Date: Fri,  6 Sep 2024 18:18:22 -0400
Message-Id: <20240906221824.491834-3-mlevitsk@redhat.com>
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

Implement the emul_is_noncanonical_address() using
is_noncanonical_address().

This will allow to extend the is_noncanonical_address() to support
different flavors of canonical checks.

Also add X86EMUL_F_MSR and X86EMUL_F_DT_LOAD emulation flags which will be
used to indicate an emulation of a msr or a segment base load, which
will affect the required canonical check.

No functional change is intended.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/emulate.c     | 15 +++++++++------
 arch/x86/kvm/kvm_emulate.h |  5 +++++
 arch/x86/kvm/x86.c         |  7 +++++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index e72aed25d7212..8c8061884a019 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -651,9 +651,10 @@ static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
 }
 
 static inline bool emul_is_noncanonical_address(u64 la,
-						struct x86_emulate_ctxt *ctxt)
+						struct x86_emulate_ctxt *ctxt,
+						unsigned int flags)
 {
-	return !__is_canonical_address(la, ctxt_virt_addr_bits(ctxt));
+	return !ctxt->ops->is_canonical_addr(ctxt, la, 0);
 }
 
 /*
@@ -1733,7 +1734,8 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 		if (emul_is_noncanonical_address(get_desc_base(&seg_desc) |
-						 ((u64)base3 << 32), ctxt))
+						 ((u64)base3 << 32), ctxt,
+						 X86EMUL_F_DT_LOAD))
 			return emulate_gp(ctxt, err_code);
 	}
 
@@ -2516,8 +2518,8 @@ static int em_sysexit(struct x86_emulate_ctxt *ctxt)
 		ss_sel = cs_sel + 8;
 		cs.d = 0;
 		cs.l = 1;
-		if (emul_is_noncanonical_address(rcx, ctxt) ||
-		    emul_is_noncanonical_address(rdx, ctxt))
+		if (emul_is_noncanonical_address(rcx, ctxt, 0) ||
+		    emul_is_noncanonical_address(rdx, ctxt, 0))
 			return emulate_gp(ctxt, 0);
 		break;
 	}
@@ -3494,7 +3496,8 @@ static int em_lgdt_lidt(struct x86_emulate_ctxt *ctxt, bool lgdt)
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 	if (ctxt->mode == X86EMUL_MODE_PROT64 &&
-	    emul_is_noncanonical_address(desc_ptr.address, ctxt))
+	    emul_is_noncanonical_address(desc_ptr.address, ctxt,
+					 X86EMUL_F_DT_LOAD))
 		return emulate_gp(ctxt, 0);
 	if (lgdt)
 		ctxt->ops->set_gdt(ctxt, &desc_ptr);
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 55a18e2f2dcd9..86bde1c9d9183 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -94,6 +94,8 @@ struct x86_instruction_info {
 #define X86EMUL_F_FETCH			BIT(1)
 #define X86EMUL_F_IMPLICIT		BIT(2)
 #define X86EMUL_F_INVLPG		BIT(3)
+#define X86EMUL_F_MSR			BIT(4)
+#define X86EMUL_F_DT_LOAD		BIT(5)
 
 struct x86_emulate_ops {
 	void (*vm_bugged)(struct x86_emulate_ctxt *ctxt);
@@ -235,6 +237,9 @@ struct x86_emulate_ops {
 
 	gva_t (*get_untagged_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
 				   unsigned int flags);
+
+	bool (*is_canonical_addr)(struct x86_emulate_ctxt *ctxt,
+				  gva_t addr, unsigned int flags);
 };
 
 /* Type, address-of, and value of an instruction's operand. */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f72e5d89e942d..f496830445355 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8617,6 +8617,12 @@ static gva_t emulator_get_untagged_addr(struct x86_emulate_ctxt *ctxt,
 					       addr, flags);
 }
 
+static bool emulator_is_canonical_addr(struct x86_emulate_ctxt *ctxt,
+				       gva_t addr, unsigned int flags)
+{
+	return !is_noncanonical_address(addr, emul_to_vcpu(ctxt));
+}
+
 static const struct x86_emulate_ops emulate_ops = {
 	.vm_bugged           = emulator_vm_bugged,
 	.read_gpr            = emulator_read_gpr,
@@ -8663,6 +8669,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.triple_fault        = emulator_triple_fault,
 	.set_xcr             = emulator_set_xcr,
 	.get_untagged_addr   = emulator_get_untagged_addr,
+	.is_canonical_addr   = emulator_is_canonical_addr,
 };
 
 static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
-- 
2.26.3


