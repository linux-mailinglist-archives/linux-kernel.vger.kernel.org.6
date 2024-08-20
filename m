Return-Path: <linux-kernel+bounces-294278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED1C958B92
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCD31F2260E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985E1BB691;
	Tue, 20 Aug 2024 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPbL/008"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143018FDA9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168715; cv=none; b=Ie3Er+Ed7abqzQKLYI/PYRJcidruPyGR4zPd9JnXnJ2OjtRMeoRtojhBoezjtfsP0EzCJaCjEmNDvP25QWJUAqBZbFdJD5NEbKeQ4Hth70P3ZuQy4j+GnU4GLhEgcXM6mLelYjvCBp7AZT4Pe1kWmOXDrOhiZPtzYeGs4txAvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168715; c=relaxed/simple;
	bh=s5k0dav438HHlTLDNrAApZZSfOagAQrpp+Raf/i4tIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5n4X2boW3QI+R4M/C1YH0VOQFyrsRJHePRiIFrbU4t2Aixb2eAEyjFY1hrrvOmtWKasgnqBJoICvIiJFo5KPPm+NUGy2V2rg1RHpcP2lhFk9NqskdhNaagJ44V/hO9V0TvFd1En4m7MEggknK1JvGghurWydWb1Ft69IMxnkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPbL/008; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5e97b84fbso3284237eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724168713; x=1724773513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aG9F7n30CyAyMrE3pAZTmqYbiXUQ46lcHUXIcH0pMVA=;
        b=fPbL/0083rbYq1QZ6+Ik98dFhOL7vETAJM3D6oQZkFDqrG+LBUPKbykWazMRo0/0RB
         dyHV+RIcpgOiomS5HE3ntWFY4mCIV4wkC38ii+8uwbvawjdlM7H2g/aHAjTPV0lNvUWe
         G2DLilcIIb2X4QiDlXmSqq4ArmMYcTJSuZv4oAcKqk8Z+ly9BL6esrXjoXl11GApfUvG
         3PcIyFJ4APZ5i6Z03FaGUg2qWJ0kIN0Kmi+Y7hIiH54HdcbXcmUMS30vdqEa7RbK+9wl
         OdJMOLT9uPZivzKWhssmwpdN4Ny7eUTeFoqrEMgecfIX1yUYy+ZEMrFGV9u06eGxXPYk
         wmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724168713; x=1724773513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG9F7n30CyAyMrE3pAZTmqYbiXUQ46lcHUXIcH0pMVA=;
        b=oGAN9v6OX+nt0Rvco05jstWBFKBW5Mq1aOQS3Sn07nKds8TUc2OBZSN7DpGnPJ5bYs
         AyqY8T603Jksw+5+pev+P1f6Jkt8dDe+LHDvfno+1tWTR8V1KmhNSFHNKIvbNVXOf93/
         UjNgiZhOMjR41crkNc+FA5ga2+cWNFgT+JuwlELGWVz4RduHcOfO8zNuqpVe33NyJaSq
         o1wZnmEJuTjKdYNihcEKuSHQ+OF/QpBQSoV1kIc/bQmoQcfkA/Pxt6RN5Vs42H8wAO/m
         NlbH9+TSOBKhgM4JBw8DvC/acZHKjd4pPAp5Y6hSUE8UUDAxjR4NTsIRHwTwJcYtEREr
         7tHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqiqVWc8DXNl09BfQgoxtCUOGgqWbeA6zeaLasxkhn01I1pqMSI9K4K7WAWalkXl7VJZh95MSrqNZupME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PbJpFIaVn6+4BvjPlSZTiaXRVW6KyWQWPqr3kA1WT3esiNSN
	bXYJv7c+ZXiq7HZ3opwXGAcB/wEm0P4u0w3xwFtrDSdzsh3EiF5f
