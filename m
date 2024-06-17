Return-Path: <linux-kernel+bounces-217085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16C90AA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F22828C3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E971940B3;
	Mon, 17 Jun 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsYe6sK5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22C19149E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617948; cv=none; b=BqX5YohlhhWWZ6iXbu7095zFS2yjvl7+wnLIyqwAjTLA/cNNzxZ5qkLFoDDiW9zNYT7Z4l7/nYggoLfyKjCG3pzmgh66ShAqiN9Jk7GXSHNpAD33ZswxIg8BohGmQ0Tx0RIJ3mVeztgRyRtnAayWZsgRqfocLqy3V6XswaAqdBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617948; c=relaxed/simple;
	bh=0diccXzeqCODbtB5L/RmLhup3dwka4Towaac8oBPrOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SW1rYPfTdm1wnoZ/UCySLZzWHwACmpeNRVZpjeL8og3NeRbozV2uJhdroNbSZ6BsJuU4wyiBgq+fVfmmnCRCxNnK6jntxLCElRO/TyFXR+X52z6qMxlXF6jyKt+nd06+bcuzpkO2jK4RXVDYBFPz+3P+nvhMPGi4rlGkcJm9z+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsYe6sK5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718617945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=upc3/mktmP/npFDSDwM/GDltY3em+URTeFSNSPFhZqQ=;
	b=JsYe6sK5yCCqZizVBuGr9Yo2N8wpl3fmKZ7LV5IJVqmLifeS3seAKofwFxm4wt60ErBj/S
	yTJSToHq7ml78QYr3ZDOPSY5K/UafNRTjZiLXO+Lb515JXc+SoPBADQg0EotYC0sp5KL21
	zkVn5JmaQbgRxup/c/kbM0bTnxJ9jKQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-p65i3JMrOimp_P_vb1oazw-1; Mon, 17 Jun 2024 05:52:24 -0400
X-MC-Unique: p65i3JMrOimp_P_vb1oazw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52c83760212so3251079e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617943; x=1719222743;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upc3/mktmP/npFDSDwM/GDltY3em+URTeFSNSPFhZqQ=;
        b=TQf8EH3+ZPKjOCUyOknM+9TJjFMoG6hGc+dF5aifuXZvR//SfE0CGN1T4ZjZ/I4zEa
         ireRhEa69l3TQlSGPgDFGlEUHHFlp4C5DFJ4XV85Lr0U6Pomf8y/oOEI52Mbbn9LOpcS
         F2SHnwpHXCdVbuW7EoXJDDOq4DVWDRPJVksDaZgXrjMTIJB3WwdgpyQd79sS2nwDJlgP
         S9eyUTwBitF9z7omBO5LlPB6SBhDfE41WsNvrVbx3RzY09b6x1yXih9QNQckK0m253bw
         4i9rEApK/OUYpGMkUpx3qV4OpV1o+lbTy7IcvcIs/tWsqWtBWYmswPzn7vT2JPVYybsS
         rTxw==
X-Forwarded-Encrypted: i=1; AJvYcCXbGmY4rNx7PgN1BYUb/obTY6FafjUIUFwsGP8qKeiEg2iJXaV19li9F0H6VGRhMAlrrfCq5MkmoxfNsUTbHAVJ1O+5ol6vyypq82tt
X-Gm-Message-State: AOJu0Yygdgm4kz78uldZLePTzjvBacujo11aES8fN8K3/nBa3/eBefZg
	VK5faekOJrMEEsAq1Wzn3dG59NaxjjJprNuD5ksgpfbmKS/6Hp/LDWueIarQa4ZPOsGdawqosJT
	SRFehCLlRoWv6CrC6+Ncu7Gf02sUfeCbVHa2lgsiYZHcCRLtzKUYn6zSZ8PzLdktYgeV8wQ==
X-Received: by 2002:ac2:5f53:0:b0:52c:9bcc:e177 with SMTP id 2adb3069b0e04-52ca6e6db3emr6300460e87.34.1718617942818;
        Mon, 17 Jun 2024 02:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTnElTyOc1gk5JjgjRK+1F6XuAO37hYNdlhnJ+qHYwdAv1eQppFyilEXe800qNX9Un5jnxdg==
