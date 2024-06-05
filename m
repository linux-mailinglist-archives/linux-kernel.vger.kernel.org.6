Return-Path: <linux-kernel+bounces-201907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D98FC50F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D875C1F236A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63DE18F2E7;
	Wed,  5 Jun 2024 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuBItsH7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7E14EC75
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573846; cv=none; b=nT9hQPTpdto/ckq+KUCCxV2t2aGRv3z4S9kAfe7Kiu0bfaF2CnpNnYdslEdJgF5LpT0/UaUrGDkCitjOkMjtILsgSYXQKoIGitRoKE+fTzzVRu1L8vq6wCQWEcaBQ9tlxB1fOD9PRQ0G1IO3la54BcoivS8KqcygY9Iy+bcjLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573846; c=relaxed/simple;
	bh=3I5LZhSbqNX/QtV/uPg/+RPJGW4N+cDUUbMDJWeg2c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rU69fVrLaxA+l0vU717Pac3ZPe6n/HaXpku/6+QqvrN8SeF58D4gZoud3Th3r5Mmagnb9FdZVkSv1LcE1kz/osBPxn1p0oryVPUZ1TNGfWrfmQKZRIPxMhYWX1OB2oL7gbsjbFJNpkh3CFqG/+7DCsxwN9NfJq8UteNQaqOvaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuBItsH7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717573844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sp/TPmj4gCyL+99ZYYAO/l58UJA5aZi2Ueydu1EQa4w=;
	b=EuBItsH7E8tqSduDo5Lb3Yhvzg5dHNaaFRMBBlrb7Zl5BBnygX1uiPm1fC0vqOmJDzBYgm
	nADUJFCiVuhRi1xmKXU/tX20kWU2Ti2M8CIUxpRKIwOYtMjEsQTacyPtbLuC/2M8Lewoqu
	LxBj5m0EQ/APpwekJd5qiCDdYe7K2bw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-wmr5febDOXaNuYmG5lvd-A-1; Wed, 05 Jun 2024 03:50:41 -0400
X-MC-Unique: wmr5febDOXaNuYmG5lvd-A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42129affd18so31790075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573840; x=1718178640;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp/TPmj4gCyL+99ZYYAO/l58UJA5aZi2Ueydu1EQa4w=;
        b=LeUtjpu3tlrEpeInd9vC35le389mNkyqwVk4XMnLUMzElB8gndeqhUVPaPX5kFkU8H
         iTsNlKPYBdYZMP+iFOjPNpD8K/ChGr9QUbEHy+U2nPwDrOdTjduP+HR2pQMR6PPQm1Yr
         uMCPpExMZDtw8yaKJUveOxr8A6auD7B9SrXWOXnMfL8VTtgafnxJJFv3c3PriE/Wj+Cq
         S1MarjZ+MrgODWf7TqMVjYvzQCuSKal9rP1JySltPR3K8Zk16Wp3y6uGCNENCM6auWA4
         hz+no8hgDjU7+e/ZsFvZ6p2o6DB1nNgPwAYTGHSUw9aqptqhmOmbikfkul2A3o97cZwe
         /o1w==
X-Forwarded-Encrypted: i=1; AJvYcCUOkJIy/08Lf+M1vY4WWBt+3EGq8R2sZhdlqvaxmWtXvxzvfjr8zkn7+G1MoN6VfHpSbY4T6S/SgBAwElyzWQx/fyZl7DIDmKk3YogL
X-Gm-Message-State: AOJu0YxVfniHwHATfYzvjRseKvnJOSl5/jIQQG4PdLazKECB3m5AHcMA
	+Ccq9yI6HdkS+4xOtK0BAgF71pHCmwjxxlWQdawIA+ZbIeFBKPz+VDZw4t2f7FhMlB7HxpdmWWA
	oTmkx/S3o2FXqJvvpDCzNnnzseJDomDWhZOMLaX6mtoZaKerLJlEotXtSRwoSMA==
X-Received: by 2002:a05:600c:3c94:b0:420:78f:3f87 with SMTP id 5b1f17b1804b1-421562dd26emr16250815e9.11.1717573840533;
        Wed, 05 Jun 2024 00:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMWRiMiuljMfIWttm/qOea9hgxv9ucbwEzofHXngrWZJaJZmu2nJR1X8vDogrHGmdtGYwoZw==
X-Received: by 2002:a05:600c:3c94:b0:420:78f:3f87 with SMTP id 5b1f17b1804b1-421562dd26emr16250685e9.11.1717573840138;
        Wed, 05 Jun 2024 00:50:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215810826csm10594355e9.17.2024.06.05.00.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:50:39 -0700 (PDT)
Message-ID: <f21b037b-07f4-41dc-acfc-1bd4de634511@redhat.com>
Date: Wed, 5 Jun 2024 09:50:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] mm/ksm: use folio in try_to_merge_one_page
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-4-alexs@kernel.org>
 <8a4d048c-0764-442a-aa70-48518068f163@redhat.com>
 <2b2e209d-863a-4c21-b7a5-2d328866cd0e@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2b2e209d-863a-4c21-b7a5-2d328866cd0e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.06.24 05:38, Alex Shi wrote:
> 
> 
> On 6/4/24 4:19 PM, David Hildenbrand wrote:
>>>
>>> @@ -1489,11 +1494,11 @@ static int try_to_merge_one_page(struct vm_area_struct *vma, struct page *page,
>>>         * prefer to continue scanning and merging different pages,
>>>         * then come back to this page when it is unlocked.
>>>         */
>>> -    if (!trylock_page(page))
>>> +    if (!folio_trylock(folio))
>>>            goto out;
>>>    -    if (PageTransCompound(page)) {
>>> -        if (split_huge_page(page))
>>> +    if (folio_test_large(folio)) {
>>> +        if (split_folio(folio))
>>>                goto out_unlock;
>>>        }
>>
>> Careful: there is a subtle change:
>>
>> In the old code, after split_huge_page() succeeded, you would have a ref on *page* that you have to drop.
>>
>> Now, you would have a ref on *folio* -- IOW the head page that calling code has to drop.
>>
>> Is that handled accordingly? IOW, is there no code that would assume it would drop the reference on the *page* instead of on the *folio* (that, after split succeeds, would be an order-0 folio)
>>
>> If so, worth spelling out in the description (you say "So in the calling path to try_to_merge_one_page() parameter pages are actually folios", but I am not sure if that means that all page refcounting code was changed to folio refcounting code).
> 
> Hi David,
> 
> Thanks a lot for comments. Yes, the ref on folio was handled. I will mention it again in commit log.
> The 2nd patch in this series would just pass folios into next step, tail page will be warned, so the ref on 'page' here is also the ref on folio. they are same.

Okay, but the 2nd patch is wrong and should be dropped. We can easily 
end up with tail pages here.

We have to be a bit careful here.

-- 
Cheers,

David / dhildenb


