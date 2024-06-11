Return-Path: <linux-kernel+bounces-209970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C408903D85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4981F27489
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A98F17D348;
	Tue, 11 Jun 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAJ7JzzM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295917CA10
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112876; cv=none; b=fIiy/c5cHHwdqyXuBFM+2VM2dsM9IvjFgGqf1Fh5SgJz40ULIbs1P84g5Au/mvp8Tc0KymxOFQYz8bOh63jYNyz0uUI5PUNnqgsVsE6Viygo5+vmNuPykQP1Gyje9+8i1l4OhUfDYcgb7yTRvhArH0xyizwFjiUbOyhwKB6JxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112876; c=relaxed/simple;
	bh=fMnXH3P0sY84oJ2i2VipVV01IJMpLfSoDJiUvYvQfns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TokUdcieIf/005enS4lBKN9PDgDPl4BczQP+ThMIGAeFLN8GOrzo15/6Gssruw76jRxqnqTT3SF5vNHFBkVcLuFDxOk9bAqU7wa6oerNGa9uKD132lL6RKo4RQV2Yu4oCFemCjWowA+tQApg0gPNjhn3Z0brPG9DfBtPBbAbQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RAJ7JzzM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718112873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlFqDsmpxiQwCMlRn4XZlM9/t+MHExO4t8nH/Whd6bg=;
	b=RAJ7JzzMsTu72t6pqihU4sARVmtkMOgTX3tkMZoubgQbX4Tw7Iox/l7jlCOeAckLoJafPw
	yCesIIXQSXZZJEmM1GpngNM66Ct0K+TxGftd0PhOmjehNltqs4KX0Bdz1xb1u7gKMIW2CN
	D8gcm2eBjja0r79lkghhEtRU9+T2bTU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-DIgkzERXO3eRviHZvamO7Q-1; Tue, 11 Jun 2024 09:34:28 -0400
X-MC-Unique: DIgkzERXO3eRviHZvamO7Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f306b2e66so118078f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112866; x=1718717666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlFqDsmpxiQwCMlRn4XZlM9/t+MHExO4t8nH/Whd6bg=;
        b=OWX2be7mNkttl1B+2TKoWnu85CBXt7reSDkhv4U3C8JDMGBtHV/Fd2+Y0g15yM+/OR
         O2FWf3lQdU7neS+vXzGt1eRqhuag8NQpAXjcoVAbS+J169Gr+UyIFS9vWV76Iwq49/N0
         AYKt2k1w1uExuAWwIkiAc+BaSk7Kii23ItQDQ4pDjmYTqqvoq3+XuGbscu0TfDYzM3u7
         EATfQ5TriIP7W8YkgM4fXS/JwTFLlMu8vaMMIBLulX62X6lD1aGXvlCkFrFV659WsIzZ
         QsiunyJfWSOk81W+6iDV8XzH1NoJYycNL57CIfOfzBhxH+SCCrDkpwyvTLC0BrFPWSMP
         fXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIoxRwb4aRWEQknCI8VT3Z4Ck1er6f8OyVGP3YWJuyDvHta+WnYEIN4kQwXnFWWzATHpjGIYr9d8nT91Zk/KPi7cNAALugMyds4yqc
X-Gm-Message-State: AOJu0YwHQo5lGcAZrlmqiQJrDoF4+K8cldW/FUino+g0fZpmfeeh70Bp
	EiDT4I4YKSjOcWQlN6iexsH1UEeHqssV6TyYoequ2Z+AmFVdFWBlJX4P90yQE5eLXlndcErrIlZ
	MFvVu6eG7hiod66U/MgC4joXKIMM+TywT9jBWauHzme6OlGzbQ4cg3+yCFvkaZQ==
X-Received: by 2002:a5d:4bcf:0:b0:35f:1d1a:11c0 with SMTP id ffacd0b85a97d-35f2b27ed29mr2421740f8f.12.1718112866108;
        Tue, 11 Jun 2024 06:34:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtvsdbGvd3XwP/XQg2ucbgKXsN6X7Gi981zQpTfdDMs0qq8PbLVMYy8FUi4ZtzUR3cJqEqzg==
X-Received: by 2002:a5d:4bcf:0:b0:35f:1d1a:11c0 with SMTP id ffacd0b85a97d-35f2b27ed29mr2421709f8f.12.1718112865674;
        Tue, 11 Jun 2024 06:34:25 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d2e73dsm14053708f8f.16.2024.06.11.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 06:34:25 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:34:22 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, mcgrof@kernel.org, russell.h.weight@intel.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: add firmware abstractions
