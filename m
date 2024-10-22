Return-Path: <linux-kernel+bounces-376425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99A9AB148
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26702847AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B51B5ED1;
	Tue, 22 Oct 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX/Eqwo1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA81B5338;
	Tue, 22 Oct 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608384; cv=none; b=ESkvAk2sgHYS6dz/Df+X+YP/yttXlikf8VZAuIyysCP9tF5apnN/VC71wU+fuXcAbZzykwuQxjZjy7RYEY1iPvA1Kqm8qAURjeKFjdGDsgB97Cfu1v3dZU3+QV4M02UUJ0S8abYKEXYvFHQzcjlwXVj8tn5Ob21dCDaw1gIp6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608384; c=relaxed/simple;
	bh=Fh2C4xJGXENNWpZqv80RU12bD646b4685Dm9INfr9ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BILXVuLushScgKXy9Ia0os95RMKXVNJpsF6zV7F4dLx38cvQoHyTds0Yiyqv1hbFfSVTV1PrJozBgwUOl+01R1+CpwuyKuDqc5O7iktcn6oDKZn+MfCXZxhrsKJAbP8JRpqaZ5vEohrcTcvfiI4eoOhBqDHs+Q/BArZY1VKdiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX/Eqwo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE07C4CEE4;
	Tue, 22 Oct 2024 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729608384;
	bh=Fh2C4xJGXENNWpZqv80RU12bD646b4685Dm9INfr9ZQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LX/Eqwo1+oPZDboZtl67WIeVZH4JpA1xFxlzDwIqeenFldSA8EGtFOprqEeqfcBAH
	 QyLg/Ur8c1PYARPjJufyewnFjMqIbIK3r2USWWDc+gQGeFcZEA/aQyQaqmfQ/n7QKv
	 ikDAbxYHvfCi7y00UeXaegHx9sdjtzEryVevMoWARWBXVU3SFvicyNfHndUkMwtNIH
	 4JpT/SI9p242Z0Ul6yWkD2scNnoHoEWnuaT1+eR4mjmdmtHIf0hQlxla5WAw8HPnkF
	 7RDkGwkqEnBncb+mXUwAyaFdsIhzufrBhJyBsc92nLSDh5SZHroVfbgoxzkg5zyykY
	 McdCP/NgEnOhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 93563CE0A48; Tue, 22 Oct 2024 07:46:23 -0700 (PDT)
Date: Tue, 22 Oct 2024 07:46:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <2f689438-8626-43d7-a762-cd44b8b05cef@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <53b980b3-6bdb-4331-a627-f6e775d23eb1@paulmck-laptop>
 <nycvar.YFH.7.76.2410221357140.20286@cbobk.fhfr.pm>
 <a627c5bd-e219-4d0e-a2d9-8dda44143d8c@paulmck-laptop>
 <Zxe4XT59FhkZbgdq@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxe4XT59FhkZbgdq@sashalap>

On Tue, Oct 22, 2024 at 10:36:13AM -0400, Sasha Levin wrote:
> On Tue, Oct 22, 2024 at 07:22:12AM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 22, 2024 at 02:06:46PM +0200, Jiri Kosina wrote:
> > > On Mon, 21 Oct 2024, Paul E. McKenney wrote:
> > > 
> > > > I have to ask...
> > > >
> > > > Wouldn't more people testing -next result in more pressure to fix
> > > > linux-next problems quickly?
> > > 
> > > I believe I brought up pretty much exactly this at this year's maintainer
> > > summit.
> > > 
> > > >From the discussion it turned out the many people believe that this
> > > investing into this is probably not worth it, as it will require much more
> > > continous, never-ending effort (for which there are probably not enough
> > > resources) than just dealing with the fallout once during the -rc1+ phase.
> > 
> > Thank you for the response and the information!
> > 
> > But why won't this same issues apply just as forcefully to a new
> > linus-next tree?
> > 
> > Full disclosure:  Testing and tracking down bugs in -next can be a bit of
> > a hassle, to be sure, but I expect to continue to do so.  For one thing,
> > dealing with -next is way easier than testing patches on the various
> > mailing lists.
> 
> I'm not trying to change the workflow here, I think all this amounts to
> is just a quality of life improvement for Linus who could ideally merge
> faster if he knows that the pull requests he's looking at will build and
> won't brick his laptop.

I don't understand how creating yet another tree will have that result,
but you have more direct experience with this aspect of the process than
I do.  I do hope that it works out.

> If we start playing games around "must spend X days in linus-next", then
> yes - I agree with you.

I did see the later email indicating that Linus was dead-set against
such a requirement, so there is that.  On the other hand, the subsequent
discussion of publicly documenting which commits had less testing seems
like it might work.  For but one example, I would be suspicious of
commits coming from someone arguing that appearing frequently on that
list is a non-problem.  ;-)

(Yes, yes, there are always exceptions.)

							Thanx, Paul

