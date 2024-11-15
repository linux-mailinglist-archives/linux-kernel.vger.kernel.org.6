Return-Path: <linux-kernel+bounces-410830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885529CE175
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E33D28358F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D0D1D4355;
	Fri, 15 Nov 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KFFAYoNl"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885E1D434D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681677; cv=none; b=rF6yCiHVW5/3zJfWCKUPAAy5FsEGEbWQc5wXrtlu5uuVokFVeB+aKe6IYxkyTT6Z9UasXH9ABtmmJVBdrDch4gWkGgtbOaSfId7X3FHaizDQkgU0im5nbTzh4jF6teKZ1lDCsMnzFP/QiwfequzUAEZEDF7XPz5EK/AXV8S/Oqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681677; c=relaxed/simple;
	bh=XMTSDfanDaZ7WYPbG6cWpNGScnLpVHLhoodazeCIIXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6oGthh5VVPcV9TwLSBQjntyHlknkmNPYccmSzgi24lYiDCFwttSrZg+nUw53VdrrmzgBwIEMQnjFnd0y6q2vogiJS19hZoFeZ9/mSKPvlAmT7aiXtV5qCSermy2Yl9jNFbNEt3Y5KPlwz2rJMfHLmIxyR2ZinJ6ynbx23YaTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KFFAYoNl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e9ecba5db0so1483321a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731681674; x=1732286474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3Jfhe8hhCGXDldif9Jvrqjsrwf4QgzpQ9EYZSG5+LM=;
        b=KFFAYoNlMfF84lsR3iGGTEZsFD4+oBGx2y5Qk/LHhVCOxG3IbHn29sczXVR2AjtwMR
         gJXQiOL1kEX7njZxwhzHt+vTvluVNeHRXu0F0MTcUj3vzKNCYk1+nYFt2YBXhJVha99r
         PGUeeoPUtdKg4PI1oE3zWzv1/ljPCB5uusyVNOd94hyz08aPC5TErUHAIrd1OmGbMMwo
         5fiKwJIRACWw6Z+xb3gfg9jcXekPTe1zT4qNRl/DsC607sLn9QtR06G5KsmCfWqoxo+e
         X7a+1wi7Uz9qW92JjQC2uU2KBZtlxHO1/EvOP7IGeLWXfgrj/BjbSNkRKk8L8A/y7B8b
         BADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681674; x=1732286474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3Jfhe8hhCGXDldif9Jvrqjsrwf4QgzpQ9EYZSG5+LM=;
        b=u/1sgPExiDleh3ZokdSG6Uov8ehJ2QosLINRt8yPZVSDPfCg9h5pQQC2hGq2JnIrU7
         laCWf8uCqjcPqKXziute7fAveREZ+QsU0rjdYEDuZpHaMsd7l23EKolSRPyzm2oQm752
         mMXo3EWKY2GFjgp0aYV0MAugl5tU60I3LAMGO/+HMu7nvqPairD7zdqmU9ntjhpdTay4
         1LS8eVCa7E4UEqBq9j0o6ZtcNv4qVvefaJOFh7g319M6kn6GldqhcYMLhVQoi8FGbIR+
         e+JbrMyjI/6kky6GWPHWq4uwhlv4W/3+pL26i8LVz0V9R4qafeZA/N5FWdsFFpxWsHbZ
         mZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbGdnc2kraOSB25rSkPnGDmkZPdyOLV8dCJVYQ8SHfCXmBAYS9SWl8uJZZ7JUnR1R++tVtDDjP5xbroTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztWgQ9/7Wuu1ygIiDEOGqZGUN9REsXh7A11ZaxrZlun967uV16
	/tCmn571EPTCiHaWO5Uk3iBUIJiWR7la3+znUwcUir04uHo7bYqj/FwNyVSDthU=
X-Google-Smtp-Source: AGHT+IFcqNCh68FKdaVU9KfniiAfeGPIeMRv2yX8H1KOiQadwOZd/OCDdaNFjSWc6Tz8an57NuZrTg==
X-Received: by 2002:a17:90b:4c52:b0:2e2:b45f:53b4 with SMTP id 98e67ed59e1d1-2ea1559acbfmr3333926a91.25.1731681674587;
        Fri, 15 Nov 2024 06:41:14 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f559ddsm12944115ad.267.2024.11.15.06.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:41:14 -0800 (PST)
Message-ID: <5a3428bd-743a-4d51-8b75-163ab560bca7@bytedance.com>
Date: Fri, 15 Nov 2024 22:41:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zokeefe@google.com,
 rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
 <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
 <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
 <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
 <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
 <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
 <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
 <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/15 18:22, David Hildenbrand wrote:
>>>> *nr_skip = nr;
>>>>
>>>> and then:
>>>>
>>>> zap_pte_range
>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, &skip_nr,
>>>>                           rss, &force_flush, &force_break);
>>>>        if (can_reclaim_pt) {
>>>>            none_nr += count_pte_none(pte, nr);
>>>>            none_nr += nr_skip;
>>>>        }
>>>>
>>>> Right?
>>>
>>> Yes. I did not look closely at the patch that adds the counting of
>>
>> Got it.
>>
>>> pte_none though (to digest why it is required :) ).
>>
>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>> empty PTE page.
> 
> Okay, so the problem is that "nr" would be "all processed entries" but 
> there are cases where we "process an entry but not zap it".
> 
> What you really only want to know is "was any entry not zapped", which 
> could be a simple input boolean variable passed into do_zap_pte_range?
> 
> Because as soon as any entry was processed but  no zapped, you can 
> immediately give up on reclaiming that table.

Yes, we can set can_reclaim_pt to false when a !pte_none() entry is
found in count_pte_none().

> 
>>
>> Looking forward to your more review feedback on this series.
> 
> Thanks for all your hard work on this, I'm only able to make slow 
> progress because I keep getting distracted by all different kinds of 
> things :(

It's OK, just take your time. :)

Thanks!

> 

