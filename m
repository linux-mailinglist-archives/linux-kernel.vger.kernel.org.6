Return-Path: <linux-kernel+bounces-218154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C83390B9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CCE1F23DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D154198838;
	Mon, 17 Jun 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcWV5tXU"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9C194AD5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649457; cv=none; b=AJkManR+r29OR1J8j0ejHgPQNvEg/2AEAfU1NldgBZPWpMp+PZpfGJcjGwC56wLCIDrQqwOutlViwFxVMG00tTSz7cIWYH7VYoZFm+6BLhid0gLkdDI3Yt6rDaX+ZTwRDEkfLUWlEqGv/PI3yiML8rqMEXJMt9WrQ0RB4g8cwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649457; c=relaxed/simple;
	bh=fyrpp2yF4aIYKTN8cDgvs3STrDN8prieilqUnx09/SI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sL6BjLqwPJZ4mDH660V4EWD/F+ioDEOhQOQJtDOH32N8PQQpg8TDR1cgLvgnrgCWQAGE1LZycuMPkLK0Qll+d5UdJaF0tcO6rZklnFOaKkYghG6aBxGVT54/YpXfSixNjgxUKHbNmFY2IbruFvwOM+ngjpASi6OpzfUJsPDcEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcWV5tXU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c2d4ea53c7so4506236a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718649455; x=1719254255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVb9bJW/yXgkQj+PV0cMLcdHxyPeYBELQ67LgqP0P74=;
        b=fcWV5tXUiqEpCzFRoxZr+WucJQG5JRNMWYy+mP0FN5rW+jApKOlh6e1fEckgnXrRP4
         q1zN/SJFJEtROdXdxseB9eJDlOZ1Adsry2kg9XJvpXlEbJWekudlATEWDdLsCjEeGawF
         pBkNR4jwy1TqYBy5fepgkJlCeLBcp2YNzI/UN7A9OkTNBQvMzen0Hko/JlgO7642Nbct
         Ff8sCteaptJYKoys5nuvBwzhr6mkMd+isTozXWyqc2Y5NMLS1XylCXlUPVYFedVGEIFG
         GkwuqcroRFmjbTnY7ZZ1u4Mp6EEiB+VaOj5FGCxHcDu9zimudPTA7tSCqJhObWXv6mgG
         b5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718649455; x=1719254255;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVb9bJW/yXgkQj+PV0cMLcdHxyPeYBELQ67LgqP0P74=;
        b=LPzMxfclM8jK3QvhQmARJ8LAvBdhgTxPzZBziH1bD2PwZ1/z3J/BpcST80MIphTjLG
         +C17wu8mJWr0HeQ1+38Sx3hxOzK/hj22zh7tZ4sK2X0tmuYPpb7VmNNIgAva/lbYF/j9
         vwdhe5yDKxjm4vI9RMrEX8z+joGRxfo1ciPW5DDK0E99MVJFPM9dk780jIncKflgOTQG
         osp1ea5iH+b7tlI4biuSmAnIzEkRro3Kqobv1oFA3LDZKU1VKH/5h4voJdEWsTAJ4KHM
         pQoGnwGLSx7h/aL8VlrNNGx8fvU+g3zabz1WKiMo88W7jXGz2i7x4eIwXg0R5Ltv2cPo
         jeNA==
X-Forwarded-Encrypted: i=1; AJvYcCVNKOAWsHNuhXA+1p11FujYd1WFuoG+XQxh5eB7uVUPIOMXaTHKyQZz2kS3l6kLxme1iv8DLK9z5i5/SjhXvqPIBju8+q1QwmCCqg+O
X-Gm-Message-State: AOJu0Yw5cR0cZxmROJH3jl4t5pRPIVNyvK1qWAl5eI0U9CzcBi3Ql/g3
	qBoDOYnje9ivmwahOhCh61goxeSVPPfY+KI+e/AlQ7EtE2jvIIRcWyCxOC2CWmGUF4JpKFoQoos
	dIg==
X-Google-Smtp-Source: AGHT+IF3ovJSiOKecScB3AmrwPx3A35/rUgMT/905FvA0ZGLjFKkhGdKFyVMw2sGINH1wDrN4Gap7jytJ8g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9cb:b0:2c4:e074:de83 with SMTP id
 98e67ed59e1d1-2c6c9221593mr1951a91.2.1718649455060; Mon, 17 Jun 2024 11:37:35
 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:37:27 -0700
In-Reply-To: <CADrL8HW3rZ5xgbyGa+FXk50QQzF4B1=sYL8zhBepj6tg0EiHYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAOUHufYGqbd45shZkGCpqeTV9wcBDUoo3iw1SKiDeFLmrP0+=w@mail.gmail.com>
 <CADrL8HVHcKSW3hiHzKTit07gzo36jtCZCnM9ZpueyifgNdGggw@mail.gmail.com>
 <ZmioedgEBptNoz91@google.com> <CADrL8HU_FKHTz_6d=xhVLZFDQ_zQo-zdB2rqdpa2CKusa1uo+A@mail.gmail.com>
 <ZmjtEBH42u7NUWRc@google.com> <CADrL8HUW2q79F0FsEjhGW0ujij6+FfCqas5UpQp27Epfjc94Nw@mail.gmail.com>
 <ZmxsCwu4uP1lGsWz@google.com> <CADrL8HVDZ+m_-jUCaXf_DWJ92N30oqS=_9wNZwRvoSp5fo7asg@mail.gmail.com>
 <ZmzPoW7K5GIitQ8B@google.com> <CADrL8HW3rZ5xgbyGa+FXk50QQzF4B1=sYL8zhBepj6tg0EiHYA@mail.gmail.com>
