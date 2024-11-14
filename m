Return-Path: <linux-kernel+bounces-408977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A789C85ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ED6281C75
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF31DED72;
	Thu, 14 Nov 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O4mpwlKF"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9B1D1724
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576016; cv=none; b=nMzF59JYdjXqiVe/NQP+uLPHL9jU0qMZkr93Q5XXagjODv+mxMXGh59boKTaJCwEPHJmCyJj8C5Vp4BevhrJ3Rb+8wAaWjzzuTljJ1TDtRUOMY58XUFjFj1kKFWTF54pPEvH7jsDFScuzOchcAIhDJ5aS+P5tyCIHESVUAKAjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576016; c=relaxed/simple;
	bh=lkD2vXS/YBJlK45nXS0jJmdpIJqG/yMYI7I16eZpsXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjhd+lgXzI3SEa6LLR2w/vh6KPCgo0Z1ZI3NJdljoJN6p4H9VTXYqSxOjdkwwjh+CvAnZ9DuLLxMDpNgFhxBlSMMrQ4toveLHzTBudleagotPoiEWVpcmw/NVsSXzFKitKGuZ6/4e+dHVjSDg2MHTZO5myi9VCgwghENK6XrLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O4mpwlKF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2113da91b53so2411145ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731576014; x=1732180814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLuhGBNI7mSDN8kf5W4IBkCXg+WxXsuESCrfnLcIFaw=;
        b=O4mpwlKFuNbNp5paAByvwsiMy8QP2xfUXp7jr+tzGqDTsYQUWg8HYc6MDf/bYlK1N1
         HA/d8+JPSSzKfYblYzPnXgrfmEwHPSUBngm0koqclzz0sRFltW1VMs+8yD6kiVxKyHlg
         2is5yk/DGSzeJ8WgiS0vUSYxK58HLGRGH1BYpZ4PySr2CczuOpvuywW57CRPZElNGTA7
         PSoI30qBjbVBe6ilQyGiiYk48NPSBnyN1o47QX3A4+sstnuI5K51JL6r3cqS2+TotNMU
         Hs7p4bJgR95Txu2h4/GYythU0lNugrDcteeU5vYyZDRiRNvWFOPRDIBTGAy+YxovhH92
         km/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576014; x=1732180814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLuhGBNI7mSDN8kf5W4IBkCXg+WxXsuESCrfnLcIFaw=;
        b=Xk21xRMwhygN888KVdA0shFyh/HpvgaJFlFLwnpKUmOqyGQuxSnnOrU/uV26yalGLq
         E9tcWsADdZ+st9cPx6o0zX0IcNaSn4fdQHVKEz+H9X7Dl9yjWj++2WwaYTnFaX70APhc
         6gqdOIxJ6yUNXsbZ+xIDIf112cjUOJ3bMG4j8cqE/p+crMOfi7h0NVscmdk19Vm+cR+i
         6KAFQI485uTvrGf0Ol4Eur1QeeQmF7rsqgwXhTwMJ4R5Lp2r4OkGJryDsYUFyV/gavIg
         8qi0yxugTlu11dnOtpbFpbrOX9F5PidWoiR8ZLy3FUYca/PmBrk8E6q9wKB9nZT94r2o
         PwAw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0yDWLWBV0g/tPVEdO+benGqfX/2C6upE2cHlgZEUxlZHbvrEmHHUQpcRtGfEqmIvhhg3Bj1/fmMv2Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpOcKbpXcFbaI8KTAHUXa6qRJw5fVdkoquZn9exuYeRKzIAomk
	6UQsvSC4jhQmdZ9a/IWdSWUlFcTXnWzkMaqpKVLYvpVtO1r+K+Q3JALU1gyi3d8=
X-Google-Smtp-Source: AGHT+IFMMpatUed99XmkbIDmSKtP/bx2VLKWtk0NTN+JwnU9doOjab2LaNQ7qbLDcDth1uJgOq+Jgw==
X-Received: by 2002:a05:6a21:8901:b0:1db:915b:ab11 with SMTP id adf61e73a8af0-1dc229a6e8dmr26638759637.24.1731576014274;
        Thu, 14 Nov 2024 01:20:14 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7ce9bfesm6414265ad.120.2024.11.14.01.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:20:13 -0800 (PST)
Message-ID: <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
Date: Thu, 14 Nov 2024 17:20:04 +0800
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
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/14 16:04, David Hildenbrand wrote:
> 
>>   static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                   struct vm_area_struct *vma, pmd_t *pmd,
>>                   unsigned long addr, unsigned long end,
>> @@ -1682,13 +1704,17 @@ static unsigned long zap_pte_range(struct 
>> mmu_gather *tlb,
>>           pte_t ptent = ptep_get(pte);
>>           int max_nr;
>> -        nr = 1;
>> -        if (pte_none(ptent))
>> -            continue;
>> -
>>           if (need_resched())
>>               break;
>> +        nr = skip_none_ptes(pte, addr, end);
>> +        if (nr) {
>> +            addr += PAGE_SIZE * nr;
>> +            if (addr == end)
>> +                break;
>> +            pte += nr;
>> +        }
>> +
>>           max_nr = (end - addr) / PAGE_SIZE;
> 
> I dislike calculating max_nr twice, once here and once in skip_non_ptes.
> 
> Further, you're missing to update ptent here. 

Oh, my bad. However, with [PATCH v3 5/9], there will be no problem, but
there are still two ptep_get() and max_nr calculation.

If you inline it you can
> avoid another ptep_get().

Do you mean to inline the skip_none_ptes() into do_zap_pte_range()? This
will cause these none ptes to be checked again in count_pte_none() when
PTE_MARKER_UFFD_WP is enabled. Of course, maybe we can count none ptes
in do_zap_pte_range() and pass it through function parameters like 
force_break.

> 
>>           if (pte_present(ptent)) {
>>               nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
> 
> 

