Return-Path: <linux-kernel+bounces-208718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D24902870
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4EE288E27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FA51494B9;
	Mon, 10 Jun 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD0iSwBx"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE27E761
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043097; cv=none; b=Ax9KqLeHsDEsboqzYH2Nuy9Tt2z6nHlaMVAKE2UJrywj7D1NWtzNzuSEKpE0Yc+1FiKTBuwMapT0aMcnm1MjGx3HOS4Kr6lj5WJa3vfU9BGN043r1Shb53EK/6mYoRgh0SYSdmNxMszd8LVd9JOT67OVptkQ9gu9nPw3B3/uiow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043097; c=relaxed/simple;
	bh=hhIn4dPqyPsPULGsZbxagOtKdHsglWZaz5bDRr5/1Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAegwdgamnJuHMi3vBUW2A6m/PLUxs5QhpbZiZz3uxIFV215qcucqFuFF8CW+UJ/5DnJoouJpoiY4JgUBghcdG6N1oCikg7rdLxNpUtzCSHF/ouPHO4JhvlhgaQA+/Cm1D1PUoHMwHZ9QV6yi3zGFt69HHeKFSWyP1D+vAsWXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD0iSwBx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6efae34c83so280277166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718043094; x=1718647894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBitgYqhRpDDEUtVM72CLTY5WJYHc8q6oeiiPInU5GI=;
        b=KD0iSwBx+jmoIorH8yx7b1g9yOkLWpKC65k0yujf0MVt7Y3UE+JYC0py+O8A0LHC7n
         UgoppnSQy+c5NkqX67+JliVa5bBsTZTRWbU2y+myy0nFcnkR7BOEwuvRZ1uCtCsFvwzI
         vklmkZYbk9lOHuuqYtXyMnMda1snBwe1yH2uAGXglS5lU7Fd5ETPHmzh8JIm7UGhotyp
         tkQp1czyarbv0XiM68wavFnAYEE/x5nAFyz4yh40zCmH8/iAVQkQoNg8iQnHg/n9gS3G
         eM6GjfGecaxF+0j62pAmQ75w4ST2yd4gkh4SmR445cLQrywBm6Jea5aPyAwZC6Srhgzc
         KkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043094; x=1718647894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBitgYqhRpDDEUtVM72CLTY5WJYHc8q6oeiiPInU5GI=;
        b=dTHSS5Kv6dODRNiElKd5wWG+14pD8B309nVBB1IyCdCRTqf4VUhfFqefwxUDXVdDYx
         pgU/If0fkzTnwuP8ywhCc6vsefCvLT5H0dZfRj/tzVliNpI56JfnHXW2b0ukJvjimYIT
         Rmy4ZsDyMCdf5l4aYArff0D5b4PuGEH9ZV+iKGJVemg4iRVFY6UulIezOO3dAr9u19Rw
         v/JtC1R4/HrX57eqSOIEwklCwU86iD24zEm2ymAzrrUPgc1E5iMeZqbVGYMal95WqtTG
         w2TWAsVIXJ87NJ3tY1GdepS5FdmjSRoj/V21zXY6cDq6VynazlcGzEM7J21gvwyLJtOr
         TVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQc3PIikEYM1m4+RqXAWJiMACDjKtv+OiAz3x2JfYDEaKuaNR3KITtZ1Ye1tFlPqpKG1Ywkk19bdnvEWFQm/Pj4o1EZtyvg3nXgSna
X-Gm-Message-State: AOJu0YyGr8eIsFgewROFJ5oJ3bu2Z2GH30w7GxWJmgmrxfAOYA2cadMs
	ap3vDfneRiFZDP44AhEBLvTp96UTn+GmAgpOTbQrAE2MIXmn7BM6
X-Google-Smtp-Source: AGHT+IF0Mv0XUMU02EjNpOe4jzo3/oQog3zMX8x5oxhQnWrjVqr23TsNAWgjjb/P7RTBR1dMgNbzTg==
X-Received: by 2002:a17:907:720c:b0:a59:c367:560c with SMTP id a640c23a62f3a-a6cdb0f540fmr829869466b.60.1718043093459;
        Mon, 10 Jun 2024 11:11:33 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:493])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f27837769sm93827866b.34.2024.06.10.11.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 11:11:32 -0700 (PDT)
Message-ID: <ed4cff58-93ff-4658-bade-13a3e66cba4b@gmail.com>
Date: Mon, 10 Jun 2024 19:11:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
To: Yosry Ahmed <yosryahmed@google.com>, willy@infradead.org
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20240610143037.812955-1-usamaarif642@gmail.com>
 <CAJD7tkYdTvfO8P+aZNmr7bF7vEetxiqQQ4ML8BcLdmKohT-+Cg@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkYdTvfO8P+aZNmr7bF7vEetxiqQQ4ML8BcLdmKohT-+Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/06/2024 18:31, Yosry Ahmed wrote:
> On Mon, Jun 10, 2024 at 7:31 AM Usama Arif <usamaarif642@gmail.com> wrote:
>> start/end writeback combination incorrectly increments NR_WRITTEN
>> counter, eventhough the pages aren't written to disk. Pages successfully
>> stored in zswap should just unlock folio and return from writepage.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   mm/page_io.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index a360857cf75d..501784d79977 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -196,9 +196,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>>                  return ret;
>>          }
>>          if (zswap_store(folio)) {
>> -               folio_start_writeback(folio);
>>                  folio_unlock(folio);
>> -               folio_end_writeback(folio);
> Removing these calls will have several effects, I am not really sure it's safe.
>
> 1. As you note in the commit log, NR_WRITTEN stats (and apparently
> others) will no longer be updated. While this may make sense, it's a
> user-visible change. I am not sure if anyone relies on this.

Thanks for the review.

This patch would correct NR_WRITTEN stat, so I think its a good thing? 
But yeah as you said for people relying on that stat, suddenly this 
number would be lowered if they pick up a kernel with this patch, not 
sure how such changes would be dealt with in the kernel.

> 2. folio_end_writeback() calls folio_rotate_reclaimable() after
> writeback completes to put a folio that has been marked with
> PG_reclaim at the tail of the LRU, to be reclaimed first next time. Do
> we get this call through other paths now?

We could add

if (folio_test_reclaim(folio)) {
         folio_clear_reclaim(folio);
         folio_rotate_reclaimable(folio);
     }

to if zswap_store is successful to fix this?

> 3. If I remember correctly, there was some sort of state machine where
> folios go from dirty to writeback to clean. I am not sure what happens
> if we take the writeback phase out of the equation.
>
> Overall, the change seems like it will special case the folios written
> to zswap vs. to disk further, and we may end up missing important
> things (like folio_rotate_reclaimable()). I would like to see a much
> stronger argument for why it is safe and justified tbh :)
>
The patch came about from zero page swap optimization series 
(https://lore.kernel.org/all/ZmcITDhdBzUGEHuY@casper.infradead.org/), 
where Matthew pointed out that NR_WRITTEN would be wrong with the way I 
was doing it.

Overall, I thought it would be good to have consistency with how 
zeropages and zswap pages would be dealt with, and have a more correct 
NR_WRITTEN stat.

In the next revision of the zero page patch, I will just add 
folio_rotate_reclaimable after folio_unlock if folio is zero filled.

>>                  return 0;
>>          }
>>          if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) {
>> --
>> 2.43.0
>>

