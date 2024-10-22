Return-Path: <linux-kernel+bounces-376386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57E9AB0B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEE428357D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868E1A08B6;
	Tue, 22 Oct 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojA/1PjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D91A01D4;
	Tue, 22 Oct 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606933; cv=none; b=CJb7red29kWrsHkSl3TuPeAtxtU+ZrKVQIidhDefCwuP17dg+P0T5Em/u7FpZbLi+RXuP2di54pvGqLbzWMrxxGWRGyzE9ZC58L2D3YZtQFwBdF8Gziby/9owvjlz0X80uslxDOHcRrr06ZDuAXOXDCU0VZpVQej//4FSmLlKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606933; c=relaxed/simple;
	bh=iJHn87vkgLfnLIDakzLFyyojgl+FR5MWtZ4S4LA8uu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0xOFut8QwdB/vLG3gdCmFxp++lHaInX8ctsVgJoqUPLLrQKFeqhIm1qtyPSWaMLOw7LVZxPX90ROgJwWy/0a45kUGkA+6oTpXeWInb3M4onVp2QS0tQ7VethSyHvM0R1+LrS9lhwasvLPaQyFaoxmHZNMf+ZMPwjybO26U7Ey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojA/1PjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171B8C4CEC3;
	Tue, 22 Oct 2024 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729606933;
	bh=iJHn87vkgLfnLIDakzLFyyojgl+FR5MWtZ4S4LA8uu0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ojA/1PjEnyx1rfQ3GVzJOw02VyesI9Bz7AfnoncfATKyX71SqlPSTvMeEoMMsyYXg
	 E3I9OH/J9iq5K6BVxd9VckKoMg3SwbGsZY7WZv1gwQ/KmBzw6rWO1hXZPtlfjFqjaV
	 3y+D+irhXyfHPw8EXvFufUGcrTl2oqa2i6yVwy2ptrNtDK0yMmUUqfH1g2dtLf/iLg
	 bwebjQjhFLBjTS4rpjZ3d5QV+CRo7PMLk32pGOEBFzs8F4RD5dWkGJVd24DkMX65kt
	 xxwq/xVjncY5slaPBXAKLsPJuJ0GGGW943+Ucm83bMKF86L4X93qeKLuDlTHVsCH0M
	 NZnZjWyy0/l8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B0818CE0A48; Tue, 22 Oct 2024 07:22:12 -0700 (PDT)
Date: Tue, 22 Oct 2024 07:22:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <a627c5bd-e219-4d0e-a2d9-8dda44143d8c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <53b980b3-6bdb-4331-a627-f6e775d23eb1@paulmck-laptop>
 <nycvar.YFH.7.76.2410221357140.20286@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2410221357140.20286@cbobk.fhfr.pm>

On Tue, Oct 22, 2024 at 02:06:46PM +0200, Jiri Kosina wrote:
> On Mon, 21 Oct 2024, Paul E. McKenney wrote:
> 
> > I have to ask...
> > 
> > Wouldn't more people testing -next result in more pressure to fix
> > linux-next problems quickly?
> 
> I believe I brought up pretty much exactly this at this year's maintainer 
> summit.
> 
> >From the discussion it turned out the many people believe that this 
> investing into this is probably not worth it, as it will require much more 
> continous, never-ending effort (for which there are probably not enough 
> resources) than just dealing with the fallout once during the -rc1+ phase.

Thank you for the response and the information!

But why won't this same issues apply just as forcefully to a new
linus-next tree?

Full disclosure:  Testing and tracking down bugs in -next can be a bit of
a hassle, to be sure, but I expect to continue to do so.  For one thing,
dealing with -next is way easier than testing patches on the various
mailing lists.

							Thanx, Paul

