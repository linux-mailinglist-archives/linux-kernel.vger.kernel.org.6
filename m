Return-Path: <linux-kernel+bounces-260951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FCF93B0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4DE1F22602
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B215884B;
	Wed, 24 Jul 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+DNDFzd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79873156871
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823058; cv=none; b=ZV+bazq/Q17WsYkX6Nzkb2D8CJEUj/Dl9DGgLiW9oJqiAcPoMjGNbwKkvNnyeLoXS1aMZFvhgs9I3aeKiir8bXqjjVfLJ7xQkUaDQ8L/sR6OPJvECZQ+jAe+ojT0pxMe/nfEX7ddghLUMo6lTOcPA5PHQGX6M4WqdeBD0Ljce8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823058; c=relaxed/simple;
	bh=csg4Z3+s45IbHVOgFZkpPLJvQyuq8WsMMCvwBc1Qr20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvLs3hpxn6KBXeGnSsOjvF/LaJSWQpgRSVp78EmAK0UyMM4f/YdCldxOi1DRlaA62RAkjRD3mgqwgxZUZZhsbkFA0SpnrSL5jxq4W+38maoXEmJBiqbbZnDbp8kQkLB+U9BpsGGwDbTF1CkPukBpykPaWFMy6q8pb9NIc8dkBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+DNDFzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27861C4AF0F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721823058;
	bh=csg4Z3+s45IbHVOgFZkpPLJvQyuq8WsMMCvwBc1Qr20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k+DNDFzdWGuYzsis1lCTinqYPExVgiTnNLPkL1Es88n0DD8LHNGjcisI6jPhBWbT9
	 TBpQlbt03WDIwlW29BuIiQ3V04c5EZCWeilT2zD20//NjtF9cW5Hgc5T0dRhfQ6MIi
	 HzZF8K/15FbRAW8Me0kG5lh6jOwy519JMEx5OsyNoBjtVffTlSDaBySZOXEvcVUcWM
	 54SSsDOwmIdjQDOjB5UQBL6dQnIb/GvKyaJ14FVwD2wa2Q48khHpBlyDboaC4zKkNH
	 XSiZ8xtpfnJCDDMMbHZqk7BWhwn3dYaOJWmXtwBlIwHf5XQXUaiwudVi1W1DEQgLC/
	 loU6Ryuv0cMkQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f025bc147so4970288e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:10:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWczpK0ioVMya8BBtgLllA4+AgdQbfUUWDIvbyiBGHU483Y75DSOQ8ZCs7XwjN8n+neB4Dr3CGjPzGogNLSL2+roaVnumxUC4lMP6YL
X-Gm-Message-State: AOJu0YycaQtPQOUkIRf9x3oKNgxhHwXDhiGcBvPTTNcYDiWPBKuv1lLu
	KsMCLNHIoApsFIDBLVfqWNcAecWtm3Ew9RwYepXoFzaXIpHf4QItDEEIi2070g8U78jctu2FVDa
	dZ630wQg+mTT07cb8oV13nyGWtH4=
X-Google-Smtp-Source: AGHT+IEv0BF/mQwbqGY48LUWq4SUUbjc31/O/yu0siZ+PJnKmYA/IJfOGhnHtWWy3JVNKSHy8ZslU4klyRnXYs1GV0E=
X-Received: by 2002:a05:6512:ad4:b0:52e:9a91:bba3 with SMTP id
 2adb3069b0e04-52fcf007c36mr1533119e87.15.1721823056391; Wed, 24 Jul 2024
 05:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
 <20240718131428.GA21243@willie-the-truck> <CAMj1kXFi0sRVMRNhMVEnYBrLT4DycPoDMUa9VkP8wqqdf59eeA@mail.gmail.com>
 <20240723145214.GA26403@willie-the-truck> <CAMj1kXEkHKtFKFS3ejeDsg1Q+2NY1JibzurzqgwVGqb+1=XrRg@mail.gmail.com>
 <20240723160543.GA26546@willie-the-truck> <CAMj1kXGPc5k-+CK=CQ=UDTzggtZ+r5aKSzBhvWLh7aY4BxuW+Q@mail.gmail.com>
 <20240724113340.GA27474@willie-the-truck>
