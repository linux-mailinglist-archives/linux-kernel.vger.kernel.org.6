Return-Path: <linux-kernel+bounces-244939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796D92ABF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0EC1C220E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0641509B0;
	Mon,  8 Jul 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwIHuMN3"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F6150989;
	Mon,  8 Jul 2024 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477001; cv=none; b=KuAKKz7qNFwq4n2E65nH/XX51ncoHRvGrKadWARHqvl3qEozv8X6bsfTqGwyLnIJnHPfKzB/1lhSypdgBCsAtFh/p9B8b4VhvPdmrcSCAjfh/ZoGzQsJD0q5BJNd7JT/fVso6XskWGwIWezieyaebankYsLKXleXBPM41iOe3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477001; c=relaxed/simple;
	bh=r85fh6KcSliTflOSzKO4M7DtwEKxSywoyBFcV+rFY7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGSyz/y+ZDk3N2hYnsihTluXyj+3tEfyPwGE2rUkfgKycYc1ZxfK+I6GEvrGN3GdndxrIYGjwzjl+dnn4VRA4pYr3LHcBss6YyyeKI/v/s/a2wDivPgy4y2G/j9ao8ZZeY3/eDYsdM9/awLHZLJktei2m4MDinp+STibG7TtXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwIHuMN3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77e2f51496so303944066b.0;
        Mon, 08 Jul 2024 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720476998; x=1721081798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8IPZEgNUUiuogNfAHnJPTqt9cHkFDPDkD4qrjFJewc=;
        b=VwIHuMN3ZsyQQVQtdD3poa0TT6gd1bO6xcjEeB3GZuPns6J3Yrf/ymDx5hG6vhcRTV
         +lwOXEWQ5ov1fJUK1c3Dx3v01XQ4u4Uxlz8mLKAIJ+CP1xbQmfV30fWPHYW0RZW16p0K
         +4lZW7s6ISqrjLZH1bTo76qKbjQfzQKgNhUpNxjWRwyk2okkMnUjU/WNwtxscpAMI0At
         vkRYF5ZnkS9Wck1vNJ2n+qPqc98Jz9P6QUmgcBOw5ENYZd/6yvOvNWmXMbJ8M/6gnhkW
         x0daJw/AQD2TrzILjviKasx3mKdl6wkLrZ8QcRWWCO5hJb5dKKDjcTVuHGKbLGPCuluS
         3S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476998; x=1721081798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8IPZEgNUUiuogNfAHnJPTqt9cHkFDPDkD4qrjFJewc=;
        b=Fo9Lx3RI0buQYV0l3GBaZnZwj0sdEbVVj+DQid8l46VflPdbVAtJREsBpHBYH9tIWc
         N3uuDFuAbldTuDvRGzyVAg5jaUapKlVnLhA4V6qjXH83h7zXKNoauTe3xyRnJLpGAj4m
         kA3VIPccQJRsZqXYorKEfYjmFC/kqDoiSpj4IBvQUsbWE9oRToxlgkCb4sLMzTuMkUIn
         rnQcvWYtqK0zTHuaZMOBtF6qAEg9G0BEmAtENJWjM3T8UAsNgvsQEpqDM1U2dUV5MEmq
         V+t9XcSfMBxF6kwJofnBThXw+z1j2TzUW9yncRumtdaUhK7o5SNxXOl+8SusXNAnLE/p
         ya2A==
X-Forwarded-Encrypted: i=1; AJvYcCWQGgEKDK4n4yQYepkamtLPv6kTxbmUFMGbTtFe28OCektOmhTT+RYax3LSD2ECIb6AOB7HmhuGuaLA/FN1nxsfipw65SIeFribWlLRSPU=
X-Gm-Message-State: AOJu0Yxe44vy07JsmvjAXDuQ+CnFHMpACHXYn9Cq+pCp9/MK0C+OE7h6
	K9cO3qohjBQ179vDkUHqg1jhQuo+bZky5T5hVNzVTx0V0Re8XuRv
X-Google-Smtp-Source: AGHT+IFqwfJfwY/dv7As6iUWdwfMCxHRyvXfl1tVUAm0TZEUjxj1gCdbeXAQKa5H6Txwc8uvvmBsJg==
X-Received: by 2002:a17:907:7e94:b0:a77:a529:4457 with SMTP id a640c23a62f3a-a780b6b3611mr71153766b.25.1720476998163;
        Mon, 08 Jul 2024 15:16:38 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:68fd::1ad1? ([2001:871:22a:68fd::1ad1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a86ec75sm25885366b.191.2024.07.08.15.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 15:16:37 -0700 (PDT)
Message-ID: <12a986aa-3fed-4686-b5bc-99cbe446cca6@gmail.com>
Date: Tue, 9 Jul 2024 00:16:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] firmware_loader: fix soundness issue in
 `request_internal`
To: Danilo Krummrich <dakr@redhat.com>, mcgrof@kernel.org,
 russ.weight@linux.dev, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Gary Guo <gary@garyguo.net>
References: <20240708200724.3203-1-dakr@redhat.com>
 <20240708200724.3203-2-dakr@redhat.com>
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20240708200724.3203-2-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Greetings

On 08.07.24 10:07 PM, Danilo Krummrich wrote:
> `request_internal` must be called with one of the following function
> pointers: request_firmware(), firmware_request_nowarn(),
> firmware_request_platform() or request_firmware_direct().
> 
> The previous `FwFunc` alias did not guarantee this, which is unsound.
> 
> In order to fix this up, implement `FwFunc` as new type with a
> corresponding type invariant.
> 
> Reported-by: Gary Guo <gary@garyguo.net>
> Closes: https://lore.kernel.org/lkml/20240620143611.7995e0bb@eugeo/
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
> v2:
>   - provide method for each wrapped `FwFunc` (Christian)> ---
>  rust/kernel/firmware.rs | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index 106a928a535e..2ba03af9f036 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -7,10 +7,23 @@
>  use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
>  use core::ptr::NonNull;
>  
> -// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> -// `firmware_request_platform`, `bindings::request_firmware_direct`
> -type FwFunc =
> -    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
> +/// # Invariants
> +///
> +/// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> +/// `bindings::firmware_request_platform`, `bindings::request_firmware_direct`.
> +struct FwFunc(
> +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32,
> +);
> +
> +impl FwFunc {
> +    fn request() -> Self {
> +        Self(bindings::request_firmware)
> +    }
> +
> +    fn request_nowarn() -> Self {
> +        Self(bindings::firmware_request_nowarn)
> +    }

I'm not sure if we should have a comment here that describes how the invariant is fulfilled.

In this case its not too bad since the Invariants are described just a few lines above, so:

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>


Cheers,
Christian

