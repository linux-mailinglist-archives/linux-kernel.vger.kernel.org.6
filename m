Return-Path: <linux-kernel+bounces-202784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86938FD103
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89FF1C22974
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E18D208D1;
	Wed,  5 Jun 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYAy+JWd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288FF1B5AA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598534; cv=none; b=lVI867GZjQf4CWdC3kp/u18+wK7MFZqHX7dail61baPnaR7kBp4G0O8IibRpKw9N3wuokv/Z5+hpEtlcVYY6LHyXnOxI3kUpmPaxuWnTmn/1QntbzIkdbSORZxuGQiRY/b31UBeKInWMxuz7lTUI8W3qEoI3RRyQEN0IXdbUNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598534; c=relaxed/simple;
	bh=K28g+f/D/gr3rfNCKVUw18hsV2Ij+fYu4fPgJUBJ5FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2Aky34vYU78EkYdUEsfeL4HAWoFyAL4JZL+wIFwiq87uA+HajGRFp9vJrGqdwd0l7eHp9bu9CyP6BAcoh4/J8IWsVEUYcUEZlT2UvIA35A4J3w/sMEhnTtfQK+0+tyAb/pq37bsKfpN1ztIl/H5cy9qJ2heS1pNxdNwlGOuRhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYAy+JWd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717598532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GiPeZhxJtGJ8quf69kDStSSY+XUu4EI97FvqlN+T3ow=;
	b=fYAy+JWdsO18bSXwthFpBbtdQEQ+srvrjlI/IMuO4iLiQdRomPVvql+YmRZcJ6Ycyxsylh
	fMauIMExerHxQMg9w1MuNVMrSV4hhPTdzEaRDHgAUhA3ClcGSLRKaFx0z48652E12vJQrJ
	thgNW6uYAxTlR6m1GvXvsCbsbK8XgXw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-_r4441GTM3eRUobx8sVtbQ-1; Wed, 05 Jun 2024 10:42:10 -0400
X-MC-Unique: _r4441GTM3eRUobx8sVtbQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35dcde1be6cso1573216f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717598527; x=1718203327;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GiPeZhxJtGJ8quf69kDStSSY+XUu4EI97FvqlN+T3ow=;
        b=pQBA0BF05ThOC3mwHtQNK3BWHN2gP5x6XQ/+dP42pRfNIHCrSnxh9g2iF3JYkagp/B
         FeRBehlbM6dCnBpyLh8t8wPWUizi1l+smHY+XF0sJADEn0afK2xJMKDgQEm3P2CpJLZw
         /ZS1X/tDjOKI5V9jFHBk+0+3f5hWNK0YBI2kVyspVS3qlAYgYV/hGPHVdd7+R5XXfMZU
         U5PeesU1mlWnM5Cs9IQIt7SQ6JmaGtk00cfCiOQiG/vWa9yO/Fiwtx5WOQntF+ueuQnE
         yfEN7xdDsUc1SW2tDuNYxSxkSPaXMLp/mBVAud6kTmZU9A+t1LsoCzcnX+Vj+/gimqn6
         tZgg==
X-Forwarded-Encrypted: i=1; AJvYcCVMJFiXE++khewSNAGBtIa7sujm0uib/kbx0HY9kzBffwsFuUjCqS2daB3grj0K7AuLrXGmqDpDQXIAXvp5pw+5B5b0it8unMiPN8R5
X-Gm-Message-State: AOJu0YzdGynWVYhZw4hSmf5bV+A7adzpjCasuqwn3a97k+uEXfjaOT9D
	nOZYa6+R8A2ESxkuy7EqBk8kerBHxCJ7dool/cc4O1NqTpkEW/Pi+EwhX7jjcIxWq0wNM5cAw0E
	p7FwAZ45fYwQdLq6OK5sCdtX5WfDWSiN1oqN5oODo2BMswot7BROhexdIRd7eVA==
X-Received: by 2002:a05:6000:d51:b0:355:3cf:49b1 with SMTP id ffacd0b85a97d-35e84070fedmr2059936f8f.19.1717598526918;
        Wed, 05 Jun 2024 07:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn+4+m9rnSh0qE54VOEI6wdoE8IgJxY/3eN+7Od0MrvYthUs1DLYvgPJ/y3xRi0QIR8uQCUg==
X-Received: by 2002:a05:6000:d51:b0:355:3cf:49b1 with SMTP id ffacd0b85a97d-35e84070fedmr2059919f8f.19.1717598526491;
        Wed, 05 Jun 2024 07:42:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d9c89sm14739988f8f.60.2024.06.05.07.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:42:05 -0700 (PDT)
Message-ID: <c110eb46-3c9d-40c3-ab16-5bd9f75b6501@redhat.com>
Date: Wed, 5 Jun 2024 16:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: Zi Yan <ziy@nvidia.com>, ran xiaokai <ranxiaokai627@163.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org,
 v-songbaohua@oppo.com, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
