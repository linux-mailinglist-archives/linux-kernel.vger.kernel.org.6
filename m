Return-Path: <linux-kernel+bounces-543505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73090A4D663
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC23B3AB663
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1F41FC0EA;
	Tue,  4 Mar 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccTEj6Q3"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA051FBEA7;
	Tue,  4 Mar 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076906; cv=none; b=EHdxYnmK0fRdrX3hm9l/e3S1qBYNlOIJj+4buOBUgmcE3EjvoC1/reFXHXnXQj5IBVJpRGwRmz7ihy/nX/tXl7CGYFmaluY4l2Gfk92Eq7SegZqfkV8v4meRvnbP3niuuAOm0dT+Y/jEOC2gtyzM11CtNw64Xbb3opB285CUMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076906; c=relaxed/simple;
	bh=+Xd2Qwr5IaKsyLjb2/QOiSSthlsBv7A9tUADYqtec0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lV/RbZ6akjnHOByUjSg/MlXKFO1HdzxkczxHksH/jUP7lSfiTrGYdTXzG79PWND6BlyXS/x1W+jHpuSfmXUYxeKAxZkn/Yakw85nQklg6sQ6dX0L4PS/WeaItf3+Dj4ePf/iYLikgt55PYmg7n93hjRu3yvxSls38E7cwLYABK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccTEj6Q3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307bc125e2eso60119471fa.3;
        Tue, 04 Mar 2025 00:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741076903; x=1741681703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mX8x9KTPJ/SeOY+OHyZ4DRgvFc341kcnP5lxBsMGds=;
        b=ccTEj6Q3RtkBBVKRAaYgvRBcx3Ya3aHuaZ4Ml5c9LKX17xIe9MRjO0Fe0+Ii79o1ec
         1VXdnbB/VCfGUN8Ou/bxwm+Uds3iZzvzPbTASllsDktzuhlYRb5b/ZdA4bCEeHIdF/Rz
         Y+MT6uieBe8SK8/CPgPMZfbgORBqetkvPNt8M80FX246Magq4r65BP1JWvU2TIyKK7Jg
         hGvOkQJfyRUEbcsZvr4F1X+OKp+l1WtWRL+TgUgAwM74f1khnePNXEMvYKzOszPuj8sZ
         0jwmQh3AkymWFDyCNZm4oL2QsW7TZ4rycSvxHIrgYHNZfxyqPpWrrHKX2X6/Kh8QOO2H
         026w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741076903; x=1741681703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mX8x9KTPJ/SeOY+OHyZ4DRgvFc341kcnP5lxBsMGds=;
        b=eRfxrmEj+7u1uuOWPCBVLOfdCg5Kuth8EOwf9nd8khL0cwIu6pm8qOy/5QYJTTNNhq
         tV7AkDIKTNwDqUJoKDzgxrW4vjJ7ZOkJnqpb5kfM2QpfdqDxdswM7o7Gim30FYZ80iDX
         dVgdqyM12YIArvTFE3aIKaGGk/yYyTEr/I5GNJRzARfxfweDO9hWWg21/zPZopIzPDv/
         p0NynQkkQqwS1XRKUqVK8bwJ8AapLl1Z1QAKSBS1NRvZNVFRH8RieBOfBKkw36/aYued
         i3ZfabDMez8askpRWKzB+PVI6m4cV7WilVDxdFW8eJxiB77m5uUGW7h8HbY1Y33zUpHb
         lKCw==
X-Forwarded-Encrypted: i=1; AJvYcCVvpWWOSxh8eBFp5zMtvQ0eYeGaJ1Wv7p+y5r9YOSjcnrUAce+8XlSd1DDf5rXmfDGY7pSGE0g1txd/rm0=@vger.kernel.org, AJvYcCWbXrCfNWMwAlzl3LKvRpGKClOV2sYm42ItZq+dZIG7jbbwR1Zz8r7y+JRnY+or7k+ZNSjCUTa/IMktNjyPwx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1GuyXdW2WRA0iGcrX1moIzevejwUx1Al0PDkFG7XiwoTf/jby
	H4QQXmC3MfBxYeg1M2mldUsausCR3VwPji1V6DvgqUz4tJNDNtDN4+LAQQ==
