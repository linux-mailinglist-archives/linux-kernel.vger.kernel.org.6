Return-Path: <linux-kernel+bounces-423889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120AB9DADEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72375166031
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1924120127C;
	Wed, 27 Nov 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="kZK6rJCN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70A140E38;
	Wed, 27 Nov 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736182; cv=pass; b=owusdo2lstf2NGKRWoBHWMoTg0rlU1cJ+2mvf3NIvwoEHwDOCgtRJ+19AwmSEvsjz7iL+atjID83Ab8zZ14xdV2BK99Q1rvSymW5RZzWKlGEOLI8wpAtGangr15YnTm3+o1kwrBnV82GoARd0qWg4wbNGb+AObZVJQTfI42muks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736182; c=relaxed/simple;
	bh=NE388iVPpvaBpvGxTNK1Un0mwqG4BlziEkeChtEvX+Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dTmvmypdnl5zFOBEaFInkun95e+DnIYMOrglpUDXyxPC5bE9B+QcEPvZSVnN7Znq8P6ubjpu8qziiOf1/tYz8kKyW8qUoGToGQfMg9FZKFkPoKQ4zksHmK2QtgH3fScDO8CpQ4ckZXrPbsQYviUCOfQxXPhPVMluyLDGEB0+iKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=kZK6rJCN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732736146; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y2r6QH9W7W4HwO1pYW0MPKURYgp7zrT5GxK/aMkSb9k1opBCVSduaQ3Y32Tyn95PSN3E4s8fVVvTnJcGetGqiuHbHAdPCncoRoXpHmtoO0N+iYW7j9J9gYQOZbUIBaZcWtbIctY8Mytw7mrPprRJtTTRamjRV3of/0v0uSig0tI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732736146; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z8d4w5bTmj38SdaBknN0Buc18AmnCZ/rgUCkilbxcZo=; 
	b=MR7rCEiqQOElmGaGAmWDx3vjlXYUfdFYOzOdzLBgWdIMCBgD9hVYIYoV1SrSro3j9TYjOS0SrwuCzNvwqPzX0z6xJpzJNk/b//eBNZ0km8OqsSHovt0V/V5NyVQ6fFv5W8Ifc6OjDT4qzZnNhvLbNp6JEMHJOlyyZMi6nBoy4MY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732736146;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Z8d4w5bTmj38SdaBknN0Buc18AmnCZ/rgUCkilbxcZo=;
	b=kZK6rJCNZr2dnqjM9TSsLF/iWqz3QjYsHEhfAktU9UOPnRNsUqhRSH7qFt7KoPc4
	tJq+OhedNH6UqXtxN6YYu65WUbI2m0yhE2IAQTBlh/tBX6xAhCGe6MC73m1Z37vCkEa
	Rm42k5OEsRIEM3swImwi3wxiRzdtPlPm/r9b+hb8=
Received: by mx.zohomail.com with SMTPS id 1732736144982179.1544890029311;
	Wed, 27 Nov 2024 11:35:44 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 19/35] WIP: rust: drm/kms: Add OpaqueEncoder
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-20-lyude@redhat.com>
Date: Wed, 27 Nov 2024 16:35:30 -0300
Cc: dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Asahi Lina <lina@asahilina.net>,
 Danilo Krummrich <dakr@kernel.org>,
 mcanal@igalia.com,
 airlied@redhat.com,
 zhiw@nvidia.com,
 cjia@nvidia.com,
 jhubbard@nvidia.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8281624-85B3-423E-8451-354F4BC16B97@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-20-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude,

> On 30 Sep 2024, at 20:10, Lyude Paul <lyude@redhat.com> wrote:
>=20
> Same thing as OpaquePlane, but for encoders now.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
>=20
> TODO:
> * Add upcast functions for this
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms/encoder.rs | 55 ++++++++++++++++++++++++++++++++++
> 1 file changed, 55 insertions(+)
>=20
> diff --git a/rust/kernel/drm/kms/encoder.rs =
b/rust/kernel/drm/kms/encoder.rs
> index 3ae597093645e..71fae45d2d651 100644
> --- a/rust/kernel/drm/kms/encoder.rs
> +++ b/rust/kernel/drm/kms/encoder.rs
> @@ -235,6 +235,61 @@ pub fn new<'a, 'b: 'a>(
>     }
> }
>=20
> +/// A [`struct drm_encoder`] without a known [`DriverEncoder`] =
implementation.
> +///
> +/// This is mainly for situations where our bindings can't infer the =
[`DriverEncoder`] implementation
> +/// for a [`struct drm_encoder`] automatically. It is identical to =
[`Encoder`], except that it does not
> +/// provide access to the driver's private data.
> +///
> +/// TODO: Add functions for upcasting.
> +///
> +/// # Invariants
> +///
> +/// Same as [`Encoder`].
> +#[repr(transparent)]
> +pub struct OpaqueEncoder<T: KmsDriver> {
> +    encoder: Opaque<bindings::drm_encoder>,
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: KmsDriver> Sealed for OpaqueEncoder<T> {}
> +
> +// SAFETY: All of our encoder interfaces are thread-safe
> +unsafe impl<T: KmsDriver> Send for OpaqueEncoder<T> {}
> +
> +// SAFETY: All of our encoder interfaces are thread-safe
> +unsafe impl<T: KmsDriver> Sync for OpaqueEncoder<T> {}
> +
> +impl<T: KmsDriver> ModeObject for OpaqueEncoder<T> {
> +    type Driver =3D T;
> +
> +    fn drm_dev(&self) -> &Device<Self::Driver> {
> +        // SAFETY: DRM encoders exist for as long as the device does, =
so this pointer is always
> +        // valid
> +        unsafe { Device::borrow((*self.encoder.get()).dev) }
> +    }
> +
> +    fn raw_mode_obj(&self) -> *mut bindings::drm_mode_object {
> +        // SAFETY: We don't expose Encoder<T> to users before it's =
initialized, so `base` is always
> +        // initialized
> +        unsafe { addr_of_mut!((*self.encoder.get()).base) }
> +    }
> +}
> +
> +// SAFETY: Encoders do not have a refcount
> +unsafe impl<T: KmsDriver> StaticModeObject for OpaqueEncoder<T> {}
> +
> +impl<T: KmsDriver> AsRawEncoder for OpaqueEncoder<T> {
> +    fn as_raw(&self) -> *mut bindings::drm_encoder {
> +        self.encoder.get()
> +    }
> +
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::drm_encoder) -> &'a =
Self {
> +        // SAFETY: Our data layout is identical to =
`bindings::drm_encoder`
> +        unsafe { &*ptr.cast() }
> +    }
> +}
> +
> unsafe extern "C" fn encoder_destroy_callback<T: DriverEncoder>(
>     encoder: *mut bindings::drm_encoder
> ) {
> --=20
> 2.46.1
>=20

No `from_opaque` and `try_from_opaque` like the previous patches?

=E2=80=94 Daniel=

