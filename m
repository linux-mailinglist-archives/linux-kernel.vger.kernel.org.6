Return-Path: <linux-kernel+bounces-547886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D336A50EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A0117032B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E77266B63;
	Wed,  5 Mar 2025 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA/clk9W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35B265618;
	Wed,  5 Mar 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214304; cv=none; b=e1DHxLXn/+TD/zM2ntyjWsqy3AvGq4Xzgmqn3XtV5qLRdTlbq5iktGLshqh96vrukmKYzGVNQRzRldOJkY0G3AFNcrbWRo85ApnHNoiccD28Q6pZk+NwL9DGwuiQ1WtFf89g0lLHjPj6pFNizv9YantVg+z2khBrQW6C6eR+w/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214304; c=relaxed/simple;
	bh=Roi/euyc99FChG5PRFvFXT8ZwL1l4H4tpWXXNhTNGBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkHBZb8B7K2XmVASG9ELwkk+Pu0U9Q+Donfs42oDI0CkdT5t24ezoEohksepFhzZ8Zb6O1p9vEA3lxK3sBblYLNT3xTJ+zuMGucxy58fc1adY8z37JVpxfswo5OQy89/iI6D729d5ANCMTGqdwAy9Po2yuij7DShCqBSk0O69Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA/clk9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C96C4CED1;
	Wed,  5 Mar 2025 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741214303;
	bh=Roi/euyc99FChG5PRFvFXT8ZwL1l4H4tpWXXNhTNGBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kA/clk9WPgtegyDu4qZG4uoAQHpEzBCX0vDP6Fl7+UDdfG9p5puozCMDQ5kFyAGKF
	 NtBCKZIAj/YGDocvp28Xbb8pKpXLMEY1frV6Lz66+WTAzlRm29i5nA6wa2xx76O8gJ
	 PoE+OjQ43lFAvcLD5HisHMw3hvdStEtfZaoXsrnk985rif07HdB1hN6Ij6zxWBYxdW
	 LS4tMczCjF4l9B0nMjmNyxjzHXaHKg5iBFxOjsJdLYSepgdgeicUiTZc1PK/d5gois
	 OfWP6zx6sflntD4RTvwSTJy/IxZiui90MLcw575hCHfP0bCzvBkwOXwzVJitup0w9T
	 7ixe53hqaEpsw==
Date: Wed, 5 Mar 2025 23:38:15 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, russ.weight@linux.dev,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 2/5] rust: firmware: introduce
 `firmware::ModInfoBuilder`
Message-ID: <Z8jSV5CpZDcXrviY@pollux>
References: <20250304173555.2496-1-dakr@kernel.org>
 <20250304173555.2496-3-dakr@kernel.org>
 <D88OSC9XJXZL.C5HXWFYCG9U6@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D88OSC9XJXZL.C5HXWFYCG9U6@proton.me>

