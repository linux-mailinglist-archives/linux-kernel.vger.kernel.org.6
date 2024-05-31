Return-Path: <linux-kernel+bounces-196998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F58D64BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8946C1C236E7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6D256B72;
	Fri, 31 May 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ96qm9R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B141C69
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166621; cv=none; b=JHFzuha0an0/I/N9aQk8l0tumqB/W7dU+XNFaDpQYUy55iFfv8U8u5MseloIOJrccFQrcB8/hD0mXuo0AK4QH3SpU3+0NCPuEg6locrE6YMzLPhJSJ6KL/29YRg0VA1/93b6WubGyNgiKGkHGlBjmRmEuuA5vaS1zlLHJb2pFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166621; c=relaxed/simple;
	bh=YFA/fpE2FqtCUp+xAa/4CGzWGoLjo+G1Tiz2ljVAA3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MD7noelXwcslKxeVTNn8jZfGAzR2HQSPfh5EeAHODFMZAH0Zpgq0PbOk5TK8de79/a8hI+p8aIHX5pCqyL8zP/ZxmCmvuqxYnwqSb3k5O3x7cCXVhgNOlp8e7bthXTfbBoVvtOhFG/t7w9ZIDQCq60EqErDFZjCvhdwg/+agxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQ96qm9R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717166618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h7BCmuVT8wXxARstYW4zJweVRBuV08WhpIAYAR0E5iQ=;
	b=LQ96qm9RC0weXuK3xj4AgPT70b8tH46/tqtkJs6UEKPZJrF72urpjQJJpENXMFROtImLxx
	N6NWlXT/XzB7TqHRllUqcu03noMNx+rP9xqECj9XEv55D2mLSkEu41h8vtMOr3tgYbtTTK
	dK+uKV0c0tpUununCR05rL6U4uXCwKw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-gRQwkQ1xM32EqvDbo8nbuA-1; Fri, 31 May 2024 10:43:36 -0400
X-MC-Unique: gRQwkQ1xM32EqvDbo8nbuA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42120611b0bso10838905e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166615; x=1717771415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h7BCmuVT8wXxARstYW4zJweVRBuV08WhpIAYAR0E5iQ=;
        b=O21ZVPw5IYW4MEgFpWWPd8zzWg8EVWeNzwsPiVw0PQQU+qK0ZNW2rCaBY1MNWkZDym
         7GIfc6xKLYL500u0T3HZtPUSkIspxVsR40YYrUG2CcG4Z35yEamyeOD5OMBJPA/KDmd9
         66SAnb6pPSRdsV1P5fCo10QTOZQoUXmXx5MRtSQryyogbzeGPQdBCUIwJag1gXku+cjv
         QOfg4AHk/0IwdTW/R6/YoLX9iCeSoIaKmwmiG4p0dQAfFf9FxPjamVXJJeb7CuCeK9jo
         rSuL+mhapsZOCSvs3n59F5Duln0uZJx37RdMjBJj9cI10vWqpcydOKGnsvk9YLQ3ycg/
         phIw==
X-Forwarded-Encrypted: i=1; AJvYcCVUsvwDDq7Lma0ERLt82B2F7anGddjKQY9tKYLz+seNH8FKqHakQncnlvgbGWjeqtwDhLQrwktTvLWSbuWJntZLwWDx0EJ+Kf6loz5k
X-Gm-Message-State: AOJu0Yy9TF3uJlOFsWZ3dBFcqArEzCj0amrmVk/eRTvCIxlgk6mLY+9n
	VwY8IUxA4FPu9BL5rucP92h2NAiz687AMvHVsYGU0412MUU7n5uvbfJ/2Z3e5tJ3TC7FI2PLwuv
	uUWOJ2SXF+XYsPz+o/dCtrx5AaoZk3JC6Nn2yXsMlsbfn9UJ3ZsX7A3tLu1pnxA==
X-Received: by 2002:a05:600c:34d2:b0:421:b39:9ea0 with SMTP id 5b1f17b1804b1-4212e05e489mr18496485e9.16.1717166615481;
        Fri, 31 May 2024 07:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe9KLIh2ab8ePVc03Ii/7E39e1fiMHobofJw1lrKMtFAzRPVsDkLiGfjAhHqrnA18wJDP11A==
X-Received: by 2002:a05:600c:34d2:b0:421:b39:9ea0 with SMTP id 5b1f17b1804b1-4212e05e489mr18496215e9.16.1717166615038;
        Fri, 31 May 2024 07:43:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b84d66bsm27735325e9.12.2024.05.31.07.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:43:34 -0700 (PDT)
Message-ID: <f0618bca-119b-417a-a19d-699084476f88@redhat.com>
Date: Fri, 31 May 2024 16:43:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <CGME20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a@eucas1p2.samsung.com>
 <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
 <vlkkfcyumveggkddb6d44f55gtx4qonoiijxyofa63mtmkuofv@uf4nbw3r5ysh>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <vlkkfcyumveggkddb6d44f55gtx4qonoiijxyofa63mtmkuofv@uf4nbw3r5ysh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

