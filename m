Return-Path: <linux-kernel+bounces-263652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7A593D8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291051F225E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A4155A30;
	Fri, 26 Jul 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wkb5AEUS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D114D282
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019935; cv=none; b=S6e4MyrT0nwoo2NEOYPPqInP2RjyyyD0cY2YiDSxvHTbtDn6JB1/CQjZzTFkfebfCbGJRyIe3oR8XKiysSO3N/s3lpmE8HOVx3l24dtnrKkZPALBKLpa4Jnp808y0n8Z2zN2zdFgL/QT0nQqN3xZ/n17G65qZt1r7Hvcxybkywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019935; c=relaxed/simple;
	bh=ifbo9j+5kmjHjJq4lVj1MOCrJiSz5tdU3l3BsqETtIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjRY4ZgOnVZGVvH/Ktkz/9CWSi/eM3F3/OIqSdyuyvI3ig0QA+l34m8pMoWnvLfOgjqHUc9eadCOZz5i88Q5x2MH/Lerkn0wEsB3OaB3afNWeUM7KEy7ZIAXtj6LzRtCX7OQN4WNxmvrWlSnqAauH5qPGOy0/U2iBeBKAWCHwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wkb5AEUS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722019932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdQXRewcaCvJ7fsXxayPldP2wYuonqZxSpjigXlrQvw=;
	b=Wkb5AEUSOB08tvz2Zfr6FpO4HQCB7xh2kjIfBncBHkRETNzB5NsDV/XrPb4QlifVcQOMB7
	rjB9kvqTdYhf5dw9Hya2xBY7JpUYMQdTy2V5USzpIN20efXFmKGWWtvKKAzlwDafNnMc11
	f8TGmaWd1Wphk3DB7corJLkavBPcajc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-ehTjmrJONyikROZY9NYHeg-1; Fri,
 26 Jul 2024 14:52:08 -0400
X-MC-Unique: ehTjmrJONyikROZY9NYHeg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC23F1955F66;
	Fri, 26 Jul 2024 18:52:07 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 297A71955D42;
	Fri, 26 Jul 2024 18:52:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH v2 10/14] KVM: guest_memfd: move check for already-populated page to common code
Date: Fri, 26 Jul 2024 14:51:53 -0400
Message-ID: <20240726185157.72821-11-pbonzini@redhat.com>
In-Reply-To: <20240726185157.72821-1-pbonzini@redhat.com>
References: <20240726185157.72821-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Do not allow populating the same page twice with startup data.  In the
case of SEV-SNP, for example, the firmware does not allow it anyway,
since the launch-update operation is only possible on pages that are
still shared in the RMP.

Even if it worked, kvm_gmem_populate()'s callback is meant to have side
effects such as updating launch measurements, and updating the same
page twice is unlikely to have the desired results.

Races between calls to the ioctl are not possible because
kvm_gmem_populate() holds slots_lock and the VM should not be running.
But again, even if this worked on other confidential computing technology,
it doesn't matter to guest_memfd.c whether this is something fishy
such as missing synchronization in userspace, or rather something
intentional.  One of the racers wins, and the page is initialized by
either kvm_gmem_prepare_folio() or kvm_gmem_populate().

Anyway, out of paranoia, adjust sev_gmem_post_populate() anyway to use
the same errno that kvm_gmem_populate() is using.

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 virt/kvm/guest_memfd.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6589091e8ce0..752d2fff0f10 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2290,7 +2290,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn_start, kvm_pfn_t pf
 		if (ret || assigned) {
 			pr_debug("%s: Failed to ensure GFN 0x%llx RMP entry is initial shared state, ret: %d assigned: %d\n",
 				 __func__, gfn, ret, assigned);
-			ret = -EINVAL;
+			ret = ret ? -EINVAL : -EEXIST;
 			goto err;
 		}
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 191fd42067c0..319ec491ca47 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -653,6 +653,13 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 			break;
 		}
 
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			ret = -EEXIST;
+			break;
+		}
+
 		folio_unlock(folio);
 		if (!IS_ALIGNED(gfn, (1 << max_order)) ||
 		    (npages - i) < (1 << max_order))
-- 
2.43.0



