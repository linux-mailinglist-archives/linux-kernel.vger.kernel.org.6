Return-Path: <linux-kernel+bounces-199324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825468D858E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6821F21000
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345012FF73;
	Mon,  3 Jun 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFFpOcsp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D112FB29
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426572; cv=none; b=itf9bouAixb2zP8LolOAgdn8VJZRjH1O/VGu3UgNf0mFveN3HDpxRwYc40mY/VDzkFd0WT1ZAb6PZ9QeIf6uE3FOSuOHDs14J9x8mgy/DSqJiFXZifghCzd4HDNO8QfKPEykkZ2oCo7UfG9epY2dAl4iVMZKTOLbbR9nXuDox00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426572; c=relaxed/simple;
	bh=oWJ8YADXw3LKz/Pboxdue6t1nuUJqAxc9sJe1mosed0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUiEddj0KjN4vwR8aFULpPjuVhnCoW0m8fmLerqKsdl8e2GbUlXZB97iJTqjq4rDFnOQgibJuRuUkARsI65danKIj2NrcACmUz/1AXD5Dysj4zHHLf8+blbmn6cq5HrzLkVa7eQxEMJGVHTd+v9CqGxNio3HMbgCWJC7kOG3kJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFFpOcsp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717426569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OIpIkuDdJN5pRhF5lcudBYvGA8DN+9nHxzwJ2HQxWo8=;
	b=jFFpOcspH4Jg6opx2gu/Q/hLTb+ZfOpLVAHh0qhRH9HBXD/run1aApRMmUW1z6OtjENnKQ
	kKeyx6yKjxWZ9rydHlT8qUWpQ9xwH05o1HlIajolbtRpgHoW0Cy/5o6nnrhzTWyfWTbkbv
	rfgF/g5OMGRu23M1F155aYaX+ZoWX9Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-sIdy2c8rOmqUF7ZIcIdOsQ-1; Mon, 03 Jun 2024 10:56:08 -0400
X-MC-Unique: sIdy2c8rOmqUF7ZIcIdOsQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35e50fe93a5so1156058f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 07:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426567; x=1718031367;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIpIkuDdJN5pRhF5lcudBYvGA8DN+9nHxzwJ2HQxWo8=;
        b=LJLHaohTfurS7Y7VHw1L8J7cSiI0yVwTIwf+TwzOPTyjjhrV0w7y0vrw+F5csXwexb
         qt65pWZVebU8z3xDEpgvbFYnPW476MCw0TVPkDpUzb4lyue7i1i6JCwGYr7l42oSwybs
         tr/jUJlF/y07Jduo1te64V7iXMT/cfobzCngd6dO/HQxympB+MyPrKC/0eAPK7dUSG7S
         sy8zTVJoHe3RKZqodd/ApZ+JDBSXAMGBrOw7Qs8OQ7Fn3ov0xJbCokZmsUjv1ybPQfd7
         8V9gzOOZNDhsxdYoZylBa6WiaTDELYAhtcXepwOM/yy6jAuqxNAtAfiiKV79Ua2L/04B
         Xc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2mCYAsKa7cH3nPPx1s470xXvGBpHUYaaYyAqLbs44GBIbHGpSyHZHiF5EmozMP0sdFUAPP+Jr+8mkxk68ECDpAbqWLdL7pepKluFP
X-Gm-Message-State: AOJu0YwX+SUcy/gtHA4VXEXF06p/uByyW+siYnOfhUXk3pdfzM+sOIDm
	jBhtbMsog6KJQTh157ZK3Vbv2uFs7b0P+CkFrB8plOk+UObbntUnmXsWbKCyGo5tvbKoX7NUuTV
	n47WV1eMRvJrNFLgkRhPKtrnud2dfqFSnHtfBq7HORpEq0WJ3T31Dj/0maJFZXQ==
X-Received: by 2002:a05:600c:4f0f:b0:421:1f78:1564 with SMTP id 5b1f17b1804b1-4212e04a0femr62448925e9.9.1717426567088;
        Mon, 03 Jun 2024 07:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnq9qREQQY7cDsMGcBFej8S62YU7wti94ZuaWKbyt1spX1Ns7Q7nYMOToA2LgHX3OICn5A4g==
X-Received: by 2002:a05:600c:4f0f:b0:421:1f78:1564 with SMTP id 5b1f17b1804b1-4212e04a0femr62448665e9.9.1717426566602;
        Mon, 03 Jun 2024 07:56:06 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212709d336sm150214425e9.37.2024.06.03.07.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 07:56:06 -0700 (PDT)
Message-ID: <c0309ab6-8bae-42b7-8d27-1df895689fb8@redhat.com>
Date: Mon, 3 Jun 2024 16:56:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/mlock: implement folio_mlock_step() using
 folio_pte_batch()
To: Matthew Wilcox <willy@infradead.org>, Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, fengwei.yin@intel.com,
 ying.huang@intel.com, libang.li@antgroup.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240603140745.83880-1-ioworker0@gmail.com>
 <Zl3Wjh9_aGY8Xxm7@casper.infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zl3Wjh9_aGY8Xxm7@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 16:43, Matthew Wilcox wrote:
> On Mon, Jun 03, 2024 at 10:07:45PM +0800, Lance Yang wrote:
>> +++ b/mm/mlock.c
>> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
>>   static inline unsigned int folio_mlock_step(struct folio *folio,
>>   		pte_t *pte, unsigned long addr, unsigned long end)
>>   {
>> -	unsigned int count, i, nr = folio_nr_pages(folio);
>> -	unsigned long pfn = folio_pfn(folio);
>> +	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>> +	unsigned int count = (end - addr) >> PAGE_SHIFT;
> 
> This is a pre-existing bug, but ... what happens if you're on a 64-bit
> system and you mlock() a range that is exactly 2^44 bytes?  Seems to me
> that count becomes 0.  Why not use an unsigned long here and avoid the
> problem entirely?
> 
> folio_pte_batch() also needs to take an unsigned long max_nr in that
> case, because you aren't restricting it to folio_nr_pages().

Yeah, likely we should also take a look at other folio_pte_batch() users 
like copy_present_ptes() that pass the count as an int. Nothing should 
really be broken, but we might not batch as much as we could, which is 
unfortunate.

-- 
Cheers,

David / dhildenb


