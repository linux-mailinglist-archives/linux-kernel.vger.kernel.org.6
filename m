Return-Path: <linux-kernel+bounces-539038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E8A4A00F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C893A9DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA321BBBD7;
	Fri, 28 Feb 2025 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k11uD75O"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397881F4C88;
	Fri, 28 Feb 2025 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762948; cv=none; b=IVoPoBr5JgPhIx0JK47/3ZBkb/rEzK24AQLrDNNiJocM0sL78ljgRA+QvY1ZBN1QLQ23xnjA132A6L78MC25Zvso4Era3cOxf7HbcycaH2JMSP2Pxsk0Mj3PT5I/F3oNb1OyzCl26whKw+9Crd17Ho1vYEjalO/ODp+4AKUT2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762948; c=relaxed/simple;
	bh=gx4wG1zS7MeYegXlTB+CL4QBg1jGlAiH8mFxp22/Vvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkmNtrSS/gwjlOAX5EUEm3jkXB6kiVoUozCVLdhCR701mN8vUsl8vsMLMbpyM2y03g+rEYPFIat0Fbib+Vwyb0CZxWxnC/nxnowOZPciSo8RIqt/J9H72c5z1YlP+LAHpDKmM3aJldFNEu+1qlxo1qhTulbZz6SguNJKw3haI+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k11uD75O; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so20057151fa.3;
        Fri, 28 Feb 2025 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740762945; x=1741367745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5IViTe8RLsr/7gyIz1ubG0CWzAG2HTZaKxR7vnijfU=;
        b=k11uD75OR5utqDP474QgyeTYVf/NM+H6xBqpn6uxUmLH5/fJzhBXrEvLRPryyiXfnD
         h8uLlWFgQaGg1zpRk/o30w0yu84Pv+WPEVYTIl9GZIBVdWXfKCK9t0Oq/cwJyEd4msQQ
         2XMrIFpFKDzC6nEff09uaIemy+SGdnr33829gKrBc39n4UmoMwzEIVZ1ebkLCy2epUL/
         mjrzqH+ACK1O1bQNO4k4ZK1iV3t7R0ZUcsuW3cckXTCwGcKiFyLtFqlc57Lq6kZXWKtZ
         lJVczUSGi85UUyZEZPV4+aKgnB8Kod+8up81Y8Dw3M+BNkek9nTN4K0720yV0UG7JFiC
         k0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762945; x=1741367745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5IViTe8RLsr/7gyIz1ubG0CWzAG2HTZaKxR7vnijfU=;
        b=aiPGljE7fhIXrUgsxPUg73z+KlCcHrFI4nOhG529RtDEca/XkccFgIOkWR1Y2mX/JT
         jIkFSLcovb8Jm+V0AfW9cRgpp+n5UaAS3g6D5aMCuZix2Z6UBBu2t2U5C6/c8TtfhTgd
         gtXtmwrqtY8BBQ8ZLMfrp3VpV4BzSLHWZnJphmN6zafVj2XooADoXLXFF6yw5363XMHV
         JdeupDORBccY3MdZ3D6XHkagws1AUN+gs1xGULqk+sduPSvudz21YVZnXAybfLk5QPzT
         nSJlI+vuPM/BZNvcxw1hAdQDr+uFOKJYDzZFug5R8DPXEyD6t7EPp6/nhhjYRZU0h3Xc
         sbdw==
X-Forwarded-Encrypted: i=1; AJvYcCUEhpoxCfw3z5kkyVeCZ1JRUp8A6dUbwseFdVF5Xj3j9oqpK/cUhSw24GjRLAe69TIyZyC/8ZtlQZ/S3pQ=@vger.kernel.org, AJvYcCWVvritzaLXJaqKCIji7691dTGvbvSu5kAwjm66FdZxMDDHMRSvfpWL8f7IyI3GZTdWlPbG0Lxk5Iz6ywP4Qe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfDPsxiGfTk6RsEQ2bFg69tqkxC8GrkgEw5BWQOWKr+QFT2ix
	Z15aYibsxlj/56TcGQ60WYGIcQS9eFFeqxOKtT/9qt8QyUGcNWIO5y+H3psdF6IzCkrgrTB680c
	m4YnHdSd1czHsflWddswgLxdztLg=
