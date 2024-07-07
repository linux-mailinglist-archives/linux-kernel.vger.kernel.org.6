Return-Path: <linux-kernel+bounces-243732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083489299C2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 22:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2F71C20C05
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8B60B96;
	Sun,  7 Jul 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGHktWEw"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E7F51B;
	Sun,  7 Jul 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720385856; cv=none; b=J3LfJUDE7A5b/YJodtFuxccTFQ/+1jiAiSkVvDwU4A9LMz0SvSwyFMHA4fWwS8JqMl2egppofDSleqP2gOTrs0f+6+wvi/bShGbtVM+IdxrglCFe8NY3R0c/UaNBfiueuaIe+F5NGq3VmK8sQxjzMBLAWw00J1yNbLV3hycBZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720385856; c=relaxed/simple;
	bh=ff/TEO8b5EQqT8C9q2SHDDj+bLmKMDMJgn55WuNzLUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfCmnBIn+ozwXDpAW4cVoglDkcXRsL0LVHSRMqWPVnm3zX6c9npA7T5o4oAqclOmlcQmidefCEu6PGLedhvmozXtIidOWREoF06r5xVsUslaLZQHg8uxfzwmg0JYLaNFLHOVCi2Uv3oHgCdvCFYYoA7olIGp5eGNT1USIOkKfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGHktWEw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58bac81f39bso3724495a12.2;
        Sun, 07 Jul 2024 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720385853; x=1720990653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1QpJG+Kuls5EcalWj8r5uH8ccKjZ8ExXvX8fWy6I7rU=;
        b=EGHktWEwyhzyANhw32h85zkXBFy8Xx7eN7jPwhJnwxB7qxopczCKTNvFMQAv3paBzp
         646b1B/I3oVpywonjDT40VWU7ZsikSnKkWpGysQ4de2Ozpe69xhcFOj4Ch1tHHcuyZMQ
         F6dU6LZMSnkQzr0uRyCg4Z3U4BOm/SV2QfqqYs53O93GpALlACmUY/2kywDlkuBayR+Z
         3F+syeETQU/37tkX4GXYLAWttlKouSFUzBUhbi2iC4AfJ5HAJ+410QHg3Bu1yAzGdn/H
         J+WJ/TicI2wzhxFP/d7cQjFFt19e5HsYm6Ogr/lBk2DkXFuzoxWX/96YncEV8mguVgM7
         jV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720385853; x=1720990653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QpJG+Kuls5EcalWj8r5uH8ccKjZ8ExXvX8fWy6I7rU=;
        b=eNACLXlCh1uR50KH57WXvJ9L4KRMNZZ6usBa8nu9TzGASByEgKDkcn5j6FSNNEEdCh
         tZlq4xSkD1swu/Hnc3VRRfM1VN3B5aZFghhUdsnYutiRTDy96icmTL1tCR1vHxUJzlga
         ihAbWtDW9NzDY2RiT4LCSqJwboN2Uu9xqXQmin1cONUyWNdiPjVni0oEhGTggfYCI2KS
         RjJsp/h0MQGzrv0GIg7kHZXP/X6hGs/wj80xnQ/obC73VsoQmYyijONTYZC6l5w5Jzwy
         qFcsn5YyUTV63a6yGOwsoQY+Rc9bToeQ6M3xOuwVWBG96ISAreqAQQvnbiMVDlvmbqD4
         ptDg==
X-Forwarded-Encrypted: i=1; AJvYcCXRr8y3slPxZnZZeNp2OeYMvOf/72admGL4RGeHUoiXUTrUTM1eQn4t7Wx/x86zX4ZYKaUZndVVMe3fOnN8DbcolYQnKxx+AGOTA2acJio=
X-Gm-Message-State: AOJu0YzR0/uqoMmqNCEwSHkesb1UNgGuX7jInFiC6lBhaiB3a5C0y+Ij
	4ojoTdukhh8NrawJaQIUOwzP5eh1KUzLCJbmU8CSPzrnYL5vrmEzXHdDX2PA