>> Let me summarize the takeaway from the bi-weekly MM meeting as I understood
>> it, that includes Hugh's feedback on per-block tracking vs. mTHP:
> 
> Thanks David for the summary. Please, find below some follow up questions.
> 
> I want understand if zeropage scanning overhead is preferred over per-block
> tracking complexity or if we still need to verify this.
> 
>>
>> (1) Per-block tracking
>>
>> Per-block tracking is currently considered unwarranted complexity in
>> shmem.c. We should try to get it done without that. For any test cases that
>> fail, we should consider if they are actually valid for shmem.
> 
> I agree it was unwarranted complexity but only if this is just to fix lseek() as
> we can simply make the test pass by checking if holes are reported as data. That
> would be the minimum required for lseek() to be compliant with the syscall.
> 
> How can we use per-block tracking for reclaiming memory and what changes would
> be needed? Or is per-block really a non-viable option?

The interesting thing is: with mTHP toggles it is opt-in -- like for 
PMD-sized THP with shmem_enabled -- and we don't have to be that 
concerned about this problem right now.

> 
> Clearly, if per-block is viable option, shmem_fault() bug would required to be
> fixed first. Any ideas on how to make it reproducible?
> 
> The alternatives discussed where sub-page refcounting and zeropage scanning.

Yeah, I don't think sub-page refcounting is a feasible (and certainly 
not desired ;) ) option in the folio world.

> The first one is not possible (IIUC) because of a refactor years back that
> simplified the code and also requires extra complexity. The second option would
> require additional overhead as we would involve scanning.

We'll likely need something similar (scanning, tracking?) for anonymous 
memory as well. There was a proposal for a THP shrinker some time ago, 
that would solve part of the problem.

For example, for shmem you could simply flag folios that failed 
splitting during fallocate() as reclaim candidates and try to reclaim 
memory later. So you don't have to scan arbitrary folios (which might 
also be desired, though).

> 
>>
>> To optimize FALLOC_FL_PUNCH_HOLE for the cases where splitting+freeing
>> is not possible at fallcoate() time, detecting zeropages later and
>> retrying to split+free might be an option, without per-block tracking.
> 
>>
>> (2) mTHP controls
>>
>> As a default, we should not be using large folios / mTHP for any shmem, just
>> like we did with THP via shmem_enabled. This is what this series currently
>> does, and is aprt of the whole mTHP user-space interface design.
> 
> That was clear for me too. But what is the reason we want to boot in 'safe
> mode'? What are the implications of not respecing that?

[...]

> 
> As I understood from the call, mTHP with sysctl knobs is preferred over
> optimistic falloc/write allocation? But is still unclear to me why the former
> is preferred.

I think Hugh's point was that this should be an opt-in feature, just 
like PMD-sized THP started out, and still is, an opt-in feature.

Problematic interaction with khugepaged (that will be fixed) is one 
thing, interaction with memory reclaim (without any kind of memory 
reclaim mechanisms in place) might be another one. Controlling and 
tuning for specific folio sizes might be another one Hugh raised. 
[summarizing what I recall from the discussion, there might be more].

> 
> Is large folios a non-viable option?

I think you mean "allocating large folios without user space control".

Because mTHP gives user space full control, to the point where you can 
enable all sizes and obtain the same result.

> 
>>
>> Also, we should properly fallback within the configured sizes, and not jump
>> "over" configured sizes. Unless there is a good reason.
>>
>> (3) khugepaged
>>
>> khugepaged needs to handle larger folios properly as well. Until fixed,
>> using smaller THP sizes as fallback might prohibit collapsing a PMD-sized
>> THP later. But really, khugepaged needs to be fixed to handle that.
>>
>> (4) force/disable
>>
>> These settings are rather testing artifacts from the old ages. We should not
>> add them to the per-size toggles. We might "inherit" it from the global one,
>> though.
>>
>> "within_size" might have value, and especially for consistency, we should
>> have them per size.
>>
>>
>>
>> So, this series only tackles anonymous shmem, which is a good starting
>> point. Ideally, we'd get support for other shmem (especially during fault
>> time) soon afterwards, because we won't be adding separate toggles for that
>> from the interface POV, and having inconsistent behavior between kernel
>> versions would be a bit unfortunate.
>>
>>
>> @Baolin, this series likely does not consider (4) yet. And I suggest we have
>> to take a lot of the "anonymous thp" terminology out of this series,
>> especially when it comes to documentation.
>>
>> @Daniel, Pankaj, what are your plans regarding that? It would be great if we
>> could get an understanding on the next steps on !anon shmem.
> 
> I realize I've raised so many questions, but it's essential for us to grasp the
> mm concerns and usage scenarios. This understanding will provide clarity on the
> direction regarding folios for !anon shmem.

If I understood correctly, Hugh had strong feelings against not 
respecting mTHP toggles for shmem. Without per-block tracking, I agree 
with that.

-- 
Cheers,

David / dhildenb


