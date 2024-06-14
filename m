Return-Path: <linux-kernel+bounces-214615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9FF90871F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC69F1F2382A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5623B1922C2;
	Fri, 14 Jun 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rwppda1a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B75FBB7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356311; cv=none; b=dtGz8aPXtveMe5v0IKJNjTvsQ7/mS5AhP0Ag2Q69Zb/84Doy/2svEIdoiiPJKgnmiLalRNNgGCSumpKlLdtCDdOkK78EsGZgbzJ6I0u0UEWo1GzvHuvD264i4yqUGz5+eZwJb3Qm6XmcgCyUC2UDHrmT3ow8UaWhtwtrkg7rfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356311; c=relaxed/simple;
	bh=PyT3i07hVZXSmRuKgMLGdo4Bxyuj19MmGk+2thL7vGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmNuld6Be9w7jp42XN5Rrc3jvEMr5JJfagRJo1ywiAnnaljHf+aj7/wBGv+cX8UwrCTTmYrrptt66m6RDANTP0bJ1NyneDXdD9dXYmPp4EiaVN3MQbuN0q3EIQ/RZTlhbGpPAGTskiTRPVdcCF7nXeQoWNVyul7fSp+stzIkJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rwppda1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A871FC2BD10;
	Fri, 14 Jun 2024 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718356311;
	bh=PyT3i07hVZXSmRuKgMLGdo4Bxyuj19MmGk+2thL7vGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rwppda1aLZIXLJs35olcYIjwj21f86cZkWa0/kRQDTpATfF0PJe7bRDMEcX6YR2Nw
	 f9cL5q91QzF+mzmHXZzOOXM6athaJGWHjomZTNJ4aHwEESckpwJK+WNQ5C3gX3G6V3
	 IEgvvlGHYVsLuj0MZF+QEIAcweiHuinDi301fQyE=
Date: Fri, 14 Jun 2024 11:11:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Carlos Llamas <cmllamas@google.com>, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Martijn Coenen <maco@android.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Todd Kjos <tkjos@android.com>, LKML <linux-kernel@vger.kernel.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	John Stultz <jstultz@google.com>, Nick Chen <chenjia3@oppo.com>,
	Steven Moreland <smoreland@google.com>,
	Tim Murray <timmurray@google.com>
Subject: Re: [PATCH v5] binder: use bitmap for faster descriptor lookup
Message-ID: <2024061443-breeding-obvious-908d@gregkh>
References: <20240612042535.1556708-1-cmllamas@google.com>
 <7daafcb7-2c80-4c2a-bf25-7202634f79f0@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7daafcb7-2c80-4c2a-bf25-7202634f79f0@web.de>

On Thu, Jun 13, 2024 at 06:50:53PM +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/android/binder.c
> …
> > +static void try_shrink_dmap(struct binder_proc *proc)
> > +{
> …
> > +	binder_proc_lock(proc);
> > +	nbits = dbitmap_shrink_nbits(&proc->dmap);
> > +	binder_proc_unlock(proc);
> …
> > +	new = bitmap_zalloc(nbits, GFP_KERNEL);
> > +	binder_proc_lock(proc);
> > +	dbitmap_shrink(&proc->dmap, new, nbits);
> > +	binder_proc_unlock(proc);
> > +}
> …
> 
> Would you become interested to apply lock guards?
> https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/cleanup.h#L124


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

