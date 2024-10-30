Return-Path: <linux-kernel+bounces-389116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0FB9B68C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F26E1C2153D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB42141B7;
	Wed, 30 Oct 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDDeMcYy"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3C36126;
	Wed, 30 Oct 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304235; cv=none; b=af5t3Qh8wZWrrA+wFRP8AJQ/mCFzMsjD+PCUrg7R8y4q3VDr0h4Ime6St3VOt0miIupyV8O3s7+WjbL7xe8yX86ARIo4WAl6cn/69rDAwCjSI8EczgdNrA2922nsurcbCTzvu4DfSv72WKzKQTNmpsBuXW+cb09zZ1gMaaFAZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304235; c=relaxed/simple;
	bh=8MLDBn7mU2G6eGwIVqX/nGEK1NGlKs8yV/EOwYpdu7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcWvzSgjCFSG0Vu9B3oly2XxU4FiPpjsO6OpZb6SWd852K0PP2NzVq1sP2CEreM/cGByfyloaf63b5wskD/vUHLGigSRp3jGMar+BcwVGZjM17Tz8SUWtKOREqOPANokhavt/2al487m4TMepqO9LnCSqm1vwcOr7ML4v3OI+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDDeMcYy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so32114f8f.2;
        Wed, 30 Oct 2024 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730304232; x=1730909032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loh0zeo2kdsDuCCuROMVcSaSS8mgdLqRUDrIHMoopBQ=;
        b=KDDeMcYywvGN79xZP3ghu5cm2Xpo6NhOQiZSxDuyBz6OyNbAa2IEwhNidt8i0wM5Ln
         j/VzrurUVOXeL0s+YNM1Gk9r0xNCDPH0KHx/hqbgt+nLwbv1ogKVLdofHUB3WdePfZmp
         jPtpdDZI2mGn1tjiYTfVwNKKaECmkCKFg9i/YK4vQ3AZp+H/H7BH2dIPo8cUOIsI3cel
         rknRjafUj6edXfQ1S4/xYZkB+wwlu2SXOT4PtmR7wxBPG2M9K5QiVTdOMzbmE47sCH22
         l0cCPQg6DFY+mRIwYr9wdVwVCAd6R8byNvHtepGliYXVCagC2YKwX9U9ThY9JzIzClPn
         f6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304232; x=1730909032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loh0zeo2kdsDuCCuROMVcSaSS8mgdLqRUDrIHMoopBQ=;
        b=h4iiMsc6byTAHWdVm4+e/6aWMIEJuBXApxI2/RhnIQYfpJiaxeXxqd6wpbjddq8zFp
         AZHHKVEZyvCtdh2sq2NCy28OmcDJgceSbzapqFpCyr6QK8x+R1NLLwK0Q1v8DnDEKipr
         dwCAVn3tKlfa6bYR9Cxk/082h8cuh+UxkZc2nas50xUuQ9oiRpgpgWFpMqEUG0eVs/Lg
         PlbJufz9D81qq/jbSuwaEWB3YRcbGGTioMF/G99QmZpWNXegXUZM2VH0U3U9fcZPtH78
         03Wnygy40qHYaZfhC+sYb0TGwPP4JOzN7DigFO0TdK6UwoX4rxqDK23gFrJc3PUX8hxv
         X8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpLIWqx058goMdbnwE3+Yb01/i5iBT/85ZY6ezv4TQc0ggJQYkHtUaftiPy5n9A+sez5Qs7xmHeco/YDXQ@vger.kernel.org, AJvYcCVx0cu7/9bFrXlXf7kxDgbcQgS0xXmEdMqXkMnbq65X0R80tQYg6OGcoZSI4nMpj9oXhOlQgVnyhAFi@vger.kernel.org, AJvYcCXPlva0Kf4U0vbMyz3t5YUw1DRGmkWdQWX0sm9Eig2upOhopdwGDtnn4NxLufKu8WLLD1L5MYBzJiLrVhuGrm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/uMtUFgyV2ifKrIg0BFqLaPIBT0cOrMDbY5HOMgxShdC6ByJ
	kvF6Ws5qVG7sLawKxCDJuQrlzHG8R8seQH51cv2zqAkWOG6fdPY7
