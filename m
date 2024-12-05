Return-Path: <linux-kernel+bounces-432872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA709E514A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F4B286280
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9DD1D5CC2;
	Thu,  5 Dec 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=benoit@dugarreau.fr header.b="spsw8HwE"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD41D5179;
	Thu,  5 Dec 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390887; cv=none; b=AtMvXYfz3yX/Surnv2m2cS3+sOElyOIC0D0hUv/h6bor0RaPwTvxe2PXRFt8Qacg9LyJR0eQemmZnC8dHsEpI0ro64/oFdBNsqO9GdalcSjrrMIsPbcYSDBmBva1eSkhbHaBu8zzkGGyUL0mfvKe/QjgvcWG55CG40CpJnJOlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390887; c=relaxed/simple;
	bh=9VnhS4rWQUvpCvvqLD3tS7DsrdZ/LMYOWMp4kty4Hfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpJHKx5TTOD6IbTyLiLYrdg8CLGS5/nfUByqsRlgevZEXv7BwWTTWMxVpzB0VnRLCMvjERThDMW0xXJRU/9OYpWAHH03BqrAPSuNflK/++NpH8zMiFN3Z4AuKxS10N3RbN4apteMVzEmCze9Ili1ljUP3tOf9y6DUiI4n65wO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dugarreau.fr; spf=pass smtp.mailfrom=dugarreau.fr; dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=benoit@dugarreau.fr header.b=spsw8HwE; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dugarreau.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dugarreau.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dugarreau.fr;
	s=s1-ionos; t=1733390878; x=1733995678; i=benoit@dugarreau.fr;
	bh=Rm4UhrUgzrcYIaJ//FNv6eLPnSRc/tJECUXLUl0t0Os=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=spsw8HwE/HS7h17yT0W3tbkhqe+7cxeMNJ69ptvNAYFBQ9YbLletvrMAngwddAqP
	 NWBHLMy+GKtdmE4oTpgH4QUQhwOYF1crNUgjaEODb50D6MVOVmxEaKTXTy1khAHZc
	 GqlKWHkrXVRXYJUkQXYQ4ea82IUffVD5CMFphDa1YOdXVHx+fATF/wjcNfrf+LzPN
	 9M0gOEd61UAql7NL+9p8jcazFMG7Jxy4Vd0qbSk/d7rn7sFQg+AC+dfQARM23p6HA
	 Se7m/WaeMjHk+9tiuTC5nZjc88CQFyy/Mj3kWAHmxTkDERKhBLdx5IqXvJaCPl20t
	 dshakiC3+4kiouh9hw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from debian.hades.lan ([185.116.133.150]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1MCKSA-1tSRjb41Tu-005xw7; Thu, 05 Dec 2024 10:22:14 +0100
From: =?UTF-8?q?Beno=C3=AEt=20du=20Garreau?= <benoit@dugarreau.fr>
To: Lee Jones <lee@kernel.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20du=20Garreau?= <benoit@dugarreau.fr>,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] samples: rust: Provide example using the new Rust MiscDevice abstraction
Date: Thu,  5 Dec 2024 10:21:35 +0100
Message-Id: <20241205092135.48978-1-benoit@dugarreau.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204174627.1151288-1-lee@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SZh1JFRhAxHNjNlr0D8jkqdozVdcewZFimxgKhA80sjVfNGNelR
 xVnBYz6uULZrGReEcqQPbHcbhp3yxjLfEm+SHFbwYgMSPLusXEeMq2FNoraxDwnqcENkJWT
 hDxZbf+seHKNfGxWmNq+y2n6dbM71/hvndSYb6nmhBTvLbQ+vpGAGDJl1xTEXrCCFoYjdNf
 W37vtoPqL0Xy63opHEpbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J5Enrao+g1E=;Vv2HM8fTQEsPYk/k8yEv4fD8w2l
 7hFIxQ6sY/fW5F4/qhXRmWOPR85PFv7Y6DnqzPPqpIdYIoevaeU/5s+TTaewjLIQ8ZbgSCijE
 QFhozaxDZdRAbJMrf+8zIqLmVobnzmtDts30yxYK6qHl621kDMaCywJqD7+Qu+N41TtTTIguc
 IW27+XAgSpQAuv+NhDCmnj2wNki/roT6YcqOsXOOc22CLyDzUnz7scEb5cx0Wah2ox+rVKWMu
 hWmgPXfLA/XEvrimoYv2IjKqzxzfQu3SinoBqj7soL8Cgq1uYIhaDn0A2DqBTBI2me0wrORuA
 qG2tpLFqKQmLsTt3VB+icyK0Zm29b1vsZNh/FM7EYSKFBGPqwx47sWDmNd+rNk6ykQo9yUxbY
 Kt+rTUpkKrF6vy0O51GPgy3J/fYrfUvphlxVLrTydIX8rLf+6dq+gVwpM3yYYqtdAXM63duuf
 cxC5QtifGsLm6X3tx2QjILMfrzZGG8TZm9zZBXXJ9M//d0wWmTcIi8s3fKvCTmx+XPT6dvwbc
 L9Bx/K3sx2E/tURsz+0wMynhwqG2k+bagfH98vqPWLoJJOR8pFawvadlg3RJUQ+6TT9yc+5fi
 nf+PhcHefURPi8dDbV7Xnp391yxWb7w9xzaykASDen0fR8CrUxAVhQXqsef2n+JozPbhx13Pt
 zjb4q1NQqUKEfmcM6TTk+lGFFhybsDedpF66LTXLgbgMNfm0x2juSqTE/iMusEvjFlMjeaeds
 f0rkiFZjcH2OyUM2P49dyePE+wx7v8OQN2rrwv4jjoFWVym3HOdmSbD68U3z61FDrORX1wyY5
 5R7tgJ/YVMJnxTbLmpwKDge8UwjA21D6XrdV4gE6saiZ32HqW/NoVefJ1hykA7XgQUPF6IkBX
 dn9SOb06yzOOkZHBfgwQakRBDz3ZbV0LTv6kmcrYrcVWoQ62qcaTrO63FLjKhcOjecZyOZlLv
 UVNhFxn1qzUS1X+zPb2nzKcAhLeoSkSDszBJ9zxLqgNrdeEXtVGK+W/O5wO3+NTb9OpnoxxwB
 4Rh//EE9j0DgsvFAlpp23pHBUWDBzDwysjGyqaE

