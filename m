Return-Path: <linux-kernel+bounces-280921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6194D0ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93CB21C21E81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4178018C93F;
	Fri,  9 Aug 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyCdURGf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1202F37
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209354; cv=none; b=fx157oFw6Og4iLhvZ/4tnwftVCxgeYGLLCOrW85lsbOzYpHxEK8pn7VYFJpl9Biu45jDBnIJCyNBBkOlBUz0FhMXU5/ekHdi9GOziTRXndQEosGi2suGUAqDN9mEhWydkblppNiNhY3rBhi6UB1xUQwqf7KbLfUoj7kfax2GwyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209354; c=relaxed/simple;
	bh=7OLHuZLA+wekoF1jSliPoUFrt/5wGnEFVctAIBp4AJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUaeczbvET3eWsoGKW6XZ5On05riTzpiaDoqEIrmVFFRNAuBhoan2VonfTmp2enMzo0IuWK+tsA0Q+zH18haxQXaMQL0PXTVis+f23p8fBYKDjNmrF+NvHnMh80TFkgINjWGqpg8JlW/3hNM0zn3chPoUkb7y6Y3h/sIqp4bNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyCdURGf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723209351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qazZ/ldG9PSzs/XNp1paWJ3VAtmzoEMclWJ73reXsYU=;
	b=SyCdURGfpWcLQXTDSnsgLZYRECx3lZ/bqmhgtNmeAlZ29rvlIzer+Nn3ljaxd4CV5nFu74
	gMeicwy033wBpxFqKm560zTT56pVBtzYfif975K4dVMOwI/fpTdFODCvGosx1+qNGdTFfC
	+85yjX70nLRw0p+fVPelj5rJdrEH2lI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-H18b89QePkKHKe54DalpUw-1; Fri, 09 Aug 2024 09:15:50 -0400
X-MC-Unique: H18b89QePkKHKe54DalpUw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-369bf135b49so1119171f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209349; x=1723814149;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qazZ/ldG9PSzs/XNp1paWJ3VAtmzoEMclWJ73reXsYU=;
        b=K9y/3wpD44vnFW5QuPPsJyGRz/MEnil+sC5PB/GSJnj4S7L0JrwkSfVc5pUmvt/gFo
         Je1e5LO2PelutJ1oVtkt1iQjXewbcdTAJbK1WUyVs3vd3avOmvMYU/X1OCUT43fblruE
         lhUri33EgVBZ/vQY2jmWnOlid6q5zZzmBHI8WV1QBdIM9vrirA2DK+/eglmWpXa9g1Yl
         36GNlfAGSg/vTacHcss8zzGitOgJockJ5fLyvKLrxPcz42Mf7ygEVuzOBR/fJuL63YjE
         GkGcw5GkqXvULKC3kZO3NvtHcyNQk50KUdARHl+hhHfUK6opVLUhiiCxKhaDDWPj63ey
         35yA==
X-Forwarded-Encrypted: i=1; AJvYcCU81FRTWzKnWHyEpnEZDL9BZRd3XNNxyHJD1fQmkkOzyW+7nW82xQk1KZbG3wGkevV5n1L4lqlNiR3btuokhjRp2gqtnR+cO68Xg6qp
X-Gm-Message-State: AOJu0YzFZBQP6cORyefhcVclqzt259WXgRIuNfGCZ0tvZYdJ+y8nUjGK
	dR3tc43hVHlgaKKbqUpwqjmaQT6AUmuU4Q2LXfhgMT8CHVo18LE+AN71BbBr0KLAmma6r3jt4/3
	lpo76VJDnbCStI3YaT0IotfrbMnPhbRAdjgbhYBBxAcNa87EpxOi+Bljy999DuFOS7QvII1EH
X-Received: by 2002:a05:6000:e08:b0:362:4679:b5a with SMTP id ffacd0b85a97d-36d2815552dmr4390715f8f.16.1723209348851;
        Fri, 09 Aug 2024 06:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+gV9pb9K6js3sl4IRkNI8+q752q3xEGqEfpoWY39nMDHNpHyWsT8ZZsSwk9S9iWI14XXFoA==
X-Received: by 2002:a05:6000:e08:b0:362:4679:b5a with SMTP id ffacd0b85a97d-36d2815552dmr4390686f8f.16.1723209348282;
        Fri, 09 Aug 2024 06:15:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7728c5sm76115605e9.32.2024.08.09.06.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 06:15:47 -0700 (PDT)
