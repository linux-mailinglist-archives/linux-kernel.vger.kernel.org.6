Return-Path: <linux-kernel+bounces-212583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA73890639A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB0F1C22821
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F376A13698E;
	Thu, 13 Jun 2024 05:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wZDluJb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680E633;
	Thu, 13 Jun 2024 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257636; cv=none; b=ULlI52DEzI0OwmM6ep7y+F999YtRbRG/VKRRhiULXzwlu5RqTDgFv9qu2BiUOTJ/UrdLN1/YslVzf4USBbs+dyNrh6KpA91UF5rcXIvG+NfkA1eVGAehU2Gp/fy+IaqG0M2GM2Sbif4TrZRTlOAB7+UEtrLnXJXgBPuzmcmwni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257636; c=relaxed/simple;
	bh=ZvzEKX38KuTN62FCUwMKyDyA6aaaOsrl7XhjidVCGv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSvjjuO3M3t2HUTIXODecQA3Ydg/bmOVU2zDF7QpoENH6a2SEHFro7001LL3wSiP5C1lkjG2Pa9L3mn+gCWpBNewzmmOyBzCVRqWZhG7g59/O6gcTjFIHWlvg+okApqE9yeBf2oQD2alzfjZgaDQFmx+7+UfpOkU4VZ1aC6tvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wZDluJb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F62C2BBFC;
	Thu, 13 Jun 2024 05:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718257635;
	bh=ZvzEKX38KuTN62FCUwMKyDyA6aaaOsrl7XhjidVCGv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wZDluJb+Mibo/rfV4e7GHGS6xYZ+yn1WxY9MpAjpKbPJJ0THVZou8jRqQoIV8UB87
	 jJZhd9plasPLRUX0u8SvmhK8BskodjUwp77V+PjismJrrkC57GCo3io0ckyyku5W/j
	 9NyAwNIZ+PqiBk8Ajw+Q4DZnEB3OHo7DEz7slu/w=
Date: Thu, 13 Jun 2024 07:47:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, rafael@kernel.org, mcgrof@kernel.org,
	russell.h.weight@intel.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add abstraction for struct device
Message-ID: <2024061345-troubling-visiting-830a@gregkh>
References: <ZmhPW9yq7y6jbmIg@pollux>
 <2024061136-unbridle-confirm-c653@gregkh>
 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
 <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
 <2024061245-kangaroo-clothes-76e1@gregkh>
 <ZmnAOfCUFkZqhDji@pollux>
 <2024061214-dusk-channel-e124@gregkh>
 <ZmnKXoBYf0qOcPU4@pollux>
 <2024061254-scoured-gallantly-5e41@gregkh>
 <ZmoLi57aT4EB_97W@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmoLi57aT4EB_97W@pollux>

On Wed, Jun 12, 2024 at 10:56:43PM +0200, Danilo Krummrich wrote:
> > > Oh, I fully agree with that. Let me try to explain a bit what this is about:
> > > 
> > > In Rust we have the `Send` and `Sync` marker traits. If a type (e.g. `Device`)
> > > implements `Send` it means that it's safe to pass an instance of this type
> > > between threads. Which is clearly something we want to do with a `Device`.
> > > 
> > > If I don't implement `Sync` for `Device` the compiler will prevent me from
> > > sending it between threads, e.g. by disallowing me to put an instance of
> > > `Device` into another data structure that is potentially passed between threads.
> > > 
> > > If I implement `Sync` I have to add a safety comment on why it is safe to pass
> > > `Device` between threads. And here we have what Boqun pointed out: `Device` can
> > > only be passed between threads when we're allowed to drop the last reference
> > > from any thread. In the case of the kernel this can be any non-atomic context,
> > > any context or any other subset. But I have to write something here that is
> > > a defined rule and can be relied on.
> > 
> > You really have two things here, a matrix of:
> > 	can transfer between threads
> > 	can call in irq context
> > that are independent and not related to each other at all.
> > 
> > Looks like Rust has built in support for the first.  And nothing for the
> > second as that is a very kernel-specific thing.
> 
> The language documentation defines `Send` as "can be transferred between
> threads", likely because it's written from a userspace perspective. But in
> the kernel context it actually means can be transferred between any context,
> thread, IRQ, etc.
> 
> If this isn't true, then we have to add a comment what is allowed (e.g. any
> non-atomic context) and what's not allowed.

That isn't good, you are going to have to change how `Send` works here
if you think it's safe to do stuff in all of those different contexts,
as that is almost never going to be true.

Why not just stick with "accessed from another thread" and leave it at
that, as again, the combinations here are a matrix, not a boolean yes/no
type of thing.

> > So let's not confuse the two please.  `Send` and `Sync` should be fine
> > for a device pointer to be passed around, as long as the reference is
> > incremented, as that's what all of the kernel C code does today.  Let's
> > not worry about irq context at all, that's independent and can be
> > handled at a later time, if at all, with a different "marking" as it's
> > independent of the current two things.
> 
> That'd be great, but as mentioned above, we only have `Send`, but nothing like
> `SendIrq`, hence `Send` really means any context.
> 
> Given your proposal, to just say it's fine to pass between (actual) threads and
> ignore IRQ context for now, we have to implement `Send`, but document that IRQ
> context is not covered.
> 
> We can either do that in the Rust abstraction as safety requirement, or we can,
> as proposed previously, add a comment to the C `struct device` documentation
> that implementers of release() must *at least* make sure that it can be called
> from any non-atomic context. We can then refer to that.

As someone who has written comments in code for functions that are
always ignored, I am happy to see you think that this is actually going
to do anything :)

Heck, I have put huge messages in kernel code for when people implement
the api wrong[1], and they still ignore that at runtime.  Only way to get
it noticed is if you break someone's build.

So you all need to really define what `Send` means, as it sounds like a
userspace thing that isn't going to fit in well within the kernel model.

thanks,

greg k-h

[1] See the pr_debug() calls in kobject_cleanup() as proof, people just
    create an "empty" release function to shut them up, thinking that is
    the correct solution when obviously it is not...

