Return-Path: <linux-kernel+bounces-348765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B698EBA0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6781D1F21044
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92C13BAEE;
	Thu,  3 Oct 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MLxD/3E1"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1681742;
	Thu,  3 Oct 2024 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944222; cv=none; b=AlzLH9Rrol8ebpeenvak1m2XU6dUhuhIY3fLLEKMJclWf+x4mxapfSWDjMoL+BqeKdAHM4v/9RJBwz/01bNMo8ARd8i2JmaJu+nqKWlBmCqIiQuAdVLQJ3BiNCsWMWSRI+xB9Rf3lZ7R5VP11eY/fmDHrwjc8c3kOxfL5BQm2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944222; c=relaxed/simple;
	bh=r4ckcudw7AIh1S3P1T4mzMN26Ylp3YQjuwun/cFyf0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J67ATOqkctw+7PYH9m5A2m4FJnpfg2bvcfyersmpscST0eQAPUX93Nmjhl46xTZQ561hV0fGkC8cuV07SgkPs/sejFzLbfxnHtZcvwHLyJxF16FsXRL7FzbTR7OCJ3mZb9tHNQOwxaPt9DhF4R7YXcywRorCcf+nRbTHu6QGb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MLxD/3E1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F6D0E0004;
	Thu,  3 Oct 2024 08:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727944219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iYwVbcXzOAwHNa1Q5dbXWi831DDv+S4RKd+7CqAL57I=;
	b=MLxD/3E13eXYlbGJbaC/H7zWAk2rWd0u4/tdXCF5JFlR4zm3qRI22LGc8UdNLu/xA3wS5/
	OL2YXmGOO+j93JMupyf5BUg3fb6vCY0CDmAscJfOxDLwHtJxSN+0y3izq4v/SelX+L3+Fk
	0QDIOjMNY97FffSglfrdsLBv62vfqVwDrw7SlfO3SFNROI5Mh4M54GySu0glEf2VgItf0O
	zotlUCsNtHB1kS9mYoe0JMEixSfQ1S4NJSr1GOA0czsBEIguYVxOkxbqaVnUs9DVGrpijG
	XkUc3PY3duRwGygsL6bsVGyX8EyHV/2er9g1unUwatuERCVoR8MJ6M+VtSj2xQ==
Date: Thu, 3 Oct 2024 10:30:16 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com, airlied@redhat.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [WIP RFC v2 06/35] rust: drm/kms: Add drm_plane bindings
Message-ID: <Zv5WGMxZHAeRkgZI@louis-chauvet-laptop>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com, airlied@redhat.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-7-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930233257.1189730-7-lyude@redhat.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Hi Lyude

Thank you for all this amazing work!

[...]

> +impl<T: DriverPlane> Plane<T> {
> +    /// Construct a new [`Plane`].
> +    ///
> +    /// A driver may use this from their [`Kms::create_objects`] callback in order to construct new
> +    /// [`Plane`] objects.
> +    ///
> +    /// [`Kms::create_objects`]: kernel::drm::kms::Kms::create_objects
> +    pub fn new<'a, 'b: 'a, const FMT_COUNT: usize, const MOD_COUNT: usize>(
> +        dev: &'a UnregisteredKmsDevice<'a, T::Driver>,
> +        possible_crtcs: u32,
> +        formats: &'static FormatList<FMT_COUNT>,
> +        format_modifiers: Option<&'static ModifierList<MOD_COUNT>>,
> +        type_: PlaneType,
> +        name: Option<&CStr>,
> +        args: T::Args,
> +    ) -> Result<&'b Self> {

Here I have a little comment about this API, I really like the fact that
FormatList and ModifierList have a type fixed length, but I fear it will
be limiting for the drivers. The same apply for the &'static lifetime,
does it really need to be static?

For example, with the introduction of ConfigFS interface in VKMS (I did
not send this part), I need to be able to create a plane with any number 
of formats/modifier dynamically according to the userspace configuration: 
so a dynamically allocated array, which is not 'static and not 
fixed-length.

I think here you can easly remove the &'static requirement as the
format list and format modifiers are copied by drm core [1]. Do you think
it is also feasable to use a slice instead of a custom *List type?

[1]:https://elixir.bootlin.com/linux/v6.11.1/source/drivers/gpu/drm/drm_plane.c#L442


> +        let this: Pin<Box<Self>> = Box::try_pin_init(
> +            try_pin_init!(Self {
> +                plane: Opaque::new(bindings::drm_plane {
> +                    helper_private: &T::OPS.helper_funcs,
> +                    ..Default::default()
> +                }),
> +                inner <- T::new(dev, args),
> +                _p: PhantomPinned
> +            }),
> +            GFP_KERNEL
> +        )?;
> +
> +        // SAFETY: FFI call with no special requirements

I don't know what should be the granularity of safety comments, but I
think drm_universal_plane_init requires some pointers to be valid (at
least dev, this, formats, funcs)

> +        to_result(unsafe {
> +            bindings::drm_universal_plane_init(
> +                dev.as_raw(),
> +                this.as_raw(),
> +                possible_crtcs,
> +                &T::OPS.funcs,
> +                formats.as_ptr(),
> +                formats.raw_len() as _,
> +                format_modifiers.map_or(null(), |f| f.as_ptr()),
> +                type_ as _,
> +                name.map_or(null(), |n| n.as_char_ptr())
> +            )
> +        })?;
> +
> +        // Convert the box into a raw pointer, we'll re-assemble it in plane_destroy_callback()
> +        // SAFETY: We don't move anything
> +        Ok(unsafe { &*Box::into_raw(Pin::into_inner_unchecked(this)) })
> +    }
> +}

[...]

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

