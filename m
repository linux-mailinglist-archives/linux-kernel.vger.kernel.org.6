Return-Path: <linux-kernel+bounces-171756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB828BE828
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB55B28A1EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D79176FDF;
	Tue,  7 May 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiQembaJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E416D334
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097509; cv=none; b=Zk0vaa/9ODyZ00ZnnViTigqy5uub9g/f34/8/sViIblwCXuiSEg4eXFYFMhNWDMs3Ns5l8OsRZJ3V+4xAs0+ME5yk2L2FtPVEuTuY1kqAL6c6CeHjB7wt+TJE1p8Rq6OysdQMpfW6NI6mxd9TtHCZSqPrT5H213045cfepfSkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097509; c=relaxed/simple;
	bh=GkkN7T6+cimw4JT93KNHujzpgLF1lKsT4txhFyN6FDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAGYfQxnYgF2FQ0sj3X8Lb5f6rUs79AygAQPUDLAUiM6dICngUPw1iLdyKUJTA3bj1WBnVyzVdVEaksb8wgNAOfZoqayob9d+aj2GC44dlQAipgINviSxJ6aD101ZOZJ6wdGL2sJRrPEsPSTPAUau3R5AD+olY6GpqFyJXTInic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiQembaJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715097506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKGQpKXK/VsaKh591Gi5ng8g+rbrmbkAlShhkhIq5DE=;
	b=PiQembaJ6TE9maTZmW7r0MQmX+adRkq/q4QHyUUlrBSuBb2J3gMFtcvo/jocUFl1056Hcf
	ivjMr3yG6M2RPSBVlEMETBAWnPC79X5n8IuigAR93q1Wu0ipxWQZpXioa3dV+PSEYDGeUd
	PdG1CZovG6M+Zlgoc57xraUu936emwM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-QRQjOmf1P1Wkbar0la-dlQ-1; Tue, 07 May 2024 11:58:21 -0400
X-MC-Unique: QRQjOmf1P1Wkbar0la-dlQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0207857A81;
	Tue,  7 May 2024 15:58:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BE97C492CAA;
	Tue,  7 May 2024 15:58:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH 16/17] KVM: x86/mmu: Initialize kvm_page_fault's pfn and hva to error values
Date: Tue,  7 May 2024 11:58:16 -0400
Message-ID: <20240507155817.3951344-17-pbonzini@redhat.com>
In-Reply-To: <20240507155817.3951344-1-pbonzini@redhat.com>
References: <20240507155817.3951344-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Sean Christopherson <seanjc@google.com>

Explicitly set "pfn" and "hva" to error values in kvm_mmu_do_page_fault()
to harden KVM against using "uninitialized" values.  In quotes because the
fields are actually zero-initialized, and zero is a legal value for both
page frame numbers and virtual addresses.  E.g. failure to set "pfn" prior
to creating an SPTE could result in KVM pointing at physical address '0',
which is far less desirable than KVM generating a SPTE with reserved PA
bits set and thus effectively killing the VM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Message-ID: <20240228024147.41573-16-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu_internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index dfd9ff383663..ce2fcd19ba6b 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -307,6 +307,9 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.req_level = PG_LEVEL_4K,
 		.goal_level = PG_LEVEL_4K,
 		.is_private = err & PFERR_PRIVATE_ACCESS,
+
+		.pfn = KVM_PFN_ERR_FAULT,
+		.hva = KVM_HVA_ERR_BAD,
 	};
 	int r;
 
-- 
2.43.0



