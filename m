Return-Path: <linux-kernel+bounces-424757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61019DB8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62CD16346E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017021A9B4C;
	Thu, 28 Nov 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GEfRPRGV"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4A1A9B52;
	Thu, 28 Nov 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801100; cv=pass; b=e9lEKC640anDVL04q6axv8ePNjITcN6+s8plRxHmf9HYjueWyauC/cAIPjzeqPTz2HSSQMyasFwIEHNoCooPkkurtnZgoSuTZCrnrOwRGx0COZPDdr3TMEPePAwwaaSXYajeY6ETxHnTsqlI5zAfQ9oy6mGuqN2vEsG4EaIW3dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801100; c=relaxed/simple;
	bh=sMli31f5k2R4zuxMzErWTv+JVEyzZe03gFtFRqlczZY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jWzGWZ5W2Q86H4PH6ikZvqswUmgHKwNzn0AjdS6vHUX7mqBC9XYuTdsOjQK+ogZLRP4onFWgotBRS4itfweg8wCpL5NoC7WESOeDsXJQAV+Ww366hAHuh7eU3YAj8CRr/hh/44zYAZRw6KrtCsr2yfAX8hd5ITvdEMM2PasgcZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GEfRPRGV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732801051; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a4sPCVWFbtmlTYEKygiqDDmLR3oqC0ouqwWk+2601UyvS1wz9M6OYLuXvWbVfSqDOMPjeef9UQUO7qFgCFGRVxFSjZv2jPHej8g9eCWxse5gn8Z2OwuyFjyV/q+LVo6lB8KxYNyHa/uVWcJsENeUnoWtQcGnHr+vVYaiWYmR71c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732801051; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8ixZhmmSEhwQiWsN6iV1hHytd5tiR7EWF10aS4cvfPQ=; 
	b=SYwtNttWo1Ckj8Zwq4KgsSS662BRzAFPOHaMgaLqUIrFGHoto0easJViyDLoHehY0KRWl6tP9t4u9F2Bph0hRIYsq90bH0XpEj0Ku++XSgmNpaQhiWdNJ6cM1T0cwmv3bnlKiPrMMq/zeLKzvNkGgR5heOAhZQ9oIWMpDPyrzOQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732801050;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8ixZhmmSEhwQiWsN6iV1hHytd5tiR7EWF10aS4cvfPQ=;
	b=GEfRPRGV3x2CFC/KzNwCDKOd6Jq3n++dy4a6resfcgF9Spii/1gloI20XIub/z8L
	d7Ui6etrFJdld5QKaWY4Jz4vdb35UoIuXcONmFs6KFCfDPi6o1JmWZRPL+WdACy5Wkh
	xkXw+GyfebN3uXEkJkE2VO6v9CIy48x+yvTkjFoQ=
Received: by mx.zohomail.com with SMTPS id 1732801048593235.7251758614393;
	Thu, 28 Nov 2024 05:37:28 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 21/35] rust: drm/kms: Introduce
 DriverCrtc::atomic_check()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-22-lyude@redhat.com>
Date: Thu, 28 Nov 2024 10:37:13 -0300
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
Message-Id: <94CA8996-2993-434F-AE98-989D346461FF@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-22-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude,

> On 30 Sep 2024, at 20:10, Lyude Paul <lyude@redhat.com> wrote:
>=20
> An optional trait method for implementing a CRTC's atomic state check.

A more thorough explanation like you had in your last patch would be =
nice here.

By `atomic state check` you mean after the state has been duplicated, =
and mutated, right?

So it=E2=80=99s the stage where we check whether the hardware can accept =
the new parameters?


>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms/crtc.rs | 46 +++++++++++++++++++++++++++++++++++--
> 1 file changed, 44 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
> index 7864540705f76..43c7264402b07 100644
> --- a/rust/kernel/drm/kms/crtc.rs
> +++ b/rust/kernel/drm/kms/crtc.rs
> @@ -27,7 +27,7 @@
>     marker::*,
>     ptr::{NonNull, null, null_mut, addr_of_mut, self},
>     ops::{Deref, DerefMut},
> -    mem,
> +    mem::{self, ManuallyDrop},
> };
> use macros::vtable;
>=20
> @@ -82,7 +82,7 @@ pub trait DriverCrtc: Send + Sync + Sized {
>         helper_funcs: bindings::drm_crtc_helper_funcs {
>             atomic_disable: None,
>             atomic_enable: None,
> -            atomic_check: None,
> +            atomic_check: if Self::HAS_ATOMIC_CHECK { =
Some(atomic_check_callback::<Self>) } else { None },
>             dpms: None,
>             commit: None,
>             prepare: None,
> @@ -117,6 +117,21 @@ pub trait DriverCrtc: Send + Sync + Sized {
>     ///
>     /// Drivers may use this to instantiate their [`DriverCrtc`] =
object.
>     fn new(device: &Device<Self::Driver>, args: &Self::Args) -> impl =
PinInit<Self, Error>;
> +
> +    /// The optional [`drm_crtc_helper_funcs.atomic_check`] hook for =
this crtc.
> +    ///
> +    /// Drivers may use this to customize the atomic check phase of =
their [`Crtc`] objects. The
> +    /// result of this function determines whether the atomic check =
passed or failed.
> +    ///
> +    /// [`drm_crtc_helper_funcs.atomic_check`]: =
srctree/include/drm/drm_modeset_helper_vtables.h
> +    fn atomic_check(
> +        crtc: &Crtc<Self>,
> +        old_state: &CrtcState<Self::State>,
> +        new_state: BorrowedCrtcState<'_, CrtcState<Self::State>>,
> +        state: &AtomicStateComposer<Self::Driver>
> +    ) -> Result {
> +        build_error::build_error("This should not be reachable")
> +    }
> }
>=20

I am confused. If this is optional, why do we have a default =
implementation with a build_error ?

> /// The generated C vtable for a [`DriverCrtc`].
> @@ -726,3 +741,30 @@ fn as_raw(&self) -> *mut bindings::drm_crtc_state =
{
>         )
>     };
> }
> +
> +unsafe extern "C" fn atomic_check_callback<T: DriverCrtc>(
> +    crtc: *mut bindings::drm_crtc,
> +    state: *mut bindings::drm_atomic_state,
> +) -> i32 {
> +    // SAFETY:
> +    // * We're guaranteed `crtc` is of type `Crtc<T>` via type =
invariants.
> +    // * We're guaranteed by DRM that `crtc` is pointing to a valid =
initialized state.
> +    let crtc =3D unsafe { Crtc::from_raw(crtc) };
> +
> +    // SAFETY: DRM guarantees `state` points to a valid =
`drm_atomic_state`
> +    let state =3D unsafe {
> +        =
ManuallyDrop::new(AtomicStateComposer::new(NonNull::new_unchecked(state)))=

> +    };
> +

Some comments on why ManuallyDrop is required here would also be useful. =
Is it related to the
use of ManuallyDrop in the preceding patch?

> +    // SAFETY: Since we are in the atomic update callback, we're =
guaranteed by DRM that both the old
> +    // and new atomic state are present within `state`
> +    let (old_state, new_state) =3D unsafe {(
> +        state.get_old_crtc_state(crtc).unwrap_unchecked(),
> +        state.get_new_crtc_state(crtc).unwrap_unchecked(),
> +    )};
> +
> +    from_result(|| {
> +        T::atomic_check(crtc, old_state, new_state, &state)?;
> +        Ok(0)
> +    })
> +}
> --=20
> 2.46.1
>=20

=E2=80=94 Daniel


