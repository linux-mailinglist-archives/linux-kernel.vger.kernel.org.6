Return-Path: <linux-kernel+bounces-289696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B2954AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42CB1F21D55
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7001E1B86E3;
	Fri, 16 Aug 2024 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnvyayI8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855C191F78
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813294; cv=none; b=jhSJpUag+k1N1BtI00XCotQkfRruREEz5YGhcPseACHXUJGhkdrzO1mCLUhGpUC4AvAmFfMlwX0/G83eIzUgFjdafE/6w6gAuHJeTYp9gT6VBSMZapxNPWhC1WK1YwxbZeVtwvugobOOX9tK+WEdWjYUX5E+TGgp2u0QtK6GHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813294; c=relaxed/simple;
	bh=yN8D3jLA4C3tYPjY12G4kOC6cJolY8eMLg2OuRxHKwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qzcZ20JMAV0ZBNbVEJ46hmfDxn7b8FsDnck5j3frPKWT5AWFqLlqEYEgSIUEKy4rT/JCg2tXmCpVOfXqB5v+zHIoSd7ENLsiOVGAbbVS9BkrgsbcNOs0NgVcIGEl3IgvK6cQckNqQEjpPXzODjvyZtgR5fs/71O4BA4gXJjAFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnvyayI8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723813292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yi0TSacbKqXq5yNbiW+EAFSO47xRtRnE3Rn8A+AM4jA=;
	b=hnvyayI80Sb3hDeLesRwXYZerpGmEHKdorni7LXXCegc9uVX6YA+KMaVUZDdqfqQgN4dEu
	HmyUg/q7IRSPHNWAn7k7Gj+ti1qDr9w2kiKiDJhLIcMqKsMOSq8+iZsqDlZp2FBUX/Dsnq
	EX4KRuTMw0PZxSZckJX1F2DpMyTrA2E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-3p9r_sfoM6GHljgrwnleGg-1; Fri,
 16 Aug 2024 09:01:28 -0400
X-MC-Unique: 3p9r_sfoM6GHljgrwnleGg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B89F81955D59;
	Fri, 16 Aug 2024 13:01:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE0A81955F35;
	Fri, 16 Aug 2024 13:01:25 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: VMX: hyper-v: Prevent impossible NULL pointer dereference in evmcs_load()
Date: Fri, 16 Aug 2024 15:01:24 +0200
Message-ID: <20240816130124.286226-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

GCC 12.3.0 complains about a potential NULL pointer dereference in
evmcs_load() as hv_get_vp_assist_page() can return NULL. In fact, this
cannot happen because KVM verifies (hv_init_evmcs()) that every CPU has a
valid VP assist page and aborts enabling the feature otherwise. CPU
onlining path is also checked in vmx_hardware_enable().

To make the compiler happy and to future proof the code, add a KVM_BUG_ON()
sentinel. It doesn't seem to be possible (and logical) to observe
evmcs_load() happening without an active vCPU so it is presumed that
kvm_get_running_vcpu() can't return NULL.

No functional change intended.

Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/vmx_onhyperv.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
index eb48153bfd73..bba24ed99ee6 100644
--- a/arch/x86/kvm/vmx/vmx_onhyperv.h
+++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
@@ -104,6 +104,14 @@ static inline void evmcs_load(u64 phys_addr)
 	struct hv_vp_assist_page *vp_ap =
 		hv_get_vp_assist_page(smp_processor_id());
 
+	/*
+	 * When enabling eVMCS, KVM verifies that every CPU has a valid hv_vp_assist_page()
+	 * and aborts enabling the feature otherwise. CPU onlining path is also checked in
+	 * vmx_hardware_enable().
+	 */
+	if (KVM_BUG_ON(!vp_ap, kvm_get_running_vcpu()->kvm))
+		return;
+
 	if (current_evmcs->hv_enlightenments_control.nested_flush_hypercall)
 		vp_ap->nested_control.features.directhypercall = 1;
 	vp_ap->current_nested_vmcs = phys_addr;
-- 
2.46.0


