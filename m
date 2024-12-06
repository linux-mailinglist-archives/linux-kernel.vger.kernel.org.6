Return-Path: <linux-kernel+bounces-434651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971419E6968
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4563B28355A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E81E04AC;
	Fri,  6 Dec 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2UuGPlh5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158FB1B4122;
	Fri,  6 Dec 2024 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475335; cv=none; b=pZjgCTcDlDTpr0qE/fIW36HI3ByakIS2pEJJdFKnCiQsXaRiWG6ptfqnCxtGNI3uMnrMjcTyA0sfM/L3PGbjn5uY9RjOqafyGDd9tDI9aMVfbRHJL6SbBMWaszhv8SJsH5YgaN6O2M0l1zDk6Q8UxARbUgWVq1igVtrXdCeFWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475335; c=relaxed/simple;
	bh=L6yN7mD5rKVPN+tUKvRk9yYl6zI+0cfg0Z1YEPW68Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CReMah4i+VtaL37FOSJm1v1sAdvTCZhU/HhvwwWkx/En4qyf1x9waynpVLZdnBRWvwuYZ6SHZ7Xuk6PRRdboRAcW+8WASLE3Lg9Wl+fDO18661jIfE+Q0g2ZoNBzO22rwqXTUELvD1mfGss2ajVl1+RT627Tevv7efGwk7mRfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2UuGPlh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7C2C4CED1;
	Fri,  6 Dec 2024 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733475333;
	bh=L6yN7mD5rKVPN+tUKvRk9yYl6zI+0cfg0Z1YEPW68Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2UuGPlh5lVMkaJBzRw92Ro+VgeHLMjpc0xzpHzY4GGFBtTFgfbdUkTOaATmlUihTx
	 CSKYse/KRWJUv/5C3hYmoZo/SzUU1fdy2iB/huG9QvHhr+oshcYkDrmeTZVkOEFrKw
	 yhUj26SuCe39/PVN4g9mu/lv8jz9WT5OOm/tZGKA=
Date: Fri, 6 Dec 2024 09:55:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, arnd@arndb.de,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 0/5] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <2024120609-stamina-slit-5a84@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <2024120632-hardwired-hardhead-1906@gregkh>
 <20241206074443.GJ8882@google.com>
 <2024120622-unvalued-wriggle-7942@gregkh>
 <CAH5fLgj6rqVbGHrU4008fvO60fJdRWoE2SvW7nc9njPUFuzJ_A@mail.gmail.com>
 <2024120615-concert-oven-66f1@gregkh>
 <CAH5fLgjb9UaFGB0fQn4hO5oWySkNdY0ZJDUaNTgiEBYu6wG5BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjb9UaFGB0fQn4hO5oWySkNdY0ZJDUaNTgiEBYu6wG5BQ@mail.gmail.com>

On Fri, Dec 06, 2024 at 09:51:55AM +0100, Alice Ryhl wrote:
> On Fri, Dec 6, 2024 at 9:44 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Dec 06, 2024 at 09:31:28AM +0100, Alice Ryhl wrote:
> > > On Fri, Dec 6, 2024 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Dec 06, 2024 at 07:44:43AM +0000, Lee Jones wrote:
> > > > > On Fri, 06 Dec 2024, Greg KH wrote:
> > > > >
> > > > > > On Thu, Dec 05, 2024 at 04:25:17PM +0000, Lee Jones wrote:
> > > > > > > It has been suggested that the driver should use dev_info() instead of
> > > > > > > pr_info() however there is currently no scaffolding to successfully pull
> > > > > > > a 'struct device' out from driver data post register().  This is being
> > > > > > > worked on and we will convert this over in due course.
> > > > > >
> > > > > > But the miscdevice.rs change provides this to you, right?  Or if not,
> > > > > > why not?
> > > > >
> > > > > This does allow us to pull the 'struct device *` out from `struct
> > > > > miscdevice`; however, since this resides in MiscDeviceRegistration,
> > > > > which we lose access to after .init, we have no means to call it.
> > > > >
> > > > > Alice is going to work on a way to use ThisModule to get the
> > > > > MiscDeviceRegistration reference back from anywhere in the module. Until
> > > > > that piece lands, we can't call MiscDeviceRegistration::device() outside
> > > > > of RustMiscDeviceModule.
> > > >
> > > > That seems crazy, as ThisModule shouldn't be dealing with a static misc
> > > > device, what happens for dynamically created ones like all
> > > > normal/sane/non-example drivers do?  This should "just" be a dynamic
> > > > object that is NOT tied to the module object, or worst case, a "static"
> > > > structure that is tied to the module I guess?
> > > >
> > > > Anyway, I'll let you all work it out, good luck!
> > >
> > > If you store it somewhere else, you're probably okay. The current
> > > place is just hard to access.
> > >
> > > The problem is that the Rust module abstractions generate a global
> > > variable that holds an RustMiscDeviceModule which is initialized in
> > > init_module() and destroyed in cleanup_module(). To have safe access
> > > to this global, we need to ensure that you access it only between
> > > init_module() and cleanup_module(). For loadable modules, the
> > > try_module_get() logic seems perfect, so in Miscdevice::open we have a
> > > file pointer, which implies that the fs infrastructure took a refcount
> > > on fops->owner, which it can only do once init_module() is done.
> > >
> > > Unfortunately, this doesn't translate to built-in modules since the
> > > owner pointer is just null, and try_module_get performs no checks at
> > > all.
> > >
> > > Also, I'm realizing now that try_module_get() succeeds even if `state
> > > == MODULE_STATE_COMING`. :(
> > >
> > > So in conclusion, I don't know of any way to provide safe access to
> > > the global RustMiscDeviceModule value.
> >
> > Odd.  How is this any different than what is going to happen for
> > platform or other drivers of any other type?  Sometimes they want to
> > only create one single "static" object and register it with the bus they
> > are assigned to.
> >
> > Do we need to have a RuscMiscDevice object somewhere instead that
> > doesn't care about the module logic at all?  And then just use a
> > "normal" rust module object to create a single instance of that which
> > the misc binding will handle?
> 
> Actually, I guess we can access the miscdevice in open via the pointer
> that misc_open() stashes into the file private data. We don't have to
> go through the global variable.

Ah, nice, that's how a "normal" misc device should be doing this, so
yes, that sounds good!

thanks,

greg k-h

