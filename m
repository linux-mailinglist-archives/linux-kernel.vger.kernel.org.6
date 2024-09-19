Return-Path: <linux-kernel+bounces-333551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB14597CAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DB8284531
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D219B59D;
	Thu, 19 Sep 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DHGQ+5Bt"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E36190664
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754639; cv=none; b=FyD29vHZPzuGLPN6zbnUHN+TOXHNISBiwRLSYc0IbHmb3gRUQEgP16ICJLFGJxb5hmBknGSnDBXjv/CiFbfwhWpBpcdsgZQxPwpSudn6noe6bGe83ns0bbxTH3K7w0rq+2ULz4j3ZlI8hr7p1MpfEtymTbuXIj9BbiECKazxbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754639; c=relaxed/simple;
	bh=cmGLd08CsjOKNV4VxVyn6jm5trLijeF6uQOC7KHDSF8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpDOhml3DT94TzfJThTNBjusMZSLLL4oJxnGApej/0gAZIGPrHO4npuitT8ArMvrTNz7qW+xOHeDxM9ahjp9LAOiCWMdyeKzWtZm6e22HuqYhwS9/UkuDdTMG9sWiRBwd3BpGEwhLV1NsthPQeNZuRU7amr3tcumbM6DQzPRnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DHGQ+5Bt; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726754635; x=1727013835;
	bh=jnmHS2qymuDnyC8ztO5a6S72SS+8B0fe54CXhWxCzn0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DHGQ+5BtHIzhIFeFrkl/rwj7V6Kz3E9Xw9GMv7ww509RdJhBQDq2wsklSEl42tCpG
	 fTVHhXzQnq0zo6bT5YlU1+I4dTjRUmmlxybGyVjitCV8bwLm/j9axXOwnIkWLgPdPK
	 GzLrpggWvYJ35LkbcEPZKmfzfC+Bjyw/deHWHVOb28uJDUveFVBFyBSGvo8+eLpa+Z
	 y+wOjcgmCY3j69my1E0MVywf00RBI+oroAgqYGY8yAnofkZIaMFSfpykni4U+LOaTc
	 0v/0zx8YuAE1sX8mKYygHbV20aRLCwz4IFKc7GrGzOBW4pEWfl3iAn9BWHo/XX5uAY
	 FiF0u/X7zerGg==
Date: Thu, 19 Sep 2024 14:03:50 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] rust: sync: add `Arc::as_ptr`
Message-ID: <e7e42ff2-1543-48b3-9bd3-bdef5ce66348@proton.me>
In-Reply-To: <20240917222739.1298275-4-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org> <20240917222739.1298275-4-a.hindborg@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dde87f36e2780ed2bd55c6f5db9b6bd5e2920797
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.09.24 00:27, Andreas Hindborg wrote:
> Add a method to get a pointer to the data contained in an `Arc`.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/sync/arc.rs | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 3673496c2363..a57ea3e2b44c 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -258,6 +258,14 @@ pub fn into_raw(self) -> *const T {
>          unsafe { core::ptr::addr_of!((*ptr).data) }
>      }
>=20
> +    /// Return a raw pointer to the data in this arc.
> +    pub fn as_ptr(&self) -> *const T {

I don't know if we have a convention for this, but shouldn't this be an
associated function? Because if `T` also has an `as_ptr` function, it
will be shadowed by this one.=20

---
Cheers,
Benno

> +        let ptr =3D self.ptr.as_ptr();
> +        // SAFETY: As we derive the pointer from a reference above, the =
pointer
> +        // must be valid.
> +        unsafe { core::ptr::addr_of!((*ptr).data) }
> +    }
> +
>      /// Recreates an [`Arc`] instance previously deconstructed via [`Arc=
::into_raw`].
>      ///
>      /// # Safety
> --
> 2.46.0
>=20
>=20


