Return-Path: <linux-kernel+bounces-529564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85561A427E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6735E16DACA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02D262D06;
	Mon, 24 Feb 2025 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQJhHDvJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87C125485D;
	Mon, 24 Feb 2025 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414446; cv=none; b=jDQqX74IY36wwm/ULSnMOmK0egObcioMljJkwkW6IB0WQXa+/VKdnupPcGVDu4GzPrR8MowlB8995pQpsbBPFYRMSNtjs2iNZmHpHFJGMRHsk3+yrjL0ovZZwjlgH7+fUlDcDetBhAuMxsor8zCqPQi+7wTlaUpsCXiIUtdgyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414446; c=relaxed/simple;
	bh=ydaM6hj0cYqKGtZFlwPdLyQgyQlFKrqeJWmamUgbdaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pgd9qlxptDuALvAr1gGVGYZ2yfvYzf0mUo9/eGiYqOaTIZxzIFmYcKY6T1mhrV6tdcLi1pDtB/g6Vr0Hey0r4L4nARKsJjC1zMWTdu5Mp8WCDCYwkdDl5LVSDCcbUUcm8G5FDBdL+2TqGUJ4M/U6PEjccszzOjPPRGojb7XqUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQJhHDvJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30761be8fa8so49274181fa.2;
        Mon, 24 Feb 2025 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740414443; x=1741019243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhXRCNxJnJ8dZow1OlvTXJLJwEVfQM+CNtGvDdtiqB0=;
        b=LQJhHDvJOMnzeIG8JQHGS6h/4IqfM4s7PSEXwBErD2KrAlJ2utM31n0IK/ZbtoKvW9
         YCYga1cnXgFA+pVgqo/kQFJ2jad8kVa15JgVC9Vs5FWIqobVRGsp/AvlsdaZlRVLxpgX
         IUuqcihXpVqLSbY2rNfERYOHS2RQRxkzBNsaO4ldrMLwYh5Muwq6UPzArK4HNwCT2Bzh
         BX3qRICijyJfRXif6+BtkNsYJkFWzy/EA64/pA2AerAIkDM8wUXfUVSJFvjX4ix+YKvh
         hF7YeLW3l8aUMKPdjn54PxsFTznmyakbnmYQQlrPDYayujBMHK3GRgxiv4rkKfP24sDJ
         n1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414443; x=1741019243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhXRCNxJnJ8dZow1OlvTXJLJwEVfQM+CNtGvDdtiqB0=;
        b=Uc3Fqgldjk0iu/Uq56txo/I803GzMUo9cGOt0V7jojRY4DkC2Jh+r7uJOlW6odqm86
         O7HL5t5VRzR7AWVynbYWdqHWdRsMrA340V6N+K9ODUEu3/9sOksSCd8DZxpjBD/FuJK9
         QmlKl/Gw1ImMzDWa94XrAmP0OsBrNBDbv5xl+yCAcgOiteiK4mhkoji6jCZeVb9QKj9t
         MCLhyKBFRnBOM64f34eiZkLpVp3K2YYqwQ0jJ26ktdggToPzwKJDXUfL32eVYBXUMCw2
         R3imgtOL/SfBgq0yT62lllfwslI2JUhoqwt4PO5ybsZxEmZId7GWKDVVoidLxrU0/fEs
         5XbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfkWIK/BAjXE+TnMX7n+2y7qNw6TgspQK2U3VrBHvHECVbTmmqh+B8SkvM01lh8VpBaKOZ7LxosucfMzw=@vger.kernel.org, AJvYcCXzLQDGgnBPtdi0+gaFeWGnzjt4VHahHz8UH3i2NIN+93d3OwPOJ88Rw1mxX9IcKNxuSW27HrVFxW0K4tABH9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9JjmDwXF49USy2t9l8HMmNdmZGFR6QBhgmFCdh9RSzSaPL36
	VeSVP6oK+9sQNTf/Ibnjbvqbx2VO3f+77/tI/d7HDeHHfsA08Z2S
