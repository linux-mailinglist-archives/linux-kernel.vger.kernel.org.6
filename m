Return-Path: <linux-kernel+bounces-227797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC69156A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411E31C21F66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A21BC20;
	Mon, 24 Jun 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z87RTDvE"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C8107A0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255028; cv=none; b=e4egZjoL9CwQMvmbNpAwWO5eJ5SIEHPFIbn7cg6B2lM7JCkwbeszuDWt1qV97OlelMUvR/g1j2wwMhQ+FaLU5peKmqzuE0YsR0mFdKbYORbz6H6hxejPEKbCfzHpIJg6ugCGFD3M1/s+2luiYtIOW/xrVlPOsFKxWAVHYrnaEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255028; c=relaxed/simple;
	bh=qcsG6vyr1tXaw2vLVjmbHIg584Hl51LOJd9BkXwOpMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVzbKJntQKQlsIebHn8GbaXFyNmrKC/CAHVrbeFkAwiomdP54zNvnK7o9FT7g7w3mYPAOMNqgNQ/4nGrlFqYG4ZCZo056nTZISvZ43PpgXwEffwl9bdqiuTHEnZFcbqt5EenCP52vLsyXn8+8D/Xp/7OILVhtdYizvEkHjcVBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z87RTDvE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421d32fda86so51662045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719255024; x=1719859824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBiWnUshv9OkKg3tPzc7vkd68oaE09mot+Fd5BTkZ5w=;
        b=Z87RTDvErLdTSQbEAMguT2HWxnfXsartkRT7UmxkRm+hkWj3STBEAjyHiLsyWLbE40
         94UnIdbT7RnluvZCPDpHfZaJgPy23jlKwly0XaWcaU482uRFlNkVPC6aQhiT15bWnnzQ
         5E5caQlczTJc84O+wP34lrfyND9pmx4614L8DP+LZuqhw37pLpQW76U19ZVQRYgmJnHj
         yf4/D6n3Nwzq99sPOjrJK3Rp+9tbzFnzxbD9rVmxWJuxJAVoNjd2GekXnhom68n8K8zT
         NhLwq1Q6FCTeFdx1pjdwSq7hba7ajUV0lWGNJCgtpKRjIJ7V1GSF/A+n4TUmoEl7/igS
         AFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255024; x=1719859824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBiWnUshv9OkKg3tPzc7vkd68oaE09mot+Fd5BTkZ5w=;
        b=l8jUc/7KxxHJAS1XqM6GVLAYOLqdpEtKYTq3wxmNdC2lTpHEpZ6QRMFp11VKOrfRlS
         IOVwTYw3S3/aSUd3JU4A1O5cIJ4EH4nHarCuXg+OVvI+ihQfWWWablRkEgCWkJtiZEgn
         yzroq7JnVvk0MANu/Al7SUSkGhrgzDrnUunY4xGBURw/LlUVlpWHs4o6UT5Y3c9srsPO
         PQPvBTHSU4NduZZUiW6DwKJdTWDn2uWHuRFtg1PuTtCIxwS5Dg9G7ap7ZwcSwXF118DO
         BEqvDqbWkpA9/yuBo+BQnLXgMhSIy7qTnIQWamzn1XdGnkRRGMWY4xqnicfFfBwQe6xY
         hSsw==
X-Forwarded-Encrypted: i=1; AJvYcCXZFQw7GY08Ob3mqFfbQf/X+i0DT4DKiVju7iyxWc+j+hylhXJHNSYPGxo3qxlwhS/l/gmnFOc7o0b/Vlo7mBrX2DwN3hdULBVuECOE
X-Gm-Message-State: AOJu0YxWtMe8dert5pH7x7gby+3NCV46GVyjBXcl41VxMO9wv5raRh8b
	ipIfMQAcSegSHALFoMgru9dNNfinq1kdJz4wRs0PYmL614PjaAoP
X-Google-Smtp-Source: AGHT+IEG0ohM8vCl8uLGcKYTGbH3rrX+tD6F5+jka/SZNjxategSPRKu6VYzlsUqtGUOqJetdRzptg==
X-Received: by 2002:a05:600c:21cc:b0:421:756f:b2e8 with SMTP id 5b1f17b1804b1-4248cc271b9mr48044475e9.11.1719255023980;
        Mon, 24 Jun 2024 11:50:23 -0700 (PDT)
Received: from ?IPV6:2001:16a2:df66:b900:46d:aa3:6645:bcd8? ([2001:16a2:df66:b900:46d:aa3:6645:bcd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f65easm10837829f8f.23.2024.06.24.11.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 11:50:23 -0700 (PDT)
Message-ID: <ad18c6fb-7d00-494b-a1f6-3d4acfbd2323@gmail.com>
Date: Mon, 24 Jun 2024 21:50:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: Matthew Wilcox <willy@infradead.org>, Yosry Ahmed <yosryahmed@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <Znm74wW3xARhR2qN@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/06/2024 21:33, Matthew Wilcox wrote:
> On Mon, Jun 24, 2024 at 05:05:56AM -0700, Yosry Ahmed wrote:
>> On Mon, Jun 24, 2024 at 1:49 AM kernel test robot <oliver.sang@intel.com> wrote:
>>> kernel test robot noticed "WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof" on:
>>>
>>> commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pages to be swapped out in a bitmap")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>> This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), and
>> is triggered by the new bitmap_zalloc() call in the swapon path. For a
>> sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
>> under the hood) cannot be used to allocate the bitmap.
> Do we need to use a bitmap?
>
> We could place a special entry in the swapcache instead (there's
> XA_ZERO_ENTRY already defined, and if we need a different entry that's
> not XA_ZERO_ENTRY, there's room for a few hundred more special entries).

I was going for the most space-efficient and simplest data structure, 
which is bitmap. I believe xarray is either pointer or integer between 0 
and LONG_MAX? We could convert the individual bits into integer and 
store them, and have another function to extract the integer stored in 
xarray to a bit, but I think thats basically a separate bitmap_xarray 
API (which would probably take more space than a traditional bitmap API, 
and I dont want to make this series dependent on something like that), 
so I would prefer to use bitmap.


