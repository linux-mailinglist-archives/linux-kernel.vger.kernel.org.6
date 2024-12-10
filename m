Return-Path: <linux-kernel+bounces-439243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929499EACAC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193CE2960B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B621DC9A9;
	Tue, 10 Dec 2024 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5k6jApf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C981DC99E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823593; cv=none; b=qkuepU59l+sWeil0lQFbvRZ8HKmQDFbra3ybB5TMA4BtJS9SH8hElBe8/gm7bamZyEHA9mo4UV7FeBzqPGMDnawpC2420ejE3r223jq4Tdb0O7mbBAFJnqanY4UR315KY0/EeI7jDf3MJPiC6DTq38VVZRis+P6vVfTQagAWEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823593; c=relaxed/simple;
	bh=IfoTZe/VrUgF9ZHQAH9Qe5C0Ph1goVeVOKxRoBk+MQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8PSVTWkztbXL037Riu19pHFjcO7LWr2qRulzgkH2/RiNWhvvg7CAJ3q3qp9D3g6UTrzhiCu/na+xjhafRgwLbxRgI0G3+LGPJ2OjFiti6AgIvIn2jmjK8bviIhQRCJpTNBVqU4++qB44i4KnxGB3jTGk6qRJR6JQzUCoF6W/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5k6jApf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733823590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D+Uv+Vx+HF9E4YKbYyzkXKDBdKz+8OHhAuKZnqmZkRo=;
	b=C5k6jApfHHXRGvwk0N38F4EYeHptqBCxKCxP0Ukt7gmYIuQvBqhuWmTAdhmxGzN3nJYB1Z
	DP0v5AZT5O4IhkCeJbwIi5S6NTtMZfVQHE1LehHcjF1MnsfDiFCL6Bb/PdGqVorgPTU06F
	DmNaQGHX4UxbPzCEGS7Kt87A9pyvWUI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-7t6GLUTrNQOI0gVtLb3tCA-1; Tue, 10 Dec 2024 04:39:48 -0500
X-MC-Unique: 7t6GLUTrNQOI0gVtLb3tCA-1
X-Mimecast-MFC-AGG-ID: 7t6GLUTrNQOI0gVtLb3tCA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385ed79291eso3140253f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823587; x=1734428387;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+Uv+Vx+HF9E4YKbYyzkXKDBdKz+8OHhAuKZnqmZkRo=;
        b=MUn5nuf35zgq0FsKGzds7ax/NjFYvVdGcryyR5R4RnrVr6v6tqetga22y3ulz6UUsV
         gqFYem58dCRuPLIozgDl8YZq1gG1v/1qXJ8s10VZ31GkIMD8AUhKBBbmvd/yKIBT+PFd
         t+ToZ8bKc+eRLK103UOaF8LLd4D82qFUYFw9+SkHNoRfarr2Oi0EKn7mTagGky4LGGIL
         RpjAXTJ2i6z5Dv+XgyAjPdKjzg3RPIYDK8cTU3oBNSUlixp0kS282KyE5gLbIdQgm8aD
         E4Ns82yUrgCM9JjaYHLeL2/420UKhtbV8JQtMSxzmchxjTYJbABUofzxUXSO8C0rb/Ye
         SO0g==
X-Forwarded-Encrypted: i=1; AJvYcCV49EiLYeefLyG+WONxIhRbs9v4uU54qHd8v3oMd24+pYRGoA0Hbr4M4eAApNR7GkhYb/E03Q6T4cT/IHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAjDdaWlybxjgwH319TF9M6CnE3i9BhR8/KrxOuVcG1VDBr4t
	qyOdJjPlU5EKtJKob2sVPkhHU90yLXAfsb3pBeVGgHB+M4FY9hYPiFegsK1xN3MEOoI0j684mgC
	SbqotPQpysF9+1KnWkopWOwfdQi3N/yAKdJSAl8q9xCJ5szWwNGzn2s8ZubV2Mw==
X-Gm-Gg: ASbGnct/jjhy9w2im6ccn6iCk+5Ut/7jJ6dkSNdvrMhV13msX+Dk/8AWKS4yfD0sBgk
	dzNhx4sKmuEcQSM2fzPoywIoxULS46zZqSgRsZFzO3KykUDIXH3C97VG5UvUaMWZOL9xAgh3T3K
	54Lvf+rZS7cOD6MEhtxfsAnd1njynFvttMel3ntrRDAjEUckLSpYwjjls097f/4qQRbtlN+YGgh
	uSiyGmFJmgd20PyNhjepS2SVbohZPK2FImzd6WIvW2zjK5V7PYrRRDtc8auA3/OVN2LasoGKYJ8
	oXy8zkb67ADBs480uh/euXoUz0FFX0xecKHm80qm1L7zhHC7RiP3dMfEu1L46ilopcTXKNWAm7A
	OVAfBwQ==
X-Received: by 2002:a05:6000:2a6:b0:385:fb40:e571 with SMTP id ffacd0b85a97d-386469a101emr1907181f8f.6.1733823587724;
        Tue, 10 Dec 2024 01:39:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTTdWJ3zb1Zjed1HWrG58HyaLWoY79cx2Ofjk54fKEID4esdsAEmYKqs55zCa1MDZw1GjV1Q==
X-Received: by 2002:a05:6000:2a6:b0:385:fb40:e571 with SMTP id ffacd0b85a97d-386469a101emr1907158f8f.6.1733823587384;
        Tue, 10 Dec 2024 01:39:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3? (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d7158c4sm12336389f8f.54.2024.12.10.01.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:39:46 -0800 (PST)
Message-ID: <20245acc-1d2e-4166-ab78-6b1614d4e47c@redhat.com>
Date: Tue, 10 Dec 2024 10:39:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
To: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Zi Yan <ziy@nvidia.com>, Yu Zhao <yuzhao@google.com>
References: <20241206095951.98007-1-david@redhat.com>
 <20241206095951.98007-2-david@redhat.com>
 <e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.12.24 20:01, Vlastimil Babka wrote:
> On 12/6/24 10:59, David Hildenbrand wrote:
>> Let's special-case for the common scenarios that:
>>
>> (a) We are freeing pages <= pageblock_order
>> (b) We are freeing a page <= MAX_PAGE_ORDER and all pageblocks match
>>      (especially, no mixture of isolated and non-isolated pageblocks)
> 
> Well in many of those cases we could also just adjust the pageblocks... But
> perhaps they indeed shouldn't differ in the first place, unless there's an
> isolation attempt.

Thanks for the review and finding that one flaw.

Yes, I agree: usually we expect this to only happen with isolated 
pageblocks. At least in the scenarios I have in mind (boot, hotplug, 
alloc_contig_range()), we should only ever have a mixture of isolated 
and !isolated.

Maybe one could even special case on zone->nr_isolate_pageblock: if 0, 
just assume all pageblocks are the equal. I'll look into some details 
and might send a follow-up patch.

-- 
Cheers,

David / dhildenb


