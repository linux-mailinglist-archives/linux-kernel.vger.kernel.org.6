Return-Path: <linux-kernel+bounces-300166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F8695DFB4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AA51C20DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949E279B87;
	Sat, 24 Aug 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2w831mC"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5D27DA62
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724525931; cv=none; b=ADbf2H2yBMr11Z9fQZwvP/SAwPk3bzPBNC8Z+WMJrkzlUFErBRCf+Ata+4SqbcloP71FTeNwm6shk48X4/8hpQdyYirMdRc1//6IBJ7MImMBolJwd449+XPSOAkr5xM4lpP86ADowak+3S6WvIe6UiN35axWuYtkp1sWhmcmitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724525931; c=relaxed/simple;
	bh=gRc8nmvJgD2A3goE+uoG7toUeIITXZmFyNs/93uMZJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+Xg1nOuXolOjZ6vWDIWThCDn6lpd0chApmeZO7tBmCQ2FR78NNMlacr3+xGv5/BEUGNPY2dHLJkULuqFaQwSGbVyLINNrsl8AqP/vxOiMPgmJ2FcG16IXQVRe+SPb4lcDfVXYqiFlZ16JbrDHNnBgFrVKZoDbG6gSlCuy9BPWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2w831mC; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6bada443ffeso22794847b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 11:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724525929; x=1725130729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHmNkA5ynV1P4Wa9MrNLlvBNlS2hWd3TPD/qVs35LGc=;
        b=f2w831mCdg3Z6O4LkgEIFFNYVGff6SuKQG/tKmU+CXrvWZZvqGkoHk3lhqs+919aLJ
         gtGckMnRD4Lxmp+E+hORA1a+8jNe6ile0WS2TwyHMQVEeNy/h+FoIZzJubksx077tglQ
         SnC6U6B2LODyXX3oRY/7a2uMlHObDrHQuhYCHkasKPWhkgdHeHeUC1dgnh9ECJMW99et
         nBdzrlF6/wQOXmCvkDPHlCd+K3DD+Hkm4eqghKSx0/+KmAjWj8XgVFcj5EQ8RnHbeYQK
         nABNDg0ubnj8dg+JiCGSgDKjZrKj3AMkwwHBEFrbi/ijjt/ElnQM5axMx0k3S9LZa8iP
         O9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724525929; x=1725130729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHmNkA5ynV1P4Wa9MrNLlvBNlS2hWd3TPD/qVs35LGc=;
        b=KTzKRWrGX+KbmOPuz6YtHl5E9ZfWadAz7p6Xol2fH7alwc6zG59E0fWeagrof1xFfL
         l+W9T6l1vavIQQhUVEdWUhOkZSRTCifZ7PCLG4vrRqd7GYmTOyYs8hSEEZ8DrDGeq3ck
         URqkL8vAALwQgBaeNanm85v8D4dQ3BRNEYHae339KVzzVbuadC/EGNcmNObwxQcTuaZr
         LzZEkxXAQLM2vBeSVc3TGCAGPHOMZEpKEaTYAMfc+0VE5e5W899Ap4l5KNnD+6aW9QbF
         JzvpNo+J4HjvLxDR/31fzdsju7Ouen/mfYHBnwyGwbvq22tkg/nEm1Z85i/DyBdDxADV
         F7gA==
X-Forwarded-Encrypted: i=1; AJvYcCVvK8ZHPHxyNSfI/0l0wIhVAMmqO5N+rhqvGmbUZrBEQg/nUsbrMyXq+43iKDpZr0vrLNg1uuoFWakCVPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbvkl1/lqRn6LkTLMlqBtdmw/3wmDJXn0DHjfNx7jlxUgEkouW
	bMq/8Vyxnm3/miwpmoVLA2LMNuwLNxH65ZbuNQo9dGJD6iKYpJMF
X-Google-Smtp-Source: AGHT+IE3cCeTNAcwdXUdhToa+u45GpXaafPg0wtBZlztiVimoRsozLlmaqjhpmGyn4dwkuzwPfSWbQ==
X-Received: by 2002:a05:690c:4c0c:b0:61b:e61e:8988 with SMTP id 00721157ae682-6c30691ec33mr82911317b3.18.1724525929193;
        Sat, 24 Aug 2024 11:58:49 -0700 (PDT)
Received: from [172.30.3.60] ([12.247.251.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39dd4864csm9454857b3.129.2024.08.24.11.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 11:58:48 -0700 (PDT)
Message-ID: <f4b5fefb-d5cb-4b21-845f-1c5a2165990d@gmail.com>
Date: Sat, 24 Aug 2024 14:58:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v8 1/2] mm: store zero pages to be swapped out in a
 bitmap
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Andi Kleen <ak@linux.intel.com>
References: <20240823190545.979059-1-usamaarif642@gmail.com>
 <20240823190545.979059-2-usamaarif642@gmail.com>
 <70a3d71d-b0f9-48b8-bb00-497cd17da764@wanadoo.fr>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <70a3d71d-b0f9-48b8-bb00-497cd17da764@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 24/08/2024 02:55, Christophe JAILLET wrote:
> Le 23/08/2024 à 21:04, Usama Arif a écrit :
>> Approximately 10-20% of pages to be swapped out are zero pages [1].
>> Rather than reading/writing these pages to flash resulting
>> in increased I/O and flash wear, a bitmap can be used to mark these
>> pages as zero at write time, and the pages can be filled at
>> read time if the bit corresponding to the page is set.
>> With this patch, NVMe writes in Meta server fleet decreased
>> by almost 10% with conventional swap setup (zswap disabled).
>>
>> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
>>
> 
> ...
> 
>> @@ -3428,6 +3444,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>           goto bad_swap_unlock_inode;
>>       }
>>   +    /*
>> +     * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
>> +     * be above MAX_PAGE_ORDER incase of a large swap file.
>> +     */
>> +    zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
>> +                    GFP_KERNEL | __GFP_ZERO);
> 
> Nitpick: kvcalloc() maybe, to be slightly less verbose?
> 

There was quite a long discussion [1] on this in v5 of the series, and we settled no kvmalloc_array in the end. I think best to leave it as it is at kvmalloc_array.

Thanks

[1] https://lore.kernel.org/all/159061bc-27b5-4127-a85d-223bed0ddfd5@gmail.com/


