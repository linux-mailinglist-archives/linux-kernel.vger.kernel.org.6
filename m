Return-Path: <linux-kernel+bounces-424763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B459DB912
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAAB1632B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221831A9B59;
	Thu, 28 Nov 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aeczCsZ0"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55901E4B2;
	Thu, 28 Nov 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801929; cv=pass; b=R844XoDmwsB6eMHkbUo1yTRs9L4OCgO97fMci44n4daBdkaA069NhGEv7PTBfR2jrJl+FLgIr5h8/aQn8zPd/9cvSfzhp+XXj+nhU9U6nt8kTXa2eg0eBU4H1t4mxZXkFcPwG3EdYL6XRE2ha03Qrmgjl4A+zaRerY2Bx939JVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801929; c=relaxed/simple;
	bh=SAtxWeO3fSRqwvzuCcfyG/WTTo9zbAMfhatYkQs6f1s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LpW5sfEP2sqMP6R4OpHPpS0HOlGyOM2vppT3sfysO6L5r8KS8I1+IYRhit41TmZMIWNsKmf7hHHMgn6Fhts2Q8YIi8IsaQZkDYlbBmPzEnhx7QmBf20/qc7+t9pcB7aF1RcanNMWffTKxz2TVObYxCxSy640zDbJjwzDUMtCENo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aeczCsZ0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732801898; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZZ3MbdT06hAw7ytVGKhzzx2dNQIBazQWGb9YK9B5zYDCNdALfLSfQ49uHg9w1hl4Zuonv0R517wmIHdl6hhvUmiFbnmpoKzQD5/2cCevm/1ykSRyDiKwPInHP41hQTY5vwh2Ycraf7/KN+2dqWWD6/FX0+l28i5+ZfkvzEPALgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732801898; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EgcRrpiem1ZrG7RBPW7iZiifVvSFATA7CY1pGps5r8Q=; 
	b=kAuFHmbjmLZ4WUp347c8mW248UTRYj3MAuk95CUqkgW2ezZhtWZnyxTWJJbTs3XmkIHpk6CLOGDLa09JaKXb+wID7EgQ9prJFXlaZVyylosd4Jt1HnFA/SbNEZoU72OFNQMZlk9mSVBFYY0eZuXsoEmaYTITEKk8hxQxr4ILxA8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732801898;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=EgcRrpiem1ZrG7RBPW7iZiifVvSFATA7CY1pGps5r8Q=;
	b=aeczCsZ0P+ubCYvGuK//URh9+tLN1FHYNUCA+2eYJ0ATGU5+hIP7LMmk2rskdQ6u
	ZEb21MpP961OEXsBxGrGP/okpgfloo2DAbJMxJhs4L8DhK7nJApl0pH0aZkcYz1Lcra
	vJ1bGZJry7bOt1viufYeIykC1UdU5noOt9U+3fSo=
Received: by mx.zohomail.com with SMTPS id 1732801897483651.5340119757609;
	Thu, 28 Nov 2024 05:51:37 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 22/35] rust: drm/kms: Add
 DriverPlane::atomic_update()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-23-lyude@redhat.com>
Date: Thu, 28 Nov 2024 10:51:22 -0300
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
Message-Id: <E4022636-D8A6-4B03-8EF0-E9E3177E760A@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-23-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External



> On 30 Sep 2024, at 20:10, Lyude Paul <lyude@redhat.com> wrote:
>=20
> A mandatory trait method used for implementing DRM's atomic plane =
update
> callback.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms/plane.rs | 39 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/drm/kms/plane.rs =
b/rust/kernel/drm/kms/plane.rs
> index d6e11a65cc101..506ed5ced1270 100644
> --- a/rust/kernel/drm/kms/plane.rs
> +++ b/rust/kernel/drm/kms/plane.rs
> @@ -75,7 +75,7 @@ pub trait DriverPlane: Send + Sync + Sized {
>             begin_fb_access: None, // TODO: someday?
>             end_fb_access: None, // TODO: someday?
>             atomic_check: None,
> -            atomic_update: None,
> +            atomic_update: if Self::HAS_ATOMIC_UPDATE { =
Some(atomic_update_callback::<Self>) } else { None },
>             atomic_enable: None, // TODO
>             atomic_disable: None, // TODO
>             atomic_async_check: None, // TODO
> @@ -103,6 +103,21 @@ pub trait DriverPlane: Send + Sync + Sized {
>     ///
>     /// Drivers may use this to instantiate their [`DriverPlane`] =
object.
>     fn new(device: &Device<Self::Driver>, args: Self::Args) -> impl =
PinInit<Self, Error>;
> +
> +    /// The optional [`drm_plane_helper_funcs.atomic_update`] hook =
for this plane.
> +    ///
> +    /// Drivers may use this to customize the atomic update phase of =
their [`Plane`] objects. If not
> +    /// specified, this function is a no-op.
> +    ///
> +    /// [`drm_plane_helper_funcs.atomic_update`]: =
srctree/include/drm/drm_modeset_helper_vtables.h
> +    fn atomic_update(
> +        plane: &Plane<Self>,
> +        new_state: BorrowedPlaneState<'_, PlaneState<Self::State>>,
> +        old_state: &PlaneState<Self::State>,
> +        state: &AtomicStateMutator<Self::Driver>
> +    ) {
> +        build_error::build_error("This should not be reachable")
> +    }

One more comment. If this is mandatory, why not omit this default here =
to get the compiler to enforce
the implementation of this fn by drivers?=20

> }
>=20
> /// The generated C vtable for a [`DriverPlane`].
> @@ -757,3 +772,25 @@ fn deref_mut(&mut self) -> &mut Self::Target {
>     // - The cast to `drm_plane_state` is safe via `PlaneState`s type =
invariants.
>     unsafe { bindings::__drm_atomic_helper_plane_reset(plane, =
Box::into_raw(new).cast()) };
> }
> +
> +unsafe extern "C" fn atomic_update_callback<T: DriverPlane>(
> +    plane: *mut bindings::drm_plane,
> +    state: *mut bindings::drm_atomic_state,
> +) {
> +    // SAFETY:
> +    // * We're guaranteed `plane` is of type `Plane<T>` via type =
invariants.
> +    // * We're guaranteed by DRM that `plane` is pointing to a valid =
initialized state.
> +    let plane =3D unsafe { Plane::from_raw(plane) };
> +
> +    // SAFETY: DRM guarantees `state` points to a valid =
`drm_atomic_state`
> +    let state =3D unsafe { =
AtomicStateMutator::new(NonNull::new_unchecked(state)) };
> +
> +    // SAFETY: Since we are in the atomic update callback, we're =
guaranteed by DRM that both the old
> +    // and new atomic state are present within `state`
> +    let (old_state, new_state) =3D unsafe {(
> +        state.get_old_plane_state(plane).unwrap_unchecked(),
> +        state.get_new_plane_state(plane).unwrap_unchecked(),
> +    )};
> +
> +    T::atomic_update(plane, new_state, old_state, &state);
> +}
> --=20
> 2.46.1
>=20
>=20

=E2=80=94 Daniel=

