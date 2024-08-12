Return-Path: <linux-kernel+bounces-282761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C214D94E847
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D524282008
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64942166314;
	Mon, 12 Aug 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNoyHL4W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29E55896
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450377; cv=none; b=qg5mOYeKn0IRZxVf/sqVFcIC3V5C8sbtr7MxSR/gjzQiS3wlVd4mts3anInRO6IHjf7hW3/43kGdD2L0vXwIOCTyHZSX/8fCkqglV+G+d4CTvpuSImivmcbezW3J8N+wUpaeCt81Jwor4fKdOpiQ9zE012LsOoXbCRFAwbLwDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450377; c=relaxed/simple;
	bh=dz0V9NTqFz4sCd1B4mGAfWC+Mya5ZLb4ZlISM9Ufunk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiRrGPy5FTWewaZ3Ih45lrYsGvo0H92oebiW2DRFbM5/PwyQqMll2tvNWOMpDBIQYaq0QE7ixk2okZUuLQvoqZtA8eXGglZA2EDfzEJgmr1IgD3g+FHxtyR2U6a7QHa8bzHhUw8AcZN0ceabOEgyXo1zTLQouFdDLnGYz3edFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNoyHL4W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723450374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9/O94cIOAubUcCnH22HxzTXBVG3wCdY9CNBpRnC+1gc=;
	b=QNoyHL4WIZ95uFnyStdQYn0/e3tDjDpaDttDDYrKJO0rAAuc7ugwv+dFZYNQb6q810/pxN
	tcwWJ0Fupboy1c6ZFF2Clze9rlf2rAdPeFHva708XwZJY1qOp3zYDEiV1cbKSK+j3Id23d
	wX1f6d2qt98L4lQmsuxgPQq2XmbucL4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-M63MMd6UNYWGV2wEx6NWpA-1; Mon, 12 Aug 2024 04:12:52 -0400
X-MC-Unique: M63MMd6UNYWGV2wEx6NWpA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4281d0d1c57so23655175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723450371; x=1724055171;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9/O94cIOAubUcCnH22HxzTXBVG3wCdY9CNBpRnC+1gc=;
        b=uRFx1/Jp5mEQv5PhrjYoMzoGFKR+FuX3efUGAeU4rvHS4EpX42icFxK3QyDVwDoj5V
         1zEuiTSDNN3D9q4G1mrVgHBMiQQ9uWwbLlT6+a9pi4Xk2RELRxwBmdsx93wuXe0uwCdC
         JlcMrJeeNufNVpnjNqe4slh+iLaMUWXihFCj+l6LBYa8H/0lBZ/5pWhf1nTZR0RYaNQT
         Mi4aWSmRwPRzSu1QvrC4h+7l0BpJCXv/K2e+3eZczrVdoZ+DtOvZVKShy3UeC2FEAh9L
         9H2XdgVZxUzvmD/BkBtY75YMUAgZ8PsR/ZWKAb1yRk4LpMQI8VE8djuMvrS3Us1a+yvO
         R1nw==
X-Forwarded-Encrypted: i=1; AJvYcCWqoVo+Uy6ohKy6NM2ijnmgcV1OY2vVf0oshEuYQDXvvC3Gm//SPaprPWFmoPoWPE1RCh66FjI9QXU2uN5NwOMS3Z3XVdoNBEVxwfcV
X-Gm-Message-State: AOJu0YxZxexfWunbRNW74bb50YerKpwmn5PKi5D/SBzW+uQUzfO4kcMN
	4WveSnsLtfEgQ/dlnTYouSSqrh1xg12v16QFkclFffPlnYFMdykSrDxCktpYD4xmd9xq7Bso+yb
	B7khYFsABr5XJJrgZcSIf6aFrSdUmAQjZfXh4YSTBaBcCIqj5YlnfAMov7RiNow==
X-Received: by 2002:a05:600c:511e:b0:426:5b19:d2b3 with SMTP id 5b1f17b1804b1-4290b8ac120mr100753935e9.14.1723450371449;
        Mon, 12 Aug 2024 01:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd3yKp/oTOh03eeBsVmUJqgm6/TVCyV/bHHfaZTKDIWPgHeZDHDYWlPuryu+8SyGv4Uop/sw==
