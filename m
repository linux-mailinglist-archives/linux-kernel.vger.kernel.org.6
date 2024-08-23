Return-Path: <linux-kernel+bounces-299638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 717EF95D7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010941F231A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B404C1C6F7D;
	Fri, 23 Aug 2024 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfk10kmV"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D223148FED
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445944; cv=none; b=hexdARNYFkoHg8IGBnphaHyZ995sXTA1DT1VeGgoR59/qmyk/9LlFsTU0ruOvwZA8EaSvcTjl+qfR23JW/y3L07U/JKM7Eafs71V7Ydsyj+rtaH1Ylat0LkUwKVCTA/z5e0IrcneI/4mJISMZ6ONzJ7UqQT7Nl8hYP7gMZ5RjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445944; c=relaxed/simple;
	bh=cRAFIOYweaPLXuQzpNKH5NrrC6FPYf80f7BpoNfCH8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Btm0G56IEDNhGv8pdHcwGS/40W3H09hLbIYgN/kYJxCGXhwZQze6uCjlUbMbaS7vUH5jZll85Eg86cX+LjaLYjPKUqFoo/67afo7UsqTHH2wi5GgvxHn0kf7WeGoyBR9Oz9pr4V3jkwwXwfi1qjYxvQN1tYPaRwkUhWVXAXsA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfk10kmV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d3bbfcc5dbso2503178a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724445943; x=1725050743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pfoDyB1z78e7hhTe95tzN4jRJokvmOUNObCprbC0zY=;
        b=jfk10kmVF/pCy4KnF7fsGsbpdAW8gO7TrP1L+gEgkf8c9fiuc640souJVmcp5ltNKP
         MekC4NfdPJKHHfMLCR1MurHdBBTzGUUgLqaMPfjf1tdREV+Qbpvuod3TVNzn8luHmt4N
         qThkdhxMqeMqBhzzdWJ7SThpqnwbxjTtVg2cIJM13kWS5LrYfAs+ExVH9dkZ+B8IBTAU
         vkcu65ICafY3NsREC+HRFIIH5rOo7RxA7Ma1sybYioa/0n62pcMBRi1P8h/2GOBsfMQ5
         good+InE8WRvSfFBZWekMzlDV36kUH0REeeaZ40TsLfoOfSDG01plZ7eLujhYN1J7kdY
         N1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724445943; x=1725050743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pfoDyB1z78e7hhTe95tzN4jRJokvmOUNObCprbC0zY=;
        b=hRdrPAxS9ZmqRDYyinm92XdrcXCpZZvTbbqZvGS+E4aKF4ysc55TliNa/9pdQLosDp
         74UOJTRvl4vIzqc0Us0z5/mLBAgmUe68AX01SoVbjuU2cJyPi2UKkwgFtpdzRjPN9cmU
         iswdvTsuhC8Gh6WY+HeEoUqd2UayheMNj7GebCWQP50QiTV4nW8O/tFsUOzYGoMfpBt7
         XJaiDq2PeDdK76T34WbXUE5liJdOkqRT/WPQNfgvINQ1vByhvN54wqnTy3IV37nmLQCj
         dKj25q24ruqrvOrwkve1si28viX3CIucFPeFC1Obx64EUCDGK7v3NQq7dIlUhFPmeC1m
         OaLg==
X-Forwarded-Encrypted: i=1; AJvYcCXBoN9TIhSZru1joXJq3CRsaaNi669sK1YFM+YBgD47GOj0ulogaC4/0qk8eaEpcTvPsE1piXhoEImXSLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+iRRPTeOGmbGdpsmoNK5Lw4c+CkAQL7DQjDP5/IR+hk41Ecx
	Tsm8I6Q+mXM2BB9mHTvhhv+iG9qjXJviyjYHUfavG3IbANNuPk3wwv8MfI0IwgeXjFNbyN6DJkO
	ATg==
X-Google-Smtp-Source: AGHT+IFyrAlF2jCyND5FgILCtFB17g60e07rsYNVxLtHOmyJyID1u6gI3iOOaixnUUtaSe9hqRndpjx465Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:390e:b0:2c9:7616:dec5 with SMTP id
 98e67ed59e1d1-2d646bcaae1mr7785a91.2.1724445942503; Fri, 23 Aug 2024 13:45:42
 -0700 (PDT)
Date: Fri, 23 Aug 2024 13:45:40 -0700
In-Reply-To: <20240823192736.GA678289.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812171341.1763297-1-vipinsh@google.com> <20240812171341.1763297-3-vipinsh@google.com>
 <ZsPE56MnelsV490m@google.com> <20240823192736.GA678289.vipinsh@google.com>
Message-ID: <Zsj09MWgM7-HuZ__@google.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging to TDP
 MMU under MMU read lock
