Return-Path: <linux-kernel+bounces-347690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2254998DB21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E24B2368F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776E81D0956;
	Wed,  2 Oct 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7465AFA"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BC1D096F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879000; cv=none; b=ZzLnN+3JEYkwDPE6jUSW4aoERcfa7fvsBP1tfjpSFpi4Mjt4lPfBRoQekZtJPR9mHefpnsMMrk5UZBUqHPzywsiPXPZpu75H8oPvdy5PPAcMvmQEziFje1puA9KP4vp/I5G/9JwSOYyqSbME6uaY6qsBfILq2BO1gsLaEOVmpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879000; c=relaxed/simple;
	bh=eiyjdF5hXl39+AjMZDIaRSk6/Ek8NxiW/0BDefW2khY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ok3QHwj+OLsqx+DAu7VVsL1kq7kBBYkIkBFBibA0gCQ6YlmgEQq2cGZHvyQyURTUTK0rSP2ZPVekCqAz9PL9kfeyhBQ3x+OLlRFgSW0YXrT56he7VX5/vLO4JKMNpIbIjGSvi8EE/2zI6e4DcQKCPYhn1NUGwMbd814GwjR8mEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7465AFA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so60904295e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727878997; x=1728483797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6jepWn8dhuSRAjLw3KdMFpHt20laxE9Jig0ar+wsmA=;
        b=i7465AFAOlkzs6oxv4l4t6fKtjXUT1jAdQytE/ltD6cvhFtEG50Xqme1axzcSGua8J
         yt12pdD2SELUvXD/G3F4y7EL8p+Wo6Rbvb8I5QGkjlj7L31Y4Ghkyx45XmwQ/brfacLp
         TvUO2ufP4oT4DEEnzhfv/PJ2SHCpBZVlRxK1puL9uFnR3Jm9q75K2v5vfei8v0o1SaIs
         ixi42KE2fTAHctgPmzCpkrNm1KOGJf9B44Teps6BSDzoOEW1tTFKRBdb9DTtMQf8GYpZ
         qgzS3xO2QW3V1x6S5SIA/LuxxACNiWJX4+7BtEQv/aKaPn3OvbA7GxkE4VfMoHPlDYBa
         ZMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878997; x=1728483797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6jepWn8dhuSRAjLw3KdMFpHt20laxE9Jig0ar+wsmA=;
        b=gOeWA23fiQsKMS+EsWy5Kd5/D721n0L6P6mXlytZNn4GPO3yUTEd+a2vl6HWkY9DTy
         fNyIxDz73JM99Ohjzt+2aB4byJB8IcW778VwDAF6XGeR/bFQbzVVrkZFCjw25TwAtcX8
         nb0+CZVPEGnH2QXHhJmWMEueQeV05qUR/cgH5/pEpervASxpugMHQ+gPNg0JV2CKnDAu
         MznCllrVgR+XwP5JMh0cZE+B31jy68PzHxkDFiYb+96LYak8y4PhmB0TiAMbl976GxY+
         cRdGF4r9kVMoJBEhEVn+IfFkC1rM7xgU03c2NyB8futXNVajJT2mQUFCU/SSIE59PXWN
         1BNg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Wufjm0uWlWnYFBiMQTAkk6CpBUCbowz2pQOxUQ9TDbhrpcJg33duqwqvcFrz9gKMnKCP6CqOhH6usOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLEEpAsikj+TMquxSaU3Zo6A6ThgP0HdUH9Ok5KgMx37F80wv
	JHMmqxmWjrmy9wxjQMipE1hTuvy3XeXEMAiqd9ZIzNSVjFz/soNi5whEdH/Lf02Zt3drzDDvTgD
	n4L9Kwi/O9X2zfQC+GYsjZzosL9RL6xpQM3pY
X-Google-Smtp-Source: AGHT+IGcQPzxIUZ3glbIGkb5AzgTz8lDY/Rdgwu3D1JTRTdIyDAO4C5JPTlfGwW0gSTHx3EECbpMY9WDk1ryLmAIUqM=
X-Received: by 2002:a05:600c:3c9f:b0:42c:aeaa:6aff with SMTP id
 5b1f17b1804b1-42f777c0705mr24758295e9.10.1727878997036; Wed, 02 Oct 2024
 07:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com> <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <CAH5fLghmkkYWF8zNFci-B-BvG8LbFCDEZkZWgr54HvLos5nrqw@mail.gmail.com>
 <50b1c868-3cab-4310-ba4f-2a0a24debaa9@app.fastmail.com> <CAH5fLghypb6UHbwkPLjZCrFM39WPsO6BCOnfoV+sU01qkZfjAQ@mail.gmail.com>
 <46c9172e-131a-4ba4-8945-aa53789b6bd6@app.fastmail.com>
In-Reply-To: <46c9172e-131a-4ba4-8945-aa53789b6bd6@app.fastmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Oct 2024 16:23:04 +0200
Message-ID: <CAH5fLgjjcwTZzN5+6yfku2J6SG1A8pNUKOkk1_JuyAcfNXa2BQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:59=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 2, 2024, at 13:31, Alice Ryhl wrote:
> > On Wed, Oct 2, 2024 at 3:25=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >>
> >> On Wed, Oct 2, 2024, at 12:58, Alice Ryhl wrote:
> >> > On Wed, Oct 2, 2024 at 2:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de>=
 wrote:
