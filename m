Return-Path: <linux-kernel+bounces-390081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BFA9B753F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477281C21C32
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A214A084;
	Thu, 31 Oct 2024 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw2T4Vu/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC591487FE;
	Thu, 31 Oct 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359196; cv=none; b=p6DFd0l0qPRnlN8L/VYIoZf5lsfZgEI7ERAu6PxDIengM9vhXBfebzK8yg9Ups42/11A3smpvxFqfpTeED208YZ1DO6DOBYDSIdONV3li8W1zI0rheNgqbUUGz2AcpVeWYBOwZGKUkSWS8E1wWLyrsevl22aDzQCzR3bm4AxRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359196; c=relaxed/simple;
	bh=SgOgFG1BEPIvTLIqnCJzdAkzonty5Cbue+t1fnhQ0Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMjKmjpNKzu0xX94z32J+4fWtIjXsaX8+nX6GsLqFN5x06ReeYhq75NUcFit4YqFQEZSrAWGDr7p2fFnSVarsnozc7oQygr6dLRi1WqgD33OFsieMUolL+x7tKrQjAygb/ukcqSYrRGOhij8eaH5BcPBpQJS6NdPJ68JUu/DreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw2T4Vu/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso5080655e9.0;
        Thu, 31 Oct 2024 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730359193; x=1730963993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbUNa9NvVBQiQBCGAtj9LNHK2+u/05a6j0plbfulxqw=;
        b=Pw2T4Vu/SG/HSjTiqaFtrOSC/2WVWY2LUHcvzNVaPYJyikIt4niWBjkSh6hO7RJF9A
         dIQy8urtO78I5oltC7FG8tKbRbr+KMkVydeNy1wjM0TI6QXRI/dZ1bf8vpbn2lTb/54d
         T0A4ITX06S0bq9aZqbXjHwMw+ZUVLNOrrVlcXJTQZmM7c0dpGhuj4Q1RhHyNy4k1WSQJ
         p9LJZweSOjgv4MjX49tmzdL1uOCSkXEj2ovj7PDGzKfIq17n6Eh3F4hwM+FFaXK2hmQH
         sjaaJjZ/XKBldoh+T1T4KIvElYYP3FjrD5a2KMk+vlkakCN+rSX2eUBNmCJ66wAoDp8j
         X6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359193; x=1730963993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbUNa9NvVBQiQBCGAtj9LNHK2+u/05a6j0plbfulxqw=;
        b=n+/oHLfbAFn8nm/9Vu0j5mJV2uiPVVF3DHa+GoUObnPq/MRvmc/mYjdXA30tL/pcim
         XwZxVr93tWYPlVZ8tC+wOXFbmlA4S5h8bh+Y/OIU2a4ojjGxIBzFbX70XxAWPK385Ezr
         zFVmVXxFXMTei1VE1gYgaSxvVvxfPimhkak/oV7pYCKijIxOYbIa5dA5iBg9uTNt3OJw
         Q4Y76ddi/onWnj5QjmvvVHMImqutfJ2r1JMRsjv82va64AxcC8OyzqJp/md15o2PUTZ3
         a94YKhN1ULu7z1aj5HfkCHbZkG16lAdDIH685Sjii+KSuKQadr4VpVWMFWIizmhuU6PW
         CR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUatvRg+ZctfBtjiS5iv3/z1PFF0okNSrvjh6C1chSjPkjz5PT9Bp6IW0QhYd0cDwtsfANHqAesDDvA@vger.kernel.org, AJvYcCV/bppR9pgAyvAo5fN2v6+XfdLGWyiuD3GBnNOU2G6I/u6HaTcwx4mQzUqaPOVKM+u9zOYkCmKTNAgkmMHayB4=@vger.kernel.org, AJvYcCWKSzR+CxuJHVrHWpjj8W53I5hwcV6gOd40P+kpWXpiUuAZUJff7WHXHdcaKGUw7ZYyHhbODpXJBRW+6hog@vger.kernel.org
X-Gm-Message-State: AOJu0YyTX6alGIg2l4TNycEzMY3mz6mf5tQs5lYElv5l/KDpvOEHv7sa
	AFLYqxOxbvIia5OBQIJrsoymtPl2sS0jiHfzlIkFwNE3KStp1buw
