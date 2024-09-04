Return-Path: <linux-kernel+bounces-315446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5F96C2D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2D21F21B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AEE1DEFE2;
	Wed,  4 Sep 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wknBmI/F"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A411D9D6A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464923; cv=none; b=S6tmuOp1hIIslQ4XwsawPoWyCtHeSzQKSDceySYDAYm8BdzG7gi3XNAeOd+bAiDR4RGIZochNkosiXo524LR6g09sGc3w3aFEaByim0umHvGfw8SNuFPG9Og3mqmFWQE+06pTixrrfszpn7uV4L2/ZhSxa/LnlGkBrQoPUAkX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464923; c=relaxed/simple;
	bh=YFXu6Fs91bSZlaLaA/3ydsvGQ81AEcDn4k3L1L/q5f8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=edCWDY1rQWz3iXgbjxqynBW5XaVxswv1yYrzFEv7jcrzGhcrrmM4PVNlLfs0kNLkXuTDzkwPVH2VZGVdGd0yWufamgXqz2fTJuHoZWv7As3vfdhJe2G1MXTv+HeRaKBvSL9FtPqVOcpx378zN3dSfNjJiAeQnkFXfv8YW3ofWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wknBmI/F; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-715c530f80eso7355063b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725464921; x=1726069721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouT7rYO2/YVMI+l5OQmMww73bGkck/LGVXhuvGIWT20=;
        b=wknBmI/FoHatxQr5XB32z+MRtf4SPtppPU7O3f691cj/FV+BC1qNN9VcWc2RkOjVDm
         NDhWJ+pctqpyKPO07RCm99Z06vsC9qO1eH1bzaoJX+cwWHPmplsq67uMirSqP3PYn3Y2
         sw0M3UNxYaFIwCZHzaQWwGMs3WaSfhAvU2z7LYsoMyuScNpospKMrcUTzRhC0V5KB23L
         Bbv4Mz2msYCNMdJ2aDXyYtjTiD6evdv8Oy4OMc6I/UJuQtoQ6y8lS4UienAF7K1jYU0t
         Z2VdpOBvLrUklWwswrVCrXEOMLFJC+MFqKQKqnqT0T1LNpxCqfCuQH7O7+AF5nktquik
         Pqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464921; x=1726069721;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ouT7rYO2/YVMI+l5OQmMww73bGkck/LGVXhuvGIWT20=;
        b=sJdTLnoK4Fss2OA515VcHVbXzt8gRYt8Q7ppEFGb/kSRpm9MFrBLJ/Z/m4JMv67S9+
         SBulN03GKbBOITShkNKDwXgLmtLZdFpcPz1awvLChTC6d+fh4SkmPqAx6Bm/mOfnWaxU
         w8ZA68DoHxwRtE58f2EqSRJFMG2c/2PnC8POOMcuuYHHa7YvgJnQp26zZq8M9lfsc116
         7pRfIqFytbyNevT10j0v+Lt9OIezP6leiJItByUUOChUd2x19FzUlQLR+79wZeUamcdV
         jyfBDyJZVo5TQSZbdxnRqmgfAqW5XtRLNqvbSKfTM+qECpyThBTzgy1ju8jPsmZ3YUn7
         FDmw==
X-Forwarded-Encrypted: i=1; AJvYcCW94Rm9TKypu+zhnKyUkb4TPnl8zo2QZ5Fwj4yzX/U2Ztkt8hzzoQcc9z8PjK7CyHUwjhZALTnoBocDoK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPy7O8srvHC6WmXeCftJYyDqyPwZwXb9COpPRDjxiHblcKds6
	kgcul7yA0cBn8HeSNpJbln6GrKCzhMur8GSycQyXnYnKixqYcD9H22VmWzrBxnQpPIylwXzE7pg
	fRw==
X-Google-Smtp-Source: AGHT+IGGP3PXqrQgYqgMOgQ+kMGQRkSHUgc2dXDaJi8EO81IhrHsgPA17Q69v3HAlkSASN14F+txkPEx7hA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9457:b0:70d:fba:c52b with SMTP id
 d2e1a72fcca58-7173072c955mr48049b3a.3.1725464921051; Wed, 04 Sep 2024
 08:48:41 -0700 (PDT)
