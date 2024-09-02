Return-Path: <linux-kernel+bounces-311420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0DA9688F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DDFB2204B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850115E81;
	Mon,  2 Sep 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8NcdWpL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88916200118
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283999; cv=none; b=USlryYZAzP4FLc1sSY1f84ot/hdrYl7UpfS++HyhmZMFJVwm4TeO4WWQN0AK58G4wgc6qpNjvLrpGtt0M7OtwDxsKwLCfw1hRAYGl2WatBIhs2LF5M2e9U/cjb1Oi1ygZZBXMBdCoUbgKP58uBDC3R50IjdR1kSYjyNdErlvIxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283999; c=relaxed/simple;
	bh=mL8u/QaAgRDkFloPPHg6w0teI2OXLqmh1DorelyTSFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYTmQOQqDUnBqeUzAYS5u24KcJ8R8YOJwvPtLpdbXnkUQSMiJXkd7ch3UypxiDrS6lLh6L6sKjtJNvCs5qXoIgdUDPuF9bc9yvEE0DzUtg+fXgNIuwLVNuze9JohIlCj2TrBY3auQmHbjtWbvalW5BnEDsKL2WdEOkV2OENfWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8NcdWpL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725283996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BatJX0UrZrv0JixsK5bHxW6Hou59a+F6YK/s6g/HXTs=;
	b=Q8NcdWpLxz+huS8aUVtRwPzkQapAC8lk5s8pBUYxJNHX/ZbhF/j+5mg1NG4jDyjnotYBlh
	Kh5eTRakAWKCdUtDGDKJqf8bFa23ZxSTi9zJZtQ3GWTprgMuDACD+T0HTDpEh4KmyOwRmt
	ZJWYZL9YdABW0Oc9VH94AhzDZFg2vvg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-rKXfY51KPVWrahbGwG9trg-1; Mon, 02 Sep 2024 09:33:15 -0400
X-MC-Unique: rKXfY51KPVWrahbGwG9trg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bb5950d1aso48367475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725283994; x=1725888794;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BatJX0UrZrv0JixsK5bHxW6Hou59a+F6YK/s6g/HXTs=;
        b=t7+43MmCuwBNnckbzyRM0aoAiWAh9ByYlSMGvZ9MrlulPSMr87f7NXy6eAOraZS0y+
         OA/eKwirkCm5hY5mb5uIUL4kkkY+kk0DYhwhHqRiOrO166kpb8qLBbzdiOJyyFUiAAsQ
         GptTY9tOmJ0Db/r1gSclKvTEb8/Wf5CWYn6zD9id6eH9PdWH3+PQjptqFYAsrGb0L1o3
         rcOx4QnUnd+2zx0o1iGX47T/HSlm0O3C9k5Dfx2kmryhMkrZyNGX+FqKtR8uQdHlybji
         5iGuMPK9dv6e07HM8UY2N+gkJB4h+2fchd3xDn2cyF3mJXrAJNUMzJ6Ef9uPAG6WHsrU
         tjlw==
X-Forwarded-Encrypted: i=1; AJvYcCU4pb0aSLZh5jhhCQ2s0gnpB7ZRGeMRqE9aBJiV6IX4D36LNyeQgQXaBI8oq+eOKlE01Dwq5fCnDPEarww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9nIDNJHAYeMgrCX1DCVqAurEvrRVsktwPp7j5+JczInwA1Tkc
	LBU8Cmb65nXJg0bEzsXFfd0juKw6w1sMl0xSoF+MbLL6nncs5jzhFZsVjCcS/13Wwaw+yaBAezV
	q5L9+fJNc+9swEsaMXdvQRlJ93ivWnVNihAXhzfDcR14aZXFr2uRWEDhLN5Scng==
X-Received: by 2002:a05:600c:4512:b0:426:5e8e:aa48 with SMTP id 5b1f17b1804b1-42bb01c1ff9mr131513845e9.22.1725283993917;
        Mon, 02 Sep 2024 06:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyRPmzpxcMqfNupV7IiaUohULHAhvhx0y6pDhqULdWQA+ozHPmnZsnbRmineAjrj+cCGVwQQ==
X-Received: by 2002:a05:600c:4512:b0:426:5e8e:aa48 with SMTP id 5b1f17b1804b1-42bb01c1ff9mr131513345e9.22.1725283993008;
        Mon, 02 Sep 2024 06:33:13 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba3f2875sm117904625e9.41.2024.09.02.06.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 06:33:12 -0700 (PDT)
Message-ID: <15f31ce4-6e41-4444-963b-77c9bea33b86@redhat.com>
Date: Mon, 2 Sep 2024 15:33:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: control mthp per process/cgroup
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nanyong Sun <sunnanyong@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc: hughd@google.com, akpm@linux-foundation.org, ryan.roberts@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, peterx@redhat.com, ziy@nvidia.com,
 wangkefeng.wang@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240816091327.54183-1-sunnanyong@huawei.com>
 <Zr-XVn1ExJ7_LSLS@casper.infradead.org>
 <3ac1e404-a531-a380-7a2f-6adae4640da6@huawei.com>
 <2cfb4e1a-d9be-47ab-b92d-94cd65bfec43@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2cfb4e1a-d9be-47ab-b92d-94cd65bfec43@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.09.24 11:36, Baolin Wang wrote:
> 
> 
> On 2024/8/19 13:58, Nanyong Sun wrote:
>> On 2024/8/17 2:15, Matthew Wilcox wrote:
>>
>>> On Fri, Aug 16, 2024 at 05:13:27PM +0800, Nanyong Sun wrote:
>>>> Now the large folio control interfaces is system wide and tend to be
>>>> default on: file systems use large folio by default if supported,
>>>> mTHP is tend to default enable when boot [1].
>>>> When large folio enabled, some workloads have performance benefit,
>>>> but some may not and some side effects can happen: the memory usage
>>>> may increase, direct reclaim maybe more frequently because of more
>>>> large order allocations, result in cpu usage also increases. We observed
>>>> this on a product environment which run nginx, the pgscan_direct count
>>>> increased a lot than before, can reach to 3000 times per second, and
>>>> disable file large folio can fix this.
>>> Can you share any details of your nginx workload that shows a regression?
>>> The heuristics for allocating large folios are completely untuned, so
>>> having data for a workload which performs better with small folios is
>>> very valuable.
>>>
>>> .
>> The RPS(/Requests per second/) which is the performance metric of nginx
>> workload has no
>> regression(also no improvement)，we just observed that  pgscan_direct
>> rate is much higher
>> with large folio.
>> So far, we have tested some workloads' benchmark, some did not have
>> performance improvement
>> but also did not have regression.
>> In a production environment, different workloads may be deployed on a
>> machine. Therefore,
>> do we need to add a process/cgroup level control to prevent workloads
>> that will not have
>> performance improvement from using mTHP? In this way, the memory
>> overhead and direct reclaim
>> caused by mTHP can be avoided for those process/cgroup.
> 
> OK. So no regression with mTHP, seems just some theoretical analysis.
> 
> IMHO, it would be better to evaluate your 'per-cgroup mTHP control' idea
> on some real workloads, and gather some data to evaluation, which can be
> more convincing.

Agreed!

-- 
Cheers,

David / dhildenb