From: Sean Christopherson <seanjc@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 23, 2024, Vipin Sharma wrote:
> On 2024-08-19 15:19:19, Sean Christopherson wrote:
> > On Mon, Aug 12, 2024, Vipin Sharma wrote:
> > > +retry:
> > > +	/*
> > > +	 * Since mmu_lock is held in read mode, it's possible to race with
> > > +	 * another CPU which can remove sp from the page table hierarchy.
> > > +	 *
> > > +	 * No need to re-read iter.old_spte as tdp_mmu_set_spte_atomic() will
> > > +	 * update it in the case of failure.
> > > +	 */
> > > +	if (sp->spt != spte_to_child_pt(iter.old_spte, iter.level))
> > >  		return false;
> > >  
> > > -	tdp_mmu_set_spte(kvm, kvm_mmu_page_as_id(sp), sp->ptep, old_spte,
> > > -			 SHADOW_NONPRESENT_VALUE, sp->gfn, sp->role.level + 1);
> > > +	if (tdp_mmu_set_spte_atomic(kvm, &iter, SHADOW_NONPRESENT_VALUE))
> > > +		goto retry;
> > 
> > I'm pretty sure there's no need to retry.  Non-leaf SPTEs don't have Dirty bits,
> > and KVM always sets the Accessed bit (and never clears it) for non-leaf SPTEs.
> > Ditty for the Writable bit.
> > 
> > So unless I'm missing something, the only way for the CMPXCHG to fail is if the
> > SPTE was zapped or replaced with something else, in which case the sp->spt will
> > fail.  I would much prefer to WARN on that logic failing than have what appears
> > to be a potential infinite loop.
> 
> I don't think we should WARN() in that scenario. Because there is
> nothing wrong with someone racing with NX huge page recovery for zapping
> or replacing the SPTE.

Agreed, but as sketched out in my other reply[*], I'm saying KVM should WARN like so:

	/*
	 * If a different task modified the SPTE, then it should be impossible
	 * for the SPTE to still be used for the to-be-zapped SP.  Non-leaf
	 * SPTEs don't have Dirty bits, KVM always sets the Accessed bit when
	 * creating non-leaf SPTEs, and all other bits are immutable for non-
	 * leaf SPTEs, i.e. the only legal operations for non-leaf SPTEs are
	 * zapping and replacement.
	 */
	if (tdp_mmu_set_spte_atomic(kvm, &iter, SHADOW_NONPRESENT_VALUE)) {
		WARN_ON_ONCE(sp->spt == spte_to_child_pt(iter.old_spte, iter.level));
		return false;
	}

[*] https://lore.kernel.org/all/ZsPDWqOiv_g7Wh_H@google.com
	
> This function should be just trying to zap a page

Yes and no.  KVM, very deliberately, has multiple different flows for zapping
SPTEs, because the requirements, rules, and performance needs vary.

Initially, the TDP MMU had one common flow for zapping, and it was difficult to
maintain and understand, because trying to optimize and adjust for the various
scenarios in a single path was difficult and convoluted.  E.g. when zapping for
mmu_notifier invalidations, mmu_lock must be held for read, a flush is required,
KVM _must_ process stale/obsolete roots, and KVM only needs to zap leaf SPTEs.

Constrast that with zapping SPTEs in the back half of a fast zap, e.g. after a
memslot deletion, which runs with mmu_lock held for read, only processes invalid
roots, doesn't need to flush, but does need to zap _everything_.

This API is no different.  It is very specifically for zapping non-leaf, non-root
SPTEs in live roots.

So "yes", it's "just" trying to zap a page, but "no" in the sense that there are
a lot of rules and requirements behind that simple statement.

> and if that didn't suceed then return the error and let caller handle however
> they want to.  NX huge page recovery should be tolerant of this zapping
> failure and move on to the next shadow page.

Again, I agree, but that is orthogonal to the WARN I am suggesting.  The intent
of the WARN isn't to detect that zapping failed, it's to flag that the impossible
has happened.

> May be we can put WARN if NX huge page recovery couldn't zap any pages during
> its run time. For example, if it was supposed to zap 10 pages and it couldn't
> zap any of them then print using WARN_ON_ONCE.

Why?  It's improbable, but absolutely possible that zapping 10 SPTEs could fail.
Would it make sense to publish a stat so that userspace can alert on NX huge page
recovery not being as effective as it should be?  Maybe.  But the kernel should
never WARN because an unlikely scenario occurred.

If you look at all the KVM_MMU_WARN_ON() and (hopefully) WARN_ON_ONCE() calls in
KVM x86, they're either for things that should never happen absent software or
hardware bugs, or to ensure future changes update all relevant code paths.

The WARN I am suggesting is the same.  It can only fire if there's a hardware
bug, a KVM bug, or if KVM changes how it behaves, e.g. starts doing A/D tracking
on non-leaf SPTEs.

> This is with the assumption that if more than 1 pages are there to be zapped
> then at least some of them will get zapped whenever recovery worker kicks in.

