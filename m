Return-Path: <linux-kernel+bounces-349698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8B98FA2A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCFAFB22D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8401CF5D8;
	Thu,  3 Oct 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+VnBKG2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFD1CB531
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996473; cv=none; b=hnMYMH6nDLFClejwv8Evapcs3xnlmgo7Ds6rAcPmLx0fS7E4itK6bPa9cU5lx0qXkElxZu/xyNrKKgiiyboQEkpg4g2bRP36F0NHhngBhbp3aOTQgcFSOk6tkMCWikXTu3lKL9N7Sh9AXoRnVBOPt6XzrZ1DzgsswJ9621OkRLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996473; c=relaxed/simple;
	bh=/x6uxLlO0mauXrOgXGo8vsi0cerHzFIKDs8L+mQV+MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LY1wdGatBT8SNkelBslw0Naj5rmVvShXNf/LuULlEMmvZ9C7NJJoGpTr7hpqSg4U9ni4m/DAhD4lcHq2ekTyatXON11FsRnKFiT5xukd5+ai1F9BNYVnN5qboaEppR0ethaoBFSyGLStu0Zq53SR9JbY+YmLEay7UjxJsHRHyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+VnBKG2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727996469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lUOVCWF9y+PyVxDtvCc716bXoB77f25WdszoXqApmDc=;
	b=R+VnBKG2vuMjLeqV+E9X/QCCJjni8FBhK80VLizluzgatrNk9shAVDbh+9IW+ngYr+ZbzU
	bVmCBBm5837TocCafSp1XJbHAX735jW74w9lLC1mPLu+KflDvJKXf9J7lfHJ4ZrEyrpmcq
	Pj5ruXG6SR7Ru7NdnniXMWA80cr78U0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-3LydSmTNO0KQgL4Vf2DmYg-1; Thu,
 03 Oct 2024 19:01:08 -0400
X-MC-Unique: 3LydSmTNO0KQgL4Vf2DmYg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA6F619560A5;
	Thu,  3 Oct 2024 23:01:06 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29F1D19560A2;
	Thu,  3 Oct 2024 23:01:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH] KVM: x86/mmu: fix KVM_X86_QUIRK_SLOT_ZAP_ALL for shadow MMU
Date: Thu,  3 Oct 2024 19:01:05 -0400
Message-ID: <20241003230105.226476-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

As was tried in commit 4e103134b862 ("KVM: x86/mmu: Zap only the relevant
pages when removing a memslot"), all shadow pages, i.e. non-leaf SPTEs,
need to be zapped.  All of the accounting for a shadow page is tied to the
memslot, i.e. the shadow page holds a reference to the memslot, for all
intents and purposes.  Deleting the memslot without removing all relevant
shadow pages, as is done when KVM_X86_QUIRK_SLOT_ZAP_ALL is disabled,
results in NULL pointer derefs when tearing down the VM.

Reintroduce from that commit the code that walks the whole memslot when
there are active shadow MMU pages.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	In the end I did opt for zapping all the pages.  I don't see a
	reason to let them linger forever in the hash table.

	A small optimization would be to only check each bucket once,
	which would require a bitmap sized according to the number of
	buckets.  I'm not going to bother though, at least for now.

 arch/x86/kvm/mmu/mmu.c | 60 ++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e081f785fb23..912bad4fa88c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1884,10 +1884,14 @@ static bool sp_has_gptes(struct kvm_mmu_page *sp)
 		if (is_obsolete_sp((_kvm), (_sp))) {			\
 		} else
 
-#define for_each_gfn_valid_sp_with_gptes(_kvm, _sp, _gfn)		\
+#define for_each_gfn_valid_sp(_kvm, _sp, _gfn)				\
 	for_each_valid_sp(_kvm, _sp,					\
 	  &(_kvm)->arch.mmu_page_hash[kvm_page_table_hashfn(_gfn)])	\
-		if ((_sp)->gfn != (_gfn) || !sp_has_gptes(_sp)) {} else
+		if ((_sp)->gfn != (_gfn)) {} else
+
+#define for_each_gfn_valid_sp_with_gptes(_kvm, _sp, _gfn)		\
+	for_each_gfn_valid_sp(_kvm, _sp, _gfn)				\
+		if (!sp_has_gptes(_sp)) {} else
 
 static bool kvm_sync_page_check(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 {
@@ -7049,14 +7053,42 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 	kvm_mmu_zap_all(kvm);
 }
 
-/*
- * Zapping leaf SPTEs with memslot range when a memslot is moved/deleted.
- *
- * Zapping non-leaf SPTEs, a.k.a. not-last SPTEs, isn't required, worst
- * case scenario we'll have unused shadow pages lying around until they
- * are recycled due to age or when the VM is destroyed.
- */
-static void kvm_mmu_zap_memslot_leafs(struct kvm *kvm, struct kvm_memory_slot *slot)
+static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
+						struct kvm_memory_slot *slot,
+						bool flush)
+{
+	LIST_HEAD(invalid_list);
+	unsigned long i;
+
+	if (list_empty(&kvm->arch.active_mmu_pages))
+		goto out_flush;
+
+	/*
+	 * Since accounting information is stored in struct kvm_arch_memory_slot,
+	 * shadow pages deletion (e.g. unaccount_shadowed()) requires that all
+	 * gfns with a shadow page have a corresponding memslot.  Do so before
+	 * the memslot goes away.
+	 */
+	for (i = 0; i < slot->npages; i++) {
+		struct kvm_mmu_page *sp;
+		gfn_t gfn = slot->base_gfn + i;
+
+		for_each_gfn_valid_sp(kvm, sp, gfn)
+			kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
+
+		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
+			kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
+			flush = false;
+			cond_resched_rwlock_write(&kvm->mmu_lock);
+		}
+	}
+
+out_flush:
+	kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
+}
+
+static void kvm_mmu_zap_memslot(struct kvm *kvm,
+				struct kvm_memory_slot *slot)
 {
 	struct kvm_gfn_range range = {
 		.slot = slot,
@@ -7064,11 +7096,11 @@ static void kvm_mmu_zap_memslot_leafs(struct kvm *kvm, struct kvm_memory_slot *s
 		.end = slot->base_gfn + slot->npages,
 		.may_block = true,
 	};
+	bool flush;
 
 	write_lock(&kvm->mmu_lock);
-	if (kvm_unmap_gfn_range(kvm, &range))
-		kvm_flush_remote_tlbs_memslot(kvm, slot);
-
+	flush = kvm_unmap_gfn_range(kvm, &range);
+	kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
 	write_unlock(&kvm->mmu_lock);
 }
 
@@ -7084,7 +7116,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 	if (kvm_memslot_flush_zap_all(kvm))
 		kvm_mmu_zap_all_fast(kvm);
 	else
-		kvm_mmu_zap_memslot_leafs(kvm, slot);
+		kvm_mmu_zap_memslot(kvm, slot);
 }
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
-- 
2.43.5


