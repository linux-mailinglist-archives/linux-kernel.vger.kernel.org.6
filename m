Return-Path: <linux-kernel+bounces-287933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE4E952E55
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD88E1C22351
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C7719AD87;
	Thu, 15 Aug 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHTp1xqD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059517C9AF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725264; cv=none; b=bh48JZMYGLSS06J+LcnOPdV2TBjEdLPetSm0xi/Wt6P6Hf112CU+zKbR1tgiQ01TNcwe4txJ+4tG+Ku3Kk3Df4VzDBWvvkDg5YlplFLwGVLzJ5qfeuvArgjn/EN3ztlQoqqPWf6fQCMTC6Fk4hSoUabb5qg93JQxyZH8+3dg71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725264; c=relaxed/simple;
	bh=qA/vjHiFuW33Gns/1do2oaIyFzXBTSLeYtUza0ruWTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGvTc9C64opdN3Gi175DWwfdr/3W0AmbXaL2jTSroJV1UEUoPBDclARmJlHK2OALPtfZMNZ5vPumjitIlMkLP+d2jsbSn0g8kkGmG7O+b7WqyJb7sjhZl0U1GNPAHIOV04917dYh1yC5fNY5D0UCnpjhLxuKPgnr9RauAf39p48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHTp1xqD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723725262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zYUq9vCVBL/ellLmExJameIYyfLb7npz24FshDuo5o=;
	b=cHTp1xqDJnHUwn+tfSeaTtgAEbXrirQGo+XvucaVDK/k3N/vr5A5e/aFNnM3zUHT4eqk5M
	LC5M5A27ppU7RJL7mlIXACawnhCAcCmkXxnHmIteyW2yIwa9rt9FRcBBY9doQW84mtdugQ
	lUFpmzc/9GYki72x1qD8V8HEZmeoAWE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-l6v2RgwSPcWBheuRwWqcqA-1; Thu,
 15 Aug 2024 08:34:17 -0400
X-MC-Unique: l6v2RgwSPcWBheuRwWqcqA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66E991956048;
	Thu, 15 Aug 2024 12:34:15 +0000 (UTC)
Received: from intellaptop.lan (unknown [10.47.238.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F007C300019C;
	Thu, 15 Aug 2024 12:34:10 +0000 (UTC)
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
Subject: [PATCH v3 2/4] KVM: x86: add X86_FEATURE_LA57 to governed_features
Date: Thu, 15 Aug 2024 15:33:47 +0300
Message-Id: <20240815123349.729017-3-mlevitsk@redhat.com>
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

Guest support for X86_FEATURE_LA57 will need to be tested to determine
canonical width check for nested VMX VM entries.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/cpuid.c             | 2 ++
 arch/x86/kvm/governed_features.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2617be544480..1a2d3fbe9a59 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -373,6 +373,8 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (allow_gbpages)
 		kvm_governed_feature_set(vcpu, X86_FEATURE_GBPAGES);
 
+	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_LA57);
+
 	best = kvm_find_cpuid_entry(vcpu, 1);
 	if (best && apic) {
 		if (cpuid_entry_has(best, X86_FEATURE_TSC_DEADLINE_TIMER))
diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index ad463b1ed4e4..475171f2fd49 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -17,6 +17,7 @@ KVM_GOVERNED_X86_FEATURE(PFTHRESHOLD)
 KVM_GOVERNED_X86_FEATURE(VGIF)
 KVM_GOVERNED_X86_FEATURE(VNMI)
 KVM_GOVERNED_X86_FEATURE(LAM)
+KVM_GOVERNED_X86_FEATURE(LA57)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
-- 
2.40.1


