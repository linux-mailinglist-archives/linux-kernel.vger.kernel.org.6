Return-Path: <linux-kernel+bounces-288609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7543953C60
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B182824B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE314D6F7;
	Thu, 15 Aug 2024 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug6PILG4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A0BA53
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756125; cv=none; b=ht8CqVywsZwK8nt26YH6qrHTOXhFI6lt9i8EnRxcc5MEKbHuIkGViK38wLPzNBSepse6gyrxe/eTQjkKldfYklFbi6yjKmSDdU+NiIHm8L+zmCxaFcITaL0SLic8PpsG4xEQnyKjmxgVw6tNcxK6kU2CMGQ2ffAur65D7jfo0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756125; c=relaxed/simple;
	bh=vPrBWizLkvvXLrkIZqlSz3Drin44WQTkyJdWzOqOLkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egnEZuV5U/onZuKsqr3k1c9x+rr34/t6k0+TRavZaiyEBbQeYBo95OvWNSwtPrjKVuspgjiQqF7OJZE6hpO34gycZrGbTAENLCwDq6JYSmXO1KrE7WpfTHTeHR51yLG4wJ8S3cN0V2ETm3guY19/25YVsExYzzGjEXlFbpqHBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug6PILG4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723756123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AbJukgnVCZoBww8VUPq6BvfUAMyC8SeWvlvh6FgvKKA=;
	b=Ug6PILG4hG8IjQPqeSxPa/vBF4LR3ACDB/d9NGCFyKmWHbmAlN6kBvQSlkiajr8V2es9ST
	V7Gkt6X0KM+JXU5wrWolpoFqWhrO5fEodg7KJCpyoUJ5FcVsM/4OYMkE+aSx1qcENdFLQm
	hshznaurzyo4+88LbMfiFi0Ex+/r+Hs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-68qNjVpuMx-kjPF-n0JjBg-1; Thu, 15 Aug 2024 17:08:41 -0400
X-MC-Unique: 68qNjVpuMx-kjPF-n0JjBg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42820c29a76so8980075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756121; x=1724360921;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AbJukgnVCZoBww8VUPq6BvfUAMyC8SeWvlvh6FgvKKA=;
        b=ti4ZCcm89Qprnf6nyN3bAjdnG81IbROAiDHxkMi9JnXPUJ+R3npcMLYO23V9pStBfD
         KGnd6y+KCDKuAA5p3DvgEvGqsF7c3SCn0JUIP9jrWaesmKnoI049PgauqrUKwJ31NoQW
         svWNIVpbj6TFJEBF1wkTxKp3+IC4iQltdbFo0MlfRRzEDzI0CNf7yhFoThwcHGDqRAvv
         XaQgPu8oxXqr0SpBQvGbVBcSIniL8ROqTffaEZJvS3cAIE37VIjRbl5JGLgBsRgVZfvR
         8/LhLWj0Hi+ANGovYqwMKh4FXiRB1gIU5JCsHK49cfOQz1A26KDakfcTslAKGqL/QXJU
         wTsw==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZKZJcVz7mN6ElEvPYT4jGU5SoP6DGR3JGO8BuFsyu8Gf1D3PTfM+f2xGJTFA9Qt/YPlLWI/cHYRFerM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+n/z2Lq+FH8I7/7JpDfHepJWnN8876VXOLrVxdt/vncK/rt+b
	gPSpMDfMvCCqwghO0nPOGU5buExY2mle59VO3BVfT2XUIifFhnrLJCw32Ng21Y8tNpzZmyhDgD0
	48yBMyEamlS/2YHnoRuG3uDEo/B7AH8rfr6HcPp+xDer9U7qKxjwTmG4mwAiekg==
X-Received: by 2002:a05:600c:3ca0:b0:426:6e9a:7a1c with SMTP id 5b1f17b1804b1-429ed7cc497mr3588495e9.25.1723756120637;
        Thu, 15 Aug 2024 14:08:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnadehEuz+ZomR3i4TSDcNey/Wo0B8Gn62/NQ3HNztokdixwOC611hdUzowFnrgj6FiCobqg==
X-Received: by 2002:a05:600c:3ca0:b0:426:6e9a:7a1c with SMTP id 5b1f17b1804b1-429ed7cc497mr3588325e9.25.1723756120081;
        Thu, 15 Aug 2024 14:08:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6d00:aebb:127d:2c1a:7f3a? (p200300cbc7176d00aebb127d2c1a7f3a.dip0.t-ipconnect.de. [2003:cb:c717:6d00:aebb:127d:2c1a:7f3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a3b9sm2328701f8f.56.2024.08.15.14.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 14:08:39 -0700 (PDT)
Message-ID: <fe79d6ca-6005-46d9-b14a-b785dd0b0414@redhat.com>
Date: Thu, 15 Aug 2024 23:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com>
 <ee0bae67-17b8-4807-a9b2-9a08df00987a@redhat.com>
 <d7433859-6217-483c-9d48-bb6de97b09f7@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d7433859-6217-483c-9d48-bb6de97b09f7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> 
> Was there some comment here? I just see ">" remove from the start of /* We lost race with folio_put() */
> 

Likely I wanted to comment something but decided otherwise, sorry :)

>>> +            folio_clear_partially_mapped(folio);
>>>                ds_queue->split_queue_len--;
>>>            }
>>>            if (!--sc->nr_to_scan)
>>> @@ -3558,7 +3564,6 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>    next:
>>>            folio_put(folio);
>>>        }
>>> -
>>>        spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>>        list_splice_tail(&list, &ds_queue->split_queue);
>>>        spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 1fdd9eab240c..2ae2d9a18e40 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1758,6 +1758,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>>>            free_gigantic_folio(folio, huge_page_order(h));
>>>        } else {
>>>            INIT_LIST_HEAD(&folio->_deferred_list);
>>> +        folio_clear_partially_mapped(folio);
>>>            folio_put(folio);
>>>        }
>>>    }
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 52f7fc4e8ac3..d64546b8d377 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -662,8 +662,10 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
>>>        atomic_set(&folio->_entire_mapcount, -1);
>>>        atomic_set(&folio->_nr_pages_mapped, 0);
>>>        atomic_set(&folio->_pincount, 0);
>>> -    if (order > 1)
>>> +    if (order > 1) {
>>>            INIT_LIST_HEAD(&folio->_deferred_list);
>>> +        folio_clear_partially_mapped(folio);
>>
>> Can we use the non-atomic version here?
>>
> 
> I believe we can use the non-atomic version in all places where set/clear is done as all set/clear are protected by ds_queue->split_queue_lock. So basically could replace all folio_set/clear_partially_mapped with __folio_set/clear_partially_mapped.
> 
> But I guess its likely not going to make much difference? I will do it anyways in the next revision, rather than sending a fix patch. There haven't been any reviews for patch 5 so will wait a few days for any comments on that.

If we can avoid atomics, please do! :)

-- 
Cheers,

David / dhildenb


