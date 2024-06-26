Return-Path: <linux-kernel+bounces-231652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9BC919B64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D550B2161A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0F1922FE;
	Wed, 26 Jun 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsf2Mm1z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641415E5B9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445723; cv=none; b=fH7hDuViybpeZO1MKnActuu6WJ7l98yeLRxLDeJt/VVWuj0kL5cdAssnZjJimNxODlUHq/bIUWfPROE26g25mUSqcmje1I48JTqQHL62deeQD6FX0oIUrCVSmnmWdzKMmzg+GIWmZjk2UkyN+JYIhKYSVMQskHIqqAgSooFSnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445723; c=relaxed/simple;
	bh=prYxmVaT2pXdyaU+Bub6Dy4ols0oNvlkfqPFHvbTipI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7iaRvVhVN2NsV24IM5s4V6gg6c7eyeuAh2fOia3ns5dVjd0rDMvU2GMNnWr9dco4egXoDPrtwgMTV1BoX7t4qapRHqncGaUPdUE4dUTYDBAGORB2rTTP4Zr765qHEGnYbQc08zYzGSGCZNMmfT/vUbgMeTrWg6iHux7jwh7K9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsf2Mm1z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719445720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7CqT7ZoVZ21vEmREjMyead0YkkLsWeh8E80zva5ToM=;
	b=gsf2Mm1zPna+2+8x67YP8eELOcpI84KPzMDAFZwvmjtdOXZMhqLAiqKBQq5fzr/Z26zDqi
	jYcg/oDWK3uKoXzeO2G6s5Kl1DIWQEB4p6prSv/GU5f4Zc9I2z+ISh9nABtyMy9eLyhB7E
	MWdIbAAvTynYFqVjVclArVHhI9gu4hM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-5C_75bx2PreGo7_WHU7Uxw-1; Wed, 26 Jun 2024 19:48:39 -0400
X-MC-Unique: 5C_75bx2PreGo7_WHU7Uxw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7225d0435a9so2705558a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445717; x=1720050517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7CqT7ZoVZ21vEmREjMyead0YkkLsWeh8E80zva5ToM=;
        b=gKtnwFr4WvoRvy5DQGMWY6DUm6V+OFdh/U/2JcZJkX9KXwQYgWqOtCiodMSeQOIfDF
         rerTJRqMLGcesXeZLMpOVdiocBhQUPAaWGSwq8NlxMqRmUavdtaqqg2qYkiYOVtnpG5r
         AggA0VQtHPwLDgylmWRrDbVizzaMEVi66CbewC4IiEE6s3fD2nc/WdwEAOc6TdU3Ytyo
         kksIMNTcuToS0Jsphb4yM9qX5Jb54ryzdUQEX5RttlgreWbDwvshouIi42YfDLbF8JpD
         jgQtiaa1HFu/KmDLW5negf0U6B4OdMW/X824QwT5tI6ot59yEQG/hX2mvYo3S3Rv8k4X
         tjlg==
X-Forwarded-Encrypted: i=1; AJvYcCWuviWi7tIULALnu/uJKale2lgcYzoIl+hcigsVNnjW3+PsX5wYJp47vOC6oPl8/V08uh3JiDR8+9G7P7YD7klRyPX9DSlv6HLWcdVz
X-Gm-Message-State: AOJu0Yyggps1EPMLhcWvS9Ff4vTjbxEkmVfMULtFrN0nennwqyiqAHnl
	P5xEiIlSLwBAkTxFsiCval/t1aXcp4G4W26HzCTIIp0U6f/ABQyH2wlmEDW1Sk/7RdpW9MRvG1O
	2SxQwWiy1DB2sgx27gEuiuImldTQU/NMnq8SkTdp5iw6jAgiDOMQrIYfsoEEWb06Jocqdbw==
X-Received: by 2002:a05:6a20:4c82:b0:1bd:1fb9:37be with SMTP id adf61e73a8af0-1bd1fb94724mr5339537637.34.1719445717481;
        Wed, 26 Jun 2024 16:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO4cQmMl+Yz/ePmJozmWEc69fVJbFIuXB/kxX5f4SOa9YmR96mVVLdgm1KF4X5QUEcUDF8Mw==
