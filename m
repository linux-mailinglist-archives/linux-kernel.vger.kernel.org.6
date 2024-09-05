Return-Path: <linux-kernel+bounces-316826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B596D5E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AEA1C250A6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB3519D899;
	Thu,  5 Sep 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF0/jBF9"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC619D095;
	Thu,  5 Sep 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531689; cv=none; b=aIng4cpwP9Xr5rvniaaNOncZulOzrOBkILC/8Dd8UBdLT8vj9jtLcBiMv7+J2X5EetdcmtE/wMpFGj6IdmstURiNksIGca/zxNXNh4LWMZRGgFnaRM9Fdj0Z4XlYNX86XhaSEQE5TdVc92H2lAy5KM4NUd/qIz0d59KHTM8FamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531689; c=relaxed/simple;
	bh=TaJcLnRPtL91S/LQ+7NpJUuA6OprloQJTvp6vXOn0FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgaoP0foRnud8Awy6PM4XGaf5ijJYWHa5lp/8qbiT8+zscfU70jXEUqiraREHd49RQJvoTkL6hok3ZvzJLsEaZ1fRpI5322X4bwQ9LZxzyjPG7z6lR+lkATze/Av2/ARjZ3G/MTnycH+BVReng3PwkqTfX08w0DiVSaURBgjy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF0/jBF9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f4f505118fso6600431fa.3;
        Thu, 05 Sep 2024 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531686; x=1726136486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWUmOKRHUFdWNzdh5pw1Ez/2T72/kqrXnIrfhfqLjOw=;
        b=lF0/jBF9Q4x/eW18WcQFXpOeS2D+uUI71OJfmYQJ1dELXwBSbZkwp3wzzLji+xxGlC
         j5pRfxOhIFzePzv21BIW+7kpaYRBOeZO0lF9ffCcg1JIWboMzakzdYeZGA5DpAgkO89Q
         ALang7vOJ+m70CbO3uFyXWNjcqI7l0IM+RMjnfCr9pY2gt6IoUNeTXJkTCs18wSBS4qb
         cGb+Hot2EJQQ1+OzkDrdkONna2RsT+Bt3vSSylu6YAUUIaa93tB9pT+OUEK+Af5LTfns
         F7B/OBLFc/oU6YDpTOa8bQUlCJtMDLO+cYPVIIynAFW2yA5Bx1lsCr8O0c4qv50V32T3
         H1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531686; x=1726136486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWUmOKRHUFdWNzdh5pw1Ez/2T72/kqrXnIrfhfqLjOw=;
        b=YSWM570+upo5YLeV4zRQ4QqczJy1W4QZLWo7JrYzSESzCsZfwg2kMSdox220z8q7Sb
         Glqz0VGAngFFA6Ufuhw+ElqbCp7/PpkaQt27brLb/gBAPLLEI09/hLIEARyIc54VdbuJ
         jjyoEG9+uz4xjGE90usYg7hBpLlQHbpUg9WtL0mNxt6ONGqxAz0PVrBdvYXHlXhT8D6q
         6QaUMRiCGNWDznGz3AARttIYepdey479i6nqlD2itpphw1xvq+BLqub7YHBECJGoS3r7
         8C4G9P8XY8/iQJ2cg6o8yOTsVA0mYoBxswx0Jt9tiuB1AFzQQuy3njoKSvexENZpa/Gn
         JO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgTtzV/k2cpV/jcTdbnHAS0ueiG8p9UJ4CXYynuhGlAZm5rIBPXbp/CM4z3ZJ8meJK+NNft80/67kby9zK@vger.kernel.org, AJvYcCXfiUkWWRRUTb9fJjpFdmKwVumBLbRJEbvkdYofeVSc1aFPftsXdy3+nJcqZtaVXCiatpPGBB9Jxss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyID7k0CpAB+UZu5MhSmUr5OfgnC3wEwmRjhXB90O9rhCYE+PNg
	+ux8A+NZpv13ct21JRNxTCcA5JIqfzCnuleYItHGHY1o0T8csftq
