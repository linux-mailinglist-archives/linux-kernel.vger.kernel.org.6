Return-Path: <linux-kernel+bounces-533539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A591DA45BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E23188ACBA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F126A086;
	Wed, 26 Feb 2025 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OBlShDae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9B25D54D;
	Wed, 26 Feb 2025 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565854; cv=none; b=eKy3OdQPDWiymNqyVlWyvoGGs25Dy7Ca0pIxAqKf8XdeIEzQq6qzZtLyXRDGuUdZ8dX6/0rx6+fHJ3Q7AmgD5Mh/7j/UDvff8hZDSVQTR/H9Z3HD00lerpRdwaTzHwZjuE5hhVeIi1xX/eu7qzOBWQpnmeAZLUotOQsutzNL7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565854; c=relaxed/simple;
	bh=QxxEuuew0/uWLYhyIE8htE/moWOVjyP01tNeUPnqg4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VetGbhscVQl9eY7xtZqt+CHyTiKdS6zavRptQImghgrCUGW4h3ltRTjLup7bCW7PW2qZwmZjeP9wsWfCXjsb8a1JMUYQbkx0liApVqYDS4W4lLWHVTHzlzaApY/4lCxFXI0gne7rD1qefTR2cj8pZzbwE8Nb246VK5Dtdk1RuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OBlShDae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3EAC4CEE2;
	Wed, 26 Feb 2025 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740565853;
	bh=QxxEuuew0/uWLYhyIE8htE/moWOVjyP01tNeUPnqg4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBlShDaeuzYfsYFoeKqXArY/U5DNtOyOl8KfLhgyaTaAp1cEuVCsHT3wQqbOL/lnc
	 0IVkznD5Vw8R4Q3NQpGrF/pWdtk1k5iLy+DmYk/Zn9TDah3pgc04wI7rOQhQ7ZV8v4
	 92bnzTSoZnlHJ8/9aAVB55613ohfAE9oHaO6oqx4=
Date: Wed, 26 Feb 2025 11:01:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to
 Registration::new()
Message-ID: <2025022601-starlit-roamer-1687@gregkh>
References: <20250225213112.872264-1-lyude@redhat.com>
 <20250225213112.872264-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225213112.872264-3-lyude@redhat.com>

On Tue, Feb 25, 2025 at 04:29:01PM -0500, Lyude Paul wrote:
> A little late in the review of the faux device interface, we added the
> ability to specify a parent device when creating new faux devices - but
> this never got ported over to the rust bindings. So, let's add the missing
> argument now so we don't have to convert other users later down the line.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  rust/kernel/faux.rs              | 10 ++++++++--
>  samples/rust/rust_driver_faux.rs |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 41751403cd868..ae99ea3d114ef 100644
> --- a/rust/kernel/faux.rs
> +++ b/rust/kernel/faux.rs
> @@ -23,11 +23,17 @@
>  
>  impl Registration {
>      /// Create and register a new faux device with the given name.
> -    pub fn new(name: &CStr) -> Result<Self> {
> +    pub fn new(name: &CStr, parent: Option<&device::Device>) -> Result<Self> {
>          // SAFETY:
>          // - `name` is copied by this function into its own storage
>          // - `faux_ops` is safe to leave NULL according to the C API
> -        let dev = unsafe { bindings::faux_device_create(name.as_char_ptr(), null_mut(), null()) };
> +        let dev = unsafe {
> +            bindings::faux_device_create(
> +                name.as_char_ptr(),
> +                parent.map_or(null_mut(), |p| p.as_raw()),
> +                null(),

I guess you can add parent can be NULL to the SAFETY line?

Sorry, I thought I would just leave it this way without a parent pointer
until you actually had a user that needed it.  And then we could add the
new parameter and fix up all callers.  No need to add support for it yet
without that, changing apis is easy!  :)

Do you have a real user for this any time soon?

thanks,

greg k-h

