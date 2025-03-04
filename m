Return-Path: <linux-kernel+bounces-543607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0993A4D77A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B198F188A893
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E31FDE37;
	Tue,  4 Mar 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwoBmjc8"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC781FC7FD;
	Tue,  4 Mar 2025 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078743; cv=none; b=t2+W05cPlSUPI0T/glR1sgVtFsgb12OrQfWmSaTkWi3SasIjH+zGushf/OgweBZj2zXpGA9tj0TYWmoQuPc/MDnhFAu+WygKeOou+Zp+1NrxR28HDaU4A92xBAaP/93jNGFohRRtacwyG6JlzOrm0bzh9mrLlkPl7Uj9yajxaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078743; c=relaxed/simple;
	bh=GRs8DmVV8Q0Rqg68kkllhDnXL0SPxEdTvmczIygoWyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYE9weGIW6tjDrypHENa336jkpBFGCcTWwv33JKBqECi9Ij7IiWj67/q7WJh815XKza21kN7GdmcHQlzWZsGzv0/lYjD8T+6rALMuuFru0wsDKu5cceZwMlOH3kSNKHdBlbnpLQIjSvSIRHbHOQ77rb0bI35rQN44o4h9POwS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwoBmjc8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3061513d353so55170081fa.2;
        Tue, 04 Mar 2025 00:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741078739; x=1741683539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpLvosOPTODge75ZhJwO92ZOn1A2PUQkW7JVgLvP6v8=;
        b=jwoBmjc8Dsu5KozbT+haPlx1u/cDTHDvW8NcRh0S8qckDRX7EaCDZynDnZ4IXfmqFF
         7iunV5ChsNsUTXuM8x32A8XBvET6z5EjbNDaVu40QfWr+9UKzs7yWSBlLsmPi0q9w1PP
         LFVNmEWDw8eAJPHVfSrmv55mHQvEoK33IfVQT95OnbQ5mdI38PTIgzwlTrDwdENPUf+m
         /N1ZdvMN9lVxOk5GtM2T0eFluoXSsBfeTq0lLKPm5jZrBt6JsOch7rTrqIus/zw4HAIK
         43K9sbMcDCRvQfy6CyJ5BeymlmmV5Phts37fk+BkUK6j0vvcQnaw5s9oVl/4X8Jy8KTY
         B6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078739; x=1741683539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpLvosOPTODge75ZhJwO92ZOn1A2PUQkW7JVgLvP6v8=;
        b=MQuG65F5fdwt2z3QPjvCpolY5yEYNp/QiNQgIhCdB/k6t/E0ZV99k1GUs/FyQ8Uv6o
         8FZs7l+Cv9JI2A8JZbMipo8316WP3IUbABOYJRAEdI4zoofIlwe3XgMcUmh8UINd2vdq
         XslbFqCb9C4Wyk4pccbeT8BXW6CZAGMRHW6DL92dUbqJaD1P+IC/nNPT1D/UQXAcbuSH
         yqe6WSDcWE13W02Uxa1PSxNU8acqkLyCgjfkCYi+2qmFiwVhLfCBLsiSGeNqIK2fUDO1
         OFVBCzoVcHZviu60blTV4R23dDL7267Xbyx4pMOhwWBYaw9FTO7ob6Z+43CnQls0dceY
         mNWw==
X-Forwarded-Encrypted: i=1; AJvYcCWQj8FtDcgOLiKOpBbD7s+mKufGssraUhdtkwafEJtqr6ZOlOrfRTuHxORGB5eeDDka3KM5RI2PEydpwzw=@vger.kernel.org, AJvYcCX2t1PMPgD11P/x4fvLONmXr/0KnPJQPOidchgDs9xxchHPA+qbSMcsc4x/1ZXl/5ODCpfNhQlfhDsHPYp1Y8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9CONk72bkA3KBZ/Jz/gstlyVL6VSzD0tdhk0MOkwe93V2HHI
	BNofuNFRFCyI4CoeuDQ9rgzeci8vkD3V3XzSjypVhSteFfVSBbUx