On Wed, Mar 05, 2025 at 10:30:31PM +0000, Benno Lossin wrote:
> On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
> > The `firmware` field of the `module!` only accepts literal strings,
> > which is due to the fact that it is implemented as a proc macro.
> >
> > Some drivers require a lot of firmware files (such as nova-core) and
> > hence benefit from more flexibility composing firmware path strings.
> >
> > The `firmware::ModInfoBuilder` is a helper component to flexibly compose
> > firmware path strings for the .modinfo section in const context.
> >
> > It is meant to be used in combination with `kernel::module_firmware!`,
> > which is introduced in a subsequent patch.
> >
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/firmware.rs | 98 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > index c5162fdc95ff..6e6972d94597 100644
> > --- a/rust/kernel/firmware.rs
> > +++ b/rust/kernel/firmware.rs
> > @@ -115,3 +115,101 @@ unsafe impl Send for Firmware {}
> >  // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
> >  // be used from any thread.
> >  unsafe impl Sync for Firmware {}
> > +
> > +/// Builder for firmware module info.
> > +///
> > +/// [`ModInfoBuilder`] is a helper component to flexibly compose firmware paths strings for the
> > +/// .modinfo section in const context.
> > +///
> > +/// It is meant to be used in combination with [`kernel::module_firmware!`].
> > +///
> > +/// For more details and an example, see [`kernel::module_firmware!`].
> > +pub struct ModInfoBuilder<const N: usize> {
> > +    buf: [u8; N],
> > +    n: usize,
> > +    module_name: &'static CStr,
> > +}
> > +
> > +impl<const N: usize> ModInfoBuilder<N> {
> > +    /// Create an empty builder instance.
> > +    pub const fn new(module_name: &'static CStr) -> Self {
> > +        Self {
> > +            buf: [0; N],
> > +            n: 0,
> > +            module_name,
> > +        }
> > +    }
> > +
> > +    const fn push_internal(mut self, bytes: &[u8]) -> Self {
> > +        let mut j = 0;
> > +
> > +        if N == 0 {
> > +            self.n += bytes.len();
> > +            return self;
> > +        }
> > +
> > +        while j < bytes.len() {
> > +            if self.n < N {
> > +                self.buf[self.n] = bytes[j];
> > +            }
> > +            self.n += 1;
> > +            j += 1;
> > +        }
> > +        self
> > +    }
> > +
> > +    /// Push an additional path component.
> > +    ///
> > +    /// After a new [`ModInfoBuilder`] instance has been created, [`ModInfoBuilder::prepare`] must
> > +    /// be called before adding path components.
> > +    pub const fn push(self, s: &str) -> Self {
> > +        if N != 0 && self.n == 0 {
> > +            crate::build_error!("Must call prepare() before push().");
> 
> This will only prevent the first `prepare` call being missed, right?

Correct, unfortunately there's no way to detect subsequent ones.

> 
> > +        }
> > +
> > +        self.push_internal(s.as_bytes())
> > +    }
> > +
> > +    const fn prepare_module_name(self) -> Self {
> > +        let mut this = self;
> > +        let module_name = this.module_name;
> > +
> > +        if !this.module_name.is_empty() {
> > +            this = this.push_internal(module_name.as_bytes_with_nul());
> > +
> > +            if N != 0 {
> > +                // Re-use the space taken by the NULL terminator and swap it with the '.' separator.
> > +                this.buf[this.n - 1] = b'.';
> > +            }
> > +        }
> > +
> > +        this.push_internal(b"firmware=")
> > +    }
> > +
> > +    /// Prepare for the next module info entry.
> > +    ///
> > +    /// Must be called before [`ModInfoBuilder::push`] can be called.
> 
> If you always have to call this before `push`, why not inline it there?

You can push() multiple times to compose the firmware path string (which is the
whole purpose :).

Example from nova-core:

	pub(crate) struct ModInfoBuilder<const N: usize>(firmware::ModInfoBuilder<N>);
	
	impl<const N: usize> ModInfoBuilder<N> {
	    const fn make_entry_file(self, chipset: &str, fw: &str) -> Self {
	        let version = "535.113.01";
	
	        ModInfoBuilder(
	            self.0
	                .prepare()
	                .push("nvidia/")
	                .push(chipset)
	                .push("/gsp/")
	                .push(fw)
	                .push("-")
	                .push(version)
	                .push(".bin"),
	        )
	    }
	
	    const fn make_entry_chipset(self, chipset: &str) -> Self {
	        self.make_entry_file(chipset, "booter_load")
	            .make_entry_file(chipset, "booter_unload")
	            .make_entry_file(chipset, "bootloader")
	            .make_entry_file(chipset, "gsp")
	    }
	
	    pub(crate) const fn create(
	        module_name: &'static kernel::str::CStr,
	    ) -> firmware::ModInfoBuilder<N> {
	        let mut this = Self(firmware::ModInfoBuilder::new(module_name));
	        let mut i = 0;
	
	        while i < gpu::Chipset::NAMES.len() {
	            this = this.make_entry_chipset(gpu::Chipset::NAMES[i]);
	            i += 1;
	        }
	
	        this.0
	    }
	}

