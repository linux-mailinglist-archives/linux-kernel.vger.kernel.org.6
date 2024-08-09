Return-Path: <linux-kernel+bounces-280751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367B94CE9D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424EC1C21166
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE10A19049A;
	Fri,  9 Aug 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilZJA6z9"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EABA41;
	Fri,  9 Aug 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199487; cv=none; b=tqDB6Sz7Qqw16hiJqiFN4xcqxYEG92XND6TFw2rSaWQsiXhWJqhHmjZSVlYo6y4uEl+V4oEKMSbvEo7Jd4wReWqHwYd04KLRlA7ewMpKC2YPKiuoVus24+ma29hlz6qwGCx0+eUPi0/0VdUtMA5uEIy8W0Xai3o1OPJBmx/c9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199487; c=relaxed/simple;
	bh=DtNOSx5uJmg562IfzMov0Ka7Y/CuGMi+ySL1Q1TfgUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMoaOBGxt7z7IkVjzjor8cdInZmr1t2jafo0UyC/9HV0zGt41iXG1O+JSZT/DuNlzodNmwb3I7e4udCBinAncFNuMDqVuEBC5jmN5TrIG5oj3lcCTmYSyYXvxfd5f8V49oA8X9myBzkNVbdmH08TkSYwa1yeJDNqc4wpsmo+ggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilZJA6z9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso1872937a12.0;
        Fri, 09 Aug 2024 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723199484; x=1723804284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+H3eyHtXbgtv4OaC7MvOOPUY9/9WMhUrsBtexcGajXA=;
        b=ilZJA6z9n2l09qSA5sn+5AKo5OHdIx+FfMvlJJ4qVXUFFSme+RXdAtgILpaTypJ3HK
         +5a+zcvKJJ3nCc8d/n8snMsRKs0ZpLT9AGJwYGjLgS//HWjyUPi27Ll0ZENT1XF3Znvc
         JML3JErKj7uRmpCwcs0gkJijQlj7tCp9Cdhlk+aLtSQMdJFyFX5RYm/aBWKCrwAZ9HYr
         yuYpZpVKhkdg93rwNF1xZVijVOhXMH7R7OUQ4Ex9g3JszDLaVoKCuvRVC+1dkQC/x65Q
         Q+26cDKhejXgkZ5RTJY0+MuGl4aVNhZ4Qpdl4YX2IfSY0dD0+YWvXWI/f1c/7Yq8Y4Rb
         bedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723199484; x=1723804284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H3eyHtXbgtv4OaC7MvOOPUY9/9WMhUrsBtexcGajXA=;
        b=QzTaCcBRngGZ3zfA9iqsUWC1A8lYRJXyCAZpkY2kvcvbHZ0urB6EqDxyzQvnPS/1au
         HydFNUUBpLdQEFPzAv+dBn2VVCgYEshmXasYlCCmxtdnSpIJi3QLJiB5tDVwWZoVJUyy
         HRuCS7XPC+WAMCvIdv213llXc9MWM+MTd5ExS+vtWRQ7NcihLw7o0TOshqw4y0aJfSnv
         moWDh75g6L7XBH4C0+PjlIJM6eHMM8Kr2R15NuspmP364LJaxqFUAWDsdoPltoCuP7C6
         6Yc4unC5e4Ajp4oM36ydZIaE/n8xe+40cIIHhB3q5MKtk/FeYjVI1u7INYN4r4GCrGq1
         fuzg==
X-Forwarded-Encrypted: i=1; AJvYcCUOsFxgHBMxEVTfOioSJdQyEE39loEqr8itMcDigqikSclQDhFeb5d8sY/04a24GjdzotvtyJYPoRalDUCV@vger.kernel.org, AJvYcCWKOESmI8LQQd4C/cxPlooO+JRIGB1YMHGZWPwG4LF8Nkt8QExhZlxAzXu22HYGVHSHI3ofsNOesn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs82yrDfocmu/6tAAvVENVdficcFlPM8oLlt8O/mbM1xF7G+if
	yBLoVXIJ6a/RfZQOTBpGDkNN9/bjjvHsjGuwLYMrRW8sTRnuk9Ylvk04Kw==
