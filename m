Return-Path: <linux-kernel+bounces-202065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECD68FC76C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02D12863D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089D18FC65;
	Wed,  5 Jun 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdxY0O7X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8714B093
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578876; cv=none; b=sPQKsso9voWIZfzMROIxkcT2hTfagQSeE1po9DdPuMXC7NG0fhTPZBfIo0Kf7aQvmW4Qx8mTYuGFA89lCUN+3YFpp7lzCbhMqsxn30W2UnZpk5rKpKrDdofdtIdtZdnz8fgHdrmhEifws5pBuMeeJMIDQysitFId6bd3WNZutVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578876; c=relaxed/simple;
	bh=9jH7Z5LsgMoyBqdv9pQfNtzccPm8sWv/Hd5qsZj2Dbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hPtaOUL5poCfKTwJTLzFGmVptSSYYOp2u9Wqx4Y4a97XpSZaneQ7F3zrBkt7ym8bY5BdTjBkHgnPaPXGSNkjJmv466UWENN3zP3wzCNdb+TcYhd35rQj853caYyRSpdzXERYQ9LTqaaXazOGFnheAAJDGKJ0LjI0Z1Zto9rfxrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdxY0O7X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717578873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ECiqjrq4uqLZy0Wh/Ft8EG5eXJWRolWE786wAUykcz4=;
	b=MdxY0O7XcA67TQzk7K2uro9RASm0az+soYs/QaNfP0UrXFBX5aNlSmBLfjk/9YphIYhMjK
	dUxdZd0uygDtJ6YaY5KbHmLJWlVnKgNsKsDPSIVs8LB2Soa54GYq7ig31VkLw0xoeU6lBz
	QkM8UjxACM7FW42VvD++hIigQUd/w/8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-H9Zywf_UPe2hZPfQ8FLEIw-1; Wed, 05 Jun 2024 05:14:27 -0400
X-MC-Unique: H9Zywf_UPe2hZPfQ8FLEIw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35e0f069ad4so3812579f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717578866; x=1718183666;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECiqjrq4uqLZy0Wh/Ft8EG5eXJWRolWE786wAUykcz4=;
        b=tWGWl6o7mEG0+Ccr/9hHD4+X6+UcBqmavH8De9XhhP8XjtNWypTZzQ9DnrvUhTh0TA
         YxAcCqpDlH+NiTvWluXDIE8AfDOdXIttBMguNLQG0xBCIz6hO/JrJ1JNbnyuJa+YsQZS
         bERgIG+/zURWP1kbjgO9/SqGEZybgrLtjPM+cq69It2TrFsxT5aJ2XF0J4zU9DtNgYeG
         YLs6oA5XkVkZaZDoub79XPzwszkiflQExSeP0SEVn6aYesR45Y2YbcgM02gdj7RURmIB
         vbrnaVl9V0L0hHUeo+8gY9vPJGunDI+3ybmIgot+MQH3Eo9TWKUVGRaDBrGyJgSNWquh
         jrUg==
X-Forwarded-Encrypted: i=1; AJvYcCWGc/IogJ8RQqIyKkMZletTGWgsbvI9N0KuJcAEqGHADw0aLoT0+fsqQph15y4HfW/nzp62m1FbeHHkLIEi2tlpJTOfqw/nDSiTbirp
X-Gm-Message-State: AOJu0Yycpzd1QG2MWcPiFdiaghEK0qqjg2aAQ6NotYIj195xMwU0AsnU
	wQz2b4txwAdg9eNOIuPaacPV7xFUI0FOX8DivUznkm4wyb0fXXiXTRkRJ5pOwDOIbERPAUBqxr3
	eWUGSDVbgvNlWkSDBqC2JIPQA+atRNsLSHm2R7ZDNr8qr5PlBZy+Dtf7YiaARfg==
X-Received: by 2002:a5d:4a4f:0:b0:35e:7d21:cad2 with SMTP id ffacd0b85a97d-35e8ef2553bmr1621912f8f.30.1717578866451;
        Wed, 05 Jun 2024 02:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbr7bZ3mwrCo97qmn6F/LwMydLWE42LGqqHM3APD05MO77ixOEX9zg6fxzwCNXm3yvaqL/tw==
X-Received: by 2002:a5d:4a4f:0:b0:35e:7d21:cad2 with SMTP id ffacd0b85a97d-35e8ef2553bmr1621893f8f.30.1717578866053;
        Wed, 05 Jun 2024 02:14:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c4388sm14002266f8f.14.2024.06.05.02.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 02:14:25 -0700 (PDT)
Message-ID: <41130a02-80cc-4ee4-89ab-e889844a35f7@redhat.com>
Date: Wed, 5 Jun 2024 11:14:24 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a3942479-764f-4e19-8b90-682fa56c8e20@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 11:10, Alex Shi wrote:
> 
> 
> On 6/5/24 3:26 PM, David Hildenbrand wrote:
>> On 04.06.24 15:02, Alex Shi wrote:
>>>
>>>
>>> On 6/4/24 6:45 PM, David Hildenbrand wrote:
>>>> On 04.06.24 12:26, Alex Shi wrote:
>>>>>
>>>>>
>>>>> On 6/4/24 4:07 PM, David Hildenbrand wrote:
>>>>>> On 04.06.24 06:24, alexs@kernel.org wrote:
>>>>>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>>>>>
>>>>>>> We can put off the flush action util a merging is realy coming. That
>>>>>>> could reduce some unmerge page flushing.
>>>>>>> BTW, flushing only do at arm, mips and few other archs.
>>>>>>>
>>>>>>
>>>>>> I'm no expert on that flushing, but I thought we would have to do the flushing before accessing page content -- before calculating the checksum etc.
>>>>>>
>>>>>> Now you would only do it before the pages_identical() check, but not when calculating the checksum.
>>>>>>
>>>>>
>>>>> Hi David,
>>>>>
>>>>> Thanks a lot for comments!
>>>>>
>>>>> If calc_checksum() is wrong before pages_idential(), (that's just after page was write_protected, that's a real guarantee for page context secured) pages_identical could recheck and make thing right.
>>>>>
>>>>
>>>> Yes, but you would get more wrong checksums, resulting in more unnecessary pages_identical() checks.
>>>>
>>>> That is missing from the description, and why we want to change that behavior.
>>>>
>>>> What's the net win?
>>>>
>>>>> And as to 2 flush functions here, I didn't see the guarantee for other writer from any other place. So maybe we should remove these flush action?
>>>>
>>>> "I didn't see the guarantee for other writer from any other place" can you rephrase your comment?
>>>>
>>>> If you mean "the process could modify that page concurrently", then you are right. But that's different than "the process modified the page in the past and we are reading stale content because we missed a flush".
>>>
>>>
>>> Maybe moving the flush before checksum could relief some worries. :)
>>> But still no one knows what flush really help, since if page content only syncs to memory by the flush, the kernel or process can't be work with current code.
>>
>> Please explain to me why we care about moving the flushs at all :)
>>
>> If they are NOP on most architectures either way, why not simply leave them there and call it a day?
> Uh, 2 reasons:
> 1, it uses page and can't convert to folio now.
> 2, as you pointed, flush action w/o page reading seems just waste time.

Alex, I don't think the approach you take for coming up with the current 
set of patches is a good idea.

Please reconsider what you can actually convert to folios and what must 
stay pages for now due to support for large folios in that code.

Then, please explain properly why changes are required and why they are 
safe.

For example, for in scan_get_next_rmap_item() we really *need* the page 
and not just the folio. So just leave the flushing there and be done 
with it.

-- 
Cheers,

David / dhildenb


