Return-Path: <linux-kernel+bounces-446143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4189F204E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C987B7A0FAA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E078419939E;
	Sat, 14 Dec 2024 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GrYr3qMk"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66A3D96A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734201135; cv=none; b=r/RwUh5PlidwU/3SIiyVSMOU6FVP6XAAbuIBXJ2VyCCdqlGBNcvMeJdFc7YcVuDLmgaBIKoug1qfTaK7mmhlPKEd6NsGsb7UkzmTOOzcwlex5czBbhfND54jIkRyJ8WafSGB0LO+Hkjh4iev2O/KZlQkAaDNZawi0Ywuw5cEZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734201135; c=relaxed/simple;
	bh=tsNE6VasQ+Ei/NKtPQBXUEmbIn5HlcSNjcWsjIFD8As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmUTVK9210+WSmm0SDSHSGy/ly+7/moY3Xli9xIXtA8WVaq+pODG2vU0iF1OaGF2gLMNoKyrdAHJGontDua3rGNxCK1XwP2AbTy2ZqRuF4THGbNyIsY/GhdEUbdZkzGSwO8OVjC70LTxMBytLJnoHt15+lCamM065746SJ2jXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GrYr3qMk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sClTmN2ak+nqbe6oYuaErN5fVuaZuyGFO1mn6+HleZQ=; b=GrYr3qMkLB3FHivSOUXEvhQEUh
	WkEN+963DRWmTlI2cxQK8hfZoliVOx7mvff7CPDwdPniOtFhoPlFLLzT21T7CCLBpyLNwNLisJGH3
	rixB/pDgF9MpCS4qLF+nYuiWDtUrViJdfZCcbUORQOpUFfqqazM9o4dqqhd45Z8R0ctA4yI4T5dHL
	wXsT9r6txUY8+mGj8qC5J0PJaacQ02tg4HS2BfK/qkV8K5pLcROqSSeWKC+N6P5XM0dpsbRqSo+I5
	IsOPspcX0UMeKsinUSGfDb9CCXtvDEzkw06YzUW/VdExA9s/T2lA0yxqVk3ODyaB2a7Fyrd0M+l/e
	BOgzQVGA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMWvz-00000004Y5X-08xa;
	Sat, 14 Dec 2024 18:32:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7FF7730035F; Sat, 14 Dec 2024 19:32:10 +0100 (CET)
Date: Sat, 14 Dec 2024 19:32:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sched/urgent for v6.13-rc3
Message-ID: <20241214183210.GB10560@noisy.programming.kicks-ass.net>
References: <20241209094822.GAZ1a85tp2J_T7_Ctd@fat_crate.local>
 <Z13BzesSJDSuSXRc@lappy>
 <20241214180537.GA10560@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214180537.GA10560@noisy.programming.kicks-ass.net>

On Sat, Dec 14, 2024 at 07:05:37PM +0100, Peter Zijlstra wrote:
> On Sat, Dec 14, 2024 at 12:36:07PM -0500, Sasha Levin wrote:
> > On Mon, Dec 09, 2024 at 10:48:22AM +0100, Borislav Petkov wrote:
> > > Hi Linus,
> > > 
> > > please pull the sched/urgent lineup for v6.13-rc3.
> > 
> > Hey Boris,
> > 
> > I'm a bit late to this party, but I've started seeing the following
> > warning. I'm not 100% sure that this PR is the culprit because Linus
> > ended up pulling it before I could run tests on it, but I haven't seen
> > this warning before.
> > 
> > [ 1107.003243] ------------[ cut here ]------------
> > [ 1107.010677] WARNING: CPU: 0 PID: 16 at kernel/sched/deadline.c:1995 enqueue_dl_entity+0x4a8/0x570
> 
> Ah, yeah, no. That's a known issue which we *finally* managed to track
> down last week. Unfortunately this sched/urgent pull does not yet
> include those patches.
> 
> If you want them, they can be had here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
> 
> I was meaning to push them to tip/sched/urgent on Monday, so they'd be
> in next week's batch.

/me finds that the robots have blessed them and it's only Saturday, so I
could push them into tip now and then they go to Linus tomorrow.

Yep, let me do that.


