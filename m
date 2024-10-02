Return-Path: <linux-kernel+bounces-347576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A198D595
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAD31F21AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CD1D0951;
	Wed,  2 Oct 2024 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXDHVALX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F81D07AB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875894; cv=none; b=nc8leQe1UQoZz0PWtKR8svxq204Rlc76TASepwkWRuV1Y1KbfGbIyvyMfgI9GrujRlbPWOuzfoXoGIoesq+HxqeFjVUhOcVr70Lkb1p57KQSu4Y6e0N+uddbICe9gqJ+scTkES2vgsTm6ASYDliIGJNTJy0p7MuoSKHVJF+cqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875894; c=relaxed/simple;
	bh=xIDUfM1YGCBBJI64d1JLkEQ8Gvw4pZEwXK0zAc0QiVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoV64GAv4YLddu0ulT1+e7ZxuHxkit0mioxsqQ0T73tmdr7ZHOCAC3VeutHkJGJePJrq/bzXpNz+mqPcYU87dt5UsAjnVzrAlyEBSrAT7Z6n2LRhm9Dary50OJqV/zblJc3FSw553Fd5W1n1EmnrkC+nbx0NXcbEB/LyjnaASZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXDHVALX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccfada422so3648564f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727875891; x=1728480691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkWYgToO0DMvbFDKMhpMNh7o7O74NRjqRQJdfvF0X/s=;
        b=EXDHVALXh7pFALsFtZktiXxsBUePbRcaGviO+6GaT1K4BBgtGGeLKBoDRms6tusMIX
         VNuJfRvlSzSGG2sgekMCkZFNymF1Cq2U4TIvTXj2rB7H3say3mWBqya7R3DsBCAIKF/8
         ITjfBzCoRAw3qLgIYY5rOrBGoNDnMx0SmHoEq8IlSHEVEgADoswSj8TQqD8HzrKFSYtr
         LwZpgbpe4POn4Dc9QOGLgq0VRZEWMdaAStO2jJOhYOzGM/3T2kspeWLb5O9b5j3qEue8
         7rT0MT+TI4yLd1psQJzHxR3d9b1qnGe0XaeLboRIjDmZSh6kYIFFQSW3Jee9EZ3N2WoY
         qxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875891; x=1728480691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkWYgToO0DMvbFDKMhpMNh7o7O74NRjqRQJdfvF0X/s=;
        b=UODd8JbTquOCF1pB2e9+gjCdlQ1HKRfqSIJIaxU9mlWXfv+Yb+8fuswmr88ZQlGBNY
         F1si3eDgS/i8NkePdYbpnTZxJEGjYQ1TesuWV8TaSnBTgDxDAIw3mKtP/qD5SUMsw2Fc
         RPcPx2+lc14nq3L5cJOclasZDjtvlRTQR/N+7DvYLzcxWjM4dyvFqSKnbgbdxEBg5W+5
         WCA4yx8Du2ssR/DvW+IN+fS5rxWJ5DIoXra+3lCzc/snKiDcTLaS9bSTgVoOWj2rKoGG
         7ScxCLLesa3neVB+OBQHHtZ9hj7/7Wan1NvkeUQiuYqFpMEYiikhVXdg2Wb79JpUPkia
         6OKg==
X-Forwarded-Encrypted: i=1; AJvYcCWxZfV5N0byI0FfPrTGUayPrwO1msoeU/NhyuG8kw/0sKcTyYHy+GEJR5wc4Fguo/2O5+SMD6St9qLZ91A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3TfhfoOZ92KenTJFb6TTuW2M57mBnvENDizXJqRlDv9MgMx0k
	ZK2bDjJqC5WqA6Dlw0HFJ2xjDn0c8h7yzwFNXB3TEOqltH8pLxGkkqOvICjyaEVLBYLI4CN+Sfl
	4wgpyZkPYIx1KpBFQrdSbZ/O4l+J+bwLDJzrt
X-Google-Smtp-Source: AGHT+IFlIvs7e/ia8VSgB2h6Q79NEDLL0KBjtkkuINW01wxUjE5e1qAsquCSTT1UnmS1R7GYH2cAdth2gFMLytNEVKY=
X-Received: by 2002:a5d:63c9:0:b0:37c:d179:2f73 with SMTP id
 ffacd0b85a97d-37cfb8c8403mr1960219f8f.13.1727875890690; Wed, 02 Oct 2024
 06:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com> <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <CAH5fLghmkkYWF8zNFci-B-BvG8LbFCDEZkZWgr54HvLos5nrqw@mail.gmail.com> <50b1c868-3cab-4310-ba4f-2a0a24debaa9@app.fastmail.com>
In-Reply-To: <50b1c868-3cab-4310-ba4f-2a0a24debaa9@app.fastmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Oct 2024 15:31:19 +0200
Message-ID: <CAH5fLghypb6UHbwkPLjZCrFM39WPsO6BCOnfoV+sU01qkZfjAQ@mail.gmail.com>
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

On Wed, Oct 2, 2024 at 3:25=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 2, 2024, at 12:58, Alice Ryhl wrote:
> > On Wed, Oct 2, 2024 at 2:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> > A quick sketch.
> >
> > One option is to do something along these lines:
>
> This does seem promising, at least if I read your sketch
> correctly. I'd probably need a more concrete example to
> understand better how this would be used in a driver.

