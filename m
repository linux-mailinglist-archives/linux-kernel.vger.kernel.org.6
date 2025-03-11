Return-Path: <linux-kernel+bounces-556624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B06A5CC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00493179C34
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D2726388F;
	Tue, 11 Mar 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy+FYqGs"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A611262D11;
	Tue, 11 Mar 2025 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715124; cv=none; b=kW7Nc/h8nkzaItKoPDKDoT6UgaDjXbLXpcKCZtZROf6H7fniOIsbwGlRYOYaU1HMZuLUuy1DZzs2Ufsxf4j2n5eIOTq8XfyrdnE4/No6HykPRpQMn1cY19kV4sYWOl5O6B7r4OKnMWdT4zYJ3c1pcXbNcX5y9bGY76n15toNFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715124; c=relaxed/simple;
	bh=l0VXxLyHqQ03BojE4ii06LhUjI+hhzdC8CIFLnCEcf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMnxH3204GXXax/4s0ZQYmMWLCruxEXKXjkt+DiQexZziMidEeeXIKxJiKXLuyGiLLScGaRpfCzXmgJVbY6cKN4RLxhccCeAfjreJUIi3B3egsKR0CDToomRhdTHLECtvT/X9wjOLqYGGdJubR1W+W+MU1orOOTqWfEY5kKshIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy+FYqGs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so61597361fa.1;
        Tue, 11 Mar 2025 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715121; x=1742319921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asnNU19ygcsN2CKrHdfOexyM1HK98rMZqPH+Eazq5VA=;
        b=hy+FYqGsfUKjY2ZkFG5llaXOO7sE4eXtVSnRiwp3BwM5zUXQBaa84k/IeAuRx+x8ml
         BlWnGg3i1/fvNXjrlgsInpPSwL3Czf5b1JTSn11TgcskX5QnNyb49jPScReHyzpzIEh6
         JhRepdQZpQJcXJVh7emEIT3cz0sh/mvPEI6v1AlIKTx3Sxn4MT3Uw0AyZzHyhI4MKxtE
         2DCQYxU+tXIxbni1AIaHsdg3yW+dXAGrXuX+Hm24aI4E02CioMoTuAJPGC1DENg0h4UR
         IXFFRqPg9eMvybBzZVYYwFWM+k/INb2ccGj9dL0yTRhQR3jVjPMJkziwzTQ/sPTwE+/x
         VBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715121; x=1742319921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asnNU19ygcsN2CKrHdfOexyM1HK98rMZqPH+Eazq5VA=;
        b=VwXccTfTv7rSrgKd/VDd8/GUgp61pNS9+yiIJXlNIjlgiQWRvjiBlVVbGoz4DqIrbH
         CzydEsOYjuaoHzz6qELxRYzGgffbJr0JBzn4hJoKImDZ70c2GNuuDPx+OL5+C7XfMSwI
         7O1zkozNYyy4WhD+Mrt8iEy0f7nIUmWIpAZKXuuclk0MLaqmRjtqxswYbEGErI9l/JHk
         U98GzNX74+yDq3YtJg3dQCVtITAmEawMaMoJjYc3Z7QU3DDC9IgkF/4ZdlY3gmS2XoQZ
         nIqFvzF/Fb/KnntFtwadmJum+vwmERf731zkYVjX5gtgxhmNyZnJt6HBC6SRvCWizB8T
         H1cw==
X-Forwarded-Encrypted: i=1; AJvYcCX7S+eTjvjS1xN36F1rnYS9ZurabwRAb7zPzvP0r9jY5+RCWj3gAW24cgLzMPGk7NEI3eluJVhZPZPIqjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFOflYzVlNQf0NXY69ccYErM9HuIj5yyMkm3I7hvhhrs8lVsR
	dIG5TCESnCOI0bncQ65enMw43osbjbN+90aMMo0d/CzbHZoT1v1t
X-Gm-Gg: ASbGncuIAkWtkZdZjnpXUiVqDgXfvlwWvNuwT/yKm41sL+Jgf+NfGFP3jLwEHeecU4N
	yabGep+GnAYNwRPGq6IljReBeFA5p3GLXscU2fPBkncT66SisK3Q/EW82xdzvR5rYLqjK0w3euY
	gsOLFNmNSYDGGgYlZHJnKI5uMOydWG6s7gRBPrWxqOZ1eUhcT7dpEtpSUF2+iKb3SG/fseXgtYG
	lYNvYSrxBeghYN3r5N0LB+DonzzowQlrmywKGY+rOxxUYyhsf88scFmMIOIrhJQvY9SwA56POY6
	A1OIJNPSw2jqd7ghkxHJzJluulZF1Voe47cFmkmBSa04DaCIffcs/tGUJz8C3BlCCdCoc4J2ZW2
	j+qZDEMwn0nz2RF6aghrh7A==
