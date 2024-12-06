Return-Path: <linux-kernel+bounces-434751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB129E6A9A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F1016CC5A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC021EF0B5;
	Fri,  6 Dec 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVoth1r+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E11EC00A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478039; cv=none; b=mXFPDGR0xrUQuWFWt77UdZD+GcM0vZSK2MR/BByXo+JTqTXmSHSZ62LNcqC6rPBUdryk8wI9OG8qgzc46xebF01R7pLHbJMuQ5o9F5epXiXV5GUvgnJOogGuOPAw7UpYLMEMyB2CYXg5e9ER8u+ysEzdkM7RysTdMrz7j1qrh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478039; c=relaxed/simple;
	bh=TWS54qtWOUt4tbtkhVNM5u8s8m+lfvjSfdulgwfehLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBM5ungWm1clKIjIvaIQlrwZE0kuWQFpmPaC1kWRaSlEnF0N4iWeNDFp849CjXEKbduchEr8iTz8DWGcUWNk87V1Wi03T5onkJAue4W8k88Q2YQQMx6G4NM9ZSpOHo4Rk9BJ7nuIQPgd4ShMsrTmot9zkJO7bADZxn9utGN2dZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EVoth1r+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434aa472617so12897535e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733478036; x=1734082836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roDsf5JZ69Vb0EVMiFOCplKdqH1R39suO8gspINBAFY=;
        b=EVoth1r+EngQHyeBKzqdF2ba4dNWoeWjblIfn+14BjwS66sBNHaZ8DiYRoDrvrRmNj
         wQliKUTfzWAk0ZK/0/4klWu1qQhY0OszO5LciQYmCkCmoMyLaGRKqzadAE0gKVPN/4Yn
         CbGPdlDx01xphe4bWdi3e6W5CCGh+8DBLGiYrjBUM8mWkFSfxORWOhLpW2TgZ8qsvm6+
         BT0Zu/Ax+ZVIOIq9dg8pwm/dX+HAB6hKL8uxrCD+g5aEDkoeS+kpXvSl0O8eJih7oxEn
         +n7Gtp/lbWozq5PEl63o9ychjckhj46sNvpoK0EQNDdQuq5ZcnlL65xOxCbVj5nQxY8Y
         8BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478036; x=1734082836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roDsf5JZ69Vb0EVMiFOCplKdqH1R39suO8gspINBAFY=;
        b=QT/EoL/Z9ooK9iDYJR3LnIUy8JGl+vv5xKswwxi6ObBSUt752zHP6gR1470M6XWvGY
         sALkxkM3gRnHfY7+bpmvkRtqwf02kN1J+1kL5i3pTyInXK8s1WEukqsb0Swm3C9ehvH5
         mKn/09kq1lPcup8a0cM62mqFHGU+Q8ajyT71xC0D7+AiEWLFDv/zuODSsr2pPkql863B
         VJBf3+DZyX7Th3C7uYS+qISwYSKdmhUCqyfeQtdum+vSe6GUMWGphtzDQzpU6CBiO/Df
         9BYhZUUP5joAHjLA6nWcPBCyCf1xhFUsljjSaVcjFbN8xEmTTOneEAY4yg6vt5xj1VwF
         PjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbKNDfFT+LxoV3eTh4/rf3XZgwIfZOokOQNaQZqP1aak1KK6uZyzZgfI//8rluhPUs9nirSZr+f87cwkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbMqpj7hOJK5cnZgescU9Ml6MtE8+XXa/zsrfob92dGSRvGeV
	WG9JIYKzOsfqehTShoQJV2MepRJBRyi1vG75bQ/eGawkzdJQqTTA3czTQVWBJLmimThaaEa5wfT
	TkqAslM+bQd5/1Ef2otoEykgQY9hUsT6S8Z+L
X-Gm-Gg: ASbGncv78Dk9Rwg51gDkoPo6RpVTmOWdoAEDbqx4v+h97ev0snIxIJ4X4m0CAso/Cq0
	k5/3Jw4RxnoRaH5EA8TezjS7o0hsFbH6a
X-Google-Smtp-Source: AGHT+IFsWWSvAWLzPdhJb+M+fGJXNYBcqly8mjWF2TdF0iIoCLduCHfJWFjNVoFpOFvhxKnrXSbxSDlzlgGS+l5y3wE=
X-Received: by 2002:a05:600c:450b:b0:434:a7b6:10e9 with SMTP id
 5b1f17b1804b1-434ddeb9b73mr22189395e9.17.1733478035843; Fri, 06 Dec 2024
 01:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206090515.752267-1-lee@kernel.org> <20241206090515.752267-5-lee@kernel.org>
 <Z1LD42UsCvtAhluY@pollux>