On Wed, 4 Dec 2024 17:46:24 +0000 Lee Jones <lee@kernel.org> wrote:

> This sample driver demonstrates the following basic operations:
>
> * Register a Misc Device
> * Create /dev/rust-misc-device
> * Open the aforementioned character device
> * Operate on the character device via a simple ioctl()
> * Close the character device
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  samples/rust/Kconfig             | 10 ++++
>  samples/rust/Makefile            |  1 +
>  samples/rust/rust_misc_device.rs | 84 ++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 samples/rust/rust_misc_device.rs
>
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index b0f74a81c8f9..df384e679901 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
>
>  	  If unsure, say N.
>
> +config SAMPLE_RUST_MISC_DEVICE
> +	tristate "Misc device"
> +	help
> +	  This option builds the Rust misc device.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_misc_device.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_PRINT
>  	tristate "Printing macros"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index c1a5c1655395..ad4b97a98580 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -2,6 +2,7 @@
>  ccflags-y +=3D -I$(src)				# needed for trace events
>
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+=3D rust_minimal.o
> +obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+=3D rust_misc_device.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+=3D rust_print.o
>
>  rust_print-y :=3D rust_print_main.o rust_print_events.o
> diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_d=
evice.rs
> new file mode 100644
> index 000000000000..5f1b69569ef7
> --- /dev/null
> +++ b/samples/rust/rust_misc_device.rs
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust misc device sample.
> +
> +use kernel::{
> +    c_str,
> +    ioctl::_IO,
> +    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration}=
,
> +    prelude::*,
> +};
> +
> +const RUST_MISC_DEV_HELLO: u32 =3D _IO('R' as u32, 9);
> +
> +module! {
> +    type: RustMiscDeviceModule,
> +    name: "rust_misc_device",
> +    author: "Lee Jones",
> +    description: "Rust misc device sample",
> +    license: "GPL",
> +}
> +
> +struct RustMiscDeviceModule {
> +    _miscdev: Pin<KBox<MiscDeviceRegistration<RustMiscDevice>>>,
> +}
> +
> +impl kernel::Module for RustMiscDeviceModule {

This could probably use `kernel::InPlaceModule` and avoid allocating
the registration.

> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Initialising Rust Misc Device Sample\n");
> +
> +        let options =3D MiscDeviceOptions {
> +            name: c_str!("rust-misc-device"),
> +        };
> +
> +        Ok(Self {
> +            _miscdev: KBox::pin_init(
> +                MiscDeviceRegistration::<RustMiscDevice>::register(opti=
ons),
> +                GFP_KERNEL,
> +            )?,
> +        })
> +    }
> +}
> +
> +struct RustMiscDevice;
> +
> +impl RustMiscDevice {
> +    fn new() -> Self {
> +        Self
> +    }
> +}

Given that this function is nearly empty and removed in the next commit,
it could probably not exist in the first place.

> +
> +#[vtable]
> +impl MiscDevice for RustMiscDevice {
> +    type Ptr =3D KBox<Self>;
> +
> +    fn open() -> Result<KBox<Self>> {
> +        pr_info!("Opening Rust Misc Device Sample\n");
> +
> +        Ok(KBox::new(RustMiscDevice::new(), GFP_KERNEL)?)
> +    }
> +
> +    fn ioctl(
> +        _device: <Self::Ptr as kernel::types::ForeignOwnable>::Borrowed=
<'_>,
> +        cmd: u32,
> +        _arg: usize,
> +    ) -> Result<isize> {
> +        pr_info!("IOCTLing Rust Misc Device Sample\n");
> +
> +        match cmd {
> +            RUST_MISC_DEV_HELLO =3D> pr_info!("Hello from the Rust Misc=
 Device\n"),
> +            _ =3D> {
> +                pr_err!("IOCTL not recognised: {}\n", cmd);
> +                return Err(EINVAL);
> +            }
> +        }
> +
> +        Ok(0)
> +    }
> +}
> +
> +impl Drop for RustMiscDevice {
> +    fn drop(&mut self) {
> +        pr_info!("Exiting the Rust Misc Device Sample\n");
> +    }
> +}
> --
> 2.47.0.338.g60cca15819-goog


Beno=C3=AEt du Garreau

