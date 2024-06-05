Return-Path: <linux-kernel+bounces-202162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ABF8FC88A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52651C21798
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CE918FDC7;
	Wed,  5 Jun 2024 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSQgDnaf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27EF49646
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581662; cv=none; b=XRzd8JHX1/Fkf1DBD2/bP7/io8lb5fXyibULHNywbpbQO+szaybfDw9Rvu0/AQxou47sMIb7kRdlpuEreCjEFW31+t108knNfD7vZTqI7yK+dKiL5fA7w+ZQhcoCd96NImfSOijT9wNlJs6h2BD/aG7iyl3ss0+drMVRATMrhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581662; c=relaxed/simple;
	bh=k0AJCiPDXP28efu1By6lEPqY9tDxVQH00CvXRdBXEbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eosHa5b26MbfwBNfqDyfZ0hfmzerwNKwxS7YMcclxeLsqEW7q1QcOTdPbd4bFhzr7WlOYeVSMFrLTVgQrWD1QQLQgNfsoPNXpTCFWDBEjqjzQfD9EiyN8tkObwwKqcLEKgjR9csj+QcCYyHFc9yItsfRjiSdJtZH7t88YcfniEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSQgDnaf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717581659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7wXR39HpwcKUfxXF+QwF4iqlnoidckP6gdlx6uO+c2o=;
	b=PSQgDnafdjYE/CLN7ZsbTLny/oLX+r++hC1w02gpMU1HXEzRh0CUiSq/GF3Z2570wfZ7mx
	tGMPtbbRl5YO9A4opX9ot5KFPAnxHqO86QucutQvClLCwO660FcjZwMPybGawFxwPlaccy
	TYQyQddQoRMHWiyJv9OHZMjGRYo9PZ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-kn_AE4WoMw6msgcVo6OPRg-1; Wed, 05 Jun 2024 06:00:58 -0400
X-MC-Unique: kn_AE4WoMw6msgcVo6OPRg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dcb3f1ab3so4023778f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581657; x=1718186457;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wXR39HpwcKUfxXF+QwF4iqlnoidckP6gdlx6uO+c2o=;
        b=mSyWrpKL+a+GdAplotSDRNWd/ZXdeVzdzz1SUg8xFFfksTkr5fOiBeBbA4ncb3ai7f
         Pg417krutI+SzCedZDl7iC2MVUZ2z0lagxNQzNnsYnIlnBlyrOFFbjnzvVP7ShSIWazs
         GSkXDDmlZdDgHHZ/pyD5JVeDqeIUVZhHinEX4Q+kw7cZgNvhLWHzA5OcsD5Ws76NNESr
         3OP3yxMmRMFnVsDVIS6XAt8cHHV4NMI56V1AcuvZqR4hMTiRDDsn2rzWNnRobY2ZTzL5
         ldOgJU2C3r3eByFx/L8X+pTd0zSrZWgbFYlPgCCASjiFeypjO1UgD7VO43vBcwJpVu43
         380Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY79m1WX/zGkpIvK3sD/WziY92t3yJzcENAz89BmIbJtBUoiNBu2D9oq6cp8xHdZ3VIQ6Q8kI49xgvyWk/o5i6LEKnsyE66Zb833K2
X-Gm-Message-State: AOJu0YzIMxc89VwX8kzGXcKyvLlolmC5eQnT5out7ubCW5o9Cflk+xgF
	tfoTW6lQTm6OEUmSeaCSGnbsB3QFhPbHVi34LE+tefmYQZXR/2YceHfXmmbK/E0moET2yENfCYj
	Zv0Gyss98BSZm8Im3leuMVKZz9Qmp3XD1Xea2RbbgeWi+SAzRMnigunzatsvcks4wsCf6hQ==
X-Received: by 2002:a5d:638f:0:b0:35e:7e6a:254f with SMTP id ffacd0b85a97d-35e8ef65b44mr1608152f8f.49.1717581657431;
        Wed, 05 Jun 2024 03:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKLJlwN41Pi+qmvPRwUuW0vOjfwp4ANFBWQr4ukXmaqndcdkFvJJKHZ4nHsITuDBwKMu631Q==
