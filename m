Return-Path: <linux-kernel+bounces-211998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F19059CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E2D1C210CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F31822C8;
	Wed, 12 Jun 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ED6QTUpf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7C1822D5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213023; cv=none; b=YJy2i9kb0PvWZUCNuLjhfTMrtDHOiKQLYEEGdhYQD6taufN+5LuVqarLI8c8cW41fAGrcfYx0LeFjnpntzP6Sxbnl8dH47uPBwOxyFAQpyevb8THV/HWdczC8sD/a0MJSJy1NNwsGjiTWOVNB8Z7orbs2DF4YhQbIKxCBRLGmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213023; c=relaxed/simple;
	bh=qvzOGVZF1aFjcNNXoWdAyWZv4lQeSovWWQTrEs6pNdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z8sz0X2WLLDv8aORh9x0UDqc2jZ2HVuLfAePR9PjjtOm4OenNlE+6u9wZbS9dzDp7vSKosateft6Z6hvG+pr50wYwl/b31LlBfyNUTr5/4uj/v4r1sAgneZVSkTDPrYmaQTn4R5pDxQ8iza4BpodFWaW8WfERtHWTEL8bD6XKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ED6QTUpf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfe4f388d33so124057276.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718213020; x=1718817820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0uZvClGSP7b0LMzzAPVM0AhM29ZDe2y2D54OZuyJ4o=;
        b=ED6QTUpflG01XxDwADpCTuUCb3My1wmNO1KRIabL/mB6J08kl5ENGX51vmpVHsg6xR
         jFv33Xhk3VXxWTVvpGKAaIotK7Zksj8HAw0XHs6pGvPnVz+1x1dCCWPEFUm/SJy06FLi
         BpuEPZLYakQWef9qNxKBc3A3XsNZbfd6mt7/jBNk0WSx8e0xYM5diG+B74Wd60h/dixp
         Ae7x+VxLhJaqlumRqtc3pPayDW5jcNJHxwn3EmaYD3cAVYZ7BtagZ8ZPWqNrRQf8GGOR
         qUscLQNTNlkm6MS3vd2OpolLDv7GKWif+u6p98TUEVHK9IwK5SEi6mXOlkhAKEmwzS4n
         qyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718213020; x=1718817820;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v0uZvClGSP7b0LMzzAPVM0AhM29ZDe2y2D54OZuyJ4o=;
        b=ZphytQPNvuDFNDvhd30zOkiLRORgWXunze1qk3y82J7N3HqBCVWF1B9f3d03LMwqfo
         ktcNzRPLHQ9+mdahizpUY1jGQzNNxZCjdPYlVMaSiDk3HADJMVRSeA5Omt1AkDcLXPr/
         VLrSaN0E4E71MgTOeXEE6jzUFp5DWqSGIcEL3Knx30rEC0DlY2fqIiExlSw2Dxdfhh39
         nQ0cSHOil8++8BWlTe6FfZXh7tH+6+7niQFdyf6uRl9kCGKhwTKCGF+WS4/7jB7N6KY3
         k3JVJytqH4EcHYIDbf7hRang0wR+Y+/FB4FZoxM5P1Q/peesxVK3T8hgzrgIk2zbPsz2
         gIPg==
X-Forwarded-Encrypted: i=1; AJvYcCUF66Eq5ikfNgNvWkrMU5Ec5AdUcsKROvBwr3SCGE7UEg7MRItoYCvBW3y++ury4fri38maRlbu9op5Pig81YujtadrcKGoZg1NTT7R
X-Gm-Message-State: AOJu0YxUCwvWBnFdhHHuHMeJQJZGTeaDCJhIFYpyjEMec5RpxfSk4R98
	jx96imUr7Ct7jl+1p759p8E0PyrSE2gelto+pioTGEf0vur4tcXVkF2RM6ba4hdXb0K41jUOb6/
	+NA==
X-Google-Smtp-Source: AGHT+IHsuziTjwu8H3LsGOZG3nq2ECdUkM7fJ/s+9lw1k304/SuAsQ64WUp2lf97WzRuhz9PeWwlSE0Bo58=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:729:b0:dfb:b4e:407a with SMTP id
 3f1490d57ef6-dfe68035fbemr647880276.9.1718213020117; Wed, 12 Jun 2024
 10:23:40 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:23:38 -0700
