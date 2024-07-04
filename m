Return-Path: <linux-kernel+bounces-240893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC68927444
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BFA1F2341E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609BC1AB51B;
	Thu,  4 Jul 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QG0wQm0N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5914B964
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089885; cv=none; b=my+lnP8U8ykc6DrniSGtmrmX5XvKELIaBFSHpt1PsLW9trNWTy1cALZLdFz5N9nvuWax6Vuu8fIZJhuW90aSoIRIaVWrc2M7fUMHreyq+AswUQZAjpfQAbfmRQT2KkaKk3vpdWnjzeaFZWAp/Vv3YK0x5OPjUIHxw7YGa5KTVO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089885; c=relaxed/simple;
	bh=8g2yPPGMct+M6aBR8QBUu7FaRJJnQdYJKGgMMP0tvdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIwiZ3X+ZID7s1Qh0+jgVGwQehBzyZYno0n2VlrlQ27Dc0R2Tx9Nt5lOlf8XfYyQgiHyWykmBBOxVSoYw5x6pAWmCZ1Rt8qu5Iunvmvqs+zn4/OGjRCQHh8AfW/BR1iZ0RsbyGf/LRD7lSjE8ThsEClJ9Um449WE1veGt7wJWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QG0wQm0N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720089883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fZpn8kHgE/bMEniuPcP/3ICYR7WvQhmiBIdlMJZWKSI=;
	b=QG0wQm0NyOn6TM/L/Vatb0E69WmF7Plo7U+Zt9k/DtOL11JePvc8lxvWiyPQB3LcMsxmir
	PCV0JwKo4zQ/XIq+8PsTBkuwi6qaLBT4HhGvohK5himjy/cHFS1KbGkIhPQAZmcmsL+OQb
	wIiDVNRpchpqZh3ggSNR7uyk7u0+WvE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-Cd14ECP_NayK6qs3f7gMsA-1; Thu, 04 Jul 2024 06:44:41 -0400
X-MC-Unique: Cd14ECP_NayK6qs3f7gMsA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee4d3091b6so6684581fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 03:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720089880; x=1720694680;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZpn8kHgE/bMEniuPcP/3ICYR7WvQhmiBIdlMJZWKSI=;
        b=SpcmBGz9clJQABHk+ZTgPkUqP0J7NXVALHRu9amKoIkHZwplx2Ut7X6vUpJjWhnFwF
         fgkn3Pa0WM5NocRxy+WInA3fSgTVaKvAVACNdFUI67/bDGq6bkt0mSXqjIzSd/GcUNTp
         IiD7cwy6hzshIiSKoGqHDr7Vp1sy9aW8m5dR3U2EYWyzqSOMN+kVFVqz0ZiOoEgjtGr1
         2NvueNc6Dq9MAlvzxFqKXRUHFBafMEx+LWhy+zgn6JgQDfz8fv04E9Po5zDlDVtZyAlb
         43VDXcSQk3u+pLLuqdp37tfTPqIhE98uFxpgtsG6134Tlml8meP1pV3BfHI6FS0KTNyO
         yehQ==
X-Gm-Message-State: AOJu0Yy+sVQsVQyeo2aBgnPMIN/xM0kU2o5QIVc0UwHZGlaLYqROpbJG
	0LJ9YRpbzicwZPXnm5NcymrwxViklI0d3vdcXBrRQOIinQZGc/8foD3Ma1B3Z/c9iG1soqTkFNi
	Od2CkZuAu6c0DROrD1Z/oiRLnoFU9c61kM/+/BFnH+JDHfJma/W6KHSh0DRIilP9DzWUmDA==
X-Received: by 2002:ac2:4e97:0:b0:52c:d8c7:49ce with SMTP id 2adb3069b0e04-52ea06263e2mr770016e87.22.1720089880331;
        Thu, 04 Jul 2024 03:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsIQ5LP+eCBnK+pL5Qjpaln16Nnr9AYVYZyLyUFoDQ2TromTpHMZFpWECpn79jDrL3AQx2Xw==
X-Received: by 2002:ac2:4e97:0:b0:52c:d8c7:49ce with SMTP id 2adb3069b0e04-52ea06263e2mr769996e87.22.1720089879871;
        Thu, 04 Jul 2024 03:44:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:8600:f05d:97b6:fb98:2bc1? (p200300cbc7158600f05d97b6fb982bc1.dip0.t-ipconnect.de. [2003:cb:c715:8600:f05d:97b6:fb98:2bc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d1668sm19287565e9.1.2024.07.04.03.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 03:44:39 -0700 (PDT)
Message-ID: <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com>
Date: Thu, 4 Jul 2024 12:44:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240704043132.28501-1-osalvador@suse.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 06:30, Oscar Salvador wrote:
> Hi all,
> 
> During Peter's talk at the LSFMM, it was agreed that one of the things
> that need to be done in order to further integrate hugetlb into mm core,
> is to unify generic and hugetlb pagewalkers.
> I started with this one, which is unifying hugetlb into generic
> pagewalk, instead of having its hugetlb_entry entries.
> Which means that pmd_entry/pte_entry(for cont-pte) entries will also deal with
> hugetlb vmas as well, and so will new pud_entry entries since hugetlb can be
> pud mapped (devm pages as well but we seem not to care about those with
> the exception of hmm code).
> 
> The outcome is this RFC.

First of all, a good step into the right direction, but maybe not what 
we want long-term. So I'm questioning whether we want this intermediate 
approach. walk_page_range() and friends are simply not a good design 
(e.g., indirect function calls).


There are roughly two categories of page table walkers we have:

1) We actually only want to walk present folios (to be precise, page
    ranges of folios). We should look into moving away from the walk the
    page walker API where possible, and have something better that
    directly gives us the folio (page ranges). Any PTE batching would be
    done internally.

2) We want to deal with non-present folios as well (swp entries and all
    kinds of other stuff). We should maybe implement our custom page
    table walker and move away from walk_page_range(). We are not walking
    "pages" after all but everything else included :)

Then, there is a subset of 1) where we only want to walk to a single 
address (a single folio). I'm working on that right now to get rid of 
follow_page() and some (IIRC 3: KSM an daemon) walk_page_range() users. 
Hugetlb will still remain a bit special, but I'm afraid we cannot hide 
that completely.

-- 
Cheers,

David / dhildenb


