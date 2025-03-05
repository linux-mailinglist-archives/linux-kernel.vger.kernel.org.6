Return-Path: <linux-kernel+bounces-547880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C0BA50E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDF218832C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243D320469E;
	Wed,  5 Mar 2025 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ExIVDq+U"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA254A33;
	Wed,  5 Mar 2025 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213846; cv=none; b=HNWhQAaTxnJl6ROx2SC1hFI54ndytizsGFPNY35FufXtlspTzd/Cd/5D3GIkUK6/9eH5UStIWX12qUmIkJ7LLT+yCI8on4iBdtIMtB7UP9VB9pHWZUFCEwv0Az260YRktWyZdhVZIiyykFlUmnJHK0IffUOioWpqVJDgTIPTkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213846; c=relaxed/simple;
	bh=EYN/BSLLtdiTg/f7jeJ6J4AoAO07Udklbww6jnmiAaE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2drmGUulmUO0UdeoJVOBOXjvwASH9gEGwCrOXwIa61qUMgtb2lzcRvIA1nK6WKpCm3phAGz1HErOmL0YxvvALrI3gDQELfnJWWxDnyT9taG7WbN+tXuYDNfazYRm5X+frcDuD2KJCRaLSO26OfasFKTpBUkcdS+A/KYNYiV70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ExIVDq+U; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741213841; x=1741473041;
	bh=oA5VdBYqAl1FD7XLdd6ED5xak0jGnkmx5w36QBysOHU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ExIVDq+Ujn6KsOt67OMC7GxrAMIcWg00nU1tO3l1CRkkMfRDzJfhUvlOnbAFRRdwh
	 QSIFakcquGfaPU+hFA+dg/eqEL5ljlXh9cxSrJd/gz0cypodCjxiFBhoA+FX/Jji5X
	 KH9tXlAO+QzhvYchL/eCAymMTqJgYmpyXsPoMOAW7Gr5cGXq/BOJ6ZHwGC4mHfHXmO
	 BINFIJj8ovd8c3iX/5R20OaEcbzFpvkmE3oMa7zRiD7ziMgat1ysdRpIkc0JjpKlzK
	 O2U8nk7deejkOq6rODO8bJp9A0ftPXefTmSwnB6yDHUxkwVXMCmui6Z3aid/fg9nM2
	 5DLkYeCXLmxGw==
Date: Wed, 05 Mar 2025 22:30:31 +0000
To: Danilo Krummrich <dakr@kernel.org>, airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 2/5] rust: firmware: introduce `firmware::ModInfoBuilder`
Message-ID: <D88OSC9XJXZL.C5HXWFYCG9U6@proton.me>
In-Reply-To: <20250304173555.2496-3-dakr@kernel.org>
References: <20250304173555.2496-1-dakr@kernel.org> <20250304173555.2496-3-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fc5a88e7746fec47f7de82f7668300d12884367f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
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
>  // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, ref=
erences to which are safe to
>  // be used from any thread.
>  unsafe impl Sync for Firmware {}
> +
> +/// Builder for firmware module info.
> +///
> +/// [`ModInfoBuilder`] is a helper component to flexibly compose firmwar=
e paths strings for the
> +/// .modinfo section in const context.
> +///
> +/// It is meant to be used in combination with [`kernel::module_firmware=
!`].
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
> +        let mut j =3D 0;
> +
> +        if N =3D=3D 0 {
> +            self.n +=3D bytes.len();
> +            return self;
> +        }
> +
> +        while j < bytes.len() {
> +            if self.n < N {
> +                self.buf[self.n] =3D bytes[j];
> +            }
> +            self.n +=3D 1;
> +            j +=3D 1;
> +        }
> +        self
> +    }
> +
> +    /// Push an additional path component.
> +    ///
> +    /// After a new [`ModInfoBuilder`] instance has been created, [`ModI=
nfoBuilder::prepare`] must
> +    /// be called before adding path components.
> +    pub const fn push(self, s: &str) -> Self {
> +        if N !=3D 0 && self.n =3D=3D 0 {
> +            crate::build_error!("Must call prepare() before push().");

This will only prevent the first `prepare` call being missed, right?

> +        }
> +
> +        self.push_internal(s.as_bytes())
> +    }
> +
> +    const fn prepare_module_name(self) -> Self {
> +        let mut this =3D self;
> +        let module_name =3D this.module_name;
> +
> +        if !this.module_name.is_empty() {
> +            this =3D this.push_internal(module_name.as_bytes_with_nul())=
;
> +
> +            if N !=3D 0 {
> +                // Re-use the space taken by the NULL terminator and swa=
p it with the '.' separator.
> +                this.buf[this.n - 1] =3D b'.';
> +            }
> +        }
> +
> +        this.push_internal(b"firmware=3D")
> +    }
> +
> +    /// Prepare for the next module info entry.
> +    ///
> +    /// Must be called before [`ModInfoBuilder::push`] can be called.

If you always have to call this before `push`, why not inline it there?

---
Cheers,
Benno

> +    pub const fn prepare(self) -> Self {
> +        self.push_internal(b"\0").prepare_module_name()
> +    }
> +
> +    /// Build the byte array.
> +    pub const fn build(self) -> [u8; N] {
> +        // Add the final NULL terminator.
> +        let this =3D self.push_internal(b"\0");
> +
> +        if this.n =3D=3D N {
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