Date: Wed, 4 Sep 2024 08:48:39 -0700
In-Reply-To: <CADrL8HWizVVmTvbxpFbVN9M7YhRpJYpVnhK_O7XKYMdy1=DBHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com> <20240809194335.1726916-22-seanjc@google.com>
 <CADrL8HWizVVmTvbxpFbVN9M7YhRpJYpVnhK_O7XKYMdy1=DBHw@mail.gmail.com>
Message-ID: <ZtiBJydMqwkTaoOM@google.com>
Subject: Re: [PATCH 21/22] KVM: x86/mmu: Support rmap walks without holding
 mmu_lock when aging gfns
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024, James Houghton wrote:
> On Fri, Aug 9, 2024 at 12:44=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > DO NOT MERGE, yet...
> >
> > Cc: James Houghton <jthoughton@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 63 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 59 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 48e8608c2738..9df6b465de06 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -995,13 +995,11 @@ static void kvm_rmap_unlock(struct kvm_rmap_head =
*rmap_head,
> >   * locking is the same, but the caller is disallowed from modifying th=
e rmap,
> >   * and so the unlock flow is a nop if the rmap is/was empty.
> >   */
> > -__maybe_unused
> >  static unsigned long kvm_rmap_lock_readonly(struct kvm_rmap_head *rmap=
_head)
> >  {
> >         return __kvm_rmap_lock(rmap_head);
> >  }
> >
> > -__maybe_unused
> >  static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
> >                                      unsigned long old_val)
> >  {
> > @@ -1743,8 +1741,53 @@ static void rmap_add(struct kvm_vcpu *vcpu, cons=
t struct kvm_memory_slot *slot,
> >         __rmap_add(vcpu->kvm, cache, slot, spte, gfn, access);
> >  }
> >
> > -static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
> > -                                  struct kvm_gfn_range *range, bool te=
st_only)
> > +static bool kvm_rmap_age_gfn_range_lockless(struct kvm *kvm,
> > +                                           struct kvm_gfn_range *range=
,
> > +                                           bool test_only)
> > +{
> > +       struct kvm_rmap_head *rmap_head;
> > +       struct rmap_iterator iter;
> > +       unsigned long rmap_val;
> > +       bool young =3D false;
> > +       u64 *sptep;
> > +       gfn_t gfn;
> > +       int level;
> > +       u64 spte;
> > +
> > +       for (level =3D PG_LEVEL_4K; level <=3D KVM_MAX_HUGEPAGE_LEVEL; =
level++) {
> > +               for (gfn =3D range->start; gfn < range->end;
> > +                    gfn +=3D KVM_PAGES_PER_HPAGE(level)) {
> > +                       rmap_head =3D gfn_to_rmap(gfn, level, range->sl=
ot);
> > +                       rmap_val =3D kvm_rmap_lock_readonly(rmap_head);
> > +
> > +                       for_each_rmap_spte_lockless(rmap_head, &iter, s=
ptep, spte) {
> > +                               if (!is_accessed_spte(spte))
> > +                                       continue;
> > +
> > +                               if (test_only) {
> > +                                       kvm_rmap_unlock_readonly(rmap_h=
ead, rmap_val);
> > +                                       return true;
> > +                               }
> > +
> > +                               /*
> > +                                * Marking SPTEs for access tracking ou=
tside of
> > +                                * mmu_lock is unsupported.  Report the=
 page as
> > +                                * young, but otherwise leave it as-is.
>=20
> Just for my own understanding, what's the main reason why it's unsafe

Note, I specifically said "unsupported", not "unsafe" :-D

> to mark PTEs for access tracking outside the mmu_lock?

It probably can be done safely?  The main issue is that marking the SPTE fo=
r
access tracking can also clear the Writable bit, and so we'd need to audit =
all
the flows that consume is_writable_pte().  Hmm, actually, that's less scary=
 than
it first seems, because thanks to kvm_mmu_notifier_clear_young(), KVM alrea=
dy
clears the Writable bit in AD-disabled SPTEs without a TLB flush.  E.g.
mmu_spte_update() specifically looks at MMU-writable, not the Writable bit,=
 when
deciding if a TLB flush is required.

On a related note, I missed is that KVM would need to leaf SPTEs as volatil=
e at
all times, as your MGLRU series modified kvm_tdp_mmu_spte_need_atomic_write=
(),
not the common spte_has_volatile_bits().

Actually, on second though, maybe it isn't necessary for the AD-enabled cas=
e.
Effectively clobbering the Accessed bit is completely fine, as aging is tol=
erant
of false negatives and false positives, so long as they aren't excessive.  =
And
that's doubly true if KVM x86 follows MM and doesn't force a TLB flush[1]

Oooh, and triply true if KVM stops marking the folio accesses when zapping =
SPTEs[2].

So yeah, after thinking though all of the moving parts, maybe we should com=
mit
to aging AD-disabled SPTEs out of mmu_lock.  AD-disabled leaf SPTEs do end =
up being
"special", because KVM needs to ensure it doesn't clobber the Writable bit,=
 i.e.
AD-disabled leaf SPTEs need to be treated as volatile at all times.  But in=
 practice,
forcing an atomic update for all AD-disabled leaf SPTEs probably doesn't ac=
tually
change much, because in most cases KVM is probably using an atomic access a=
nyways,
e.g. because KVM is clearing the Writable bit and the Writable bit is alrea=
dy volatile.

FWIW, marking the folio dirty if the SPTE was writable, as is done today in
mmu_spte_age(), is sketchy if mmu_lock isn't held, but probably ok since th=
is is
invoked from an mmu_notifier and presumably the caller holds a reference to=
 the
page/folio.  But that's largely a moot point since I want to yank out that =
code
anyways[3].

[1] https://lore.kernel.org/all/ZsS_OmxwFzrqDcfY@google.com
[2] https://lore.kernel.org/all/20240726235234.228822-82-seanjc@google.com
[3] https://lore.kernel.org/all/20240726235234.228822-8-seanjc@google.com

> > +                               if (spte_ad_enabled(spte))
> > +                                       clear_bit((ffs(shadow_accessed_=
mask) - 1),
> > +                                                 (unsigned long *)spte=
p);
>=20
> I feel like it'd be kinda nice to de-duplicate this clear_bit() piece
> with the one in kvm_rmap_age_gfn_range().

Ya, definitely no argument against adding a helper.

> > +                               young =3D true;
> > +                       }
> > +
> > +                       kvm_rmap_unlock_readonly(rmap_head, rmap_val);
> > +               }
> > +       }
> > +       return young;
> > +}
> > +
> > +static bool __kvm_rmap_age_gfn_range(struct kvm *kvm,
> > +                                    struct kvm_gfn_range *range, bool =
test_only)
> >  {
> >         struct slot_rmap_walk_iterator iterator;
> >         struct rmap_iterator iter;
> > @@ -1783,6 +1826,18 @@ static bool kvm_rmap_age_gfn_range(struct kvm *k=
vm,
> >         return young;
> >  }
> >
> > +
> > +static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
> > +                                  struct kvm_gfn_range *range, bool te=
st_only)
> > +{
> > +       /* FIXME: This also needs to be guarded with something like ran=
ge->fast_only. */
> > +       if (kvm_ad_enabled())
>=20
> I expect this to be something like `if (kvm_ad_enabled() ||
> range->fast_only)`. With MGLRU, that means the pages will always be the l=
ast
> candidates for eviction, though it is still possible for them to be evict=
ed
> (though I think this would basically never happen). I think this is fine.
>=20
> I think the only other possible choice is to record/return 'not young'/fa=
lse
> instead of 'young'/true if the spte is young but !spte_ad_enabled(). That
> doesn't seem to be obviously better, though we *will* get correct age
> information at eviction time, when !range->fast_only, at which point the =
page
> will not be evicted, and Accessed will be cleared.

As above, I think the simpler solution overall is to support aging AD-disab=
led
SPTEs out of mmu_lock.  The sequence of getting to that end state will be m=
ore
complex, but most of that complexity is going to happen irrespective of thi=
s series.
And it would mean KVM MGLRU support has no chance of landing in 6.12, but a=
gain
I think that's the reality either way.

