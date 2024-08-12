Return-Path: <linux-kernel+bounces-282868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2AB94E9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E583B20E88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFBD1547F4;
	Mon, 12 Aug 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvUrVKky"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0131876
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455026; cv=none; b=PZ14eRGohB2YztSdmiTYLTQQnpmo9v/tXxXPgWKsOWGB3AiMOcIAau53wbyXU2/ijO/Fu1x+dakIIo+C/Se7uGNEdLt9lkBPSjk9ZgZHnQ7iDDWE5Ulg6x/FjzoGkI5AlGG44FjfBMPNSTeC8XSeGMlubThkd1a1fsa5ZJfG3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455026; c=relaxed/simple;
	bh=vzBBL1ZC3+7zIGGpMnRESBinlOVSn0i5ZzPm/BkJIjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0J6KB0zX4z/kz3KkCqHpgZfooHtmS08inpBGGT0Ue8xmY6RZiOSL/8D+PSnlC/0RI80YZCDgoI64VIvLcFL2Bx5eb+YCgA4ZNfMvIIW5uR4AacQ8c46BPdtSUe129EKt3a8hicq2qoDzE8U1SEiOa4yf9nqvfUARG1dyzS3Tdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BvUrVKky; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723455023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RlbAIG3U/FkMeN2DtHLFcCK+2wTph/qPAt3sAj3H4SA=;
	b=BvUrVKky2W6J5BtJ2Ag0USteUmEGlFfQbE/cdJo8HdTnF9JSjwsLRJNke3TklxR0x/x3wQ
	u/Tn50sfLL0TH3hpOwygmegzm6aA5DD0LsWX+s41Q/wFzXcJSy/77hRTpom63qvdiqy9kl
	QEfJvCDw9ANFevPN8wNrY4X9HjnNLqQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-2FIm3CoBP_6SxyO6TtZzSw-1; Mon, 12 Aug 2024 05:30:22 -0400
X-MC-Unique: 2FIm3CoBP_6SxyO6TtZzSw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3686d709f6dso2473630f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723455021; x=1724059821;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RlbAIG3U/FkMeN2DtHLFcCK+2wTph/qPAt3sAj3H4SA=;
        b=qfG+2+GDqSjroyEhlUyuMPNIctvkzC5faDgFJcV0TmUtMDzjztTT7g6Knfyfk6E871
         y/Un8NQH5zrqTXZ1fMuzM6PDgtSFHa15icLJdI656gwH98boD3L1Dj5tX0PJznyYQ5vI
         DXc3Nf+q5JGCNAgviJXGct2g0PhRXlftEkhtMx44LAtHQ8b/PmqOgZDArbfCrdv1XgHV
         4wJD07F0elRN94O2wmjZgZRA7QmxHYAV5O5NszrRTB7se1KgMLEyV6iLvK6UgjEyErR2
         fpt7C3l78cq1YiSYSw+IHOKkgBLbsRcA1YA8veje+/Nhyep6RjsLpaAT3CIn2V2EejRt
         ZOhg==
X-Forwarded-Encrypted: i=1; AJvYcCVW6l5eCn49F9+z/bgI8U4zWiZksBzj1/gEobcpM1BuuM1dUOknv7LVi9tiKdKpzAL4H/svxZwBcWxSbutpzFHNTrVwGi04qyFIa23j
X-Gm-Message-State: AOJu0YyNXAsqUwSsdOGiN1ln6dcI1EoO1iesJ7pbw4lBN9mPhLyNmzVV
	xKzmSyNTNDndLFnfvpYKs0gqQI/kU/xjrgeseL5XPyr37MNmKMIH2oo1+qePVhzg08zS3z07LUt
	CoIInzFvayauJn6SZJqXQqOyj/+0q8vq9WVS3B2fWKxwZCEZIvZ3GwFfbfCcJAg==
X-Received: by 2002:a5d:510f:0:b0:369:9358:4634 with SMTP id ffacd0b85a97d-36d5e4cb234mr5214820f8f.19.1723455020681;
        Mon, 12 Aug 2024 02:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+LE5JLv4epgU2WXufgtfc4m9ua8imHwjoTg51Xr3aHs998VDQnY94ZNURSbjf4We4Xxr8fA==
X-Received: by 2002:a5d:510f:0:b0:369:9358:4634 with SMTP id ffacd0b85a97d-36d5e4cb234mr5214772f8f.19.1723455020129;
        Mon, 12 Aug 2024 02:30:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cc18ee7sm6998882f8f.45.2024.08.12.02.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:30:19 -0700 (PDT)
Message-ID: <854cc5eb-0c60-4574-9291-e1c8dc84e5a6@redhat.com>
Date: Mon, 12 Aug 2024 11:30:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, ying.huang@intel.com
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-2-dev.jain@arm.com>
 <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
 <5a4ae1d3-d753-4261-97a8-926e44d4217a@arm.com>
 <367b0403-7477-4857-9e7c-5a749c723432@redhat.com>
 <ee1b9177-fb12-4bcb-a644-8d5d3d9f16fa@arm.com>
 <04e12698-8f83-4033-91b2-3a402c59c17a@redhat.com>
 <0d049ec4-ab39-441b-8560-5613f3527473@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0d049ec4-ab39-441b-8560-5613f3527473@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.08.24 07:35, Dev Jain wrote:
