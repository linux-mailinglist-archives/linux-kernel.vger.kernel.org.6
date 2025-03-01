Return-Path: <linux-kernel+bounces-539828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA19A4A97D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275E43B6775
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E321CAA68;
	Sat,  1 Mar 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bfg/rOE9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B813E41A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740814477; cv=none; b=mXRcWLVnfg8g2xY7PR5UpO/Ju/mkh497UxSG+1mqvi6XqCNo5TeTcjcIU2w1AIgNJn/SwxtndnfrR3eBIDafdbEg928dfgvld6R/1G97yzZVgp1lKDsirVvglt+dIspVn6wwdpMs2uZeqCekN6wwmvk7qUWultWlQOtjVyIGLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740814477; c=relaxed/simple;
	bh=DtG47iRANC5wZLgg0LnqyN8qTPJehZD/bILJ9tpVnw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhZVzAIUGzAHOa35SkOnwPB/RH9Sp3cLt6ar1uJwrv4dsTSLv8DPnRIqh9EoTDzHKbcSLj35XktModgdUoCcUZ6gZZB0vQ4WTTBVRK/o981/rlOr25DSDBwXaoPlI3/We38sJI8+SpW1e9vkeDkLSifrw7xAUe8VhjDfJgpE1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bfg/rOE9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740814473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2tPBmgIhCufUhRamCTf9UFIDJg21WLE0DY219BoGCQ=;
	b=Bfg/rOE9tJR2axP0tuZbjgWPDCAqt87ozCM4qkckt3DEBl1W0x3U0vh2c2FBiUT0NYX6v2
	5BoywD+9r34StUOzxNEnMBcwLsODKr2ZQcpZKIOpRhFvplMY+cCAEqIpWc62N4Lsuxrgop
	7+SHtdm4O9va/M/WUCZ/yOJIYceKV1w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-e3AQlyKZPDio4mgbSPJI_w-1; Sat,
 01 Mar 2025 02:34:32 -0500
X-MC-Unique: e3AQlyKZPDio4mgbSPJI_w-1
X-Mimecast-MFC-AGG-ID: e3AQlyKZPDio4mgbSPJI_w_1740814471
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BEB219373D7;
	Sat,  1 Mar 2025 07:34:31 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97A5A19560AE;
	Sat,  1 Mar 2025 07:34:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	yan.y.zhao@intel.com
Subject: [PATCH 1/4] KVM: x86: Allow vendor code to disable quirks
Date: Sat,  1 Mar 2025 02:34:25 -0500
Message-ID: <20250301073428.2435768-2-pbonzini@redhat.com>
In-Reply-To: <20250301073428.2435768-1-pbonzini@redhat.com>
References: <20250301073428.2435768-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In some cases, the handling of quirks is split between platform-specific
code and generic code, or it is done entirely in generic code, but the
relevant bug does not trigger on some platforms; for example,
KVM_X86_QUIRK_CD_NW_CLEARED is only applicable to AMD systems.  In that
case, allow unaffected vendor modules to disable handling of the quirk.

The quirk remains available in KVM_CAP_DISABLE_QUIRKS2, because that API
tells userspace that KVM *knows* that some of its past behavior was bogus
or just undesirable.  In other words, it's plausible for userspace to
refuse to run if a quirk is not listed by KVM_CAP_DISABLE_QUIRKS2.

In kvm_check_has_quirk(), in addition to checking if a quirk is not
explicitly disabled by the user, also verify if the quirk applies to
the hardware.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20250224070832.31394-1-yan.y.zhao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c |  1 +
 arch/x86/kvm/x86.c     |  1 +
 arch/x86/kvm/x86.h     | 12 +++++++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 486fbdb4365c..75df4caea2f7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8506,6 +8506,7 @@ __init int vmx_hardware_setup(void)
 
 	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
 
+	kvm_caps.inapplicable_quirks = KVM_X86_QUIRK_CD_NW_CLEARED;
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 856ceeb4fb35..fd0a44e59314 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9775,6 +9775,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
 	}
+	kvm_caps.inapplicable_quirks = 0;
 
 	rdmsrl_safe(MSR_EFER, &kvm_host.efer);
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 8ce6da98b5a2..9af199c8e5c8 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -34,6 +34,7 @@ struct kvm_caps {
 	u64 supported_xcr0;
 	u64 supported_xss;
 	u64 supported_perf_cap;
+	u64 inapplicable_quirks;
 };
 
 struct kvm_host_values {
@@ -354,11 +355,6 @@ static inline void kvm_register_write(struct kvm_vcpu *vcpu,
 	return kvm_register_write_raw(vcpu, reg, val);
 }
 
-static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
-{
-	return !(kvm->arch.disabled_quirks & quirk);
-}
-
 void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
 
 u64 get_kvmclock_ns(struct kvm *kvm);
@@ -394,6 +390,12 @@ extern struct kvm_host_values kvm_host;
 
 extern bool enable_pmu;
 
+static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
+{
+	u64 disabled_quirks = kvm_caps.inapplicable_quirks | kvm->arch.disabled_quirks;
+	return !(disabled_quirks & quirk);
+}
+
 /*
  * Get a filtered version of KVM's supported XCR0 that strips out dynamic
  * features for which the current process doesn't (yet) have permission to use.
-- 
2.43.5



