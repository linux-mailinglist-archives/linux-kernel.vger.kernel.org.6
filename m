Return-Path: <linux-kernel+bounces-241648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D8A927D93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39A61C234AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D8F137C36;
	Thu,  4 Jul 2024 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrxocATk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0AE132122
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119927; cv=none; b=tnxjVgFrduoGNbzYgiR3TmabTIrsvMgnL23hiv3fQcH10BPeuNmGzvNJ7Ui94pN00vzmrjBaacgHHoaiGmN2naxpdIXX6V58Ftr8kWgtPAryPbZdMvQ21/97Hv6YhGbUtBybFV8wGMrujiO01+n275+gLz0UGwHnEtDdawQsryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119927; c=relaxed/simple;
	bh=zlRycrno5scc3FF63X71VyGn4cuuFZbFgTnV0OpYbIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gOugbfmj8pekHqENyFwKNqYoifjVydWNFtgy1zk0FErZnz5Ur/ObKZhf+5F2KaD/9+hH1eSiOGYxtaqd7s/7GTi17dGNceugtqBrtw50fM6xp83mqnmiRWACz+L8nyMys4F5eLVcpczICN8osR940KrsHpOirEFEs3fHLe+Zy/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrxocATk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720119924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YJ62yNRB3/Kncq4g9Aye/MiNuR3rPeNkfs1pvITIYv4=;
	b=PrxocATkS87iY6nZHG4gfZoM7SLpRPtVWRfp1M4WylxdhRJn/+Q4yBj+sqZDWtk4sKPiex
	xI0LYB24XHoWZpGmSac5/+N6OYy1yh3WBqHsgGbdjl7nu+tE0Rl3nJshH3uWID3IAnnzml
	UGSiljmQ3c992ckVByR+rHxQBr6tFIY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-LowJ6vE2OTCgznz4yB022g-1; Thu, 04 Jul 2024 15:05:22 -0400
X-MC-Unique: LowJ6vE2OTCgznz4yB022g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36793b39ee5so644027f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 12:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720119921; x=1720724721;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ62yNRB3/Kncq4g9Aye/MiNuR3rPeNkfs1pvITIYv4=;
        b=sCdg8XViECOK0ymEIwVncXZFo5xa23IW1KrpXhanwA1HcfMTwDZMu8x6fRCRUeCpbp
         FeevoAzznTQ+ic5n09EV+owdCDVImC1OI2xwHC0rf4ZVozx70nhOtFud0r16D4Sh1r22
         jB9iQ0KrE+RRekpV/zCiwvRsu+lOAa/xc6ok6x/61ItJgcnyyR3u/AkyJk2TC67t5oKM
         gtBygyTOHfqXCvvsJ/kb/8CH2Z+zu7jM5jXTgShmrROqA49l7K8JmuW4Xye2J8KTVVJA
         qaaRockBifhIeNorImpJdN7DMmM2H8W017sFKJsdSLAV1SaNMg0adjYRuxF9RHEDDGce
         0gvA==
X-Forwarded-Encrypted: i=1; AJvYcCUunDNOA38UJI9CIjLDtgNhwNGO58IWbZWZipM+8xoUyhThO2sCMDl8WnX9dpsQ59Fk8opA059TyoV6EfWU16jNPJaH1JJ/mPSRnHb3
X-Gm-Message-State: AOJu0YxdXIyxhhzS5Zd11DS8aoXsbxUWMYWsJEf+CiXUpYiArPR/VcHS
	C2o41flKaRkckmaU39biw/Jg2R0fpwWsGS18YkjLHchCdJ1PKG//oFzQMjg9EJ5mGPQEnuS0VvG
	LTsNwYQ0WHJ5Qqqg78xNj0G6uSkTey7G5Svh+qfZIWROR4eP012cvm93TB08i4Q==
X-Received: by 2002:a5d:56c8:0:b0:367:9791:2939 with SMTP id ffacd0b85a97d-3679dd2388fmr1502667f8f.21.1720119921687;
        Thu, 04 Jul 2024 12:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfcEkGTDab30yQEIkMnfUMn4Kxym2fIogzqApAykEKGn3kLTIX35z8xOuHyIifrZhYQ2xFvw==
X-Received: by 2002:a5d:56c8:0:b0:367:9791:2939 with SMTP id ffacd0b85a97d-3679dd2388fmr1502651f8f.21.1720119921268;
        Thu, 04 Jul 2024 12:05:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:8600:f05d:97b6:fb98:2bc1? (p200300cbc7158600f05d97b6fb982bc1.dip0.t-ipconnect.de. [2003:cb:c715:8600:f05d:97b6:fb98:2bc1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a29eab73sm1267268f8f.41.2024.07.04.12.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 12:05:20 -0700 (PDT)
Message-ID: <bc353ad9-3446-497c-bf66-74bae2b7056a@redhat.com>
Date: Thu, 4 Jul 2024 21:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] filemap: replace pte_offset_map() with
 pte_offset_map_nolock()
To: Andrew Morton <akpm@linux-foundation.org>,
 Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, ying.huang@intel.com,
 fengwei.yin@intel.com, aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
 hughd@google.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20240313012913.2395414-1-zhangpeng362@huawei.com>
 <20240625140643.bf4a1a19b0d534d802764610@linux-foundation.org>
 <20240704114039.4fd0739593cd0a96fe428496@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240704114039.4fd0739593cd0a96fe428496@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 20:40, Andrew Morton wrote:
> On Tue, 25 Jun 2024 14:06:43 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> On Wed, 13 Mar 2024 09:29:13 +0800 Peng Zhang <zhangpeng362@huawei.com> wrote:
>>
>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>
>>> The vmf->ptl in filemap_fault_recheck_pte_none() is still set from
>>> handle_pte_fault(). But at the same time, we did a pte_unmap(vmf->pte).
>>> After a pte_unmap(vmf->pte) unmap and rcu_read_unlock(), the page table
>>> may be racily changed and vmf->ptl maybe fails to protect the actual
>>> page table.
>>> Fix this by replacing pte_offset_map() with pte_offset_map_nolock().
>>>
>>> ...
>>>
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -3207,7 +3207,8 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>>>   	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
>>>   		return 0;
>>>   
>>> -	ptep = pte_offset_map(vmf->pmd, vmf->address);
>>> +	ptep = pte_offset_map_nolock(vma->vm_mm, vmf->pmd, vmf->address,
>>> +				     &vmf->ptl);
>>>   	if (unlikely(!ptep))
>>>   		return VM_FAULT_NOPAGE;
>>>   
>>
>> whoops, I'm still sitting on this because I didn't know whether we
>> should backport it.
>>
>> And...  guess what I say next.  Can we please describe what are the
>> userspace visible effects of the bug?
>>
> 
> Nobody?
> 
> Oh well, I'll add cc:stable amd move this into mm-hotfixes.

Yeah, we should better do that. IIRC, the PTL pointer might be stale 
(use after free?), although I cannot judge how often that should 
actually happen.

-- 
Cheers,

David / dhildenb


