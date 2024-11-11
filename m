Return-Path: <linux-kernel+bounces-404587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FAE9C455D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649BD1F227D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B51BBBE4;
	Mon, 11 Nov 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMFWwJaU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1208B1AB51E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351092; cv=none; b=tDb6bFWH4Ogfh+EoDERas/pR9AC/4aqiMv9FM1j0hN/vJz497OapFtpdavEYmBCCDySx+975CENmQcfJm6rvU+kBS+ENe0yLm/fLs91d66VEnCQaApHhneDNxPMR4VRq4SBLVRyGNgkxCaCyrHp99VaZoFH+bMtFfNnqlWKbrqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351092; c=relaxed/simple;
	bh=MTpZX5JfeyyyyUSFS4jw9azmMqwzmoUxTuNHbw6WU3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZXiFRsPiV52ukFnPkBrnZDmDIC55JNXn6fDdJImK3TPTXGgVNPDplQB5PHBdIA1ljblj0aeb9tt5PGEQ4q4USEsilN2TBhv98ti7ly+ZdjFZmjYbVM6VoJHOF9B2nGykobAz3wr3LESVUwryChhB0boOvalAwuVwuQUHO1ewcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMFWwJaU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731351090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsSRb3PGEUmOp7yP3NS3yWseDnxsiXqE/IGfV+5rsII=;
	b=dMFWwJaUqNdFf2KJAzbvtjhXeVt6mOxq6XncoAOjjULro2+cS2LXAogE3nfIPV5xbaRKsm
	03ZHWm3PkXgtcW4bN3KAWQQJjT88LVOwtRWi4qFns4JJ2lbXQ5/LGnOZDnHQ5xQnhkunaJ
	7JjFddERA2eSo2bepkzUgCWqsrs649s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-8wQ0XJiaPLSYRxPkJOVxGQ-1; Mon, 11 Nov 2024 13:51:28 -0500
X-MC-Unique: 8wQ0XJiaPLSYRxPkJOVxGQ-1
X-Mimecast-MFC-AGG-ID: 8wQ0XJiaPLSYRxPkJOVxGQ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c92e8b8101so3621360a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731351087; x=1731955887;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsSRb3PGEUmOp7yP3NS3yWseDnxsiXqE/IGfV+5rsII=;
        b=KXThqMOJ78/6Ikp9ldSnQ7r/BMW+sXIIWISoI+gg5pf1PT7NAA5sF1tuizEdBJrVRl
         yqQb5PdAcx0v7x+uktVl+2JDf3MmUu6c7CYGb0BL1qI1ihFkUjrNIqs+u0X+JNPPcf8K
         CNltstiWRpA9oslfdeoGCm2y2RnZBsoHWcqgmfeRmdrILCKo6/+kaX0OaTGMMGy8/2ym
         /h5jSMXiWp/Ax68PvSBQFm45XDd16OS1Tc2elMZ80g05/f6UKDnsJ8oymQm9YNtvQE4K
         x/7adFUbNn0mXNLiUEqdZJckvAsWNnXNN9t7jPP/YQpqjfbnHeen0GNg8EB3x7ElJL1k
         4UXg==
X-Forwarded-Encrypted: i=1; AJvYcCXvk4vuJg0kUoGTeUFga2C7qDrnT3Pfrow/TCCaqjDMg9BTE1skcfX0oLTwKijviYGMW4Bg/mZaLGwTK1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwadYu+rR64lWbr+VX6v+jtWJJsjKCL91ythN6fK9iyZ25N0gE3
	sny9nsC8475smHAklkBblt64xVzpK5HWJLi1lTDvTefDtp6R7BaYtOfs+4Z+SRlDgI6r5hw1ALc
	d1pDa9O5n5NssosYUcrzt08N9wBJX+J1zwDfAk2ef1QggoueK7V6xBDseLmUh3A==
X-Received: by 2002:a05:6402:3547:b0:5cf:3de5:bca4 with SMTP id 4fb4d7f45d1cf-5cf3de5bd9cmr4049387a12.3.1731351087519;
        Mon, 11 Nov 2024 10:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPU9LxV7uIQIC4DyaRXESg9B6B8I+37/6oh9tli56IPfbf0uFpOypDUyt7degzpr18gdG9zQ==
X-Received: by 2002:a05:6402:3547:b0:5cf:3de5:bca4 with SMTP id 4fb4d7f45d1cf-5cf3de5bd9cmr4049366a12.3.1731351087054;
        Mon, 11 Nov 2024 10:51:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b7e7absm5415421a12.19.2024.11.11.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:51:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0D2EC164CCA2; Mon, 11 Nov 2024 19:51:24 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
In-Reply-To: <4564c77b-a54d-4307-b043-d08e314c4c5f@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org>
 <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
 <4564c77b-a54d-4307-b043-d08e314c4c5f@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Nov 2024 19:51:24 +0100
Message-ID: <87ldxp4n9v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2024/10/26 15:33, Yunsheng Lin wrote:
>
> ...
>
>>>>
>>>> AFAIU Jakub's comment on his RFC patch for waiting, he was suggesting
>>>> exactly this: Add the wait, and see if the cases where it can stall turn
>>>> out to be problems in practice.
>>>
>>> +1
>>>
>>> I like Jakub's approach.
>> 
>> As mentioned in Toke's comment, I am still not convinced that there is some
>> easy way of waiting here, doing the kick in the kernel space is hard enough,
>> I am not even sure if kick need to be done or how it can be done in the user
>> space if some page_pool owned page is held from user space for the cases of zero
>> rx copy, io_uring and devmem tcp? killing the userspace app?
>> 
>> If you and Toke still think the waiting is the way out for the problem here, maybe
>> we should wait for jakub's opinion and let him decide if he want to proceed with
>> his waiting patch.
>
> Is there any other suggestion/concern about how to fix the problem here?
>
> From the previous discussion, it seems the main concern about tracking the
> inflight pages is about how many inflight pages it is needed.

Yeah, my hardest objection was against putting a hard limit on the
number of outstanding pages.

> If there is no other suggestion/concern , it seems the above concern might be
> addressed by using pre-allocated memory to satisfy the mostly used case, and
> use the dynamically allocated memory if/when necessary.

For this, my biggest concern would be performance.

In general, doing extra work in rarely used code paths (such as device
teardown) is much preferred to adding extra tracking in the fast path.
Which would be an argument for Alexander's suggestion of just scanning
the entire system page table to find pages to unmap. Don't know enough
about mm system internals to have an opinion on whether this is
feasible, though.

In any case, we'll need some numbers to really judge the overhead in
practice. So benchmarking would be the logical next step in any case :)

-Toke