X-Gm-Gg: ASbGnctpZ9th73klUUAPcT08h/uCSSEwBQBneFmxQd4i+WiWxmoqtUm2vKCX7cXKiCf
	JqtdBKOyLcABHAqAXZD40fTGhbV1Y3bWXiPgv//sKF1J19KumN89D2vnCGNbx446g/P8/d3KRqs
	lHG+wxZFik9/v6cH/Wk2n5781Ppnt+B9bTUcqqRdH/z/w255EDq+tcZT5ZcV4EwBvrbVdH7KaxC
	yB5zmZbs6zyjtD9eMt2avluQHjizix8LNhxDnx1S8fJcULVV/8wkngoW1/IIRsTOlldVohky9I7
	f5SYsThIr8tX9UVxjfzjyeDwhal0OOy2MXn+tiUAuh0KDXVZ8DaGaJ63UkRvh+drm2OGFZ3whun
	jRxb8CaC4DCFIfJNsD4mv+Q==
X-Google-Smtp-Source: AGHT+IGQXjXy4I7TbIxibMzg0y1cK5xMehOkC/wPiOXepdk9gzG4SYdo2xhPe+ixkrPITWiBjQcj8Q==
X-Received: by 2002:a2e:bc0f:0:b0:30b:b987:b68d with SMTP id 38308e7fff4ca-30bb987bb51mr20938931fa.8.1741076902435;
        Tue, 04 Mar 2025 00:28:22 -0800 (PST)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b86875b76sm16838331fa.91.2025.03.04.00.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 00:28:21 -0800 (PST)
Message-ID: <8d998447-bb4e-4b4b-a2d7-f5cba4b815dc@gmail.com>
Date: Tue, 4 Mar 2025 10:28:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>,
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Benno Lossin <benno.lossin@proton.me>, dakr@kernel.org,
 robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 iommu@lists.linux.dev
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
 <tnwDK3QN_Xr0Yoa3U8HVxS5OqjvxIhgmmO_ifTGJR_EtIzjoxawOHtnbOJ9yChsUWXyFPcU9beIdrgbpfGZI8w==@protonmail.internalid>
 <3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com>
 <87bjuil15w.fsf@kernel.org>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/03/2025 15:13, Alice Ryhl wrote:
> On Mon, Mar 3, 2025 at 2:00 PM Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>>
>>> Hi Benno,
>>>
>>
>> [...]
>>
>>>>> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
>>>>> +    /// number of bytes.
>>>>> +    ///
>>>>> +    /// # Examples
>>>>> +    ///
>>>>> +    /// ```
>>>>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Result {
>>>>> +    /// let somedata: [u8; 4] = [0xf; 4];
>>>>> +    /// let buf: &[u8] = &somedata;
>>>>> +    /// alloc.write(buf, 0)?;
>>>>> +    /// # Ok::<(), Error>(()) }
>>>>> +    /// ```
>>>>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
>>>>> +        let end = offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
>>>>> +        if end >= self.count {
>>>>> +            return Err(EINVAL);
>>>>> +        }
>>>>> +        // SAFETY:
>>>>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`
>>>>> +        // and we've just checked that the range and index is within bounds.
>>>>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>>>>> +        // that `self.count` won't overflow early in the constructor.
>>>>> +        unsafe {
>>>>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
>>>>
>>>> Why are there no concurrent write or read operations on `cpu_addr`?
>>>
>>> Sorry, can you rephrase this question?
>>
>> This write is suffering the same complications as discussed here [1].
>> There are multiple issues with this implementation.
>>
>> 1) `write` takes a shared reference and thus may be called concurrently.
>> There is no synchronization, so `copy_nonoverlapping` could be called
>> concurrently on the same address. The safety requirements for
>> `copy_nonoverlapping` state that the destination must be valid for
>> write. Alice claims in [1] that any memory area that experience data
>> races are not valid for writes. So the safety requirement of
>> `copy_nonoverlapping` is violated and this call is potential UB.
>>
>> 2) The destination of this write is DMA memory. It could be concurrently
>> modified by hardware, leading to the same issues as 1). Thus the
>> function cannot be safe if we cannot guarantee hardware will not write
>> to the region while this function is executing.
>>
>> Now, I don't think that these _should_ be issues, but according to our
>> Rust language experts they _are_.
>>
>> I really think that copying data through a raw pointer to or from a
>> place that experiences data races, should _not_ be UB if the data is not
>> interpreted in any way, other than moving it.
>>
>>
>> Best regards,
>> Andreas Hindborg
> 
> We need to make progress on this series, and it's starting to get late
> in the cycle. I suggest we:
> 
> 1. Delete as_slice, as_slice_mut, write, and skip_drop.
> 2. Change field_read/field_write to use a volatile read/write.
> 
> This will let us make progress now and sidestep this discussion. The
> deleted methods can happen in a follow-up.
> 
> Similarly for the dma mask methods, let's either drop them to a
> follow-up patch or just put them anywhere and move them later.
> 
> Alice

Thanks Alice. Yeah, will follow-up with those other patches and move 
forward with the basic implementation for now.

Regards,
Abdiel

