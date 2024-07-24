Return-Path: <linux-kernel+bounces-260925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6AA93B05A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C61B1F21912
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5615748C;
	Wed, 24 Jul 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ4qpA9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1903481CD;
	Wed, 24 Jul 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820826; cv=none; b=StywqatLyycMeY3HMI2vw7WsMFE02po3nk3KQQodf15OdAinuDoANMRqPnHgtPcd+gQsAJm8DifkHI9SM5Gvibu0vbenqZbLHodnxOcljjfdVAFr9RF75Ka6pNNDki/+9tkMFRJmrRCGOZa+AfbW7aSDvLUYAazyFyg8a15VcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820826; c=relaxed/simple;
	bh=gBHbPU82zZ4Z5Y800YED50fqun4wIRYLdr5Afy6feFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTzE2ovxWpCgPfkFjmshDzwjofR1ox9bOuJFXWJHFKGEQeqz4DuhZTS5VBnQ31c06WUq49G8M0xO1VOwL3mTMwI+uYz96Guij/F3umzp2xgRCi2bR7oHbbLlJ/WbLzdev4wTsAsi5lcZAo8j/OrLRW5kmai2PK7oSmMuyZrYNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ4qpA9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE80C32782;
	Wed, 24 Jul 2024 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721820826;
	bh=gBHbPU82zZ4Z5Y800YED50fqun4wIRYLdr5Afy6feFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZ4qpA9JLoAPUfFf4NYmLc6cuTleS/PmaQSRVFPL//tKrDKb99/zmkxlWj2fUnRkd
	 u/0hhIo71tZ1YWj9KDw4jLlO9+7D67M4G+6B6UcVWi0U/fGbanBzlWs2uyy2eAIwsl
	 eCeuj6/HUcRzU0kZQQLPb4k8dh4HLRV4uBxkdBsDWziYBPdoUZA+TeR7WwM0eGdSnP
	 1t9EEwcHJUO8hGoNof2RqR/PBu9o5DVro/UjSxMMb41JiNLxguFKClOxPq77OWG/ax
	 YgSOJsJgmnqt0P9oEIJGF85d+gLXtM9IXYedBp0wIcHZLwMJRtLKKNpuwohem22peP
	 W1Ho4J/4rIpww==
Date: Wed, 24 Jul 2024 12:33:41 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Asahi Lina <lina@asahilina.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, ryan.roberts@arm.com,
	mark.rutland@arm.com
Subject: Re: LPA2 on non-LPA2 hardware broken with 16K pages
Message-ID: <20240724113340.GA27474@willie-the-truck>
References: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
 <20240718131428.GA21243@willie-the-truck>
 <CAMj1kXFi0sRVMRNhMVEnYBrLT4DycPoDMUa9VkP8wqqdf59eeA@mail.gmail.com>
 <20240723145214.GA26403@willie-the-truck>
 <CAMj1kXEkHKtFKFS3ejeDsg1Q+2NY1JibzurzqgwVGqb+1=XrRg@mail.gmail.com>
 <20240723160543.GA26546@willie-the-truck>
 <CAMj1kXGPc5k-+CK=CQ=UDTzggtZ+r5aKSzBhvWLh7aY4BxuW+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGPc5k-+CK=CQ=UDTzggtZ+r5aKSzBhvWLh7aY4BxuW+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 23, 2024 at 06:28:16PM +0200, Ard Biesheuvel wrote:
