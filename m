Return-Path: <linux-kernel+bounces-190126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2548CF9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5021C20C51
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8469717BA7;
	Mon, 27 May 2024 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeEkXfnm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A322301
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794304; cv=none; b=AmC+mLvvGwHePM6U3kEjSLxGGk9GYyZaHSj7LZWJjM77BlOIg7vg8H3LYD9/uv+ZIt79WpwlbK9dF16D5QJ87YomO3LL+uaxBolCqAHFTRu9vDP4ks8LXBZv/BxonmaGyprhex4QRTxlZ1LfMq94CDim7mJYe/QmkBig1VlNvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794304; c=relaxed/simple;
	bh=O3z8wJj/RY7tGCWilHtBGM/+NL7UV0l+De08BSogcjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQ69fp++i3+t6Ib65XxC7fzdaFbgxW6XgruGjREgsNF7l+S/dU2TZFLxUI+9I8atFz0lgkp+2qJhu+mxyCeZPo+SLGGbQKaSaKOVBcBWtftIeTuU6Gqt/bmzdjHJ58Av4lzEZLXxp4g0t5Kod/eOTALas2tCg4B//CCafSIw48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GeEkXfnm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716794301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SM1q7lncJqyUgRL+tvS7Y4Z/ejSGiKTndXWZjUnltd0=;
	b=GeEkXfnm3y8BfiGluHhM+4kYyZqd3gAHo0UfImf5x7MZFCDvKf15rOJDIDK/s6F5aF9sj0
	CCPf+ysXJV0dU1c/8jcVq4sy7AjORRA1m9013boff68oCeO547LLVKNC7rMo2jvRZdwiyD
	kno3IFqQ0FTmcffYS2AYNZ8Frv0tq4g=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-s12t_Au9Pfq7C0fARdOQ8g-1; Mon, 27 May 2024 03:18:20 -0400
X-MC-Unique: s12t_Au9Pfq7C0fARdOQ8g-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3d1ca4ed5a3so106699b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794299; x=1717399099;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SM1q7lncJqyUgRL+tvS7Y4Z/ejSGiKTndXWZjUnltd0=;
        b=afgDw2xQnLt7nUpLKRGWdt7j3P2rWvrBjdp8gb/rFepZE3BtnpRp3fKdsQmhVhmY70
         xSM1dq5rp6B0O/JQRDPr1GMmRsSTVuJhj8QyeA50p+aO80Gna8OnI4+UN2uhNiM2rk6v
         JkKNWl2AzjW7U6cR0cz1k7TWplOx4x27RPetqRcdv/nO99WSyh5eEG/Yb25tEl2nG1CW
         Z5od8quZuoWLgR85D7uF6m8/4Z2AdvnAcyNkVRZ0ewuvTToBL2ZhcQd+EFpQblRx4VwW
         /9p/deNB9GrevK3i02KB1x9XYWglbpJSTA4d3kN/GDp5SBsaHrVYfhZhwIwV9EL0uj1m
         1a2A==
X-Forwarded-Encrypted: i=1; AJvYcCVOs/q4KYe2lFDPKPoAfLgM8a81plXhb+ePhh40oTN7G+bFNCW3InUYS7/ADQIOMyER3bSzhthYVPngiVUE+EcUWYGbSItQi2FfACQP
X-Gm-Message-State: AOJu0YxZw9NtoakgejO34gG6VS8D/PBE0Ra1UJm3FP3OXGUPphf5eWgD
	jOYWTBmvAuJiBmRFLKt7S90RJgklbwpUxgjkMb4J486for2TNF1Hu2mhPoGJOhjYoSvHh1vgCWm
	YMrd7ceBu8q/DBPeZMMBzmCpT1CuCG3IiQMUjz6dM5TrnIbKgrx5NunQWhcCySQ==
X-Received: by 2002:aca:1312:0:b0:3c9:ad70:39ce with SMTP id 5614622812f47-3d1a6112debmr8635045b6e.29.1716794298018;
        Mon, 27 May 2024 00:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV8wNdsYexNXiniGqldjiWs6gOpxxTn5nnS4Owmc8hzpeS/GcM6kANJPEIljKOoKIbsf/30A==
X-Received: by 2002:aca:1312:0:b0:3c9:ad70:39ce with SMTP id 5614622812f47-3d1a6112debmr8635028b6e.29.1716794297618;
        Mon, 27 May 2024 00:18:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fd16b2dc6sm2784471cf.63.2024.05.27.00.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 00:18:17 -0700 (PDT)
Message-ID: <18ad1a9f-8f00-41c1-9c77-ac3252061852@redhat.com>
Date: Mon, 27 May 2024 09:18:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/ksm: refactor out try_to_merge_with_zero_page()
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
 hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
 <20240524-b4-ksm-scan-optimize-v1-1-053b31bd7ab4@linux.dev>
 <18259f7c-d57e-4504-91ec-90b7c87aad01@redhat.com>
 <36d4f3a6-c426-4455-b5be-2ab503d380ad@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <36d4f3a6-c426-4455-b5be-2ab503d380ad@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.05.24 um 06:36 schrieb Chengming Zhou:
> On 2024/5/24 23:12, David Hildenbrand wrote:
>> On 24.05.24 10:56, Chengming Zhou wrote:
>>> In preparation for later changes, refactor out a new function called
>>> try_to_merge_with_zero_page(), which tries to merge with zero page.
>>>
>>> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
>>> ---
>>>    mm/ksm.c | 67 +++++++++++++++++++++++++++++++++++-----------------------------
>>>    1 file changed, 37 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>> index 4dc707d175fa..cbd4ba7ea974 100644
>>> --- a/mm/ksm.c
>>> +++ b/mm/ksm.c
>>> @@ -1531,6 +1531,41 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
>>>        return err;
>>>    }
>>>    +/* This function returns 0 if the pages were merged, -EFAULT otherwise. */
>>
>> No it doesn't. Check the "err = 0" case.
>>
> 
> Right, how about this: This function returns 0 if the page were merged or the vma
> is out of date, which means we don't need to continue, -EFAULT otherwise.

Maybe slightly adjusted:

This function returns 0 if the pages were merged or if they are no longer 
merging candidates (e.g., VMA stale), -EFAULT otherwise.

-- 
Thanks,

David / dhildenb


