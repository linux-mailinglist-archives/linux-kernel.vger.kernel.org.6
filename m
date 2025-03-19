Return-Path: <linux-kernel+bounces-568736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E31A699E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE598A63E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89478214223;
	Wed, 19 Mar 2025 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwKbKUJe"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54F819;
	Wed, 19 Mar 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414500; cv=none; b=AC4ucgfRHj9+Z+cU4GI/7gsThmtErpdCbumfNiGImRv2aytyX539ZKBCGhaT7kP+bwxj5DA7Aq9N8Efal6cA/C5ltJLei/sDYIW8nBtDODK7N1y11LeqERPreT8wrAtcRK2Nf82y2D9XbDf0jkyqLqtBd3VGVH2XGAIJjo/CfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414500; c=relaxed/simple;
	bh=HNhrLqHBjSWDpUKy7bR0ZKV8TpiO4BGW+PfF5xbKpU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CH/fr3dTl4Tq2WOh5Q5UgdKkUf0N1eLi5lYwqPhSjT/cBD6xOpCK5Tn6F0ofgDXkIy9MlCMwit6je0Ftbj4kw/ramkEvi/hvloEmJMJGjGFUCDDh39zDuhwaFM098Z0M9bwhx3Ylo6vXcrloheV6ji3Iovhap+DqJ9paeY9y4wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwKbKUJe; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac29af3382dso11902166b.2;
        Wed, 19 Mar 2025 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742414497; x=1743019297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhXyC50rPXEulYo8pufxyLKKlG33MVYM86PDyMLQEjM=;
        b=GwKbKUJenljJMq3a1w9BigZN0jRpNxKmTh0BuMmBbPyMt73o+kMGyFmTflQ1JKfVPZ
         TutNvcvbKRSxhuAzWqmYUUMNekJyoKUVqLbzkD+3axgPM3UaI8WdV1j5PATDpZQCQmUk
         wKQCYHMnBllllAC0zdHNabs84niVZcWWOiTI4DRB7D167d37qm7aP7/v5pTglrtSXyEU
         bFdDuvifHilEL+lbiwpft/rVeK/C/uo2TN8EujqjUB1t9HR8f/2azbf29Jo6dz6CA/E5
         oFtXhiQ54PUf0FZyWBOhQVkloDuiO6X/aMlkGdgNe7Jsje24vYmkwx5/fjqadXauIVBX
         kuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414497; x=1743019297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhXyC50rPXEulYo8pufxyLKKlG33MVYM86PDyMLQEjM=;
        b=q5wmy/n/gxrQbaZQNjkqbAaGwnWKFw2x8QTn1mbeQEnA/XWR+zBN2P/wbi56aTsp1k
         QgbiA/wb0c5KiLR2luOGE4nO/T3zp0vLNpj0r8rWyORdhmdpRDZOOsbP+kpSrDWUk7LB
         Iqvc2IM8HOs9uNK4wFvnn1qTsZromb3AdXjF6wfQhGqnVznBGb0Re8+mcY2isSkFrtfT
         AdEY8KhMt38VYUCaoQRCYRhG8utT3nIFvIxZu77TbRCAtLhBnlzcjErkke3mraU+EPQ3
         KlUlnedw6d7VHpkzRcxtCaKcUd1zndHeP5ZOGSpNavaKnJbHt3mYj5629hGT9GjtJR7n
         HU4w==
X-Forwarded-Encrypted: i=1; AJvYcCVDF9THG4zpYazPHuwtwYrLUTz7Pyns7kIXSlaJ+9iuyFCWbpv1Q5I/kICUd3pew7kU3WquaxY5wkUqjDQ=@vger.kernel.org, AJvYcCVHFVBEYv1HUqrnXDYx+Bqzu2imc7CUYx8My4ax7b3Ak/Gd9kilOnJG+X/wdDiFIFqH+iWVx4iAPIQ7IgL2cu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcuOSNc26ClJX2mNtPg8I4GAOXvnURkTHagncPSflcDPLeQGbQ
	XDG6GSVDzcrfigU2WN5G1dAHlP3S83a1Sjk/L3yqaSQbsMMzUOvA5ov9Xgv+
X-Gm-Gg: ASbGncstwpxUihL0CaEEfKq5JH1eeojSblyv2nuz9ovmJ9NvL4bk5BrrL2QSN5eHjPi
	MzSE3SFqZ9ggaXYVm6lD8w6sSHlZNOq9KRQog70H4r/Q5fni/68mi/JmdYPdLBNOesBAO40Irll
	c5siqRZ2pmKkNdOZQBwPF481JaARAVotz4J3aAK86KOnPyw6CmQgNyTY7dPQhMyznpZOQK4CfHx
	LkI+lHkt7qL3KQLaSGAucyZC139h1YHNeO24Bn31Rp7HaqTZGw92s8IKZ0102I2cnxPnvBPt1BD
	we5XB0VRe61m57YPH3kaLM3vBVuyYDlBIBo7Me41SSuKMtNWkkslnQ==
