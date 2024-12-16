Return-Path: <linux-kernel+bounces-447157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ABA9F2E19
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6910116326A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4102036FB;
	Mon, 16 Dec 2024 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1gj1C2M"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02C2010EF;
	Mon, 16 Dec 2024 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344596; cv=none; b=ejJCqf8684p/iQg8uVcMnS4OTuZOOPHx+w20QFe/KgSBC9CpDlvictf6VJDsN/crB8Wa//9GwQmXqU7MeWmqT/0syoiQeG9IpwGaFAZtjQWooxU6or4PaSKw3k6wxtYahgDthHluFwncMWo0eKFr4Oi27Koc7WYWNE4F7ZaQnDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344596; c=relaxed/simple;
	bh=X7hz73YZMAuspL4ZSWRJS0L8v8iep2zqFRz8Exthqjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbzJyOKQRsXY3suCMXUQjrLVE4c0mcPbXU054dETwswm2lQxe85TidW3Q+ttIu8EOeQIalQFMIe9Axhzk0D16mx6sNLIeME04O/oBj23V2XHDF0U1QqKR+oQPlrcQMa9Tx0jQEtfhHdpQ67TZlWk92CzRI8jeLRtRY1k5kP5RAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1gj1C2M; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e28cf55cdso3533904e87.3;
        Mon, 16 Dec 2024 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344592; x=1734949392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQgc2lLILX6zWYW2cp2uo7oeDGv90xpnmmiFLnRu7LI=;
        b=Q1gj1C2MAa2xcJMSYElPG6IT19L60mIN4DUdfLMAL+pu2xRwWJ1WPPcNlZB6QEB4Rw
         F5aV9p8Tsb15RZ873cYi6RU6iBLhoQOSCHknKfTdRdUqxhNccJfluhwA05C2kF/yherW
         fBadFQilqtMkeDlXBjXgyzujeb9dCiv1ZYAzylGV2Z8+iiFrEyPMpBh50aIA1u6W7HOd
         prSLX8D6YOg3u8htgCvsYtmuKe6DhkYs85H5ay3ves2Dq4/k9bo8+pb+yO//LHpO62ZF
         0CsMH/bMEVMpSqhh7EttFA2Y0dz7y8zIguq2yhosIebPbe51OzsZ824ooLWOAyq60YDI
         G8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344592; x=1734949392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQgc2lLILX6zWYW2cp2uo7oeDGv90xpnmmiFLnRu7LI=;
        b=fK38Z3nbbIupfuoAFLxev5HqEk9BPC7o2Ks7ezLKMwfy4tI++qrXRU6vUpLsjqRhrs
         DGntwiFCwk3A5lklh9hNyIAtSBc0OlRZYfM2DcR0Zrnr0ewuxGAL/RVSEVULSxOeehBS
         tEwhM9c0sNfkS0yqENIk+qU7WBpe4x/FVLcfuJINSN+9Ojr7e5KADusrr6XEfL/0rdA8
         lC5iZIFq4lVWUzp1rocWSQLsHWbpllPoLkz1pZwStC+nJ2Yas0ekrJu3VA6ALf6V1L8i
         gyYkpFQkj4+twm/frVJugIHZmRvh/vDD5vhItnOwc2S6jhi5DkDV11uBO40dTYKcPjNS
         p9ig==
X-Forwarded-Encrypted: i=1; AJvYcCVHX3guEKzmhcA2dYk9E4WVaMyYXKx3LDHLgW7otgmzwFP/oH6exdY49AsmErIaoG0bZwnw5lTJMRQ3ibQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8l/86Ke4fQq3ZpgxPIrdK7c60m5F0sblhfvT8yJxM2fax0mQ
	62nCAuARDJlk1oqY1fZ4137XPVtA/dwMQoYF7jwpkWJLur0ZSn3T
X-Gm-Gg: ASbGncuoGegFXJZxqnQk0s3wXhzqHlCOE7Q/BBSKjW0BurU+/vOw6hIN1uFQ2Vzu3q1
	4WpJWLAazX4LR2aLtzOaVySebmg7I5e4l+Zb354Y2/t3zb0k073Wis3MYS95YTYLfFbRfKrISCC
	CTX9rm+ptmCvsbTzJafio7phkyRffjDBGLxXS2lhf91+O855wNvd6SDl/+T08G2HLmz/yb28Lq4
	Srw/4Bn1oP5DiBHdthC+YRdFwTzHzM+wEYyLgCqVMdMrVZ9wkA2ZcqLOQhQqREPhhkw8JjMgSP8
	jr9ISOmYgJlC0FW8HBFr5wPwT2o=
