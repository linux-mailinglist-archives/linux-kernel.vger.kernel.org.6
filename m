Return-Path: <linux-kernel+bounces-200670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DDD8FB32F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EBC1C22B52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585E146592;
	Tue,  4 Jun 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc9hOzEh"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576FF8BF7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506662; cv=none; b=my1SQRkGdGKxlJVfloIL+KKmMHUvctJ1sr+bqECij8mbQmxM29hLCjb/X+ClEFa+vI5J6KDiErdumXIZWRl2hSEAmqtwtcg6lV18Pslxq8xIazYifiuCAHLIUpRWlnEzGgo2jhTYE6vwnh/MJmaoUxznNcNtlzvAdD8cw12fQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506662; c=relaxed/simple;
	bh=baN4QDdqVlM1zTqWsL2lyJJ1gn4kVmcywwgkXnY9+cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NHNPeWKEJGWXeNJmIeZymd9qHFBoaJnEKRpWvtosrR/+FBeGcGjANLUUNgB8VtWfus7QTgjd4FYqCLbmr41x/MdR3sL+st4BIXJywJ8OrpOghLRnZ/1F9G/wUaGlnL5xMca1dcta6ypMLsJaQWC/inSu2YyLbObLVamMnVJWb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc9hOzEh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-702492172e3so1117209b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717506660; x=1718111460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WqRWfZWbvnjoGxU6H+VNtcwLKh0+wvggr84zkrj+n6k=;
        b=gc9hOzEhjrMVxm+/VQ298Fajd5coHkPnp7pWufIqsgc6b5qhCLKpCGcunh9FPEqZ5s
         BS9Sxfgzre+3GoZLdZa5SaDQjAsjY+ULDsYG49y1ZM0uW6a3kS43N8MG5ly8y4yntCIA
         458f67v6jbJBLPfLSCk398tDqUlk2v6hy7znXJBPAVP1jI/UJYEY6Pj/p0ab658gYeNM
         j8ZJf9WiaOXhBdk4Lox84vXW5bY8C9lQNiCDQRLjlNwcIOIEsc7Fcg1XzFupw/yrWOkZ
         ehYCUswaW6PBTI5UvodSRPm2DzpTzsPqck6Lutl6ttoAGJa4f1hKpamnrpzRR6iIhxKa
         V3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506660; x=1718111460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqRWfZWbvnjoGxU6H+VNtcwLKh0+wvggr84zkrj+n6k=;
        b=qSLAuka4+qJu/tKRg+L1uTrNIhxsZjsadboMpRp+dbjz4YwwCfLO3sri/R4/SbBo5z
         jgkNHKLIoAea/8ZPSwNcZM1fZ6Xi9zHuYORnHmw5mzVEyUD9ced2PdMvW0SfTThVGLGs
         ek8Ro5tMXDgdKE+f4Nb8U3orSuCsaSiR4H5o/BYu0JXV1TOb54r9bh9yE4mvPz2hJNmZ
         oeMc6nS+15krL5ZX6LtD4CzcILMmP5vtIkZDmpcu5cdoOfwz6LSQiYAWLZxWvloUAN7V
         MuT9kUEOqjaNtcCh/lzlU/VWNZtNucIkKHj2x6fovezVl8NLOUP93c87xMdDGh+iUhAp
         SR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLZk9lKJf9HNnwyagjOiJ0iQtwTn6cbtmSN2VKxEZhh4cU/OZ67kcwQoushHllbqUmkrlWYcj3o+kQzSdc6LQ92pbPtyYVNqwpX9uJ
X-Gm-Message-State: AOJu0YycrH4q377N8xieH9g7ajj4DWvk/IS4xE3EDslqapOaRXkNTiAJ
	NiTiin30vi1RVzmYxmkWSMf7YkaR16xai9WgyILOr22mCj81x97m
X-Google-Smtp-Source: AGHT+IFuPN0egSCqzumzY+9vyDIFi0UnLGicFW1BqDvHlelENXwvNr3lmTC3upQAkjJxJY0xGG74Eg==
X-Received: by 2002:a05:6a00:130d:b0:702:7bfa:3457 with SMTP id d2e1a72fcca58-7027bfa34dbmr3813719b3a.28.1717506660401;
        Tue, 04 Jun 2024 06:11:00 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242ae89b0sm7018235b3a.101.2024.06.04.06.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:10:59 -0700 (PDT)
Message-ID: <9f4f6f0e-81e8-4bd0-9f20-412a543a452d@gmail.com>
Date: Tue, 4 Jun 2024 21:10:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
 <8d3a60d5-06c5-4df4-aeda-2fbec45a8ae0@redhat.com>
 <b3e242b5-c589-47fd-9a02-1e488bed9d15@gmail.com>
 <00dcd224-6333-4f1e-9087-bdb5024ac236@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <00dcd224-6333-4f1e-9087-bdb5024ac236@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/24 6:43 PM, David Hildenbrand wrote:
>>>>
>>>> @@ -2680,7 +2685,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>>>                }
>>>>    next_page:
>>>>                put_page(*page);
>>>> -            ksm_scan.address += PAGE_SIZE;
>>>> +            ksm_scan.address += nr * PAGE_SIZE;
>>>>                cond_resched();
>>>>            }
>>>>        }
>>>
>>> You might be jumping over pages that don't belong to that folio. What you would actually want to do is somehow use folio_pte_batch() to really know the PTEs point at the same folio, so you can skip them. But that's not that easy when using follow_page() ...
>>>
>>> So I suggest dropping this change for now.
>>>
>>
>> Hi David,
>>
>> Forgive my stupidity, where I jump over normal page that not to belong to the folio?
> 
> IIUC, you assume that the folio is fully mapped by all PTEs that could span it, and that follow_page() would give you the head page, correct?
> 
> As a simple example, assume only a single page of a large folio is still mapped, which could be any tail page. You couldn't jump over any PTEs.
> 
> Or am I missing something?

Uh, thanks for explanations. for what's we concerned, the following code could take care of the FULL or ERR pages. And it still keep the step of single page.  
                        page = follow_page(vma, ksm_scan.address, FOLL_GET);
                        if (IS_ERR_OR_NULL(page)) { 
                                ksm_scan.address += PAGE_SIZE;
                                cond_resched();
                                continue;
                        }
And after the above code, step folio_nr_pages on address should be safe, isn't it?

Thanks a lot
Alex

