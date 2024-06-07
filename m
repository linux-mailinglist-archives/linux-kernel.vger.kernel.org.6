Return-Path: <linux-kernel+bounces-205842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FE2900116
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E61C22C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259EB15ECEB;
	Fri,  7 Jun 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIL1peXP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72815D5D6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756805; cv=none; b=f9ZO3JZeoGAGZik+fFlxmU0LAucRW0N3hauKq60d/RTFnarlL8VqXEYPIgOMS+HO4s9I59f+OyrvTeqGGzenIYMYH06cdoFUdiV1GGGOpmXtwLjnSOmhUPtk+Rt9c0t+8wG/jt/oK3/RsADcPX6tf9/obPf7UzFZMR0TR/+bqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756805; c=relaxed/simple;
	bh=RNYspcEPwyIQJKh7EQUxXoVtBdyfWedxUyCXv/X/UZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi8AIs+6RWYCszeS2zeInSOSnHWeYArcUvIOYs9tRSjy2WpXWwaL5HInavB4FMaTrwZoRuhF3NBIe1KechPbUz+CY4IJOkI3ERV+nvKDe36u2d+E/yjYvSmb7/LL7NxmgfBq8S23E4Koz9Aez4aJoXaeP+bbjMaR0pPGkx8JEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIL1peXP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717756802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=npA+mrK958AR5fc95CrozI0zOPbGNdw6cZrPjm/DSfg=;
	b=jIL1peXPPSMQYD3oogV6S1+a5C+eehcI9+ogtmvuM3wgItB+8ZGQGvFGstcLA4Z4SQRQ78
	z0e9yWD13ipngoP47droKnr10Uxt3b/Cm54F4wZiWFpctv3n6hpbgXjbLc7CVYQQGy6dQZ
	7APPLTU/dHDPuAN3/mXLMEjYI0gKdek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-T7-yyQXwPcqKt0xXjnRkuQ-1; Fri, 07 Jun 2024 06:40:00 -0400
X-MC-Unique: T7-yyQXwPcqKt0xXjnRkuQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-421739476b3so1961425e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756799; x=1718361599;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=npA+mrK958AR5fc95CrozI0zOPbGNdw6cZrPjm/DSfg=;
        b=NV4behSNsv80rdt699UsuSa28kUFEo0RwhCnRRxA/TscGc1n+TtJpQ+6oEqnXWV+ld
         04hVv9nw7YTdnGjydYSLgSFEQkx6uSa2PUVS7k9hEfZSqrb/Pzs0zzAKoeQF9CR7y7cz
         oh3yGVUqd6DbVbQdskymPOA0CmPKhDXtppIn5/9hooqRs2l3e9eOp9sspQzpN+2kzKM/
         Js39N2xslvVf9l6fUCpyfF8X+dsFYf0CJY6ajEPY6VotcGhJ8DrAN9L+YtZ45bRQH+JP
         3cxUjyeezarh5uERLxxs4pVXZi1dQmh2Dmgln+QFGusFivK4ZzZIywu+fPJSOs01g5BZ
         9NZA==
X-Forwarded-Encrypted: i=1; AJvYcCVaccXkBjYPH1Bj0oLgAgBSPp44pfzXqCdB81OBmDTY+X+SY4Plj8s521LJ84MoL9jG0NQoQQTi2p5eFF/XTTX7e1WlQhdpRrqsTBqU
X-Gm-Message-State: AOJu0YyMDmFmYs16mG+KwUEv4aDD/YqriDXIrDML9TNOKR+alq6Ki0gi
	UNqN0BF64V3PQbAUF/aIiuoLoTfcNGmImQt5ftRwTQ3kGYhK2eKKWlVv54nZol0sJw/tl+RFnlW
	UzsBy32rvwqaB+gieIeG42XTKnajPKYD65NQh1TAJObnYny1j9UIutKWu2g2lhw==
X-Received: by 2002:a05:600c:34d5:b0:420:fed7:2903 with SMTP id 5b1f17b1804b1-421649fbfa9mr24090445e9.15.1717756799565;
        Fri, 07 Jun 2024 03:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPptPmifZa/aeCBeNoDTvZtYQtR77scx3n8VWrS3UcgCuO/KEi77AmFnY9tMlaaaCOkAOeWQ==
