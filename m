Return-Path: <linux-kernel+bounces-385443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807DE9B373E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A282859C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375F91DEFFC;
	Mon, 28 Oct 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTb6l7VZ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFD1DED4C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134841; cv=none; b=IkilECSoFqCsPvCLZQ/6+18cmuN1YaJOPqHIy5DNFvyI/4Bgjehz6Y2YCmk9pM6C7K5vTvFSgQ3oT+TVmv5+DoRqvB6qgdOPkUiimcuRaZTC9Yp+6pwPS+S3KY2NlFhyAbOUQ8n4liZMpwuYCKEUSlzt1suRcQLXqNu9kQ5tVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134841; c=relaxed/simple;
	bh=9nqdjvS4IiBcLvntUXIA2w0IPX22ISXj6zmND97upE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScYae90ogSRbFX44pui2IxecJ4v+K773Y3vNtK6sk6jA6aB/iJbQkN7eRlRm3kD5dzsJAu2fylEfw9Sf6qs6saXSBccyzJCOU+HVrtzMwU74r3ca923kQc5pg99XwShyIyYNZhcVSmT0oFTeurjwmWR4uvTJQoLNUvbFBdIGxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTb6l7VZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a156513a1so709493566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730134838; x=1730739638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrjMaXXj+jfgf+DVrhrW4u7B5OhsmwVqgofVaVRB/SQ=;
        b=cTb6l7VZ5KI1vV95eC+Pfjir9Y1pyDz+t1kexHy9rp8nJVa5Mpj9Q0UU2JxJE/cQHB
         s9bTZ0mOU3Yniucr1vSn4Wqh6ZGTnOBUmKay3qNdzabQn63v63WdxzPqm32jNdesM+6a
         IKyALEnvWVToP8eHRbWn8rdIpJWK6crpKpGnrKfWWMz9rByD/p3qcMwJ5fxzSls7om2h
         u32UeVjGumDdk2JOoJaFDng5+ASwpdNZf1/qfEfdtXtVf5I8LgvEq/qU3j5iBV1/ZdOH
         ThjQWLYhqsGVHNOssVAJXlfKddXNkicvEtyoupGoAqn5V6crJ6OAJ5PCJLt4pi4a4aX+
         6SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730134838; x=1730739638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrjMaXXj+jfgf+DVrhrW4u7B5OhsmwVqgofVaVRB/SQ=;
        b=ChHr3nIsoThUWCc5TP7YBKMp5QO51LR7xbh3vGcCSoiIkR3HzZjpVzsNx92/okshqX
         sr8hhzN3TibPeG5QtGkoKdHa6O+qEymAH6lMpJ3p5Dbw0b5qDzJfqrJJMTLcKK7bZbqN
         jBBeqMVoATPhYXUmOpAzfYaHoi+z7WPJxshwCgpbiRUOkjBw5bfL3Cay7Vi6RtHpQLBy
         vVZpancr9uzw1W6rXHPTEnywsDzUzrZMNDQ+hPiyM7DPhDQSDUCmAz/3AqBQoL4xKwwx
         tYuAKbdln+r7lBgWKwv1jS5zvIIYny5KlfOkpU/FcTyK93oXS/ip0sU7XU3dJfvOqmXF
         TG1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjKNDUvce7I+m2fC4ovhLpioV4q5Jz2nX2MRBX4n3UliWVkPvpoXgupnPY2jRAyAs8W8MOWcK3cvbG00Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4KZ7dlsXADIjIc+L70nbPY5G7g36h4b1KRwZB9r4aWE3y4Xk
	Xoiu8nNSwDGZBAabw1RhLfbfBgzzzOmbH8wVjgj55eQGl3uQ+s+a
X-Google-Smtp-Source: AGHT+IEzF2HF0Gq0YJoKVyANSwRvB4fbgapxGgOP0KpiaPUyyvV+ZQPVLjnBVS8Z/Igqo+lFTvOkmg==
X-Received: by 2002:a17:907:7d88:b0:a9a:c57f:9634 with SMTP id a640c23a62f3a-a9de61d1a97mr812510366b.42.1730134837616;
        Mon, 28 Oct 2024 10:00:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:1494])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1e0b2400sm392018866b.45.2024.10.28.10.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:00:37 -0700 (PDT)
Message-ID: <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com>
Date: Mon, 28 Oct 2024 17:00:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Nhat Pham <nphamcs@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
References: <20241027011959.9226-1-21cnbao@gmail.com>
 <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com>
 <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/10/2024 16:33, Nhat Pham wrote:
> On Mon, Oct 28, 2024 at 5:23 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> I wonder if instead of having counters, it might be better to keep track
>> of the number of zeropages currently stored in zeromap, similar to how
>> zswap_same_filled_pages did it. It will be more complicated then this
>> patch, but would give more insight of the current state of the system.
>>
>> Joshua (in CC) was going to have a look at that.
> 
> I don't think one can substitute for the other.

Yes agreed, they have separate uses and provide different information, but
maybe wasteful to have both types of counters? They are counters so maybe
dont consume too much resources but I think we should still think about
it..

If you think from a production context, I feel like the number of pages
currently in zeromap could be more useful than just accumulation of all
zeromap loads/stores, which after days is just going to be a very large
number. You can compare the accumulations at different points in time,
but they dont take into account freeing swap slots and swap_reclaim.

If we are open to having both types then its ok. But might be good to
have that discussion here.

> 
> The "current zeromapped page" counter gives you a breakdown of where
> memory resides, whereas the in/out counters explain past performance
> based on events that have happened. That's why you have zswap,
> zswapped, zswpout, zswpin.