X-Google-Smtp-Source: AGHT+IHUeir8mWJDMubLNBEwRE0TOe2jZjlVnj5E+6MVDLPtwfdQnftnTctkqu2Of/4M9kA/fowwPQ==
X-Received: by 2002:a05:6512:3096:b0:540:5253:9669 with SMTP id 2adb3069b0e04-54090568080mr4056809e87.32.1734344591920;
        Mon, 16 Dec 2024 02:23:11 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f3basm789880e87.15.2024.12.16.02.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:23:10 -0800 (PST)
Message-ID: <f340e2c9-a794-4ea9-8b1a-53496765e769@gmail.com>
Date: Mon, 16 Dec 2024 12:23:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
 <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
 <0F719804-2AD3-4C4E-A98C-2862295990BA@collabora.com>
 <b7130ae2-6314-41d9-bda2-d875b22463bb@arm.com>
 <263C49EB-5A5D-4DF4-B80A-A39E6CE58851@collabora.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <263C49EB-5A5D-4DF4-B80A-A39E6CE58851@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/12/2024 21:08, Daniel Almeida wrote:
> Hi Robin,
> 
>> On 13 Dec 2024, at 12:28, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 13/12/2024 2:47 pm, Daniel Almeida wrote:
>> [...]
>>>>> +    /// Returns the CPU-addressable region as a slice.
>>>>> +    pub fn cpu_buf(&self) -> &[T]
>>>>> +    {
>>>>> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
>>>>> +        // is valid for reads for `self.count * size_of::<T>` bytes.
>>>>> +        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
>>>>
>>>> Immutable slices require that the data does not change while the
>>>> reference is live. Is that the case? If so, your safety comment should
>>>> explain that.
>>>>
>>>>> +    }
>>>>> +
>>>>> +    /// Performs the same functionality as `cpu_buf`, except that a mutable slice is returned.
>>>>> +    pub fn cpu_buf_mut(&mut self) -> &mut [T]
>>>>> +    {
>>>>> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
>>>>> +        // is valid for reads for `self.count * size_of::<T>` bytes.
>>>>> +        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
>>>>
>>>> Mutable slices require that the data is not written to *or read* by
>>>> anybody else while the reference is live. Is that the case? If so,
>>>> your safety comment should explain that.
>>>>
>>> The buffer will probably be shared between the CPU and some hardware device, since this is the
>>> point of the dma mapping API.
>>> It’s up to the caller to ensure that no hardware operations that involve the buffer are currently taking
>>> place while the slices above are alive.
>>
>> Hmm, that sounds troublesome... the nature of coherent allocations is that both CPU and device may access them at any time, and you can definitely expect ringbuffer-style usage models where a CPU is writing to part of the buffer while the device is reading/writing another part, but also cases where a CPU needs to poll for a device write to a particular location.
>>
> 
> Ok, I had based my answer on some other drivers I’ve worked on in the past where the approach I cited would work.
> 
> I can see it not working for what you described, though.
> 
> This is a bit unfortunate, because it means we are back to square one, i.e.: back to read() and write() functions and
> to the bound on `Copy`. That’s because, no matter how you try to dress this, there is no way to give safe and direct access
> to the underlying memory if you can’t avoid situations where both the CPU and the device will be accessing the memory
> at the same time.
> 

This is unfortunate indeed. Thanks Alice for pointing out the 
limitations of slice.

Btw, do we have any other concerns in going back to plain old raw 
pointers instead? i.e.,

     pub fn read(&self, index: usize) -> Result<T> {
         if index >= self.count {
             return Err(EINVAL);
         }

         let ptr = self.cpu_addr.wrapping_add(index);
         // SAFETY: We just checked that the index is within bounds.
         Ok(unsafe { ptr.read() })
     }

     pub fn write(&self, index: usize, value: &T) -> Result
     where
         T: Copy,
     {
         if index >= self.count {
             return Err(EINVAL);
         }

         let ptr = self.cpu_addr.wrapping_add(index);
         // SAFETY: We just checked that the index is within bounds.
         unsafe { ptr.write(*value) };
         Ok(())
     }

> I guess the only improvement that could be made over the approach used for v2 is to at least use copy_nonoverlapping
> instead, 

You mean introduce something like read_raw(dst: *mut u8,...) and 
write_raw(&self, src: *const u8,...)?

Regards,
Abdiel