> On Tue, 23 Jul 2024 at 18:05, Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Jul 23, 2024 at 05:02:15PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 23 Jul 2024 at 16:52, Will Deacon <will@kernel.org> wrote:
> > > > On Fri, Jul 19, 2024 at 11:02:29AM -0700, Ard Biesheuvel wrote:
> ...
> > > > >
> > > > > We might add
> > > > >
> > > > > if (pgtable_l4_enabled())
> > > > >     pgdp = &pgd;
> > > > >
> > > > > here to preserve the existing 'lockless' behavior when PUDs are not
> > > > > folded.
> > > >
> > > > The code still needs to be 'lockless' for the 5-level case, so I don't
> > > > think this is necessary.
> > >
> > > The 5-level case is never handled here.
> >
> > Urgh, yes, sorry. I've done a fantasticly bad job of explaining myself.
> >
> > > There is the 3-level case, where the runtime PUD folding needs the
> > > actual address in order to recalculate the descriptor address using
> > > the correct shift. In this case, we don't dereference the pointer
> > > anyway so the 'lockless' thing doesn't matter (afaict)
> > >
> > > In the 4-level case, we want to preserve the original behavior, where
> > > pgd is not reloaded from pgdp. Setting pgdp to &pgd achieves that.
> >
> > Right. What I'm trying to get at is the case where we have folding. For
> > example, with my patch applied, if we have 3 levels then the lockless
> > GUP walk looks like:
> >
> >
> > pgd_t pgd = READ_ONCE(*pgdp);
> >
> > p4dp = p4d_offset_lockless(pgdp, pgd, addr);
> >         => Returns pgdp
> > p4d_t p4d = READ_ONCE(*p4dp);
> >
> > pudp = pud_offset_lockless(p4dp, p4d, addr);
> >         => Returns &p4d, which is again the pgdp
> > pud_t pud = READ_ONCE(*pudp);
> >
> >
> > So here we're reloading the same pointer multiple times and my argument
> > is that if we need to add logic to avoid this for the
> > pgtable_l4_enabled() case, then we have bigger problems.
> >
> 
> The 3-level case is not relevant here. My suggestion only affects the
> 4-level case:

That's exactly what I'm uneasy about :/

> if (pgtable_l4_enabled())
>    pgdp = &pgd;
> 
> which prevents us from evaluating *pgdp twice, which seems to me to be
> the reason these routines exist in the first place. Given that the
> 3-level runtime-folded case is the one we are trying to fix here, I'd
> argue that keeping the 4-level case the same as before is important.

I think consistency between 4-level and 3-level is far more important.
Adding code to avoid reloading the entry for one specific case (the
pgtable_l4_enabled() case), whilst requiring other cases (e.g. the
3-level compile-time folded case) to reload from the pointer is
inconsistent. Either they both need it or neither of them need it, no?

> > > > Yes, we'll load the same entry multiple times,
> > > > but it should be fine because they're in the context of a different
> > > > (albeit folded) level.
> > > >
> > >
> > > I don't understand what you are saying here. Why is that fine?
> >
> > I think it's fine because (a) the CPU guarantees same address
> > read-after-read ordering and (b) We only evaluate the most recently read
> > value. It would be a problem if we mixed data from different reads but,
> > because the use is confined to that 'level', we don't end up doing that.
> >
> > Dunno, am I making any sense?
> >
> 
> So what is the point of p?d_offset_lockless()? Is it a performance
> optimization that we don't care about on arm64? Or does this reasoning
> still only apply to the folded case?

Well, naturally it's all undocumented. S390 added the macros, but it
looks like that was because they hit a similar problem to the one
reported by Lina (see d3f7b1bb2040 ("mm/gup: fix gup_fast with dynamic
page table folding")) and, really, that change is just moving the logic
out of the fast GUP code and into some new macros.

If you think about trying to do fast GUP using the regular pXd_offset()
macros with 5 levels, the problem is a little more obvious. For example,
it would look something like:

	// gup_fast_pgd_range()
	pgd_t pgd = READ_ONCE(*pgdp);

	if (pgd_none(pgd))
		return;

	...

	// gup_fast_p4d_range()
	p4dp = p4d_offset(pgdp, addr);
		=> READ_ONCE(*pgdp);

A concurrent writer could e.g. clear *pgdp between the two reads and
we'd end up with junk in p4dp because of a ToCToU-type bug.

But I don't think that applies to the case we're discussing, because the
reload of the entry happens in the following READ_ONCE() rather than
in the _offset macro:

	p4d_t p4d = READ_ONCE(*p4dp);

and, as this is in the context of a new level, everything is then
rechecked so that a concurrent modification won't cause us to crash.

Will

