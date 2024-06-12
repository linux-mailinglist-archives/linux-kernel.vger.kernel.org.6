Return-Path: <linux-kernel+bounces-211820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ACB905766
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F101F28420
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A009180A77;
	Wed, 12 Jun 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p8SVCsIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A121EB2A;
	Wed, 12 Jun 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207446; cv=none; b=ilhXNdJBZ1WTN33DFNw2U41N5NuYCmZ88m9FBp3MeRJhpb/9pXGwXGWXAbnjKQ5tetrO85Z0cDyiN0Zhn4GBqYo7w3dVKclrCjDRBl4ScMqXxQM7r4hszxDwKTufTrTj5cmiYdPokp7AlGDMN9BGc2DjY6CJQ4VMi9OKnq2trDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207446; c=relaxed/simple;
	bh=wS+VUO0hoEADLBCnlRkuzmRL7zFIbGqrwwWgMD5w+2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnWNZ0ZUsDSJRmncu4at05U/3iqTIR24PDg0itMd5xjYQoJmJtquqdJP9H6Vu2Nk6U6cMkQtvcI0CATEWMtV/FTc1jH0mk3zPnRpKUxqN2gR+Ojy5hCLdit5e+kZYCgiDlFLuMBuDlLL9pOHI33dV3xeJs7C5QE4esIvvUn9Ndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p8SVCsIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF0CC116B1;
	Wed, 12 Jun 2024 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718207445;
	bh=wS+VUO0hoEADLBCnlRkuzmRL7zFIbGqrwwWgMD5w+2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8SVCsIRVMUwltCtmtQSLzbuSTFqyPkv61ITUPQGMCs403TU+secnBlqSZxoi19AL
	 G1bli+YEM8Qv0bk5rM8Bxc3x77G3MiKFx+wtq0rYc3PKBEV0ZeW2/IqpRjS3kJdLq8
	 qSH4bFWecHYUWQMQeoiujg4t0Cq9yjlG6RxticEg=
Date: Wed, 12 Jun 2024 17:50:42 +0200
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
Message-ID: <2024061214-dusk-channel-e124@gregkh>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-2-dakr@redhat.com>
 <ZmdID8AlXtoxUfC1@boqun-archlinux>
 <ZmhPW9yq7y6jbmIg@pollux>
 <2024061136-unbridle-confirm-c653@gregkh>
 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
 <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
 <2024061245-kangaroo-clothes-76e1@gregkh>
 <ZmnAOfCUFkZqhDji@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmnAOfCUFkZqhDji@pollux>

On Wed, Jun 12, 2024 at 05:35:21PM +0200, Danilo Krummrich wrote:
> On Wed, Jun 12, 2024 at 05:02:52PM +0200, Greg KH wrote:
> > On Wed, Jun 12, 2024 at 04:51:42PM +0200, Danilo Krummrich wrote:
> > > On 6/11/24 18:13, Boqun Feng wrote:
> > > > On Tue, Jun 11, 2024 at 03:29:22PM +0200, Greg KH wrote:
> > > > > On Tue, Jun 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > > > ...hence, I agree we should indeed add to the #Invariants and #Safety section
> > > > > > that `->release` must be callable  from any thread.
> > > > > > 
> > > > > > However, this is just theory, do we actually have cases where `device::release`
> > > > 
> > > > @Danilo, right, it's only theorical, but it's good to call it out since
> > > > it's the requirement for a safe Rust abstraction.
> > > 
> > > Similar to my previous reply, if we want to call this out as safety requirement
> > > in `Device::from_raw`, we probably want to add it to the documentation of the C
> > > `struct device`, such that we can argue that this is an invariant of C's
> > > `struct device`.
> > > 
> > > Otherwise we'd have to write something like:
> > > 
> > > "It must also be ensured that the `->release` function of a `struct device` can
> > > be called from any non-atomic context. While not being officially documented this
> > > is guaranteed by the invariant of `struct device`."
> > 
> > In the 20+ years of the driver model being part of the kernel, I don't
> > think this has come up yet, so maybe you can call the release function
> > in irq context.  I don't know, I was just guessing :)
> 
> Ah, I see. I thought you know and it's defined, but just not documented.
> 
> This means it's simply undefined what we expect to happen when the last
> reference of a device is dropped from atomic context.
> 
> Now, I understand (and would even expect) that practically this has never been
> an issue. You'd need two circumstances, release() actually does something that
> is not allowed in atomic context plus the last device reference is dropped from
> atomic context - rather unlikely.
> 
> > 
> > So let's not go adding constraints that we just do not have please.
> > Same goes for the C code, so the rust code is no different here.
> 
> I agree we shouldn't add random constraints, but for writing safe code we also
> have to rely on defined behavior.

As the rust code is relying on C code that could change at any point in
time, how can that ever be "safe"?  :)

Sorry, this type of definition annoys me.

> I see two options:
> 
> (1) We globally (for struct device) define from which context release() is
>     allowed to be called.

If you want, feel free to do that work please.  And then find out how to
enforce it in the driver core.

> (2) We define it for the Rust abstraction only and just constrain it to
>     non-atomic context to be able to give a safety guarantee. We can't say
>     "might be safe from any context, but we don't know".

Why can't you say that?  Your "saftey" barrier ends/begins at the
interaction with the rust/c layer.  You can't "guarantee" anything on
the C side...

> But again, this is really just a formality, the C code does it all the way and
> practically there never was an issue, which means we actually do follow some
> rules, it's just about writing them down. :)

Again, this has NEVER come up in 20+ years, so maybe it's just not an
issue?  Not to say it isn't, but maybe do some tests and see what
happens...

thanks,

greg k-h

