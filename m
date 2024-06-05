Return-Path: <linux-kernel+bounces-202625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014318FCEE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EB61F276BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9F1957F0;
	Wed,  5 Jun 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHUw4hyj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC71957E3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591229; cv=none; b=TCjPDdta17beJLTO03Qv2Z8VU6fOhPS2gR38wT1o7ifT/Q4NOcN72BN1FSClEo1ObxUuItdXlu1mgX/hWi2601JhjjYYE34/3wud00pdVSEn5SS+SS6o5+As0oMSti4o7CVffLItOec5mqD+Ar6B9nHPssZI9FN/EH2MM3DqmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591229; c=relaxed/simple;
	bh=fTj8oqzixDOnw98MMc7gAnO1TsJrNYBGRMd8QpqOvpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX62Z6JeLyajNePD8Fc4XAQn1y42n6jcIKbSKXq/hOjzscNXtfk5DxkHzc9bLmw+8Ty6wiETNtAS34IF6nJl0kORJXAggR8fX/6SBduk1DZ3Z0rcDpKu7XNvJwy1OCPYfMdATSFF27I+bBmX5O0mySr2LgSLys1kV/MTXfXslf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHUw4hyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBD9C4AF0C;
	Wed,  5 Jun 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717591228;
	bh=fTj8oqzixDOnw98MMc7gAnO1TsJrNYBGRMd8QpqOvpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHUw4hyjTzdGTrr31aRBhvPcUxxIQB+CF4oSvRyygdllkwSV0/Lqc5Qz/NZ/DOytM
	 TItnS8yTMEZ/RbnOqau8lVCSPY22r0zPT5TnvZ7suoL43ZhVW/XvDqSxkglbvosDHw
	 rHaJqwxNK4crqamkt4ZYgV5G1k3UDkpdjj5W/D5pE/vPE2xXdEGJr753HhUBeT0HXg
	 51jCig/hOWr58WCHUhC1zNP54LLMjCI+OVk/r4rUQvITFt/K0xPRcFFDwPkc+xMlO4
	 62RT7HMopxKSL8uEWZWpI3Hr32UOOx/495D/5MYudyl434/48i1Ahc3DOTO8szJYiw
	 NCjPblmn5rcPw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEpwM-000000007gp-0z0r;
	Wed, 05 Jun 2024 14:40:30 +0200
Date: Wed, 5 Jun 2024 14:40:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] mfd: lm3533: Hide legacy platform data in the
 driver
Message-ID: <ZmBcvtLCzllQDWVX@hovoldconsulting.com>
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
 <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
 <20240531150048.GO1005600@google.com>
 <Zlnn89KPSHSCp3Bh@smile.fi.intel.com>
 <20240531155445.GS1005600@google.com>
 <Zln9lRvKJYwlSM3l@smile.fi.intel.com>
 <20240531165834.GA1204315@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531165834.GA1204315@google.com>

On Fri, May 31, 2024 at 05:58:34PM +0100, Lee Jones wrote:
> On Fri, 31 May 2024, Andy Shevchenko wrote:
> 
> > On Fri, May 31, 2024 at 04:54:45PM +0100, Lee Jones wrote:
> > > On Fri, 31 May 2024, Andy Shevchenko wrote:
> > > > On Fri, May 31, 2024 at 04:00:48PM +0100, Lee Jones wrote:
> > > > > On Wed, 08 May 2024, Andy Shevchenko wrote:
> > > > > 
> > > > > > First of all, there is no user for the platform data in the kernel.
> > > > > > Second, it needs a lot of updates to follow the modern standards
> > > > > > of the kernel, including proper Device Tree bindings and device
> > > > > > property handling.
> > > > > > 
> > > > > > For now, just hide the legacy platform data in the driver's code.
> > > > > 
> > > > > Why not just rip it out entirely?
> > > > 
> > > > You mean the driver?
> > > 
> > > The unused platform data.
> > 
> > Good question. In any case these drivers are non-functional anyway without OOT
> > board code. If we rip out the main platform data completely, the logical following
> > question arises: why do we need the per-device platform data? If we rip that out,
> > we basically make non-functional driver a 100% dead code. Hence what you propose
> > mostly equals to ripping out the drivers completely.
> > 
> > TL;DR: with the main platform data being ripped out the driver code will be in
> > inconsistent state.
> 
> What do you think Johan?  Do you see any reason to keep it around?

Yeah, I'd prefer to keep it around. This device is used in a bunch of
Sony phones and Bjorn A posted a series adding devicetree bindings a few
years ago which I believe was more or less acked and ready go.

I'll try to find some time to look at that myself as I think I may
favour a less verbose binding (e.g. similar to pm8008 that I'm working
on).

For now I suggest keeping the platform data where it is and just convert
the single gpio lookup to look for a "hwen" gpio that can be provided by
lookup tables and soon devicetree.

Johan

