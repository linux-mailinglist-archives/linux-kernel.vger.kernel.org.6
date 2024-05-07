Return-Path: <linux-kernel+bounces-171981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B960D8BEB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6491C2214E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69D16D9A0;
	Tue,  7 May 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+Bvs9jm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8216D4F6
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106623; cv=none; b=ICm7v935NlEipEj2EadV3xJ8a8Ck5BgnOsD39xTh4OvU8f8NwVp5tNbwElVSASfiKKxdgAl9yKZ94eKQZ7c2NuWX66yGs5ufjiyklIoBgPgq7y1i31jTDCDnyCcvUufx0IAQNa0tzVy8qOXAIIbylRue8oQLPjdlSx11Dm4+39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106623; c=relaxed/simple;
	bh=todgKwr/CScOY+A7F9fkG13fuoc4NybkkFJ51I6dpdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJVdLFx176Stv/8Z2jfED1kAZ40BFKn20DzG44rbjTPBWUlOeQF+3vgzVATD4Hlgz1Y64Q6W3xmQc7kJIM0RZ66EuFt/tfMs9JR3bcemrVs/5Wpi+b0ODNwgmQWgyyq4dY7muNtSZ2UC8Le3HDUjLYydHiSCmEbC4sXxIQ3tjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+Bvs9jm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715106620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fHPcl5tLAWgsnKeV21CWQ6TvBf3RI38u5xSjGGRjJy4=;
	b=a+Bvs9jmh0dF5oDW9Y5x0ZIX0TLwCA9L+Gwx77Hi8OqMce6Sm4O28RHXopiR5Ql03Xloa9
	UZ7AY/nnMIEOQlKA9KlAQ3hvXnfW61DDuohlnzFlNQiATdNRelK0t0Lti7EpXZtiejpP3t
	GuiLSnibCjGhw0o52xM8kW9MH6IHQis=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-sQQIF0nrMXeuYa0zEgLJEw-1; Tue, 07 May 2024 14:30:19 -0400
X-MC-Unique: sQQIF0nrMXeuYa0zEgLJEw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-346c08df987so19591f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106618; x=1715711418;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fHPcl5tLAWgsnKeV21CWQ6TvBf3RI38u5xSjGGRjJy4=;
        b=Hr4RflGTdqThFVx7qr5O3CyK2wGRGPnksq2+l6nZqlLmfk36hpt3cbez0NKVr4PcTj
         sP3IWLNsHvBpKjkZfG37DUqJZwTeZaMMtpznLejhV2AigT4sZMiVHHCRC5RI6wGLqFeh
         qIlF3TFCYZ++SrRMQe4wdOGK+vjAXmDvFrwuF7TOK5xJyrI+R/WnhEAN76FcCujhedZO
         XucYIP9u4XY5KdZv3/EvTxC71xknZ13yaaIKZCFObMV5gPACaAcj2IctaKwyzLSXOljw
         nrazRWVE03fYmMLufQpHhdwdTgQ17iOg+Lgkd5TfixXbI6jV1m4XxFeK2vby8Z41yu6Z
         opig==
X-Forwarded-Encrypted: i=1; AJvYcCVXGn24xn2eqPGAI/8yiSRYeiW6AkVxcElK61Ol4djTXjLK2l6Fj4vFMfS+DINIflY8GNwF41Ty5HaVzL8oD4345NQigYjIWeLAW5Dt
X-Gm-Message-State: AOJu0Yy58/AypkVWwVc0PzgI3y+hDk45f3hzF2hJXq6fQ225zBBzkFoD
	ZV2fNc+x/2Cs8aEYdt5xeXXrJTTK1flJgp00bJ9fKSJeMzDlR81N2qslRpmQm4doXdaCb710W9L
	aKPU+hRVFVlxC++HuaL1SdWQFmc9IwHwRoMW0B3xeWcwvKgtlCcdkbKipClgWpQ==
X-Received: by 2002:a05:6000:b86:b0:34d:a0b4:d122 with SMTP id ffacd0b85a97d-34fcaa02533mr490493f8f.30.1715106618051;
        Tue, 07 May 2024 11:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7mf8ds4M054PVWfbTMpVAM2jRSr4JQPHwuncQiXJPbcNLu98xQNw4gNgCjf2Sy6HOkY1HYw==
X-Received: by 2002:a05:6000:b86:b0:34d:a0b4:d122 with SMTP id ffacd0b85a97d-34fcaa02533mr490463f8f.30.1715106617597;
        Tue, 07 May 2024 11:30:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:b500:3f9d:130d:ea00:afc7? (p200300cbc744b5003f9d130dea00afc7.dip0.t-ipconnect.de. [2003:cb:c744:b500:3f9d:130d:ea00:afc7])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d47c9000000b0034d7a555047sm13456532wrc.96.2024.05.07.11.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 11:30:17 -0700 (PDT)
Message-ID: <86749724-81fe-4d54-b909-e4ca4171c6ce@redhat.com>
Date: Tue, 7 May 2024 20:30:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org,
 sj@kernel.org, maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <cc9fd23f-7d87-48a7-a737-acbea8e95fb7@linux.alibaba.com>
 <CAK1f24kyCj2Svguuu07wDuVEWYYbcmRc_18ihgVAzSjoJ9ox2A@mail.gmail.com>
 <a8f7a8da-c2e1-443c-9220-a224d97b1c81@redhat.com>
 <CAK1f24=rWdgscbDa6pMqOmTEDOHVLo5NQ=7jOo9TdyJRXahHZg@mail.gmail.com>
 <20240507102241.0a09db69afd62efb5ce84f17@linux-foundation.org>
 <19645506-f17d-4202-807e-f0e5c99af742@redhat.com>
 <20240507103843.d15414e356d60612f94ec6ce@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240507103843.d15414e356d60612f94ec6ce@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.24 19:38, Andrew Morton wrote:
> On Tue, 7 May 2024 19:33:05 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>> Well, which series are we talking about?  "mm/madvise: enhance
>>> lazyfreeing with mTHP in madvise_free v10" or ""Reclaim lazyfree THP
>>> without splitting v4" or both?
>>
>> See my other mail, "mm/madvise: enhance lazyfreeing with mTHP in
>> madvise_free v10" is all acked/reviewed and good to go.
>>
>>>
>>> And how significant are the needed fixup patches?
>>>
>>> And what is our confidence level after those fixups are in place?
>>
>> I'm afraid I won't have time to review this series this/next week, so I
>> cannot tell. I already assumed this would not be 6.10 material.
> 
> OK, I've dropped the series "Reclaim lazyfree THP without splitting",
> v4.  Let's revisit in the next cycle.

Thanks, should be more than ready by then :)

-- 
Cheers,

David / dhildenb


