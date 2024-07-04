Return-Path: <linux-kernel+bounces-241259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5B8927920
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4D31F24C23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1431AED4D;
	Thu,  4 Jul 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPxAdgDx"
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED615491
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104403; cv=none; b=EvdSnDRKlb2ZHgfw+s1i4PILf/3TllGaQFUkWVFHW7BhJ232fQ5SrUnZ9Hso3TfWqETt4aOxAF/F5zaSx9DxBw1f5WZUWcB6eXmyJujOIA/436xuIxOWa7XpFbrdSIMWlLtXU5knpKaDx1yepPs6nhqcWIL3tEKDFt7M4EKcPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104403; c=relaxed/simple;
	bh=2/IgjV6ddwK2/2EGwMX/wecagPQI7cWCL7ScRUtsf/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEuFvTtiszsD//ctl1NOUgF5YsNPcLV5BkkP/M//UVCpKK605FdSDZd/WIUNc19ja+yU+Z2MRjRsAWfgvuWY7Vru4XrRd0gT5NMwIkiJdgJ8sSH2Mxxj/P2dE2xaKo0ZX4tvjgEprMOvYWERzThOXWwVNu2LXl4bBrv++XocOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPxAdgDx; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-7f624e70870so41595939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720104401; x=1720709201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovAGVS3VHRPu/ayJ7OgBZYBcLdsO3egzdp3KRf/I5wo=;
        b=kPxAdgDxJ1H57Gz8gzTEEPmOUjhC6DIuBCmMdoeEWT6aBK4Mz5GrDd+Nhb7dIMQTam
         087Ji0FExYU+Asi3zVSg7+3MeFgQHvXjFQmUpVP4nwbjBN1Nq7zHNk9yatyEhqaGcDAc
         YE89p/mnA9ZMOW+E2AhCRyhMDpWs4s1Mk+9/hjNy+/bPN2R3CZPIErR0ro6L0gOw7lR3
         AVMIEf40lb0M8bVQUaCpIUDBrIgA7rr+S66gS5zpWUV2u3zR891AgLChHoTGs8h/DvsX
         t5MG6v9VeVjPTN2885w6r1Ra1mMzmPp2aoHryBb4AWKcXbGGQj7ZDDIUDW2545gJjYm5
         9WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104401; x=1720709201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovAGVS3VHRPu/ayJ7OgBZYBcLdsO3egzdp3KRf/I5wo=;
        b=ndJdcnYhvTSroLUhRLusZ7xj3xdSPBmyEHSzHSBTlUo3xYkF25hu4nSATrqUcE3pK6
         asiVdAfQScF6yf9La1ShunMR6rzOnD64wAgpKalMGb6if2ZTCz0PfVrvokMjgtg7mZbm
         sa8QJRJtQ3GJg2utg0iYFgBIWFQfxcUX+0kS5I8FuSq6vsKWdV8j6kx7U/0Ux2hYWIv9
         zgxoWpklhNm6lQBE3SkX1B7N9ooMIjRbgHpiK91ugiAwtHl3ZxS8ANPemv4xNXNFmFw2
         fd7N5yPNa2MCFgBg0eN0fiCYaNjywxPxhwd4Hv6I92xkdMGmZ7PcxfBnvGX10OHS8LNQ
         OfGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDqkxXeVYwmGJ9G2LOVqwLjgX11Z6Mk9g24Bd4uH9oQpQeojaH5CkTKfIeO8vtPS4tpWl7tTlMYyiWNT0JleI1NW5m/mnPYg6jmvUu
X-Gm-Message-State: AOJu0YxqV5lUv8GlOUASLLodn4o2gvz9BqqAr46O5gsyVOzGgfccvSo/
	VayQ9HzX+S6wf6vXaxJaKHDeI41eCmXNfV4RIxrVAM+lXoNvMwKt
X-Google-Smtp-Source: AGHT+IFdC1bMPgh1nTtndsMYHB4W0rmDbASqI2lZOfJfEaAmurqWXB3XbObe/2fTuuwrn3LykuqoYQ==
X-Received: by 2002:a05:6602:e43:b0:7f6:200a:ba8c with SMTP id ca18e2360f4ac-7f66de8c749mr238274939f.1.1720104400628;
        Thu, 04 Jul 2024 07:46:40 -0700 (PDT)
Received: from [192.168.3.24] ([36.24.57.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256af87sm12319914b3a.70.2024.07.04.07.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:46:40 -0700 (PDT)
Message-ID: <a3910f60-6e2e-4ede-b3f3-47d8dfe9f23b@gmail.com>
Date: Thu, 4 Jul 2024 22:46:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: shmem: add mTHP support for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <65796c1e72e51e15f3410195b5c2d5b6c160d411.1718090413.git.baolin.wang@linux.alibaba.com>
 <65c37315-2741-481f-b433-cec35ef1af35@arm.com>
 <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
Content-Language: en-US
From: Bang Li <libang.linux@gmail.com>
In-Reply-To: <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bao lin,

On 2024/7/4 19:15, Baolin Wang wrote:
>
>>> +
>>> +    /*
>>> +     * Only allow inherit orders if the top-level value is 'force', 
>>> which
>>> +     * means non-PMD sized THP can not override 'huge' mount option 
>>> now.
>>> +     */
>>> +    if (shmem_huge == SHMEM_HUGE_FORCE)
>>> +        return READ_ONCE(huge_shmem_orders_inherit);
>>
>> I vaguely recall that we originally discussed that trying to set 
>> 'force' on the
>> top level control while any per-size controls were set to 'inherit' 
>> would be an
>> error, and trying to set 'force' on any per-size control except the 
>> PMD-size
>> would be an error?
>
> Right.
>
>> I don't really understand this logic. Shouldn't we just be looking at 
>> the
>> per-size control settings (or the top-level control as a proxy for every
>> per-size control that has 'inherit' set)?
>
> ‘force’ will apply the huge orders for anon shmem and tmpfs, so now we 
> only allow pmd-mapped THP to be forced. We should not look at per-size 
> control settings for tmpfs now (mTHP for tmpfs will be discussed in 
> future).
>
>>
>> Then for tmpfs, which doesn't support non-PMD-sizes yet, we just 
>> always use the
>> PMD-size control for decisions.
>>
>> I'm also really struggling with the concept of shmem_is_huge() 
>> existing along
>> side shmem_allowable_huge_orders(). Surely this needs to all be 
>> refactored into
>> shmem_allowable_huge_orders()?
>
> I understood. But now they serve different purposes: shmem_is_huge() 
> will be used to check the huge orders for the top level, for *tmpfs* 
> and anon shmem; whereas shmem_allowable_huge_orders() will only be 
> used to check the per-size huge orders for anon shmem (excluding tmpfs 
> now). However, as I plan to add mTHP support for tmpfs, I think we can 
> perform some cleanups. 

Please count me in, I'd be happy to contribute to the cleanup and 
enhancement
process if I can.

Thanks,
Bang


