Return-Path: <linux-kernel+bounces-186171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C98CC09F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1712D1C2264D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F06C13D538;
	Wed, 22 May 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPe5o+lA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6FB7E765
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378557; cv=none; b=jUZ9dfGb+uDcATjcNFtw3GbuOWLdKvzK39ax7FtKV8TdDHmExYHH6/2RdgAA07XTktoJxlUUoPkiOQrgOq+EGqO+cNCRSZFl2AyF2IU8zeeknSrWJ8cyMvFSNkZ5diRxqye7o6ksHkm5QpqncjZW1fVlVNGq48WaaiMcI46LEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378557; c=relaxed/simple;
	bh=UzH+1NWocshBSCBm4dmtBnM01DprKUsgR94/RLlAP30=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sGiD04m5my9lKpNtYtvVgduhi2sMMYex95SgN+PU7R7e8JEaSV5cVXw6RDwNjYy8IfpIktIVbD5sTt2g9nx8RPcCurNyOABOGsa3YE8L/Ex0xTFr5VjBupNkNbu4WjVGdljazw6StmVqAZGEAIv+7o3ZLFAW5ng1+VV651aREJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPe5o+lA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716378554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iQhB0iztFPknInaPPJkVPXM2/PL7yjnBkt/B3GMg3iA=;
	b=BPe5o+lAaEEqCWYLwLUo3iW/ol6RdOJvwJ9CbCjQafX/jwqKBDIzFOA2jBAXa6xcONZ52E
	p9j6NehuM91L2Og3ksSrWXckO3hbmQdzUUodkdxS/WcZx+TBssi6Tx7bRxntPKLX3eCo8I
	5EbtVHj8RELRNjdLn4jcdUblJpqJ5Og=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-dYe8NDjDOTOMN8_LqdBizg-1; Wed, 22 May 2024 07:49:13 -0400
X-MC-Unique: dYe8NDjDOTOMN8_LqdBizg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-354dd4a4284so360416f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716378552; x=1716983352;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQhB0iztFPknInaPPJkVPXM2/PL7yjnBkt/B3GMg3iA=;
        b=Uzoa+LWLe3zDqLcGaf2OOD/4di3JxZCcW6xbEPdEihZVX47gVACAipqYwkqCHELNc7
         xDtMlE3dDwDpAOGYsQ+yd4xwiexDXs4w64C85CDfbYKSAtharLGGrSVXNi3hlRlQFI06
         nOflOVUfloGNu2NNEC1f0SHybpZZycTP3WnZMkHHTz0fbdKL1AIwF3dwln/V1xsinr2z
         d54EaavqcpHDSGwTkvJEas2lVSTjOB4L1XihnIvopGBoCUqWKlkqS3llnzXzUnFrE8Hv
         otLahQmUex3A7fg8tysDhzqTVtVzSqPLxojFkAhqbaYSu6HRcXuc/BHP+zlmoBWarz2t
         mu9A==
X-Forwarded-Encrypted: i=1; AJvYcCUxc7Y+5aiYWPjTUdxlGWVWKP49zbwhn5huD38wgAIHT1vh48/kiDVbvpW3nsfYAZuCib4RANurv4pFYQ1Fu5KqDq1rRgvfkgySDg+l
X-Gm-Message-State: AOJu0YwVaZD0X836av3eJKLKF60jsOk9c0MUvi3thNTKyoqvniBKSdPQ
	L1SZ31WuBFKO46MVrzB19efNQUqDD/xrEgCo1Yj4+ZDQ2GkmnyQGqQptxip04YHnR++4ZZxwPrv
	FMU/TFAJw2B9qdAYj4iKfQ9Di1Lb8rIPSaSxsCMBTxFx/96yGLZjboY4VhTRw2w==
X-Received: by 2002:a05:6000:89:b0:34d:b549:9465 with SMTP id ffacd0b85a97d-354d8cdd80amr1325086f8f.32.1716378552008;
        Wed, 22 May 2024 04:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPYshRhMBqprIwRI44n20QSlHrRd/6hhTxsXawr1u16AgvgZxzQ/HYSdCueimfhK32bSDORA==
X-Received: by 2002:a05:6000:89:b0:34d:b549:9465 with SMTP id ffacd0b85a97d-354d8cdd80amr1325072f8f.32.1716378551552;
        Wed, 22 May 2024 04:49:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d500:4044:6d4c:f060:f677? (p200300cbc709d50040446d4cf060f677.dip0.t-ipconnect.de. [2003:cb:c709:d500:4044:6d4c:f060:f677])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354db76acafsm1480470f8f.49.2024.05.22.04.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 04:49:11 -0700 (PDT)
Message-ID: <edb23777-fd94-4395-893f-ac9697e915e1@redhat.com>
Date: Wed, 22 May 2024 13:49:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/ksm: rename mm_slot_cache to ksm_slot_cache
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, willy@infradead.org,
 izik.eidus@ravellosystems.com
References: <20240428100619.3332036-1-alexs@kernel.org>
 <20240428100619.3332036-3-alexs@kernel.org>
 <2e074a0b-7ab6-4381-9216-31f68a738a07@redhat.com>
 <4c255baa-99e3-4f48-9303-13edb99adc89@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4c255baa-99e3-4f48-9303-13edb99adc89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.05.24 14:15, Alex Shi wrote:
> 
> 
> On 4/30/24 8:57 PM, David Hildenbrand wrote:
>>>
>>> @@ -2972,7 +2972,7 @@ int __ksm_enter(struct mm_struct *mm)
>>>        struct mm_slot *slot;
>>>        int needs_wakeup;
>>>    -    ksm_slot = mm_slot_alloc(mm_slot_cache);
>>> +    ksm_slot = mm_slot_alloc(ksm_slot_cache);
>>
>> Similarly, this makes the code more confusion. The pattern in khugepaged is similarly:
>>
>> mm_slot = mm_slot_alloc(mm_slot_cache);
> 
> Could we rename it to khg_mm_slot_cache in khugepaged?

I don't see any sense in such renaming, sorry. This code resides in 
ksm.c/khugepaged.c respectively and at least for me is, therefore, quite 
clear.

-- 
Cheers,

David / dhildenb