X-Gm-Gg: ASbGncs4X7prEaAgrnvnJdt98xA5ZtpPuDPgmZ5lz0dInupeuD5Ynw2cNYw3p9yX0P+
	jCNAhCpP4a1UXc+Gus424vwKyOdqcXUmANezXR5gs32Cxsl6QegYAh8HIQ5a0XGKvlYzgwy3t8j
	6o8iRrEYrOeFnzQwEVoomQHZ0pRmAbF1xSJBQ/Tf8G
X-Google-Smtp-Source: AGHT+IEbcsQtbp3O+ey+VrdIkA81JOdN79Hm7TR8R6EWpdhblI9jRvrXZbzmKG3aUjKFJdpaw+SmrW35RWe4VuPKUGM=
X-Received: by 2002:a05:651c:1503:b0:30b:a20b:6667 with SMTP id
 38308e7fff4ca-30ba20b669cmr2499401fa.9.1740762945018; Fri, 28 Feb 2025
 09:15:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-5-569cc7e8926c@google.com> <CAJ-ks9k4rZdpL5dDfwMHuiKFdyYdY00YioYxdtsqszpcbhzjHQ@mail.gmail.com>
 <CAH5fLggDgYYk-0HzCjDmmHjV6JkR7WJhmQU-Nhbo4iBGBw1AJw@mail.gmail.com>
In-Reply-To: <CAH5fLggDgYYk-0HzCjDmmHjV6JkR7WJhmQU-Nhbo4iBGBw1AJw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 28 Feb 2025 12:15:07 -0500
X-Gm-Features: AQ5f1JrjOvuMmGe4WteqIrZ6qgU1Y7KkRrBQNzJg64Rc_W6A8qEHvWvwyzOVcTM
Message-ID: <CAJ-ks9k2HaeTyGfFSfeJUFWkwc2F2hvTg2m4yEQ+8-AvLS6UZg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] panic_qr: use new #[export] macro
To: Alice Ryhl <aliceryhl@google.com>
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

On Fri, Feb 28, 2025 at 12:08=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Fri, Feb 28, 2025 at 4:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > On Fri, Feb 28, 2025 at 7:41=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > @@ -980,8 +983,12 @@ fn draw_all(&mut self, data: impl Iterator<Item =
=3D u8>) {
> > >  /// * If `url_len` > 0, remove the 2 segments header/length and also=
 count the
> > >  ///   conversion to numeric segments.
> > >  /// * If `url_len` =3D 0, only removes 3 bytes for 1 binary segment.
> > > -#[no_mangle]
> > > -pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: u=
size) -> usize {
> > > +///
> > > +/// # Safety
> > > +///
> > > +/// Always safe to call.
> >
> > This should explain why it's marked unsafe, since it's always safe to c=
all.
>
> Safety comments generally do not explain rationale for why they are
> the way they are. Where would you like me to put it?

Safety comments also generally do not say that the function isn't
really unsafe (with a notable exception in
`samples/rust/rust_print_main.rs` which is similar to this case).

Perhaps "This function is marked unsafe because ... but since a safety
comment is still required:" would flow nicely into the safety section.

> > > @@ -36,6 +36,10 @@
> > >  #include <linux/workqueue.h>
> > >  #include <trace/events/rust_sample.h>
> > >
> > > +#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> > > +#include <drm/drm_panic.h>
> > > +#endif
> >
> > Why the guard here?
> >
> > It'd be nice to have a comment here explaining the atypical need for
> > this include.
>
> It's not necessary. I can drop it.

Ok. A comment on the include would still be helpful.