In-Reply-To: <CAOUHufYCmYNngmS=rOSAQRB0N9ai+mA0aDrB9RopBvPHEK42Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611002145.2078921-1-jthoughton@google.com>
 <20240611002145.2078921-9-jthoughton@google.com> <ZmnGlpBR91TyI3Lt@google.com>
 <CAOUHufYCmYNngmS=rOSAQRB0N9ai+mA0aDrB9RopBvPHEK42Ng@mail.gmail.com>
Message-ID: <ZmnZmj8iVmcLf8fo@google.com>
Subject: Re: [PATCH v5 8/9] mm: multi-gen LRU: Have secondary MMUs participate
 in aging
From: Sean Christopherson <seanjc@google.com>
To: Yu Zhao <yuzhao@google.com>
Cc: James Houghton <jthoughton@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Wei Xu <weixugc@google.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024, Yu Zhao wrote:
> On Wed, Jun 12, 2024 at 10:02=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Tue, Jun 11, 2024, James Houghton wrote:
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index e8fc5ecb59b2..24a3ff639919 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -870,13 +870,10 @@ static bool folio_referenced_one(struct folio *=
folio,
> > >                       continue;
> > >               }
> > >
> > > -             if (pvmw.pte) {
> > > -                     if (lru_gen_enabled() &&
> > > -                         pte_young(ptep_get(pvmw.pte))) {
> > > -                             lru_gen_look_around(&pvmw);
> > > +             if (lru_gen_enabled() && pvmw.pte) {
> > > +                     if (lru_gen_look_around(&pvmw))
> > >                               referenced++;
> > > -                     }
> > > -
> > > +             } else if (pvmw.pte) {
> > >                       if (ptep_clear_flush_young_notify(vma, address,
> > >                                               pvmw.pte))
> > >                               referenced++;
> >
> > Random question not really related to KVM/secondary MMU participation. =
 AFAICT,
> > the MGLRU approach doesn't flush TLBs after aging pages.  How does MGLR=
U mitigate
> > false negatives on pxx_young() due to the CPU not setting Accessed bits=
 because
> > of stale TLB entries?
>=20
> I do think there can be false negatives but we have not been able to
> measure their practical impacts since we disabled the flush on some
> host MMUs long ago (NOT by MGLRU), e.g., on x86 and ppc,
> ptep_clear_flush_young() is just ptep_test_andclear_young().

Aha!  That's what I was missing, I somehow didn't see x86's ptep_clear_flus=
h_young().

That begs the question, why does KVM flush TLBs on architectures that don't=
 need
to?  And since kvm_mmu_notifier_clear_young() explicitly doesn't flush, are=
 there
even any KVM-supported architectures for which the flush is mandatory?

Skipping the flush on KVM x86 seems like a complete no-brainer.

Will, Marc and/or Oliver, what are arm64's requirements in this area?  E.g.=
 I see
that arm64's version of __ptep_clear_flush_young() does TLBI but not DSB.  =
Should
KVM be doing something similar?  Can KVM safely skip even the TBLI?

> theoretical basis is that, given the TLB coverage trend (Figure 1 in
> [1]), when a system is running out of memory, it's unlikely to have
> many long-lived entries in its TLB. IOW, if that system had a stable
> working set (hot memory) that can fit into its TLB, it wouldn't hit
> page reclaim. Again, this is based on the theory (proposition) that
> for most systems, their TLB coverages are much smaller than their
> memory sizes.
>=20
> If/when the above proposition doesn't hold, the next step in the page
> reclaim path, which is to unmap the PTE, will cause a page fault. The
> fault can be minor or major (requires IO), depending on the race
> between the reclaiming and accessing threads. In this case, the
> tradeoff, in a steady state, is between the PF cost of pages we
> shouldn't reclaim and the flush cost of pages we scan. The PF cost is
> higher than the flush cost per page. But we scan many pages and only
> reclaim a few of them; pages we shouldn't reclaim are a (small)
> portion of the latter.
>=20
> [1] https://www.usenix.org/legacy/events/osdi02/tech/full_papers/navarro/=
navarro.pdf

