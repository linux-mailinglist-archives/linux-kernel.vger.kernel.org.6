Return-Path: <linux-kernel+bounces-311489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB899689C3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E55E28439D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462E19E986;
	Mon,  2 Sep 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ycd+acDj"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A71E49F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286781; cv=none; b=mUJhls5OmolvO76+ynv/AHheNspY8h6ZbDyHLVbdI5U1tdP4cTV3xBSIFm2accRbKHVK04QHezD+Hk2sVLeusD4xONP6vYFc2e0B91sd3G0l2S2MZHWGfYAqy4FDNaAdYmy+sRtoC+WKxDisECBOk1W/CYlHQN0uA0MMXV2Yl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286781; c=relaxed/simple;
	bh=LG0/mepi4Yn4891dLYyQ4cRspvQjvmHTXGUk+m7kvJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siWrXzPamaPlOMyPrzNxuIQJ6772QTl5PL0tgsMmndrSIYUMnVrfRps/0EvmdgDlOl18g84zyfhKal2k1K5EOzq1Thd/BJTbPeBa+QWd9d46TyEEUCT2GqoueaZtymNHhL8PKhYS2EtDegxBNGl0d7/YFm/e/AKpClz2V7b5QE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ycd+acDj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c84dcc64so957734f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725286778; x=1725891578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoa/sFhv9aeIIaoHwgF3hcgD0SXOWcDwajU4vAmZvlw=;
        b=Ycd+acDjZ+/z5cHqtdUbFKLU4OxLrDPrf6wJNNdW8Il+fxkI3mUK/CwbyOziJcni6+
         +gIp0TNq4jfAUftw4CuFMH9NvPFPe98TvsGmRy+0edeS755Lln7qy71h7h6K3eBF+Bev
         4/0bqcrSfbjhf5FWBATRhJfdvd1saO9pfFLFM3IendaIHq2uoKgLTNsoAq+ZYE/2x2q6
         ZfGupWNs35BVSR484Kw2Ov08vdrAHGN/dGyz/OadeNdrwyMQ9SwuYkblAw/BrqJbu8UW
         A7VkCGAlAhCX0G084JsWSNtNuZB+nfO2VViGv6n/U4RH8SNTlqoiREsKy2gF869Hm818
         gXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286778; x=1725891578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoa/sFhv9aeIIaoHwgF3hcgD0SXOWcDwajU4vAmZvlw=;
        b=DFxKM9qnlHT4GHqPlSkKno+aMZovxV8b+ywYzJicYLb/IVD8vYfbczxXG+U80HVutm
         xmAIJzXOPyHkZF/RXFbSTT4BjiIBKebRLm3To/BhfbOCNoxw7sDlfi/JX+z0wtw6Xbxm
         h4TDqMkUvu53zBfhBvgsDqDU4mlb+GdY5ySZ63P6XOECCN1BxhL28lCnjEr+7Gb4Q4jx
         Got0+jcv2sIdPXsulNL886A7vESF68zXQnEPZalSGMp4JHKhcKUiE0QyMoBot2Qzu2sg
         QbdNuruvp0LcUy7hrH1A+XZV9hhVJm9/x/s4OtUR7vDEHErkt/Avmcht7p/Clvv7TxHT
         maRA==
X-Forwarded-Encrypted: i=1; AJvYcCU/zN/1wQs9k3rR+a+gvIDjdqj6MteJLUC/Jzb0iyelRWNqmWONGM1bWQoCddnC0+soM8Yz6fqXPWt5RNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6i4b9c71DUsfl1T1LnyZhokKUR10p265TMVfWuR7m+JvXVITP
	RKbe2wFUhcLQuHy9edcVU5MuRxeXV+ff8qUYVCz/inllV3eOu/drrtMNk7WHwJETuDoNkPxQ26G
	RbKA30x7zt2vPulXL1+8Pvg5pTZ0Zu9jMW27i
X-Google-Smtp-Source: AGHT+IGxkHEaZH/ZhcBOmeWnhbMJUIKaj6yfOK2C/lu4yJnt27SEIG5s+Si57ntQAuhwDIsQi5J9SQtVTkAUmC9Xpuk=
X-Received: by 2002:a5d:56d1:0:b0:374:bcdc:6257 with SMTP id
 ffacd0b85a97d-374bcdc639amr6440738f8f.54.1725286777254; Mon, 02 Sep 2024
 07:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com>
 <10453342-d269-4b78-8962-821ef53d3cb5@proton.me> <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com>
 <3b557f61-cead-4568-b2b4-4a56c4cbff52@proton.me> <CAH5fLggE-fWDuZXH_F3ixDSo7sQEFwnUV3cd+9_rpFH+XmnA2Q@mail.gmail.com>
 <CAH5fLgiZt3uVZiU1xXPcvYNR-Em2V3y+-C9EbsqrNvkScbiAYA@mail.gmail.com> <ZtXJGzse8CN30Cp3@Boquns-Mac-mini.local>
In-Reply-To: <ZtXJGzse8CN30Cp3@Boquns-Mac-mini.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 2 Sep 2024 16:19:25 +0200
Message-ID: <CAH5fLgg9ntk4Zn-kBB-XLHaqHz4NXNhrS526HahBG9T2MhUx5Q@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add global lock support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 4:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> On Mon, Sep 02, 2024 at 01:42:53PM +0200, Alice Ryhl wrote:
> > On Mon, Sep 2, 2024 at 1:37=E2=80=AFPM Alice Ryhl <aliceryhl@google.com=
> wrote:
> > >
> > > On Fri, Aug 30, 2024 at 3:22=E2=80=AFPM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
> > > >
> > > > On 30.08.24 07:34, Alice Ryhl wrote:
> > > > > On Thu, Aug 29, 2024 at 8:17=E2=80=AFPM Benno Lossin <benno.lossi=
n@proton.me> wrote:
> > > > >>
> > > > >> On 27.08.24 10:41, Alice Ryhl wrote:
> > > > >>> For architectures that don't use all-zeros for the unlocked cas=
e, we
> > > > >>> will most likely have to hard-code the correct representation o=
n the
> > > > >>> Rust side.
> > > > >>
> > > > >> You mean in `unsafe_const_init`?
> > > > >
> > > > > No, I mean we would have `unsafe_const_new` directly set `state` =
to
> > > > > the right value and let `unsafe_const_init` be a no-op.
> > > >
> > > > But how do you set the right value of a list_head? The value will b=
e
> > > > moved.
> > >
> > > Right ... we probably can't get around needing a macro. Can statics
> > > even reference themselves?
> >
> > Looks like they can:
> >
> > use std::ptr::addr_of;
> >
> > struct MyStruct {
> >     ptr: *const MyStruct,
> > }
> >
> > static mut MY_STRUCT: MyStruct =3D MyStruct {
> >     ptr: addr_of!(MY_STRUCT),
>
> I'm guessing you're using nightly or new enough rustc, in the current
> stable (1.80), this would complain using static mut without unsafe:
>
>         https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=
=3D2021&gist=3D2954daab193caf14d1fb91492dcf325a
>
> , which gets changed recently:
>
>         https://github.com/rust-lang/rust/pull/125834

That's a trivial matter. Adding the unsafe block makes it work on stable.

Alice

