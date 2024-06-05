Return-Path: <linux-kernel+bounces-201796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 185158FC351
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FADB22CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40521C18F;
	Wed,  5 Jun 2024 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUce3MIV"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F60225D9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717568060; cv=none; b=H5gu1cViTNmiXoEprDal1UMM2v1JqKFRT7iiRtIS5oekVQRDStB9++ZhiorusJ69ePkrU+MHCdz5kwBr0Aee5K+KKN92UJzlhOo/rCQFzdhwB6mZ/4aUxj8jxRJHT3PmLVFYXFDNS+aWtk/OSVvBTwniDR1P27u+xcISB08d5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717568060; c=relaxed/simple;
	bh=w45Vmk06/tFfJtIYCUsNRV12HDKzGpy2cqBTKEGIyjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZ1+dze828Jw/JOevI/DgQcs5+s4cG7ex7Ml69oZ9UU5NIrOzuvRyYe2JHMmHJvxLl1covZAlDadcady2GrQnoGNnZcEqHTc0h1HJNdk3hcUgdqQdJqwbwW9NSk/Fom3eAMbSkSDMPhwTN+4hEebtv/Xm6xF3vk53fAa7wbwKRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUce3MIV; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d1ffaf6091so783219b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 23:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717568057; x=1718172857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sy9rBdag2ODKW3ZS7CtIg9SJEh0J1oN+9/tQGE9G5Uk=;
        b=LUce3MIVhHUcecL27R8W/Vy7/NVvKKcq4Hlp6NLcSVakkpGoUK/jjniiiVheRsC3kl
         ihhCm0+WxJcrPma0DxfL32qbksJeG7J3z1GPfkLnUxtZDYCyW5dYLZtMl5TfRWvjSIKM
         5H+Syp6onVEn1Syb+PRZ2Gu1PX1HTW1mNfzaGPldyX3o/Es/b4vRTD3AfuqgiCCExhEK
         WL2NXa7CvOxyDYKDpMmIyagduGMMLeHq5liuH5PpWjNtUFdRHsUiOTPWtaFrKjTb2RHG
         Dk+cwiof7CzqxQwZ57Knxl+yl2WatB9wQ4aLUUMqAt5W70FMHfMKZDLS6g0pyB73lm7t
         qG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717568057; x=1718172857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sy9rBdag2ODKW3ZS7CtIg9SJEh0J1oN+9/tQGE9G5Uk=;
        b=WWT7O620pgsodfczFji0i3CNeTvgT/R4aLp8ea85lYwfjCQhHTJ56mU3GJb5c2medh
         OopkM5LK7kOD0haJGt7wkKhZWTvsTdM8TNP3Xq/aDXWmHnxWpfHqcbliA/OSezjmNWiv
         IgfnpGSsGamGKiZBu+BW1NGo+ywbcjXrZcXu8OIwJtnEjA5RSreNFVB0wDop+I7btYRm
         TjGgVz+0NiLpfcaXRTwKKS9ee2iy8jgR6gPLrPjsXYU1BszmkOcy945omLMzsCJAAwPW
         AxAevivevc3FnhbEfAm6vExcPdkjFAIvJUoFv1+13qmf/AB3ZNZ2GpGmVCIevvNBAPWQ
         ZVqg==
X-Forwarded-Encrypted: i=1; AJvYcCWoj9UNGjDvsJcGtX0g9oTfbgdp/zvBR8VjVLR7Et7vzy1ZQQBiJKv3CkYb598fJXS+5aVHVYfdi6ylyuwzTzOlFpah/JJBhbN7XtgV
X-Gm-Message-State: AOJu0Yw+dv4JfqALhxWQOaEqgM4t06YIqLoS/YNqE0LRcVMiNjI+Smsm
	ng4BGA3umV1f4q3ujijU31b8UqDkICK4zBrC4cjIqLiiRZZ4PR7m
X-Google-Smtp-Source: AGHT+IGq8WDJvVMPjAUIosp0LtnPy4A/AiNvUulsnBTh8qtM5J2fgL5a3aAC1JEdhMqyWFZ/rB/2cg==
X-Received: by 2002:a05:6870:9689:b0:24f:f282:241c with SMTP id 586e51a60fabf-2512214b611mr1830733fac.59.1717568057375;
        Tue, 04 Jun 2024 23:14:17 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423c7bf0sm7951204b3a.42.2024.06.04.23.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 23:14:16 -0700 (PDT)
Message-ID: <5bb3bbf6-6a22-449f-96f1-b9476357f284@gmail.com>
Date: Wed, 5 Jun 2024 14:14:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 aarcange@redhat.com, chrisw@sous-sol.org, hughd@google.com, david@redhat.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
 <Zl_g7qmXAJDy4vKu@casper.infradead.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <Zl_g7qmXAJDy4vKu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/24 11:52 AM, Matthew Wilcox wrote:
> On Tue, Jun 04, 2024 at 12:24:44PM +0800, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> When a folio isn't fit for KSM, the subpages are unlikely to be good,
>> So let's skip the rest page checking to save some actions.
> 
> Why would you say that is true?  We have plenty of evidence that
> userspace allocators can allocate large folios, then use only the first
> few bytes, leaving many tail pages full of zeroes.

Um, that do need tail pages... 
Is there some way to use more folio in ksm?

> 
>> @@ -2660,6 +2662,9 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>  				cond_resched();
>>  				continue;
>>  			}
>> +
>> +			VM_WARN_ON(PageTail(*page));
>> +			nr = compound_nr(*page);
> 
> And this is simply wrong.  *page can obviously be a tail page.
> 

Got it. Thanks a lot!
Alex

