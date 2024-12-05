Return-Path: <linux-kernel+bounces-433023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74B9E52FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009A02872FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B481D63F2;
	Thu,  5 Dec 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+RI1Nva"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1B2391A1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395999; cv=none; b=Ha3pv64X8ErdVvfj0G6CHOyZF4suwx6MaDFTWVLaNeOKaE7QNguTgoKLpnqMdQ/UdeHVMcp8dvilH/KcDLsjIlT7b4KHNTnI1S7LNJAfTiDl4cW0TWO3YDNJHrLXilnqUVXCrh+FDHeG7n2b6xhk8afs7tK9HxJxwgPis+7CVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395999; c=relaxed/simple;
	bh=hy94NY21oOb9hSj04CnvCoM1wd+FE04UEpbYymEteHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=briJgFauY6Gh3kaUyi5V6hQ3/xsGcOYBM7rSz39CBl8RTbeQyb7a4K26QjxIhQ1MEpZ0RZDkxRgxEIAnzYelM+1NDEkL1AM58ehN3WC0twNoMbZ4rugQmnbh/8UHSoqrQbK3qqXtbhS18nkRF35DtOKsXZYo69+j86nKpGpEXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+RI1Nva; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733395993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oWIHGaMuZsBWFzkat+orQx5vWlr7AoJeOiq0AvT5DAU=;
	b=P+RI1Nva43snisvxRw5Q9fMxPojxc/ZKX8+p5hVAAdoV/uOPoCmFugQxbR5ThezagIzXsO
	EhtqxfslKB55SjD0HCuT+1l0U9XpAR7s8dsCAgL7uWvGjzY0QRDSLjdwkSM8rI72fo65qj
	xSUUuLn2KDeHjGjz0jvo1XcPci1Xx/E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-LsgQocSLMhKDii_IpSmuYg-1; Thu, 05 Dec 2024 05:53:10 -0500
X-MC-Unique: LsgQocSLMhKDii_IpSmuYg-1
X-Mimecast-MFC-AGG-ID: LsgQocSLMhKDii_IpSmuYg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a51e44d0so6877475e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395988; x=1734000788;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWIHGaMuZsBWFzkat+orQx5vWlr7AoJeOiq0AvT5DAU=;
        b=IqtnrK8FpuOoLflIj6FVpijaqp7htyjSlt3+Fras795OSfX82CkG4DxEInthqTzy3K
         kwcXHLdWEtE3maJ+oTXXxf46qmqgsAQjNiqSDFN4kQTmuaWcIYeg101wV+fmFd00l+tx
         jMytLqQlx2jpKehwubCV6urigmxjuFzqWlKHsiVllmvjk04TqElvHsNNzphOVW5pj4eu
         U064R8wAXTMq0RjgU3aw7Gb6pEq9KiAAQQG42e9ONUR0ZpKiAVnSRI1M3v0moExI2kBF
         TAfrwqZe0LC0anNup4ncfdLgtIOoP+IbFVyW7e33UaTS0C2QRhcKGO4QziEcGndFUD66
         gWpA==
X-Forwarded-Encrypted: i=1; AJvYcCWh89rdq4gB+BY4pmgyGB02ILXsbRdLIIJ1l7qx/WV8qBaElTUxuywiKatWnCr6vvSvn4w2jK5BWYYDeSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxW+BliX8GIpMVeTKjha32xXS9qtexJ5huvyOiC8Jn7XjrVkSB
	wwtTVHh6t7KIhI8DRRopSlTCqzqHKgGJc065ydm5f1DQ61bwE5WKvUCdggCTr7GcZNlMcHHenQW
	3DMbi5eo5YWoFTOqZ9X4PR2DtqjLPLxQnwMmsKU6w7k6Umxs/7IvY7ZbKwhF8tw==
