Return-Path: <linux-kernel+bounces-421391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 785CF9D8AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE081689F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FF1B6CEB;
	Mon, 25 Nov 2024 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6m4bXD7"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08E1B0F15;
	Mon, 25 Nov 2024 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553711; cv=none; b=qHhwafqRNsyqzDqx3nAAYiZghVteiZdm7wIjGXCXiL5mkZjl93cO53riHfwL12jfLUDzAyg3fxlgYVOD6zPEWmVBKHpn9KoaUD2TK5JSUVvxHpInWDZFewDB12Y2O+yLL/x+7FKdBCap6pI/LUDMKtdF0qqKNsSxCw6I6tvYKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553711; c=relaxed/simple;
	bh=+a0pZS2lWqZSlu33D1ccUnxq7uVqXrjVeP02nmmIABM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyMZrwYPoxb5H6X5HiQonGwsdz2CcoXSMJp8uS2LjwwCO3tKQ/L9RsMfTn9zXJKVBkZA4wR0jyCuPlcVcGcPdWmfQYk7kY9RQ3W0YBJa10EhuaUwFcy4spC2nNmGsUlwESgmF6RqX78omGaOIL1Ojs1Q1IM0CjomtwbVcSg6PBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6m4bXD7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso42768925e9.3;
        Mon, 25 Nov 2024 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732553708; x=1733158508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1e6I4plSDngJ//b0GeYuFdjW4/93fbKbdHUyBRYwFo=;
        b=K6m4bXD7nSiKQMBeGy7GnSin9Kax6j5OwpdHBACyvERfSw7N0OYuCoijy3axBUNNh5
         /NPXks3OTVT5hxktG1oESOiHY+X8E5SoFk2N6fMSJF+d21208QBQwXUtBO+uLEO4k5aE
         IlbvYtDNEkwz5pW+ycCCpb60x4D+WWrToND+ccHr+1q/QJhLzg1+ZTNRc4A//zDGUT/o
         /A0UoAuehgxtY0TkNkZtsiLp1HOeNVSHxwJWEEgcBY9x5RITKDfRoCUo2a3SStG2otDv
         A0WwpRcViTyNx1SqS+eSvALJPB6nsfQsfyDapr+eli5iHsD4Q9rHQB7Alscyt1wVfBaz
         odTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553708; x=1733158508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1e6I4plSDngJ//b0GeYuFdjW4/93fbKbdHUyBRYwFo=;
        b=qMA20elopTAKKtNKe/Suq95wfv5I69QBNcHG3diXEzF5psHXmuVYor82+3g6t9hBFs
         MuSDpCjOy1b1JNVbRiBcdPoUY4DSfUg9Dh8UgHfUnwceUAWOAqvjhPFIFo/YiBApNgwd
         3VhJ3j/FyMcvhecPB7N5IFTNYG328KTvGTGhx3ijXeHWWmvN6q1A5MpvDnRbGsksN3VZ
         3l+WhAm/lUmcDhb6XRwEKjoMTkI4IOWM9XIGgOKwBkRGx8olYBEoD4EXM9rU1BhO2v6X
         q/2QH7AsbMi1LGj97UG0lwltlQ4v4FayPqitLFoO94+JfzsbE6x7Gd7JVDCZg3CIJo4L
         3LEg==
X-Forwarded-Encrypted: i=1; AJvYcCVSFIH4F1lP9ofJqpm/437+YBWYqC1eHYqCq2+sMm9l8SCZ+RrXid/DdAVIUbukv92Z7S2a2vyNlskNKp5179Q=@vger.kernel.org, AJvYcCWus5VoPw6fN38SrbyTnr6qCHNlmjeuTkNIy3/SaUft9+DA7uIwyf7ZOTzj2z4lbbwVAMMS50GUopqS@vger.kernel.org, AJvYcCXpWVPpdj3D2SInyAFzSMPS9rVR4URvjrnUthZBwV52XXDtI3W7yO5MuLuChOrnWOreD0w9fGE7xYRAnuvI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw62Nz/A585o0oOAKg5dME3agf3KOBBl8uaZlxLDr0QxEPEgkQw
	GOBGvdc02/+F2OKFFAVcujoCCv0HqoRQWmwZWlkpeBXljWrn4DJj
