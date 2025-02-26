Return-Path: <linux-kernel+bounces-533556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B83A45C06
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55571889CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E914224DFED;
	Wed, 26 Feb 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiWnfKXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B64642D;
	Wed, 26 Feb 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566378; cv=none; b=hzz9tSe3xEA0q0EL8VQqWgyZM8r5x5HAATcPUps09VY3EvgJhZVqLBeXLseJIdO7U+4oQavNwtns3C09IiUxhwg6NC5AHPqq9qAq96clSB3bUza8YMucUJvkzOdLCGRl4jriF8eGR2+wtqj3XkiMbLurkjlOwouSnDgnAk2Rzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566378; c=relaxed/simple;
	bh=z+ACc9/vEmMyxvrB3zAJly+TnJcjuVrM2NtlojVPahc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFqegw9qu9L/N8SR9PxMkoYcgsQX4UuM/lilcDNlcaJ8QTEHHVFGCmNARLdgyyEgYkGQLxfB+goemz80C8FLBx8GDOiLOueC6mepMghsdMPhm9ftGUzuAxZPLvp+xZsF0Ooo7tjBQ06eQHDbKW7d80QXijBK/9XXbK7o27LFMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiWnfKXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B92C4CED6;
	Wed, 26 Feb 2025 10:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740566377;
	bh=z+ACc9/vEmMyxvrB3zAJly+TnJcjuVrM2NtlojVPahc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BiWnfKXAgC/TYQa9VF3IfGq1FIaDa8/lsitIellUfrpvLbrymFLgoQvv7udZM89xr
	 QNIk0whBQhCSjJ3D6q+OS+yO/UgMzGXeyaLTC75w0+WcYPE4T9D7jbHQbK7Ov4zJZU
	 velRFQWDb7lx5Wz3TQrNXetlemsGPNBByNLpyvdarH4yout5zvVwEnYMzuNSlJqOMW
	 MQ1WKg5RZnx8KWnlY+OOnkJ36Yj2DSfVYbMSRlBDZDozzrGSPInIQeo0OU3r5odrDb
	 RIWTbZBGNvVLncJy11IdhwsJayvC4BX56qvQl67D4QHp9uN6h9UwKkRWE8jtPL1icW
	 6r2YJU/EMsFng==
Date: Wed, 26 Feb 2025 11:39:31 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>, kernel@dakr.org,
	a.hindborg@kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, gary@garyguo.net,
	linux-kernel@vger.kernel.org, lyude@redhat.com,
	mairacanal@riseup.net, ojeda@kernel.org, rafael@kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to
 Registration::new()
Message-ID: <Z77vYxUYVyFtW2lG@cassiopeiae>
References: <ea2466c4d250ff953b3be9602a3671fb@dakr.org>
 <20250226092339.989767-1-aliceryhl@google.com>
 <Z77iHj56551mDybd@pollux>
 <2025022659-spray-treble-759f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025022659-spray-treble-759f@gregkh>

