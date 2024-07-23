Return-Path: <linux-kernel+bounces-260175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58B93A424
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7A0B2209F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66CD157A5A;
	Tue, 23 Jul 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clnKmAvQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34675156C74;
	Tue, 23 Jul 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750749; cv=none; b=B/FkvETtOAwANXJIz7sDEPQD6CKA/OkbKah0pUYtPeCCqbwXzmiK8slvfFziflTEBpApqsmsCrQM1MzjEKt6H7o5wF3cHYLL2sbDZaPHOHq/j+dqqpJzfdS0pAGMIwSOPaDPMAsMD/V6ZF3x1/vTQH32G4YSX8FV21okDnADZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750749; c=relaxed/simple;
	bh=3KMdKirR+5uJeBNuZveA3AnyH88+bYKyW66Km+vghS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWtvKdODrL4BOAqj7S6133uGvgt1oU0l5n+CUAEAt4BBwUeU90MNtA0BPU+sdjeI9OqviadHIIi1+sUOpLsE5JMBwuQZ1aXsnAHTp+ty2jg6nwoT9Wg0b3N5ufvthYOqybFyBGt/uHM04mbeDMy2yGNDsBipZMhpEi8Jxn+z19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clnKmAvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7680C4AF09;
	Tue, 23 Jul 2024 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721750748;
	bh=3KMdKirR+5uJeBNuZveA3AnyH88+bYKyW66Km+vghS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clnKmAvQOwXBe7A73/OF/NwP18wPGliYAOYYDSu2siqYSHC4x0hIlKiYIrsUUGY82
	 M/Rug8d/gNl1EKBR3QKb8CdNwNGCvKc+n65cL0l1n1H4RFjT6RZinQN9s6TXSi+JY/
	 7kbcFiQTgJMVsBEaP0hnZLxNDOLNosGo5ZxBFdMhKPvdjCNJAxQSXmy5hCQEjLcmj9
	 dx9fqCH3Uh/uTj1/fGigXkEwc5ug1E9rxXj5lEExsgfuYD14xMDAZNZJz6u45WmsF5
	 LoiKanwaKsCf1yW6mPY6PNfL0w4dwk2F7ilflop7GBlx76toS13qTwgFob3DhaOEl4
	 c0btHCb5nx4sQ==
Date: Tue, 23 Jul 2024 17:05:43 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Asahi Lina <lina@asahilina.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, ryan.roberts@arm.com,
	mark.rutland@arm.com
Subject: Re: LPA2 on non-LPA2 hardware broken with 16K pages
Message-ID: <20240723160543.GA26546@willie-the-truck>
References: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
 <20240718131428.GA21243@willie-the-truck>
 <CAMj1kXFi0sRVMRNhMVEnYBrLT4DycPoDMUa9VkP8wqqdf59eeA@mail.gmail.com>
 <20240723145214.GA26403@willie-the-truck>
 <CAMj1kXEkHKtFKFS3ejeDsg1Q+2NY1JibzurzqgwVGqb+1=XrRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEkHKtFKFS3ejeDsg1Q+2NY1JibzurzqgwVGqb+1=XrRg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 23, 2024 at 05:02:15PM +0200, Ard Biesheuvel wrote:
> On Tue, 23 Jul 2024 at 16:52, Will Deacon <will@kernel.org> wrote:
> > On Fri, Jul 19, 2024 at 11:02:29AM -0700, Ard Biesheuvel wrote:
> > > Thanks for the cc, and thanks to Lina for the excellent diagnosis -
> > > this is really helpful.
> > >
> > > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > > > index f8efbc128446..3afe624a39e1 100644
> > > > --- a/arch/arm64/include/asm/pgtable.h
> > > > +++ b/arch/arm64/include/asm/pgtable.h
> > > > @@ -1065,6 +1065,13 @@ static inline bool pgtable_l5_enabled(void) { return false; }
> > > >
> > > >  #define p4d_offset_kimg(dir,addr)      ((p4d_t *)dir)
> > > >
> > > > +static inline
> > > > +p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
> > >
> > > This is in the wrong place, I think - we already define this for the
> > > 5-level case (around line 1760).
> >
> > Hmm, I'm a bit confused. In my tree, we have one definition at line 1012,
> > which is for the 5-level case (i.e. guarded by
> > '#if CONFIG_PGTABLE_LEVELS > 4'). I'm adding a new one at line 1065,
> > which puts it in the '#else' block and means we use an override instead
> > of the problematic generic version when we're folding.
> >
> 
> Indeed. I failed to spot from the context (which is there in the diff)
> that this is in the else branch.

No worries.

> > > > +{
> > >
> > > We might add
> > >
> > > if (pgtable_l4_enabled())
> > >     pgdp = &pgd;
> > >
> > > here to preserve the existing 'lockless' behavior when PUDs are not
> > > folded.
> >
> > The code still needs to be 'lockless' for the 5-level case, so I don't
> > think this is necessary.
> 
> The 5-level case is never handled here.

Urgh, yes, sorry. I've done a fantasticly bad job of explaining myself.

> There is the 3-level case, where the runtime PUD folding needs the
> actual address in order to recalculate the descriptor address using
> the correct shift. In this case, we don't dereference the pointer
> anyway so the 'lockless' thing doesn't matter (afaict)
> 
> In the 4-level case, we want to preserve the original behavior, where
> pgd is not reloaded from pgdp. Setting pgdp to &pgd achieves that.

Right. What I'm trying to get at is the case where we have folding. For
example, with my patch applied, if we have 3 levels then the lockless
GUP walk looks like:


pgd_t pgd = READ_ONCE(*pgdp);

p4dp = p4d_offset_lockless(pgdp, pgd, addr);
	=> Returns pgdp
p4d_t p4d = READ_ONCE(*p4dp);

pudp = pud_offset_lockless(p4dp, p4d, addr);
	=> Returns &p4d, which is again the pgdp
pud_t pud = READ_ONCE(*pudp);


So here we're reloading the same pointer multiple times and my argument
is that if we need to add logic to avoid this for the
pgtable_l4_enabled() case, then we have bigger problems.

> > Yes, we'll load the same entry multiple times,
> > but it should be fine because they're in the context of a different
> > (albeit folded) level.
> >
> 
> I don't understand what you are saying here. Why is that fine?

I think it's fine because (a) the CPU guarantees same address
read-after-read ordering and (b) We only evaluate the most recently read
value. It would be a problem if we mixed data from different reads but,
because the use is confined to that 'level', we don't end up doing that.

Dunno, am I making any sense?

Will

