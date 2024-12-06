Return-Path: <linux-kernel+bounces-434634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6281E9E6934
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF9E282B27
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B41DF965;
	Fri,  6 Dec 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxmjIKJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE45F1DDA3A;
	Fri,  6 Dec 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474660; cv=none; b=QUi7r67ovYmydX5sX4x0jj5NIeSqtbzW5uBj1Ji1IXD1jBMEMYnxE5F+oBQcmz8F52L+5qR071grpNMzd2DSw6NV7PNcY0OIv0NKoJDyXWHPkpgArk6CiSVkKm5RHbAnP+N2LPZ/vQCW2ST5nSlfiqWv369SzoSezm9e2zCfGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474660; c=relaxed/simple;
	bh=aG0EJjM9rzjXVNynPSfZB0T8D80xTGqYyFnW1Vgewdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoEJ14ztSsmlCxyoGdNwT1wH9c6vU95xocZUqohKfmPniJHumtALTrlRv5AIJpq0/AcChz5dmI0qPXHALQJ4bxqHt0sI0Vxzk9GgcSRkqekG1OtgL7G+fMnFZD0xcXlEGqglDQ7hTY2/Inec3B8PrjtjOlpSQ9YJPnWJ3iKvgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AxmjIKJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34818C4CED1;
	Fri,  6 Dec 2024 08:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733474659;
	bh=aG0EJjM9rzjXVNynPSfZB0T8D80xTGqYyFnW1Vgewdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxmjIKJ6uWbcMezar8UfuQW0nKB2V62WhHFjhM+oha5n83jHXGAXcKxdX16F5g8Sg
	 eOb1y1wNabXfJWoAxf6bbCBwNed2zxmPBHZjycvfVoovc67qYTlWApi4z8uHfFTxjL
	 mWK97gTm4QZ9ii+FYYYogjfFVrBgmG7zL0w2rLCw=
Date: Fri, 6 Dec 2024 09:44:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, arnd@arndb.de,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 0/5] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <2024120615-concert-oven-66f1@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <2024120632-hardwired-hardhead-1906@gregkh>
 <20241206074443.GJ8882@google.com>
 <2024120622-unvalued-wriggle-7942@gregkh>
 <CAH5fLgj6rqVbGHrU4008fvO60fJdRWoE2SvW7nc9njPUFuzJ_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgj6rqVbGHrU4008fvO60fJdRWoE2SvW7nc9njPUFuzJ_A@mail.gmail.com>

On Fri, Dec 06, 2024 at 09:31:28AM +0100, Alice Ryhl wrote:
> On Fri, Dec 6, 2024 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Dec 06, 2024 at 07:44:43AM +0000, Lee Jones wrote:
> > > On Fri, 06 Dec 2024, Greg KH wrote:
> > >
> > > > On Thu, Dec 05, 2024 at 04:25:17PM +0000, Lee Jones wrote:
> > > > > It has been suggested that the driver should use dev_info() instead of
> > > > > pr_info() however there is currently no scaffolding to successfully pull
> > > > > a 'struct device' out from driver data post register().  This is being
> > > > > worked on and we will convert this over in due course.
> > > >
> > > > But the miscdevice.rs change provides this to you, right?  Or if not,
> > > > why not?
> > >
> > > This does allow us to pull the 'struct device *` out from `struct
> > > miscdevice`; however, since this resides in MiscDeviceRegistration,
> > > which we lose access to after .init, we have no means to call it.
> > >
> > > Alice is going to work on a way to use ThisModule to get the
> > > MiscDeviceRegistration reference back from anywhere in the module. Until
> > > that piece lands, we can't call MiscDeviceRegistration::device() outside
> > > of RustMiscDeviceModule.
> >
> > That seems crazy, as ThisModule shouldn't be dealing with a static misc
> > device, what happens for dynamically created ones like all
> > normal/sane/non-example drivers do?  This should "just" be a dynamic
> > object that is NOT tied to the module object, or worst case, a "static"
> > structure that is tied to the module I guess?
> >
> > Anyway, I'll let you all work it out, good luck!
> 
> If you store it somewhere else, you're probably okay. The current
> place is just hard to access.
> 
> The problem is that the Rust module abstractions generate a global
> variable that holds an RustMiscDeviceModule which is initialized in
> init_module() and destroyed in cleanup_module(). To have safe access
> to this global, we need to ensure that you access it only between
> init_module() and cleanup_module(). For loadable modules, the
> try_module_get() logic seems perfect, so in Miscdevice::open we have a
> file pointer, which implies that the fs infrastructure took a refcount
> on fops->owner, which it can only do once init_module() is done.
> 
> Unfortunately, this doesn't translate to built-in modules since the
> owner pointer is just null, and try_module_get performs no checks at
> all.
> 
> Also, I'm realizing now that try_module_get() succeeds even if `state
> == MODULE_STATE_COMING`. :(
> 
> So in conclusion, I don't know of any way to provide safe access to
> the global RustMiscDeviceModule value.

Odd.  How is this any different than what is going to happen for
platform or other drivers of any other type?  Sometimes they want to
only create one single "static" object and register it with the bus they
are assigned to.

Do we need to have a RuscMiscDevice object somewhere instead that
doesn't care about the module logic at all?  And then just use a
"normal" rust module object to create a single instance of that which
the misc binding will handle?

thanks,

greg k-h

