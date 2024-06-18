Return-Path: <linux-kernel+bounces-218814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 638BB90C675
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154891F21E67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CAE1891B5;
	Tue, 18 Jun 2024 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XWnnQRwe"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C38E13A245
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697120; cv=none; b=a5HT/WKtRhDyrrZhA4xBiC3G7Ho+wmzTROrKhlIDLuzZ8mCaJpoGz+zRYbkVH1UW79oBphTNmf5KKsh5BtZBqHpy7fc2IRD9tNxgXT3Tl7f4pmEvh+MaglwKs4XbrwFdQlTph+iJXTjtoO/8zm8AHf/oILnqHLobYdVFYJp0gzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697120; c=relaxed/simple;
	bh=Vwgt4pg+p9BNy7bSJ48m938RkAuQ2WGdPBjL3XpYsmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbqLota7gf6dm6XWXxdwgusnRd0j34HAxtQPAUumJCdKSRK5I7jbpvkR7JSKFTRBAsa0m81NW3NOL6uv9lPbadY33vYr+7IajgnqkHdeMshkQtMZMexcQNr0hkKqKTIqLzuYAEVzPyHQwGWz9MN/G90FRy/CTpd8Xv61/ovZEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XWnnQRwe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-64ecc2f111dso435162a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718697117; x=1719301917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76HALR93jYK/Zg0pajod2zJyiG6SBoSONeMtyfEqbMs=;
        b=XWnnQRweA3fmMIwik4bm7bwVSIarFBa9QZBbMctFFhskHdpsXqvct94IBzIi/06noB
         KHWnwvxyd3QDRAJqrEGlC7kAELD3n7bewFioHwXVagrMDGRX81eLoiql/w0Twud7pWYB
         wKH1YTzKpFmjb2UEw4YBvIIkzrapK1eWAnHwCovN+1Lx4VITUtH2mdJU91aUT6qPmkzd
         eiWXHcc9VO9ygI4W9kjb/rAkdv9tEeg/II+GKWoGw3nXZG4OyJnad8oopXF1V8d59fKu
         /76d2YvgaUgDiZSimazFmopJQDL8wV5N6r2w7XPTnzoJiIv6wtmnYRQnjF5p7dVID5M2
         X+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718697117; x=1719301917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76HALR93jYK/Zg0pajod2zJyiG6SBoSONeMtyfEqbMs=;
        b=pd6CT0c1qcvrVlb5/iRjWysmj+Gk9xZ2JuyycCilFnXPbqKvRJRFXuh+jzF26Q3WC+
         5y5qxiqXne1x4mSgnIbD/BzsJcZKny2gv9+tObS6RboyrtSHo3rZynO0QdrFqRos+BAd
         cpg7pQFnhXlBcPk2JCMKR14v896evlO+u+dn74K+f1oRISDRXsxuZs5X83qLDY7c09NL
         pIC0lSalRgEg+xJaHiM8dpB25vCjW5C+q65FJIH3Y50btf0fQs1PBcd0gBoNyoELBTar
         j6dk+afxx5IdrUa+9LbTAMupW9LQHhAhwNhaIGFe1/yDDTvytJZYmLncK5Oh9068lkmQ
         /fVA==
X-Forwarded-Encrypted: i=1; AJvYcCX8wKJp6IZ6CFFCn+1vJz5ZQ7WlCtVRu2dtVfYwmJmnnr9bvRyD2FeElm5e7+GixRKaxUmfZv3gG8ptvtf/7VOfK4QRgJvXbT/QXv2h
X-Gm-Message-State: AOJu0YwD8wE9Qyx8R5xf+g3XMLaJ/0kOa9b7BAivyDjYVWvXs+aOHhii
	AoiMWcPSp/RJDwhTwvj2cJXai+ROpfqChRfbwAbQ8egKKOaMgmw+JFhC/BAvJdx2Gop7vNJ0czT
	X
X-Google-Smtp-Source: AGHT+IEoKrICETtXKPz5g2VWzCsFEiGGFStEZKqestgQsuAKki+NR8fDw0zQ/kujUUyCVexn0Tunqw==
X-Received: by 2002:a05:6a21:6da3:b0:1af:d9a3:f3a3 with SMTP id adf61e73a8af0-1bae8253a95mr12479218637.4.1718697117205;
        Tue, 18 Jun 2024 00:51:57 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8d9a1sm8434984b3a.186.2024.06.18.00.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:51:56 -0700 (PDT)
Message-ID: <025ea89a-bb94-4f60-b6ad-d8b88d3cfc60@bytedance.com>
Date: Tue, 18 Jun 2024 15:51:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] asynchronously scan and free empty user PTE pages
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718267194.git.zhengqi.arch@bytedance.com>
 <02f8cbd0-8b2b-4c2d-ad96-f854d25bf3c2@redhat.com>
 <efac94f6-2fb3-4682-a894-7c8ffac18d20@bytedance.com>
 <2cda0af6-8fde-4093-b615-7979744d6898@redhat.com>
 <aadae460-3797-4d10-a380-5d4fe8189e20@bytedance.com>
 <aaf9a7d7-647f-41bf-91b4-e362ff5df6b0@redhat.com>
 <f2fbf466-f722-4fd3-9883-189145e599f4@bytedance.com>
 <86b29391-ad2a-4c4b-b9a8-974d1876632c@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <86b29391-ad2a-4c4b-b9a8-974d1876632c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/6/18 01:49, David Hildenbrand wrote:
> 
>>>
>>> No strong opinion, something synchronous sounds to me like the
>>> low-hanging fruit, that could add the infrastructure to be used by
>>> something more advanced/synchronously :)
>>
>> Got it, I will try to do the following in the next version.
>>
>> a. for MADV_DONTNEED case, try synchronous reclaim as you said
>>
> 
> I think that really is the low hanging fruit that would cover quite some 
> cases already: (1) reclaim when MADV_DONTNEED spans the complete page 
> table.

I will check and free the PTE page in the zap_pte_range() if the
(end - addr >= PMD_SIZE) condition is met.

> 
> Then, there is (2) reclaim when MADV_DONTNEED spans only part of the 
> page table (e.g., single PTE), but my best guess is that it's better to 
> scan for that asynchronously than making possibly each MADV_DONTNEED 
> sycall invocation slower.

Maybe just mark the vma, and then scan it in the system reclaim path.

I also plan to do this in the MADV_FREE case, instead of adding an
asynchronous madvise option first.

> 
> (1) would already help a lot and showcase how the locking/machinery 
> would work.
> 
> 
>> b. for MADV_FREE case:
>>
>>     - add a madvise option for synchronous reclaim
>>
>>     - add another madvise option to mark the vma, then add its
>>             corresponding mm to a global list, and then traverse
>>             the list and reclaim it when the memory is tight and
>>             enters the system reclaim path.
>>             (maybe there is an option to unmark)
>>
>> c. for s390 case you mentioned, create a CONFIG_FREE_PT first, and
>>      then s390 will not select this config until the problem is solved.
>>
>> d. for lockless scan, try using disabling IRQ or (mmap read lock +
>> pte_offset_map_nolock).
> 
> Although d) really only is desired when scanning asynchronously I think. 
> During (1) above, we know that the table will be very likely empty 
> (unless weird race).

Agree.

Thanks,
Qi

> 

