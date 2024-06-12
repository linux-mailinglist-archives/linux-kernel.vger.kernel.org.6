Return-Path: <linux-kernel+bounces-212020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA1905A15
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E26D1C224FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466F1822D7;
	Wed, 12 Jun 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sGpOP4OG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6003770D;
	Wed, 12 Jun 2024 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214207; cv=none; b=eDYpT+7iPvhqqJU78+FbAnuXfxStGIlhuzqpXYISkkEpBf4L6jLVB/IteEXLeAWP0tQq1CdHHAXs2Gu3va3YrRg9c0oCZrY0CmX3GzHZaAXUh7RJiz1KIy6Ov6YpjHcQeeLyKmULl1+r3dQqLoPqbL0bPDmixnzmZ1mYpWR8qVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214207; c=relaxed/simple;
	bh=u5T/nSVvfaLT6nbxQudcD8WYR/OAGJmqsMYRFUTyupo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi6VhM2GDrqRQDpMbxbnXS+qqjgkG5dTl5p6qn41Uqh9xesBt14zUw7eAP64EQay6JkuR6ZM7N2uOOLnHZSqnqv0yW5mfC2XfDZIPJX83XwABP3DPHshqYV6IpKUizDTopXYJeWlzjNzRC7+vBTewpjAKRfDYQ3vPeSJbY8wLbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sGpOP4OG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12D4C116B1;
	Wed, 12 Jun 2024 17:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718214207;
	bh=u5T/nSVvfaLT6nbxQudcD8WYR/OAGJmqsMYRFUTyupo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGpOP4OGZo8djUP2T/ixGMUEL5tmHJVmOL5kdXtL2GKHd+QNr9ldjFJZzOw6pMWaG
	 daYYCxLUsxmpjC2VKGovIo0uqZzQSU3CtzJn04cTuc2pFQLnXS40Zrw6HiOxl4TNh3
	 go/ZRNRlK9q/FF+QVP0pN+zc1z2DAQsoPcS+mi78=
Date: Wed, 12 Jun 2024 19:43:24 +0200
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
Message-ID: <2024061234-civic-isolation-824a@gregkh>
References: <ZmdID8AlXtoxUfC1@boqun-archlinux>
 <ZmhPW9yq7y6jbmIg@pollux>
 <2024061136-unbridle-confirm-c653@gregkh>
 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
 <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
 <2024061245-kangaroo-clothes-76e1@gregkh>
 <ZmnAOfCUFkZqhDji@pollux>
 <2024061214-dusk-channel-e124@gregkh>
 <ZmnKXoBYf0qOcPU4@pollux>
 <2024061254-scoured-gallantly-5e41@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061254-scoured-gallantly-5e41@gregkh>

