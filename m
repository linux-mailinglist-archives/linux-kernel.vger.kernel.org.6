Return-Path: <linux-kernel+bounces-534825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F3DA46B88
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C899416D19B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD925256C9A;
	Wed, 26 Feb 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnJpJWti"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961E8263C86
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599753; cv=none; b=lcswsjlq45F6LViJ9OPdHr+0naas25rTP3KXLAO4i3Jld44PGJf0/ys2wtXE0QNMjEDLASwt72E1c+Rs6xcpT9OaZqG18UfaQKaONGCS48ov8JORpYK7fv20HhPXOYhXNcgkLjLw04CC78cJl1p7UCN2ljjIJouZcgr4hJsa66E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599753; c=relaxed/simple;
	bh=3orAe8jekjI8BkEIQtuhWJlbMMIReRv2qLBvQ16HpA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDhOoRL/VTqINricMbG6eIZ/73mTTDz8QJXPhWbFXH9seIdzw9D7I01iKcBh7Ghng3Kp4OrSq7FDpRpFX2MeEDOcASPIGTclbXrvTSF65+MHyShCizEs+IryaCgY0MKMejytebDhrR8+EcJSDCcWWhBHtW8mAH4mV2F8zFMMN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnJpJWti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740599750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUMbv+V8CYR6UPN0wtPtSTtVxX9cStGwiQQlkrC9phM=;
	b=BnJpJWtiekhLOjcuvjXSEdk9YKzkej4zYzkT7lWKPSoYKWKk9dVJTy1NtbOX56mriFB+tF
	6v6P9YR4S8qN6JuDSSkfjC6Q6j9HcQMd+bRW6718Hk8zwECz97ZGHKzGtiuyBlI0OgvvhV
	2XLHCC24j5ZtZuyU9J6mURGSkd9PDXQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-jBwAYo_KMJqMbS9meJUbGQ-1; Wed,
 26 Feb 2025 14:55:47 -0500
X-MC-Unique: jBwAYo_KMJqMbS9meJUbGQ-1
X-Mimecast-MFC-AGG-ID: jBwAYo_KMJqMbS9meJUbGQ_1740599746
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC9681800871;
	Wed, 26 Feb 2025 19:55:45 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2130C300018D;
	Wed, 26 Feb 2025 19:55:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 10/29] KVM: VMX: Teach EPT violation helper about private mem
Date: Wed, 26 Feb 2025 14:55:10 -0500
Message-ID: <20250226195529.2314580-11-pbonzini@redhat.com>
In-Reply-To: <20250226195529.2314580-1-pbonzini@redhat.com>
References: <20250226195529.2314580-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Teach EPT violation helper to check shared mask of a GPA to find out
whether the GPA is for private memory.

When EPT violation is triggered after TD accessing a private GPA, KVM will
exit to user space if the corresponding GFN's attribute is not private.
User space will then update GFN's attribute during its memory conversion
process. After that, TD will re-access the private GPA and trigger EPT
violation again. Only with GFN's attribute matches to private, KVM will
fault in private page, map it in mirrored TDP root, and propagate changes
to private EPT to resolve the EPT violation.

Relying on GFN's attribute tracking xarray to determine if a GFN is
private, as for KVM_X86_SW_PROTECTED_VM, may lead to endless EPT
violations.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20241112073539.22056-1-yan.y.zhao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/common.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 78ae39b6cdcd..7a592467a044 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -6,6 +6,12 @@
 
 #include "mmu.h"
 
+static inline bool vt_is_tdx_private_gpa(struct kvm *kvm, gpa_t gpa)
+{
+	/* For TDX the direct mask is the shared mask. */
+	return !kvm_is_addr_direct(kvm, gpa);
+}
+
 static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 					     unsigned long exit_qualification)
 {
@@ -28,6 +34,9 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
 			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
 
+	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa))
+		error_code |= PFERR_PRIVATE_ACCESS;
+
 	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
 }
 
-- 
2.43.5



