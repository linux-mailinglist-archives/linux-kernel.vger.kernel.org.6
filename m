Return-Path: <linux-kernel+bounces-297249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EE795B4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526201C20C38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BF51C943E;
	Thu, 22 Aug 2024 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="atqG6hv0"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7916A940
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329368; cv=none; b=kd82+zr22SKmXtIY1LWABl9oIIxcrAxJlo49fGPaJ7KpJqYKGFCStiLz1o9wWF04dNBX1lVnVwZ+CZymNilMEfdYeA40NU1U/Wa6qwP0dk89Clk6qsnQcdTO60VBECaVTw8armggRSyhoQWptoFtKfM8FtVDqD4PWagih+uc1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329368; c=relaxed/simple;
	bh=ntAb52+IcjrxcCd9AnyHX/dzRiXg5jroKOmye09Xzcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ix9P+YYhpK3jZhKcRmhe4wtINAmQvGgX3U5ZS1wTrbW9++QmU7UhaDdjuUlVQZzxJTM//vHLSEhqqyz/am13b67KqxyfSaW2RNCQQJykih6L1tPa5d3kWh6yLlaLOeLCkXeFOzOdgRg9vUqiRXMvzSYdw430wP2NVr64pLFbkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=atqG6hv0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7143ae1b48fso250938b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724329366; x=1724934166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIwgebdH51yKuSjq8P43yv3p3Sz45IN9GInZ+H0UIGw=;
        b=atqG6hv0tPrpkugzDM89J08q4YJGsiJo/4zlMCIH2R4FTuZhzhokqZJYZz1DbyTFKh
         d9fmgvRdaYUF/jCt7WfO0cXCwDzszXYmBuNQJpu44YWZrqHGP16hiSROhk6VNz/nj3QM
         08bSny0IXG2/Fxbb84H6jhxZ+R4QPalZX7TC5DJI7sJ1d08hNasbI78VEBQ+NjUmns60
         dxyhIR7Pr6HOPth8Q9njQFoKCs+C/qowboTexLCQ4U2B9c8YqTKAQ9IhOyQdG9fvSWvO
         IZi0jmqVFBtPu+uBvFvDodO02Or/CXoiaExltwxYfBKLs2eVfGlKgWFFAbPqLoxVecYw
         xCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724329366; x=1724934166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIwgebdH51yKuSjq8P43yv3p3Sz45IN9GInZ+H0UIGw=;
        b=RY2lNQ4c6EowvVc5e2udjGRatkkwGGAneMgcZk1T8icNamLPOluHzmR4+39KYOiHqP
         d3JxGLc65KTvTgEpn6jouxlcq6fmCCmBqK4fNHUNrjP4vSRsXFKesKTNIfvz1bQVG9UM
         h0PbF0VqSMLJO4Zlg7p2clLPdhtoHZkyOtXmwNAyOh8aXPH0/hXAJ8E+CqAB/VzXTIWj
         eUycpMNtvcWDoazz30I+5GRem7V4Rg3pahZCqGpXMMembOAZ6koAzKCevmV50yGjbmal
         1S47GRvNxFWfGGCFT/u6uWkm7AznGrNjsSrr3qHCndWvNutVzUb/LhRsfHKJMZkHJEM0
         uNCg==
X-Forwarded-Encrypted: i=1; AJvYcCXqsBD6GF0/zhDZ4svisxjyKMx5gUIprlheN4egDFt1wCHJZBuxlBEZIRtY8zn7zgnYt/FTI4POSUc2Wxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMgtfwywSvCpd1Ct25YBc0bqdlkJZXcJJ80JcGEP9oNIPHOVbJ
	RaX7eIPnqHRqr4oQnIYrn/fxvc/LO01bJOzwKvrzq9J7bD48p7VrlZPn8ifhRUk=