Message-ID: <8258bf4c-ecec-4e06-ada0-da9fb99b1219@redhat.com>
Date: Fri, 9 Aug 2024 15:15:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240808101700.571701-1-ryan.roberts@arm.com>
 <99b78488-c524-4269-b1fb-a13eaa4f274c@redhat.com>
 <CAGsJ_4z2D2yWWZhUM_yDSdn9=zpkYkHhzAKO8CQ1Xu3gDaECRA@mail.gmail.com>
 <75eb6e75-8a6d-460a-8e96-7496ed1396b7@redhat.com>
 <3c8f00ea-af28-46c7-9a5d-83c4b9462be3@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3c8f00ea-af28-46c7-9a5d-83c4b9462be3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>>> -You can change the sysfs boot time defaults of Transparent Hugepage
>>>>> -Support by passing the parameter ``transparent_hugepage=always`` or
>>>>> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
>>>>> -to the kernel command line.
>>>>> +You can change the sysfs boot time default for the top-level "enabled"
>>>>> +control by passing the parameter ``transparent_hugepage=always`` or
>>>>> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
>>>>> +kernel command line.
>>>>> +
>>>>> +Alternatively, each supported anonymous THP size can be controlled by
>>>>> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
>>>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
>>>>> +``inherit``.
>>>>> +
>>>>> +For example, the following will set 64K THP to ``always``::
>>>>> +
>>>>> +     thp_anon=64K:always
>>>>> +
>>>>> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
>>>>> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
>>>>> +not explicitly configured on the command line are implicitly set to
>>>>> +``never``.
>>>>
>>>> I suggest documenting that "thp_anon=" will not effect the value of
>>>> "transparent_hugepage=", or any configured default.
> 
> Did you see the previous conversation with Barry about whether or not to honour
> configured defaults when any thp_anon= is provided [1]? Sounds like you also
> think we should honour the PMD "inherit" default if not explicitly provided on
> the command line? (see link for justification for the approach I'm currently
> taking).

I primarily think that we should document it :)

What if someone passes "transparent_hugepage=always" and "thp_anon=..."? 
I would assume that transparent_hugepage would only affect the global 
toggle then?

> 
> [1]
> https://lore.kernel.org/linux-mm/CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-Dt7Ewt3ExqTw@mail.gmail.com/
> 
>>>>
>>>> Wondering if a syntax like
>>>>
>>>> thp_anon=16K,32K,64K:always;1048K,2048K:madvise
> 
> Are there examples of that syntax already or have you just made it up? I found
> examples with the colon (:) but nothing this fancy. I guess that's not a reason
> not to do it though (other than the risk of screwing up the parser in a subtle way).

I made it up -- mostly ;) I think we are quite flexible on what we can 
do. As always, maybe we can keep it bit consistent with existing stuff.

For hugetlb_cma we have things like
	"<node>:nn[KMGTPE|[,<node>:nn[KMGTPE]]

"memmap=" options are more ... advanced, including memory ranges. There 
are a bunch more documented in kernel-parameters.txt that have more 
elaborate formats.

Ranges would probably be the most valuable addition. So maybe we should 
start with:

	thp_anon=16K-64K:always,1048K-2048K:madvise

So to enable all THPs it would simply be

	thp_anon=16K-2M:always

Interesting question what would happen if someone passes:

	thp_anon=8K-2M:always

Likely we simply would apply it to any size in the range, even if 
start/end is not a THP size.

But we would want to complain to the user if someone only specifies a 
single one (or a range does not even select a single one) that does not 
exist:

	thp_anon=8K:always

> 
>>>>
>>>> (one could also support ranges, like "16K-64K")
>>>>
>>>> Would be even better. Then, maybe only allow a single instance.
>>>>
>>>> Maybe consider it if it's not too crazy to parse ;)
> I'll take a look. I'm going to be out for 3 weeks from end of Monday though, so

Oh, lucky you! Enjoy!

> probably won't get around to that until I'm back. I know Barry is keen to get
> this merged, so Barry, if you'd like to take it over that's fine by me (I'm sure
> you have enough on your plate though).


-- 
Cheers,

David / dhildenb