X-Google-Smtp-Source: AGHT+IFEDn34ECRtayyCySyBsaVRdY0XvlpgJqc3PYvc6gu/k4TmIHAnfMYTgM6VFZrAujWxcF75xg==
X-Received: by 2002:a05:6402:13d5:b0:58b:73f4:2ed with SMTP id 4fb4d7f45d1cf-58e5b4aede0mr6385563a12.35.1720385852624;
        Sun, 07 Jul 2024 13:57:32 -0700 (PDT)
Received: from [10.5.1.156] (62-47-157-183.adsl.highway.telekom.at. [62.47.157.183])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614f3d74dsm11975137a12.90.2024.07.07.13.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 13:57:32 -0700 (PDT)
Message-ID: <dd56a9d9-08fe-4bd4-83e2-dfdc44f8c637@gmail.com>
Date: Sun, 7 Jul 2024 22:57:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware_loader: fix soundness issue in
 `request_internal`
To: Danilo Krummrich <dakr@redhat.com>, mcgrof@kernel.org,
 russ.weight@linux.dev, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240707003835.69090-1-dakr@redhat.com>
 <20240707003835.69090-2-dakr@redhat.com>
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20240707003835.69090-2-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Greetings.

On 07.07.24 2:38 AM, Danilo Krummrich wrote:
> `request_internal` must be called with one of the following function
> pointers: request_firmware(), firmware_request_nowarn(),
> firmware_request_platform() or request_firmware_direct().
> 
> The previous `FwFunc` alias did not guarantee this, which is unsound.
> 
> In order to fix this up, implement `FwFunc` as new type with a
> corresponding type invariant and unsafe `new` function.
> 
> Reported-by: Gary Guo <gary@garyguo.net>
> Closes: https://lore.kernel.org/lkml/20240620143611.7995e0bb@eugeo/
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/kernel/firmware.rs | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index 106a928a535e..d765ecc85d38 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -7,11 +7,24 @@
>  use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
>  use core::ptr::NonNull;
>  
> -// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> -// `firmware_request_platform`, `bindings::request_firmware_direct`
> -type FwFunc =
> +type RawFwFunc =
>      unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
>  
> +/// # Invariants
> +///
> +/// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> +/// `firmware_request_platform`, `bindings::request_firmware_direct`
> +struct FwFunc(RawFwFunc);
> +
> +impl FwFunc {
> +    /// # Safety
> +    ///
> +    /// Must be one of the functions listed in the type invariants.
> +    unsafe fn from_raw(func: RawFwFunc) -> Self {
> +        Self(func)
> +    }
Why not write methods that construct each possible FwFunc?
That way the code that needs to know abut this invariant is only inside a single impl block.
Something like:
impl FwFunc {
    fn request_firmware() -> Self {
        // # Safety
        // As per the Type Invariant `bindings::request_firmware` is a valid vaule.
    	FwFunc(bindings::request_firmware)
    }
}

> +}
> +
>  /// Abstraction around a C `struct firmware`.
>  ///
>  /// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
> @@ -48,7 +61,7 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
>  
>          // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
>          // `name` and `dev` are valid as by their type invariants.
> -        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
> +        let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
>          if ret != 0 {
>              return Err(Error::from_errno(ret));
>          }
> @@ -60,13 +73,20 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
>  
>      /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
>      pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> -        Self::request_internal(name, dev, bindings::request_firmware)
> +        // SAFETY: `bindings::request_firmware` is valid by the safety requirement of `FwFunc`.
> +        let func = unsafe { FwFunc::from_raw(bindings::request_firmware) };
> +
> +        Self::request_internal(name, dev, func)
>      }
>  
>      /// Send a request for an optional firmware module. See also
>      /// `bindings::firmware_request_nowarn`.
>      pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> -        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> +        // SAFETY: `bindings::firmware_request_nowarn` is valid by the safety requirement of
> +        // `FwFunc::new`.
> +        let func = unsafe { FwFunc::from_raw(bindings::firmware_request_nowarn) };
> +
> +        Self::request_internal(name, dev, func)
>      }
>  
>      fn as_raw(&self) -> *mut bindings::firmware {

Cheers,
Christian