X-Received: by 2002:a05:600c:34d5:b0:420:fed7:2903 with SMTP id 5b1f17b1804b1-421649fbfa9mr24090185e9.15.1717756799059;
        Fri, 07 Jun 2024 03:39:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a? (p200300cbc71a220031c44d181bddfb7a.dip0.t-ipconnect.de. [2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421661ecda2sm18350345e9.2.2024.06.07.03.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 03:39:58 -0700 (PDT)
Message-ID: <e19c3046-b19a-41d7-9ebb-3443e756a8a8@redhat.com>
Date: Fri, 7 Jun 2024 12:39:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
 <db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
 <CGME20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db@eucas1p2.samsung.com>
 <502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
 <slkkien5nc3weyzebdlxs5jjvealqzmctbom7sfvijvkolhsjj@athcc2aqq77p>
 <f11c1b52-67d1-4c2a-834b-47302b0054bc@linux.alibaba.com>
 <5mezgqzg7wmd4iq2d2q3aentziosetwcll3tgdbl3mhriseyv3@pgxsux7qvxno>
 <e7b4aaa1-170d-4500-bf7a-63672e4d81b8@linux.alibaba.com>
 <d5a22158-e663-43d2-a43e-8ad54bae16c8@redhat.com>
 <igzsxllakdkjjsum55d6b2rvj4cnjsgg5povgbsu6ylshstqsy@wbvxj6jvpnmt>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <igzsxllakdkjjsum55d6b2rvj4cnjsgg5povgbsu6ylshstqsy@wbvxj6jvpnmt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 11:05, Daniel Gomez wrote:
> On Thu, Jun 06, 2024 at 10:38:22AM +0200, David Hildenbrand wrote:
>> On 06.06.24 05:31, Baolin Wang wrote:
>>>
>>>
>>> On 2024/6/4 20:05, Daniel Gomez wrote:
>>>> On Tue, Jun 04, 2024 at 05:45:20PM +0800, Baolin Wang wrote:
>>>>>
>>>>>
>>>>> On 2024/6/4 16:18, Daniel Gomez wrote:
>>>>>> On Fri, May 31, 2024 at 01:13:48PM +0200, David Hildenbrand wrote:
>>>>>>>>>
>>>>>>>>> As a default, we should not be using large folios / mTHP for any shmem,
>>>>>>>>> just like we did with THP via shmem_enabled. This is what this series
>>>>>>>>> currently does, and is aprt of the whole mTHP user-space interface design.
>>>>>>>>>
>>>>>>>>> Further, the mTHP controls should control all of shmem, not only
>>>>>>>>> "anonymous shmem".
>>>>>>>>
>>>>>>>> Yes, that's what I thought and in my TODO list.
>>>>>>>
>>>>>>> Good, it would be helpful to coordinate with Daniel and Pankaj.
>>>>>>
>>>>>> I've integrated patches 11 and 12 from the lsf RFC thread [1] on top of Baolin's
>>>>>> v3 patches. You may find a version in my integration branch here [2]. I can
>>>>>> attach them here if it's preferred.
>>>>>>
>>>>>> [1] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
>>>>>> [2] https://protect2.fireeye.com/v1/url?k=a23e7c06-c3b56926-a23ff749-74fe485fb347-371ca2bfd5d9869f&q=1&e=6974304e-a786-4255-93a7-57498540241c&u=https%3A%2F%2Fgitlab.com%2Fdkruces%2Flinux-next%2F-%2Fcommits%2Fnext-20240604-shmem-mthp
>>>>>>
>>>>>> The point here is to combine the large folios strategy I proposed with mTHP
>>>>>> user controls. Would it make sense to limit the orders to the mapping order
>>>>>> calculated based on the size and index?
>>>>>
>>>>> IMO, for !anon shmem, this change makes sense to me. We should respect the
>>>>> size and mTHP should act as a order filter.
>>>>
>>>> What about respecing the size when within_size flag is enabled? Then, 'always'
>>>> would allocate mTHP enabled folios, regardless of the size. And 'never'
>>>> would ignore mTHP and size. So, 'never' can be used for this 'safe' boot case
>>>> mentioned in the discussion.
>>>
>>> Looks reasonable to me. What do you think, David?
>>>
>>
>> That mimics existing PMD-THP behavior, right?
>>
>> With "within_size", we must not exceed the size, with "always", we may
>> exceed the size.
> 
> But right now we only check the inode size. With large folio support in
> write_iter() we can have access to the length as well. I think this would solve
> (paratially?) the cases where we don't have access to the file size and if we
> perform writes in bigger chunks.
> 
> E.g. xfs_io -t -f -c "pwrite -b 2M -S 0x58 0 2M" /mnt/test/file
> 
> For 'within_size', the example above would allocate 512 pages instead of one
> huge page. After patches [1] [2] we can get the size of the write to allocate
> whatever mTHP/THP makes more sense for the length being passed.
> 

Yes, although this sounds like an optimization/change we should be doing 
separately I guess.

> [1] https://lore.kernel.org/all/20240527163616.1135968-2-hch@lst.de/
> [2] https://lore.kernel.org/all/20240515055719.32577-12-da.gomez@samsung.com/
> 
> Here a quick hack for THP:
> 
> @@ -561,7 +561,8 @@ bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
>          case SHMEM_HUGE_WITHIN_SIZE:
>                  index = round_up(index + 1, HPAGE_PMD_NR);
>                  i_size = round_up(i_size_read(inode), PAGE_SIZE);
> -               if (i_size >> PAGE_SHIFT >= index)
> +               if ((i_size >> PAGE_SHIFT >= index) ||
> +                   (len >> PAGE_SHIFT >= index))
>                          return true;
>                  fallthrough;
> 
> 
>>
>>> And what about 'advise' option? Silimar to 'within_size'?
>>
>> Good question. What's the behavior of PMD-THP? I would assume it behaves
>> like "within_size", because in the common case we mmap (+advise) only within
>> the size of the file, not exceeding it.
> 
> It allocates a huge page on request when MADV_HUGEPAGE (regardless of the size).
> 

Interesting, so we should do the same. Thanks!

-- 
Cheers,

David / dhildenb


