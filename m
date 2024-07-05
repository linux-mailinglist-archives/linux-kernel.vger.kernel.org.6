Return-Path: <linux-kernel+bounces-242214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882D928515
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F0C2872F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A64146A70;
	Fri,  5 Jul 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj5Ze7/W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627E14659B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171529; cv=none; b=dTLYP3P32hF8BfLRdw9BsQy5xAC3KW5hw0sGkKhYRgo0DEaa1OYayZcxy1pcicRLVdXekv5tfCnIg4kWfp9nvdQN5yw83EQCZAksQdZVKWEveRWwLoAdV6D00+x11V3oy6HIuMtvLWTm+zltQS1Wu7BYO464PNd5yYOFrGJt6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171529; c=relaxed/simple;
	bh=9MNSqL4NeUq23/OTvVXiSmbLK4Q+K0s48i6NHuzpOV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfMds5iujXA21WdTeB+Ifq5qzJMtT2B7I07F4teu72dauGhU4quOtPbvFlQE9FBBQFxJMxWFA5JZny74kfNoSNIKNtCSSVM1gi0wKBBDZ8wK+REAqBGn9KzQiLPojB2qpd5CuG4SokLHfJd1wxtZlLu0lF/ITTCdi9Ld79pv8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj5Ze7/W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720171526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jFgktRIcn4fEYJ1yg6uwmX65jrTz7cOI5gGNfNtERRU=;
	b=Bj5Ze7/WY4Dr584iKalzt5AdioNC0Sc7vv3SKo7JIQ+n0NT7QhxGFIRhcmCNRuqdbpkmV8
	KVv/k4bZ4domvXU5RtVG+xbaxxwrd3+381agLMggjJA/tzj9m3n96IG0KCH4ACdk14CQy6
	tQetUvmm6wUfVjNYRebkj7owzEAh7IE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-iKsfRIZlMiWE3-o-yfLm4Q-1; Fri, 05 Jul 2024 05:25:25 -0400
X-MC-Unique: iKsfRIZlMiWE3-o-yfLm4Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-367960f4673so1259264f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720171524; x=1720776324;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFgktRIcn4fEYJ1yg6uwmX65jrTz7cOI5gGNfNtERRU=;
        b=IlWG62uek22Hnqv2Whe1FCK/mFoCoKn5e1PuaWEsKw418qqPduZMkvObHiKQ4BCTyL
         MOgWnTClRblj1F3wC3PmSVR/MXphC/dzG+6flN/HKgKq94QxnNpeIU13v43tKLY6zKTb
         oZbomo7mFVA55eXdZ2+mNoLuf7yNbud5LrMgKj2m6bxoDpdxjbX1qs/OHLS+TiIda9A6
         UfYi9H9Cau0vnMDdfTX4HoBq2c6YgxF69wjXYU+7o+ICY4EAL1UPagb8pJkoE0N1HfXH
         rXZl61MmBYPrji9YrZ4aWEuYTHKpWSczAF9PYVxtW9C+GpG3mkvPYRwgcfbffBaeRM5W
         UO1A==
X-Forwarded-Encrypted: i=1; AJvYcCVnREAr0PKoURINfVobdpMHtxN9X83MHE1J/gD0PNbFMD5fg8S0Vb7cP6rjUqF1vACsKqwfO9GVn7sMDzZHhGiPMvOjdl40omNo8TTy
X-Gm-Message-State: AOJu0YyzJqJU7+w5wqqYvTAi/nNQm6ECEYmp18KoP6CQQudOUAxmKF3Q
	xqDiFtwzZUIjn5kZuACKK0+XnT834umb9EX9sLH5sVJJPsVGId876x097kkq6al3dHGq/i5VZS6
	1dhQ7K7tSK6Vj6ucODOxytX66Ercun4cZQRbv2LvSOoCK1rflptidEcGqd61JuA==
X-Received: by 2002:a05:6000:174c:b0:35f:fd7:6102 with SMTP id ffacd0b85a97d-3679f73b500mr2395888f8f.35.1720171524237;
        Fri, 05 Jul 2024 02:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqteZpKt3KNmIXStPpAtdvnsWZXgYKagkSSx8CmZVWg4EMclfy9iPwNi9SeWQYqYCk5p2p+g==
X-Received: by 2002:a05:6000:174c:b0:35f:fd7:6102 with SMTP id ffacd0b85a97d-3679f73b500mr2395869f8f.35.1720171523713;
        Fri, 05 Jul 2024 02:25:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:b500:3ed7:a1c7:447e:2279? (p200300cbc702b5003ed7a1c7447e2279.dip0.t-ipconnect.de. [2003:cb:c702:b500:3ed7:a1c7:447e:2279])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a13b61f7sm2934238f8f.13.2024.07.05.02.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 02:25:23 -0700 (PDT)
Message-ID: <40ba1239-bbe2-470b-8574-c7e098b40bc7@redhat.com>
Date: Fri, 5 Jul 2024 11:25:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: add docs for per-order mTHP split counters
To: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
 akpm@linux-foundation.org
Cc: dj456119@gmail.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, libang.li@antgroup.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>, Mingzhe Yang <mingzhe.yang@ly.com>
References: <20240704012905.42971-1-ioworker0@gmail.com>
 <20240704012905.42971-3-ioworker0@gmail.com>
 <b99ba664-982d-4b8b-b923-c3cefae8e021@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b99ba664-982d-4b8b-b923-c3cefae8e021@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.07.24 11:16, Ryan Roberts wrote:
> On 04/07/2024 02:29, Lance Yang wrote:
>> This commit introduces documentation for mTHP split counters in
>> transhuge.rst.
>>
>> Reviewed-by: Barry Song <baohua@kernel.org>
>> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>> ---
>>   Documentation/admin-guide/mm/transhuge.rst | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 1f72b00af5d3..0830aa173a8b 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -369,10 +369,6 @@ also applies to the regions registered in khugepaged.
>>   Monitoring usage
>>   ================
>>   
>> -.. note::
>> -   Currently the below counters only record events relating to
>> -   PMD-sized THP. Events relating to other THP sizes are not included.
>> -
>>   The number of PMD-sized anonymous transparent huge pages currently used by the
>>   system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>>   To identify what applications are using PMD-sized anonymous transparent huge
>> @@ -514,6 +510,22 @@ file_fallback_charge
>>   	falls back to using small pages even though the allocation was
>>   	successful.
>>   
>> +split
>> +	is incremented every time a huge page is successfully split into
>> +	smaller orders. This can happen for a variety of reasons but a
>> +	common reason is that a huge page is old and is being reclaimed.
>> +	This action implies splitting any block mappings into PTEs.
> 
> nit: the block mappings will already be PTEs if starting with mTHP?


Was confused by that as well, so maybe just drop that detail here.
-- 
Cheers,

David / dhildenb