Message-ID: <ZmhSXuO_hmV8Tmjx@pollux>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-3-dakr@redhat.com>
 <2024061128-provolone-coyness-1d3c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061128-provolone-coyness-1d3c@gregkh>

On Tue, Jun 11, 2024 at 08:31:46AM +0200, Greg KH wrote:
> On Mon, Jun 10, 2024 at 08:02:28PM +0200, Danilo Krummrich wrote:
> > Add an abstraction around the kernels firmware API to request firmware
> > images. The abstraction provides functions to access the firmware's size
> > and backing buffer.
> > 
> > The firmware is released once the abstraction instance is dropped.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/kernel/firmware.rs         | 107 ++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs              |   1 +
> >  3 files changed, 109 insertions(+)
> >  create mode 100644 rust/kernel/firmware.rs
> > 
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index ddb5644d4fd9..18a3f05115cb 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -9,6 +9,7 @@
> >  #include <kunit/test.h>
> >  #include <linux/errname.h>
> >  #include <linux/ethtool.h>
> > +#include <linux/firmware.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/mdio.h>
> >  #include <linux/phy.h>
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > new file mode 100644
> > index 000000000000..7ff4c325f670
> > --- /dev/null
> > +++ b/rust/kernel/firmware.rs
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Firmware abstraction
> > +//!
> > +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
> > +
> > +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> > +use core::ptr::NonNull;
> > +
> > +// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> > +// `firmware_request_platform`, `bindings::request_firmware_direct`
> > +type FwFunc =
> > +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
> > +
> > +/// Abstraction around a C `struct firmware`.
> > +///
> > +/// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
> > +/// be requested. Once requested the abstraction provides direct access to the firmware buffer as
> > +/// `&[u8]`. The firmware is released once [`Firmware`] is dropped.
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer is valid, and has ownership over the instance of `struct firmware`.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::firmware::Firmware;
> > +///
> > +/// let fw = Firmware::request("path/to/firmware.bin", dev.as_ref())?;
> > +/// driver_load_firmware(fw.data());
> > +/// ```
> > +pub struct Firmware(NonNull<bindings::firmware>);
> > +
> > +impl Firmware {
> > +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> > +        let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> > +        let pfw: *mut *mut bindings::firmware = &mut fw;
> > +
> > +        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
> > +        // `name` and `dev` are valid as by their type invariants.
> > +        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
> > +        if ret != 0 {
> > +            return Err(Error::from_errno(ret));
> > +        }
> > +
> > +        // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> > +        // valid pointer to `bindings::firmware`.
> > +        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> > +    }
> > +
> > +    /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> > +    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> > +        Self::request_internal(name, dev, bindings::request_firmware)
> > +    }
> 
> How does this handle when CONFIG_FW_LOADER is not enabled?  Why are you
> building these bindings if that option is not checked?

Good catch, gonna fix it.

> 
> > +
> > +    /// Send a request for an optional firmware module. See also
> > +    /// `bindings::firmware_request_nowarn`.
> > +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> > +        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> > +    }
> > +
> > +    /// Send a request for a firmware with platform-fw fallback. See also
> > +    /// `bindings::firmware_request_platform`.
> > +    pub fn request_platform(name: &CStr, dev: &Device) -> Result<Self> {
> > +        Self::request_internal(name, dev, bindings::firmware_request_platform)
> > +    }
> > +
> > +    /// Send a request for a firmware directly without usermode helper. See also
> > +    /// `bindings::request_firmware_direct`.
> > +    pub fn request_direct(name: &CStr, dev: &Device) -> Result<Self> {
> > +        Self::request_internal(name, dev, bindings::request_firmware_direct)
> > +    }
> 
> Why just these variants?  Why not just add the ones that people actually
> need instead of a random assortment like you choose here :)

Indeed seems a bit random, not entirely though. I chose `request_firmware` and
`firmware_request_nowarn` since those are the ones we need in Nova, maybe we can
switch some calls to `request_firmware_into_buf` in the future, once we got the
allocator API in place.

I added `firmware_request_platform` and `request_firmware_direct` as well, since
they share the same function signature as the ones mentioned above and hence all
four of them share the same implementation through `Firmware::request_internal`,
just passing a different function pointer.

If you prefer I can drop the latter for now though.

- Danilo

> 
> thanks,
> 
> greg k-h
> 


