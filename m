Return-Path: <linux-kernel+bounces-414250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E354A9D2543
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82FE28272D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F21CB9E8;
	Tue, 19 Nov 2024 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c12co647"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA81C727F;
	Tue, 19 Nov 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017982; cv=none; b=I33+9rzv7XI2LgohHOpUefK8XIiep5MSY7zw3vAJ9/y3pJ4Dr0cjqLFrVQfP6PmLrFDofy+aASRDK+8f2440y1uZLcMrIgRatKUwHUio56Q232BMn8NgMzRsTqlgHfJS0z7cpObZhRPwPiHQVct+de5n7KfTJubqT1fxwteIU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017982; c=relaxed/simple;
	bh=KSZskURH9NkN1WQnK9ULNoeJGX1O2vi9QZt394mZgfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QliGqwAv5DYfJvEi+LrEmKPPQVuamsFbAybg5r60EoXUEWEaxFQXku72zA2eFXx2bae+9th0Ls40A/EyIY8JNDfcnoM4O22mHm9P6K3Atyoau2B+wanCo0Bfy9ndXMVrNLgiY2LVW8izbzghFtcqV8ZvCq2iXM9h3HUNajypOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c12co647; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e59dadebso1107787e87.0;
        Tue, 19 Nov 2024 04:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732017979; x=1732622779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjIx5HKi9rJGLa+D+fv71k/Tg4v7mgWDmWtmLnRcJog=;
        b=c12co647wk9ElseHnWXPcBXL+htgO2tXIfo96wCNUzIKE2VMi0zEPUZYC4AsFt2v/W
         3LZo585Bs22fVbvlaUqKvp+tl+wnecWT2UlwRNjLxBZ9AIxzla53VnYjk4Z2RjaY16Tj
         eMhmBQoJoElBblyIdKY6bg40C94AUBens5lYP+Gh1TLfCQHPJcCrGC/baxPOyaPCME04
         vVkwU6V5iqNOgctYU/YUnS0H3i+UluPYC6AHRCQ1r1vQQiRNREdGQneBTFsde4RAAn75
         5RFLowyozPC3ZSsiTAg1ltYb9otHUucotQ7sP/VqK5wCecqRpCqn/I3rzgEExuesxElW
         cdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732017979; x=1732622779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjIx5HKi9rJGLa+D+fv71k/Tg4v7mgWDmWtmLnRcJog=;
        b=aK+1b8PVkep80rEJcKmSZJ5n65waxRQVvV8W5AJC8fBxF6dTUebizNXk6e6LXRfLUR
         lZ3/O88L0qzSxAKUWB4tB3qxyvyYR7hBOIlooPb4CgskZnVYJAbgzHNt5KDitFn00RWb
         frq8pXsIWPKnxAP5zWdM3WbdkhisM6O6r7IF3JM/4ykMuV04SqqYJIR8wd2Rw0frHwfj
         zBc79slZ45SRbYHlFSZZdbHibgG/674CH1NVvBDe6s4dQ+9Tn8dEcoS96vkiUgYUWbG9
         yHdbLy2s6bTFTzwBS+IUkk64fL79uSn91kk++taS3MFPzi/wgVjw86v/dWs6xgDnMCvd
         HGBw==
X-Forwarded-Encrypted: i=1; AJvYcCUcGYhioxRnQTIIVjqtyr7ApqfRGyp/1txBZvXATafq0itieGyqOy8/IqDh5AzPuik0M3xUGMAdAvM04Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/6n2Jt4sS5DELwtapjAaw98daodg4co/Sv6QrNT6FcGYd5c7
	QG6aE3epZttcv9eEh3yetuGyx9y01pNQwf7nAKHBfHX9+LXWzAdE
X-Google-Smtp-Source: AGHT+IFx97sth5FGl9bUbO/5Yx1nzjCRvFo9L4FIoCSP5ds7MrGV+Z4Pt2t9WZBfMPASYCZFsr8g5A==
X-Received: by 2002:a19:6a17:0:b0:53d:bc66:b371 with SMTP id 2adb3069b0e04-53dbc66bb44mr1972160e87.17.1732017978715;
        Tue, 19 Nov 2024 04:06:18 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd4723ffsm282180e87.193.2024.11.19.04.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 04:06:17 -0800 (PST)
Message-ID: <3c546153-5677-41e6-9bbe-dbf64de751da@gmail.com>
Date: Tue, 19 Nov 2024 14:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rust: page: use the page's reference count to
 decide when to free the allocation
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <20241119112408.779243-2-abdiel.janulgue@gmail.com>
 <CAH5fLgj_BW22yopAdOLpSQaK97eeUAQb4jfn=KgOqNgCJ4CsqQ@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgj_BW22yopAdOLpSQaK97eeUAQb4jfn=KgOqNgCJ4CsqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19/11/2024 13:45, Alice Ryhl wrote:
>> +    pub fn alloc_page(flags: Flags) -> Result<ARef<Self>, AllocError> {
>>           // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
>>           // is always safe to call this method.
>>           let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
>> -        let page = NonNull::new(page).ok_or(AllocError)?;
>> -        // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
>> -        // allocated page. We transfer that ownership to the new `Page` object.
>> -        Ok(Self { page })
>> +        if page.is_null() {
>> +            return Err(AllocError);
>> +        }
>> +        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::page`.
>> +        let ptr = page.cast::<Self>();
>> +        // INVARIANT: We just successfully allocated a page, ptr points to the new `Page` object.
>> +        // SAFETY: According to invariant above ptr is valid.
>> +        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(ptr)) })
> 
> Why did you change the null check? You should be able to avoid
> changing anything but the last line.

Changing only the line, it complains:

86  |         Ok(unsafe { ARef::from_raw(page) })
     |                     -------------- ^^^^ expected `NonNull<Page>`, 
found `NonNull<page>`

Unless this is what you mean?

         let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
         let page = page.cast::<Self>();
         let page = NonNull::new(page).ok_or(AllocError)?;
         Ok(unsafe { ARef::from_raw(page) })

But what if alloc_pages returns null in the place? Would that be a valid 
cast still?

Regards,
Abdiel