X-Gm-Gg: ASbGncs66LS179xcgQGreeYKmIhi2JSUGyxHWi5Vwnowqx2qgWBnPagkWHzGJIVW6jR
	7nNqB5jp/Rmc2N1YcTP5rpnhT0EApA5+69ffIuhL67OhpZeqhBOitktRwVPkk/081UQ8Fjw7Uxs
	vbI/pyo9n7eDO8/2mslN9uli/kpQHvRWva5J6pxRmC3/sXrqN7UKbKuzJq5lPmsoU4gzYvO+/3Y
	Yf8nzejEPuKm3zstZl6ciy2/MYm07LfaHvwVxTjogjxE5ymviB9czh3KOSjxhudnU7DbU9sRX3A
	cKX07wE4IlJdIo2hWW23hbYdTlt8xO5az6J6W0NM2y47f/li1liU8qjusCtbz6AEXp6BawuI0s+
	pZw==
X-Received: by 2002:a05:600c:524d:b0:434:a7e3:db5c with SMTP id 5b1f17b1804b1-434d09b6730mr84812905e9.11.1733395987817;
        Thu, 05 Dec 2024 02:53:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5ooW6PQVlKcbIE8lDown5w8jE9itKtAbQu53+Vl0JIPmxvUx+/PSBOGqQF76NIOjES0g0xw==
X-Received: by 2002:a05:600c:524d:b0:434:a7e3:db5c with SMTP id 5b1f17b1804b1-434d09b6730mr84812715e9.11.1733395987472;
        Thu, 05 Dec 2024 02:53:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8? (p200300cbc70f7e0075dc9c4033fab5f8.dip0.t-ipconnect.de. [2003:cb:c70f:7e00:75dc:9c40:33fa:b5f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5281229sm56908145e9.26.2024.12.05.02.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 02:53:06 -0800 (PST)
Message-ID: <12445dbf-cdcb-4ac8-8d6f-5b0683df6a75@redhat.com>
Date: Thu, 5 Dec 2024 11:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] anon_vma lock in khugepaged
To: Dev Jain <dev.jain@arm.com>, ryan.roberts@arm.com,
 kirill.shutemov@linux.intel.com, willy@infradead.org, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241128062641.59096-1-dev.jain@arm.com>
 <ea15f3d3-5dd8-4404-8dab-5673bb5f3413@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ea15f3d3-5dd8-4404-8dab-5673bb5f3413@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.12.24 11:10, Dev Jain wrote:
> 
> On 28/11/24 11:56 am, Dev Jain wrote:
>> Hi, I was looking at khugepaged code and I cannot figure out what will the problem be
>> if we take the mmap lock in read mode. Shouldn't just taking the PMD lock, then PTL,
>> then unlocking PTL, then unlocking PMD, solve any races with page table walkers?
>>
>>
> 
> Similar questions:
> 
> 1. Why do we need anon_vma_lock_write() in collapse_huge_page()? AFAIK we need to walk anon_vma's either
>      when we are forking or when we are unmapping a folio and need to find all VMAs mapping it; the former path takes the
>      mmap_write_lock() and so we have no problem, and for the latter, if we just had anon_vma_lock_read(), then it
>      may happen that kswapd isolates folio from LRU, and traverses rmap and swaps the folio out and khugepaged fails in
>      folio_isolate_lru(), but then that is not a fatal problem but just a performance degradation due to a race (wherein
>      the entire code is racy anyways). What am I missing?
> 
> 2. In what all scenarios does rmap come into play? Fork, swapping out, any other I am missing?
> 
> 3. Please confirm the correctness: In stark contrast to page migration, we do not need to do rmap walk and nuke all
>      PTEs referencing the folio, because for anon non-shmem folios, the only way the folio can be shared is forking,
>      and, if that is the case, folio_put() will not release the folio in __collapse_huge_page_copy_succeeded() -> free_page_and_swap_cache(),
>      so the old folio is still there and child processes can read from it. Page migration requires that we are able
>      to deallocate the old folios.
> 

Without going too much into detail: I think one reason is that 
try_to_unmap() and friends should not fail (not finding all PTEs/PMDs) 
simply because there is concurrent collapse going on.

Observe how try_to_unmap() and friends take the folio lock first, and 
how collapse tries taking the folio locks only after it already 
invalidated the PMDP.

Likely there are other reasons, but this is the "obvious" one I can 
think of.

We really try preventing *any* concurrent page table walkers, and that 
requires the mmap lock+vma lock in write + rmap lock in write.

-- 
Cheers,

David / dhildenb


