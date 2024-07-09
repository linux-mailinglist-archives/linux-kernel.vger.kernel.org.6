Return-Path: <linux-kernel+bounces-245035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7B92AD6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752491F22320
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B4286A6;
	Tue,  9 Jul 2024 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXYe7yad"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940E1EA80
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486583; cv=none; b=U0IHTAyLVUeZyFbWrPgSskeizobeHGY5YG3bETDw1NgSnthYNrxOk5+jPoDoKn6hQZldV9GDyyv3O1dMB9HuA70bRGbMu6H/IH/lRDf5E6qNHykqfj3w5bahMkjdCQJlM+DZWhRZgql8iV3juxgcfPfXJPOmpGCpQz1Z5LD6zeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486583; c=relaxed/simple;
	bh=iH4XkXh2lpYUuCPClm2R6l5GXTXOIFlp+/I6YQb8XCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWXmiCbVVpFSggqQ7wJj8+rHADtNn8wx0zCNldo9BxGgdkTiYbxb+62i7KhOMkow93mHCLXZV7CNPB5neRW2q1ut+gWoEjnZLt495FCNGq+8Q0UKnenpLB5/arbptsNV3ZtS67ounTk6cfzEl5zOacsNkv5cv0bN1z7ZMTY1bnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXYe7yad; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso5524904a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720486580; x=1721091380; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFO55uxdi8FRVhzNa7rRusXHfIz8daUjQUpq0icE1SY=;
        b=mXYe7yadr8I74FR6NUdcLsHrrLIqPQ9IQ7AyEQZyq7coBLsQm9uUBLkWLuhtepBrF0
         JxK6TurOIFxjNcv3C1kfO0jR61a9NT0KdE/rSzWJNMcvGPyuTBv5OR2zh+Kt5PMJXe9f
         puGedI3W2oQL5qsOrtPfMluyV9gwxY5+nPgFHyX765DFADZBnyUEf/7R241fCVkR8GjR
         /ZdYO3HRG4zx/HAWKqXMuZcTqSD0lyqa3Z26vwcbdd21YRT/e8X6/4QfHofyt7RrEYWJ
         0ROFk4Ns9FlHYtxHI6u4pxtFCgI8sDKiXFrdqg7DeZsZ9pCpFGzjonbdYdasJmDxC9Li
         8lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720486580; x=1721091380;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFO55uxdi8FRVhzNa7rRusXHfIz8daUjQUpq0icE1SY=;
        b=OkpPf41Xp+J4Kn22cjBMOJpdqjQoOGIWxQgFpFW6M1rP7ojT+M5huPwuVPIUb/nFoE
         AL2bU6gMGW1AOJx1JcIyFitX8N/HiEu9duxon9XGsau0F/2qxnmYxkXQlbik1ZceSxXt
         tutd5E4HtCWDEV7Hk++HJITbcXsO2+zKTgpDVOtFNHHRQ+ujxmcHQNODmil8mzhhQmFd
         Q2HUZIMwC3FBZeIMkuhpenhaSucIl7TQh8EOXoAmWmGucfCloqhNZzDNXjHd07HPl0uO
         pCSKspCNCvi0ntFXBEceg/XfQ+5VpE7TTS8aIHC17rCK1UctOUhw0fhBoePcWB2E4Dpk
         ysJw==
X-Forwarded-Encrypted: i=1; AJvYcCUVrmAS44L2aIljnybuGwbBeUb2FRfZco8phYWm/uJYQ7XL81FPw4SwhcrJW42DVRcWk4MVuRlbrLHH8lHUM+8pnFmnVmysjRHIsNu7
X-Gm-Message-State: AOJu0YxMteSh6TWxX2oWm0Mf3N/Ba+sIzwqdd2iGMoWfUnzAXBR0A4tX
	1zaPTsH3XijsJ5mrqAA7OHo0gWOY41slYT/Z0Jgt7rkmYsq4ck0y
X-Google-Smtp-Source: AGHT+IGfSsAqjNtOUpM4VVF5QwRLL78xs/D2lW+2NQL//NMV7n0myPbPXpX+umYlGfSbQ5qvxqe3wA==
X-Received: by 2002:a50:ee0b:0:b0:58d:836e:5d83 with SMTP id 4fb4d7f45d1cf-594ba59f8eamr535289a12.22.1720486579362;
        Mon, 08 Jul 2024 17:56:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bda30f0csm416259a12.88.2024.07.08.17.56.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2024 17:56:18 -0700 (PDT)
Date: Tue, 9 Jul 2024 00:56:18 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, rppt@kernel.org,
	akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
	mjguzik@gmail.com, tandersen@netflix.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_free_pages()
Message-ID: <20240709005618.a4uvufvnledd4vb5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240708010010.32347-1-richard.weiyang@gmail.com>
 <e84fcec1-31bc-4397-851a-da70dd754b19@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84fcec1-31bc-4397-851a-da70dd754b19@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jul 08, 2024 at 09:56:21AM +0200, David Hildenbrand wrote:
>On 08.07.24 03:00, Wei Yang wrote:
>> During bootup, system may need the number of free pages in the whole system
>> to do some calculation before all pages are freed to buddy system. Usually
>> this number is get from totalram_pages(). Since we plan to move the free
>> pages accounting in __free_pages_core(), this value may not represent
>> total free pages at the early stage, especially when
>> CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
>> 
>> Instead of using raw memblock api, let's introduce a new helper for user
>> to get the estimated number of free pages from memblock point of view.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: David Hildenbrand <david@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> 
>> ---
>> v4: adjust comment per david's suggestion
>> ---
>>   include/linux/memblock.h |  1 +
>>   mm/memblock.c            | 20 ++++++++++++++++++++
>>   2 files changed, 21 insertions(+)
>> 
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 40c62aca36ec..7d1c32b3dc12 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>>   phys_addr_t memblock_phys_mem_size(void);
>>   phys_addr_t memblock_reserved_size(void);
>> +unsigned long memblock_estimated_nr_pages(void);
>
>^ stale name

My bad.

>
>>   phys_addr_t memblock_start_of_DRAM(void);
>>   phys_addr_t memblock_end_of_DRAM(void);
>>   void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index e81fb68f7f88..26162902789f 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1729,6 +1729,26 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>>   	return memblock.reserved.total_size;
>>   }
>> +/**
>> + * memblock_estimated_nr_free_pages - return estimated number of free pages
>> + * from memblock point of view
>> + *
>> + * During bootup, subsystems might need a rough estimate of the number of free
>> + * pages in the whole system, before precise numbers are available from the
>> + * buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the numbers
>> + * obtained from the buddy might be very imprecise during bootup.
>> + *
>> + * While we can get the estimated number of free pages from memblock, which is
>> + * good enough for estimation.
>
>I'd drop that sentence.
>

Will update it.

>
>Apart form that LGTM
>
>-- 
>Cheers,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