> 
> On 8/11/24 14:38, David Hildenbrand wrote:
>> On 11.08.24 08:06, Dev Jain wrote:
>>>
>>> On 8/11/24 00:22, David Hildenbrand wrote:
>>>> On 10.08.24 20:42, Dev Jain wrote:
>>>>>
>>>>> On 8/9/24 19:17, David Hildenbrand wrote:
>>>>>> On 09.08.24 12:31, Dev Jain wrote:
>>>>>>> As already being done in __migrate_folio(), wherein we backoff if
>>>>>>> the
>>>>>>> folio refcount is wrong, make this check during the unmapping phase,
>>>>>>> upon
>>>>>>> the failure of which, the original state of the PTEs will be
>>>>>>> restored
>>>>>>> and
>>>>>>> the folio lock will be dropped via migrate_folio_undo_src(), any
>>>>>>> racing
>>>>>>> thread will make progress and migration will be retried.
>>>>>>>
>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>> ---
>>>>>>>      mm/migrate.c | 9 +++++++++
>>>>>>>      1 file changed, 9 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>> index e7296c0fb5d5..477acf996951 100644
>>>>>>> --- a/mm/migrate.c
>>>>>>> +++ b/mm/migrate.c
>>>>>>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t
>>>>>>> get_new_folio,
>>>>>>>          }
>>>>>>>            if (!folio_mapped(src)) {
>>>>>>> +        /*
>>>>>>> +         * Someone may have changed the refcount and maybe sleeping
>>>>>>> +         * on the folio lock. In case of refcount mismatch, bail
>>>>>>> out,
>>>>>>> +         * let the system make progress and retry.
>>>>>>> +         */
>>>>>>> +        struct address_space *mapping = folio_mapping(src);
>>>>>>> +
>>>>>>> +        if (folio_ref_count(src) != folio_expected_refs(mapping,
>>>>>>> src))
>>>>>>> +            goto out;
>>>>>>
>>>>>> This really seems to be the latest point where we can "easily" back
>>>>>> off and unlock the source folio -- in this function :)
>>>>>>
>>>>>> I wonder if we should be smarter in the migrate_pages_batch() loop
>>>>>> when we start the actual migrations via migrate_folio_move(): if we
>>>>>> detect that a folio has unexpected references *and* it has waiters
>>>>>> (PG_waiters), back off then and retry the folio later. If it only has
>>>>>> unexpected references, just keep retrying: no waiters -> nobody is
>>>>>> waiting for the lock to make progress.
>>>>>
>>>>>
>>>>> The patch currently retries migration irrespective of the reason of
>>>>> refcount change.
>>>>>
>>>>> If you are suggesting that, break the retrying according to two
>>>>> conditions:
>>>>
>>>> That's not what I am suggesting ...
>>>>
>>>>>
>>>>>
>>>>>> This really seems to be the latest point where we can "easily" back
>>>>>> off and unlock the source folio -- in this function :)
>>>>>> For example, when migrate_folio_move() fails with -EAGAIN, check if
>>>>>> there are waiters (PG_waiter?) and undo+unlock to try again later.
>>>>>
>>>>>
>>>>> Currently, on -EAGAIN, migrate_folio_move() returns without undoing
>>>>> src
>>>>> and dst; even if we were to fall
>>>>
>>>> ...
>>>>
>>>> I am wondering if we should detect here if there are waiters and undo
>>>> src+dst.
>>>
>>> After undoing src+dst, which restores the PTEs, how are you going to
>>> set the
>>>
>>> PTEs to migration again? That is being done through
>>> migrate_folio_unmap(),
>>>
>>> and the loops of _unmap() and _move() are different. Or am I missing
>>> something...
>>
>> Again, no expert on the code, but it would mean that if we detect that
>> there are waiters, we would undo src+dst and add them to ret_folios,
>> similar to what we do in "Cleanup remaining folios" at the end of
>> migrate_pages_batch()?
>>
>> So instead of retrying migration of that folio, just give it up
>> immediately and retry again later.
>>
>> Of course, this means that (without further modifications to that
>> function), we would leave retrying these folios to the caller, such as
>> in migrate_pages_sync(), where we move ret_folios to the tail of
>> "folios" and retry migration.
> 
> So IIUC, you are saying to change the return value in
> __folio_migrate_mapping(), so that when move_to_new_folio() fails
> 
> in migrate_folio_move(), we end up in the retrying loop of _sync() which
> calls _batch() in synchronous mode. Here, we
> 
> will have to make a change to decide how much we want to retry?

So essentially, instead of checking for "unexpected references" and 
backing off once at the beginning (what you do in this patch), we would 
*not* add new checks for "unexpected references" and not fail early in 
that case.

Instead, we would continuously check if there are waiters, and if there 
are waiters, we back-off completely (->unlock) instead of retrying 
something that cannot possibly make progress.

For "unexpected references" it can make sense to just retry immediately, 
because these might just be speculative references or short-term 
references that will go away soon.

For "unexpected reference with waiters" (or just "waiters" which should 
be the same because "waiters" should imply "unexpected references"), 
it's different as you discovered.

What we do with these "somebody else is waiting to make progress" pages 
is indeed a god question -- Ying seems to have some ideas in how to 
optimize retrying further.

-- 
Cheers,

David / dhildenb