X-Gm-Gg: ASbGncuiWr5AXApiaOK4fZnW4q8n2Dw5AfHSmMph25QgalNwcwPlW0AliSNjiC9Ykou
	THdimQjYnT+1WHLcQ9rGHFohQbw9leSXZD/GI8/6gfYIuCPm4EoAaBHyEUNBR1AhgYLNRa/kQ3e
	vL8NJdhDqYmLPdjzuhRO2kOqb86agTxHuv0kaJxZFgALk9MUmzWRCjhK2NITDW95VMWi7GY8FhZ
	RnVMR+n0gDX98jbjZsIUoteNE7vgz9V+qTG75z50OjOxAPSvZLPRn3X9hu8lc1dDSBdaLuF7EJL
	8Zkc9ZN4W0KkiSzIGI2+pRXWNJnvga8hfV7J5dAf0gSeDWsFOpcNVdPRa2ZPPtw2O+R09THkLHt
	rQLC/L+4a3vUgGmqpD4AE8g==
X-Google-Smtp-Source: AGHT+IFMgqZCbWR5mRoy9EQCtE3Z96nLi59uYRRUqwLOmodMoMI3drMHKTbl7nN9ffI6EtqpyEJVAQ==
X-Received: by 2002:a05:651c:210c:b0:30b:c36c:ba9f with SMTP id 38308e7fff4ca-30bc36cbd5dmr20830681fa.14.1741078738757;
        Tue, 04 Mar 2025 00:58:58 -0800 (PST)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bc1b1c4fasm4745901fa.18.2025.03.04.00.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 00:58:57 -0800 (PST)
Message-ID: <80f31377-f897-4881-b294-87f13f75acd4@gmail.com>
Date: Tue, 4 Mar 2025 10:58:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: aliceryhl@google.com, dakr@kernel.org, robin.murphy@arm.com,
 daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <k3GMnfXzzvUVOgSnuMlEq3eVRyq1qjcf_tDtILRbOwj08EIQpwQ4bGtGhwWufr8lUn-VlHnNjP8FxIA48Jv-Ug==@protonmail.internalid>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <87h64al5c6.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <87h64al5c6.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/03/2025 13:30, Andreas Hindborg wrote:
> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
> 
>> Add a simple dma coherent allocator rust abstraction. Based on
>> Andreas Hindborg's dma abstractions from the rnvme driver, which
>> was also based on earlier work by Wedson Almeida Filho.
>>
>> Nacked-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> [...]
> 
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
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> new file mode 100644
>> index 000000000000..b4dd5d411711
>> --- /dev/null
>> +++ b/rust/kernel/dma.rs
>> @@ -0,0 +1,421 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Direct memory access (DMA).
>> +//!
>> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
>> +
>> +use crate::{
>> +    bindings, build_assert,
>> +    device::Device,
>> +    error::code::*,
>> +    error::Result,
>> +    transmute::{AsBytes, FromBytes},
>> +    types::ARef,
>> +};
>> +
>> +/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
>> +/// both streaming and coherent APIs together.
>> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
>> +}
>> +
>> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for streaming mappings.
>> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
>> +}
> 
> I'm rebasing some of the dma pool code I'm using for NVMe on top of
> these patches, and I notice that these methods in the original code from
> way back (besides being on Device) has these methods return `Result`:
> 
>      pub fn dma_set_mask(&self, mask: u64) -> Result {
>          let dev = self.as_raw();
>          let ret = unsafe { bindings::dma_set_mask(dev as _, mask) };
>          if ret != 0 {
>              Err(Error::from_errno(ret))
>          } else {
>              Ok(())
>          }
>      }
> 
> Is there a reason for not returning a `Result` in this series?
> 

Hi Andreas, the original dma_set_mask function got lost to me for some 
reason. But yes, this is indeed a better approach!

Regards,
Abdiel



