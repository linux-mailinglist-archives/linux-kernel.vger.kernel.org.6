Return-Path: <linux-kernel+bounces-400062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3CD9C0860
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5083281D48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCEB20FAA9;
	Thu,  7 Nov 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2a2UmBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487720F5D5;
	Thu,  7 Nov 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988296; cv=none; b=UDbhwQMWOzm0YaU07g550SLGj/QVxQCtFXkX+2+Up22saoORjeOPbnHm5YnzyYgm9BFz51ldQBDTHhro8Q4w36uILUZ9ROZMW5kuDP/ySomXlplRSBm16JVwAH/V5d2N15oojAM4XB9vl8DQfQlgRtnvfg2ffmzgUWThnq6dU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988296; c=relaxed/simple;
	bh=osbP0WJ2uFzZQpPQ+PxJPBu2J9ICZNcpkZM7q+vpqs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGA6ohwKpMbN57l0yBdxxDrKH/c4QVA0hY6+cBAnGp5DJ28peMDgfqhf0wAyUXXaq4NFXz2Y78T2JDUK17g3EHefpAvNEP2ogZjOw3r2/SMg9mSB+NScG4oHoPAc5ndTESS9IUmiGyN1kIzMYnAhNbtOQWm8ZD+BUfWl16/LrvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2a2UmBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2172C4CECC;
	Thu,  7 Nov 2024 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730988295;
	bh=osbP0WJ2uFzZQpPQ+PxJPBu2J9ICZNcpkZM7q+vpqs8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=u2a2UmBHitXM0RtnoNoiDPfl1aJpnsYBN7xoUxUeVXoQBJXzSoGg+bodTGXCEINhr
	 gl+W6j5vmljAsv7tNy7Ve6lnU5NK0TybGLjsWhSx5T18PW7yrUO8bSm70tpdxPdoYi
	 FRHMGCiRj1QgTFcpWiIr4SXK8Sv4AgQWJzj4DFtx/RbMixbb/M8B+BjNBVFzgKrav2
	 rJ5GZPPT7beEhG48vsXJx41zbZgcHSdOTc+/B+G7+PcSnqRA0c2diySIVvoLGKWPuS
	 /6iSjJ8jo+NCP70cpcOaLA54nS+YTYAf5X6ikdvReqwl9qa9pB/p9s7rpZZ/t1i+H7
	 X4xnlKy4Lm0EQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5D8A7CE09F6; Thu,  7 Nov 2024 06:04:55 -0800 (PST)
Date: Thu, 7 Nov 2024 06:04:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: jonas.oberhauser@huaweicloud.com, boqun.feng@gmail.com,
	dhowells@redhat.com, dlustig@nvidia.com, frederic@kernel.org,
	hernan.poncedeleon@huaweicloud.com, j.alglave@ucl.ac.uk,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, luc.maranget@inria.fr, npiggin@gmail.com,
	parri.andrea@gmail.com, peterz@infradead.org,
	quic_neeraju@quicinc.com, stern@rowland.harvard.edu,
	urezki@gmail.com, will@kernel.org
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
Message-ID: <a1a10706-449b-44a7-92fb-edae10c4e21f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
 <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>

On Thu, Nov 07, 2024 at 07:51:52PM +0900, Akira Yokosawa wrote:
> Jonas, despite the CC, your message has not made my gmail mbox, not even
> the spam folder.
> I'm replying using lore's reply link.
> 
> On Thu, 7 Nov 2024 10:05:18 +0100, Jonas Oberhauser wrote:
> > Am 11/6/2024 um 7:00 PM schrieb Paul E. McKenney:
> >> Never mind, I found your patch in my spam folder. 
> > Glad that got cleared up. I had gotten very confused because you had 
> > also responded to the thread with the patch.
> > 
> >  > check this commit on -rcu
> > 
> > For future reference, where can I find the -rcu repository? I couldn't 
> > find the commit on paulmckrcu/linux, but maybe I looked incorrectly.
> 
> You can find your patches at:
> 
>     [v4] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=c53d54ed7e40255ea0ea66dd121672fd22423326
>     [v5] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=9b13bea0966c498629e221c3022a591cc88d4c57
> 
> and
> 
>     [v4] https://github.com/paulmckrcu/linux/commit/c53d54ed7e40255ea0ea66dd121672fd22423326
>     [v5] https://github.com/paulmckrcu/linux/commit/9b13bea0966c498629e221c3022a591cc88d4c57
> 
> As Paul mentioned elsewhere, the [v5] patch misses tags from Boqun at the moment.

Thank you both!

Just for the record, I must sadly but emphatically agree with Jonas's
point about things getting unfixed...

							Thanx, Paul

