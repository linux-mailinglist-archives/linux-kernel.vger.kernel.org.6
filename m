Return-Path: <linux-kernel+bounces-370661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B479A3054
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B3B2821F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF21D63C2;
	Thu, 17 Oct 2024 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+2Oa0JQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5EF1D54F2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202592; cv=none; b=JEggphFeOErwp5QCZeyrAzFw/yXD+VUpCmYrNAb0ZA/g77MAXnm0j5GR2hxxtG72qEHAVZAFcmaetwvr77h37i1eIAXs6ZFd+bRsEGZHI4dr1IQXX1d/VNP78yYTBLEdMmwMv8CIJUQicnPW1cmwsW7XrbNIS3DB8uC5bA3pWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202592; c=relaxed/simple;
	bh=bU9WqKLKJxgjvqo/IJScJDExjU5/7t5xdLX7OFKxV8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIER9M/q+BOwWg+kqZDpNYoAfJ5bexkqmM+jwsfR42VhMTeFSTuZb9QaK/ObkDLBzu+FbtACsYe2K1OiLuLxEN48LkBWlC37y5MzcMYj/DGDDkUOD57TNG9OUev41iZy2KdjdbKsWK/tqdFIfnfTYvAaE8E+k5ldI/oUHqpAw+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+2Oa0JQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729202589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q32jQVNfQWmZ8cx9WKFEUdpOkI/CR11n+jzfccgmn8s=;
	b=A+2Oa0JQJajhGOK2Bop3A/d2CLWRvWHvZ7ttgeO17Tugs5jSysvFyXsSkGt2etrNe0Ihyy
	0lT0o5BLLiR6N5NCf3pMlfw64lrGT5W1Ef0WyQy7Hz6nyLyUucMvexuzP1UH2X1Vj4odB2
	cyfSPADqiXsuVaY3LBxlb4UB3VLt2sw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-nZnDd1qQM3iM0E7CxGm8QQ-1; Thu, 17 Oct 2024 18:03:08 -0400
X-MC-Unique: nZnDd1qQM3iM0E7CxGm8QQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so7823355e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729202587; x=1729807387;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q32jQVNfQWmZ8cx9WKFEUdpOkI/CR11n+jzfccgmn8s=;
        b=xNLoOYRAtII68WtZOmO5fInaEJ9D8ypDC/TxrzOZSysUQFDkj7zJbywPKQEPlgJur0
         s/e72mNooz/a43I7/NTuztQLJpTOWB3x/1PVjknPjr+OF+4hZ/1NbcZtmayJ0WRjbFCx
         eg3J5vRNmz+DE+LNy9ntZJy6bjzlxbJMcag/rA/+ajzaJFYx1oUdjXXAOs4zldPZ+B/e
         AYwuI9EZ8mLJYlIk+LRiQ4NKEskNUv3/rOfIE2X/+dZLQRvTLxDXUEvteyWr+ID3w7us
         ViqZHQBNJ+MJfJeVuagwwpeqobLjWY3Qd3afvr4fZAqyoOkeZh7OQj+5HmyOVuuLu5lM
         PLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0tggDwILD6xgD8kaAuz0EWbiE5UWx1QiJGrt5mqqVsBu2hNMP4QymI/xiIlSAgxccsmzCxkoVshwkXG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4SfPaRIeLNMczqwWasKFtIU833PqhA9LaLA+VdJ5JZ9+hQf7
	/5OM9Lq8qox4BLtYgl5N4BCX0WWIFY5CwymzzPP8cTHsBwQ543/XmkznkzNZdnPbgPdSBgCVDPm
	iMHR7xaqC2HuckxfJYYftcE0mA0qO5GDUR1ASBCxhEHkjpv8/3y1Anu9+UP6I/w==
X-Received: by 2002:a05:600c:c84:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-4316161fafdmr1187555e9.3.1729202587484;
        Thu, 17 Oct 2024 15:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH+W/QUgVbyEWw3+7M5otGW0OnSdtg+qrrtRnMJhvEDhrQraS5KJ681XlH0hst7j5DIuz9rw==
X-Received: by 2002:a05:600c:c84:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-4316161fafdmr1187405e9.3.1729202587071;
        Thu, 17 Oct 2024 15:03:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431606c64a9sm8374305e9.32.2024.10.17.15.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 15:03:05 -0700 (PDT)
Message-ID: <91dbe5c9-68c3-4e92-a9c3-a3dad77d6dc2@redhat.com>
Date: Fri, 18 Oct 2024 00:03:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
To: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Shigeru Yoshida <syoshida@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Minchan Kim <minchan@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
 <87v7xqmmxt.fsf@nvdebian.thelocal>
 <52bd4862-d6ce-48f6-9bc2-0f7376a56115@redhat.com>
 <a84d415d-dd18-49ef-b72a-ee381a44a429@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a84d415d-dd18-49ef-b72a-ee381a44a429@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.10.24 23:57, John Hubbard wrote:
> On 10/17/24 2:47 PM, David Hildenbrand wrote:
>> On 17.10.24 23:28, Alistair Popple wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>> On 16.10.24 22:22, John Hubbard wrote:
> ...
>>>>> +        if (rc != -EAGAIN && rc != 0)
>>>>> +            unpin_user_pages(pages, nr_pinned_pages);
>>>>> +
>>>>>         } while (rc == -EAGAIN);
>>>>
>>>> Wouldn't it be cleaner to simply have here after the loop (possibly
>>>> even after the memalloc_pin_restore())
>>>>
>>>> if (rc)
>>>>      unpin_user_pages(pages, nr_pinned_pages);
>>>>
>>>> But maybe I am missing something.
>>>
>>> I initially thought the same thing but I'm not sure it is
>>> correct. Consider what happens when __get_user_pages_locked() fails
>>> earlier in the loop. In this case it will have bailed out of the loop
>>> with rc <= 0 but we shouldn't call unpin_user_pages().
> 
> doh. yes. Thanks for catching that, Alistair! I actually considered
> it during the first draft, too, but got tunnel vision during the
> review, sigh.
> 
>>
>> Ah, I see what you mean, I primarily only stared at the diff.
>>
>> We should likely avoid using nr_pinned_pages as a temporary variable that
>> can hold an error value.
>>
> 
> OK, I still want to defer all the pretty refactoring ideas into some
> future effort, so for now, let's just leave v1 alone except for fixing
> the typo in the comment, yes?

Fine with me!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


