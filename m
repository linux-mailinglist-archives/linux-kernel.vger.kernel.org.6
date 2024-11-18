Return-Path: <linux-kernel+bounces-413031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8929D1284
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FC21F230E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA68819E83C;
	Mon, 18 Nov 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCOzXL+f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB41199253
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938306; cv=none; b=VVv0C/a+qI5/V2ecf7pdtzAVg5uySyZ8Lzsoej56CHpj4iio8Yf/1w3OLifFbDhcHJu5AS55F2XFz2R77n7bkkdlMp+QhmA4WXvZWcTlQ8gvAEZM9Ov2XCxRpRKVeMy+MAxlugRuSnX6ZcbG1cJJLxHNwdVt3QyQyyzW+l3ilII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938306; c=relaxed/simple;
	bh=UiU/qtJW4f9XJc/dQnT7DENCuscjm2Y3iOhArlBgCzc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kThl2hgkYydb5/QhaXZc9jkWGUiDgeOLKzgOIJlMAg7v1fGThfz3S7VRJqa1npGOUCk6Ia7/82rCjkUUfBZCfZnnh8wAuzxiRMqlq5u7aKA/SJ5ePvyDqis/b1xaV/tPdtWv1oYmf735Sbg8fh17ajPiM/FnizJLejSNm3xqK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCOzXL+f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731938303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MV9t7PeyS5fNDfqXNOqFnhhI7vbfFrtvKXlM5jfsTc=;
	b=OCOzXL+fImhH17RW19XIn6LauU9uZniRngeZ+XtYHQMwKt9nwSZ+p18U7AMA2Gb2m2BFA/
	mZjtlGIGy1HD/cxeQTjZPa390sCo2YdJsLsncT//zGUqUPuWs/cxD87BEVeRsTGA63e6jU
	B7/TqTxTZJJXHh2kMIm3awiZFlfIMeY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-e2Xay_7ONHKSOyG5PTOtJQ-1; Mon, 18 Nov 2024 08:58:22 -0500
X-MC-Unique: e2Xay_7ONHKSOyG5PTOtJQ-1
X-Mimecast-MFC-AGG-ID: e2Xay_7ONHKSOyG5PTOtJQ
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b31ccf23ebso343519385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731938301; x=1732543101;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MV9t7PeyS5fNDfqXNOqFnhhI7vbfFrtvKXlM5jfsTc=;
        b=Fl+COWjUDbl9ivHybA/LZHp5OFKwWVdx+xlO98nq2xYnRKtCv6et0YjmXOk8AK+bE2
         tL4P3sI8VZvzmG3eZRVsFch96zVfis/mdBS/3PXetPt4CCLWIHROV0+WGOG2AA3MHyH9
         uCYExpbV5NDLtSofasY3LIRMGXptPrJNd4mKw4nxCNiWXJohhwCuihaFyUn1qLYMdjZn
         Ct1ZLkd/imnl0nW/26c5CIn32o1iDlgN7u5uSBLEiB1NbqF57hj0vEeEv1U8u6PoaPXv
         wgYPgLGSpoO0Fr/U/cUrynYcZR9Ao5NnowRyWA2tHMojPQe749TbQBcZL8B6QXsrrhtS
         eqBw==
X-Forwarded-Encrypted: i=1; AJvYcCWGv4t6icJuvkik+i5XKFWzF3+hfoF5+A4nAyMBsdv/VU2TVQ/8TzWTp429an19AKClYNMVaaFskAJ4/xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlTyKcBpIyMe4kUqDa3+3TbscpRVEeXycocJZNOrZfc0P9F/k
	iP+ZPETmvu+k4Zt+/uTX5zqKryCuOsvuL/NYBY1184NI2a2duwqQ9S3GrBWjQoRhA1d5d9dkDWG
	KWVlMmoIiQz5MIG75C07FLMw1oYnedjYeKF+2WDdySG/rFuJ2CYWdZ29LgTcgv93rGyUzjQ==
X-Received: by 2002:a05:620a:440a:b0:7ac:e30e:f6f with SMTP id af79cd13be357-7b36235bbb9mr1865985585a.43.1731938301358;
        Mon, 18 Nov 2024 05:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg8zld4k6YPeW4BIJQGymHWq+9Oz05egcq1pXqCLPnt9QIgQqJxwWe9aQ3E+6DdEczTLGLTg==
X-Received: by 2002:a05:620a:440a:b0:7ac:e30e:f6f with SMTP id af79cd13be357-7b36235bbb9mr1865983785a.43.1731938301103;
        Mon, 18 Nov 2024 05:58:21 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984557sm483231885a.10.2024.11.18.05.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 05:58:20 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5a878687-9d08-472e-a387-02b2a150d2df@redhat.com>
Date: Mon, 18 Nov 2024 08:58:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20241114181915.142894-1-longman@redhat.com>
 <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
 <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>
 <ZzsLTLEAPMljtaIK@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <ZzsLTLEAPMljtaIK@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/18/24 4:39 AM, Juri Lelli wrote:
> On 15/11/24 12:55, Waiman Long wrote:
>> On 11/15/24 5:54 AM, Juri Lelli wrote:
>>> Hi Waiman,
>>>
>>> On 14/11/24 13:19, Waiman Long wrote:
>>>> With some recent proposed changes [1] in the deadline server code,
>>>> it has caused a test failure in test_cpuset_prs.sh when a change
>>>> is being made to an isolated partition. This is due to failing
>>>> the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
>>>> validate_change().
>>> What sort of change is being made to that isolated partition? Which test
>>> is failing from the test_cpuset_prs.sh collection? Asking because I now
>>> see "All tests PASSED" running that locally (with all my 3 patches on
>>> top of cgroup/for-6.13 w/o this last patch from you).
>> The failing test isn't an isolated partition. The actual test failure is
>>
>> Test TEST_MATRIX[62] failed result check!
>> C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 . . X5 . . 0 A1:0-4,A2:1-4,A3:2-4
>> A1:P0,A2:P-2,A3:P-1
>>
>> In this particular case, cgroup A3 has the following setting before the X5
>> operation.
>>
>> A1/A2/A3/cpuset.cpus: 2-4
>> A1/A2/A3/cpuset.cpus.exclusive: 4
>> A1/A2/A3/cpuset.cpus.effective: 4
>> A1/A2/A3/cpuset.cpus.exclusive.effective: 4
>> A1/A2/A3/cpuset.cpus.partition: root
> Right, and is this problematic already?
We allow nested partition setup. So there can be a child partition 
underneath a parent partition. So this is OK.
>
> Then the test, I believe, does
>
> # echo 5 >cgroup/A1/A2/cpuset.cpus.exclusive
>
> and that goes through and makes the setup invalid - root domain reconf
> and the following
>
> # cat cgroup/A1/cpuset.cpus.partition
> member
> # cat cgroup/A1/A2/cpuset.cpus.partition
> isolated invalid (Parent is not a partition root)
> # cat cgroup/A1/A2/A3/cpuset.cpus.partition
> root invalid (Parent is an invalid partition root)
>
> Is this what shouldn't happen?
>
A3 should become invalid because none of the CPUs in 
cpuset.cpus.exclusive can be granted. However A2 should remain a valid 
partition. I will look further into that. Thank for spotting this 
inconsistency.

Cheers,
Longman