X-Google-Smtp-Source: AGHT+IEHSce2yik5ch9+ibHBlKnOikhH85uimhD6rYu5vvuVwwprOpDF1vUeRBo9cEYE2Tjb138rnA==
X-Received: by 2002:a05:6a21:a4c1:b0:1c8:95c9:307c with SMTP id adf61e73a8af0-1caeb250138mr1625404637.28.1724329365986;
        Thu, 22 Aug 2024 05:22:45 -0700 (PDT)
Received: from [10.255.182.243] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422eda4sm1259383b3a.35.2024.08.22.05.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 05:22:45 -0700 (PDT)
Message-ID: <7e83f87b-703b-4f7c-9d42-78845acb41c6@bytedance.com>
Date: Thu, 22 Aug 2024 20:22:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] mm: handle_pte_fault() use
 pte_offset_map_maywrite_nolock()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "vbabka@kernel.org" <vbabka@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
 <239432a0bc56464e58a6baf3622fdc72526c8d57.1724226076.git.zhengqi.arch@bytedance.com>
 <6a586524-5116-4eaf-b4f3-c1aea290d7c1@cs-soprasteria.com>
 <b4bf605a-d31a-40ad-8cee-fe505e45dc64@bytedance.com>
 <4b867535-8481-4fa1-bed1-ad25a76682f0@redhat.com>
 <ef40c2ef-e4a4-4b02-85b8-a930285a3d0e@bytedance.com>
 <61c05197-0baa-4680-ad24-5965ba37dc35@redhat.com>
 <83142dc8-edcf-4e47-8215-8b359a2b7156@bytedance.com>
 <04dccff9-87dd-4e97-a712-b62fa51b32f7@redhat.com>
 <da7aa8d2-098c-431b-86d0-b817981a9a5f@bytedance.com>
 <38d6caeb-1aba-43d2-8daf-12b9aaba77bd@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <38d6caeb-1aba-43d2-8daf-12b9aaba77bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/22 20:19, David Hildenbrand wrote:
> On 22.08.24 14:17, Qi Zheng wrote:
>> Hi David,
>>
>> On 2024/8/22 17:29, David Hildenbrand wrote:
>>> On 21.08.24 12:03, Qi Zheng wrote:
>>>>
>>>>
>>
>> [...]
>>
>>>>>>>>>> -        vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm,
>>>>>>>>>> vmf->pmd,
>>>>>>>>>> -                         vmf->address, &vmf->ptl);
>>>>>>>>>> +        vmf->pte = 
>>>>>>>>>> pte_offset_map_maywrite_nolock(vmf->vma->vm_mm,
>>>>>>>>>> +                              vmf->pmd, vmf->address,
>>>>>>>>>> +                              NULL, &vmf->ptl);
>>>>>>>
>>>>>>> I think we discussed that passing NULL should be forbidden for that
>>>>>>> function.
>>>>>>
>>>>>> Yes, but for some maywrite case, there is no need to get pmdval to
>>>>>> do pmd_same() check. So I passed NULL and added a comment to
>>>>>> explain this.
>>>>>
>>>>> I wonder if it's better to pass a dummy variable instead. One has to
>>>>> think harder why that is required compared to blindly passing 
>>>>> "NULL" :)
>>>>
>>>> You are afraid that subsequent caller will abuse this function, right?
>>>
>>> Yes! "oh, I don't need a pmdval, why would I? let's just pass NULL,
>>> easy" :)
>>>
>>>> My initial concern was that this would add a useless local vaiable, but
>>>> perhaps that is not a big deal.
>>>
>>> How many of these "special" instances do we have?
>>
>> We have 5 such special instances.
>>
>>>
>>>>
>>>> Both are fine for me. ;)
>>>
>>> Also no strong opinion, but having to pass a variable makes you think
>>> what you are supposed to do with it and why it is not optional.
>>
>> Yeah, I added 'BUG_ON(!pmdvalp);' in pte_offset_map_ro_nolock(), and
>> have updated the v2 version [1].
> 
> No BUG_ON please :) VM_WARN_ON_ONCE() is good enough.

Got it. Will do in the next version.

> 