X-Received: by 2002:a5d:638f:0:b0:35e:7e6a:254f with SMTP id ffacd0b85a97d-35e8ef65b44mr1608114f8f.49.1717581656966;
        Wed, 05 Jun 2024 03:00:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5047f75esm11097147f8f.35.2024.06.05.03.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 03:00:56 -0700 (PDT)
Message-ID: <9100f283-ab44-4481-a73c-5b5d5fabd01a@redhat.com>
Date: Wed, 5 Jun 2024 12:00:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/ksm: reduce the flush action for ksm merging
 page
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
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
 <a3942479-764f-4e19-8b90-682fa56c8e20@gmail.com>
 <41130a02-80cc-4ee4-89ab-e889844a35f7@redhat.com>
 <1a4f8984-e262-4611-81ec-6ea12fa5b20d@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1a4f8984-e262-4611-81ec-6ea12fa5b20d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 11:49, Alex Shi wrote:
> 
> 
> On 6/5/24 5:14 PM, David Hildenbrand wrote:
>> On 05.06.24 11:10, Alex Shi wrote:
>>>
>>>
>>> On 6/5/24 3:26 PM, David Hildenbrand wrote:
>>>> On 04.06.24 15:02, Alex Shi wrote:
>>>>>
>>>>>
>>>>> On 6/4/24 6:45 PM, David Hildenbrand wrote:
>>>>>> On 04.06.24 12:26, Alex Shi wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 6/4/24 4:07 PM, David Hildenbrand wrote:
>>>>>>>> On 04.06.24 06:24, alexs@kernel.org wrote:
>>>>>>>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>>>>>>>
>>>>>>>>> We can put off the flush action util a merging is realy coming. That
>>>>>>>>> could reduce some unmerge page flushing.
>>>>>>>>> BTW, flushing only do at arm, mips and few other archs.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I'm no expert on that flushing, but I thought we would have to do the flushing before accessing page content -- before calculating the checksum etc.
>>>>>>>>
>>>>>>>> Now you would only do it before the pages_identical() check, but not when calculating the checksum.
>>>>>>>>
>>>>>>>
>>>>>>> Hi David,
>>>>>>>
>>>>>>> Thanks a lot for comments!
>>>>>>>
>>>>>>> If calc_checksum() is wrong before pages_idential(), (that's just after page was write_protected, that's a real guarantee for page context secured) pages_identical could recheck and make thing right.
>>>>>>>
>>>>>>
>>>>>> Yes, but you would get more wrong checksums, resulting in more unnecessary pages_identical() checks.
>>>>>>
>>>>>> That is missing from the description, and why we want to change that behavior.
>>>>>>
>>>>>> What's the net win?
>>>>>>
>>>>>>> And as to 2 flush functions here, I didn't see the guarantee for other writer from any other place. So maybe we should remove these flush action?
>>>>>>
>>>>>> "I didn't see the guarantee for other writer from any other place" can you rephrase your comment?
>>>>>>
>>>>>> If you mean "the process could modify that page concurrently", then you are right. But that's different than "the process modified the page in the past and we are reading stale content because we missed a flush".
>>>>>
>>>>>
>>>>> Maybe moving the flush before checksum could relief some worries. :)
>>>>> But still no one knows what flush really help, since if page content only syncs to memory by the flush, the kernel or process can't be work with current code.
>>>>
>>>> Please explain to me why we care about moving the flushs at all :)
>>>>
>>>> If they are NOP on most architectures either way, why not simply leave them there and call it a day?
>>> Uh, 2 reasons:
>>> 1, it uses page and can't convert to folio now.
>>> 2, as you pointed, flush action w/o page reading seems just waste time.
>>
>> Alex, I don't think the approach you take for coming up with the current set of patches is a good idea.
>>
>> Please reconsider what you can actually convert to folios and what must stay pages for now due to support for large folios in that code.
>>
>> Then, please explain properly why changes are required and why they are safe.
>>
>> For example, for in scan_get_next_rmap_item() we really *need* the page and not just the folio. So just leave the flushing there and be done with it.
>>
> 
> Hi David,
> 
> Thanks a lot for your review.
> Though all patches are passed in kernel selftest, but if we do care the saving more than quick processing, the main purpose of this patchset is gone. I'll drop this series.

I think there is value in more folio conversion, but we really have to 
be careful when we still want to/have to work on pages (folio+page pair).

-- 
Cheers,

David / dhildenb


