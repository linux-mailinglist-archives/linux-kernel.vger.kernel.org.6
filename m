Return-Path: <linux-kernel+bounces-281511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7FF94D7A0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88131282135
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7C167DB9;
	Fri,  9 Aug 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJKcxA9G"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5F19922C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232646; cv=none; b=swAxS4vIOO1Gc474g36y6KkdpxydvDMxH+70iwSs1lsSFfOe0OTW0jVmigOhj7/GOeZ46c/hknCIFQBqcVkbqzwdBqOJWqSlOsQJKtJfedlEqplAIe903k5cMwkjAbhVddicBrelU4mttO2pAobXzGPKwopN4l8AV/pNwaUnrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232646; c=relaxed/simple;
	bh=3xSCN07is/d7+9qa5tb05xLdmkaS8Uh8BYF+HVNaYMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c4XwSZvIHam9sBFthCD9m4B/6u2B6Fkk+X537S7py7zSdIwXh6PxNUIWbEP9pWZj1tgDsQkE5hqa+pckYeV94knTIq0EXBymI/65NLJF11m9DfNk6QV1QO2fBCdmFspvU8TpYNDAMYgdn73c7eCr+vt1Ib5Qq/i7DUAPgxgXk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJKcxA9G; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc5651e888so22886055ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232645; x=1723837445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Kjdpw4GZGWgN0ZxVg8kngRskxTTrucp/2D4JfCR5g=;
        b=zJKcxA9G0HILjOPS7dzZMv3QTb+R5BJNGYIwuowxdDZ91Sl7KCJMNREMOEGyz2zh2G
         agDsp++3cPC+IO/vGRG3tKdAE/roBrNSOIeeGCufasezPUgrNNu1Dpj/rI5+rDxdneEB
         6u7uWgY1focTsh+dE7EFpyZJ74N36oNJwtqmZpoHPrFYmIyKQgssZl8K3LUlvpL9dHSq
         wwAeMql5sJe7jB4IUgCmsIuY7ugY0qD2gYLauxpKRVwq1SmRJRI+cw3RLq3QMmiRI81k
         opMFs+eSKjMQIIZ6jWu36LjcsDui+dlMImiJpkNRg7HuwjtMy4dVfu0wx9Sy7Gka6bvA
         X5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232645; x=1723837445;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C/Kjdpw4GZGWgN0ZxVg8kngRskxTTrucp/2D4JfCR5g=;
        b=dRQJpC64By6h9BnmXKLqAyAfaSIfB0bVQUGYKRzCIjMeEjH/1H4BG9ZS7G3cnaB3Dk
         71F2PlfoBbLawnwVo1phjyhFGhwokKmoM08fmXWeDNhduk9j9Upb9THRYkrW9Um8bEEJ
         3ARXs2/hqHetAuL3thYKQIX9N9MpMBiF3Dof0k2MacpaA8D1/DCDBtyjEM5JydkJibT5
         RuIM6z1zniWd8jiMYyEYXDPoPMVBCFYsOo9usa/NCvJZDekMi4aivtt+Xva7HoQh/n3e
         ZKkexVURlbUdDHDFTbWN5iCYEZdMQkalxxMaPyN2d1Q7aG4Thn2i6W+tiikRoW1YtXH6
         U7bA==
X-Forwarded-Encrypted: i=1; AJvYcCUJR/AToDmSMqlI1lGT4z9tyO9w6H0IJgxlhhvgVGRn19fW1asfR2mmLNJOwDw7lJZHB45LP8x6pRFr5WrTZsUZSMIEAdxzV99iMc7E
X-Gm-Message-State: AOJu0YzC65LJ5s/vnQVEPk9MXGH9Qy9L6BwxyYtekyBlvvIQVj9+/Oms
	3l1c8cBlGU54NQRf7HO0VlnBeZjVERNw0YGzdBTtBqJQBaTYVlnNJswfn7hQcGexuk1/E1/vsmU
	wRw==
X-Google-Smtp-Source: AGHT+IHlnphgTRNzeVdx0O31fPI0LuneFaWMABXGnKSnF6B8xUcCs6tohBFzlE1Hi/BkKbGcyYXHhyb9HbY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d507:b0:1fc:2ee3:d46c with SMTP id
 d9443c01a7336-200ae2549b2mr2179795ad.0.1723232644737; Fri, 09 Aug 2024
 12:44:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:25 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-14-seanjc@google.com>
Subject: [PATCH 13/22] KVM: x86/mmu: Honor NEED_RESCHED when zapping rmaps and
 blocking is allowed
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Convert kvm_unmap_gfn_range(), which is the helper that zaps rmap SPTEs in
response to an mmu_notifier invalidation, to use __kvm_rmap_zap_gfn_range()
and feed in range->may_block.  In other words, honor NEED_RESCHED by way of
cond_resched() when zapping rmaps.  This fixes a long-standing issue where
KVM could process an absurd number of rmap entries without ever yielding,
e.g. if an mmu_notifier fired on a PUD (or larger) range.

Opportunistically rename __kvm_zap_rmap() to kvm_zap_rmap(), and drop the
old kvm_zap_rmap().  Ideally, the shuffling would be done in a different
patch, but that just makes the compiler unhappy, e.g.

  arch/x86/kvm/mmu/mmu.c:1462:13: error: =E2=80=98kvm_zap_rmap=E2=80=99 def=
ined but not used

Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4016f63d03e8..0a33857d668a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1453,16 +1453,10 @@ static bool kvm_vcpu_write_protect_gfn(struct kvm_v=
cpu *vcpu, u64 gfn)
 	return kvm_mmu_slot_gfn_write_protect(vcpu->kvm, slot, gfn, PG_LEVEL_4K);
 }
=20
-static bool __kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_hea=
d,
-			   const struct kvm_memory_slot *slot)
-{
-	return kvm_zap_all_rmap_sptes(kvm, rmap_head);
-}
-
 static bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			 struct kvm_memory_slot *slot, gfn_t gfn, int level)
+			 const struct kvm_memory_slot *slot)
 {
-	return __kvm_zap_rmap(kvm, rmap_head, slot);
+	return kvm_zap_all_rmap_sptes(kvm, rmap_head);
 }
=20
 struct slot_rmap_walk_iterator {
@@ -1597,7 +1591,7 @@ static bool __kvm_rmap_zap_gfn_range(struct kvm *kvm,
 				     gfn_t start, gfn_t end, bool can_yield,
 				     bool flush)
 {
-	return __walk_slot_rmaps(kvm, slot, __kvm_zap_rmap,
+	return __walk_slot_rmaps(kvm, slot, kvm_zap_rmap,
 				 PG_LEVEL_4K, KVM_MAX_HUGEPAGE_LEVEL,
 				 start, end - 1, can_yield, true, flush);
 }
@@ -1626,7 +1620,9 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_=
gfn_range *range)
 	bool flush =3D false;
=20
 	if (kvm_memslots_have_rmaps(kvm))
-		flush =3D kvm_handle_gfn_range(kvm, range, kvm_zap_rmap);
+		flush =3D __kvm_rmap_zap_gfn_range(kvm, range->slot,
+						 range->start, range->end,
+						 range->may_block, flush);
=20
 	if (tdp_mmu_enabled)
 		flush =3D kvm_tdp_mmu_unmap_gfn_range(kvm, range, flush);
--=20
2.46.0.76.ge559c4bf1a-goog


