Return-Path: <linux-kernel+bounces-524000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B020A3DDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899FA3AF850
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221A1F9EC0;
	Thu, 20 Feb 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjYvUwcG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DD1D5CFB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063942; cv=none; b=tItisTzOVpSD+wgLF5u4HWdiArPjIDVVIumBsxmx/akQ65yySvlqsYK19zYAJ5cJ6tgi+2DY/u/n9QPKnxxrOdr7A1Ztlhx/qYUWIqGRfmnYpxAVg3oqne8ZcyIu3kW81pjiMessObaLUq/Kv5tZxY+bGpSef7uL6Yp9kkIOMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063942; c=relaxed/simple;
	bh=1OmnHJey756nPxtDi6zG0cDjHDyotZZNc7pVj5Wdbig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT3wjjdow8QwqULh0wGNzCJr00RArM8qkQupUas4aSQDotpqNkzzlhO83AYh4k/vQVwQMglamsT/vYmTf3V6W36ZWthEO5FBMnlAdAw6E+Q3kR9m1aoGzc/Sovl18OGt+mjp0zJ56rw4OpAwAIL+5KOpqxxURZDgUbk8zNN4Eas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjYvUwcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70C2C4CED1;
	Thu, 20 Feb 2025 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740063942;
	bh=1OmnHJey756nPxtDi6zG0cDjHDyotZZNc7pVj5Wdbig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjYvUwcGfwY5cNNSqVAEgnlOQV06rbRsvwgEBaZOUni8uFUWxwgPNpVBgDjoc+osN
	 w59+Jjwg4c1AUCkQ5+/InPSwqMtGUCSEGWqBaGUFYY2gK0W/jdimkSHN37odJhdlKA
	 jhwNFK01vJoKbVQWTKX4Ba/6ShvVUCUMWCN2cry4=
Date: Thu, 20 Feb 2025 16:05:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>,
	Vimal Agrawal <vimal.agrawal@sophos.com>, kernel-dev@igalia.com
Subject: Re: [PATCH 3/4] char: misc: restrict the dynamic range to exclude
 reserved minors
Message-ID: <2025022010-next-engaging-5467@gregkh>
References: <20250123123249.4081674-1-cascardo@igalia.com>
 <20250123123249.4081674-4-cascardo@igalia.com>
 <2025022007-rudder-refocus-5d45@gregkh>
 <Z7dBr2WJGH-XDL6d@quatroqueijos>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dBr2WJGH-XDL6d@quatroqueijos>

On Thu, Feb 20, 2025 at 11:52:31AM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Thu, Feb 20, 2025 at 03:31:11PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Jan 23, 2025 at 09:32:48AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > When this was first reported [1], the possibility of having sufficient
> > > number of dynamic misc devices was theoretical.
> > > 
> > > What we know from commit ab760791c0cf ("char: misc: Increase the maximum
> > > number of dynamic misc devices to 1048448"), is that the miscdevice
> > > interface has been used for allocating more than the single-shot devices it
> > > was designed for.
> > 
> > Do we have any in-kernel drivers that abuse it this way?  If so, let's
> > fix them up.
> > 
> 
> >From the discussion 15 years ago, though found only by code inspection, dlm
> was theoretically capable of creating such multiple devices. But, in
> practice, its user space never did create more than one. 
> 
> But from commit ab760791c0cf ("char: misc: Increase the maximum number of
> dynamic misc devices to 1048448") description, we know at least
> coresight_tmc is abusing it like that.

Ick.

> I can work on fixing coresight_tmc and any other abusers, but they will
> require their own class (though I thought about making it possible to
> create compatibility symlinks under /sys/class/misc/). So, this should take
> a bit longer. In the meantime, I think we shold apply something like this
> patch for v6.15 and even consider it for stable.

No such need for compatibility symlinks, devices should be able to be
found in the correct location no matter where they are in the system,
right?

But yes, a class is needed, thanks!

> > > On such systems, it is certain that the dynamic allocation will allocate
> > > certain reserved minor numbers, leading to failures when a later driver
> > > tries to claim its reserved number.
> > > 
> > > Fixing this is a simple matter of defining the IDA range to allocate from
> > > to exclude minors up to and including 15.
> > > 
> > > [1] https://lore.kernel.org/all/1257813017-28598-3-git-send-email-cascardo@holoscopio.com/
> > > 
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > > ---
> > >  drivers/char/misc.c        | 4 +++-
> > >  include/linux/miscdevice.h | 1 +
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> > > index 2cf595d2e10b..7a768775e558 100644
> > > --- a/drivers/char/misc.c
> > > +++ b/drivers/char/misc.c
> > > @@ -68,8 +68,10 @@ static int misc_minor_alloc(int minor)
> > >  	int ret = 0;
> > >  
> > >  	if (minor == MISC_DYNAMIC_MINOR) {
> > > +		int max = DYNAMIC_MINORS - 1 - MISC_STATIC_MAX_MINOR - 1;
> > >  		/* allocate free id */
> > > -		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
> > > +		/* Minors from 0 to 15 are reserved. */
> > > +		ret = ida_alloc_max(&misc_minors_ida, max, GFP_KERNEL);
> > >  		if (ret >= 0) {
> > >  			ret = DYNAMIC_MINORS - ret - 1;
> > >  		} else {
> > > diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> > > index 69e110c2b86a..911a294d17b5 100644
> > > --- a/include/linux/miscdevice.h
> > > +++ b/include/linux/miscdevice.h
> > > @@ -21,6 +21,7 @@
> > >  #define APOLLO_MOUSE_MINOR	7	/* unused */
> > >  #define PC110PAD_MINOR		9	/* unused */
> > >  /*#define ADB_MOUSE_MINOR	10	FIXME OBSOLETE */
> > > +#define MISC_STATIC_MAX_MINOR	15	/* Top of first reserved range */
> > 
> > I don't understand, why is 15 the magic number here?  All of those
> > "unused" values can just be removed, all systems should be using dynamic
> > /dev/ now for many many years, and even if they aren't, these minors
> > aren't being used by anyone else as the in-kernel users are long gone.
> > 
> > So why are we reserving this range if no one needs it?
> 
> Because those were reserved historically. They are still documented under
> Documentation/admin-guide/devices.txt. What do we gain by not reserving
> those? Since we moved past 255 for dynamic allocation, we are not going to
> miss those 15 minors.

True, but it turns out we don't need to reserve them anymore, so let's
not.

> One alternative is that we just disregard the 0-255 range entirely for
> dynamic allocation, which should also simplify the code a lot. If that
> would be preferable, I can work on that and submit it soon.

I'm all for that, that might just make things much simpler, as a dynamic
number shouldn't care what it's set at, right?  Try it and see?

thanks,

greg k-h

