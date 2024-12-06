Return-Path: <linux-kernel+bounces-435108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9189E6FC3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A539188282E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD5A207E0C;
	Fri,  6 Dec 2024 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDIhXhw4"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71999207DF9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493696; cv=none; b=i4NFn9zySErDbSk8KxiZRVVtwEb1AuPtu+FnHdagA8OW1OQvO6gbO9wtMJRX0IcbBYN4zsmBtjHWThNYsr6D2jft6ihm3OOkEw4JWfLERmJYf3u+JakwX+u5Wl7YOC5Wg60XwTyHnfAMwwW3znzLQlisaNr+c62rrVhou4PYPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493696; c=relaxed/simple;
	bh=ztPyo3yGt6f1hEMGIcmrfUZRowJBSTmCSEvYULhwgIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaI1HPt7R/UkqKb5xjFRcOqEPAJnyIy1zlx2ddZNb0hBX6JEOE9ITA1Eze8BpvR9I+s5aJ57amc2jqRHAUG8jKHD0O1zPKyRgrWIxJV3yZTQTgw4ax7UjZeIfurQURzz5+WGU/Eu2gEwR8br4H8roX0BabAbnSvy8QXFp1dxkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDIhXhw4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so382127f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 06:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733493693; x=1734098493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIROnSpI7QIsIhdgjfBPj1aXSKLxengS8TtSGx06igQ=;
        b=mDIhXhw43Q9O+B8djqlmEMzF9SVSh8Pvrlt1yiqCLy+hbqNvThz6cOotnXdnXR9Rmd
         GULhRHCQot/gDpsJiQw8JXPnXozdaEhwM9cYf2xK4NnvHYJu/u0WL1LB3/I2UdEs55tR
         6aekZ8ZbxT5nrOCxYxTx1uhQY2PJ7sRlHr1RK/vo/gpxPHSZ5ruMZQa7y+Xc/dbMQpJt
         RgNnjAKw4iHdsBRniVwK58Ar7WvpbjxbzqJkYUQFJ99q4ysilIayuyHx64s1oXTNDMFS
         /B2C/z2j13m/WUkhRTw7WagPYknOSQ3JMNtowLnTs8sGkvmoYX1n0JNvSRJDurw++u0m
         mUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733493693; x=1734098493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIROnSpI7QIsIhdgjfBPj1aXSKLxengS8TtSGx06igQ=;
        b=tcML+BswakLJVQv9CSzzRjZDEEeJ6s/OgMC1x98bxMEN66sDB2Qq7V6iw9UeBg+fBO
         oP5h2tTQY1yPbm5f3zgUoDlQXHUXwa/czEIugoA8LCLR3KtT+dulCuCsJsDb2JJ2obf0
         hn9ZyTRYlOGS3cG8GppLSr4ahTXK8e0+kxHIJNXQ4E8Mib+1UoeBeq9VyOTLT2mmtsWQ
         6LooHJkGXam+xVj/WeO/J4afzpkJm4Yji7/qL7dvwfS0qgohAzL6Uvjsh9xKJumjddE0
         wrz0pj3+xrGLk7gxTUFHQuCr0ITvm2Xfr1G9mpKe6JaZbAUv5x9s0ME1Xxc9rHiTaChb
         2TpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO0UlnYFusFaOStl7gWkwfCeQNwxhUTwJ412NWvhy3JPx45hr9d+BuA5F01zzywQP+MSeCPOtCTb+JBlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuemPGwP/CKCXKGnc+o0pBAfgdHqefOKTwhTN3YYKo+c7G+vDb
	nCzCStA2xO66CJWoXrW0VOsHtQ8NrYke3szMP4a9vBY8/6EGzbC6Luot/24tutxBRr+wSKdQyTY
	qFOilAUc4KvbmzO7v05orIs6Si+zUIosfL8Ma
X-Gm-Gg: ASbGncs/qM9tFhGPiOP0y6yfrGNQqiapn7oCxGzeIrzEw2KdoGWxoDj8gFAbzzmXX9v
	Lg3uAI/EOETsaxbd6c0+SIXXAzClhY0uo
X-Google-Smtp-Source: AGHT+IHLpOzFOhY4mfA0Js1CKJtdFnnaFfAgbZ1a1gRtRIpN5wpQ0aUSs985OPEDReg41RO5SuCiAM0IAzD3hXlS/+o=
X-Received: by 2002:a05:6000:402c:b0:382:45db:6a1e with SMTP id
 ffacd0b85a97d-3862a8b30c2mr2623645f8f.14.1733493692399; Fri, 06 Dec 2024
 06:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205141533.111830-1-dakr@kernel.org> <20241205141533.111830-9-dakr@kernel.org>
In-Reply-To: <20241205141533.111830-9-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 6 Dec 2024 15:01:18 +0100
Message-ID: <CAH5fLgh6qgQ=SBn17biSRbqO8pNtSEq=5fDY3iuGzbuf2Aqjeg@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] rust: pci: add basic PCI device / driver abstractions
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
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:16=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Implement the basic PCI abstractions required to write a basic PCI
> driver. This includes the following data structures:
>
> The `pci::Driver` trait represents the interface to the driver and
> provides `pci::Driver::probe` for the driver to implement.
>
> The `pci::Device` abstraction represents a `struct pci_dev` and provides
> abstractions for common functions, such as `pci::Device::set_master`.
>
> In order to provide the PCI specific parts to a generic
> `driver::Registration` the `driver::RegistrationOps` trait is implemented
> by `pci::Adapter`.
>
> `pci::DeviceId` implements PCI device IDs based on the generic
> `device_id::RawDevceId` abstraction.
>
> Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

> +/// The PCI device representation.
> +///
> +/// A PCI device is based on an always reference counted `device:Device`=
 instance. Cloning a PCI
> +/// device, hence, also increments the base device' reference count.
> +#[derive(Clone)]
> +pub struct Device(ARef<device::Device>);

It seems more natural for this to be a wrapper around
`Opaque<bindings::pci_dev>`. Then you can have both &Device and
ARef<Device> depending on whether you want to hold a refcount or not.

Alice

> +impl Device {
> +    /// Create a PCI Device instance from an existing `device::Device`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `dev` must be an `ARef<device::Device>` whose underlying `bindin=
gs::device` is a member of
> +    /// a `bindings::pci_dev`.
> +    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> +        Self(dev)
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::pci_dev {
> +        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to=
 the `struct device`
> +        // embedded in `struct pci_dev`.
> +        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) =
as _ }
> +    }
> +
> +    /// Enable memory resources for this device.
> +    pub fn enable_device_mem(&self) -> Result {
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> +        let ret =3D unsafe { bindings::pci_enable_device_mem(self.as_raw=
()) };
> +        if ret !=3D 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }
> +
> +    /// Enable bus-mastering for this device.
> +    pub fn set_master(&self) {
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> +        unsafe { bindings::pci_set_master(self.as_raw()) };
> +    }
> +}
> +
> +impl AsRef<device::Device> for Device {
> +    fn as_ref(&self) -> &device::Device {
> +        &self.0
> +    }
> +}
> --
> 2.47.0
>

