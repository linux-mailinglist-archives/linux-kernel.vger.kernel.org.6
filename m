Return-Path: <linux-kernel+bounces-403091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B423F9C30F2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 06:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B911F217D0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 05:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2F1148FE5;
	Sun, 10 Nov 2024 05:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSZEvRbB"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217A347B4;
	Sun, 10 Nov 2024 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731216018; cv=none; b=R+M0z2iBeURisdgomIAjC2I4QdQYsyueckV9cliL22DxmKnWnF21WelYvlEqP4mBg5QVRo5q5cxWAaxxeU4H9SQ1bs3oO1SQRgiT4eCmN1JOYhDhsh9hKQZDiZSqCQTfAv2gmtglXSBCLfaRT9ORPTDnjWJ9/weuYAA5s/Amm7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731216018; c=relaxed/simple;
	bh=8xvOmP/OYEyvHO4TANz2aDVksItr7L5o9Vm2hvqOU4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSpa7iKla0rZb0LTlNGVD7rMaL1YNLQjc30uq39Q/DwTRqadj+lHbWUvyBEZ29RM91WomFoW+BfUbG/aUyMBUcieBJfWnMrQxNHvPlD+oVjiyuAZVjcSe92YMART33fjB3JIR0iReQ4JyDgjXl4dzRXfkns+W4yspyVR0Ivxnbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSZEvRbB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a123f2eb3so52737666b.2;
        Sat, 09 Nov 2024 21:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731216015; x=1731820815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xvOmP/OYEyvHO4TANz2aDVksItr7L5o9Vm2hvqOU4c=;
        b=mSZEvRbBQhhT5K3+YObH6CsMm2WYjmDWGHT9JP+uHFkUbob5/cRdZabvXqRapr55mW
         1lzw2pglZCvjN/C36X7emXe4VQBDa3aaYeqo361ue4GRmnEoCIAxsvFxMBlLjQaqmrk6
         dN3Lqj7D6pvnsuW1KmVVoUHkM98WHjH92o8RHbX9x3u0I5ixDlTzjJQeBY7eY3qm7ZIH
         lTSd6yeo08gFZvlgtC3pisI17rUH9jbMVI+VNhH3uNKOEAvVY0O5J0Owm2qdP/ulyY4T
         mXpEmZHNwvc8+CyOoRScWRTUcmKcHDysutkaTvyl9AbyyleI7a7rk4ThksjX3XwySApr
         xK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731216015; x=1731820815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xvOmP/OYEyvHO4TANz2aDVksItr7L5o9Vm2hvqOU4c=;
        b=Oy3oVcnaRR7KlTnIbX0R1S4O6Aob+YvH6ZyjfaSo9DvqVkYxtM/HX/ojAXhKI9D1X0
         JQkllyuvr9q/+c0r0+hB+LlyuYjz0izmTPdy0sM6lWSnf4ENtQKx97OlLF+zeBD4R3oP
         MldJCdEvVSGWjNpeKugAqk5b9472oF1zJbc7Ps29fEkpKsj85cJzJXXVaFwTHba2wzTh
         p2Vma0jj8yJDJfB8NBlvrRZ+j9q7cG4PPGSgY2u7Qzgo4muywYd7KnPWCvb2WxuTuIrw
         Rt1Yebj2bw0tngshBxj/e6j3gKfCkxI0wxYtEqAecmvNJLxrDupz5uKSaBouhn02Q6Be
         xxug==
X-Forwarded-Encrypted: i=1; AJvYcCUtMQv7kJYM5EH+476ZC5KlkxAqRTyTNC+iWvnsY41dU9ev/k0SUYP38uWcQ4QLoaOeEybzF3v5VcQSl+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSJ7LupwpVo28vyxv12J0f09vSYikNZiyjUzaQZ/NE0JKoVVs
	4GByqMi6CdIz81vYgoSXjO2pha88iZe29pbWFt/obokApkCDdu7WAMRj55igHUJUlHHTRjSTGx8
	QKT7hXpS29srWIqcvZfCftqD03C0=
X-Google-Smtp-Source: AGHT+IEs4ltig60xPPQ5pn3fKZ6peoNzUyb2QBDLU9q7H5QoZdYWWnxSJ0/oo55TLWwdO/CPq22Lxw6UlG+L/DVZ4EE=
X-Received: by 2002:a17:907:7b93:b0:a9e:b471:8508 with SMTP id
 a640c23a62f3a-a9eefccd4e1mr268735066b.0.1731216014677; Sat, 09 Nov 2024
 21:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109055442.85190-1-christiansantoslima21@gmail.com> <C0A689E8-4192-4851-9650-5B76F5A30086@collabora.com>
In-Reply-To: <C0A689E8-4192-4851-9650-5B76F5A30086@collabora.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Sun, 10 Nov 2024 02:20:02 -0300
Message-ID: <CABm2a9e9PnZeH5ZkifNJm4o0TRbfx5c8V=h23a3WO6Urw-9TFA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: transmute: Add implementation for FromBytes trait
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, ~lkcamp/patches@lists.sr.ht, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Daniel! I didn't know. Thank you in advance, I'll improve in v4.

Best regards,
Christian

On Sat, Nov 9, 2024 at 8:33=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> +cc Abdiel
>
> Hi Christian,
>
>
> > On 9 Nov 2024, at 02:54, Christian dos Santos de Lima <christiansantosl=
ima21@gmail.com> wrote:
> >
> > Add implementation and documentation for FromBytes trait.
> >
> > Add new feature block in order to allow using ToBytes
> > and bound to from_bytes_mut function. I'm adding this feature
> > because is possible create a value with disallowed bit pattern
> > and as_byte_mut could create such value by mutating the array and
> > accessing the original value. So adding ToBytes this can be avoided.
>
> I=E2=80=99ve read this a couple of times. It=E2=80=99s hard to understand=
 what you=E2=80=99re trying to say.
>
> There are some grammar errors, but the even the key idea is hard to under=
stand. IOW,
> I had to go on Github to get the extra context needed to understand this =
part below:
>
> > possible create a value with disallowed bit pattern
> > and as_byte_mut could create such value by mutating the array and
> > accessing the original value. So adding ToBytes this can be avoided.
>
>
> Also, core::simd::ToBytes? Maybe Bjorn meant a new kernel::transmute::ToB=
ytes trait?
>
> Christian, are you aware of Abdiel=E2=80=99s dma_alloc_coherent patch [0]=
? How is this patch
> an improvement over the simpler code below, for example?
>
> > + fn cpu_buf(&self) -> &[T]
> > + {
> > + // SAFETY: The pointer is valid due to type invariant on `CoherentAll=
ocation` and
> > + // is valid for reads for `self.count * size_of::<T>` bytes.
> > + unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
> > + }
> > +
> > + fn cpu_buf_mut(&mut self) -> &mut [T]
> > + {
> > + // SAFETY: The pointer is valid due to type invariant on `CoherentAll=
ocation` and
> > + // is valid for reads for `self.count * size_of::<T>` bytes.
> > + unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
> > + }
>
> I believe that most users would have a pointer to memory allocated on the=
 C side, as you can
> see from Abdiel=E2=80=99s excerpt above. Without a user, it=E2=80=99s har=
d to know why we need this, specially
> given the simd::ToBytes bound.
>
> Just my 2c.
>
> =E2=80=94 Daniel
>
>
> [0] https://lore.kernel.org/rust-for-linux/20241105104726.3111058-3-abdie=
l.janulgue@gmail.com/

