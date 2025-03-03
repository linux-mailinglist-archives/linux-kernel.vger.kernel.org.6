Return-Path: <linux-kernel+bounces-541207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF1FA4B9F2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141C5188D895
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E71F237A;
	Mon,  3 Mar 2025 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7w2STaE"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCB1F1508
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991958; cv=none; b=PTTPSgYs6WyidyjVQZfETofHQcIyykJwbzEZmillFpUVD/7wDbIWTU6GA48XXa2Kfr2YDvGIJ1xM6Eq2byTxpqwnbZofCIUirUD7aUVE4pg5abwET82buWpxkJSHOmrDobcTK/B2slDG0bZOWHCEoE1QY0v/HbLbmgkwHDp0s34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991958; c=relaxed/simple;
	bh=n0ff1xI1lgmg8Rykovee0x4apm8ykyWD2JrE1dHfyPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rht7+g9z4BBY5ZxBtBIqNj5Pnu1Mo6LbeaT7315FDle+tvcQ1pwTrgyi0914IV/89bW/QS4Xlm2EMJg9aLIVPordupUTELNBnnpu8i+GLaa7Op+DODeCOHNvAqMtnZGt95k1nQjXU8KYXuiRKX4kOEdokYpXFFwSTRlY+Mn/ppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b7w2STaE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f406e9f80so3211387f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740991955; x=1741596755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZedBe7vxwSHNQekhyj5949NlNVonJ7luZ+4oJCMZq0=;
        b=b7w2STaEee5vPKceONXDZJvCBWg/UKCJpdTtwghOFeDYwQc9/8k5gxR8jSH+QgnV1h
         h88VwqUn6kXhdjHxAO+7MFlPm8gZOpHMcp30+B8HC2Qu1Dc1fHBwvS0UJ1YtGmVmT8zP
         LExDFqSmzuRixDyNUyhoezUkgBvpoxRQJn0U3fOf1Fzp3xOWCxQs8fBe9ivMTTy7R+dd
         Vx9HVidy3MkafrqJxiZi2xvX9O9SHxmmClp1k3lVrPUZB8qKPjfFxR2zmbsV68v4gGC2
         ViiWHTj6j17PDx23ZPIKJGUPRgqX3yEfbHzHsSk/LcD2NhWOT1EHhhMgq8bXqDU8bZBd
         w0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991955; x=1741596755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZedBe7vxwSHNQekhyj5949NlNVonJ7luZ+4oJCMZq0=;
        b=gsdCertxv6SHm4yZyCxgboriJk3hS26lsVPMSt2g0vFrnFXOO9MGPBPb/pyaJuJ1rY
         ZszLDm0LGsHJn3dosHHKiVEdwzsDAOgrAcZYM8/2SPdkwebPGWND2s0Wdsbk0ma1tlSc
         TbzYhMUNkw546WSxjBYnwbZnhdHgjQoQAT3YbGTZryUFg9kmJ7grNZlZw9cnpYG2v0Hp
         bSLP6QXLJG6XyogMw6hRBLGthU4wxOogsB7eawj5Je1Ns0vEMyt5uqnd5Wv8Nm5EIMsr
         rJuFQ23bZZE/WMfMzQAiL/3KWveal6CefEJyHC6FmU+QB66urv7x8C7A8wb8aTBatPWA
         8MaA==
X-Forwarded-Encrypted: i=1; AJvYcCU5RjmBy4WM8WJdWmZziYWx0uSPG72i99BVmL09oYlQ3nJLW5F7et+h7xz4PIiV7GtPdpqs/7qnP9q9A9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzklfnF9wmq7QOYX3kYS38zoGvkhiIP6OHPB99Hd3DzRZWU3xnX
	mHe4uDHSOyvR1LgsxXXXqQRczmFeGkes1R6Y1U0DhX+RhFF0W+L5UfO25HVcNr4sR6f6t3A0RJV
	CBM3eReClosH/Ku9/Qz+6RXa2z4RveyLQPDB6
