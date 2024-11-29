Return-Path: <linux-kernel+bounces-425624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528AB9DE7E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D3E161A36
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143019F424;
	Fri, 29 Nov 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcuOhujs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7219CCEC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887758; cv=none; b=rs61p1N3VDce8klrZfS1MMoWDFJIgJecpCJF0dusNcwJzoDnSYj8wISW7fHYF0qWZnwHKsjoN2c3QiE+QFpo1gJ5X6G/ml4BtrngpaXM5JacBLgjn/j0t61q1kaX8Vvbf6JtebZqodikv6Yh/l6nCPg25D/CDbtZb6k9rcbjN4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887758; c=relaxed/simple;
	bh=aG2sSjgDu5Iju4YthQgzNWTfdj6zbUCpREK1tLfisfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D13yALuQUDndqovbuAyMf+z9+5uQUQdDwaPSW7V/TZ13TFryKvFscPA45hCCHh/6rLdfDZ12K6i98k7OdQ/MjYl2Zq7q3xJcNu6r+jJGFZ/k+6w4tdaNcOWVRmGuHCaewck5q/s23GUKIuuzj8gll4yMXVd7b8kB0RnOgspaoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcuOhujs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732887755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V4tyi4yr8weO93NKnj4WXd3cQqnP2BTlprWIVXcZzBs=;
	b=YcuOhujs+5spSgNcKZdRhcidsPr7/AH9WirRd+LHUTJDlzMxQF4PUvgwnymMgPznmmD7LW
	ufRjwQlpX8Mr4t3bT4Bv1WG9+0GH+O275kcpYf1B4pHXYkUVQB1Tbc3RK3eQx8D484tFya
	I9fpCmi4D81O6nvucny/jkdJWcZTfG8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-u88YRSHVOd2MRSTqWY8FOg-1; Fri, 29 Nov 2024 08:42:34 -0500
X-MC-Unique: u88YRSHVOd2MRSTqWY8FOg-1
X-Mimecast-MFC-AGG-ID: u88YRSHVOd2MRSTqWY8FOg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e173e8d3so25396f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732887753; x=1733492553;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4tyi4yr8weO93NKnj4WXd3cQqnP2BTlprWIVXcZzBs=;
        b=Ej3yn4dhCpr6hSVOTwxiDXbze1XwPxH3H84YSOEHxKoN9gtGthCcaZ4Lox3sxLaY2R
         Z+iH/2HR3vQ/fXofkPeFGM+5JkLn5Q7WfZ6SWL5gppGQ0ZVchc7crDbTxSx8XVIzxv4O
         F+FmlGxfaG2hv/1tmDGL7AeXRHE4ZW7buHPgHxIPOCiOkHGu1fylVEJ+pLrsK/8uSnoI
         FjFQUYIw5xSckfXmhUjiM8VrzVfFgYIvLGRTU7ai+DRyzSf/EUWuDjeKJ9LsWkxvhU4R
         xvYWNbH0YlGQrqzx57qZt8dRr13iha3UCuaEpN/qWPsyf6//xVqxcFjHpoyQOXy9R54C
         u2Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXCgstZ0OtxwTv+Uyh+/JANk8uT9YUpp+7qa+c7C0CjnW4RHGzkMDFyAEjMHfx94fER+KLWNU2NwOdLVWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8CAFrCBJqR6LzeXJ32ZlGHIYeDLwo8jxLJPx5VrAdRpr112M
	FRyXizqr/7RaYddXbh6LIkixCUsdtdpgAg6gtqZ/W2GPYFG4La1EQurCQz3t52oWa1E1l+5RM+5
	j/OPMV94lCchs73gxbXe8nTMy8ghFIgUnGU43rhbU5/s9z9pnpdT3P7Z0z0+RcQ==
X-Gm-Gg: ASbGncuHmd8bqGSMRMQnSFD7YfRqbX7FOp5JvGtGSzqqRkcanmwHKE06rl4sgO8vSqD
	LyR6xKVLryNwxTbqTGMu2psvBznewSifH3BhGsPi2h3s6x8LMLqCUScWeB+PAbpNIUyeCaTih6q
	9dVsLwauGOz/RtyqMi67Llq8QtmTR2dU053lMEzPJYJxQDf5Nj5WwxQEfo0AFtSy82UIaKTA14r
	3QmsuUoz+Yu2eIjSWz9inPJKvSZ3gHvRIhgNcqQ9MGzWtYn00uYSHQ=