On Wed, Feb 26, 2025 at 10:58:17AM +0100, Greg KH wrote:
> On Wed, Feb 26, 2025 at 10:42:54AM +0100, Danilo Krummrich wrote:
> > On Wed, Feb 26, 2025 at 09:23:39AM +0000, Alice Ryhl wrote:
> > > On Wed, Feb 26, 2025 at 10:06 AM <kernel@dakr.org> wrote:
> > > >
> > > > On 2025-02-26 09:38, Alice Ryhl wrote:
> > > > > On Tue, Feb 25, 2025 at 10:31 PM Lyude Paul <lyude@redhat.com> wrote:
> > > > >>
> > > > >> A little late in the review of the faux device interface, we added the
> > > > >> ability to specify a parent device when creating new faux devices -
> > > > >> but
> > > > >> this never got ported over to the rust bindings. So, let's add the
> > > > >> missing
> > > > >> argument now so we don't have to convert other users later down the
> > > > >> line.
> > > > >>
> > > > >> Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >> ---
> > > > >>  rust/kernel/faux.rs              | 10 ++++++++--
> > > > >>  samples/rust/rust_driver_faux.rs |  2 +-
> > > > >>  2 files changed, 9 insertions(+), 3 deletions(-)
> > > > >>
> > > > >> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> > > > >> index 41751403cd868..ae99ea3d114ef 100644
> > > > >> --- a/rust/kernel/faux.rs
> > > > >> +++ b/rust/kernel/faux.rs
> > > > >> @@ -23,11 +23,17 @@
> > > > >>
> > > > >>  impl Registration {
> > > > >>      /// Create and register a new faux device with the given name.
> > > > >> -    pub fn new(name: &CStr) -> Result<Self> {
> > > > >> +    pub fn new(name: &CStr, parent: Option<&device::Device>) ->
> > > > >> Result<Self> {
> > > > >>          // SAFETY:
> > > > >>          // - `name` is copied by this function into its own storage
> > > > >>          // - `faux_ops` is safe to leave NULL according to the C API
> > > > >> -        let dev = unsafe {
> > > > >> bindings::faux_device_create(name.as_char_ptr(), null_mut(), null())
> > > > >> };
> > > > >> +        let dev = unsafe {
> > > > >> +            bindings::faux_device_create(
> > > > >> +                name.as_char_ptr(),
> > > > >> +                parent.map_or(null_mut(), |p| p.as_raw()),
> > > > >> +                null(),
> > > > >
> > > > > This function signature only requires that `parent` is valid for the
> > > > > duration of this call to `new`, but `faux_device_create` stashes a
> > > > > pointer without touching the refcount. How do you ensure that the
> > > > > `parent` pointer does not become dangling?
> > > >
> > > > I was wondering the same, but it seems that the subsequent device_add()
> > > > call takes care of that:
> > > >
> > > > https://elixir.bootlin.com/linux/v6.14-rc3/source/drivers/base/core.c#L3588
> > > >
> > > > device_del() drops the reference.
> > > >
> > > > This makes device->parent only valid for the duration between
> > > > faux_device_create() and faux_device_remove().
> > > >
> > > > But this detail shouldn’t be relevant for this API.
> > > 
> > > I think this could use a few more comments to explain it. E.g.:
> > > 
> > > diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> > > index 531e9d789ee0..674db8863d96 100644
> > > --- a/drivers/base/faux.c
> > > +++ b/drivers/base/faux.c
> > > @@ -131,6 +131,7 @@ struct faux_device *faux_device_create_with_groups(const char *name,
> > >  
> > >         device_initialize(dev);
> > >         dev->release = faux_device_release;
> > > +       /* The refcount of dev->parent is incremented in device_add. */
> > 
> > Yeah, this one is a bit odd to rely on a subsequent device_add() call, it
> > clearly deserves a comment.
> 
> What do you mean?  That's the way the driver model works, a parent
> always gets the reference count incremented as it can not go away until
> all of the children are gone.

That's all correct and I agree. I said it's a bit off because the reference is
not taken in the pointer assignment in faux_device_create_with_groups(), i.e.

	if (parent)
		dev->parent = parent;

but subsequently in device_add(). That doesn't make it obvious to the reader
that the driver core does indeed do the correct thing.

> 
> So if you pass a parent pointer into a "create" function in the driver
> core, it will be incremented, you don't have to worry about it.
> 
> I don't understand the issue with the rust binding here, it's not saving
> a pointer to the parent device, as long as it is valid going in, that's
> all that matters.

There's none, that's what I pointed out earlier too. :-)

> 
> 
> 
> > >         if (parent)
> > >                 dev->parent = parent;
> > >         else
> > > diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> > > index 7673501ebe37..713ee6842e3f 100644
> > > --- a/rust/kernel/faux.rs
> > > +++ b/rust/kernel/faux.rs
> > > @@ -28,6 +28,7 @@ pub fn new(name: &CStr, parent: Option<&device::Device>) -> Result<Self> {
> > >          // SAFETY:
> > >          // - `name` is copied by this function into its own storage
> > >          // - `faux_ops` is safe to leave NULL according to the C API
> > > +        // - `faux_device_create` ensures that `parent` stays alive until `faux_device_destroy`.
> > 
> > Not sure that's a safety requirement for faux_device_create().
> 
> It's by default what the driver model does for you.
> 
> > The typical convention is that a caller must hold a reference to the object
> > behind the pointer when passing it to another function. If the callee decides
> > to store the pointer elsewhere, it's on the callee to take an additional
> > reference.
> 
> Exactly, the driver core handles this.

Agreed.

> 
> > I think if we want to add something to the safety comment, it should be somthing
> > along the line of "the type of `parent` implies that for the duration of this
> > call `parent` is a valid device with a non-zero reference count".
> 
> I don't understand the need for any safety comment about the parent
> here.  Again, as long as it is valid when the call is made, that is all
> that is needed.

Right, and we could mention that in the safety comment that something of the
type `&device::Device` is indeed valid by definition and hence fullfills the
requirement of faux_device_create() to get a valid pointer (or NULL).

