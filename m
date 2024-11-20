Return-Path: <linux-kernel+bounces-416394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD3B9D4438
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FBD281472
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0B41D0DE6;
	Wed, 20 Nov 2024 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCPP6AdY"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014751D0947;
	Wed, 20 Nov 2024 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143383; cv=none; b=L4JKEqckTQRuyRVEVf1DUQ8R0neACs853PbNEGuQIoX+Jjp9AI9lk5ZlueDRPa3mt4T1tdUR75C72uxqtASJe1IGefB5zPjMq88LQi5ssGkEwhs9cZelsyemPpiQZnDokoW+aWe8xDc7+IRyHzZgm2jqZbXl0RMBCSlgra8wFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143383; c=relaxed/simple;
	bh=L5JPavDv6jkOs8+4SL1iJB89HN6ikbiWc++GnD2aw9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVfhtW5UouQLaY/MfdhG165Ew4D5JA7lfzG7vFt3Bj3w6jyStBIheTA4ljY4pCiq/Jyp36cBI+vPBFAklY9mTPa7QS11D+x85LkWL2zagwm+uyYljTomXXCTSBWfUPb/zygQr4PxHF4PVzWI2sRrW6tLNMyR9OTTKFoUXkB/qg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCPP6AdY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da3b911b9so260191e87.2;
        Wed, 20 Nov 2024 14:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732143379; x=1732748179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDe+ut7FU4NjsmyCYmZbNnNl7UOa9iCRRrQvfMKje+E=;
        b=NCPP6AdYLIXtvQgzSwK2Nc6iMviR2hMYUizmdQEGIbXEhtMr7ZVtGNUXYrsPYzlGwU
         6644cvNRZnNWbDPzsGMRprdATzQIyVepY59w6c1sqJNDKWWZITdjCIWRUWEBLXPoe1eq
         ucUS9Ol8WkGVt3bKr1yJ47J6vwvF0RbyCqbMlRrrcnZ44WFe5Xb6EiH13eafanf+BEgE
         HyfgJTANWASit4ZVdC/vhrPEEiVVyUD5tXfVmq2RSywC8Kv9y8PTr5VoCuAzJoUnyKzJ
         eyFi2PIGnCKh3RBxyu1jJA/moIuB01PjFMXa8CzpXGHmanmGcTzTS/FN3j4edvEOjj69
         71WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732143379; x=1732748179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDe+ut7FU4NjsmyCYmZbNnNl7UOa9iCRRrQvfMKje+E=;
        b=oLrUExB/2vK/TFJpOqeqTYu3AaTALLJEq7Is8b5tEGq6AqMoYg8CzbnINypA/MgfCq
         yC31EtpIKY29V5TFzkTHwWx0CP0mMR6fRHpY6n3m2iIi5Y8QH8ySGwiiSCUB31im10CN
         i8/QPBmeBtVZwqqjI4KkurnY8cjettRzNup9tOrQtpR2l1eKBoTMY5To1Jbq3up6E6Jo
         S8rJ/5RH8LSqcyoG0t7cbjGpNywBFdx6wIXBPA7e6TJ2shabpvVDh7agcpfqM/DTSP9b
         GxP8Eq+ZVzek6gV6Jon88mmVdnr+qv3Q7ImSmth8xSIqTL5b1dynMszhnLuMucA6g2j+
         JMYg==
X-Forwarded-Encrypted: i=1; AJvYcCUTxuNu4+vP9Hxrmbs1k08OnGYWrwdC4YrGKezndRr2nQM7t5eSApvsF3sovf4MXCl2nle0a48DSWSeKRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/8d9PLnKr3uZW0VVWRo+viEp/sp15B48DxCD7Q3GGu/Mispl
	DbQPBgBJyOXbig45No+xIAxI8+8Zk72xscU4Gtu8e7lV3fwH4j/b
X-Google-Smtp-Source: AGHT+IEPWWHE/H8MR95ODYZ/MAqZO2vFJWEoMmaT8xgsBQiNCOjdaFjg85Aupur+Yw0QashfxHHKHg==
X-Received: by 2002:a19:8c1b:0:b0:539:f953:2da7 with SMTP id 2adb3069b0e04-53dc136df2amr1696512e87.50.1732143378777;
        Wed, 20 Nov 2024 14:56:18 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd4723ffsm777283e87.193.2024.11.20.14.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 14:56:17 -0800 (PST)
Message-ID: <43a07c04-2985-4999-b6d6-732794906a36@gmail.com>
Date: Thu, 21 Nov 2024 00:56:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] rust: page: Extend support to existing struct page
 mappings
To: Jann Horn <jannh@google.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <20241119112408.779243-3-abdiel.janulgue@gmail.com>
 <CAG48ez3fjXG1Zi=V8yte9ZgSkDVeJiQV6xau7FHocTiTMw0d=w@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAG48ez3fjXG1Zi=V8yte9ZgSkDVeJiQV6xau7FHocTiTMw0d=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the feedback.

On 19/11/2024 19:07, Jann Horn wrote:
>> +    pub fn page_slice_to_page<'a>(page: &PageSlice) -> Result<&'a Self>
> 
> Sorry, can you explain to me what the semantics of this are? Does this
> create a Page reference that is not lifetime-bound to the PageSlice?

This creates a Page reference that is tied to the lifetime of the `C 
struct page` behind the PageSlice buffer. Basically, it's just a cast 
from the struct page pointer and does not own that resource.

>> +fn to_vec_with_allocator<A: Allocator>(val: &[u8]) -> Result<Vec<PageSlice, A>, AllocError> {
> Do I understand correctly that this can be used to create a kmalloc
> allocation whose pages can then basically be passed to
> page_slice_to_page()?
> 
> FYI, the page refcount does not protect against UAF of slab
> allocations through new slab allocations of the same size. In other
> words: The slab allocator can internally recycle memory without going
> through the page allocator, and the slab allocator itself does not
> care about page refcounts.
> 
> If the Page returned from calling page_slice_to_page() on the slab
> memory pages returned from to_vec_with_allocator() is purely usable as
> a borrow and there is no way to later grab a refcounted reference to
> it or pass it into a C function that assumes it can grab a reference
> to the page, I guess that works. 

Yes, I think that is the intent. I appreciate your help in pointing out 
the issues with using refcounts in slab memory pages. As you can see, 
page_slice_to_page() only returns a Page reference (not a refcounted 
Page). Hopefully that addresses your concern?

Regards,
Abdiel

