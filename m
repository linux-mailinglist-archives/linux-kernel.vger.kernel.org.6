Return-Path: <linux-kernel+bounces-248578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD10992DF34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1721B2840DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF034084E;
	Thu, 11 Jul 2024 04:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bl04fBux"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F615AE0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720673592; cv=none; b=c8YW/zNn7SMGw+yCLbne5ow/9ljpytdCc7QTQ9//XlyLj5fPpOP9v7bUn7L2xJ1aOpYyYvXKtJQwZ30lLnwmoEQTkpHvgxsfUXShSGxcqnHMDW70B5Rhdn8WQf4Q+t4skrtwBRjXpzdTtyNSv2Fm1xddVw+D5ORhWOeHiG3uGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720673592; c=relaxed/simple;
	bh=Or7bw6wvZdrSRlLf29yh1BSvsYPyl0c/svI1h5EAQRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXOu8x1tYWwNJ2xOxdiamqftpITplg27KKQ3cbt0jSwH483d/D0qUV4VtqiFkLW4T/YA5a2ED3rp0OUFT4Ff5wzcBWe4JT+MIzz7DyIcY1FMsQjrGiFQo2Om171Rzy04xlozY/04ZNFWdqQa5LQMjaOx6fhn2apzkV2rj/ys4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bl04fBux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720673589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8g0zUV8cpJI+idm/YiDkSx9qRkVF3fRL4fAS6ajS/uY=;
	b=bl04fBuxnPPt4zFh8udQ1N3p9jvBxPKMg2XlBEfkYvhLBwJD38HFF4JEMZGxFMqMf3Zn7K
	znqTkg+H2S2iygfvGTBvu5BLN9i6zIhCX+neAHIj4ZZuj0RZl5k0XT3iNTwi0LVh/ZCPlo
	d4SQzhvPlapdK/f2k3OffFJbAWAKPHs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-i-VjHGP5OFuZDnWUWgNQjA-1; Thu, 11 Jul 2024 00:53:07 -0400
X-MC-Unique: i-VjHGP5OFuZDnWUWgNQjA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7278c31e2acso354288a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720673586; x=1721278386;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8g0zUV8cpJI+idm/YiDkSx9qRkVF3fRL4fAS6ajS/uY=;
        b=NHrNNVkWrLMJFvanVL5oU8UrmNkAgxYO7MVbs1c43N7xFP9TGJyMY5pgBX9eIKKlad
         PWNttJkFElMDATy3L5bRl2A/j1hThOuxofN0EINhpvEYPLLMM3fGR8yaC9njtVYF2XUl
         SqesNOhkxuTT7Pp/XuffVMiHvsqOSS7KFxwvJFY1ElXS/eFZ8Tv9lQ6ePDwTLdsPXigA
         +U3Pl1pq5k+XaL4ZRYe7QOB803O7cGGQlHhaq0nDl3uVSkU4tO2RFb3dQC1r6YRFYn3g
         m1bIo++wGd2n/YakCClqqQx5kcpYh3PKcAENN8Qg9Rx0cwKF8i6iJ/CyMIk6P0W73UwH
         ABtw==
X-Forwarded-Encrypted: i=1; AJvYcCWK4Y7BCDZSfTfx3VPz/Q3UUgYTZpOa9mpw5ks7dAAmjOjQVsShsYRDGJiMw3AvGeVfKxI+xJ+xuezNpBW5x2DGma4TmcIM1lZZdkXL
X-Gm-Message-State: AOJu0Yzo2JCscxtMAhtjhwfblc5BoiIwm+QyLvkw4mYhRFSl6pRT4iHi
	z/WQIvvvaQ8yRobmHkDrZRf6D1GhPPfH/ex1Q6ADdbkDuf31H5u/gh20lUuQydJ8qJLflY890AL
	yCuHxemhoi1+vndqC9caO+HLrTzc0wcHvnYYASl1h/+tl+LFemHFhDxyQDxxAMw==
X-Received: by 2002:a05:6a20:7485:b0:1c2:97cd:94d8 with SMTP id adf61e73a8af0-1c298223d92mr8162577637.20.1720673586091;
        Wed, 10 Jul 2024 21:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuBcnPgOQDfaSMbgn/kyNHvB/POCVtdzyItufrxyMr6RCyOy1aQROJt2qdO3GzMLBPA+LuQA==
