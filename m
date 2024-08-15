Return-Path: <linux-kernel+bounces-288099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8235953473
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C859E1C21032
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDA31AB53E;
	Thu, 15 Aug 2024 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLm7C+jU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AF63C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731959; cv=none; b=E3NOejVu+8wYNjqLVGRKDoRm8Ww/bOEtLto6E2EYmOcEABPnWTrupWrpkrjVroIgVmpotSWqc56j5SmSZMHK38upritRKH1UjqliByrbhio+QFZ2s9PemCkdCK+Wo56p+xJvPaROG7GdAzPu5OsDidLDJjbaE/mSZsTiZ5RJ+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731959; c=relaxed/simple;
	bh=T6w22f/EV1nqV5GX244Le2gSBKKj4m81OK4ziNx9288=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oR7dSlKZgAkH1UFqriZdaczCJRxmWO/gF1cEIWLYXHijNyKh4FqopclBhXX7/OLgL4XLq5Npvc+ZKGscDhVPvxPE0A6IAUgKzBjGNigGLq+4+irFKw4/MJrCQcsq6ucT5h64r4SLRClU9fJAa44g274nRSl1wGtBJe/P/UQ/X90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLm7C+jU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b036192efaso9431907b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723731957; x=1724336757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=roDNKJdSnZwy+Mcdcl1djSIrOYwbDe7Ptmk1JHrL0bw=;
        b=jLm7C+jU6XjfdoT0kILhERtZHfJVwi6W8vZAc2IJkmjgVBCedI9LuIjl2a7MLQrIkZ
         5rDVQ9zecfHJfkP+byHthcYdAmKUwth7u6WTic25k1iVsSi2KKB2u5kLp6rPOJwhniSc
         hqtWUQh7ZGwz0zZzjBSmDqRI+z0Yhb2I6bnRzUaAm1bfYinlWLZzieQD5KipfyUuaNJ6
         OoXxf1qeKcASfVpaS19JzUvV91gLXMfPjT4e9DUGjRUpxBoO6pvWCwIo68CIgJ/Oh/Ac
         2knsYeyJs0EFq7Xb8FVL3YvdDkUt6eeDEwX8y3Jhtmkn27fPonTyVnr4BcsEVaK1QocS
         iI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723731957; x=1724336757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roDNKJdSnZwy+Mcdcl1djSIrOYwbDe7Ptmk1JHrL0bw=;
        b=J6MeAE5I92mYS8FLkUiW4CsjLooz8UbCyKk8kwg9AmoVWnmE+5NVYJF2re67nF3eG8
         jrKDgs/8dZchpFYHOJ0YtQrYhJwC2NeiGCMMzlcR5CK52oOBQdMnUPQ/hnngo8weZr+0
         WkACLAf30REam9Vif7azmLnoDjOBjOlCiwGWefhR445GAOEQ4gV0R+vKR40Q+VZoyuPj
         tpso1f5208KTUpQXXW0P7DLTOE0RWMExmJyoLFJ7TdwTtA5Muhwx274E1jN3gbKfziL2
         TdHTQEpYd1g2f2HrhxTwXzQfm2CqFMqpQp3eMelmAKpI43RYJ7WqMlFKJhjJ0WAGO+El
         4QmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ORnIwpuuiP1tJNrk6kU/qn4M4h62b2P2JACVCHsTrIKDEzUmm4YbAqZPnDalUBTn8EJUXxWWOFE04lW9lXfdwY39wedvz+u8iT4Z
X-Gm-Message-State: AOJu0YyTVywXks4/aBFf3Nfa3HiwfgPI42z2Rd4C0jZW2y9wUdW3CS8e
	7W7RuofrSja0Mu/lK2NbuwT+Fn3nXb+ps4DZDerDu/j0xfBflFmgOJtVmBIgKdWEyhPNQPGDjup
	S8g==
X-Google-Smtp-Source: AGHT+IFE0Vi4b+EvUBIA+1EZT1ThmV3wetNw2WaTANsCnH4Lk17nU+Pfq+H8vJYE/x9QR0+/9/9P2e/bgOA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d385:0:b0:673:b39a:92ea with SMTP id
 00721157ae682-6ac997f8a9cmr3405997b3.7.1723731957160; Thu, 15 Aug 2024
 07:25:57 -0700 (PDT)
Date: Thu, 15 Aug 2024 07:25:55 -0700
In-Reply-To: <5f8c0ca4-ae99-4d1c-8525-51c6f1096eaa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com> <20240809190319.1710470-23-seanjc@google.com>
 <5f8c0ca4-ae99-4d1c-8525-51c6f1096eaa@redhat.com>
Message-ID: <Zr4P86YRZvefE95k@google.com>
Subject: Re: [PATCH 22/22] KVM: x86/mmu: Detect if unprotect will do anything
 based on invalid_list
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 14, 2024, Paolo Bonzini wrote:
> On 8/9/24 21:03, Sean Christopherson wrote:
> > Explicitly query the list of to-be-zapped shadow pages when checking to
> > see if unprotecting a gfn for retry has succeeded, i.e. if KVM should
> > retry the faulting instruction.
> > 
> > Add a comment to explain why the list needs to be checked before zapping,
> > which is the primary motivation for this change.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/mmu/mmu.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 300a47801685..50695eb2ee22 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -2731,12 +2731,15 @@ bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >   			goto out;
> >   	}
> > -	r = false;
> >   	write_lock(&kvm->mmu_lock);
> > -	for_each_gfn_valid_sp_with_gptes(kvm, sp, gpa_to_gfn(gpa)) {
> > -		r = true;
> > +	for_each_gfn_valid_sp_with_gptes(kvm, sp, gpa_to_gfn(gpa))
> >   		kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
> > -	}
> > +
> > +	/*
> > +	 * Snapshot the result before zapping, as zapping will remove all list
> > +	 * entries, i.e. checking the list later would yield a false negative.
> > +	 */
> 
> Hmm, the comment is kinda overkill?  Maybe just
> 
> 	/* Return whether there were sptes to zap.  */
> 	r = !list_empty(&invalid_test);

I would strongly prefer to keep the verbose comment.  I was "this" close to
removing the local variable and checking list_empty() after the commit phase.
If we made that goof, it would only show up at the worst time, i.e. when a guest
triggers retry and gets stuck.  And the logical outcome of fixing such a bug
would be to add a comment to prevent it from happening again, so I say just add
the comment straightaway.

> I'm not sure about patch 21 - I like the simple kvm_mmu_unprotect_page()
> function.

From a code perspective, I kinda like having a separate helper too.  As you
likely suspect given your below suggestion, KVM should never unprotect a gfn
without retry protection, i.e. there should never be another caller, and I want
to enforce that.

> Maybe rename it to kvm_mmu_zap_gfn() and make it static in the same patch?

kvm_mmu_zap_gfn() would be quite misleading.  Unlike kvm_zap_gfn_range(), it only
zaps non-leaf shadow pages.  E.g. the name would suggest that it could be used by
__kvm_set_or_clear_apicv_inhibit(), but it would do the complete wrong thing.

kvm_mmu_zap_shadow_pages() is the least awful I can come up with (it needs to be
plural because it zaps all SPs related to the gfn), but that's something confusing
too since it would take in a single gfn.  So I think my vote is to keep patch 21
and dodge the naming entirely.