X-Google-Smtp-Source: AGHT+IFL8IL/r/7evwprQo12o/EGG7BHLI+5GZnOHOoid4wzbxJoaZHTTtuTsPd2ymN1YEHYIXoNXA==
X-Received: by 2002:a05:6359:2707:b0:1b3:94cc:6526 with SMTP id e5c5f4694b2df-1b394cc6647mr1924072855d.2.1724168713026;
        Tue, 20 Aug 2024 08:45:13 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1409:786c:cb1d:c3fb? ([2620:10d:c091:500::4:4b1f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5e8bsm539212985a.94.2024.08.20.08.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:45:12 -0700 (PDT)
Message-ID: <29e481af-b5e1-4320-a672-8251f5099595@gmail.com>
Date: Tue, 20 Aug 2024 11:45:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] mm: drop lruvec->lru_lock if contended when
 skipping folio
To: Andrew Morton <akpm@linux-foundation.org>
Cc: yuzhao@google.com, david@redhat.com, leitao@debian.org,
 huangzhaoyang@gmail.com, bharata@amd.com, willy@infradead.org,
 vbabka@suse.cz, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Johannes Weiner <hannes@cmpxchg.org>, zhaoyang.huang@unisoc.com,
 Rik van Riel <riel@surriel.com>
References: <20240819184648.2175883-1-usamaarif642@gmail.com>
 <20240819181743.926f37da3b155215c088c809@linux-foundation.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240819181743.926f37da3b155215c088c809@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/08/2024 02:17, Andrew Morton wrote:
> On Mon, 19 Aug 2024 19:46:48 +0100 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> lruvec->lru_lock is highly contended and is held when calling
>> isolate_lru_folios. If the lru has a large number of CMA folios
>> consecutively, while the allocation type requested is not MIGRATE_MOVABLE,
>> isolate_lru_folios can hold the lock for a very long time while it
>> skips those. vmscan_lru_isolate tracepoint showed that skipped can go
>> above 70k in production and lockstat shows that waittime-max is x1000
>> higher without this patch.
>> This can cause lockups [1] and high memory pressure for extended periods of
>> time [2]. Hence release the lock if its contended when skipping a folio to
>> give other tasks a chance to acquire it and not stall.
>>
>> ...
>>
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1695,8 +1695,14 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>>  		if (folio_zonenum(folio) > sc->reclaim_idx ||
>>  				skip_cma(folio, sc)) {
>>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>> -			move_to = &folios_skipped;
>> -			goto move;
>> +			list_move(&folio->lru, &folios_skipped);
>> +			if (!spin_is_contended(&lruvec->lru_lock))
>> +				continue;
>> +			if (!list_empty(dst))
>> +				break;
>> +			spin_unlock_irq(&lruvec->lru_lock);
>> +			cond_resched();
>> +			spin_lock_irq(&lruvec->lru_lock);
>>  		}
> 
> Oh geeze ugly thing.  Must we do this?
> 
> The games that function plays with src, dst and move_to are a bit hard
> to follow.  Some tasteful comments explaining what's going on would
> help.
> 
> Also that test of !list_empty(dst).  It would be helpful to comment the
> dynamics which are happening in this case - why we're testing dst here.
> 
> 

So Johannes pointed out to me that this is not going to properly fix the problem of holding the lru_lock for a long time introduced in [1] because of 2 reasons:
- the task that is doing lock break is hoarding folios on folios_skipped and making the lru shorter, I didn't see it in the usecase I was trying, but it could be that yielding the lock to the other task is not of much use as it is going to go through a much shorter lru list or even an empty lru list and would OOM, while the folio it is looking for is on folios_skipped. We would be substituting one OOM problem for another with this patch.
- Compaction code goes through pages by pfn and not using the list, as this patch does not clear lru flag, compaction could claim this folio.

The patch in [1] is severely breaking production at Meta and its not a proper fix to the problem that the commit was trying to be solved. It results in holding the lru_lock for a very significant amount of time, stalling all other processes trying to claim memory, creating very high memory pressure for large periods of time and causing OOM.

The way forward would be to revert it and try to come up with a longer term solution that the original commit tried to solve. If no one is opposed to it, I will wait a couple of days for comments and send a revert patch.

[1] https://lore.kernel.org/all/1685501461-19290-1-git-send-email-zhaoyang.huang@unisoc.com/

Thanks,
Usama