Could you point me at a driver that uses all of the features we want
to support? Then I can try to sketch it.

> > struct IoctlParams {
> >     pub cmd: u32,
> >     pub arg: usize,
> > }
> >
> > impl IoctlParams {
> >     fn user_slice(&self) -> IoctlUser {
> >         let userslice =3D UserSlice::new(self.arg, _IOC_SIZE(self.cmd))=
;
> >         match _IOC_DIR(self.cmd) {
> >             _IOC_READ =3D> IoctlParams::Read(userslice.reader()),
> >             _IOC_WRITE =3D> IoctlParams::Write(userslice.writer()),
> >             _IOC_READ|_IOC_WRITE =3D> IoctlParams::WriteRead(userslice)=
,
> >             _ =3D> unreachable!(),
>
> Does the unreachable() here mean that something bad happens
> if userspace passes something other than one of the three,
> or are the 'cmd' values here in-kernel constants that are
> always valid?

The unreachable!() macro is equivalent to a call to BUG() .. we
probably need to handle the fourth case too so that userspace can't
trigger it ... but _IOC_DIR only has 4 possible return values.

> > enum IoctlUser {
> >     Read(UserSliceReader),
> >     Write(UserSliceWriter),
> >     WriteRead(UserSlice),
> > }
> >
> > Then ioctl implementations can use a match statement like this:
> >
> > match ioc_params.user_slice() {
> >     IoctlUser::Read(slice) =3D> {},
> >     IoctlUser::Write(slice) =3D> {},
> >     IoctlUser::WriteRead(slice) =3D> {},
> > }
> >
> > Where each branch of the match handles that case.
>
> This is where I fail to see how that would fit in. If there
> is a match statement in a driver, I would assume that it would
> always match on the entire cmd code, but never have a command
> that could with more than one _IOC_DIR type.

Here's what Rust Binder does today:

/// The ioctl handler.
impl Process {
    /// Ioctls that are write-only from the perspective of userspace.
    ///
    /// The kernel will only read from the pointer that userspace
provided to us.
    fn ioctl_write_only(
        this: ArcBorrow<'_, Process>,
        _file: &File,
        cmd: u32,
        reader: &mut UserSliceReader,
    ) -> Result {
        let thread =3D this.get_current_thread()?;
        match cmd {
            bindings::BINDER_SET_MAX_THREADS =3D>
this.set_max_threads(reader.read()?),
            bindings::BINDER_THREAD_EXIT =3D> this.remove_thread(thread),
            bindings::BINDER_SET_CONTEXT_MGR =3D>
this.set_as_manager(None, &thread)?,
            bindings::BINDER_SET_CONTEXT_MGR_EXT =3D> {
                this.set_as_manager(Some(reader.read()?), &thread)?
            }
            bindings::BINDER_ENABLE_ONEWAY_SPAM_DETECTION =3D> {
                this.set_oneway_spam_detection_enabled(reader.read()?)
            }
            bindings::BINDER_FREEZE =3D> ioctl_freeze(reader)?,
            _ =3D> return Err(EINVAL),
        }
        Ok(())
    }

    /// Ioctls that are read/write from the perspective of userspace.
    ///
    /// The kernel will both read from and write to the pointer that
userspace provided to us.
    fn ioctl_write_read(
        this: ArcBorrow<'_, Process>,
        file: &File,
        cmd: u32,
        data: UserSlice,
    ) -> Result {
        let thread =3D this.get_current_thread()?;
        let blocking =3D (file.flags() & file::flags::O_NONBLOCK) =3D=3D 0;
        match cmd {
            bindings::BINDER_WRITE_READ =3D> thread.write_read(data, blocki=
ng)?,
            bindings::BINDER_GET_NODE_DEBUG_INFO =3D>
this.get_node_debug_info(data)?,
            bindings::BINDER_GET_NODE_INFO_FOR_REF =3D>
this.get_node_info_from_ref(data)?,
            bindings::BINDER_VERSION =3D> this.version(data)?,
            bindings::BINDER_GET_FROZEN_INFO =3D> get_frozen_status(data)?,
            bindings::BINDER_GET_EXTENDED_ERROR =3D>
thread.get_extended_error(data)?,
            _ =3D> return Err(EINVAL),
        }
        Ok(())
    }

    pub(crate) fn ioctl(this: ArcBorrow<'_, Process>, file: &File,
cmd: u32, arg: usize) -> Result {
        use kernel::ioctl::{_IOC_DIR, _IOC_SIZE};
        use kernel::uapi::{_IOC_READ, _IOC_WRITE};

        crate::trace::trace_ioctl(cmd, arg as usize);

        let user_slice =3D UserSlice::new(arg, _IOC_SIZE(cmd));

        const _IOC_READ_WRITE: u32 =3D _IOC_READ | _IOC_WRITE;

        let res =3D match _IOC_DIR(cmd) {
            _IOC_WRITE =3D> Self::ioctl_write_only(this, file, cmd, &mut
user_slice.reader()),
            _IOC_READ_WRITE =3D> Self::ioctl_write_read(this, file, cmd,
user_slice),
            _ =3D> Err(EINVAL),
        };

        crate::trace::trace_ioctl_done(res);
        res
    }
}

Alice

