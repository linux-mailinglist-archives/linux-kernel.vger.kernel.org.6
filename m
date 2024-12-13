Return-Path: <linux-kernel+bounces-445497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F368A9F16F8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC55D161371
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB191F429D;
	Fri, 13 Dec 2024 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpDaWdG3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020771F193A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119853; cv=none; b=RftdfxSfu+zKlMb7I1Snm7PP5FwAi3mzigcWIlNRnAudGLVj+X1YsyE3/3yxH4ufDcP0ffh0DUaQQ/0UyPDdFEiheHZVLb+g7yl4dKdCQWEqXUq/vNNF7YeF6UHZwFXJl7AKUNfeJMP23MxIG+nv77eLVysQ4S9bFf5d2vWWFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119853; c=relaxed/simple;
	bh=bOO2gzg7Bdt9vvJEN+OiXnNUIvaW46KI3xBUFYOhrQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+WHIkOV6AjN0D/WTcqi2xADckbp/tqcvj1YlmsRlr5MO73jRpZnG3n2ITPK4Yvz87hnDl6J8h6AqWFFtQN51fWmdJtX0EFV6TY/UfcRd/h0v7jKe3TdVj41nJGiCrhu8Yd+zcuhlVlPEYCFskYqu5/ic3t8Qbi4XToyRwcbWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpDaWdG3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734119849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZifNjJVBL89JDtng2Mk8RYCoQKEDHmbIpZW/pMk0qU=;
	b=PpDaWdG36ZMrWBBbxQfTf/sQYX1180cp8wmW6Xp5vMVpDTu1auASjD33qrsJJQB752ewP6
	/win9PUUmfUW4FLBHVboXKSVSh3Afqi5sdoVn1p4DUzPyqLELuhNwVLJ/P900rvlA3OPzS
	x6pbf416Mv8lu8ooerBwJlF7G6T42HU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-BlCvz05uPyGgu1DyWsbNAw-1; Fri,
 13 Dec 2024 14:57:25 -0500
X-MC-Unique: BlCvz05uPyGgu1DyWsbNAw-1
X-Mimecast-MFC-AGG-ID: BlCvz05uPyGgu1DyWsbNAw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78D761956089;
	Fri, 13 Dec 2024 19:57:24 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85D81195605A;
	Fri, 13 Dec 2024 19:57:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: yan.y.zhao@intel.com,
	isaku.yamahata@intel.com,
	binbin.wu@linux.intel.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 09/18] KVM: x86/tdp_mmu: Extract root invalid check from tdx_mmu_next_root()
Date: Fri, 13 Dec 2024 14:57:02 -0500
Message-ID: <20241213195711.316050-10-pbonzini@redhat.com>
In-Reply-To: <20241213195711.316050-1-pbonzini@redhat.com>
References: <20241213195711.316050-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Isaku Yamahata <isaku.yamahata@intel.com>

Extract tdp_mmu_root_match() to check if the root has given types and use
it for the root page table iterator.  It checks only_invalid now.

TDX KVM operates on a shared page table only (Shared-EPT), a mirrored page
table only (Secure-EPT), or both based on the operation.  KVM MMU notifier
operations only on shared page table.  KVM guest_memfd invalidation
operations only on mirrored page table, and so on.  Introduce a centralized
matching function instead of open coding matching logic in the iterator.
The next step is to extend the function to check whether the page is shared
or private

Link: https://lore.kernel.org/kvm/ZivazWQw1oCU8VBC@google.com/
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Message-ID: <20240718211230.1492011-10-rick.p.edgecombe@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c77cbf2577c3..fbf835469390 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -92,6 +92,14 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
 	call_rcu(&root->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
 
+static bool tdp_mmu_root_match(struct kvm_mmu_page *root, bool only_valid)
+{
+	if (only_valid && root->role.invalid)
+		return false;
+
+	return true;
+}
+
 /*
  * Returns the next root after @prev_root (or the first root if @prev_root is
  * NULL).  A reference to the returned root is acquired, and the reference to
@@ -125,7 +133,7 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 						   typeof(*next_root), link);
 
 	while (next_root) {
-		if ((!only_valid || !next_root->role.invalid) &&
+		if (tdp_mmu_root_match(next_root, only_valid) &&
 		    kvm_tdp_mmu_get_root(next_root))
 			break;
 
@@ -176,7 +184,7 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 	list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)		\
 		if (kvm_lockdep_assert_mmu_lock_held(_kvm, false) &&		\
 		    ((_as_id >= 0 && kvm_mmu_page_as_id(_root) != _as_id) ||	\
-		     ((_only_valid) && (_root)->role.invalid))) {		\
+		     !tdp_mmu_root_match((_root), (_only_valid)))) {		\
 		} else
 
 #define for_each_tdp_mmu_root(_kvm, _root, _as_id)			\
-- 
2.43.5



