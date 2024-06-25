Return-Path: <linux-kernel+bounces-229668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9836A91729A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C36C28334D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3D117D88C;
	Tue, 25 Jun 2024 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAj4M7hm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C444C6E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348078; cv=none; b=akiV8HlytcXGxq/UonbdZEDljgvfxVzQXwoFEAbf+MjGwJv19U4YvLnBSf9OaOaLd7y9ND0mlrO0jimXaVtPtG8Pz8yMLs1lAyhT/pejoFx3eYzy/+HvEYebcvw7gIkapW1Vx6SRSlC5qPqwmfFKepU8Dt1ykJJcVnqFhZHULL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348078; c=relaxed/simple;
	bh=SAo3jCAA3Q0QHEz348ac/3Eb0PL2wRnp76/hMdfz4mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPmg1HHDnca1INbC4AXbgYqJa4im6jNPPldHw8WV70JkXt9IL+PoR3hgS7J2E01CELj4CQnZ/568/jWI1v245Qs7cC2Mr4Cph34/XEnmqpxkqP74tL3jdjCoDE/JyhqET+XF58aPL6v0AuFTvtGoiHy9n4UrN/H4PxaxHPaOAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAj4M7hm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719348075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8o/LZltz2Srf/59+hcmhRn1Z8GI9CbfzhFVCfFTqJko=;
	b=dAj4M7hmkYT3MbYdHoeCx5Li6WJK7S21pzaSh6cOzGuNgNe9PUtJ744+VurznPOrXGB3I9
	24qxOayATJlXgfcG5dXHa7Il7zeTF1gMRQb9J/mwsqRJsJLF4Zy/cGNzT+N0PQJwxPrz5g
	4mRnsBCyVlZH0PEzWs5U5tnmuchiomk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-bW0yr10SOhCUurW4xg3AoQ-1; Tue, 25 Jun 2024 16:41:13 -0400
X-MC-Unique: bW0yr10SOhCUurW4xg3AoQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42196394b72so36387685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719348073; x=1719952873;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8o/LZltz2Srf/59+hcmhRn1Z8GI9CbfzhFVCfFTqJko=;
        b=w/Y8x9ntmH7Fo21CPQOGQVhKOp7T4atfAWCjCmZSCi7HjAyyCGy+WbbWZgoLd6EeZn
         XBObY3u0uWtwTa2g41wpBxlok/szhvFYkZG1h3HIj9irNC07oUNQCZg0tQYEWyEOLCDk
         NdO0qUW74qLsUtfqKmRyZkRFxlHXmE5gY0LSIHennLirzdSjv5g4jbMKXuzFTM3C69zV
         hIG6oDYdekiONRfEMrGpLUfV04xDwhaOJlxJ78hKg2ukRmFbZojl5TOj7M6UfKzz+sCa
         JWJo/hnshLrOg+etn/2EcY6qak5pzwuDQ09wVquzwPvtXZjSNqF1cPbMd8EwfU/Cw/1h
         DoCA==
X-Forwarded-Encrypted: i=1; AJvYcCUs8XKK/kuQTtHFNIjWf8BAlSnypyhFFix2bT0Qeu15qQL5FjYUiSxzSbwwjnVVDgiY0JTwDg4/XQaYHCj+IyFB48XCOGR6Vjptf8Pd
X-Gm-Message-State: AOJu0YyBhMjEYqgiwqAjaYzU5fdv9sAhxh2EJ7bqrthh1L8qZD2RYz7X
	6mBrTgPBZQ5+vQDie8cGAies2lF+YjJR+A71scsVXFb+slJsSdC+sNbsD/me5ftnzCtsQ1gEgv2
	U8ZL1m9hBQ9p5ACaXhkeq3tf7LiE+suhRc9GOpHumcqAEQLzERhpLANWtq+dNSQ==
X-Received: by 2002:a5d:61c2:0:b0:35f:10a0:9b7 with SMTP id ffacd0b85a97d-366e95db2f1mr4875828f8f.46.1719348072787;
        Tue, 25 Jun 2024 13:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPWXWs96hXpRVsd/M233FSA1Wm/ro0WOYYwz6ZNo6zROmWfLhjGHJalzTa8m7E6AVV00Dkcw==
X-Received: by 2002:a5d:61c2:0:b0:35f:10a0:9b7 with SMTP id ffacd0b85a97d-366e95db2f1mr4875817f8f.46.1719348072290;
        Tue, 25 Jun 2024 13:41:12 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c823c28asm712865e9.5.2024.06.25.13.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 13:41:11 -0700 (PDT)