X-Google-Smtp-Source: AGHT+IEQGpPT26AOYC9chXY6sOBc3bShNjn3DG5YtMRlhutES2lt4BeO3HvDqYZ3czZyw6CPjqUUeA==
X-Received: by 2002:a05:6402:3885:b0:5bb:9ae0:4a47 with SMTP id 4fb4d7f45d1cf-5bd0a56681cmr673021a12.17.1723199483082;
        Fri, 09 Aug 2024 03:31:23 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:b73e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d35351sm1400544a12.60.2024.08.09.03.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 03:31:22 -0700 (PDT)
Message-ID: <c0ed5796-a6a6-4757-b7df-666ba598d9fe@gmail.com>
Date: Fri, 9 Aug 2024 11:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: split underutilized THPs
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
 <20240807134732.3292797-5-usamaarif642@gmail.com>
 <5adb120e-5408-43a6-b418-33dc17c086f0@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <5adb120e-5408-43a6-b418-33dc17c086f0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08/08/2024 16:55, David Hildenbrand wrote:
> On 07.08.24 15:46, Usama Arif wrote:
>> This is an attempt to mitigate the issue of running out of memory when THP
>> is always enabled. During runtime whenever a THP is being faulted in
>> (__do_huge_pmd_anonymous_page) or collapsed by khugepaged
>> (collapse_huge_page), the THP is added to  _deferred_list. Whenever memory
>> reclaim happens in linux, the kernel runs the deferred_split
>> shrinker which goes through the _deferred_list.
>>
>> If the folio was partially mapped, the shrinker attempts to split it.
>> A new boolean is added to be able to distinguish between partially
>> mapped folios and others in the deferred_list at split time in
>> deferred_split_scan. Its needed as __folio_remove_rmap decrements
>> the folio mapcount elements, hence it won't be possible to distinguish
>> between partially mapped folios and others in deferred_split_scan
>> without the boolean.
> 
> Just so I get this right: Are you saying that we might now add fully mapped folios to the deferred split queue and that's what you want to distinguish?

Yes

> 
> If that's the case, then could we use a bit in folio->_flags_1 instead?
Yes, thats a good idea. Will create the below flag for the next revision

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..5825bd1cf6db 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -189,6 +189,11 @@ enum pageflags {
 
 #define PAGEFLAGS_MASK         ((1UL << NR_PAGEFLAGS) - 1)
 
+enum folioflags_1 {
+       /* The first 8 bits of folio->_flags_1 are used to keep track of folio order */
+       FOLIO_PARTIALLY_MAPPED = 8,     /* folio is partially mapped */
+}
+
 #ifndef __GENERATING_BOUNDS_H


and use set/clear/test_bit(FOLIO_PARTIALLY_MAPPED, &folio->_flags_1) in the respective places.

> 
> Further, I think you forgot to update at least one instance if a list_empty(&folio->_deferred_list) check where we want to detect "partially mapped". Please go over all and see what needs adjustments.
> 

Ah I think its the one in free_tail_page_prepare? The way I wrote this patch is by going through all instances of "folio->_deferred_list" and deciding if partially_mapped needs to be set/cleared/tested. I think I missed it when rebasing to mm-unstable. Double checked now and the only one missing is free_tail_page_prepare ([1] was removed recently by Barry)

[1] https://lore.kernel.org/lkml/20240629234155.53524-1-21cnbao@gmail.com/

Will include the below diff in the next revision.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aae00ba3b3bd..b4e1393cbd4f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -957,8 +957,9 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
                break;
        case 2:
                /* the second tail page: deferred_list overlaps ->mapping */
-               if (unlikely(!list_empty(&folio->_deferred_list))) {
-                       bad_page(page, "on deferred list");
+               if (unlikely(!list_empty(&folio->_deferred_list) &&
+                   test_bit(FOLIO_PARTIALLY_MAPPED, &folio->_flags_1))) {
+                       bad_page(page, "partially mapped folio on deferred list");
                        goto out;
                }
                break;

> I would actually suggest to split decoupling of "_deferred_list" and "partially mapped" into a separate preparation patch.
> 
Yes, will do. I will split it into 3 patches, 1st one that introduces FOLIO_PARTIALLY_MAPPED and sets/clear it in the right place without introducing any functional change, 2nd to split underutilized THPs and 3rd to add sysfs entry to enable/disable the shrinker. Should make the patches quite small and easy to review.


