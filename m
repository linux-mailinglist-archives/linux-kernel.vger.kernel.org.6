Return-Path: <linux-kernel+bounces-171754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A0B8BE827
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7221F2B058
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F260216F84C;
	Tue,  7 May 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5OPKhW1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4216C6AA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097508; cv=none; b=WmkekErJueof+C7Tk2wbzfQAgcDa1RCw1G+KY4g2aDMa+VEB42F5tB/zlPtnVeeClRgIE4l4mA98H4Js8i5waItpjS2Dq7AXxm3DaouoNc4Ptvkz/MDikPbpRycRghXF5IX17UgmKk4YKkPJQmwJy2eT5E9XpqH5JxU9EyaxuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097508; c=relaxed/simple;
	bh=aWR8vi3ctb5xuNS5aLdoGpoQVQX3R/AX8tzJO890OYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ur1cjyfReOrIKeVT9+nfFFU800Ni9Ew5im/sSmTpq32MWoABpuRCVztm5BlkDd+WnNf0aF3eE2caEPIDrJlPJFufN57mbzas4/QA0P0Wh3kds3w70xCcROLOQPApPu6o9zwaVvQx8QotpC0UlATgK3OrZh2VsCKaSGI4ukClgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5OPKhW1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715097503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeJwneIQoupo8QkN2Q+WsjpfxqenpfhUm2BwJMPTxBw=;
	b=V5OPKhW1+BWcqS23/1fFUjMKvZbeGipkIER0abPetR8nVDGU8UBa5b+oa4j47y7hXipvqr
	+8OCxdnhet5u+OXsS9mZWfEIYHn4ecOOy89O91FxPtA8zmBndIexvXijEX+oWwRePHjfO4
	nlkWuyC2Nnjtktzq8F7FRP7yKIPdTfM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-EwPh8TxkNUSzca5Oyj3J0w-1; Tue,
 07 May 2024 11:58:21 -0400
X-MC-Unique: EwPh8TxkNUSzca5Oyj3J0w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B6073802AC9;
	Tue,  7 May 2024 15:58:21 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E866A401441;
	Tue,  7 May 2024 15:58:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH 17/17] KVM: x86/mmu: Sanity check that __kvm_faultin_pfn() doesn't create noslot pfns
Date: Tue,  7 May 2024 11:58:17 -0400
Message-ID: <20240507155817.3951344-18-pbonzini@redhat.com>
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

WARN if __kvm_faultin_pfn() generates a "no slot" pfn, and gracefully
handle the unexpected behavior instead of continuing on with dangerous
state, e.g. tdp_mmu_map_handle_target_level() _only_ checks fault->slot,
and so could install a bogus PFN into the guest.

The existing code is functionally ok, because kvm_faultin_pfn() pre-checks
all of the cases that result in KVM_PFN_NOSLOT, but it is unnecessarily
unsafe as it relies on __gfn_to_pfn_memslot() getting the _exact_ same
memslot, i.e. not a re-retrieved pointer with KVM_MEMSLOT_INVALID set.
And checking only fault->slot would fall apart if KVM ever added a flag or
condition that forced emulation, similar to how KVM handles writes to
read-only memslots.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Message-ID: <20240228024147.41573-17-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d717d60c6f19..510eb1117012 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4425,7 +4425,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	if (unlikely(is_error_pfn(fault->pfn)))
 		return kvm_handle_error_pfn(vcpu, fault);
 
-	if (WARN_ON_ONCE(!fault->slot))
+	if (WARN_ON_ONCE(!fault->slot || is_noslot_pfn(fault->pfn)))
 		return kvm_handle_noslot_fault(vcpu, fault, access);
 
 	/*
-- 
2.43.0