X-Received: by 2002:a05:6000:a1c:b0:382:4378:465c with SMTP id ffacd0b85a97d-385c6ef5a20mr11287289f8f.56.1732887753408;
        Fri, 29 Nov 2024 05:42:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVWOu8vC4BX+/G+QxaJZ3tXq9R7FuZZ7NKpNyvjSXGdUkyykpQKty0AL3uhh4SFSIZD5cAkw==
X-Received: by 2002:a05:6000:a1c:b0:382:4378:465c with SMTP id ffacd0b85a97d-385c6ef5a20mr11287261f8f.56.1732887753053;
        Fri, 29 Nov 2024 05:42:33 -0800 (PST)
Received: from [192.168.10.27] ([151.49.236.146])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385dc169d79sm2591698f8f.92.2024.11.29.05.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:42:32 -0800 (PST)
Message-ID: <f824d57c-6578-47de-9c73-c86c9c9e60b6@redhat.com>
Date: Fri, 29 Nov 2024 14:42:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: block/mq: replace mem::zeroed() with Zeroable
 trait
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, ojeda@kernel.org, benno.lossin@proton.me,
 axboe@kernel.dk, tmgross@umich.edu, bjorn3_gh@protonmail.com,
 gary@garyguo.net, alex.gaynor@gmail.com, a.hindborg@kernel.org
References: <20241128141323.481033-1-pbonzini@redhat.com>
 <20241128141323.481033-3-pbonzini@redhat.com>
 <CAH5fLgi9+d6PwZdU23xcF0p+m6mja3Dx8BufiiM-ZgLtDSqQDw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAH5fLgi9+d6PwZdU23xcF0p+m6mja3Dx8BufiiM-ZgLtDSqQDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/29/24 10:41, Alice Ryhl wrote:
> On Thu, Nov 28, 2024 at 3:13 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Isolate the unsafety in the declaration of the Zeroable trait, instead of having
>> to use "unsafe" just to declare a struct.  This is more similar to how you would
>> use "..Default::default()" (which is also a possibility here, but arguably
>> less efficient).
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/kernel/block/mq/gen_disk.rs |  8 +++++---
>>   rust/kernel/block/mq/tag_set.rs  | 10 ++++++----
>>   2 files changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
>> index 708125dce96a..65342d065296 100644
>> --- a/rust/kernel/block/mq/gen_disk.rs
>> +++ b/rust/kernel/block/mq/gen_disk.rs
>> @@ -6,7 +6,7 @@
>>   //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
>>
>>   use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
>> -use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
>> +use crate::{bindings, error::from_err_ptr, error::Result, init::Zeroable, sync::Arc};
>>   use crate::{error, static_lock_class};
>>   use core::fmt::{self, Write};
>>
>> @@ -31,6 +31,9 @@ fn default() -> Self {
>>       }
>>   }
>>
>> +// SAFETY: `bindings::queue_limits` contains only fields that are valid when zeroed.
>> +unsafe impl Zeroable for bindings::queue_limits {}
>> +
>>   impl GenDiskBuilder {
>>       /// Create a new instance.
>>       pub fn new() -> Self {
>> @@ -93,8 +96,7 @@ pub fn build<T: Operations>(
>>           name: fmt::Arguments<'_>,
>>           tagset: Arc<TagSet<T>>,
>>       ) -> Result<GenDisk<T>> {
>> -        // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
>> -        let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
>> +        let mut lim: bindings::queue_limits = Zeroable::ZERO;
>>
>>           lim.logical_block_size = self.logical_block_size;
>>           lim.physical_block_size = self.physical_block_size;
>> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
>> index f9a1ca655a35..1ff7366ca549 100644
>> --- a/rust/kernel/block/mq/tag_set.rs
>> +++ b/rust/kernel/block/mq/tag_set.rs
>> @@ -10,6 +10,7 @@
>>       bindings,
>>       block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
>>       error,
>> +    init::Zeroable,
>>       prelude::PinInit,
>>       try_pin_init,
>>       types::Opaque,
>> @@ -32,6 +33,10 @@ pub struct TagSet<T: Operations> {
>>       _p: PhantomData<T>,
>>   }
>>
>> +// SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
>> +// all are allowed to be 0.
>> +unsafe impl Zeroable for bindings::blk_mq_tag_set {}
> 
> This will have to be reverted if we want to split up the kernel crate
> due to the orphan rule.

Ok, I will look into using the bindgen doc comments then.  It looks like 
the idea is not dead on arrival at least!  Thanks for the review.

Paolo


