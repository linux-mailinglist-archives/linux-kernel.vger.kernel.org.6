Return-Path: <linux-kernel+bounces-171757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F538BE86D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87784B286F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9717799B;
	Tue,  7 May 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HS0TdCwm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AC16C6A1
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097509; cv=none; b=tFqYS55jT2SBEThcJOZdFZ9JoDwVnhMceLBItApOfJbgvMSjeXA9PlHPVGjLs0SPckl0681dkGefkI9wudag25zqHN8ztwLhczHLZZ6G2JhFBCkvkimQbUniD0yxhZS1/pcWQlqbOF0vlsggNXnLJ7f6XbWjHhs/UQK1xmVQxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097509; c=relaxed/simple;
	bh=AEDj0QP9X/29ZeWxz7Y3Z4nz0H8Ield92JGUU5fqxk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCcnxyelKM240fx1uYcqB9PRhEG1DaAsYm+EW0Q/7wiw73uPpt9BD74e5PK1e50863ABawlBvydrDhirCM2equaotwaKpJ7Mkt+19p3DYYuuoXJXY/fDxpKsa0LFv/L7LmdDySCj4C3CARzvDGoePiEKXGM4l9KLvfZuRNDt5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HS0TdCwm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715097503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfYqWHCMNvvr7g3hZxttx2F/NwK+cEPEKDtwCJOPG4M=;
	b=HS0TdCwmFYKwouePrQU/idx8LP6Q4mK3zNJ431omaB6a8VJL4wegglOfaoXNBQrBMO/ykq
	u8ev0QXZeIwIfFGlUSK3HUODweKRyhb6u/tzLfgfHvprVZ59sMOANAWAIdpCsn9zdeUhGT
	6HDa+Z3VH+EVcIgOVW5CZB+xEBUMn74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-3Cwx2YUwN7qLulppB-IAtg-1; Tue, 07 May 2024 11:58:20 -0400
X-MC-Unique: 3Cwx2YUwN7qLulppB-IAtg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33348802BF7;
	Tue,  7 May 2024 15:58:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 16C4A401441;
	Tue,  7 May 2024 15:58:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 12/17] KVM: x86/mmu: Explicitly disallow private accesses to emulated MMIO
Date: Tue,  7 May 2024 11:58:12 -0400
Message-ID: <20240507155817.3951344-13-pbonzini@redhat.com>
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

Explicitly detect and disallow private accesses to emulated MMIO in
kvm_handle_noslot_fault() instead of relying on kvm_faultin_pfn_private()
to perform the check.  This will allow the page fault path to go straight
to kvm_handle_noslot_fault() without bouncing through __kvm_faultin_pfn().

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20240228024147.41573-12-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a8e14c2b68a7..fdae6d19e72b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3262,6 +3262,11 @@ static int kvm_handle_noslot_fault(struct kvm_vcpu *vcpu,
 {
 	gva_t gva = fault->is_tdp ? 0 : fault->addr;
 
+	if (fault->is_private) {
+		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
+		return -EFAULT;
+	}
+
 	vcpu_cache_mmio_info(vcpu, gva, fault->gfn,
 			     access & shadow_mmio_access_mask);
 
-- 
2.43.0



