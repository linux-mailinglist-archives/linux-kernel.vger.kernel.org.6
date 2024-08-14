Return-Path: <linux-kernel+bounces-286245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EDC95188F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092622865DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92E1AD9F5;
	Wed, 14 Aug 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAxCrTMU"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0261AD9DC;
	Wed, 14 Aug 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630845; cv=none; b=Ty+HYwqgquURxQjGfyv2Mn+/uePeSVYAgOGgBVt/Zf/vD/1OommlUku8wVCnEATKJP9gW6y3os3DjSe9Q99ktblvBPmW7w+Q5W+w5wiAnbwhYLYwGgiNC8o7G4NvXZJmb6109JtZlxAId03SN/xjcodZnX39flJ0LU2AZ8K20sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630845; c=relaxed/simple;
	bh=SbXbrEHuBfbyQo7b7wagUFoBAd4cypQd4YiqU7SHRx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsyjCmFloJWMR2TGgUwXlJitLA+n6RHtI8i14GxMPDvb7cEuakx+wt1TJDX/W/yoV+bYwSQ9hRO2Ig8A+90Zo4deFdkojcOhoaqczACmf9FmMItp7bBfl++1pC4c6OxjhNN+YM0iYZzJR3WFpQ57ADWtvQyFHDMlw9NXnuWHoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAxCrTMU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb8e62570fso7747986a12.1;
        Wed, 14 Aug 2024 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723630842; x=1724235642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hS8lGCxtgdQMkLEIv96JQJSW30lCVa7QFTqxjW3g+JE=;
        b=KAxCrTMUf+TDRQyCvf0NF+E6ENB3I70kH0mXbECM31fhjWLX4+vriQaoWFwTTMAjmi
         VOHkJudzzYhTTSKzPw1kMfNEEfEizr7UPKlrtlSWp7qIm8drNum7VNoPj5zg+Pxrxs/9
         lCimiD9JTxb1uGRrGUVjIpdC+xwjHv9AJ2eo88ecPERTj5wq7jlb+WuqTOX4ZgLcOb11
         onvsRzDu4DF71MCoyRBZT7C/Y1uh4yFIqSaVtzMqou/w27B4Ua2j8fkxCl8VyJtMA++3
         kO9MQngTu9A59QhU21s/GAGSfGxKP477K/+eBjHyQVFwpBHoJybhGMNHEW7CwGjqyCpR
         ObVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723630842; x=1724235642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS8lGCxtgdQMkLEIv96JQJSW30lCVa7QFTqxjW3g+JE=;
        b=oRUrdcKItlqfz4YvMfnjNRXxY5zQ7UOH5pxYdq2fjMq1DIci65Q82b6JWYb7csViWV
         h9o+KkzoEUmcK84Fo72Q1Qwdpk26xR9wy8Dn59rIvyEBjWQrZeSpZHYGi0trEFS9CWT1
         UEuztx+SExUmjlH8Wr9ylUZcpJ4Fzt4oiZtdxq1ckmSgxSq6CM5hACpG7suAqnyFTim4
         DII3Pg5kSTaO1UyGuEiz0qAH3/ClLjH13GT+9Owf6AZn5B/jmdFZ+NLljGA4k7qZ6PMs
         mXixKmC5p8L5H4mLfbL9t6NrzZWEo4ZqXVMCNERkjjHHeM3PHOeOgZ6t+dFCp6fx3hmK
         a8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW544ojtxkFAjOBkuDdZoKvdFQtDj/M860CT7hFcciesYokwXJ8IVbLLH7tFgbC6HOlJEkdhPO5LGUuviWyaTutsoZWKZjheXscnql/UEPYohBfUqHiZaZiZeylRviDO6XLkPP6kB87
X-Gm-Message-State: AOJu0Yw1T15wxdfqLhiA3kwuAbO+hGopqet+leAsCgNHFbbytvQ8qw/w
	3LQIzria0CLzMgrUv5pB6jGRroAim698iNPHeURJW8qS4YwPj+BL
X-Google-Smtp-Source: AGHT+IEz6IAV72R1dG8IaxpUSGQ4yh+slaUPRbi03CQplRXICCbR7V3r/2VG1ZGOj+YEeOWjUIf5Rg==
X-Received: by 2002:a17:907:2da2:b0:a7a:a6e1:2c60 with SMTP id a640c23a62f3a-a836711e423mr116134366b.61.1723630841458;
        Wed, 14 Aug 2024 03:20:41 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:61b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa5db7sm155096366b.58.2024.08.14.03.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:20:41 -0700 (PDT)
Message-ID: <c429f444-5f8b-4845-a9ee-3262c92109ad@gmail.com>
Date: Wed, 14 Aug 2024 11:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: Yu Zhao <yuzhao@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com>
 <CAOUHufbmgwZwzUuHVvEDMqPGcsxE2hEreRZ4PhK5yz27GdK-Tw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAOUHufbmgwZwzUuHVvEDMqPGcsxE2hEreRZ4PhK5yz27GdK-Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/08/2024 04:30, Yu Zhao wrote:
>> @@ -3558,7 +3564,6 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>  next:
>>                 folio_put(folio);
>>         }
>> -
> 
> Unintentional change above?

Yes, unintended new line, will fix it.
> 
>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>         list_splice_tail(&list, &ds_queue->split_queue);
>>         spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 1fdd9eab240c..2ae2d9a18e40 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1758,6 +1758,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>>                 free_gigantic_folio(folio, huge_page_order(h));
>>         } else {
>>                 INIT_LIST_HEAD(&folio->_deferred_list);
>> +               folio_clear_partially_mapped(folio);
> 
> Why does it need to clear a flag that should never be set on hugeTLB folios?
> 
> HugeTLB does really use _deferred_list -- it clears it only to avoid
> bad_page() because of the overlapping fields:
>                         void *_hugetlb_subpool;
>                         void *_hugetlb_cgroup;

Yes, thats right, will remove it. Thanks!

