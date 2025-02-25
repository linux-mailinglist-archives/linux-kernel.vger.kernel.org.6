Return-Path: <linux-kernel+bounces-530703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE48A4371B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5681896782
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3929A25EF95;
	Tue, 25 Feb 2025 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPuvFThF"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E1255E3C;
	Tue, 25 Feb 2025 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471340; cv=none; b=hoP1uo6QJutqh2u9orHFXEG/Q3PXBKMMJe1JODf8/6dMU8vtJgTYt/UyUymFKJBKok/d936LLJpKmau9HqFR1ZowdtC0HiiGQTOER3QRM2ujU4OqqSImFkwWQuQoD9tktuicRXQJ7evWubwwHymJVJdR6WdC0T1umRsPKLpcH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471340; c=relaxed/simple;
	bh=kmvuv+Jfr496j/cgberO76qrda4nqaWb+Uq969dYEXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VS8fXp/qhp/D10OyuH0ex8L/ZbU50psCIoDG00CZ3dx6Hvtl//fLRVNYiF6sL6TFku3tbCJQ2SSBnkZxNGTqoLZlG5yrQ6gpAPAOaS02oUwseWwv0sXGxF4nSPYYN1lrLK3gG2VcjW2yNbvjWE6I2LgLhgnF8bXuqr7Cj9p9JCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPuvFThF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30918c29da2so56394681fa.0;
        Tue, 25 Feb 2025 00:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740471337; x=1741076137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/KJUokdxrYn1BIrwoPNGtVFx5fJyWbgxS9RdZ3FB8I=;
        b=mPuvFThFTdD9/nR0QJPkBia82+uw6ffp3RqLMZNsp+MqDJyle3aGIH2aqzmj0yKuuH
         FyAub5E98tu18/czuClviQr9nDyvcB2X7lr2jNrsJKKS7XW3oFTqZGUX3lyCaV944zad
         jhHEu4lA6+l1nqS2lQP+0lW7qFJIDoJ3tu6kEBbbVz4KeebOLrrd1dTCgjqNRiDdvbLn
         0A6lCjJxq9+KaAymaGR3+FlBH/1XKV8VlCfX3LsAN+iyZIIj2Pxi/JkVImGyyqGrc2+J
         bi4pVgKYooIx3CIcY/5Q6seJa850DwCNks7pJj5Bx1y2hN7qgjXMeT3Hr716bzwhw5B4
         Yraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740471337; x=1741076137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/KJUokdxrYn1BIrwoPNGtVFx5fJyWbgxS9RdZ3FB8I=;
        b=W1+hOLUQYqSUremZMhKSCcTbPCwMqQzzohrk3KaTngAcNqkBVM5HPUEj3dIqq8fuqP
         7X7sV7RSXBiuq9NRlz4vNjkAfU88fzcc+uKXx/7SU/LjVOfjcEkcphd4kVhsZqzAWg2k
         ibai9izm8DnBmPQoOSMRP23whsyJKFxt1j0BsgaqFxraLyx0XB3Y2Xx/fwv/gkzd3rXm
         vK5gx+x/QlqMjLAUF9RizzicA2U5hP22IaQpKn2PFrpVQToM6vusVGEvvcbcJUoMqDKx
         J6eeZflKvkG7eO781T52/org8Da/8zrESDr5wY8CP+kXcmQfkJ0SgCSmIpSouW9VfCJt
         PRGg==
X-Forwarded-Encrypted: i=1; AJvYcCUcrDgSPu1rbAzCs5UqtzaRVqdLdg4skjbPjvRgvx6xZT/a/wlRmSjeF6ow1eX8J8qXqACJvP+AkQwbLDv5E9M=@vger.kernel.org, AJvYcCXt50DFZpc+GSD5PBz/YRYm/58fUmwoA4V2u4A6PAwpCx3h58HfH9bkkZL6gkwDbzeCP0k5hSr40VWxBC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXw7MhsNITenJtG4emNxtOefp5FlisuTLKW/rvGFxIvw7LTDkw
	wlprdC8sgd6IjWvDwzv6qKblvayk+zkZhRZFHRCbNZJc/jmrmFNO
