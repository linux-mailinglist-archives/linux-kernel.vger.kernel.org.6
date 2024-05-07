Return-Path: <linux-kernel+bounces-171210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C068BE142
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8A11F219F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C411A152DEA;
	Tue,  7 May 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyrbP9HJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E206F525
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082165; cv=none; b=kz/+ZCGVt4/Z53Hccp2cMdeqQJPQBtsxU4nmSrTFgA0ulqAT0ZRuA60TVce0ntVmpJ60y1wdATEnc6ZAdBBO/UpQDI20kxGlqh9rg2P7EZ57bay2Kkc91Vr8XD/1Mzu862Z7WUMriIs/MR2Ciit0G8MrsSFemcNTsJLx6DVVJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082165; c=relaxed/simple;
	bh=9WvnFyNuQ4U1cXH4W2mfSfQq2or6ycC8wjnRBp3cTak=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KyyamxlmfexlP95FS5h884sbwZH+E8trVdfEy3eT52EoldI78CFXBAlFT+Q2x+OCux0hj5HMT1zaE6wPskwF2EK8rAVTGNFr3vy5AuWm0RAdcFwG+9h+fOEBNYYztwgHzee7WlgezNpguZP5GWCxQyW6U9hqlKQjOjk/qvd3SSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyrbP9HJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715082163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jPRYoMgnpo20fT3iCSoSZIvouquMcyBtOuWF7MTQKrM=;
	b=NyrbP9HJ7XJoPcfQ13GGBZBMwbMwTn/YdyvGZ+gtDZSXTyxuUztoJb/BQyCmPWOMFFkMQE
	TohloMe2E/ip4lhYFuxaIa37dMIJaZH7G83wtUJ2Q6ogeJobMgpxkdVyvBRiyvgdt4cJEQ
	lI+/g3VjHtZetk2XaghdUJJrjfssOQw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-M_LjhinMOpmDMa2K8IjNng-1; Tue, 07 May 2024 07:42:41 -0400
X-MC-Unique: M_LjhinMOpmDMa2K8IjNng-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-349fbb7ab16so2032847f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082160; x=1715686960;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jPRYoMgnpo20fT3iCSoSZIvouquMcyBtOuWF7MTQKrM=;
        b=ktMLeTWxKMNQHJGJJTJogBaXLobpbPun7U3FACg+y+cC0keyZa0D8jIQgaOt2wigtS
         7s9voKABDTefRGxa13vEhMxmyrjTa5lIuxEX9HZ3jFL7bkKFX/t0hApO5omzrZcbqfFj
         UzNqrEGHImPQ+BxHr+Q45xDjm2KxZU//YDzU0Z1CJ60HJTYR9MDPRBA+EtWEDzIenQKZ
         M/EP882KdWzcg4scx8Bk7ZBrILDG7jc9mmzNTYqPUNTgTg9IMpm3Qfd7bx9Ppf1+ZUKL
         EGPegJS8R7hmBQWfS5BLx8nP+tb0+zWBnitNqlXGvDpnXMAnrc/z5n5zPiDNSRo5dr8H
         R1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVsHfgSr7RJYrZZHeaRperxqhanEtKk1guBbRNGBpz7Wtsb/15Mi0HvbWeU3JJxWQE+/hhSlDwycNmn1m3qUkrYZ2YF9ithcjQwryDd
X-Gm-Message-State: AOJu0YwC/zpQUWK64OIQSWtvzqTCqnQAvRYvMEc3cQY+KyiHVYuRpLH4
	4b/bFGIBTI760vRUmjYkcH/NNHH14FCM8gr46+hcz8BANzWhuUB8I3CZxWQOuaTavYLPMK8nKjZ
	sT4fnulOZymilmbGzUbo0ObNr9tO7oBLZeW3kr5IuJmu1NzU0Azeuul+UTW8YWQ==
X-Received: by 2002:a5d:4681:0:b0:343:e52a:f51e with SMTP id u1-20020a5d4681000000b00343e52af51emr8296787wrq.47.1715082160560;
        Tue, 07 May 2024 04:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESeSNqcQIHzk1ErFvIeBHGLDQr/04N51XuBaeu1HoaBLFdx8kWZGQAD/9HQIw5flvl8pBWjg==
X-Received: by 2002:a5d:4681:0:b0:343:e52a:f51e with SMTP id u1-20020a5d4681000000b00343e52af51emr8296773wrq.47.1715082160083;
        Tue, 07 May 2024 04:42:40 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id s8-20020adfecc8000000b0034dda041ccasm12818039wro.102.2024.05.07.04.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:42:39 -0700 (PDT)
Message-ID: <adc6ac88-8fb8-44ad-abe6-9e9f9e4017e3@redhat.com>
Date: Tue, 7 May 2024 13:42:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
From: David Hildenbrand <david@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, cl@linux.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ze Zuo <zuoze1@huawei.com>
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
 <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
 <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
 <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com>
 <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
 <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com>
 <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
 <2c14d9ad-c5a3-4f29-a6eb-633cdf3a5e9e@redhat.com>
 <4e7ce57f-cad1-44d5-a1d8-4cd47683a358@arm.com>
 <9ce8a0f4-d1af-44ea-87b5-57ebdb3d2910@arm.com>
 <dbeda3dd-900a-4362-886e-d9aaa58ca525@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dbeda3dd-900a-4362-886e-d9aaa58ca525@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.24 13:34, David Hildenbrand wrote:
> On 07.05.24 13:26, Ryan Roberts wrote:
>> On 07/05/2024 12:14, Ryan Roberts wrote:
>>> On 07/05/2024 12:13, David Hildenbrand wrote:
>>>>
>>>>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
>>>>>
>>>>>> suggest. If you want to try something semi-randomly; it might be useful to rule
>>>>>> out the arm64 contpte feature. I don't see how that would be interacting here if
>>>>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
>>>>>> ARM64_CONTPTE (needs EXPERT) at compile time.
>>>>> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE,
>>>>> but will have a try.
>>>>
>>>> cont-pte can get active if we're just lucky when allocating pages in the right
>>>> order, correct Ryan?
>>>
>>> No it shouldn't do; it requires the pages to be in the same folio.
> 
> Ah, my memory comes back. That's also important for folio_pte_batch() to
> currently work as expected I think. We could change that, though, and
> let cont-pte batch across folios.

Thinking about it (and trying to refresh my memories), access/dirty bits 
might be why we don't want to do that.

-- 
Cheers,

David / dhildenb