X-Google-Smtp-Source: AGHT+IEbCOzwenjTNJj6dCH8Qbf6Mz1j8NxxWiASasAsuFPMRKYq3tazzD1aZw/KWBKRAPs0x/1UAA==
X-Received: by 2002:a05:600c:3c8c:b0:431:4fa0:2e0b with SMTP id 5b1f17b1804b1-4319ad146b1mr144630435e9.28.1730359192519;
        Thu, 31 Oct 2024 00:19:52 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:5538:841f:81ca:6a17? (p200300dfbf0db4005538841f81ca6a17.dip0.t-ipconnect.de. [2003:df:bf0d:b400:5538:841f:81ca:6a17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d429dsm1219961f8f.31.2024.10.31.00.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 00:19:52 -0700 (PDT)
Message-ID: <a5d44a42-bcc0-4512-a324-7aa8506b4fdf@gmail.com>
Date: Thu, 31 Oct 2024 08:19:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org>
 <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
 <CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com>
 <CANiq72kaidDJ=81+kibMNr9jNxg467HjOm9C_4G7WRvaiddGvg@mail.gmail.com>
 <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com>
 <CAH5fLggCDiKUu_dvJZeJr8UD5RvUpqRJbdYKf1F3_MvCdOVK6g@mail.gmail.com>
 <CAL_JsqL+b-f5K24qTxyA09c_QPeb07s4Hb=s1VqrdksBB4BQ=Q@mail.gmail.com>
 <79c47555-c9e9-4ff6-8c43-c7c26a91afd4@gmail.com>
 <CAL_JsqJkkUk6AoAdgfVHROk=wpRo0En=gi7zwXe6S7LUEsdocQ@mail.gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <CAL_JsqJkkUk6AoAdgfVHROk=wpRo0En=gi7zwXe6S7LUEsdocQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30.10.24 17:47, Rob Herring wrote:
> On Wed, Oct 30, 2024 at 11:03 AM Dirk Behme <dirk.behme@gmail.com> wrote:
>>
>> On 30.10.24 15:05, Rob Herring wrote:
>>> On Wed, Oct 30, 2024 at 3:15 AM Alice Ryhl <aliceryhl@google.com> wrote:
>>>>
>>>> On Tue, Oct 29, 2024 at 8:35 PM Rob Herring <robh@kernel.org> wrote:
>>>>>
>>>>> On Tue, Oct 29, 2024 at 1:57 PM Miguel Ojeda
>>>>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Oct 29, 2024 at 7:48 PM Alice Ryhl <aliceryhl@google.com> wrote:
>>>>>>>
>>>>>>> One option is to define a trait for integers:
>>>>>
>>>>> Yeah, but that doesn't feel like something I should do here. I imagine
>>>>> other things might need the same thing. Perhaps the bindings for
>>>>> readb/readw/readl for example. And essentially the crate:num already
>>>>> has the trait I need. Shouldn't the kernel mirror that? I recall
>>>>> seeing some topic of including crates in the kernel?
>>>>
>>>> You can design the trait to look similar to traits in external crates.
>>>> We did that for FromBytes/AsBytes.
>>>>
>>>> I assume you're referring to the PrimInt trait [1]? That trait doesn't
>>>> really let you get rid of the catch-all case, and it's not even
>>>> unreachable due to the u128 type.
>>>
>>> It was num::Integer which seems to be similar.
>>>
>>>>
>>>> [1]: https://docs.rs/num-traits/0.2.19/num_traits/int/trait.PrimInt.html
>>>>
>>>>>> +1, one more thing to consider is whether it makes sense to define a
>>>>>> DT-only trait that holds all the types that can be a device property
>>>>>> (like `bool` too, not just the `Integer`s).
>>>>>>
>>>>>> Then we can avoid e.g. `property_read_bool` and simply do it in `property_read`.
>>>>>
>>>>> Is there no way to say must have traitA or traitB?
>>>>
>>>> No. What should it do if you pass it something that implements both traits?
>>>>
>>>> If you want a single function name, you'll need one trait.
>>>
>>> I'm not sure I want that actually.
>>>
>>> DT boolean is a bit special. A property not present is false.
>>> Everything else is true. For example, 'prop = <0>' or 'prop =
>>> "string"' are both true. I'm moving things in the kernel to be
>>> stricter so that those cases are errors. I recently introduced
>>> (of|device)_property_present() for that reason. There's no type
>>> information stored in DT.  At the DT level, it's all just byte arrays.
>>> However, we now have all the type information for properties within
>>> the schema. So eventually, I want to use that to warn on accessing
>>> properties with the wrong type.
>>>
>>> For example, I think I don't want this to work:
>>>
>>> if dev.property_read(c_str!("test,i16-array"))? {
>>>     // do something
>>> }
>>>
>>> But instead have:
>>>
>>> if dev.property_present(c_str!("test,i16-array")) {
>>>     // do something
>>> }
>>
>> I think we have "optional" properties which can be there (== true) or
>> not (== false). Let's assume for this example "test,i16-array" is such
>> kind of "optional" property. With what you gave above we need two
>> device tree accesses, then? One to check if it is there and one to
>> read the data:
> 
> Yes, lots of properties are optional especially since any new property
> added has to be because the DT is an ABI.
> 
>> let mut array = <empty_marker>;
>> if dev.property_present(c_str!("test,i16-array")) {
>>     array = dev.property_read(c_str!("test,i16-array"))?;
>> }
>>
>> ?
>>
>> Instead of these two accesses, I was thinking to use the error
>> property_read() will return if the optional property is not there to
>> just do one access:
>>
>> let mut array = <empty_marker>;
>> if let Ok(val) = dev.property_read(c_str!("test,i16-array")) {
>>        array = val;
>> }
>>
>> (and ignore the error case as its irrelvant in the optional case)
>>
>> Have I missed anything?
> 
> If you grep "_property_present", most if not all calls never need the
> data. When you need the data, you read it and test for EINVAL if you
> want to handle "not present". The overhead of parsing the data is not
> nothing, so I think it is better to provide both.
> 
> The typical pattern in the C code is:
> 
> u32 val = DEFAULT_VALUE;
> of_property_read_u32(node, "a-property", &val);
> 
> // val is now either the read property or the default. If the property
> is required, then the error code needs to be checked.

Yes :)

> Maybe we should have:
> 
> let val: u32 = dev.property_read_optional(c_str!("test,i16-array"),
> DEFAULT_VALUE);
> 
> Or looks like Option<> could be used here?:
> 
> let val: u32 = dev.property_read(c_str!("test,i16-array"),
> Option<DEFAULT_VALUE>);


In the success case we will get back Some(val)? In the error case
'val' will get Some(DEFAULT_VALUE)? But where would we get the error
value itself (e.g. EINVAL)? Or is the idea to not care about that any
more then? When would we use None?

Best regards

Dirk

> One thing I'd like to improve is having fewer driver error messages
> and a printk for a missing required property is a common one. We have
> APIs like clk_get and clk_get_optional (which parse firmware
> properties). The difference is the former prints an error message on
> error case and the latter is silent.
> 
> Rob


