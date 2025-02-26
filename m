Return-Path: <linux-kernel+bounces-534831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B702AA46B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A973188C935
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A728271261;
	Wed, 26 Feb 2025 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoQ7CxpE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7226FA77
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599762; cv=none; b=D9BUdSqmh5vpUb8Va6C2tqt55sigT/VPlgabuoWxpbxyNWxystp1wD6NVtZ5yvFQmJ6gjvh4yh9ysnxEwfg4HHpIJFvFnkiPIg5XNzI3YtoxLV1KMYAB7OZAYLmNJOmlL+KF6P6DCxpa8QvQC8+sjwjbwDUlzcGNxNH6NTdVquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599762; c=relaxed/simple;
	bh=I0m/UyhWDbKxRmQr78dCOQ7ktjKAe1rGbG0Pai33N8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRCdEZiiGJv5/IKnQ9pHAclY9emeBerkzB/BWjgAdGdpeqtEI1L9MG3tPXvTFioF2MDwQ/k4MtIVwl7VFdTOOvA1bVv5FLpCukmKaRfgU606cwSYhFz7JYOBjHuuyUNOqf8FQe2O6FmRdxYLo46LW5yV7gVagmGiOj7LiWJrpRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoQ7CxpE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740599758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6scfnPXKYb5nPx3bz4ITiIsd9lknNFX39Usf1FHUuE=;
	b=OoQ7CxpEmb1Jw0W6BdoHSLddOCpRk9Q/rAEiR+Sb7HIy5Dr8BwaW8UZm6OxXO89VcrwQDo
	HNEZWemKMKYSCf0j+J/Hm235qfoNBb2mUnhOp22AtU5GYVLuVmm3jbuYBlUBLUQix/bhRj
	rVxt1IvHT2RpZ09SQ1PYc2B8vQx+VTI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-7psDDalyP2mhke6z4h0KVg-1; Wed,
 26 Feb 2025 14:55:53 -0500
X-MC-Unique: 7psDDalyP2mhke6z4h0KVg-1
X-Mimecast-MFC-AGG-ID: 7psDDalyP2mhke6z4h0KVg_1740599752
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D88A51800874;
	Wed, 26 Feb 2025 19:55:51 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4F26300018D;
	Wed, 26 Feb 2025 19:55:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH 15/29] KVM: x86/mmu: Add setter for shadow_mmio_value
Date: Wed, 26 Feb 2025 14:55:15 -0500
Message-ID: <20250226195529.2314580-16-pbonzini@redhat.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Future changes will want to set shadow_mmio_value from TDX code. Add a
helper to setter with a name that makes more sense from that context.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
[split into new patch]
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20241112073730.22200-1-yan.y.zhao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h      | 1 +
 arch/x86/kvm/mmu/spte.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 8d0fca4b4a50..47e64a3c4ce3 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -79,6 +79,7 @@ static inline gfn_t kvm_mmu_max_gfn(void)
 u8 kvm_mmu_get_max_tdp_level(void);
 
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask);
+void kvm_mmu_set_mmio_spte_value(struct kvm *kvm, u64 mmio_value);
 void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask);
 void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only);
 
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 22551e2f1d00..c42ac5d1f027 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -433,6 +433,12 @@ void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask)
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_set_mmio_spte_mask);
 
+void kvm_mmu_set_mmio_spte_value(struct kvm *kvm, u64 mmio_value)
+{
+	kvm->arch.shadow_mmio_value = mmio_value;
+}
+EXPORT_SYMBOL_GPL(kvm_mmu_set_mmio_spte_value);
+
 void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask)
 {
 	/* shadow_me_value must be a subset of shadow_me_mask */
-- 
2.43.5