X-Gm-Gg: ASbGncvnEVypVKqLJH0JQVsOEgxIIXi0LIqUatRWJhb5sH+brk9XDK8xwPbjDxxIc9J
	QVqpts7KJZMpeLM7JurgV7uIbSNoiorjiVXnsPe8zU6CKV5DIQ5u0S30S+7zknGt9HTtKE7Mh7O
	0aNaBxNTLTH8R7zCZHXNDFSvzBPuXH1PZOXelR3whQmyVvLt0JNznhlb7sczvbwL/M3A1kHhciE
	p0IDX79hVx1/tENojOyoXyDWQtYCO3SAZsUScxMZCkrQA4tJc683tQ9MlnpQdQJrbqwNA2l7/ME
	BlmADHuwudc0ZNQWGujZRsA/iIOXROn29UHnFAL+SWbgLKEhnrno0lDV7wOYaxBI4JhiqoJ8
X-Google-Smtp-Source: AGHT+IGifLN+BkJJASBV49lEfWIaIINPrBJ23N3ztsheqn5LrpjibwTh5MaO/IGC2B4XFQnSgLuzJg==
X-Received: by 2002:a05:6512:308b:b0:545:56c:36c7 with SMTP id 2adb3069b0e04-54838f59115mr5828030e87.41.1740414442323;
        Mon, 24 Feb 2025 08:27:22 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f08332bsm3478218e87.48.2025.02.24.08.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:27:21 -0800 (PST)
Message-ID: <487bb34a-e304-488a-80d5-97cf55ea25d0@gmail.com>
Date: Mon, 24 Feb 2025 18:27:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>
Cc: dakr@kernel.org, robin.murphy@arm.com, daniel.almeida@collabora.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <CAH5fLggU_sU56dEz6hQvMwjY=G2TuC9GYiVEBZFtE=Tk2QW4Fw@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLggU_sU56dEz6hQvMwjY=G2TuC9GYiVEBZFtE=Tk2QW4Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/02/2025 15:21, Alice Ryhl wrote:
> On Mon, Feb 24, 2025 at 12:50 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> Add a simple dma coherent allocator rust abstraction. Based on
>> Andreas Hindborg's dma abstractions from the rnvme driver, which
>> was also based on earlier work by Wedson Almeida Filho.
>>
>> Nacked-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> 
>> +    /// Create a duplicate of the `CoherentAllocation` object but prevent it from being dropped.
>> +    pub fn skip_drop(self) -> CoherentAllocation<T> {
>> +        let me = core::mem::ManuallyDrop::new(self);
>> +        Self {
>> +            // SAFETY: The refcount of `dev` will not be decremented because this doesn't actually
>> +            // duplicafe `ARef` and the use of `ManuallyDrop` forgets the originals.
>> +            dev: unsafe { core::ptr::read(&me.dev) },
>> +            dma_handle: me.dma_handle,
>> +            count: me.count,
>> +            cpu_addr: me.cpu_addr,
>> +            dma_attrs: me.dma_attrs,
>> +        }
>> +    }
> 
> The skip_drop pattern requires the return value to use a different
> struct with the same fields, because otherwise you don't really skip
> the destructor. But I don't think you have the user for this method
> anymore so maybe just drop it.

Ah, yep. I agree.

> 
>> +    /// Retrieve a single entry from the region with bounds checking. `offset` is in units of `T`,
>> +    /// not the number of bytes.
>> +    pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
>> +        if offset >= self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY:
>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`
>> +        // and we've just checked that the range and index is within bounds.
>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>> +        // that `self.count` won't overflow early in the constructor.
>> +        Ok(unsafe { &mut *self.cpu_addr.add(offset) })
> 
> The point of the dma_read/dma_write macros is to avoid creating
> references to the dma memory, so don't create a reference here.
> 

This is embarrassing, I thought I had changed this already in the patch. 
My local tree had this already fixed. Anyways thanks for catching this!

/Abdiel