> >> > A quick sketch.
> >> >
> >> > One option is to do something along these lines:
> >>
> >> This does seem promising, at least if I read your sketch
> >> correctly. I'd probably need a more concrete example to
> >> understand better how this would be used in a driver.
> >
> > Could you point me at a driver that uses all of the features we want
> > to support? Then I can try to sketch it.
>
> drivers/media/v4l2-core/v4l2-ioctl.c probably has all of the
> things we want here, plus more. This is a big ugly for having
> to pass a function pointer into the video_usercopy() function
> and then have both functions know about particular commands.
>
> You can also see the effects of the compat handlers there,
> e.g. VIDIOC_QUERYBUF has three possible sizes associated
> with it, depending on sizeof(long) and sizeof(time_t).
>
> There is a small optimization for buffers up to 128 bytes
> to avoid the dynamic allocation, and this is likely a good
> idea elsewhere as well.

Oh, my. That seems like a rather sophisticated ioctl handler.

Do we want all new ioctl handlers to work along those lines?

> >> > struct IoctlParams {
> >> >     pub cmd: u32,
> >> >     pub arg: usize,
> >> > }
> >> >
> >> > impl IoctlParams {
> >> >     fn user_slice(&self) -> IoctlUser {
> >> >         let userslice =3D UserSlice::new(self.arg, _IOC_SIZE(self.cm=
d));
> >> >         match _IOC_DIR(self.cmd) {
> >> >             _IOC_READ =3D> IoctlParams::Read(userslice.reader()),
> >> >             _IOC_WRITE =3D> IoctlParams::Write(userslice.writer()),
> >> >             _IOC_READ|_IOC_WRITE =3D> IoctlParams::WriteRead(usersli=
ce),
> >> >             _ =3D> unreachable!(),
> >>
> >> Does the unreachable() here mean that something bad happens
> >> if userspace passes something other than one of the three,
> >> or are the 'cmd' values here in-kernel constants that are
> >> always valid?
> >
> > The unreachable!() macro is equivalent to a call to BUG() .. we
> > probably need to handle the fourth case too so that userspace can't
> > trigger it ... but _IOC_DIR only has 4 possible return values.
>
> As a small complication, _IOC_DIR is architecture specific,
> and sometimes uses three bits that lead to four additional values
> that are all invalid but could be passed by userspace.

Interesting. I did not know that.

> >> This is where I fail to see how that would fit in. If there
> >> is a match statement in a driver, I would assume that it would
> >> always match on the entire cmd code, but never have a command
> >> that could with more than one _IOC_DIR type.
> >
> > Here's what Rust Binder does today:
> >
> > /// The ioctl handler.
> > impl Process {
> >     /// Ioctls that are write-only from the perspective of userspace.
> >     ///
> >     /// The kernel will only read from the pointer that userspace
> > provided to us.
> >     fn ioctl_write_only(
> >         this: ArcBorrow<'_, Process>,
> >         _file: &File,
> >         cmd: u32,
> >         reader: &mut UserSliceReader,
> >     ) -> Result {
> >         let thread =3D this.get_current_thread()?;
> >         match cmd {
> >             bindings::BINDER_SET_MAX_THREADS =3D>
> > this.set_max_threads(reader.read()?),
> >             bindings::BINDER_THREAD_EXIT =3D> this.remove_thread(thread=
),
> >             bindings::BINDER_SET_CONTEXT_MGR =3D>
> > this.set_as_manager(None, &thread)?,
> >             bindings::BINDER_SET_CONTEXT_MGR_EXT =3D> {
> >                 this.set_as_manager(Some(reader.read()?), &thread)?
> >             }
> >             bindings::BINDER_ENABLE_ONEWAY_SPAM_DETECTION =3D> {
> >                 this.set_oneway_spam_detection_enabled(reader.read()?)
> >             }
> >             bindings::BINDER_FREEZE =3D> ioctl_freeze(reader)?,
> >             _ =3D> return Err(EINVAL),
> >         }
> >         Ok(())
> >     }
>
> I see. So the 'match cmd' bit is what we want to have
> for certain, this is a sensible way to structure things.
>
> Having the split into none/read/write/readwrite functions
> feels odd to me, and this means we can't group a pair of
> get/set commands together in one place, but I can also see
> how this makes sense from the perspective of writing the
> output buffer back to userspace.

It's the most convenient way to do it without having any
infrastructure for helping with writing ioctls. I imagine that adding
something to help with that could eliminate the reason for matching
twice in this way.

> It seems like it should be possible to validate the size of
> the argument against _IOC_SIZE(cmd) at compile time, but this
> is not currently done, right?

No, right now that validation happens at runtime. The ioctl handler
tries to use the UserSliceReader to read a struct, which fails if the
struct is too large.

I wonder if we could go for something more comprehensive than the
super simple thing I just put together. I'm sure we can validate more
things at compile time.

Alice