X-Received: by 2002:a05:6a20:4c82:b0:1bd:1fb9:37be with SMTP id adf61e73a8af0-1bd1fb94724mr5339527637.34.1719445717109;
        Wed, 26 Jun 2024 16:48:37 -0700 (PDT)
Received: from [192.168.68.51] ([103.210.27.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d8060f14sm2269364a91.29.2024.06.26.16.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 16:48:36 -0700 (PDT)
Message-ID: <471488ec-ea1f-4c57-ad0d-bea422863574@redhat.com>
Date: Thu, 27 Jun 2024 09:48:30 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, hughd@google.com, torvalds@linux-foundation.org,
 zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
 <33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
 <20240625115855.eb7b9369c0ddd74d6d96c51e@linux-foundation.org>
 <f27d4fa3-0b0f-4646-b6c3-45874f005b46@redhat.com>
 <4b05bdae-22e8-4906-b255-5edd381b3d21@redhat.com>
 <ZnyAD24AQFzlKAhD@casper.infradead.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZnyAD24AQFzlKAhD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/24 6:54 AM, Matthew Wilcox wrote:
> On Wed, Jun 26, 2024 at 10:37:00AM +1000, Gavin Shan wrote:
>> On 6/26/24 5:05 AM, David Hildenbrand wrote:
>>> On 25.06.24 20:58, Andrew Morton wrote:
>>>> On Tue, 25 Jun 2024 20:51:13 +0200 David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>>> I could split them and feed 1&2 into 6.10-rcX and 3&4 into 6.11-rc1.  A
>>>>>> problem with this approach is that we're putting a basically untested
>>>>>> combination into -stable: 1&2 might have bugs which were accidentally
>>>>>> fixed in 3&4.  A way to avoid this is to add cc:stable to all four
>>>>>> patches.
>>>>>>
>>>>>> What are your thoughts on this matter?
>>>>>
>>>>> Especially 4 should also be CC stable, so likely we should just do it
>>>>> for all of them.
>>>>
>>>> Fine.  A Fixes: for 3 & 4 would be good.  Otherwise we're potentially
>>>> asking for those to be backported further than 1 & 2, which seems
>>>> wrong.
>>>
>>> 4 is shmem fix, which likely dates back a bit longer.
>>>
>>>>
>>>> Then again, by having different Fixes: in the various patches we're
>>>> suggesting that people split the patch series apart as they slot things
>>>> into the indicated places.  In other words, it's not a patch series at
>>>> all - it's a sprinkle of independent fixes.  Are we OK thinking of it
>>>> in that fashion?
>>>
>>> The common themes is "pagecache cannot handle > order-11", #1-3 tackle "ordinary" file THP, #4 tackles shmem THP.
>>>
>>> So I'm not sure we should be splitting it apart. It's just that shmem THP arrived before file THP :)
>>>
>>
>> I rechecked the history, it's a bit hard to have precise fix tag for PATCH[4].
>> Please let me know if you have a better one for PATCH[4].
>>
>> #4
>>    Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>>    Cc: stable@kernel.org # v4.10+
>>    Fixes: 552446a41661 ("shmem: Convert shmem_add_to_page_cache to XArray")
>>    Cc: stable@kernel.org # v4.20+
>> #3
>>    Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>    Cc: stable@kernel.org # v5.18+
>> #2
>>    Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
>>    Cc: stable@kernel.org # v5.18+
>> #1
>>    Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>    Cc: stable@kernel.org # v5.18+
> 
> I actually think it's this:
> 
> commit 6b24ca4a1a8d
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Sat Jun 27 22:19:08 2020 -0400
> 
>      mm: Use multi-index entries in the page cache
> 
>      We currently store large folios as 2^N consecutive entries.  While this
>      consumes rather more memory than necessary, it also turns out to be buggy.
>      A writeback operation which starts within a tail page of a dirty folio will
>      not write back the folio as the xarray's dirty bit is only set on the
>      head index.  With multi-index entries, the dirty bit will be found no
>      matter where in the folio the operation starts.
> 
>      This does end up simplifying the page cache slightly, although not as
>      much as I had hoped.
> 
>      Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>      Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> 
> Before this, we could split an arbitrary size folio to order 0.  After
> it, we're limited to whatever the xarray allows us to split.
> 

Thanks, PATCH[4]'s fix tag will point to 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache"),
which was merged to v5.17. The fix tags for other patches are correct

Thanks,
Gavin