Message-ID: <fc16f6d0-9605-43c6-8199-179029dac6d4@redhat.com>
Date: Tue, 25 Jun 2024 22:41:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
To: Yang Shi <shy828301@gmail.com>, Oliver Sang <oliver.sang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christopher Lameter <cl@linux.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 Rik van Riel <riel@surriel.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lkp@intel.com, oe-lkp@lists.linux.dev
References: <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com>
 <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
 <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com>
 <CAHbLzkpnDPYWq=HnaJcKhKnppdNikX4YG+1Ysu8Z+XJCoKK4SQ@mail.gmail.com>
 <CAHbLzkr5K=4Shiyb5KgPTQ20jE2Zo08wK=mT3Ez9ADEdJe0Z9A@mail.gmail.com>
 <Zl3M7iniPQaPFDrW@xsang-OptiPlex-9020>
 <CAHbLzkrOTAaYahG4JYMNrJDhQNZZxW9u+2n71J=v1XYJEVpUdw@mail.gmail.com>
 <CAHbLzkr16YZ80ES5U4BEWJ+ueL22nDJtgH=eOztdHfy080diPw@mail.gmail.com>
 <ZmEb2mdAbBQ/9PMP@xsang-OptiPlex-9020>
 <CAHbLzkqORuPjr3p7aZGPKSLfdptrg=z1624rcxjud_zs3+HnCA@mail.gmail.com>
 <Zmk5xAF+vHYLwzoG@xsang-OptiPlex-9020>
 <CAHbLzkp3bEE50n1DKfXUYHoGivOzdhwQsLF=s64QVJUEaWCG8Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAHbLzkp3bEE50n1DKfXUYHoGivOzdhwQsLF=s64QVJUEaWCG8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.06.24 22:34, Yang Shi wrote:
> On Tue, Jun 11, 2024 at 11:01 PM Oliver Sang <oliver.sang@intel.com> wrote:
>>
>> hi, Yang Shi,
>>
>> On Wed, Jun 05, 2024 at 08:44:37PM -0700, Yang Shi wrote:
>>> Oliver Sang <oliver.sang@intel.com>于2024年6月5日 周三19:16写道：
>>>
>>>> hi, Yang Shi,
>>>>
>>>> On Tue, Jun 04, 2024 at 04:53:56PM -0700, Yang Shi wrote:
>>>>> On Mon, Jun 3, 2024 at 9:54 AM Yang Shi <shy828301@gmail.com> wrote:
>>>>>>
>>>>>> On Mon, Jun 3, 2024 at 7:02 AM Oliver Sang <oliver.sang@intel.com>
>>>> wrote:
>>>>>>>
>>>>>>> hi, Yang Shi,
>>>>>>>
>>>>>>> On Fri, May 31, 2024 at 01:57:06PM -0700, Yang Shi wrote:
>>>>>>>> Hi Oliver,
>>>>>>>>
>>>>>>>> I just came up with a quick patch (just build test) per the
>>>> discussion
>>>>>>>> and attached, can you please to give it a try? Once it is
>>>> verified, I
>>>>>>>> will refine the patch and submit for review.
>>>>>>>
>>>>>>> what's the base of this patch? I tried to apply it upon efa7df3e3b or
>>>>>>> v6.10-rc2. both failed.
>>>>>>
>>>>>> Its base is mm-unstable. The head commit is 8e06d6b9274d ("mm: add
>>>>>> swappiness= arg to memory.reclaim"). Sorry for the confusion, I should
>>>>>> have mentioned this.
>>>>>
>>>>> I just figured out a bug in the patch. Anyway, we are going to take a
>>>>> different approach to fix the issue per the discussion. I already sent
>>>>> the series to the mailing list. Please refer to
>>>>>
>>>> https://lore.kernel.org/linux-mm/20240604234858.948986-1-yang@os.amperecomputing.com/
>>>>
>>>> got it. seems you will submit v2? should we wait v2 to do the tests?
>>>
>>>
>>> The real fix is patch #1, that doesn’t need v2. So you just need to test
>>> that.
>>
>> we've finished tests and confirmed patch #1 fixed the issue.
>> we also tested upon patch #2, still clean.
> 
> Thanks for testing. Sorry for the late reply, just came back from
> vacation. It seems like Andrew didn't take the fix yet. I will resend
> the patch with your tested-by tag. And I will drop the patch #2 since
> it is just a clean up and I didn't receive any review comments. In
> addition, the undergoing hugepd clean up may make this clean up
> easier, so I will put the clean up on the back burner for now.

Sorry, was expecting a v2 of the second patch. But agreed that posting 
the second patch separately is reasonable -- possibly after the hugepd 
stuff is gone for good.

-- 
Cheers,

David / dhildenb