X-Google-Smtp-Source: AGHT+IH4v2FvHEUxd5FYdC2fYN6dNH086/XAq4/VjkM93mNXAshBHwvK9C1zgYPPRtB0EvGBm+ePxQ==
X-Received: by 2002:a17:907:bac2:b0:ac1:effd:f2ea with SMTP id a640c23a62f3a-ac3cdfcf28fmr114224466b.24.1742414496982;
        Wed, 19 Mar 2025 13:01:36 -0700 (PDT)
Received: from [10.5.1.156] ([193.170.134.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ce26fsm1054276866b.89.2025.03.19.13.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 13:01:36 -0700 (PDT)
Message-ID: <52db38f9-427f-4cea-826f-eae5f39480c5@gmail.com>
Date: Wed, 19 Mar 2025 21:01:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rust: iov: add iov_iter abstractions for ITER_DEST
To: Alice Ryhl <aliceryhl@google.com>,
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
 <20250311-iov-iter-v1-2-f6c9134ea824@google.com>
 <XR-HMXHiYqCkDupCkyfLz4Rz-ucS6r5sCg1TmHQ7KeqAvf7-4ofJJcSCc2jKmS8WDivMc5oDgAYThptx7X_ExQ==@protonmail.internalid>
 <439baec2-dba8-4dab-abb5-faa14fbda943@gmail.com> <87v7s4g7ev.fsf@kernel.org>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <87v7s4g7ev.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.03.25 8:14 PM, Andreas Hindborg wrote:
> "Christian Schrefl" <chrisi.schrefl@gmail.com> writes:
> 
>> Hi Alice
>>
>> On 11.03.25 3:25 PM, Alice Ryhl wrote:
>>> This adds abstractions for the iov_iter type in the case where
>>> data_source is ITER_DEST. This will make Rust implementations of
>>> fops->read_iter possible.
>>>
>>> This series only has support for using existing IO vectors created by C
>>> code. Additional abstractions will be needed to support the creation of
>>> IO vectors in Rust code.
>>>
>>> These abstractions make the assumption that `struct iov_iter` does not
>>> have internal self-references, which implies that it is valid to move it
>>> between different local variables, and that you can make a copy of it to
>>> get two IO vectors into the same buffers.
>>>
>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>> ---
>>>  rust/kernel/iov.rs | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 139 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
>>> index 4498f65e1f65bd964909810c020db3a9f8fae389..dc32c27c5c76d059562fd7c6b9d4b178a8ea7c81 100644
>>> --- a/rust/kernel/iov.rs
>>> +++ b/rust/kernel/iov.rs
>>> @@ -7,7 +7,12 @@
>>>  //! C headers: [`include/linux/iov_iter.h`](srctree/include/linux/iov_iter.h),
>>>  //! [`include/linux/uio.h`](srctree/include/linux/uio.h)
>>>
>>> -use crate::{bindings, prelude::*, types::Opaque};
>>> +use crate::{
>>> +    alloc::{Allocator, Flags},
>>> +    bindings,
>>> +    prelude::*,
>>> +    types::Opaque,
>>> +};
>>>  use core::{marker::PhantomData, mem::MaybeUninit, slice};
>>>
>>>  const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
>>> @@ -168,3 +173,136 @@ fn clone(&self) -> IovIterSource<'data> {
>>>          unsafe { core::ptr::read(self) }
>>>      }
>>>  }
>>> +
>>> +/// An IO vector that acts as a destination for data.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_DEST`. The buffers
>>> +/// referenced by the IO vector must be valid for writing for the duration of `'data`.
>>> +///
>>> +/// Note that if the IO vector is backed by a userspace pointer, it is always considered valid for
>>> +/// writing.
>>> +#[repr(transparent)]
>>> +pub struct IovIterDest<'data> {
>>> +    iov: Opaque<bindings::iov_iter>,
>>> +    /// Represent to the type system that this value contains a pointer to writable data it does
>>> +    /// not own.
>>> +    _source: PhantomData<&'data mut [u8]>,
>>> +}
>>
>> It might be a bit nicer to add a (private) struct 'IovIter' that implements the common operations.
>> Then 'IovIterDest' and 'IovIterSource' could store that struct and forward the implementations to
>> it.
>> But I'm not sure if that's really much better.
> 
> Yea, I was thinking the same. Maybe we could have an `IovInner` and a
> local `AsIovInner` trait that would give all the shared methods?
> 
> I am sure Alice knows the idiomatic way to achieve code sharing here.
> 

It would also be possible to use generics here.

Something like (Maybe using types instead of the const-generic):

pub struct IovIter<const DEST: bool> {
   ...
}

impl <const DEST: bool> IovIter<DEST> {
   // Common functions
}

impl IovIter<false> {
   // Source functions
}

impl IovIter<false> {
   // Dest functions
}

Possibly also providing type aliases for 'IovIterDest' and 'IovIterSource'.

Cheers
Christian