Message-ID: <ZnCCZ5gQnA3zMQtv@google.com>
Subject: Re: [PATCH v5 4/9] mm: Add test_clear_young_fast_only MMU notifier
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
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

On Mon, Jun 17, 2024, James Houghton wrote:
> On Fri, Jun 14, 2024 at 4:17=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Jun 14, 2024, James Houghton wrote:
> > > On Fri, Jun 14, 2024 at 9:13=E2=80=AFAM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Thu, Jun 13, 2024, James Houghton wrote:
> > > > > I wonder if this still makes sense if whether or not an MMU is "f=
ast"
> > > > > is determined by how contended some lock(s) are at the time.
> > > >
> > > > No.  Just because a lock wasn't contended on the initial aging does=
n't mean it
> > > > won't be contended on the next round.  E.g. when using KVM x86's sh=
adow MMU, which
> > > > takes mmu_lock for write for all operations, an aging operation cou=
ld get lucky
> > > > and sneak in while mmu_lock happened to be free, but then get stuck=
 behind a large
> > > > queue of operations.
> > > >
> > > > The fast-ness needs to be predictable and all but guaranteed, i.e. =
lockless or in
> > > > an MMU that takes mmu_lock for read in all but the most rare paths.
> > >
> > > Aging and look-around themselves only use the fast-only notifiers, so
> > > they won't ever wait on a lock (well... provided KVM is written like
> > > that, which I think is a given).
> >
> > Regarding aging, is that actually the behavior that we want?  I thought=
 the plan
> > is to have the initial test look at all MMUs, i.e. be potentially slow,=
 but only
> > do the lookaround if it can be fast.  IIUC, that was Yu's intent (and p=
eeking back
> > at v2, that is indeed the case, unless I'm misreading the code).
>=20
> I believe what I said is correct. There are three separate things going o=
n here:
>=20
> 1. Aging (when we hit the low watermark, scan PTEs to find young pages)
> 2. Eviction (pick a page to evict; if it is definitely not young, evict i=
t)
> 3. Look-around (upon finding a page is young upon attempted eviction,
> check adjacent pages if they are young too)

Ah, I now see the difference between #1 and #2, and your responses make a l=
ot more
sense.  Thanks!

> > If KVM _never_ consults shadow (nested TDP) MMUs, then a VM running an =
L2 will
> > end up with hot pages (used by L2) swapped out.
>=20
> The shadow MMU is consulted at eviction time -- only at eviction time.
> So pages used by L2 won't be swapped out unless they're still cold at
> eviction time.
>=20
> In my (and Yu's) head, not being able to do aging for nested TDP is ok
> because running nested VMs is much more rare than running non-nested
> VMs. And in the non-nested case, being able to do aging is a strict
> improvement over what we have now.

Yes and no.  Running nested VMs is indeed rare when viewing them as a perce=
ntage
of all VMs in the fleet, but for many use cases, the primary workload of a =
VM is
to run nested VMs.  E.g. say x% of VMs in the fleet run nested VMs, where '=
x' is
likely very small, but for those x% VMs, they run nested VMs 99% of the tim=
e
(completely made up number).

So yes, I completely agree that aging for non-nested VMs is a strict improv=
ement,
but I also think don't think we should completely dismiss nested VMs as a p=
roblem
not worth solving.

> We could look into being able to do aging with the shadow MMU, but I
> don't think that should necessarily block this series.

...

> > Ooh!  Actually, after fiddling a bit to see how feasible fast-aging in =
the shadow
> > MMU would be, I'm pretty sure we can do straight there for nested TDP. =
 Or rather,
> > I suspect/hope we can get close enough for an initial merge, which woul=
d allow
> > aging_is_fast to be a property of the mmu_notifier, i.e. would simplify=
 things
> > because KVM wouldn't need to communicate MMU_NOTIFY_WAS_FAST for each n=
otification.
> >
> > Walking KVM's rmaps requires mmu_lock because adding/removing rmap entr=
ies is done
> > in such a way that a lockless walk would be painfully complex.  But if =
there is
> > exactly _one_ rmap entry for a gfn, then slot->arch.rmap[...] points di=
rectly at
> > that one SPTE.  And with nested TDP, unless L1 is doing something uncom=
mon, e.g.
> > mapping the same page into multiple L2s, that overwhelming vast majorit=
y of rmaps
> > have only one entry.  That's not the case for legacy shadow paging beca=
use kernels
> > almost always map a pfn using multiple virtual addresses, e.g. Linux's =
direct map
> > along with any userspace mappings.
=20
...

> Hmm, interesting. I need to spend a little bit more time digesting this.
>=20
> Would you like to see this included in v6? (It'd be nice to avoid the
> WAS_FAST stuff....) Should we leave it for a later series? I haven't
> formed my own opinion yet.

I would say it depends on the viability and complexity of my idea.  E.g. if=
 it
pans out more or less like my rough sketch, then it's probably worth taking=
 on
the extra code+complexity in KVM to avoid the whole WAS_FAST goo.

Note, if we do go this route, the implementation would need to be tweaked t=
o
handle the difference in behavior between aging and last-minute checks for =
eviction,
which I obviously didn't understand when I threw together that hack-a-patch=
.

I need to think more about how best to handle that though, e.g. skipping GF=
Ns with
multiple mappings is probably the worst possible behavior, as we'd risk evi=
cting
hot pages.  But falling back to taking mmu_lock for write isn't all that de=
sirable
either.

