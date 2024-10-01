Return-Path: <linux-kernel+bounces-345778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3025998BB09
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46B81F22B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BFD1BFE0E;
	Tue,  1 Oct 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adaidGRe"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CEF1BFDEE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782151; cv=none; b=aALbghWkHERxGykhj8icCDTl6Ntqh0w3baSkalMhaeqvg71UEQX+kprg+HjBKAcd+JYxEMYPKJDxpc/rQ6QlkCD62ARFGM/ULXKZDLmH/68VSOzI0bU4RWkqRvp+N047qtXL+ujuPvYg8NP7ZEE/8yBo+QNllHAkjzxOES9e/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782151; c=relaxed/simple;
	bh=wRYe1vcQI0lZ4YwSx4XKpg3rYqAFEJunm9v7pgh1H1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc9ngRnUxHaYt8C7FYXDUMPZrUsLZcRoMzCvARKg/s+sS6A0g93vZFYrU6PS/aMJPhl86vjNaFiSJDq1hZdo7l2qx1EfiDuJPEiv2UAGmr9VzJkJcashoxj3V5inxvbGYNtb5KE5xtSRNXwDnbqYCGMlXbZPOgB+bUmxRaLyWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adaidGRe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37ccd50faafso3480303f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727782147; x=1728386947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0EGqao/z/3uTPQ94VdscyZy2iIMPcbVgjbB5vcmiAM=;
        b=adaidGReAMjv7H+AYMtEOGAOHxoiIgw7QQZ/eKSOTS7vYtqAECZfnWBAb/DFkAQrjG
         F2vEgnsC5R8VjAO5m5ttTytaPM1quKVO857VCyX7GmOsH31GS1kD9L+A6hTuauRYN/DH
         Jyp62jAjEfKt74PB4blJtCyxNzLFHiRb5f46P/QTg9k5WgmbZKtnnyaC1SqHwM6e1oUX
         nNmVjr5hkuHJLOkXUYhNIxN81iUHzBuSCsQoW3o0Gvk2jRqglISsd+C/iWZNWdrOt2jB
         5/00aD9cVV2H7v9m78cp3SG3gYFQOfo6lBTTAxEsCF38EaezACk9YwuJ3bJAUTi4h6NR
         Nu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782147; x=1728386947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0EGqao/z/3uTPQ94VdscyZy2iIMPcbVgjbB5vcmiAM=;
        b=SO/i1xcrx89N4gp1ho/PFAphYSOqXinMndeOulNHaCYtL4TTusNM5uOiZHvfEb5+dh
         tmxcG/hSQKctM5p4+M7qMvehZ3u2RnMYqhrWW/hnSZRYzGqDfI4EDvKUH6XbI9r9h/HW
         lyxIl/jSJPd4JxMqJR4/raC8GvlUFMcSfWa9ZgJGtj5LoerDvD2Y6Ub29pGmvv+SuBLK
         shKVvMleaU65dvc3GQgI8a5UM3Eyu24zuazRHv8kQ9sA+0f2KmCoutRcNP91D7iQjHpW
         HmG4YLj93EW/8bmKR1gIXLq1ZGrt62EzaIppzCNJS/QfbbddzlyUzOjq86h2IbV7+AJO
         d0fw==
X-Forwarded-Encrypted: i=1; AJvYcCWzrRNGvrrg4b9bA9mvosPeHqGnWv1u1j0udXENLGT2bGqaYuOG06mpiEEBOE5vsv1SXVVo/9W/rTlPUdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHfRfNGFXyDZxShffWA4v47b/vDqbIJNh89AhfIMeg/vUZlMl
	XkEX4PcYFK4awpDBwV4c/Hw112zeM8sADQJiQ+rukZIw+JveqwmTOFUQkViv+AGVMWbTDwCZdWV
	ag47XQZA3F+k2Uh+4I3JCiEz12PCvNibqeRxN
X-Google-Smtp-Source: AGHT+IHdJuezNC+cQOgCWdRYkNZbxrqMXbT01e/SnhIAXkrXy+UEqZN+0xO+ze21oJFFoxqcCO/UzF62jVvVTatBwGI=
X-Received: by 2002:adf:e709:0:b0:37c:ccad:733a with SMTP id
 ffacd0b85a97d-37cd5b3cc45mr8866453f8f.59.1727782147358; Tue, 01 Oct 2024
 04:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com> <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
In-Reply-To: <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 13:28:53 +0200
Message-ID: <CAH5fLgjCA77nAYqZLus7TWbW7mOKC1MKn+jJL-_tpQSR-h-r8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
> +impl<T: MiscDevice> MiscDeviceRegistration<T> {
> +    /// Register a misc device.
> +    pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error=
> {
> +        try_pin_init!(Self {
> +            inner <- Opaque::try_ffi_init(move |slot: *mut bindings::mis=
cdevice| {
> +                // SAFETY: The initializer can write to the provided `sl=
ot`.
> +                unsafe { slot.write(opts.into_raw::<T>()) };
> +
> +                // SAFETY: We just wrote the misc device options to the =
slot. The miscdevice will
> +                // get unregistered before `slot` is deallocated because=
 the memory is pinned and
> +                // the destructor of this type deallocates the memory.
> +                // INVARIANT: If this returns `Ok(())`, then the `slot` =
will contain a registered
> +                // misc device.
> +                to_result(unsafe { bindings::misc_register(slot) })
> +            }),
> +            _t: PhantomData,
> +        })
> +    }

Note that right now this can only be used in the module init function
if the registration is stored in a pinned box. We need the in-place
initialization change to fix that.

Does anyone want to revive the in-place initialization patch?

Link: https://lore.kernel.org/rust-for-linux/20240328195457.225001-1-wedson=
af@gmail.com/

Alice

