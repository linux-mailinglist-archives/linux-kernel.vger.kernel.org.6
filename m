Return-Path: <linux-kernel+bounces-417576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5774D9D561E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD3A1F23A64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579911DE2B5;
	Thu, 21 Nov 2024 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeS6JsRX"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748119F410;
	Thu, 21 Nov 2024 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732231115; cv=none; b=khrdNHk7fG2p6i9HCaO0H4eiaQpeK1JyqRsR1EGDzT6osiDbwxhnMpC6Jbty8/goJnHOZz4cwznoPkb85OI7u2NO/XYPawK2kCgiFpw0GsXIepQJh2oz/MdqjJr69xSZSeiZdj/6tyPAp1LjP9AM9H1/QfVe09lc88qQ3tR01hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732231115; c=relaxed/simple;
	bh=Jd4PH0eLCKPO1Re8CCzf7GW2qghj9z74BdPmIq+OKDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGmpf0fXjPwdMkSXBQQVca5GrXjMXfsGAXmqMXXRBfu+XoUUeN0dvSl9ZJERZwsmTpldQ/C2sKyIT0uNiOmsBseIwbkrpJGI+lIHFeh7+qkJl/ZQpr1TcqHaas6SKnGILelqy0d45u34kDAwD7nYv4yxd7h6GSDowSTrUbFRI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeS6JsRX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53da24e9673so1590379e87.2;
        Thu, 21 Nov 2024 15:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732231112; x=1732835912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OL9X8Kvpun/SWWLLZPeJ5t6X+R0QyKBPzXrsZ+HbodE=;
        b=HeS6JsRXdTVDWDO/VNRw/ShUJtKH4mVsfVvjqhhiBY4scDKybOjfdiWEudQiMgAkmr
         s3lXbk/LKowQVDTkIFJc3jjE5eeUvPvSgmLfErWjjdoCAiPyV63s6YDFdxqycG2BBnvk
         O3Xe53VxUnhcEDFZfn+unfJJUk8IjyxZSDwEnW9UT7oCrcxbBkh+whA9o8VLDbnAlb1a
         LT8vBaAdQHElbsh4GJ41gyLX7g7FesVsxfX85Qo/0wYbsjhlEb+h6iA8G98sSimEghRk
         3prromXHdxY/wMVj8HWma5J5pYctZr+QOJCqZcyrjSFn+vWnp7g/Lo4uMTlDip9Gs+2H
         9mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732231112; x=1732835912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OL9X8Kvpun/SWWLLZPeJ5t6X+R0QyKBPzXrsZ+HbodE=;
        b=pRtqibDV2htX3xA/gKUHCbFjBKGpD1j/cx2eiU+jwi22fibyXT2/QoRy6hPGMlE8H1
         JQ4vI1JI09JLYV0jORXJ712iZfCn814VZPStFTQy2ralmn9KBPknpXKUL0InESwt2EpV
         PXARRPp76ERYEgUXRrfzXMLot37dVGA4B6LUzm9dQYxqQyH/gi+VVVJHymCa5Np6awoO
         tBwoEySI1ULJimG6SDUlUDh56maS45yQBFD92saSYWO539kUKjt1mZJc9BsRDUy+Iuqh
         x7jcmKhuySVwKcYETrxpqKSBLr8VxstGYRngz9OaJKcYNOj/uzA1fZ4Ix2jjzohex3jF
         puEA==
X-Forwarded-Encrypted: i=1; AJvYcCWbr3CphvHQILBUaHT9Fy0HfGnOIphe1Ywp5UGe5TiRimxQp/cYrNErGDZOj7HDCJouiDA2DTTlfC/l+baLemw=@vger.kernel.org, AJvYcCXbwhiIvMchO6PzgIaDGGf275D+/A2sL7PxUc0Auv8R0Pt29/GghjM7JMHinHu1tYGDXM2wJ6VuuvDe9xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSf+qL4q8WdtKnABSd3j4zJ8LvI9a+XUymq8B3lIcFjl1C6s8E
	V06EqvNmmeF8k4Mh//Mb3Tr5ndXKGbBQwMzpiwcc5USWSl7RfN1l
X-Gm-Gg: ASbGncvr8O8npaWP5nklXDJgMBfUsaY0PXeYC0Tm8SGg+y8Jlc6qRTHSkgj3IkfusGa
	WNugBOaLP/xD2FtyacRprirEEN+eCtaQze6B04Ltj0VAVnb/haEZyIaLVdjOm1rrv74MgZ7bynt
	901vtlsj7FhAe2t2SX4QBKOZKGB+8y0H+oMoWWrPKMU9Le0sv7bFb2/VqqJ5fKOHJWIPhqdmjGD
	tHIccQp7YGeluhPSaDJTrveM2LH7tfNwwrkUwyzyM4rqUGVX0WVyF1PZQfp6zD0uFzp3tQbqwyg
	ujVrk6K64lQNoS5QvNH0
