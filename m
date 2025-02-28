Return-Path: <linux-kernel+bounces-539027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEBDA49FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E77B177124
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B2277803;
	Fri, 28 Feb 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zTKrngKZ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4372755FE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762536; cv=none; b=RrVG60hqOzeOAhwnlaTX+28yNgBVRtYWlkrVQmHXdDiHGUzpWff3f57RydUdOf/USPDbhNITjQkvtNAtId9NVL55Ub60DQvT30+/8cii5BX/rPx+qJilT9OqhRZMe5l2TBOY1wusz5n56Zo4PxcLd2F4jdbvcBSaUtm30GF68II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762536; c=relaxed/simple;
	bh=EmCyCn2DxF9tSGDIfIoV9yqm+qOWy504WdSnCUBtPkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7luQYKOtxg2qgp4rcCUI2dLpCpqHCFAAud3nW3Hrn2F3P43KP70JABo5Co1I/yry2AtoFtwSJSU6/BAqvmlm0scfp68K1xGgulZH0qDXHKlxFH1m9VsDmYnBxEBnHxwxCLSH3JuzHKm4FEbnyd4rLdRHcMj8vs/XIoEOwbm93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zTKrngKZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390f69e71c8so176634f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740762532; x=1741367332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaPCTODeLwe+V7QIP7WdzTJW222I9T9UXPmt/Ut/lfU=;
        b=zTKrngKZ9G3faw9PsTHUDqLHS6RTAeEyOf3hk8v9Cmjc1SKZxanmzcKi5gAn0xX1M0
         TtP8IVX95H/WlUi9mJXcEfc6XjNpFDfdtb8Khy+24llfG5dllx1KRKSN/f+8d/GP1WT2
         VYx88hCtYdknv330ee7Wl+sQWWLeKzhqRT7HB4CKMFatEZz0k7H9kH6T7i4aWGOcGMcz
         +gmOuDkl7jONJ8xIQM7sL4UarpWzeb/EsoBcCJGkleY1FAgMny1Xj/+azSoRLc0F3Btt
         RfEvAsKNejgrQaL6TMwFRldp8dQxRIDO6XVmyEtWmjKmqKCEXBsGklujPtXUmbENuYtU
         iV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762532; x=1741367332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaPCTODeLwe+V7QIP7WdzTJW222I9T9UXPmt/Ut/lfU=;
        b=orc/EYO3McQZznsCCmsD+cNqBIMx0GUOW2MKi8Ak9u3Zb/prWLkgfxMpIA7WWEpbng
         09iSUTXltt2useK1XIAr5biO/5DClolpgOfI8ZCBNdnt8HyEvRQqskknfOSOoFndQpP0
         A1/4zDAaNc6AJsh0wg7ZL20UX+sVU75Pg8ac1vlb3gODeiyWIS5OF3DeXljI8qLZDKbr
         RuRLLgFcWMCMr9pse9tq4470HmS1TtfA7IdI2Ytg/w7zW10yz6aVNb+mu2HRvY5v/+0R
         cnI2lmtZC2Ml6LZbs2tXyKe+ssdfC/fRIr4mZHIepq7CVQWpVwd31n2rz7PPu1C2ZbCb
         pMww==
X-Forwarded-Encrypted: i=1; AJvYcCUQqpHsX3DjQpRcUhsqRb4RMoSk1wIET6/3PzL7W2D82yoLVfPan2lv0gsnMiPTUsyRCqFL+H2NR+tFYnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SxZwpzVjhABSxodCPvZ1ET1AxkbRMJ99bqr4ZgyW7PF7AJdl
	THesLZ4MWl+JvZpt6Smm+NMHl5U9v4gN4c8RFghs2zRppZH1Drm9o+A3A+4QpDpQE4kp+d0XnD9
	iAlwO0tkj5CApzRGqZuyJIv+Ck/DQLdbNL3+E
X-Gm-Gg: ASbGncthZODfVAQDlm297YSAS4FVxZq17K74cJXZ6GZiTObZhZYiB/7fWHDZuMrSySr
	YVaaIaviY025XtqYOE5G38YfyguiX38HmJ67ZRM2QrDb+Y8+8yRqn9sxjj9SG0GaKeBX+3baBau
	Ue+oIVtG6ifIR9YFBrJnPw3vdLw+K7e/WmFJZ+OQ==
X-Google-Smtp-Source: AGHT+IG54e3GobkjZ8tPZxRoFcianUe+ZFTkJdAFfhIp2F2JiHuS56Xy9kQY/09d8HuGTQm+42i6miBW+7XanJXjdSQ=
X-Received: by 2002:a05:6000:400a:b0:38f:23c4:208c with SMTP id
 ffacd0b85a97d-390e18c8b0amr6664532f8f.18.1740762530834; Fri, 28 Feb 2025
 09:08:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-5-569cc7e8926c@google.com> <CAJ-ks9k4rZdpL5dDfwMHuiKFdyYdY00YioYxdtsqszpcbhzjHQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9k4rZdpL5dDfwMHuiKFdyYdY00YioYxdtsqszpcbhzjHQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 18:08:38 +0100