X-Google-Smtp-Source: AGHT+IHiqK+pe4ogZgBOrg0REvXdAqXeZPpccBdO2od0LtmYHMbEebXDNuf+mtX00E8V6lrZPBGUvg==
X-Received: by 2002:a05:6000:1ccc:b0:37d:4f69:c9b with SMTP id ffacd0b85a97d-380611e0c40mr14299216f8f.35.1730304231297;
        Wed, 30 Oct 2024 09:03:51 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:dc52:63bc:ee84:76b9? (p200300dfbf0db400dc5263bcee8476b9.dip0.t-ipconnect.de. [2003:df:bf0d:b400:dc52:63bc:ee84:76b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70d5csm15788527f8f.89.2024.10.30.09.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 09:03:50 -0700 (PDT)
Message-ID: <79c47555-c9e9-4ff6-8c43-c7c26a91afd4@gmail.com>
Date: Wed, 30 Oct 2024 17:03:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <CAL_JsqL+b-f5K24qTxyA09c_QPeb07s4Hb=s1VqrdksBB4BQ=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30.10.24 15:05, Rob Herring wrote:
> On Wed, Oct 30, 2024 at 3:15 AM Alice Ryhl <aliceryhl@google.com> wrote:
>>
>> On Tue, Oct 29, 2024 at 8:35 PM Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Tue, Oct 29, 2024 at 1:57 PM Miguel Ojeda
>>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>>
>>>> On Tue, Oct 29, 2024 at 7:48 PM Alice Ryhl <aliceryhl@google.com> wrote:
>>>>>
>>>>> One option is to define a trait for integers:
>>>
>>> Yeah, but that doesn't feel like something I should do here. I imagine
>>> other things might need the same thing. Perhaps the bindings for
>>> readb/readw/readl for example. And essentially the crate:num already
>>> has the trait I need. Shouldn't the kernel mirror that? I recall
>>> seeing some topic of including crates in the kernel?
>>
>> You can design the trait to look similar to traits in external crates.
>> We did that for FromBytes/AsBytes.
>>
>> I assume you're referring to the PrimInt trait [1]? That trait doesn't
>> really let you get rid of the catch-all case, and it's not even
>> unreachable due to the u128 type.
> 
> It was num::Integer which seems to be similar.
> 
>>
>> [1]: https://docs.rs/num-traits/0.2.19/num_traits/int/trait.PrimInt.html
>>
>>>> +1, one more thing to consider is whether it makes sense to define a
>>>> DT-only trait that holds all the types that can be a device property
>>>> (like `bool` too, not just the `Integer`s).
>>>>
>>>> Then we can avoid e.g. `property_read_bool` and simply do it in `property_read`.
>>>
>>> Is there no way to say must have traitA or traitB?
>>
>> No. What should it do if you pass it something that implements both traits?
>>
>> If you want a single function name, you'll need one trait.
> 
> I'm not sure I want that actually.
> 
> DT boolean is a bit special. A property not present is false.
> Everything else is true. For example, 'prop = <0>' or 'prop =
> "string"' are both true. I'm moving things in the kernel to be
> stricter so that those cases are errors. I recently introduced
> (of|device)_property_present() for that reason. There's no type
> information stored in DT.  At the DT level, it's all just byte arrays.
> However, we now have all the type information for properties within
> the schema. So eventually, I want to use that to warn on accessing
> properties with the wrong type.
> 
> For example, I think I don't want this to work:
> 
> if dev.property_read(c_str!("test,i16-array"))? {
>     // do something
> }
> 
> But instead have:
> 
> if dev.property_present(c_str!("test,i16-array")) {
>     // do something
> }

I think we have "optional" properties which can be there (== true) or
not (== false). Let's assume for this example "test,i16-array" is such
kind of "optional" property. With what you gave above we need two
device tree accesses, then? One to check if it is there and one to
read the data:

let mut array = <empty_marker>;
if dev.property_present(c_str!("test,i16-array")) {
    array = dev.property_read(c_str!("test,i16-array"))?;
}

?

Instead of these two accesses, I was thinking to use the error
property_read() will return if the optional property is not there to
just do one access:

let mut array = <empty_marker>;
if let Ok(val) = dev.property_read(c_str!("test,i16-array")) {
       array = val;
}

(and ignore the error case as its irrelvant in the optional case)

Have I missed anything?

Best regards

Dirk







