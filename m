Return-Path: <linux-kernel+bounces-286400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52300951A84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ED81F23253
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A681AD40B;
	Wed, 14 Aug 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2HvMOoD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38E13D51D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636972; cv=none; b=pCcOlgFOIzwgBl9w/xVZ/XS/L8W/PCgw/CjZoa3sgpnnIEbBqxvwRP/HItuEkId0Bg9zEvaBsS7ULKIdqQnDBxOYDropoJeSF2PDAwRWuyv078Uv4s11aTtqMHowR7vdY5JGdj64TfLl7u6DiCc9YZ6vC/YGtuO+8m4H+cTXlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636972; c=relaxed/simple;
	bh=OGyn8eMF3CuGWeBJEAFztHG64evrs8oZxrrmOT3q3DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVM/dNOisjOWTvTCwA2MEs3fZPWA8FWadObcv8M+8O0s0uBZmxEtN0VRFv22yY+hv990VC6xlHfqmGnzOsmzoY1U419BNX5BhcNZJYVeZx/e/gI/BnXyV70WBp25oGaHtBv8IDoJ2m9zBgVy1A0qTAvObeDPpv/+N8bC4VDBgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2HvMOoD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723636969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GMXMQTZDYE6luh611XN2OI8EVP3+a0ynEUGI8ZYLzb8=;
	b=H2HvMOoD0gQsvgHu39G3eRM/rgn5xMns9gpxEJkltOrZoGltTIf8Xn08nmDzInh1FX8GFa
	v+M72UmlKtNuWwLKG7vSHfk02aTlmj0LkjSrDEr+Dz1fli8nSmh8DIvfg70mdD0Y8Hrgpm
	mcp6s74bdr7Jx4IysFhwulk+K5g4r48=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-LlvnhFE7Ps25JTwyDbkyFw-1; Wed, 14 Aug 2024 08:02:48 -0400
X-MC-Unique: LlvnhFE7Ps25JTwyDbkyFw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3684ea1537fso3153708f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723636967; x=1724241767;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GMXMQTZDYE6luh611XN2OI8EVP3+a0ynEUGI8ZYLzb8=;
        b=udebXVprQFcK0q5tSrIaDp1TcTftL0R8j1p5NnroICsYlQegCx5QW+xvh0lbKLwXKg
         2FEL9B0XiXwVHYR99Vjk9BmpAWRm1WIrgRux6rde8RCa1v/ragmDbL2KkydpTUsjwxso
         YwrlzRw49XULCEkK0KKQQM/hr+aciDFZSC+JfiNxMfIJ30gK+DFnaIJ15tzC+iBghIVt
         k9LBtm4vF+FHPuCBQImclLO1XkX9euTbxHjKO0GQEvJZaJz64bt40Mt5GQMoDSH6l/39
         IrOkKzwE1hqAkIChmFBlSZLPGckzgjGkGSDzANO5AyGHvI6eB6h+z/CW804UeWfX0iBh
         y12Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPIHvgFnWZajaI8hUZZ6JRu+PgzJQJ2lplH6MtWFBtGVj+8LAosSsC0hHzyG/H4rawjyhFgttqd1hTXBH+xCeKe2Pk5ID2XXE/83Jf
X-Gm-Message-State: AOJu0YxBvWTg9ag9/6YNxowcfTBsuZKX+7GSx2eP5h9UPg7L5af0lSRc
	96MXhtykxKS0jknqMSQbBEEXTsg6yWd+thpeks7MW+JzBA92AVD8GgoTFIqHYmf0fzZ+4MqkAur
	SBbiOVToN8i6rHUqLqPPVyLPdu182PARjTu9r5c5m5nWuY01yfx3hLv93tbxAOg==
X-Received: by 2002:adf:f542:0:b0:371:6ff3:d578 with SMTP id ffacd0b85a97d-37177756804mr1908594f8f.6.1723636967264;
        Wed, 14 Aug 2024 05:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETUgVE1o5r0CQo3MheUwAWZg3aCLbqDQBvgbZWPvVeMLYUHQzD9ZMpTqtmvMSJiclXMA/p+Q==
X-Received: by 2002:adf:f542:0:b0:371:6ff3:d578 with SMTP id ffacd0b85a97d-37177756804mr1908555f8f.6.1723636966642;
        Wed, 14 Aug 2024 05:02:46 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6e46.dip0.t-ipconnect.de. [91.12.110.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3717d27b9d4sm486496f8f.21.2024.08.14.05.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 05:02:46 -0700 (PDT)
Message-ID: <69f480d6-2dd8-4efb-9516-70d74eceedd5@redhat.com>
Date: Wed, 14 Aug 2024 14:02:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9%
 regression
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>,
 kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Matthew Wilcox <willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>,
 linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
 <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
 <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com>
 <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
 <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com>
 <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>
 <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2>
 <817150f2-abf7-430f-9973-540bd6cdd26f@intel.com>
 <CAGudoHG1=p0GEVaSASA1C+iVYbfA5rryozAPPEoxr5uKtM=ghw@mail.gmail.com>
 <f4ddda8d-3513-4471-8609-acb3ce29219e@intel.com>
 <CAGudoHECfSYd7EcxiY+soh157m9H4xfU1en=TgX_=QkpbsOFdg@mail.gmail.com>
 <116e117c-2821-401d-8e62-b85cdec37f4a@redhat.com>
 <CAGudoHGzNu4MUDyd1OeP+R=TdOzO6Nidk26_hrinBncz6FpGvw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGudoHGzNu4MUDyd1OeP+R=TdOzO6Nidk26_hrinBncz6FpGvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.08.24 13:06, Mateusz Guzik wrote:
> On Wed, Aug 14, 2024 at 11:45 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 14.08.24 06:10, Mateusz Guzik wrote:
>>> On Wed, Aug 14, 2024 at 5:02 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>>>
>>>> On 8/13/24 03:14, Mateusz Guzik wrote:
>>>>> would you mind benchmarking the change which merely force-inlines _compund_page?
>>>>>
>>>>> https://lore.kernel.org/linux-mm/66c4fcc5-47f6-438c-a73a-3af6e19c3200@redhat.com/
>>>> This change can resolve the regression also:
>>>
>>> Great, thanks.
>>>
>>> David, I guess this means it would be fine to inline the entire thing
>>> at least from this bench standpoint. Given that this is your idea I
>>> guess you should do the needful(tm)? :)
>>
>> Testing
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 5769fe6e4950..25e25b34f4a0 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -235,7 +235,7 @@ static __always_inline int page_is_fake_head(const struct page *page)
>>           return page_fixed_fake_head(page) != page;
>>    }
>>
>> -static inline unsigned long _compound_head(const struct page *page)
>> +static __always_inline unsigned long _compound_head(const struct page *page)
>>    {
>>           unsigned long head = READ_ONCE(page->compound_head);
>>
>>
>> With a kernel-config based on something derived from Fedora
>> config-6.8.9-100.fc38.x86_64 for convenience with
>>
>> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
>>
>> add/remove: 15/14 grow/shrink: 79/87 up/down: 12836/-13917 (-1081)
> [snip]
>> Total: Before=32786363, After=32785282, chg -0.00%
> 
> I guess there should be no opposition then?
> 
> Given that this is your patch I presume you are going to see this through.

I was hoping that you could send an official patch, after all you did 
most of the work here.

> 
> I don't want any mention or cc on the patch, thanks for understanding :)

If I have to send it I will respect it.

-- 
Cheers,

David / dhildenb