On Wed, Jun 12, 2024 at 07:13:31PM +0200, Greg KH wrote:
> On Wed, Jun 12, 2024 at 06:18:38PM +0200, Danilo Krummrich wrote:
> > On Wed, Jun 12, 2024 at 05:50:42PM +0200, Greg KH wrote:
> > > On Wed, Jun 12, 2024 at 05:35:21PM +0200, Danilo Krummrich wrote:
> > > > On Wed, Jun 12, 2024 at 05:02:52PM +0200, Greg KH wrote:
> > > > > On Wed, Jun 12, 2024 at 04:51:42PM +0200, Danilo Krummrich wrote:
> > > > > > On 6/11/24 18:13, Boqun Feng wrote:
> > > > > > > On Tue, Jun 11, 2024 at 03:29:22PM +0200, Greg KH wrote:
> > > > > > > > On Tue, Jun 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > > > > > > ...hence, I agree we should indeed add to the #Invariants and #Safety section
> > > > > > > > > that `->release` must be callable  from any thread.
> > > > > > > > > 
> > > > > > > > > However, this is just theory, do we actually have cases where `device::release`
> > > > > > > 
> > > > > > > @Danilo, right, it's only theorical, but it's good to call it out since
> > > > > > > it's the requirement for a safe Rust abstraction.
> > > > > > 
> > > > > > Similar to my previous reply, if we want to call this out as safety requirement
> > > > > > in `Device::from_raw`, we probably want to add it to the documentation of the C
> > > > > > `struct device`, such that we can argue that this is an invariant of C's
> > > > > > `struct device`.
> > > > > > 
> > > > > > Otherwise we'd have to write something like:
> > > > > > 
> > > > > > "It must also be ensured that the `->release` function of a `struct device` can
> > > > > > be called from any non-atomic context. While not being officially documented this
> > > > > > is guaranteed by the invariant of `struct device`."
> > > > > 
> > > > > In the 20+ years of the driver model being part of the kernel, I don't
> > > > > think this has come up yet, so maybe you can call the release function
> > > > > in irq context.  I don't know, I was just guessing :)
> > > > 
> > > > Ah, I see. I thought you know and it's defined, but just not documented.
> > > > 
> > > > This means it's simply undefined what we expect to happen when the last
> > > > reference of a device is dropped from atomic context.
> > > > 
> > > > Now, I understand (and would even expect) that practically this has never been
> > > > an issue. You'd need two circumstances, release() actually does something that
> > > > is not allowed in atomic context plus the last device reference is dropped from
> > > > atomic context - rather unlikely.
> > > > 
> > > > > 
> > > > > So let's not go adding constraints that we just do not have please.
> > > > > Same goes for the C code, so the rust code is no different here.
> > > > 
> > > > I agree we shouldn't add random constraints, but for writing safe code we also
> > > > have to rely on defined behavior.
> > > 
> > > As the rust code is relying on C code that could change at any point in
> > > time, how can that ever be "safe"?  :)
> > 
> > That's the same as with any other API. If the logic of an API is changed the
> > users (e.g a Rust abstraction) of the API have to be adjusted.
> 
> Agreed, just like any other in-kernel code, so there shouldn't be
> anything special here.
> 
> > > Sorry, this type of definition annoys me.
> > > 
> > > > I see two options:
> > > > 
> > > > (1) We globally (for struct device) define from which context release() is
> > > >     allowed to be called.
> > > 
> > > If you want, feel free to do that work please.  And then find out how to
> > > enforce it in the driver core.
> > 
> > If we *would* define non-atomic context only, we could enforce it with
> > might_sleep() for instance.
> 
> might_sleep() isn't always correct from what I remember.
> 
> > If we *would* define any context, there is nothing to enforce, but we'd need to
> > validate that no implementer of release() voids that.
> 
> Trying to validate that might be hard, again, I don't think it's worth
> it.
> 
> > The former is a constaint you don't want to add, the latter a lot of work. What
> > if we at least define that implementers of release() must *minimally* make sure
> > that it can be call from any non-atomic context.
> > 
> > That'd be something we can rely on in Rust.
> 
> Determining if you are, or are not, in atomic context is almost
> impossible in C, I don't know how you are going to do that at build time
> in Rust.  Good luck!

Note, the real problem with calling release() on a device, is when you
do so from within the device's sysfs file.  That causes all sorts of
"fun" times that people have had to work around over the years.  It's
not something you probably need to worry about yet, as you are not
writing a bus subsystem in Rust yet, but it is something that can get
tricky very quickly.  Look at the hoops that scsi has to deal with if
you want to see the gory details...

But this is all just "logic" bugs, not thread or irq issues at all.
Nothing is different, nor should be different, for code doing this in C
or in rust.

What I'm trying to get at is that you can't document all of the
"constraints" you are dealing with when handling C apis like this,
sorry.  It's going to be hard, if not impossible, to worry about that at
this point in the api.  It's better left to be documented where the real
call happens (i.e. in the C code), than attempting to keep it up to date
in the c<->rust binding point.

thanks,

greg k-h

