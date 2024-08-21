Return-Path: <linux-kernel+bounces-295212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85159598AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8553B1F22E45
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421ED1E916B;
	Wed, 21 Aug 2024 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jOcpAxBt"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D81E9169
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232252; cv=none; b=l+g4Q5Oy6pjoj6WTEM//PVnJmRCke+926aT9Cru+RlUbwV14I99uOUb50OT8Hvdrgx+NjWa+7OCxoMRx/b6CR8RsDeP5NxaRiJTweQWIH4yTctHbBibRor3sAsjk8oEZqrTTGPPOukRtGEPAui9Z9POqsdluJnpY9tj/W4+MbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232252; c=relaxed/simple;
	bh=uMDT/NhfPMJAlUSvSaPPm70ztRHPdvb4X+134BfpULk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIaJtgSSvFbf/fYONBIhwJ8fAjnbUEkW5jR2n0mzoRBMWSOO3RUp+xPoHp6EjRVZycN8PXgTDeB9GYd0LB9VcT840+eVZ+LG5kmdOX1UczARbKXu5fWvRIA1lHn+rlXxJjrZXvgFfQtBqD2wlCzL65rDd/IYLJtyC0Nn4CiVDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jOcpAxBt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-202376301e6so25402495ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724232249; x=1724837049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSX2UW/W8B7Ffz8kkQMnXKOYBxRf7RK7/SpflK+Hcb8=;
        b=jOcpAxBtkLKBfthbeKny1ArP5q8XtmfmlllEXizwFxMRK1Co+15zlaWDae0pehrTWo
         GrfftKZxWYszY8Dqw5P5Wgnesb10TQU1krB0agojIw1P74boBBp10RVtGFHNt02W9a5g
         weWPjPBenq4AJKitAu2PDerfIrUjrVzZmtWPAFbVUgSxKm1/DlWwgwVR7XGhXcKdoZaL
         5w6BZ6FuyWeStoVH1MoRzOx3rFSZOsvHGu715UMleSPGnc7jgaLiEJsjQQYILFuowYGi
         qTjzYJwyQxkAuVpynBmharl4VVNaa2X+wfQmLik7m+avpZhtIpg18wr4wLFX9cpF0t8g
         gQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232249; x=1724837049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSX2UW/W8B7Ffz8kkQMnXKOYBxRf7RK7/SpflK+Hcb8=;
        b=pZI5NkFJkAqvTTAJaCvQdAb/PChu9JP0nFKowsoedQi+643n1aL4744gtRLZ40YjX1
         enV89Qod8MynGY2tuBjSU2Nlw8k9+JbyAyVKxdPbLtPhaa/wfUAYu4tL87PLQvgsLT1J
         +iDpkkmNdmVvR81FXUk8BDM0qG+65oMZ+5ZebgZm5+UVQPOa1MDq3oCe+20GEkCVCgy9
         GBvUcdjyHwlJOrw8KR61/LZKO0iAwZUdycEkPyahQwqG8IPvZs3Uvfx22Jo505TTrwbs
         yHHKSbAHRn90QKan/4KL8HgFRgDCbvNFwIVs8ZGUprgRSxFAE7r57vFF/HoZUy8uKTpv
         Z2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVKaNM9NBTzT350raoLG+E2oXNA2zPFNAKoiTog6zqDTH6e1BA7v8ZQ02XsV4Sku0zEuKMCYOnQ9J14/5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+jVAv/pziYJFt7Qp8RxoTPs1ae0v/5nVsCl3NCRCSbG0A+C2+
	5ZAQ6hlTUr1WAxkXXy9Rs/mIsB2EFn07SfcUwwmvYVHjVy8088UwYSpsGRyji+A=
X-Google-Smtp-Source: AGHT+IEgVXX8+VxDvZcoW1SKZwBL11MhagLS8dAsfWdFenURBSvzCDIeLTwfbkrSYGW7mFvGjU6V4w==
X-Received: by 2002:a17:90a:7893:b0:2c9:635b:7271 with SMTP id 98e67ed59e1d1-2d5e9a24ea2mr1735850a91.21.1724232249566;
        Wed, 21 Aug 2024 02:24:09 -0700 (PDT)
Received: from [10.84.144.49] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebb69487sm1232288a91.45.2024.08.21.02.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:24:09 -0700 (PDT)
Message-ID: <b4bf605a-d31a-40ad-8cee-fe505e45dc64@bytedance.com>
Date: Wed, 21 Aug 2024 17:24:01 +0800
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
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: "david@redhat.com" <david@redhat.com>, "hughd@google.com"
 <hughd@google.com>, "willy@infradead.org" <willy@infradead.org>,
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
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <6a586524-5116-4eaf-b4f3-c1aea290d7c1@cs-soprasteria.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/21 17:17, LEROY Christophe wrote:
> 
> 
> Le 21/08/2024 à 10:18, Qi Zheng a écrit :
>> In handle_pte_fault(), we may modify the vmf->pte after acquiring the
>> vmf->ptl, so convert it to using pte_offset_map_maywrite_nolock(). But
>> since we already do the pte_same() check, so there is no need to get
>> pmdval to do pmd_same() check, just pass NULL to pmdvalp parameter.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>    mm/memory.c | 9 +++++++--
>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 93c0c25433d02..d3378e98faf13 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5504,9 +5504,14 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>    		 * pmd by anon khugepaged, since that takes mmap_lock in write
>>    		 * mode; but shmem or file collapse to THP could still morph
>>    		 * it into a huge pmd: just retry later if so.
>> +		 *
>> +		 * Use the maywrite version to indicate that vmf->pte will be
>> +		 * modified, but since we will use pte_same() to detect the
>> +		 * change of the pte entry, there is no need to get pmdval.
>>    		 */
>> -		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>> -						 vmf->address, &vmf->ptl);
>> +		vmf->pte = pte_offset_map_maywrite_nolock(vmf->vma->vm_mm,
>> +							  vmf->pmd, vmf->address,
>> +							  NULL, &vmf->ptl);
> 
> This might be the demonstration that the function name is becoming too long.
> 
> Can you find shorter names ?

Maybe use abbreviations?

pte_offset_map_ro_nolock()
pte_offset_map_rw_nolock()

> 
>>    		if (unlikely(!vmf->pte))
>>    			return 0;
>>    		vmf->orig_pte = ptep_get_lockless(vmf->pte);