X-Gm-Gg: ASbGnctLUleiTBMNds9Uk/4GFyjRu4ANCZphfmp/jvKzWQfvFZ0wsU9ETlpnxtBhnvD
	WM5jfo8vGlEb+FhvsCv3X0qEn/2VL/WqPUbigz9oOsUYVVVGZLuTWzhpIbuCA7iVl7hP1BCsdHb
	YhPuXqs1sZ41mjfIx+u36zjfW9FuKjw8ZIN/VuwePU8Y+JiTIMQrHwk6mMILHyJzC6Jo3gO1kyo
	WZei5tWxa33X/z6Amwvnhsvg/9s+JTUKm7WvH322rZ+NuGNUJ0V/102Fu4Ps0KJCeRut6rvyu1m
	to6AsVM6tXMJunWq2cnY8Q94aoX3ikCRr8wLh/+UWmXdRtnIrlXR13Wi+F/NK8r705sv9qDHqc3
	hL70=
X-Google-Smtp-Source: AGHT+IHcHez04x+2UBFPsY0MEQtZz1yMSZy3M2bsqI9vo6NcLRLlcDYUkZQtCjEOmGo/SjwWMUB4gA==
X-Received: by 2002:a05:600c:4fd6:b0:434:a1d3:a326 with SMTP id 5b1f17b1804b1-434a1d3a436mr19177275e9.6.1732553707801;
        Mon, 25 Nov 2024 08:55:07 -0800 (PST)
Received: from ?IPV6:2003:df:bf0d:b400:df4b:11b0:899:faa8? (p200300dfbf0db400df4b11b00899faa8.dip0.t-ipconnect.de. [2003:df:bf0d:b400:df4b:11b0:899:faa8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e103bsm204792825e9.9.2024.11.25.08.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:55:07 -0800 (PST)
Message-ID: <4d179a7a-3cf3-451c-9718-d20da6db69f6@gmail.com>
Date: Mon, 25 Nov 2024 17:55:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/1] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241122081257.1776925-1-dirk.behme@de.bosch.com>
 <CAL_JsqJ-cFq4jyFDnCWKy1b+7pNt8Tb11QF8vGoMb2G_4=dpBw@mail.gmail.com>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <CAL_JsqJ-cFq4jyFDnCWKy1b+7pNt8Tb11QF8vGoMb2G_4=dpBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rob,

On 25.11.24 16:35, Rob Herring wrote:
> On Fri, Nov 22, 2024 at 2:13 AM Dirk Behme <dirk.behme@de.bosch.com> wrote:
>>
>> From: "Rob Herring (Arm)" <robh@kernel.org>
>>
>> The device property API is a firmware agnostic API for reading
>> properties from firmware (DT/ACPI) devices nodes and swnodes.
>>
>> While the C API takes a pointer to a caller allocated variable/buffer,
>> the rust API is designed to return a value and can be used in struct
>> initialization. Rust generics are also utilized to support different
>> sizes of properties (e.g. u8, u16, u32).
>>
>> To build and run the Examples as `rustdoc` tests the kernel Kconfig
>> options `CONFIG_OF` and `CONFIG_OF_UNITTEST` need to be enabled
>> additionally. Besides the default `rustdoc` test options
>> `CONFIG_KUNIT` and `CONFIG_RUST_KERNEL_DOCTESTS`. This even works
>> on non-ARM architectures as a test device tree is built into the
>> kernel, then.
>>
>> The Integer trait is proposed by Alic Ryhl [1].
>>
>> Link: https://lore.kernel.org/rust-for-linux/CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com/ [1]
>> Co-developed-by: Dirk Behme <dirk.behme@de.bosch.com>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>>
>> This is an update of Rob's initial patch
> 
> I have my own updates on it based on the discussion. It's a bit
> different because I've reworked the C API to better mesh with Rust
> needs. 

Great, that sounds really good!

> I just haven't sent it out because I've been busy with other
> things and it's the merge window.

No problem and totally understood!

> You asked me if I was going to work on this and I did. If you want to
> do it, just say so. I'm always happy for less work.

Sorry! I have worked on the review comments and thought sharing them
might help. If this is not the case, then sorry again. Of course,
please share what you have. And ignore this one, then.

Thanks

Dirk