X-Received: by 2002:a05:600c:511e:b0:426:5b19:d2b3 with SMTP id 5b1f17b1804b1-4290b8ac120mr100753625e9.14.1723450370951;
        Mon, 12 Aug 2024 01:12:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c74ffb1esm92390395e9.5.2024.08.12.01.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 01:12:50 -0700 (PDT)
Message-ID: <66c4fcc5-47f6-438c-a73a-3af6e19c3200@redhat.com>
Date: Mon, 12 Aug 2024 10:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9%
 regression
To: Mateusz Guzik <mjguzik@gmail.com>, Yin Fengwei <fengwei.yin@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.08.24 06:49, Mateusz Guzik wrote:
> On Mon, Aug 12, 2024 at 12:43:08PM +0800, Yin Fengwei wrote:
>> Hi David,
>>
>> On 8/1/24 09:44, David Hildenbrand wrote:
>>> On 01.08.24 15:37, Mateusz Guzik wrote:
>>>> On Thu, Aug 1, 2024 at 3:34 PM David Hildenbrand <david@redhat.com>
>>>> wrote:
>>>>>
>>>>> On 01.08.24 15:30, Mateusz Guzik wrote:
>>>>>> On Thu, Aug 01, 2024 at 08:49:27AM +0200, David Hildenbrand wrote:
>>>>>>> Yes indeed. fork() can be extremely sensitive to each
>>>>>>> added instruction.
>>>>>>>
>>>>>>> I even pointed out to Peter why I didn't add the
>>>>>>> PageHuge check in there
>>>>>>> originally [1].
>>>>>>>
>>>>>>> "Well, and I didn't want to have runtime-hugetlb checks in
>>>>>>> PageAnonExclusive code called on certainly-not-hugetlb code paths."
>>>>>>>
>>>>>>>
>>>>>>> We now have to do a page_folio(page) and then test for hugetlb.
>>>>>>>
>>>>>>>        return folio_test_hugetlb(page_folio(page));
>>>>>>>
>>>>>>> Nowadays, folio_test_hugetlb() will be faster than at
>>>>>>> c0bff412e6 times, so
>>>>>>> maybe at least part of the overhead is gone.
>>>>>>>
>>>>>>
>>>>>> I'll note page_folio expands to a call to _compound_head.
>>>>>>
>>>>>> While _compound_head is declared as an inline, it ends up being big
>>>>>> enough that the compiler decides to emit a real function instead and
>>>>>> real func calls are not particularly cheap.
>>>>>>
>>>>>> I had a brief look with a profiler myself and for single-threaded usage
>>>>>> the func is quite high up there, while it manages to get out with the
>>>>>> first branch -- that is to say there is definitely performance lost for
>>>>>> having a func call instead of an inlined branch.
>>>>>>
>>>>>> The routine is deinlined because of a call to page_fixed_fake_head,
>>>>>> which itself is annotated with always_inline.
>>>>>>
>>>>>> This is of course patchable with minor shoveling.
>>>>>>
>>>>>> I did not go for it because stress-ng results were too unstable for me
>>>>>> to confidently state win/loss.
>>>>>>
>>>>>> But should you want to whack the regression, this is what I would look
>>>>>> into.
>>>>>>
>>>>>
>>>>> This might improve it, at least for small folios I guess:
>> Do you want us to test this change? Or you have further optimization
>> ongoing? Thanks.
> 
> I verified the thing below boots, I have no idea about performance. If
> it helps it can be massaged later from style perspective.

As quite a lot of setups already run with the vmemmap optimization enabled, I
wonder how effective this would be (might need more fine tuning, did not look
at the generated code):


diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 085dd8dcbea2..7ddcdbd712ec 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -233,7 +233,7 @@ static __always_inline int page_is_fake_head(const struct page *page)
         return page_fixed_fake_head(page) != page;
  }
  
-static inline unsigned long _compound_head(const struct page *page)
+static __always_inline unsigned long _compound_head(const struct page *page)
  {
         unsigned long head = READ_ONCE(page->compound_head);
  


-- 
Cheers,

David / dhildenb