In-Reply-To: <20240724113340.GA27474@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 24 Jul 2024 14:10:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGRg7_VS=+SYb2jW7BNCu9BMexjWMOGo0SGALO43qGnkw@mail.gmail.com>
Message-ID: <CAMj1kXGRg7_VS=+SYb2jW7BNCu9BMexjWMOGo0SGALO43qGnkw@mail.gmail.com>
Subject: Re: LPA2 on non-LPA2 hardware broken with 16K pages
To: Will Deacon <will@kernel.org>
Cc: Asahi Lina <lina@asahilina.net>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, ryan.roberts@arm.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 13:33, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jul 23, 2024 at 06:28:16PM +0200, Ard Biesheuvel wrote:
> > On Tue, 23 Jul 2024 at 18:05, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 05:02:15PM +0200, Ard Biesheuvel wrote:
> > > > On Tue, 23 Jul 2024 at 16:52, Will Deacon <will@kernel.org> wrote:
> > > > > On Fri, Jul 19, 2024 at 11:02:29AM -0700, Ard Biesheuvel wrote:
> > ...
> > > > > >
> > > > > > We might add
> > > > > >
> > > > > > if (pgtable_l4_enabled())
> > > > > >     pgdp = &pgd;
> > > > > >
> > > > > > here to preserve the existing 'lockless' behavior when PUDs are not
> > > > > > folded.
> > > > >
> > > > > The code still needs to be 'lockless' for the 5-level case, so I don't
> > > > > think this is necessary.
> > > >
> > > > The 5-level case is never handled here.
> > >
> > > Urgh, yes, sorry. I've done a fantasticly bad job of explaining myself.
> > >
> > > > There is the 3-level case, where the runtime PUD folding needs the
> > > > actual address in order to recalculate the descriptor address using
> > > > the correct shift. In this case, we don't dereference the pointer
> > > > anyway so the 'lockless' thing doesn't matter (afaict)
> > > >
> > > > In the 4-level case, we want to preserve the original behavior, where
> > > > pgd is not reloaded from pgdp. Setting pgdp to &pgd achieves that.
> > >
> > > Right. What I'm trying to get at is the case where we have folding. For
> > > example, with my patch applied, if we have 3 levels then the lockless
> > > GUP walk looks like:
> > >
> > >
> > > pgd_t pgd = READ_ONCE(*pgdp);
> > >
> > > p4dp = p4d_offset_lockless(pgdp, pgd, addr);
> > >         => Returns pgdp
> > > p4d_t p4d = READ_ONCE(*p4dp);
> > >
> > > pudp = pud_offset_lockless(p4dp, p4d, addr);
> > >         => Returns &p4d, which is again the pgdp
> > > pud_t pud = READ_ONCE(*pudp);
> > >
> > >
> > > So here we're reloading the same pointer multiple times and my argument
> > > is that if we need to add logic to avoid this for the
> > > pgtable_l4_enabled() case, then we have bigger problems.
> > >
> >
> > The 3-level case is not relevant here. My suggestion only affects the
> > 4-level case:
>
> That's exactly what I'm uneasy about :/
>

Right.

> > if (pgtable_l4_enabled())
> >    pgdp = &pgd;
> >
> > which prevents us from evaluating *pgdp twice, which seems to me to be
> > the reason these routines exist in the first place. Given that the
> > 3-level runtime-folded case is the one we are trying to fix here, I'd
> > argue that keeping the 4-level case the same as before is important.
>
> I think consistency between 4-level and 3-level is far more important.
> Adding code to avoid reloading the entry for one specific case (the
> pgtable_l4_enabled() case), whilst requiring other cases (e.g. the
> 3-level compile-time folded case) to reload from the pointer is
> inconsistent. Either they both need it or neither of them need it, no?
>

The thing to keep in mind here is that the path via
p4d_to_folded_pud() does not dereference the same pointer either. It
just converts a p4d_t* to a pud_t* by deriving the page tables address
from the p4d_t*, and applying the PUD_SHIFT rather than the P4D_shift
which was applied one level up.

So a) it does not dereference, and b) it refers to a different entry
so the prior dereference loaded the wrong entry.

OTOH, the 4-level path is not only used by 16k+lpa2 (or 16k/48bits),
it is also used by 4k/48bits where pgtable_l4_enabled() is a
compile-time constant TRUE, and this case will no longer be 'lockless'
as before.

However, if I am understanding you correctly, you are saying that

a) p4d_offset_lockless() for <5 levels cannot race in the way that
these macros are intended to address, as the folding implies that the
next-level load is in reality a reload of the same entry, and so we
will be using the latest value
b) reloading the same value is not an issue because this is not a
performance optimization but a concurrency/correctness thing.

I suppose it would be good to clarify this in a comment, as doing the
reload in the implementation of a helper that exists to omit it looks
rather dodgy. But I agree with your analysis, and the additional bits
I suggested are not needed.