X-Gm-Features: AQ5f1JpN4S2btnyWpu2cTmIDiHVgyZ8OiCtI3DLh4W0P9eLmgQGdOBc2TieXEkk
Message-ID: <CAH5fLggDgYYk-0HzCjDmmHjV6JkR7WJhmQU-Nhbo4iBGBw1AJw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] panic_qr: use new #[export] macro
To: Tamir Duberstein <tamird@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Fri, Feb 28, 2025 at 7:41=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > This validates at compile time that the signatures match what is in the
> > header file. It highlights one annoyance with the compile-time check,
> > which is that it can only be used with functions marked unsafe.
> >
> > If the function is not unsafe, then this error is emitted:
> >
> > error[E0308]: `if` and `else` have incompatible types
> >    --> <linux>/drivers/gpu/drm/drm_panic_qr.rs:987:19
> >     |
> > 986 | #[export]
> >     | --------- expected because of this
> > 987 | pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len=
: usize) -> usize {
> >     |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected unsafe fn, =
found safe fn
> >     |
> >     =3D note: expected fn item `unsafe extern "C" fn(_, _) -> _ {kernel=
::bindings::drm_panic_qr_max_data_size}`
> >                found fn item `extern "C" fn(_, _) -> _ {drm_panic_qr_ma=
x_data_size}`
> >
> > Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  drivers/gpu/drm/drm_panic.c     |  5 -----
> >  drivers/gpu/drm/drm_panic_qr.rs | 15 +++++++++++----
> >  include/drm/drm_panic.h         |  7 +++++++
> >  rust/bindings/bindings_helper.h |  4 ++++
> >  4 files changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> > index f128d345b16d..dee5301dd729 100644
> > --- a/drivers/gpu/drm/drm_panic.c
> > +++ b/drivers/gpu/drm/drm_panic.c
> > @@ -486,11 +486,6 @@ static void drm_panic_qr_exit(void)
> >         stream.workspace =3D NULL;
> >  }
> >
> > -extern size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
> > -
> > -extern u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data=
_len, size_t data_size,
> > -                               u8 *tmp, size_t tmp_size);
> > -
> >  static int drm_panic_get_qr_code_url(u8 **qr_image)
> >  {
> >         struct kmsg_dump_iter iter;
> > diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_pani=
c_qr.rs
> > index bcf248f69252..d055655aa0cd 100644
> > --- a/drivers/gpu/drm/drm_panic_qr.rs
> > +++ b/drivers/gpu/drm/drm_panic_qr.rs
> > @@ -27,7 +27,10 @@
> >  //! * <https://github.com/bjguillot/qr>
> >
> >  use core::cmp;
> > -use kernel::str::CStr;
> > +use kernel::{
> > +    prelude::*,
> > +    str::CStr,
> > +};
> >
> >  #[derive(Debug, Clone, Copy, PartialEq, Eq, Ord, PartialOrd)]
> >  struct Version(usize);
> > @@ -929,7 +932,7 @@ fn draw_all(&mut self, data: impl Iterator<Item =3D=
 u8>) {
> >  /// * `tmp` must be valid for reading and writing for `tmp_size` bytes=
.
> >  ///
> >  /// They must remain valid for the duration of the function call.
> > -#[no_mangle]
> > +#[export]
> >  pub unsafe extern "C" fn drm_panic_qr_generate(
> >      url: *const kernel::ffi::c_char,
> >      data: *mut u8,
> > @@ -980,8 +983,12 @@ fn draw_all(&mut self, data: impl Iterator<Item =
=3D u8>) {
> >  /// * If `url_len` > 0, remove the 2 segments header/length and also c=
ount the
> >  ///   conversion to numeric segments.
> >  /// * If `url_len` =3D 0, only removes 3 bytes for 1 binary segment.
> > -#[no_mangle]
> > -pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usi=
ze) -> usize {
> > +///
> > +/// # Safety
> > +///
> > +/// Always safe to call.
>
> This should explain why it's marked unsafe, since it's always safe to cal=
l.

Safety comments generally do not explain rationale for why they are
the way they are. Where would you like me to put it?

> > +#[export]
> > +pub unsafe extern "C" fn drm_panic_qr_max_data_size(version: u8, url_l=
en: usize) -> usize {
> >      #[expect(clippy::manual_range_contains)]
> >      if version < 1 || version > 40 {
> >          return 0;
> > diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> > index f4e1fa9ae607..2a1536e0229a 100644
> > --- a/include/drm/drm_panic.h
> > +++ b/include/drm/drm_panic.h
> > @@ -163,4 +163,11 @@ static inline void drm_panic_unlock(struct drm_dev=
ice *dev, unsigned long flags)
> >
> >  #endif
> >
> > +#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> > +extern size_t drm_panic_qr_max_data_size(u8 version, size_t url_len);
> > +
> > +extern u8 drm_panic_qr_generate(const char *url, u8 *data, size_t data=
_len, size_t data_size,
> > +                               u8 *tmp, size_t tmp_size);
> > +#endif
> > +
> >  #endif /* __DRM_PANIC_H__ */
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 55354e4dec14..5345aa93fb8a 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -36,6 +36,10 @@
> >  #include <linux/workqueue.h>
> >  #include <trace/events/rust_sample.h>
> >
> > +#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> > +#include <drm/drm_panic.h>
> > +#endif
>
> Why the guard here?
>
> It'd be nice to have a comment here explaining the atypical need for
> this include.

It's not necessary. I can drop it.

Alice

