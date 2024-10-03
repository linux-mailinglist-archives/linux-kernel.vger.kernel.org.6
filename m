Return-Path: <linux-kernel+bounces-348768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A47798EBA9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DA91F214B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9EC1422A2;
	Thu,  3 Oct 2024 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YIvrv5C0"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF813CFB8;
	Thu,  3 Oct 2024 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944390; cv=none; b=sKDRfyK5OqCreFJJFb5sklOh12QO1C6DxT1+n7Bhgvw5czPDkYE5UxnsikHFvHYn0rFY4N2kF0nsxI4zK9syey18sqwqwD4w4xWSfN+uFvzvGHWUZ4DJRRO5gjXKWBBJFZLgXM2Qsp39BttxdbIhPDOTHiypNHRqUosUsllh+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944390; c=relaxed/simple;
	bh=652SYa4V4KXZkIP8UL2u5wjzgFH76m9MT8+NpRC/imA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l78RPwGFMvSHHdp7PmMMX1T8L9k/MHbVLQ3w8z69gWegz/dPudW9cSgpki4OJrU905xbFqZbMxuLIKGKMswC5+mIzQ148z2BPKso3eFmDHWf2tXceUdABTwz0FRs9Zc3BkFT2UMTUzCJWOloCOFuGfKbiIaJIF1kna4KYeIVmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YIvrv5C0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53707240005;
	Thu,  3 Oct 2024 08:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727944386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IP7x0XmYXaLX6+Kxu7yEwd0o2euSr6FqYuiV2293dU8=;
	b=YIvrv5C0/wfsTJfOjhnVu+yKBMh3RL+eTvmfa62WnoKfM91BNRVXH0NVjn174R6PKIcdQW
	if3MogjJNtmCy1HFW+EsDPSdNWuaY5U9sBjBmn5tJ9X1y6VPA8RLV4OfnMdvgN0kmx+A/e
	USen8Qbb1uErAv7RMOsVCrFY5HciSmSgUSHUSqpbTl+z1YuSgzjcOp+Ar4Ah2dB+blxUTX
	Y+X7VJg6dcOGHG17VgHmNCJFuYzExyLDC2DVlOEtZFTVUiqS83myLfq3SPov4E57TFfCQ/
	oM4p0F9u2dfviUKEY53cIuwcE4KM3s4Bs3t1DQwuQcOHJ2V+FZX5GSjCFFQZrQ==
Date: Thu, 3 Oct 2024 10:33:03 +0200
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
	Danilo Krummrich <dakr@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [WIP RFC v2 01/35] WIP: rust/drm: Add fourcc bindings
Message-ID: <Zv5Wv4wQTYFN3yyu@louis-chauvet-laptop>
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
	Danilo Krummrich <dakr@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930233257.1189730-2-lyude@redhat.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Hi Lyude,

Le 30/09/24 - 19:09, Lyude Paul a écrit :
> This adds some very basic rust bindings for fourcc. We only have a single
> format code added for the moment, but this is enough to get a driver
> registered.
> 
> TODO:
> * Write up something to automatically generate constants from the fourcc
>   headers
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

[...]

> +#[derive(Copy, Clone)]
> +#[repr(C)]
> +pub struct FormatList<const COUNT: usize> {
> +    list: [u32; COUNT],
> +    _sentinel: u32,
> +}
> +
> +impl<const COUNT: usize> FormatList<COUNT> {
> +    /// Create a new [`FormatList`]
> +    pub const fn new(list: [u32; COUNT]) -> Self {
> +        Self {
> +            list,
> +            _sentinel: 0
> +        }
> +    }

Can you explain what does the sentinel here? I don't think the DRM core
requires this sentinel, and you don't use it in your API.

> +    /// Returns the number of entries in the list, including the sentinel.
> +    ///
> +    /// This is generally only useful for passing [`FormatList`] to C bindings.
> +    pub const fn raw_len(&self) -> usize {
> +        COUNT + 1
> +    }
> +}

I don't think the C side requires to have this extra 0 field. For example
in "C"VKMS there is no such "sentinel" at the end of the list [1]. Do you 
think I need to add one in VKMS?

[1]:https://elixir.bootlin.com/linux/v6.11.1/source/drivers/gpu/drm/vkms/vkms_plane.c#L15

> +impl<const COUNT: usize> Deref for FormatList<COUNT> {
> +    type Target = [u32; COUNT];
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.list
> +    }
> +}
> +
> +impl<const COUNT: usize> DerefMut for FormatList<COUNT> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        &mut self.list
> +    }
> +}
> +
> +#[derive(Copy, Clone)]
> +#[repr(C)]
> +pub struct ModifierList<const COUNT: usize> {
> +    list: [u64; COUNT],
> +    _sentinel: u64
> +}

Same here

[...]

> +impl FormatInfo {
> +    // SAFETY: `ptr` must point to a valid instance of a `bindings::drm_format_info`
> +    pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_format_info) -> &'a Self {
> +        // SAFETY: Our data layout is identical
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// The number of color planes (1 to 3)
> +    pub const fn num_planes(&self) -> u8 {
> +        self.inner.num_planes
> +    }
> +
> +    /// Does the format embed an alpha component?
> +    pub const fn has_alpha(&self) -> bool {
> +        self.inner.has_alpha
> +    }
> +
> +    /// The total number of components (color planes + alpha channel, if there is one)
> +    pub const fn num_components(&self) -> u8 {
> +        self.num_planes() + self.has_alpha() as u8
> +    }

I don't understand this "num_components" and why the alpha channel
is added to the result? For me a component could be "plane count" or
"color channels count", but your function is not returning any of this.

For example in the table [1], BGRA5551 have 4 color components (R, G, B
and A), but only have one plane, so your function will return two, what
does this two means?

[1]:https://elixir.bootlin.com/linux/v6.11.1/source/drivers/gpu/drm/drm_fourcc.c#L147

> +    /// Number of bytes per block (per plane), where blocks are defined as a rectangle of pixels
> +    /// which are stored next to each other in a byte aligned memory region.
> +    pub fn char_per_block(&self) -> &[u8] {
> +        // SAFETY: The union we access here is just for descriptive purposes on the C side, both
> +        // members are identical in data layout
> +        unsafe { &self.inner.__bindgen_anon_1.char_per_block[..self.num_components() as _] }
> +    }
> +}

And here, I think there is an issue, again with BGRA5551 for example, one
plane, with alpha channel, you are returning a slice with two members,
instead of only one.

[...]

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