X-Google-Smtp-Source: AGHT+IFBaOmLQRpRczqhiz1RGt8haQlGaTHwb+yghySwACcam9Nx+3MpjLfSASNv2RxM49KxOTq4lw==
X-Received: by 2002:a05:6512:3ba2:b0:53d:a883:5a3e with SMTP id 2adb3069b0e04-53dd39b0e57mr331517e87.39.1732231111612;
        Thu, 21 Nov 2024 15:18:31 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd248997esm110198e87.181.2024.11.21.15.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 15:18:30 -0800 (PST)
Message-ID: <0195fb77-c55a-40d5-8fe2-5844158f4f63@gmail.com>
Date: Fri, 22 Nov 2024 01:18:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
To: Matthew Wilcox <willy@infradead.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com,
 Kairui Song <ryncsn@gmail.com>
References: <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local> <Zz4WFnyTWUDPsH4m@casper.infradead.org>
 <Zz4boXyYpdx4q35I@tardis.local>
 <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
 <Zz59qgqKruqnouTl@tardis.local>
 <650846e4-b6a0-472d-a14e-4357d20faadb@gmail.com>
 <Zz-FtcjNm0TVH5v9@tardis.local> <Zz-GHlkhrz35w2YN@tardis.local>
 <Zz-ts0s3jHsNP73f@casper.infradead.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <Zz-ts0s3jHsNP73f@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/11/2024 00:01, Matthew Wilcox wrote:
> On Thu, Nov 21, 2024 at 11:12:30AM -0800, Boqun Feng wrote:
>> On Thu, Nov 21, 2024 at 11:30:13AM +0200, Abdiel Janulgue wrote:
>>> Hi Boqun, Matthew:
>>>
>>> On 21/11/2024 02:24, Boqun Feng wrote:
>>>>>> So if I understand correctly, what Abdiel needs here is a way to convert
>>>>>> a virtual address to the corresponding page, would it make sense to just
>>>>>> use folio in this case? Abdiel, what's the operation you are going to
>>>>>> call on the page you get?
>>>>>
>>>>> Yes that's basically it. The goal here is represent those existing struct
>>>>> page within this rust Page abstraction but at the same time to avoid taking
>>>>> over its ownership.
>>>>>
>>>>> Boqun, Alice, should we reconsider Ownable and Owned trait again? :)
>>>>>
>>>>
>>>> Could you use folio in your case? If so, we can provide a simple binding
>>>> for folio which should be `AlwaysRefcounted`, and re-investigate how
>>>> page should be wrapped.
>>>>
>>>
>>> I'm not sure. Is there a way to get the struct folio from a vmalloc'd
>>> address, e.g vmalloc_to_folio()?
>>>
>>
>> I think you can use page_folio(vmalloc_to_page(..)) to get the folio,
>> but one thing to notice is that folio is guaranteed to be a non-tail
>> page, so if you want to do something later for the particular page (if
>> it's a tail page), you will need to know the offset of the that page in
>> folio. You can do something like below:
> 
> This is one of those things which will work today, but will stop
> working in the future, and anyway will only appear to work for some
> users.
> 
> For example, both vmalloc and slab allocations do not use the refcount
> on the struct page for anything.  eg this will be a UAF (please excuse
> me writing in C):
> 
> 	char *a = kmalloc(256, GFP_KERNEL);
> 	struct page *page = get_page(virt_to_page(a));
> 	char *b = page_address(page) + offset_in_page(a);
> 	// a and b will now have the same bit pattern
> 	kfree(a);
> 	*b = 1;
> 
> Once you've called kfree(), slab is entitled to hand that memory out
> to any other user of kmalloc().  This might actually work to protect
> vmalloc() memory from going away under you, but I intend to change
> vmalloc so that it won't work (nothing to do with this patch series,
> rather an approach to make vmalloc more efficient).
> 
> One reason you're confused today is that we have a temporary ambiguity
> around what "folio" actually means.  The original definition (ie mine) was
> simply that it was a non-tail page.  We're moving towards the definition
> Johannes wanted, which is that it's only the memdesc for anonymous &
> file-backed memory [1].  So while vmalloc_to_folio() makes sense under
> the original definition, it's an absurdity under the new definition.
> 
> So, Abdiel, why are you trying to add this?  What are you actually
> trying to accomplish in terms of "I am writing a device driver for XXX
> and I need to ..."?  You've been very evasive up to now.

Background behind this is that we need this for the nova rust driver [0].

We need an abstraction of struct page to construct a scatterlist which 
is needed for an internal firmware structure. Now most of pages needed 
there come from vmalloc_to_page() which, unlike the current rust Page 
abstraction, not allocated on demand but is an existing mapping.

Hope that clears things up!

Regards,
Abdiel

[0] https://rust-for-linux.com/nova-gpu-driver

