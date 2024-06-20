Return-Path: <linux-kernel+bounces-222741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08F910696
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784A11F22B21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E621AD407;
	Thu, 20 Jun 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfOWApQC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D741ACE9B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891040; cv=none; b=WtoWwDV2KnhTzCfaOhdMbSQlbB7yC4+5VqMqyW/iGlxyXt6++hOfYEq4TcoGBn962otKoQ09gCjMDWz00kd/Pnp9dKoLat938dD450RYzLIAyo7cLUSXBOwnoiIY6yTDawR7Tg/f/dlNn4mZFDC9EWpu9axBGGzU1CUQ2ByFubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891040; c=relaxed/simple;
	bh=wzysBm79HIEbj0CNaTQJ1XR8YRMdkvWprIPf7NgrEKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ticHj64UbOA+8AOED/qLAFZwz9y8mV4sSc3/aOTXZ3e189LZWfDdZYEPxFVXItpoJlLmphmHznY21+Puia9LIJMUK03bor3y90gqdWjmMj4+bPDRiogDOp2ps73KU5LPsrXFMoAB8j+I4xQLhx92/nevWNS2ajn9imO7Wqaq6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfOWApQC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718891037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jAszQAYlHYicapGa42NWSvrVwmXsJz9TNE/V+NbdTg=;
	b=cfOWApQCAd9FnGRQUODKP5sPEuT8w8WrA8m+0OHVCQXwN+QTNWPJlat8oExgRscMqrSCu4
	xz+1ZiUJ6/Ths4cw++sA/Sg2NRuCyb4xcybh8BRE8xHXEt+nRNfcBFolzpPaKpKg3dbYo+
	R6TwuvMBEcNdMf1O1ED/P+N3kmup4Oo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-deKNx0iZMcqVk_sAWr8HVA-1; Thu, 20 Jun 2024 09:43:55 -0400
X-MC-Unique: deKNx0iZMcqVk_sAWr8HVA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4247d49a373so5820445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718891034; x=1719495834;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jAszQAYlHYicapGa42NWSvrVwmXsJz9TNE/V+NbdTg=;
        b=a814/xsYW5ULsnO+vIdH4eNEQgX7I3RI1m3H189ZmtpmfmRP7mOvg8TkdeRBevDHj4
         xBlvuEcOwDH9rT9WgSMEK320I2d7PfdoymFdODmJc+z5FmBy1bylvI2V/PtfiI2+L21U
         viw2rgiesK4CYs0JKZzQ+QtbW3lv8AXH9v5Qro/KGdKXzvyU5W9Tzucrftkr+NKTnZMd
         TKujMYg0ch59IFja7q2kHfDdgWAQFcDksLFoRCPXzAMKfyzyN8zaedo/wjOa+ten6kNY
         M//bzQz6Vt2SIRTiIkk7YjscREOtT3756tV0+mD60zr1KlBGUdUmohokBurxHQ6+oHml
         EVvg==
X-Forwarded-Encrypted: i=1; AJvYcCXjB4ugs15LlRgGF45prsXVolAXXZ8coQ6U/H3auEVRzKeU3ATbc6M/S2ADqh3ehtFiT8Dvq7pIiqeHIOCKlsPXvAtBhCeeIYEVTspH
X-Gm-Message-State: AOJu0YyY6tOtKeCdD4bK3LjIU3j2JoL+v8tbSK0B1oeHkyFvgZcE9RnZ
	KT1vxmIBWqvZbsv6YQ+iFSEzPFgkPcpEq7EfsDAOlotr8uQCIeIOZTI2PSOVWgkpsAL4E0z07iZ
	8Go+7ZyepHZLubu2wFA9xXGCuxmuydkfViQJ1z03McH1HelavyCbC4kP5VwhBvA==
X-Received: by 2002:a05:600c:15d4:b0:421:6b83:2a65 with SMTP id 5b1f17b1804b1-4247517f468mr37482755e9.17.1718891034669;
        Thu, 20 Jun 2024 06:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNGjj3F0CdG+CLUuBJfG3PX6oV1qE2c5L763mFcKwgz9pHGqfw4r7TTvXi41ejJkavfIQFjA==
X-Received: by 2002:a05:600c:15d4:b0:421:6b83:2a65 with SMTP id 5b1f17b1804b1-4247517f468mr37482455e9.17.1718891034218;
        Thu, 20 Jun 2024 06:43:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b6bsm26585705e9.32.2024.06.20.06.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 06:43:53 -0700 (PDT)
Message-ID: <df627771-72c7-4532-87da-3a132ad17f83@redhat.com>
Date: Thu, 20 Jun 2024 15:43:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] rust: add firmware abstractions
To: Gary Guo <gary@garyguo.net>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
 russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
 wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240618154841.6716-1-dakr@redhat.com>
 <20240618154841.6716-3-dakr@redhat.com> <20240620143611.7995e0bb@eugeo>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240620143611.7995e0bb@eugeo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/24 15:36, Gary Guo wrote:
> On Tue, 18 Jun 2024 17:48:35 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> Add an abstraction around the kernels firmware API to request firmware
>> images. The abstraction provides functions to access the firmware's size
>> and backing buffer.
>>
>> The firmware is released once the abstraction instance is dropped.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/base/firmware_loader/Kconfig |   7 ++
>>   rust/bindings/bindings_helper.h      |   1 +
>>   rust/kernel/firmware.rs              | 101 +++++++++++++++++++++++++++
>>   rust/kernel/lib.rs                   |   2 +
>>   4 files changed, 111 insertions(+)
>>   create mode 100644 rust/kernel/firmware.rs
>>
>> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
>> index 5ca00e02fe82..a03701674265 100644
>> --- a/drivers/base/firmware_loader/Kconfig
>> +++ b/drivers/base/firmware_loader/Kconfig
>> @@ -37,6 +37,13 @@ config FW_LOADER_DEBUG
>>   	  SHA256 checksums to the kernel log for each firmware file that is
>>   	  loaded.
>>   
>> +config RUST_FW_LOADER_ABSTRACTIONS
>> +	bool "Rust Firmware Loader abstractions"
>> +	depends on RUST
>> +	depends on FW_LOADER=y
>> +	help
>> +	  This enables the Rust abstractions for the firmware loader API.
>> +
>>   if FW_LOADER
>>   
>>   config FW_LOADER_PAGED_BUF
>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
>> index ddb5644d4fd9..18a3f05115cb 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -9,6 +9,7 @@
>>   #include <kunit/test.h>
>>   #include <linux/errname.h>
>>   #include <linux/ethtool.h>
>> +#include <linux/firmware.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/mdio.h>
>>   #include <linux/phy.h>
>> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
>> new file mode 100644
>> index 000000000000..b55ea1b45368
>> --- /dev/null
>> +++ b/rust/kernel/firmware.rs
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Firmware abstraction
>> +//!
>> +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
>> +
>> +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
>> +use core::ptr::NonNull;
>> +
>> +// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
>> +// `firmware_request_platform`, `bindings::request_firmware_direct`
>> +type FwFunc =
>> +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
>> +
>> +/// Abstraction around a C `struct firmware`.
>> +///
>> +/// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
>> +/// be requested. Once requested the abstraction provides direct access to the firmware buffer as
>> +/// `&[u8]`. The firmware is released once [`Firmware`] is dropped.
>> +///
>> +/// # Invariants
>> +///
>> +/// The pointer is valid, and has ownership over the instance of `struct firmware`.
>> +///
>> +/// Once requested, the `Firmware` backing buffer is not modified until it is freed when `Firmware`
>> +/// is dropped.
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// # use kernel::{c_str, device::Device, firmware::Firmware};
>> +///
>> +/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
>> +/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
>> +///
>> +/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev).unwrap();
>> +/// let blob = fw.data();
>> +/// ```
>> +pub struct Firmware(NonNull<bindings::firmware>);
>> +
>> +impl Firmware {
>> +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
>> +        let mut fw: *mut bindings::firmware = core::ptr::null_mut();
>> +        let pfw: *mut *mut bindings::firmware = &mut fw;
>> +
>> +        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
>> +        // `name` and `dev` are valid as by their type invariants.
>> +        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
> 
> This is line is unsound if this function is called with an arbitrary
> FwFunc, therefore the safety comment should also mention that `func`
> cannot be an arbitrary function and it must be one of
> `request_firmware`, `firmware_request_nowarn`,
> `firmware_request_platform`, `request_firmware_direct`, and this is

This is documented in the type definition of `FwFunc`. We can link to this invariant though
and explicitly mark it as such. Does that make sense?

- Danilo

> true because the function is not public and all users in the file
> satisfy this safety precondition.
> 
> 
>> +        if ret != 0 {
>> +            return Err(Error::from_errno(ret));
>> +        }
>> +
>> +        // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
>> +        // valid pointer to `bindings::firmware`.
>> +        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
>> +    }
>> +
>> +    /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
>> +    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
>> +        Self::request_internal(name, dev, bindings::request_firmware)
>> +    }
>> +
>> +    /// Send a request for an optional firmware module. See also
>> +    /// `bindings::firmware_request_nowarn`.
>> +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
>> +        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
>> +    }
>> +
>> +    fn as_raw(&self) -> *mut bindings::firmware {
>> +        self.0.as_ptr()
>> +    }
>> +
>> +    /// Returns the size of the requested firmware in bytes.
>> +    pub fn size(&self) -> usize {
>> +        // SAFETY: Safe by the type invariant.
>> +        unsafe { (*self.as_raw()).size }
>> +    }
>> +
>> +    /// Returns the requested firmware as `&[u8]`.
>> +    pub fn data(&self) -> &[u8] {
>> +        // SAFETY: Safe by the type invariant. Additionally, `bindings::firmware` guarantees, if
>> +        // successfully requested, that `bindings::firmware::data` has a size of
>> +        // `bindings::firmware::size` bytes.
>> +        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
>> +    }
>> +}
>> +
>> +impl Drop for Firmware {
>> +    fn drop(&mut self) {
>> +        // SAFETY: Safe by the type invariant.
>> +        unsafe { bindings::release_firmware(self.as_raw()) };
>> +    }
>> +}
>> +
>> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
>> +// any thread.
>> +unsafe impl Send for Firmware {}
>> +
>> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
>> +// be used from any thread.
>> +unsafe impl Sync for Firmware {}
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index dd1207f1a873..7707cb013ce9 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -30,6 +30,8 @@
>>   mod build_assert;
>>   pub mod device;
>>   pub mod error;
>> +#[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>> +pub mod firmware;
>>   pub mod init;
>>   pub mod ioctl;
>>   #[cfg(CONFIG_KUNIT)]
> 


