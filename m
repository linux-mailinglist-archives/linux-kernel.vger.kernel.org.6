Return-Path: <linux-kernel+bounces-202058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B88FC751
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61451C228EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3018FC8A;
	Wed,  5 Jun 2024 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCiHKnN6"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689518FC89
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578658; cv=none; b=eDzjZEwl0NVADwditoAwtZ0x3pBY0Q+xAoTTpe5sSdxUZw4AE3Aw+Dk+qHBZeUezouwbxeWE6SdmDymSEJuuVPjlo7gz8qjSH9p+Sew5gWSGAHnkM9QPBlGUDVfiPt7NO1uJMbmTZ8qbjxXTd/rblhjEeM0m1o2OQVk3meeldwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578658; c=relaxed/simple;
	bh=Ohf6oZ+oO2donfb/cODscDFAkvMhq+OmdtbGC2dDQx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ypx2vzqzfB1M+6KBREc+XN62t30UKw3hlFejARifoCcMRva90nQgJYVxgSnKU1Dzx9YsrKgfGhl74QPcQ9D9JsDaJh3GoTKy4lnNqpGvUIkniqoigg2imojcJFfS18LI30biSr/6lqyAGUT6NMIYxw7M1VWEsKBviIONOzLEd8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCiHKnN6; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-24c9f892aeaso3637352fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717578656; x=1718183456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lTG6BM2D9pwAMXwuJmppHUX0zuuxDgXItlRkB2F6Whw=;
        b=jCiHKnN63Af5aOgE6SLbJEzjFFmMY56psVg5tXC0H5aeCNKz203x6kboXnkE/pH2UW
         6kmwdG7lpR2ln4vrgiVp18lx8fjf4YmeOxT0FWFzmmNCgqdsQzKTNojW5d1KuhsnA2YU
         vndDE6ThwQxlOd6iQ0iPxTKgF/bJsDPqwWBciBLm+ipfWwObfBiCshmLwe03ftRq6FNj
         G2PAHGXBxnRrQrqDhXnGAu+XRk2d/euJImGJ0zKaE5xcPjlbB2InYIetH97FfRDbObiP
         7Dxhfhpap5YtebdFDsW4HqDWdEAnmb5RawbCwvxGQ9q3oOxIy3A85xjzGnEIV3Ouv6iq
         h5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717578656; x=1718183456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTG6BM2D9pwAMXwuJmppHUX0zuuxDgXItlRkB2F6Whw=;
        b=Jh0by8787pjvdvTl1QgNQ2sviHxpV1IuXHcs/z22waPRXJClnphe9rsXVhEX7pEqHt
         KCQmB9abzDH1D+9d4+yG5zOs2jz1zeG9HSwfNzPZsNz0xARExwtXOzTB8/4UC5YtScyb
         UHNe0oEvowgsQ98U9P7UmAiSi10gjbE3Zz+caw5GA6iuNVFlpPrYC64tOvQyKtnJj1nQ
         KdBG69DEYGwXYBoIf1G+JiYEuMEhfZyAHm0FqiezI1leIibkRqN5KDTKQ34eF3ICUoNa
         d2HjOOeIuzyVDx2sLl2i/rbfhFyWVaO2dpbFh+XBHAhE4XsOiPhpPfm5wY/SRCRoKGEL
         9e2A==
X-Forwarded-Encrypted: i=1; AJvYcCV3sJ9SXub4eDytLYmU6zdoc0hEhfQsYo4ciHfoBrO+RHOietZPEQSKR75RU29RZSf1QMzWaHZAHZJAO/rMQyMtvfzbpSoAZD07Hliv
X-Gm-Message-State: AOJu0Yx2Sb2Mmo32kVy1afCWJSULTK/b1NkypVR8RMQidQ37Wlqkr2sH
	FPHNLgKfXknIoVBMNocYiHhv1vNsLWuSvSZp3f298+4e4O4wUFpc
X-Google-Smtp-Source: AGHT+IGFVtRgof2Vr7XnnRzUy5kTO/s4QSnWyIEEWJVSWOqsNKgzwT8cHzfUyKrMnHJALyfjycu/iQ==
X-Received: by 2002:a05:6870:7006:b0:24f:e:b110 with SMTP id 586e51a60fabf-25121e3aed8mr2366720fac.35.1717578655520;
        Wed, 05 Jun 2024 02:10:55 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b2e143sm8247886b3a.198.2024.06.05.02.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 02:10:55 -0700 (PDT)
Message-ID: <a3942479-764f-4e19-8b90-682fa56c8e20@gmail.com>
Date: Wed, 5 Jun 2024 17:10:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/ksm: reduce the flush action for ksm merging
 page
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-2-alexs@kernel.org>
 <9ca730ce-2b2f-42d2-8c7a-78735a995c64@redhat.com>
 <4d299245-3166-4810-b22b-2a5b4f54a049@gmail.com>
 <7c6ae2a3-8ec3-4c9b-81c3-125f6973f0f3@redhat.com>
 <d059e397-beea-43dc-8c58-d7833b1d8bd4@gmail.com>
 <59921e08-d0f1-4bc8-acee-368a978286a4@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <59921e08-d0f1-4bc8-acee-368a978286a4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/24 3:26 PM, David Hildenbrand wrote:
> On 04.06.24 15:02, Alex Shi wrote:
>>
>>
>> On 6/4/24 6:45 PM, David Hildenbrand wrote:
>>> On 04.06.24 12:26, Alex Shi wrote:
>>>>
>>>>
>>>> On 6/4/24 4:07 PM, David Hildenbrand wrote:
>>>>> On 04.06.24 06:24, alexs@kernel.org wrote:
>>>>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>>>>
>>>>>> We can put off the flush action util a merging is realy coming. That
>>>>>> could reduce some unmerge page flushing.
>>>>>> BTW, flushing only do at arm, mips and few other archs.
>>>>>>
>>>>>
>>>>> I'm no expert on that flushing, but I thought we would have to do the flushing before accessing page content -- before calculating the checksum etc.
>>>>>
>>>>> Now you would only do it before the pages_identical() check, but not when calculating the checksum.
>>>>>
>>>>
>>>> Hi David,
>>>>
>>>> Thanks a lot for comments!
>>>>
>>>> If calc_checksum() is wrong before pages_idential(), (that's just after page was write_protected, that's a real guarantee for page context secured) pages_identical could recheck and make thing right.
>>>>
>>>
>>> Yes, but you would get more wrong checksums, resulting in more unnecessary pages_identical() checks.
>>>
>>> That is missing from the description, and why we want to change that behavior.
>>>
>>> What's the net win?
>>>
>>>> And as to 2 flush functions here, I didn't see the guarantee for other writer from any other place. So maybe we should remove these flush action?
>>>
>>> "I didn't see the guarantee for other writer from any other place" can you rephrase your comment?
>>>
>>> If you mean "the process could modify that page concurrently", then you are right. But that's different than "the process modified the page in the past and we are reading stale content because we missed a flush".
>>
>>
>> Maybe moving the flush before checksum could relief some worries. :)
>> But still no one knows what flush really help, since if page content only syncs to memory by the flush, the kernel or process can't be work with current code.
> 
> Please explain to me why we care about moving the flushs at all :)
> 
> If they are NOP on most architectures either way, why not simply leave them there and call it a day?
Uh, 2 reasons:
1, it uses page and can't convert to folio now.
2, as you pointed, flush action w/o page reading seems just waste time.

Thanks
Alex
> 

