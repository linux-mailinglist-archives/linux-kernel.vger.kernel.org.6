Return-Path: <linux-kernel+bounces-271363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF09944D39
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104471F21564
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C819E822;
	Thu,  1 Aug 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO5rXL8J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087B13D520
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519294; cv=none; b=qlfhLqoYPG2O1j6xADYh70XCJWjhWSUzawhn+BPEWQyq97+nS+5qyKUczO4Zs1s7DJxsa1zzkXmzr6V51ZQDE6gCGw2jHmd4eI0GGqK77UR3zJ+4C+bqhuKpggl2Pr0B/h140ZgDhvTUkgLtkvgh5Xks0wyDTsT+BZszCJTb5fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519294; c=relaxed/simple;
	bh=YVzAlecd1qpd6PPLie37gHbpsOjTFMOqBJ3M6/Nsbc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUnbqj8NWuJ/tsu/yuU0lYKfRGsY3RvpKvFrB5YWQP1HOXnYls2oHqG2l+6sNdD0oNYyaUyv3e2pleLEAZOmty4tZYiYphMYLV+/MwofHxlD247aA1pyOc+COyQvthHZHfVmT15vI0GyWmnfWxkSsRH+ugOnnNCo5ny1l5uTxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EO5rXL8J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722519291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7VeraTL2UmLwQLKRE3xd5PLNoj7213HAaM5a3WpSzq0=;
	b=EO5rXL8JrEPhkATeK6OuFVPchRA+uFjMCIPfCXF5hzEyep7yIouz3G1qjz7wm0mLyNqbMJ
	fOmxBQYc7vjtT/2e8Nsoi1Og3nE6OsD+5sM4A7sbU/QN5f30S8mllDVwsC8bGbi3/vRJVJ
	O2BDlT8+plMJNeQE47pKItoKKlnCgQs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-30_pZVveNPWoSi-A7m6gaw-1; Thu, 01 Aug 2024 09:34:50 -0400
X-MC-Unique: 30_pZVveNPWoSi-A7m6gaw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3683f34d8d9so3033297f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722519289; x=1723124089;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7VeraTL2UmLwQLKRE3xd5PLNoj7213HAaM5a3WpSzq0=;
        b=KBFGWqZ55UXcsA86620ef1yvJJAPlh7kS6qkv6VjeBMSmVQ9hX5UCc7aXZLdAMLXmz
         wJHAZRsbJw7hZO51Jd3bIxIW+HfL0/OIRqldGunn4TCA7hvexPVAvdRYqEre6ZRhu6UG
         yjcZ00CYcrehROc4thq/gO3YrtJfYehhqZzwm3ipHBULJwJBURC4OoXxlNZ0QagBhqcz
         FIjCwOJqRmCaBGrQLw7pw9kavRLU6rlDVFIzNeUoZsVYBGN2p6sMwXiPW7Y4wd0QyxLq
         Bd4eVDt9RZ4puaOOj+cngMkdrk5BnLGjuh87fOARnizzJX5NbGdL/gpyDzTYT1IMPNq3
         07sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFUQpRom3E4LGwroqm1d4OPsmFEJF4j6tMmA35YMIX/JI8EHhB4HoAV2qyjTmCICw3nJpucfCZrE3OghU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7KoIuAyBnaoGeGWInoZ5HEHIgKovarqwx64YDgmyOHmzbPPe7
	Ejr5eOo2iRgMNAg+9BhsF4azX8Wg3IJK8rm1SQb1XXlTZeQBCjudZcdB1AXJLBOpQrsfxioLBba
	CzbNLXPCOMJE9Tara0wK3mgJyraPTsPno8SLug9oJfK68NIhKnsldf7erggKxkejeIBcPYA==
X-Received: by 2002:adf:cf01:0:b0:368:41e0:16c0 with SMTP id ffacd0b85a97d-36baacc9cf4mr1699711f8f.22.1722519289199;
        Thu, 01 Aug 2024 06:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/SOOHnHhQ5pnvHku631UHMTVOde3FFGLZS0ii1teG5jLkSNlSy6IqxyN2GNL2VavXkLC4Wg==
X-Received: by 2002:adf:cf01:0:b0:368:41e0:16c0 with SMTP id ffacd0b85a97d-36baacc9cf4mr1699680f8f.22.1722519288671;
        Thu, 01 Aug 2024 06:34:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857d66sm19403937f8f.83.2024.08.01.06.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 06:34:48 -0700 (PDT)
Message-ID: <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com>
Date: Thu, 1 Aug 2024 15:34:46 +0200
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
Cc: "Yin, Fengwei" <fengwei.yin@intel.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.24 15:30, Mateusz Guzik wrote:
> On Thu, Aug 01, 2024 at 08:49:27AM +0200, David Hildenbrand wrote:
>> Yes indeed. fork() can be extremely sensitive to each added instruction.
>>
>> I even pointed out to Peter why I didn't add the PageHuge check in there
>> originally [1].
>>
>> "Well, and I didn't want to have runtime-hugetlb checks in
>> PageAnonExclusive code called on certainly-not-hugetlb code paths."
>>
>>
>> We now have to do a page_folio(page) and then test for hugetlb.
>>
>> 	return folio_test_hugetlb(page_folio(page));
>>
>> Nowadays, folio_test_hugetlb() will be faster than at c0bff412e6 times, so
>> maybe at least part of the overhead is gone.
>>
> 
> I'll note page_folio expands to a call to _compound_head.
> 
> While _compound_head is declared as an inline, it ends up being big
> enough that the compiler decides to emit a real function instead and
> real func calls are not particularly cheap.
> 
> I had a brief look with a profiler myself and for single-threaded usage
> the func is quite high up there, while it manages to get out with the
> first branch -- that is to say there is definitely performance lost for
> having a func call instead of an inlined branch.
> 
> The routine is deinlined because of a call to page_fixed_fake_head,
> which itself is annotated with always_inline.
> 
> This is of course patchable with minor shoveling.
> 
> I did not go for it because stress-ng results were too unstable for me
> to confidently state win/loss.
> 
> But should you want to whack the regression, this is what I would look
> into.
> 

This might improve it, at least for small folios I guess:

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..7796ae116018 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1086,7 +1086,7 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
   */
  static inline bool PageHuge(const struct page *page)
  {
-       return folio_test_hugetlb(page_folio(page));
+       return PageCompound(page) && folio_test_hugetlb(page_folio(page));
  }
  
  /*


We would avoid the function call for small folios.

-- 
Cheers,

David / dhildenb