X-Gm-Gg: ASbGncvnsDXqbSU5VGWbqTKO8hEB6FtnDca4KsuZhwgvRKTGaUGumm8jKq7RvEeuihW
	GQA394OLutxm2o0wPV74LXvrYbTQdCZo365ZKha8s7rsNYG1UXCztEBneU9NqZtPxNpcsgFq5TW
	aJQgZgt1dIWQxpelLxGqt068nDkeeeIIY4xcXQNVVWrj0xxHnZNJXYtkmC
X-Google-Smtp-Source: AGHT+IGPWx+m6XG7095T3v0ZVlAXzNJwhfctSVi2QHnsOIWVW4GZ3S/6Td355pTg0Z+ilOrY+qMqRFrKA4AKwqV4ahA=
X-Received: by 2002:a05:6000:188b:b0:391:ba6:c069 with SMTP id
 ffacd0b85a97d-3910ba6c26amr2138123f8f.44.1740991954661; Mon, 03 Mar 2025
 00:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-5-569cc7e8926c@google.com> <CAJ-ks9k4rZdpL5dDfwMHuiKFdyYdY00YioYxdtsqszpcbhzjHQ@mail.gmail.com>
 <CAH5fLggDgYYk-0HzCjDmmHjV6JkR7WJhmQU-Nhbo4iBGBw1AJw@mail.gmail.com> <CAJ-ks9k2HaeTyGfFSfeJUFWkwc2F2hvTg2m4yEQ+8-AvLS6UZg@mail.gmail.com>
In-Reply-To: <CAJ-ks9k2HaeTyGfFSfeJUFWkwc2F2hvTg2m4yEQ+8-AvLS6UZg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 09:52:22 +0100
X-Gm-Features: AQ5f1JqSjZAAlx6Wf7jKinnV6m6qfDAlCxxS5CZwf1LezmrZAHRqRlmJeyImFx8
Message-ID: <CAH5fLggVOKrWZhR8rEH1ZFbJ4naoAP8Dp=pKpuj0MmsThBuK4g@mail.gmail.com>
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

On Fri, Feb 28, 2025 at 6:15=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Fri, Feb 28, 2025 at 12:08=E2=80=AFPM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > On Fri, Feb 28, 2025 at 4:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.=
com> wrote:
> > >
> > > On Fri, Feb 28, 2025 at 7:41=E2=80=AFAM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > >
> > > > @@ -980,8 +983,12 @@ fn draw_all(&mut self, data: impl Iterator<Ite=
m =3D u8>) {
> > > >  /// * If `url_len` > 0, remove the 2 segments header/length and al=
so count the
> > > >  ///   conversion to numeric segments.
> > > >  /// * If `url_len` =3D 0, only removes 3 bytes for 1 binary segmen=
t.
> > > > -#[no_mangle]
> > > > -pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len:=
 usize) -> usize {
> > > > +///
> > > > +/// # Safety
> > > > +///
> > > > +/// Always safe to call.
> > >
> > > This should explain why it's marked unsafe, since it's always safe to=
 call.
> >
> > Safety comments generally do not explain rationale for why they are
> > the way they are. Where would you like me to put it?
>
> Safety comments also generally do not say that the function isn't
> really unsafe (with a notable exception in
> `samples/rust/rust_print_main.rs` which is similar to this case).
>
> Perhaps "This function is marked unsafe because ... but since a safety
> comment is still required:" would flow nicely into the safety section.

I added a comment, but I disagree with this claim. The phrase "Always
safe to call." is actually quite common for a "# Safety" section, even
if we have rarely needed it in the kernel specifically.

> > > > @@ -36,6 +36,10 @@
> > > >  #include <linux/workqueue.h>
> > > >  #include <trace/events/rust_sample.h>
> > > >
> > > > +#if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> > > > +#include <drm/drm_panic.h>
> > > > +#endif
> > >
> > > Why the guard here?
> > >
> > > It'd be nice to have a comment here explaining the atypical need for
> > > this include.
> >
> > It's not necessary. I can drop it.
>
> Ok. A comment on the include would still be helpful.

Added.

Alice