X-Google-Smtp-Source: AGHT+IE4tuR7i13hi7xoa6Z32tZC3aqE0CEUTpKvkNhLfuBTyGVZxY/7WThhqRCv/GWXoJeYnISRhA==
X-Received: by 2002:a2e:a544:0:b0:2ef:2b06:e554 with SMTP id 38308e7fff4ca-2f626565176mr137523161fa.15.1725531685237;
        Thu, 05 Sep 2024 03:21:25 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:decd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc568559sm1031499a12.42.2024.09.05.03.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:21:24 -0700 (PDT)
Message-ID: <1ffdf94d-ce3f-4dac-8ed3-0681f98beebf@gmail.com>
Date: Thu, 5 Sep 2024 11:21:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] mm: free zapped tail pages when splitting isolated
 thp
To: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, roman.gushchin@linux.dev, david@redhat.com,
 npache@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Shuang Zhai <zhais@google.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-2-usamaarif642@gmail.com>
 <1d490ab5-5cf8-4c16-65d0-37a62999fcd5@google.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <1d490ab5-5cf8-4c16-65d0-37a62999fcd5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/09/2024 09:46, Hugh Dickins wrote:
> On Fri, 30 Aug 2024, Usama Arif wrote:
> 
>> From: Yu Zhao <yuzhao@google.com>
>>
>> If a tail page has only two references left, one inherited from the
>> isolation of its head and the other from lru_add_page_tail() which we
>> are about to drop, it means this tail page was concurrently zapped.
>> Then we can safely free it and save page reclaim or migration the
>> trouble of trying it.
>>
>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>> Tested-by: Shuang Zhai <zhais@google.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> 
> I'm sorry, but I think this patch (just this 1/6) needs to be dropped:
> it is only an optimization, and unless a persuasive performance case
> can be made to extend it, it ought to go (perhaps revisited later).
> 

I am ok for patch 1 only to be dropped. Patches 2-6 are not dependent on it.

Its an optimization and underused shrinker doesn't depend on it.
Its possible that folio->new_folio below might fix it? But if it doesn't,
I can retry later on to make this work and resend it only if it alone shows
a significant performance improvement.

Thanks a lot for debugging this! and sorry it caused an issue.


> The problem I kept hitting was that all my work, requiring compaction and
> reclaim, got (killably) stuck in or repeatedly calling reclaim_throttle():
> because nr_isolated_anon had grown high - and remained high even when the
> load had all been killed.
> 
> Bisection led to the 2/6 (remap to shared zeropage), but I'd say this 1/6
> is the one to blame. I was intending to send this patch to "fix" it:
> 
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3295,6 +3295,8 @@ static void __split_huge_page(struct pag
>  			folio_clear_active(new_folio);
>  			folio_clear_unevictable(new_folio);
>  			list_del(&new_folio->lru);
> +			node_stat_sub_folio(folio, NR_ISOLATED_ANON +
> +						folio_is_file_lru(folio));

Maybe this should have been below? (Notice the folio->new_folio)

+			node_stat_sub_folio(new_folio, NR_ISOLATED_ANON +
+						folio_is_file_lru(new_folio));

>  			if (!folio_batch_add(&free_folios, new_folio)) {
>  				mem_cgroup_uncharge_folios(&free_folios);
>  				free_unref_folios(&free_folios);
> 
> And that ran nicely, until I terminated the run and did
> grep nr_isolated /proc/sys/vm/stat_refresh /proc/vmstat
> at the end: stat_refresh kindly left a pr_warn in dmesg to say
> nr_isolated_anon -334013737
> 
> My patch is not good enough. IIUC, some split_huge_pagers (reclaim?)
> know how many pages they isolated and decremented the stats by, and
> increment by that same number at the end; whereas other split_huge_pagers
> (migration?) decrement one by one as they go through the list afterwards.
> 
> I've run out of time (I'm about to take a break): I gave up researching
> who needs what, and was already feeling this optimization does too much
> second guessing of what's needed (and its array of VM_WARN_ON_ONCE_FOLIOs
> rather admits to that).
> 
> And I don't think it's as simple as moving the node_stat_sub_folio()
> into 2/6 where the zero pte is substituted: that would probably handle
> the vast majority of cases, but aren't there others which pass the
> folio_ref_freeze(new_folio, 2) test - the title's zapped tail pages,
> or racily truncated now that the folio has been unlocked, for example?
> 
> Hugh


