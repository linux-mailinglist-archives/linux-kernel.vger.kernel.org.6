Return-Path: <linux-kernel+bounces-545427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933B3A4ED03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D8E7A866B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB0259CAA;
	Tue,  4 Mar 2025 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTq6rl92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2F16F271;
	Tue,  4 Mar 2025 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115727; cv=none; b=BCyhxqGR1YYKBkNYicE4ctylmoZvep1kEQkkq4FZfeKVUpq1fmbj4vDmhOctKwwRhU4Rw38avgKQ4uv40IKxjB2Myjwki45am+NMqw+q9X27f54B5azhbMEDZGSacU0chYkHLkJ/XoyM/c1VZ/QIj4iGi/48FyTTgfsMY64QOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115727; c=relaxed/simple;
	bh=NJ3TQZFfV3q3elNa2NxItYJQTy6CMZkFNGwhlIZAytw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp47s9OdcQqvRVmDROWNsEl17OZudnzQzdZR4kZu6rY4fObYRwi/ZfwrEJotB4mG2+7L6ar/U5O4VT1INGQ+Ocr2h61IJi5ATVxHHkgtqD2GgCcGrByQDK5A7eBo6iJYwqQhVrv1MVImGqmApuaiUnLR5xw/oMVpfrHoN0++aZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTq6rl92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E51EC4CEE5;
	Tue,  4 Mar 2025 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741115727;
	bh=NJ3TQZFfV3q3elNa2NxItYJQTy6CMZkFNGwhlIZAytw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTq6rl92QjtF9LyJG1zuHCWL9z0PN3kj3ItWHL+poQ4CKCDTVvQXuMKeV7omAG079
	 A8L0eLtHNrgS21USGn1mmEaLQdRskQobutNrEQkJLt1VnYyGM7XbC0BrHUBdTdFjC0
	 yQUPQxUkWsaECSup+PnDHhRyV2SsB4sRbAU8GqJ7fpoI3ApW13x62Q00dqv9QyHZjX
	 +SZ1cd+h7r1lEih4uMUidp+oChcTYTVwRsa6rGPtv4PzZviy3kVOY1yOSz67CN/wyW
	 rQ0KSaNncpkrMJJsaBzvrm6gUnyM1F7KXHrJWmibu9KoZnIlKaibe5lzTG1Y+hkyIr
	 2oYKxMVUDAsXA==
Date: Tue, 4 Mar 2025 21:15:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	gregkh@linuxfoundation.org, mcgrof@kernel.org,
	russ.weight@linux.dev, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 2/5] rust: firmware: introduce
 `firmware::ModInfoBuilder`
Message-ID: <Z8dRSp13fsvEF9HR@kernel.org>
References: <20250304173555.2496-1-dakr@kernel.org>
 <20250304173555.2496-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304173555.2496-3-dakr@kernel.org>

On Tue, Mar 04, 2025 at 06:34:49PM +0100, Danilo Krummrich wrote:
> The `firmware` field of the `module!` only accepts literal strings,
> which is due to the fact that it is implemented as a proc macro.
> 
> Some drivers require a lot of firmware files (such as nova-core) and
> hence benefit from more flexibility composing firmware path strings.
> 
> The `firmware::ModInfoBuilder` is a helper component to flexibly compose
> firmware path strings for the .modinfo section in const context.
> 
> It is meant to be used in combination with `kernel::module_firmware!`,
> which is introduced in a subsequent patch.

Ditto.

> 
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/firmware.rs | 98 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index c5162fdc95ff..6e6972d94597 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -115,3 +115,101 @@ unsafe impl Send for Firmware {}
>  // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
>  // be used from any thread.
>  unsafe impl Sync for Firmware {}
> +
> +/// Builder for firmware module info.
> +///
> +/// [`ModInfoBuilder`] is a helper component to flexibly compose firmware paths strings for the
> +/// .modinfo section in const context.
> +///
> +/// It is meant to be used in combination with [`kernel::module_firmware!`].
> +///
> +/// For more details and an example, see [`kernel::module_firmware!`].
> +pub struct ModInfoBuilder<const N: usize> {
> +    buf: [u8; N],
> +    n: usize,
> +    module_name: &'static CStr,
> +}
> +
> +impl<const N: usize> ModInfoBuilder<N> {
> +    /// Create an empty builder instance.
> +    pub const fn new(module_name: &'static CStr) -> Self {
> +        Self {
> +            buf: [0; N],
> +            n: 0,
> +            module_name,
> +        }
> +    }
> +
> +    const fn push_internal(mut self, bytes: &[u8]) -> Self {
> +        let mut j = 0;
> +
> +        if N == 0 {
> +            self.n += bytes.len();
> +            return self;
> +        }
> +
> +        while j < bytes.len() {
> +            if self.n < N {
> +                self.buf[self.n] = bytes[j];
> +            }
> +            self.n += 1;
> +            j += 1;
> +        }
> +        self
> +    }
> +
> +    /// Push an additional path component.
> +    ///
> +    /// After a new [`ModInfoBuilder`] instance has been created, [`ModInfoBuilder::prepare`] must
> +    /// be called before adding path components.
> +    pub const fn push(self, s: &str) -> Self {
> +        if N != 0 && self.n == 0 {
> +            crate::build_error!("Must call prepare() before push().");
> +        }
> +
> +        self.push_internal(s.as_bytes())
> +    }
> +
> +    const fn prepare_module_name(self) -> Self {
> +        let mut this = self;
> +        let module_name = this.module_name;
> +
> +        if !this.module_name.is_empty() {
> +            this = this.push_internal(module_name.as_bytes_with_nul());
> +
> +            if N != 0 {
> +                // Re-use the space taken by the NULL terminator and swap it with the '.' separator.
> +                this.buf[this.n - 1] = b'.';
> +            }
> +        }
> +
> +        this.push_internal(b"firmware=")
> +    }
> +
> +    /// Prepare for the next module info entry.
> +    ///
> +    /// Must be called before [`ModInfoBuilder::push`] can be called.
> +    pub const fn prepare(self) -> Self {
> +        self.push_internal(b"\0").prepare_module_name()
> +    }
> +
> +    /// Build the byte array.
> +    pub const fn build(self) -> [u8; N] {
> +        // Add the final NULL terminator.
> +        let this = self.push_internal(b"\0");
> +
> +        if this.n == N {
> +            this.buf
> +        } else {
> +            crate::build_error!("Length mismatch.");
> +        }
> +    }
> +}
> +
> +impl ModInfoBuilder<0> {
> +    /// Return the length of the byte array to build.
> +    pub const fn build_length(self) -> usize {
> +        // Compensate for the NULL terminator added by `build`.
> +        self.n + 1
> +    }
> +}
> -- 
> 2.48.1
> 
> 

BR, Jarkko

