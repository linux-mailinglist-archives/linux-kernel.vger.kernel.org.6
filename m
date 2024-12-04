Return-Path: <linux-kernel+bounces-431639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE28B9E3FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2931618FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B80720CCC5;
	Wed,  4 Dec 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oBkh3P/J"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0FE182D9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330173; cv=none; b=p06sZ/b6ugi8qsiWZjYYPIlQEIZoVscSpNobQbN9Ql36AC1AhBC9drIrah/Hpz+X+yxRiXblRNWOJcq2rkLh1XwbJttLhRgVFoomuVHbMPdniPaon4lBB9XlvndSMapw5+87PIH5/3x5mqyxv7Hs7RLgdy3cR4wMddf5cK7ZbvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330173; c=relaxed/simple;
	bh=XIp2HnEBwxrCbQQ7Wteksg6Xj0ba4HtjLTdVyqpEJvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBhtGmI0CLZSUPitZMj004EWVCYh/WcwxcS2TroKVxYHJu2xqtl14+petBNaCUC41pKD0XNdCZ247scn5EAu40pzfm69aY47SiXRLZW5VrIes8azGqLvaz355wtFqz6BknEsMXa4jip6U8VaSUeAaqe6L/DVW38cApYWT2CxN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oBkh3P/J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215770613dbso31815325ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733330171; x=1733934971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBbo3x7wMFASP+XmblVLwMY6/AMJyW6BW/SbEh64LkY=;
        b=oBkh3P/JffZWQNJJJ0csj7vVSOYBFU2zv58GYJm2LMH1maOToFJX84ltqLRPhLehgR
         F36h89bVg4FOuCI35Uq31MjY1yXIZjtP/WaJOm/rcb61GfVMUsajS2uMigEd+Jd8r7jz
         U4yJMZw0d6Zvt5N7F5l+LwaDlY0gCUGBLn15Xp4+KEvDAbpqFhhB+rRRoKyOEBS8WMKe
         uIbsl9bXKVD6zxjLFejmkycc500ITeQ4MaqGiStaHQHt+31K2vHhClh5yq7KDG7WdcGT
         Dv7mAh44HKiYkAyHexQZsAqEUKiSqzxvU6p87kFYjec93AC7xN1pGzNIKWfCAXibroeJ
         dtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330171; x=1733934971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBbo3x7wMFASP+XmblVLwMY6/AMJyW6BW/SbEh64LkY=;
        b=k7w9TPaV34nUPK1SdZ5qNBXF9cv12q9pLP3+5t6abpvKgQcrSIE0qhx8zVa/kP81WO
         D8wZ2j73cNnHsOwY2oZ7rFA9wZWH9jCsrb5XslOA7ySfrlVb73WYSLIB47E7Mj8PGd49
         N3lC6mqOHKXdHBG1YhRW1ttel9sxUAogqQwErrBr61GTPyIwezVC330azTzgJs1FfSdK
         z0UjTAaeQP47MfWC0UqFC+KU2TQmQ+RLhs/1arny2TI/ZiAi8InN3P6ynu51AyP2X47L
         G4PWxz88KgTTc1jJuFPHpYHh9ofgT0uf5MSp0P/0vO2lJOjvBQQkUo2yTAV1Oaguq2Jo
         ZGpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB0RVSzcUGB1ZTMivRx0JQjdbpW2c1A5we4qkYqtrIn7rNYAjKWBL7+9pF9A1M2j7nc2rXgbS2/qHddn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTafkdFMfe3mjMDj7Jyaka1L5Khqq/x1FlvGF/OI31JCwrDivk
	carEWOvpxMOZv159FAHxnHtMoq7pLo9SCvPjolmW5PbjDYGgbc1f8uMLThXjSkw=
X-Gm-Gg: ASbGncvIzbZnw059gnk/maIpKqmCa3SjnM8R+Q0AfFrl5T7zxblk6zVM7yJz8FBOkKC
	/JpJ2OErjVQ25OYmjgBeNIehvvxrMaX5sr00zP2SfNLiE/bzhEEdvdtud/xdzQcbDy82Lkm6zIG
	GN0IIHFN/vxdWzn1Z7rd5rACbIWtZ/5DI/NAGq/Z4KrAGkQdqT1acUteUHscG8RbsyBovT74RHx
	sLUjhm2+Wt2rkHAAMJjOInYSoCzoc9Uxr/gnSq+nW5Y9MiUgcmIRGt1BA==
X-Google-Smtp-Source: AGHT+IFq0BWXPoO7jWkTFXTi5lL/pCwZIadLDCF1MS35XKXYXClo4zLPDa/VIHisfmZxq+inWAb0tA==
X-Received: by 2002:a17:903:1c9:b0:215:6211:693 with SMTP id d9443c01a7336-215bd18ed72mr65189235ad.57.1733330171446;
        Wed, 04 Dec 2024 08:36:11 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:a7a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c52b6sm113227935ad.254.2024.12.04.08.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 08:36:10 -0800 (PST)
Message-ID: <2c851bce-a65e-4132-9e0b-e7519e22dbca@kernel.dk>
Date: Wed, 4 Dec 2024 09:36:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, kirill@shutemov.name,
 bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241204055241.GA7820@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 10:52 PM, Darrick J. Wong wrote:
> On Tue, Dec 03, 2024 at 03:41:53PM -0700, Jens Axboe wrote:
>> On 12/3/24 3:16 PM, Christoph Lameter (Ampere) wrote:
>>> On Tue, 3 Dec 2024, Jens Axboe wrote:
>>>
>>>> I actually did consider using some form of temporal, as it's the only
>>>> other name I liked. But I do think cached_uncached becomes pretty
>>>> unwieldy. Which is why I just stuck with uncached. Yes I know it means
>>>> different things in different circles, but probably mostly an overlap
>>>> with deeper technical things like that. An honestly almost impossible to
>>>> avoid overlap these days, everything has been used already :-)
>>>>
>>>> IOW, I think uncached is probably still the most descriptive thing out
>>>> there, even if I'm certainly open to entertaining other names. Just not
>>>> anything yet that has really resonated with me.
>>>
>>> How about calling this a "transitory" page? It means fleeting, not
>>> persistent and I think we have not used that term with a page/folio yet.
>>
>> I also hit the thesaurus ;-)
>>
>> I'm honestly not too worried about the internal name, as developers can
>> figure that out. It's more about presenting an external name that sys
>> developers will not need a lot of explaining to know what it's about.
>> And something that isn't too long. BRIEFLY_CACHED? TRANSIENT_CACHE?
>>
>> Dunno, I keep going back to uncached as it's pretty easy to grok!
> 
> <shrug> RWF_DONTCACHE, to match {I,DCACHE}_DONTCACHE ? ;)
> 
> They sound pretty similar ("load this so I can do something with it,
> evict it immediately if possible") though I wouldn't rely on people
> outside the kernel being familiar with the existing dontcaches.

Naming is hard! Most people do seem to grok what uncached means, when
I've shopped it around. The fact that it does use the page cache is
pretty irrelevant, that's more of an implementation detail to solve
various issues around competing users of it. That it doesn't persist is
the important bit, and uncached does seem to relay that pretty nicely.

-- 
Jens Axboe

