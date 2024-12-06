Return-Path: <linux-kernel+bounces-434522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8DB9E67C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34711614C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28F1DC1AB;
	Fri,  6 Dec 2024 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gduKLat0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A48190470;
	Fri,  6 Dec 2024 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469632; cv=none; b=OIlK59LIiJ0w4WlGy/IyJGOOrwXqQ/cC19aloLORd9hWhk6gApFCZTZnBz9iKcyF+8Rknd1sX+OGPHxrR6sK2lpiejEki8GjgAYDvcPuSv3dTkdGXSETO5AHfZsDfR/VkQXw01h2VzMiNC0tYkecId6te7ogmA4LlTImq9yCGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469632; c=relaxed/simple;
	bh=BVLWGyxipdRT/hSaL5F5xCJkw6a7KQHUvjZl/NxfNkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze04bFqx/MvRse68y7f1Oo26+QCzCq1dCG1eNT/HDVCSi1IeHBVg0QW5JsHtXN6BCO/6QAINjy4FSYzoByATcJBmE+yQffmFTpYabIBKJoGptdvQbC58P5tWZqm8sqImk+F8HdPFcFccvI1glMThCNGr08EGtpGjzxodtL5kxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gduKLat0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7321DC4CED1;
	Fri,  6 Dec 2024 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733469631;
	bh=BVLWGyxipdRT/hSaL5F5xCJkw6a7KQHUvjZl/NxfNkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gduKLat01OauAOK0JiJXo+zzQ8Yy+Rj6f0c04uoDeneVE/Q2mzNwpMES8VD5w+K2+
	 TmuRS3HAaH1ldg4hqsqmoMnns9YE0w/Cxxgw1F1iRkcZT0/yk2AiCqbuGSZ5pvFPGU
	 4BeQ8ouPWnujOPAUO2OTV1yAVrW8XNKigmhHDfMuXB4+fwKsQkfIMqqOwMmOzFnsk7
	 tcCKn3ifjOmNH37JL3wxUJiQkQ9wsbOzRCqNY1gYwrV5Gyqw6cDFW5/XM1H/u7L1gp
	 22dI+pmw6bFT+KbxeVll6ChgaRdygYQ5AbObymDKww75b0GVpIGeD2qaAlo9m9NKCf
	 x3u5hJVSqe/rw==
Date: Fri, 6 Dec 2024 07:20:25 +0000
From: Lee Jones <lee@kernel.org>
To: Fiona Behrens <me@kloenk.dev>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <20241206072025.GF8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
 <F599F062-5519-4DC4-8303-7630BE0B900A@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F599F062-5519-4DC4-8303-7630BE0B900A@kloenk.dev>

On Thu, 05 Dec 2024, Fiona Behrens wrote:

> 
> 
> On 5 Dec 2024, at 17:25, Lee Jones wrote:
> 
> > There are situations where a pointer to a `struct device` will become
> > necessary (e.g. for calling into dev_*() functions).  This accessor
> > allows callers to pull this out from the `struct miscdevice`.
> >
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  rust/kernel/miscdevice.rs | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index 7e2a79b3ae26..55340f316006 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -10,11 +10,13 @@
> >
> >  use crate::{
> >      bindings,
> > +    device::Device,
> >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> >      prelude::*,
> >      str::CStr,
> >      types::{ForeignOwnable, Opaque},
> >  };
> > +
> >  use core::{
> >      ffi::{c_int, c_long, c_uint, c_ulong},
> >      marker::PhantomData,
> > @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
> >      pub fn as_raw(&self) -> *mut bindings::miscdevice {
> >          self.inner.get()
> >      }
> > +
> > +    /// Returns a pointer to the current Device
> 
> I would not call this pointer but rather reference? Pointer is usually associated with *mut or *const, and this is a reference to the Device abstraction

No, no, my Rustacean friend.  That's not the point of the comment at
all.  We can all see that it the return value is literally a reference
to Device (&Device), but the thing it's actually passing back is a
`struct device *`:

  % git --no-pager grep -n this_device -- include/
  include/linux/miscdevice.h:85:	struct device *this_device;

I'll change the comment to be a lot more intentional.

-- 
Lee Jones [李琼斯]