In-Reply-To: <Z1LD42UsCvtAhluY@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 6 Dec 2024 10:40:23 +0100
Message-ID: <CAH5fLghS+foEe7mFVDpr+AbHkQmdkx-EH0jnq2SzH+rYQPiS2A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:29=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Fri, Dec 06, 2024 at 09:05:06AM +0000, Lee Jones wrote:
> > This sample driver demonstrates the following basic operations:
> >
> > * Register a Misc Device
> > * Create /dev/rust-misc-device
> > * Provide open call-back for the aforementioned character device
> > * Operate on the character device via a simple ioctl()
> > * Provide close call-back for the character device
> >
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  samples/rust/Kconfig             | 10 ++++
> >  samples/rust/Makefile            |  1 +
> >  samples/rust/rust_misc_device.rs | 80 ++++++++++++++++++++++++++++++++
> >  3 files changed, 91 insertions(+)
> >  create mode 100644 samples/rust/rust_misc_device.rs
> >
> > diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> > index b0f74a81c8f9..df384e679901 100644
> > --- a/samples/rust/Kconfig
> > +++ b/samples/rust/Kconfig
> > @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
> >
> >         If unsure, say N.
> >
> > +config SAMPLE_RUST_MISC_DEVICE
> > +     tristate "Misc device"
> > +     help
> > +       This option builds the Rust misc device.
> > +
> > +       To compile this as a module, choose M here:
> > +       the module will be called rust_misc_device.
> > +
> > +       If unsure, say N.
> > +
> >  config SAMPLE_RUST_PRINT
> >       tristate "Printing macros"
> >       help
> > diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> > index c1a5c1655395..ad4b97a98580 100644
> > --- a/samples/rust/Makefile
> > +++ b/samples/rust/Makefile
> > @@ -2,6 +2,7 @@
> >  ccflags-y +=3D -I$(src)                                # needed for tr=
ace events
> >
> >  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)            +=3D rust_minimal.o
> > +obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)                +=3D rust_misc_de=
vice.o
> >  obj-$(CONFIG_SAMPLE_RUST_PRINT)                      +=3D rust_print.o
> >
> >  rust_print-y :=3D rust_print_main.o rust_print_events.o
> > diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_=
device.rs
> > new file mode 100644
> > index 000000000000..3837532d259e
> > --- /dev/null
> > +++ b/samples/rust/rust_misc_device.rs
> > @@ -0,0 +1,80 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Rust misc device sample.
> > +
> > +use kernel::{
> > +    c_str,
> > +    ioctl::_IO,
> > +    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration=
},
> > +    prelude::*,
> > +};
> > +
> > +const RUST_MISC_DEV_HELLO: u32 =3D _IO('|' as u32, 9);
> > +
> > +module! {
> > +    type: RustMiscDeviceModule,
> > +    name: "rust_misc_device",
> > +    author: "Lee Jones",
> > +    description: "Rust misc device sample",
> > +    license: "GPL",
> > +}
> > +
> > +struct RustMiscDeviceModule {
> > +    _miscdev: Pin<KBox<MiscDeviceRegistration<RustMiscDevice>>>,
> > +}
> > +
> > +impl kernel::Module for RustMiscDeviceModule {
> > +    fn init(_module: &'static ThisModule) -> Result<Self> {
> > +        pr_info!("Initialising Rust Misc Device Sample\n");
> > +
> > +        let options =3D MiscDeviceOptions {
> > +            name: c_str!("rust-misc-device"),
> > +        };
> > +
> > +        Ok(Self {
> > +            _miscdev: KBox::pin_init(
> > +                MiscDeviceRegistration::<RustMiscDevice>::register(opt=
ions),
> > +                GFP_KERNEL,
> > +            )?,
> > +        })
>
> Since this v4 was sent just when I was commenting on v3:
>
> Why do we add examples where we ask people to allocate those structures w=
ith
> kmalloc()?
>
> `MiscDevice` should switch to the generic `Registration` type in [1] and =
use
> `InPlaceModule`, such that those structures land in the .data section of =
the
> binary.
>
> [1] https://lore.kernel.org/rust-for-linux/20241205141533.111830-3-dakr@k=
ernel.org/
>
> > +    }
> > +}
> > +
> > +struct RustMiscDevice;
> > +
> > +#[vtable]
> > +impl MiscDevice for RustMiscDevice {
> > +    type Ptr =3D KBox<Self>;
> > +
> > +    fn open() -> Result<KBox<Self>> {
> > +        pr_info!("Opening Rust Misc Device Sample\n");
>
> This should be `dev_info!`, but I see why you don't have access to the de=
vice
> structure here...
>
> @Greg: How do miscdev drivers do this in C? I looked at a couple of them,=
 but
> all of those seem to use pr_* macros. They can't get the device pointer f=
rom
> the inode or file pointer.
>
> However, C drivers could refer to the struct miscdevice directly since it=
's
> almost always a static variable in the file scope.
>
> In Rust we do the static allocation part with `InPlaceModule` as mentione=
d
> above. However, this still doesn't let us refer to the underlying struct
> miscdevice.
>
> This all would be much cleaner if there'd be a "fake" probe() callback fo=
r a
> struct miscdevice. This way we could perfectly align the miscdevice abstr=
action
> with the abstractions for all other drivers, such as PCI, platform, etc.

It turns out that the file private data is a pointer to the `struct
miscdevice` in fops->open(), so we can access it in open. To access it
in other fops hooks, we need to take a refcount on the device in open
and stash it.

Alice