X-Gm-Gg: ASbGncslG2cFSP/gljJcNFryLxG52vnMsCYxl7mRrzS5u1zkGdgyvLx8U5BdTkAXi2x
	oBF23dxQRuuPfFG9NrXP/CI2D1eNyZCjT/I31rf4w/yBfQj0LWJNXklcbE5adPDnQT4C1HNvx3f
	SGueVS0PESNkGpOd0Qn/ZOHA5SNHq64IPp0m1xJaqgNXxmlL6ZbHD9gMM7cMVGYKjEBPxkgNW11
	jjzhTJQaI69wCDxPCDxfw9phtIA5TRPcIxfmObI1tKMF3T8P5pZT9MNDZhikz+cRGNdgv5zM2H1
	IR4iYgz30UXMrpozJPmYqqwKjdVgklY58iolrrQj/x9iFcPmiewO8U2eG1h9g+tcZDxSk3Dl
X-Google-Smtp-Source: AGHT+IHuJatL8xCQgMuRAazvliL5edKKt4ZAJLa4CGfwau4teDzhfGmcvH+sqWJ0R4CwMb9wDctcXA==
X-Received: by 2002:a2e:9658:0:b0:309:1c07:4a56 with SMTP id 38308e7fff4ca-30a80c7e8c3mr8365861fa.36.1740471336402;
        Tue, 25 Feb 2025 00:15:36 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819ec1d1sm1630461fa.41.2025.02.25.00.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 00:15:35 -0800 (PST)
Message-ID: <a65125ce-524f-4226-9e59-32b731ad97f0@gmail.com>
Date: Tue, 25 Feb 2025 10:15:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Benno Lossin <benno.lossin@proton.me>, aliceryhl@google.com,
 dakr@kernel.org, robin.murphy@arm.com, daniel.almeida@collabora.com,
 rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com, iommu@lists.linux.dev
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 24/02/2025 22:07, Benno Lossin wrote:
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// It is the callers responsibility to avoid separate read and write accesses to the region
>> +    /// while the returned slice is live.
> This safety requirement is worded quite differently compared to the one
> on `as_slice`, why?
> 
>> +    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Result<&mut [T]> {
>> +        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
>> +        if end >= self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`,
>> +        // we've just checked that the range and index is within bounds. The immutability of the
>> +        // of data is also guaranteed by the safety requirements of the function.
>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>> +        // that `self.count` won't overflow early in the constructor.
>> +        Ok(unsafe {core::slice::from_raw_parts_mut(self.cpu_addr.add(offset), count) })
>> +    }
>> +
>> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
>> +    /// number of bytes.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// # fn test(alloc: &mutkernel::dma::CoherentAllocation<u8>) -> Result {
>> +    /// let somedata: [u8; 4] = [0xf; 4];
>> +    /// let buf: &[u8] = &somedata;
>> +    /// alloc.write(buf, 0)?;
>> +    /// # Ok::<(), Error>(()) }
>> +    /// ```
>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
>> +        let end = offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
>> +        if end >= self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`
>> +        // and we've just checked that the range and index is within bounds.
>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>> +        // that `self.count` won't overflow early in the constructor.
>> +        unsafe {
>> +core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
> Why are there no concurrent write or read operations on `cpu_addr`?

Thanks for the feedback! I noticed an additional safety requirement in 
slice::from_raw_parts_mut:

"The memory referenced by the returned slice must not be accessed 
through any other pointer (not derived from the return value) for the 
duration of lifetime 'a. Both read and write accesses are forbidden."

I can see now though why both as_slice and as_slice_mut docs needs more 
clarity. i.e., they could be worded similarly and add the additional 
safety requirement of slice::from_raw_parts_mut of having no other r/w 
access while the slice is live?

Regards,
Abdiel