X-Google-Smtp-Source: AGHT+IFxj2Dayu+wbOQKzrV5wxiY2G9Z04wHC3RtTdBJTzM8av5dhGJypQXyOqhWF4kFSnReXrQF/w==
X-Received: by 2002:a2e:bc27:0:b0:30b:b184:a904 with SMTP id 38308e7fff4ca-30bf44edde3mr71880861fa.4.1741715120287;
        Tue, 11 Mar 2025 10:45:20 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c011d2830sm14276651fa.80.2025.03.11.10.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:45:19 -0700 (PDT)
Message-ID: <902d6f21-a6c9-4776-9e55-26f089acd0da@gmail.com>
Date: Tue, 11 Mar 2025 19:45:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/7] rust: device: add dma addressing capabilities
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <nxaaNW1XIbhf7dSf8aRLVF5Se-0maF6BhX8GaUXlsOL-QOste8OMQxtmhYe_BYI6FYFEMeHEzy1s4OEy7PdGKw==@protonmail.internalid>
 <20250307110821.1703422-5-abdiel.janulgue@gmail.com>
 <877c5038i1.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <877c5038i1.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 07/03/2025 22:12, Andreas Hindborg wrote:
> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
> 
>> Add functions to set the DMA mask to inform the kernel about the
>> device's DMA addressing capabilities.
>>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>   rust/helpers/dma.c     |  8 ++++++++
>>   rust/helpers/helpers.c |  1 +
>>   rust/kernel/device.rs  | 29 +++++++++++++++++++++++++++++
>>   3 files changed, 38 insertions(+)
>>   create mode 100644 rust/helpers/dma.c
>>
>> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
>> new file mode 100644
>> index 000000000000..8eb482386f93
>> --- /dev/null
>> +++ b/rust/helpers/dma.c
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/dma-mapping.h>
>> +
>> +int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
>> +{
>> +	return dma_set_mask_and_coherent(dev, mask);
>> +}
>> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
>> index 0640b7e115be..8f3808c8b7fe 100644
>> --- a/rust/helpers/helpers.c
>> +++ b/rust/helpers/helpers.c
>> @@ -13,6 +13,7 @@
>>   #include "build_bug.c"
>>   #include "cred.c"
>>   #include "device.c"
>> +#include "dma.c"
>>   #include "err.c"
>>   #include "fs.c"
>>   #include "io.c"
>> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
>> index db2d9658ba47..f9d3d4f60ddb 100644
>> --- a/rust/kernel/device.rs
>> +++ b/rust/kernel/device.rs
>> @@ -6,10 +6,12 @@
>>
>>   use crate::{
>>       bindings,
>> +    error::Result,
>>       str::CStr,
>>       types::{ARef, Opaque},
>>   };
>>   use core::{fmt, ptr};
>> +use kernel::prelude::*;
>>
>>   #[cfg(CONFIG_PRINTK)]
>>   use crate::c_str;
>> @@ -187,6 +189,33 @@ pub fn property_present(&self, name: &CStr) -> bool {
>>           // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
>>           unsafe { bindings::device_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
>>       }
>> +
>> +    /// Inform the kernel about the device's DMA addressing capabilities.
>> +    ///
>> +    /// Set both the DMA mask and the coherent DMA mask to the same thing.
>> +    /// Note that we don't check the return value from the C `dma_set_coherent_mask`
>> +    /// as the DMA API guarantees that the coherent DMA mask can be set to
>> +    /// the same or smaller than the streaming DMA mask.
>> +    pub fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
>> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +        let ret = unsafe { bindings::dma_set_mask_and_coherent(self.as_raw(), mask) };
>> +        if ret != 0 {
>> +            Err(Error::from_errno(ret))
>> +        } else {
>> +            Ok(())
>> +        }
>> +    }
> 
> I think we can use `Error::from_errno` here (and below). As far as I can
> tell, these C functions return negative on error.

This already uses `Error::from_errno`?

Thanks!

> 
>> +
>> +    /// Same as [`dma_set_mask_and_coherent`], but set the mask only for streaming mappings.
>> +    pub fn dma_set_mask(&mut self, mask: u64) -> Result {
>> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +        let ret = unsafe { bindings::dma_set_mask(self.as_raw(), mask) };
>> +        if ret != 0 {
>> +            Err(Error::from_errno(ret))
>> +        } else {
>> +            Ok(())
>> +        }
>> +    }
>>   }
>>
>>   // SAFETY: Instances of `Device` are always reference-counted.
> 
> 
> Best regards,
> Andreas Hindborg
> 
> 


