Return-Path: <linux-kernel+bounces-379110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD99ADA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495651C2137F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62804155308;
	Thu, 24 Oct 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cysmbiHP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B1482EB;
	Thu, 24 Oct 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729738265; cv=none; b=llPEOMygjtNLWXP6K1GvdeTRbIlpZ6M1czKMZTy/mWP0p2M8CJ8R6srWpaqETypuv7rjbPG0Ed+WigYAn1D8UhlYcftjWDzBIpIqunbQMQLNKoAjh4af13wMg+hbq7ojv4d0z9vjxaQoe7jT2jutU5VVLzToYmfINF5Hk33Ipsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729738265; c=relaxed/simple;
	bh=s8oTUHO03fC/qI1d52y3DAo81DcFlugJmoOFYUFCsEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWmp6mdHY+A7WFZwaFBI6VzEkUZWGDBFuzHRE6mvgGpYH5iZRQ46z/gMwhRejgz9/Jh5wPrk99za00cVFBBm13GtNXAIl6RcuCMgHdFga2dsqbA3pcLoN9mCoGlmUjgl6QFabh7ZCa7DzN95DVQ/4yYn7kJWz9EiYq6xRts94uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cysmbiHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB2DC4CEC6;
	Thu, 24 Oct 2024 02:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729738265;
	bh=s8oTUHO03fC/qI1d52y3DAo81DcFlugJmoOFYUFCsEo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cysmbiHPBuSQvoyEFF6Q8ZtDnRmZQSx35Iw8AwcLamSae2bV0dvxv2rQSLPXNVgky
	 7Pxw0BLhIl5n/a1TkkG+oK350pYCIuvmVXShSRcDKke+VSO1ITOUYxBm9XR7WLYpHV
	 kCR9l7knXSgPoUmqXG+c/sTNRdppvxZoAgj8FOIjiwhbMczH+U0ibOHXgxGW+E5yUD
	 Zvg2Fla3GxpJHJ+vckvH/0dlXg9ZkboeBOvA+j66VddriDtPzxc3dwBSV869HaqbZG
	 5vOtxMGCBedeWUKqV9ZNFzTMT32OiPR3sUVyObT5DTAnJDznfm3TqnbKJUfwYw10fY
	 RUwS99HRZR8Bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BEA43CE0D0D; Wed, 23 Oct 2024 19:51:04 -0700 (PDT)
Date: Wed, 23 Oct 2024 19:51:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <d8087943-0a9c-4e1e-8873-48a15e1311dc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZxdyYjzxSktk34Zz@sashalap>
 <ZxiOjBRdO6EMAY4H@infradead.org>
 <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
 <CAHk-=wj4aSJsVA6weV7u9KD1yA74JZq3dYZKbUtxp=3o_esnVA@mail.gmail.com>
 <bf42489f-4a86-4717-b367-d8be877b3036@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf42489f-4a86-4717-b367-d8be877b3036@sirena.org.uk>

On Wed, Oct 23, 2024 at 10:24:29PM +0100, Mark Brown wrote:
> On Wed, Oct 23, 2024 at 11:06:59AM -0700, Linus Torvalds wrote:
> 
> > And yes, I know some people do functional testing on linux-next
> > already. The message at the maintainer summit was a bit mixed with
> > some people saying linux-next tends to work even for that, others
> > saying it's often too broken to be useful.
> 
> It very much depends on what you're trying to get out of the testing -
> -next does work well most of the time, but it will absolutely just blow
> up catastrophically on you from time time to time so you have to be
> prepared to cope with loosing some or all of your coverage sometimes.
> Usually anything major gets fixed fairly promptly, but sometimes you'll
> be missing coverage for extended periods especially if it's something
> like a more niche platform that's been broken or there's some problem
> getting people to actually apply the fixes.  Submaintainer trees that
> people don't want to add to -next can be an issue too.
> 
> You're also going to run into issues that are nothing to do with
> whatever you're actually working on yourself and need to consider what
> you're covering based on your tolerance for dealing with that.  The rate
> of change can also be an issue if the tests you're intersted in are
> expensive.  OTOH if you're doing things that are likely to be affected
> by changes in a broad set of trees (eg, maintaining some embedded
> platform where you care about all the various subsystems breaking
> platform specific drivers) it can be a lot easier to cover -next rather
> than all the individual subsystems.

You said it much better than I did, thank you!

For me, -next is a convenient point to test much of what will be going in.
Yes, it can be frustrating, finding problems just as someone else fixed
them, finding problems irrelevant to any of my use cases, and so on.
But sometimes I find something that would have been quite painful to
deal with later in process that others don't find.  Overall, it is well
worth the my effort.

							Thanx, Paul

