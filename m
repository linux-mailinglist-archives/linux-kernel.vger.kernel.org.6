Return-Path: <linux-kernel+bounces-435184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716D69E73FE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FD416E72E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B11720B807;
	Fri,  6 Dec 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+Hd4VsO"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150817C208
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498744; cv=none; b=qltrUUMu4s0zYkCFEuqY2ymj+b5Fv6di51yOlLmtO7NAhhXTNvOUObkvE3hk0zJElsSYUPVU28WRW6iTYTxTqGBmQfhrZWM80svcs8LrBvEq04U7AgL7nYIiDWy4zPFwOIZU/sZX4MKyW5M24KKLFxH45nCyj6phoRz7iOViacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498744; c=relaxed/simple;
	bh=YtRCwn0L0reKz/PCsHk5nYbtcK1nUJk/nFphVP0N18Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGMv44UF+YuegWgcM8zC7bl/Fqap3aVt7iXd2CVAEI1wIhRpoHCJl5GuvF0vVmMuOYpbalc3GJvCsQOPe6pLaBUaXbW57ix1p8P8qCSya6c71j69LvlJrRpVoWN+BaYmamV4pN1Pjp7eHvGybXOWolXIINIVV0dnWUdMDPMNv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W+Hd4VsO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e27c75f4so1723520f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733498740; x=1734103540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUl66/2q9Es7IH83i2VHQcZCXL2FkKLSft77+kwSp+4=;
        b=W+Hd4VsO8QYMsHWI6lgX0bOf9MvToZO1wmKypyeyzqNlGIU5wPpkE6/mRL3zhqJrEX
         vq1OPjZvD59KBakJvYfEGD0S82DHYSA3L9qblK3VYtrxnkYNkY5bXWudEYxgnDIzKTj7
         y4OwiHR3NL8r8zfFDlZY1WzKXOKjBtSkfcsQ/dlWdjGXghZSJqG4RRkOk+aps7rk18pH
         g0RRAvENYeaMxTsWMTYb4lI5R5oobOaXND/GT4lWv66K/Df3FuAggmcPb5d2V7HcILEQ
         AdbFFPX0y7B0DrF3bCfNQ0T7swqEQrSprGgV2noVfFfXOXnCq+5QIRMOgvbeeymwfqJ9
         iG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498740; x=1734103540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUl66/2q9Es7IH83i2VHQcZCXL2FkKLSft77+kwSp+4=;
        b=apPaBpgNElq5pTnHbVIO324PlzJYOqNJpmjWFieMDge53CHBasZnc+sr3IsiW9hXB/
         Q+DzjTpjbyn68NqyfIhESYUwbHFemSD3J89Yg1HiuO1B3z8hAn3lkmzThrHH9Avs9/CZ
         BgAQWvzSFRodiv3b1uGdkdU23O5Ulg5OXYD6SNaelVV4eytHSkjnmlB5m9euUMVyhKtA
         pxgQTt2e9eTpnKklz1UZMkTrO6zNUK1PrQomacSRDx4ORPSHxG8/um8tU2Dsswqk/FWN
         WuYLfnnG5p6mFuVwSkZZlUVue5I5riraAFhsoVYAZ/UwSTDw9G8z7+lFf2rzYNO+nVyD
         a/BA==
X-Forwarded-Encrypted: i=1; AJvYcCWognX1fS/DDwBazOw2Ur01BH8gAjl+NsWZuYH83VHmFKMTXw/PeFmFf+Bgkm0C6Wjim9IaGovA1KwHg9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAddtKn0ZPBflkS4l5uTW2ks/+b/0djlUs4bLgKJSqoMa8nDA
	AfvDrxEg5thJdNkwWzxGqOX7ZUBJ/DnaRLcu32owoH93WI8WG5BIP3PYu0oMFhLd1tFYdlGBVfI
	gQFnk7+Dw6B+2SajMPtVd1htFwMuuuUrP689W
X-Gm-Gg: ASbGncs7uZQ3TCsdnPizQbsIeH+RKLv6tU/zfgeoRpRq1N7I4fSVtGf7YZEegGYzYf9
	dL55coxKdsWcnscvRvWWJI6itYuhTOTQj
X-Google-Smtp-Source: AGHT+IFYizkoJZbVBGz6vm2wzIGh1sKlEnG59vyrJhpEUKD4My3ZUK6cpeBmwJvlu/MBEgYOtQCHyJ9kZroLKgAnFK0=
X-Received: by 2002:a05:6000:1886:b0:386:3327:9d07 with SMTP id
 ffacd0b85a97d-38633279daemr57136f8f.54.1733498740410; Fri, 06 Dec 2024
 07:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205141533.111830-1-dakr@kernel.org> <20241205141533.111830-9-dakr@kernel.org>
In-Reply-To: <20241205141533.111830-9-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 6 Dec 2024 16:25:28 +0100
Message-ID: <CAH5fLggWOkut0O+28NVYBSF2CTpHXe9Thb3rhXoRZo5e9zFjzw@mail.gmail.com>
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
> +impl<T: Driver + 'static> Adapter<T> {
> +    extern "C" fn probe_callback(
> +        pdev: *mut bindings::pci_dev,
> +        id: *const bindings::pci_device_id,
> +    ) -> core::ffi::c_int {
> +        // SAFETY: The PCI bus only ever calls the probe callback with a=
 valid pointer to a
> +        // `struct pci_dev`.
> +        let dev =3D unsafe { device::Device::get_device(&mut (*pdev).dev=
) };

It shouldn't be necessary to increment the refcount here.

Also, the mutable reference is illegal because it references a C type
without a Opaque wrapper. Please use the addr_of_mut! macro instead of
a mutable reference.

Alice