X-Received: by 2002:ac2:5f53:0:b0:52c:9bcc:e177 with SMTP id 2adb3069b0e04-52ca6e6db3emr6300442e87.34.1718617942398;
        Mon, 17 Jun 2024 02:52:22 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6127d6dsm154993945e9.26.2024.06.17.02.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:52:21 -0700 (PDT)
Message-ID: <87fc95c7-0351-4b05-b68b-9b9364474cae@redhat.com>
Date: Mon, 17 Jun 2024 11:52:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: yangge1116 <yangge1116@126.com>, Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn
References: <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
 <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
 <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
 <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
 <48150a28-ed48-49ff-9432-9cd30cda4da4@linux.alibaba.com>
 <11ef3deb-d1e3-46d5-97ed-9ba3c1fbbba9@redhat.com>
 <697a9bc2-a655-4035-aa5e-7d3acb23e79d@redhat.com>
 <d6deb928-3466-45ea-939b-cb5aca9bc7b4@linux.alibaba.com>
 <3a368e38-a4cb-413e-a6d9-41c6b3dbd5ae@redhat.com>
 <48fb0e58-16d1-7956-cf35-74741826617a@126.com>
 <ZmR1dVUB5mE2If9t@casper.infradead.org>
 <617f9e36-9334-4630-a6b9-473f2dd570d4@redhat.com>
 <8351052a-5c21-c383-544b-3166e883587c@126.com>
 <a39c8602-3c9c-48fd-9bdb-2089ccccd6bc@redhat.com>
 <7b69abe5-3782-965c-ec82-5baef84e2d06@126.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7b69abe5-3782-965c-ec82-5baef84e2d06@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.06.24 11:50, yangge1116 wrote:
> 
> 
> 在 2024/6/12 下午3:32, David Hildenbrand 写道:
>> On 11.06.24 13:20, yangge1116 wrote:
>>>
>>>
>>> 在 2024/6/9 上午12:03, David Hildenbrand 写道:
>>>> On 08.06.24 17:15, Matthew Wilcox wrote:
>>>>> On Sat, Jun 08, 2024 at 12:38:49PM +0800, yangge1116 wrote:
>>>>>> Can we add a PG_lru_batch flag to determine whether a page is in lru
>>>>>> batch?
>>>>>> If we can, seems this problem will be easier.
>>>>>
>>>>> Page flags are in short supply.  You'd need a really good
>>>>> justification.
>>>>>
>>>>
>>>> A flag would not be able to handle the "part of multiple LRU batches"
>>>> that should currently possible (when to clear the flag?). Well, if we
>>>> have to keep supporting that. If we only to be part in a single LRU
>>>> batch, a new flag could work and we could still allow isolating a folio
>>>> from LRU while in some LRU batch.
>>>
>>> Yes, before adding a folio to LRU batch, check whether the folio has
>>> been added. Add the folio to LRU batch only if the folio has not been
>>> added.
>>>
>>>>
>>>> If we could handle it using the existing flags, that would of course be
>>>> better (wondering if we could store more information in the existing
>>>> flags by using a different encoding for the different states).
>>>
>>> If a folio contains more than one page, the folio will not be added to
>>> LRU batch. Can we use folio_test_large(folio) to filter?
>>>
>>> if (!folio_test_large(folio) && drain_allow) {
>>>      lru_add_drain_all();
>>>      drain_allow = false;
>>> }
>>
>> I think we should do better than this, and not do arbitrary
>> lru_add_drain_all() calls.
>>
> 
> Thanks, I've got another idea.
> 
> If we add GUP_PIN_COUNTING_BIAS to folio's ref count before adding to
> LRU batch, we can use folio_maybe_dma_pinned(folio) to check whether the
> folio is in LRU batch. I wonder if it's feasible?

Why would we want to make folio_maybe_dma_pinned() detection that worse?

-- 
Cheers,

David / dhildenb


