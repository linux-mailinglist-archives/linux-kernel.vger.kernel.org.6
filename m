Return-Path: <linux-kernel+bounces-205737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1658FFF98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66661B21DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7C15B0F2;
	Fri,  7 Jun 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWPeHvkm"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4C78C9A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752830; cv=none; b=PRU9TUHIUsY83kxjBFpbuChu4v2FkOdXXmDECr2L1sRnj3RaU0Hdf3UXzlwXTsO9TcitFAKoLCDej+Y3by5nFmqzWgbs/5HFSRTSnR8nOzQ+9P2QQg1zG1Zh2/G/qscdbinR8Jo7SBIn3GcFXy6HP5clDCGUVlI2jhBDfP/ob7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752830; c=relaxed/simple;
	bh=NT9z6P0f6puW4FsAG8N6tTIN2TGhAGLIxK/K2rXAdjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eqWVD8zPDfId4CVwILW6jTKQft/uBlcAAPu5CieVoCu+DG1YNIb3ZXgtdTzXIbcHqS/X8L4q4lE3UT2FY7z/FzuJcqUZMwSuDfe3d5LFmKgHFlJsJ57ebM73495PFZ1eaEl+nylCQ759qttWVPUqbTkuyr90XuW/JyPINJw3Hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWPeHvkm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f62fae8c1aso15174285ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717752828; x=1718357628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72YvUApEpU6/UaTvQGfQD//JdDofdvx+Uzs1egsjGI0=;
        b=CWPeHvkm55Sy2+86223poiUm04xFlQXg8Ppx4dCKY+nsq1FNkcItw2OtQ1J7AqZTXz
         WIN5IyRVzXJu77sy6eVXYVHD/+F05x4AxKZ6dabeVJS5p/Sx5N+ebszHqMq7+xQwYERI
         Ya9EFOfnNMx0ONyuGUWatL/8rJ/8it8xDu0Gf1zVPqLlhdGTwoM+CulR6YPE6U0iLgmZ
         7u0pVaK1Jt7l5etstisYXTQuMQucWtY25CXh/5PR6WkAmFvKNi/Ic04/4e4+Bvi+xf9R
         MpobXTooR+UtVQLcG+neVhuNEQBqjy7bGJT3at//DetwOMQLCYbtcixL4wgQ4o8QkYBq
         mdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717752828; x=1718357628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72YvUApEpU6/UaTvQGfQD//JdDofdvx+Uzs1egsjGI0=;
        b=u0l/sxkS10AZf3165FP19761M61KzTeNhBUdomWbbtJiiIvnY1a0qqe/Ma1r3AShU6
         xzDIyxmdMULx9VARLOpdNtJS3E1mPz6Vjjt/O1KgWO3f8Qluh/yZFY0stQl7ViWcKcid
         MIkjiHQC7x9aNfwOy/NhbZJfDx/k6+zhnbnIMPxYzCp0n+OopAfD2bdfCVaRKQW1kvFU
         FiaFXFc4G21Y1mJUFnRezVTGcyV1HFifQBr76qs8qo7gjW5nbAgVSwo/dDB0pGCnQZK7
         XZZkwP76S47Lj5l+Xg+GFV7X4atzGY9+xe9c0T44o7VVHp/uhytWx7LZ/bqqpBNTnIxa
         naJw==
X-Forwarded-Encrypted: i=1; AJvYcCXBakJ277x/WPi36FfLcHQqT+WXDma6hs5XVQ/P1LNv0TvdSpX5yvzkWkHJ46yrfpnUgwYJRjj8JQiXdlBCju1JoLsEK+AsIALvJd8+
X-Gm-Message-State: AOJu0YwPB0qpuFDw1r+TyZvQ06RgUWYN11flcX5R9xXksp0CrxXvImbF
	yPe4USv45fVW1F+LdVOZsQfEC5M4ahRaLM6GEhXiwj2KDQ86rAzo
X-Google-Smtp-Source: AGHT+IG/PHYgvvy29vk0x7nXRy/2/7OCrWbd5n0+650ff4JBOoclmWWOt1HzYycEs9xGbMXNUAWFxg==
X-Received: by 2002:a17:902:e881:b0:1e4:9c2f:d343 with SMTP id d9443c01a7336-1f6d02bec94mr24867095ad.7.1717752828187;
        Fri, 07 Jun 2024 02:33:48 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d8c70200sm8474515ad.173.2024.06.07.02.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 02:33:47 -0700 (PDT)
Message-ID: <6b39db70-70ee-4370-acc3-86050562e343@gmail.com>
Date: Fri, 7 Jun 2024 17:33:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] mm/ksm: add anonymous check in find_mergeable_vma
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240605095304.66389-1-alexs@kernel.org>
 <353d4f6c-ed3d-4afe-82ab-8c0b22a0178f@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <353d4f6c-ed3d-4afe-82ab-8c0b22a0178f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/5/24 5:56 PM, David Hildenbrand wrote:
> On 05.06.24 11:53, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> We do vma_set_anonyous in do_mmap(), and then vma_is_anonymous()
>> checking workable, use it as a extra check since ksm only care anonymous
>> pages.
>>
>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>> ---
>>   mm/ksm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index f5138f43f0d2..088bce39cd33 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -742,7 +742,8 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>>       if (ksm_test_exit(mm))
>>           return NULL;
>>       vma = vma_lookup(mm, addr);
>> -    if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
>> +    if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma ||
>> +            !vma_is_anonymous(vma))
> 
> Doesn't KSM also apply to COW'ed pages in !anon mappings? At least that's what I recall.
I didn't a evidence for this. :( 

In write_protect_page(), "PageAnonExclusive(&folio->page);" has a "VM_BUG_ON_PGFLAGS(!PageAnon(page), page);"
So is this hints the vma also need to be anonymous one?


Thanks a lot!
Alex
> 