References: <CAGsJ_4wFyFBTDDfsBpi0sKs1WOH2jaKKoYWWj9Ln_PsNjP2uuA@mail.gmail.com>
 <20240605095406.891512-1-ranxiaokai627@163.com>
 <D667F08C-0CCE-4D5E-89A3-56674B0893DE@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D667F08C-0CCE-4D5E-89A3-56674B0893DE@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 16:08, Zi Yan wrote:
> On 5 Jun 2024, at 2:54, ran xiaokai wrote:
> 
>>> On Tue, Jun 4, 2024 at 5:47?PM <xu.xin16@zte.com.cn> wrote:
>>>>
>>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>
>>>> When I did a large folios split test, a WARNING
>>>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
>>>> was triggered. But my test cases are only for anonmous folios.
>>>> while mapping_large_folio_support() is only reasonable for page
>>>> cache folios.
>>>>
>>>> In split_huge_page_to_list_to_order(), the folio passed to
>>>> mapping_large_folio_support() maybe anonmous folio. The
>>>> folio_test_anon() check is missing. So the split of the anonmous THP
>>>> is failed. This is also the same for shmem_mapping(). We'd better add
>>>> a check for both. But the shmem_mapping() in __split_huge_page() is
>>>> not involved, as for anonmous folios, the end parameter is set to -1, so
>>>> (head[i].index >= end) is always false. shmem_mapping() is not called.
>>>>
>>>> Using /sys/kernel/debug/split_huge_pages to verify this, with this
>>>> patch, large anon THP is successfully split and the warning is ceased.
>>>>
>>>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>> Cc: xu xin <xu.xin16@zte.com.cn>
>>>> Cc: Yang Yang <yang.yang29@zte.com.cn>
>>>> ---
>>>>   mm/huge_memory.c | 38 ++++++++++++++++++++------------------
>>>>   1 file changed, 20 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 317de2afd371..4c9c7e5ea20c 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>          if (new_order >= folio_order(folio))
>>>>                  return -EINVAL;
>>>>
>>>> -       /* Cannot split anonymous THP to order-1 */
>>>> -       if (new_order == 1 && folio_test_anon(folio)) {
>>>> -               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>>> -               return -EINVAL;
>>>> -       }
>>>> -
>>>>          if (new_order) {
>>>>                  /* Only swapping a whole PMD-mapped folio is supported */
>>>>                  if (folio_test_swapcache(folio))
>>>>                          return -EINVAL;
>>>> -               /* Split shmem folio to non-zero order not supported */
>>>> -               if (shmem_mapping(folio->mapping)) {
>>>> -                       VM_WARN_ONCE(1,
>>>> -                               "Cannot split shmem folio to non-0 order");
>>>> -                       return -EINVAL;
>>>> -               }
>>>> -               /* No split if the file system does not support large folio */
>>>> -               if (!mapping_large_folio_support(folio->mapping)) {
>>>> -                       VM_WARN_ONCE(1,
>>>> -                               "Cannot split file folio to non-0 order");
>>>> -                       return -EINVAL;
>>>> +
>>>> +               if (folio_test_anon(folio)) {
>>>> +                       /* Cannot split anonymous THP to order-1 */
>>>> +                       if (new_order == 1) {
>>>> +                               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>>> +                               return -EINVAL;
>>>> +                       }
>>>> +               } else {
>>>> +                       /* Split shmem folio to non-zero order not supported */
>>>> +                       if (shmem_mapping(folio->mapping)) {
>>>> +                               VM_WARN_ONCE(1,
>>>> +                                       "Cannot split shmem folio to non-0 order");
>>>> +                               return -EINVAL;
>>>> +                       }
>>>> +                       /* No split if the file system does not support large folio */
>>>> +                       if (!mapping_large_folio_support(folio->mapping)) {
>>>> +                               VM_WARN_ONCE(1,
>>>> +                                       "Cannot split file folio to non-0 order");
>>>> +                               return -EINVAL;
>>>> +                       }
>>>
>>> Am I missing something? if file system doesn't support large folio,
>>> how could the large folio start to exist from the first place while its
>>> mapping points to a file which doesn't support large folio?
>>
>> I think it is the CONFIG_READ_ONLY_THP_FOR_FS case.
>> khugepaged will try to collapse read-only file-backed pages to 2M THP.
> 
> Can you add this information to the commit log in your next version?

Can we also add that as a comment to that function, like "Note that we 
might still
have THPs in such mappings due to CONFIG_READ_ONLY_THP_FOR_FS. But in 
that case,
the mapping does not actually support large folios properly.
"Or sth. like that.

-- 
Cheers,

David / dhildenb


