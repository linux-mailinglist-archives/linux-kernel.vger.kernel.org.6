Return-Path: <linux-kernel+bounces-435104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59169E6FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6534016E867
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B264F20B1F7;
	Fri,  6 Dec 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvYoSDKS"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591E207DF9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493455; cv=none; b=mis1S68LWolhKkbO8PgCm3xOKC3SXQimxZUdmLaOni+c74ZpM4SeWx85svRiNo0uLxzoRiQZSLEmzNkkmgrL3K1rHOUjUkMby6zK7aPgNLfvSVqgYWOB0/N4dziIb7cbjLfQx+F8DBcLLdQelp1yK7ydBOdnFjnVuQVIzSVaEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493455; c=relaxed/simple;
	bh=fiLpHl8kskZJf92XZBCQSNQh0EM/rPino4TCddjjNa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh+zQ6PSbbz4kXE/PmRPk+kEyqJkbDQsjLy7kZO9beVTp2NArO9eJ69iEGZ5ojQ7HcLq17LXSRjzMiDtj1z1pOwwQihE1aVtopr7f1C+CjJocrcRhhtye67Y6VFvmfL8tgnIumW21oZRWA7u0Up2YBaIU5XdmlSUp2gGKgxo4DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvYoSDKS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385df53e559so1553592f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733493451; x=1734098251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDyT0nGxXbja5Q8/labpY0AGckKUvtd7GbprKAY57M8=;
        b=AvYoSDKSCLxYr2qJ9WJYdJyxNdwdVzH2QpufLN34unghI9e48l4BdxZcLRoBFcWYcB
         cbLgeg4nMqqCFrq4Uin8fFmFtKSiiQWLAndZGnMw8jf8jcvA4c9uB8zezR61m85Xwjt9
         eAhkuUdh8u98jKE1CteId+lUsz8MCwORlo93OGUdd/Vi6Wq+U1bTDuWn2PE943AOmAzk
         BfMAXxWdiNiCYYBQo/DN94/UNZ0PdU9MeTd9KU7lx0llZkLJGpy7NaEs51bCdAVTkLf0
         jgBzRuZh8pEnBcWXeiayq+g08pYDKfRnUd/zAxkuyvZUfXd08R4R0WifhsEPLApu0HkR
         76Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733493451; x=1734098251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDyT0nGxXbja5Q8/labpY0AGckKUvtd7GbprKAY57M8=;
        b=GZiqT8hl5I6d8HIycg6ZV+zbphI4pfr9cYWzv7McbSAOR5qiVT5FI9E5Kq+pew0r0u
         Q/xHGfnGrysU2seKD2RUN4FJoQWV6vJHO13qLIJD8nv/HcXw475YrJJbJOHZx2DJ66o0
         mEhBLBYYh0pUkPH4rrJErI6VnqXlWYIJfVfSMDNj1oZ7WBQE0+ZWKHq1hTnp4Q3UIq+g
         pALJWAs/RD811lqhFFNNPJ3NH3jJyT7lqjL7t4baCCDwpJBxl8MweVEruJLUkGD7BqK8
         2iHU4l92CMfKjIRpURt78WPYIPNNmbEvTUDhbZi1/Xmi6eXDf0D2kWOv1SD38DhrIRLw
         K3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXsogI9QAazUT30oh1Mb6UWQBxADC5dMXL08IlDFTpMealNmlvGIQz76NeuDkIfYLht9DH119M3NB+zwX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXdXgtUuesBtRk4Q5ib9VAgNMfip36XNcahzK3uac9DDgA6Xn
	0D7SELF2w3TwtaYwvDHNKaDPDIY5VNj5rPsqedEGgldY+mLK4XxiD6dQNFWP7W99/PmF5j8LhW+
	byekivpOzoOSaRvRIm1lczb+Igctnxos/0H8/
X-Gm-Gg: ASbGncuj2Oipl5wibzzd6jIK0KSNDvh9vql6qLdJScJGpr5xMaAOJLq2vUnPl114qOa
	KGVREdR2LUK76yELUQhdV1Az4E/dJNS4Y
X-Google-Smtp-Source: AGHT+IFVl6C+eSFuu9yGxEcfzxTahR7P+lh22t4H7dnq5rZTDhoIXpqQ/0j5yDdZDKZ/gkNWcTIdlAv15QqNAyld/Ak=
X-Received: by 2002:a05:6000:2cd:b0:386:2ebe:7ac9 with SMTP id
 ffacd0b85a97d-3862ebe7ddemr1414917f8f.33.1733493450776; Fri, 06 Dec 2024
 05:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205141533.111830-1-dakr@kernel.org> <20241205141533.111830-3-dakr@kernel.org>
In-Reply-To: <20241205141533.111830-3-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 6 Dec 2024 14:57:19 +0100
Message-ID: <CAH5fLghRVFAb06YYfUbuyuR1pOK0cHzGk6A25c5hX3CyvMm+sw@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] rust: implement generic driver registration
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:16=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Implement the generic `Registration` type and the `DriverOps` trait.
>
> The `Registration` structure is the common type that represents a driver
> registration and is typically bound to the lifetime of a module. However,
> it doesn't implement actual calls to the kernel's driver core to register
> drivers itself.
>
> Instead the `DriverOps` trait is provided to subsystems, which have to
> implement `DriverOps::register` and `DrvierOps::unregister`. Subsystems

typo

> have to provide an implementation for both of those methods where the
> subsystem specific variants to register / unregister a driver have to
> implemented.
>
> For instance, the PCI subsystem would call __pci_register_driver() from
> `DriverOps::register` and pci_unregister_driver() from
> `DrvierOps::unregister`.
>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

[...]

> +/// The [`RegistrationOps`] trait serves as generic interface for subsys=
tems (e.g., PCI, Platform,
> +/// Amba, etc.) to provide the corresponding subsystem specific implemen=
tation to register /
> +/// unregister a driver of the particular type (`RegType`).
> +///
> +/// For instance, the PCI subsystem would set `RegType` to `bindings::pc=
i_driver` and call
> +/// `bindings::__pci_register_driver` from `RegistrationOps::register` a=
nd
> +/// `bindings::pci_unregister_driver` from `RegistrationOps::unregister`=
.
> +pub trait RegistrationOps {
> +    /// The type that holds information about the registration. This is =
typically a struct defined
> +    /// by the C portion of the kernel.
> +    type RegType: Default;

This Default implementation doesn't seem useful. You initialize it and
then `register` calls a C function to initialize it. Having `register`
return an `impl PinInit` seems like it would work better here.

> +    /// Registers a driver.
> +    ///
> +    /// On success, `reg` must remain pinned and valid until the matchin=
g call to
> +    /// [`RegistrationOps::unregister`].
> +    fn register(
> +        reg: &mut Self::RegType,

If the intent is that RegType is going to be the raw bindings:: type,
then this isn't going to work because you're creating &mut references
to the raw type without a Opaque wrapper in between.

> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result;
> +
> +    /// Unregisters a driver previously registered with [`RegistrationOp=
s::register`].
> +    fn unregister(reg: &mut Self::RegType);

I believe this handles pinning incorrectly. You can't hand out &mut
references to pinned values.

Alice