X-Received: by 2002:a05:6a20:7485:b0:1c2:97cd:94d8 with SMTP id adf61e73a8af0-1c298223d92mr8162561637.20.1720673585706;
        Wed, 10 Jul 2024 21:53:05 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2c0dasm41719515ad.108.2024.07.10.21.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 21:53:05 -0700 (PDT)
Message-ID: <f2fbe39e-20c6-470c-a2b3-100185ee2f43@redhat.com>
Date: Thu, 11 Jul 2024 06:53:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
To: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jason Gunthorpe <jgg@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com> <Zoax9nwi5qmgTQR4@x1n>
 <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
 <Zoug1swoTOqNUPJo@localhost.localdomain>
 <9d5980e3-72e6-4848-b1ac-83ffab8522c4@redhat.com>
 <Zo5v_hefrYFImqBC@localhost.localdomain>
 <0f01c613-9e4f-47b6-af2b-09aa90437d90@redhat.com>
 <Zo9kDNFljpVzl69Z@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zo9kDNFljpVzl69Z@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 06:48, Oscar Salvador wrote:
> On Thu, Jul 11, 2024 at 02:15:38AM +0200, David Hildenbrand wrote:
>>>> (as a side note, cont-pte/cont-pmd should primarily be a hint from arch code
>>>> on how many entries we can batch, like we do in folio_pte_batch(); point is
>>>> that we want to batch also on architectures where we don't have such bits,
>>>> and prepare for architectures that implement various sizes of batching;
>>>> IMHO, having cont-pte/cont-pmd checks in common code is likely the wrong
>>>> approach. Again, folio_pte_batch() is where we tackled the problem
>>>> differently from the THP perspective)
>>>
>>> I must say I did not check folio_pte_batch() and I am totally ignorant
>>> of what/how it does things.
>>> I will have a look.
>>>
>>>> I have an idea for a better page table walker API that would try batching
>>>> most entries (under one PTL), and walkers can just register for the types
>>>> they want. Hoping I will find some time to at least scetch the user
>>>> interface soon.
>>>>
>>>> That doesn't mean that this should block your work, but the
>>>> cont-pte/cont/pmd hugetlb stuff is really nasty to handle here, and I don't
>>>> particularly like where this is going.
>>>
>>> Ok, let me take a step back then.
>>> Previous versions of that RFC did not handle cont-{pte-pmd} wide in the
>>> open, so let me go back to the drawing board and come up with something
>>> that does not fiddle with cont- stuff in that way.
>>>
>>> I might post here a small diff just to see if we are on the same page.
>>>
>>> As usual, thanks a lot for your comments David!
>>
>> Feel free to reach out to discuss ways forward. I think we should
>>
>> (a) move to the automatic cont-pte setting as done for THPs via
>>      set_ptes().
>> (b) Batching PTE updates at all relevant places, so we get no change in
>>      behavior: cont-pte bit will remain set.
>> (c) Likely remove the use of cont-pte bits in hugetlb code for anything
>>      that is not a present folio (i.e., where automatic cont-pte bit
>>      setting would never set it). Migration entries might require
>>      thought (we can easily batch to achieve the same thing, but the
>>      behavior of hugetlb likely differs to the generic way of handling
>>      migration entries on multiple ptes: reference the folio vs.
>>      the respective subpages of the folio).
> 
> Uhm, I see, but I am bit confused.
> Although related, this seems orthogonal to this series and more like for
> a next-thing to do, right?

Well, yes and no. The thing is, that the cont-pte/cont-pmd stuff is not 
as easy to handle like the PMD/PUD stuff, and sorting that out sounds 
like some "pain". That's the ugly part of hugetlb, where it's simply ... 
quite different :(

> 
> It is true that this series tries to handle cont-{pmd,pte} in the
> pagewalk api for hugetlb vmas, but in order to raise less eye brows I
> can come up with a way not to do that for now, so we do not fiddle with
> cont-stuff in this series.
> 
> 
> Or am I misunderstanding you?

I can answer once I know more details about the approach you have in mind :)

-- 
Cheers,

David / dhildenb


