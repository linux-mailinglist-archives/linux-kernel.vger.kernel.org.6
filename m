Return-Path: <linux-kernel+bounces-429625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487A9E1EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B488162F63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975AB1F4279;
	Tue,  3 Dec 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwbdnbGG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5321CF8B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235135; cv=none; b=CHsAxNmKrSBcuKsiWuYnDZ2HVrK7pCwQl26fT+6rvaCMASjN4TIeEKkYGp4byLrfrmNsUyQ3a690jo/01RkVhCT8e7YrH4l8a9ORn7wGnghhM6AvSmGH3AT3CUN3eAKQtBGJqhkH2DyqsrHguZwo1MisxLmifkO1hEmIJhLogSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235135; c=relaxed/simple;
	bh=2n1hv6eRIJdRn+TvuxeSW+jSTuBwjt1Onmwjq8M3JU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeqleWlCZ1JDvlDKxOwAECemGZpZe1sRR1qO+5XrqL3hkOifeMFqJiK7WN5W4sB1haUABbWno+m1w52cIqWZAQngT6eqR/CLApUhPKFDKm/olu9gBfWYeMKL00f5mHxaDuodRjixTx0xfX5CQpAWL8KI3Oh3gUYJAS1JHz8aRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwbdnbGG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733235132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DfmOmAYsWzbzU97D/IfZswWynVBYus13MGWPWCnnhmw=;
	b=XwbdnbGGY7s6HAV/fnBVl4d0CyrWolCXWeNNJ+jlCF2ylKXpdIYKIZKNUDF/aFSX1E5l5U
	IDmbriXMF3Vz2GIqSQYimzboNaKrogRcQ8QJvyI0c/Rf90Z6nPiwKUIVPqwZJYY/FXAhFx
	KG5Qi3olpm4n/Zk6Kz2gbgxevH9KD28=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-5sEDeeD7NZO3AcuuQj2nsg-1; Tue, 03 Dec 2024 09:12:11 -0500
X-MC-Unique: 5sEDeeD7NZO3AcuuQj2nsg-1
X-Mimecast-MFC-AGG-ID: 5sEDeeD7NZO3AcuuQj2nsg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e49efd59so1493231f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235130; x=1733839930;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DfmOmAYsWzbzU97D/IfZswWynVBYus13MGWPWCnnhmw=;
        b=hVvf8etbE4cGkQly+Pex4ACPACbmvWJftRWu/C5SuehT3f4eiK0oEORkN1rSfBsqVY
         Q1nPRGEBv5tuJKkGc4U/TZuuKs/G5hHnlIE819xSy26Sd2IaGimLGPfSCbWGdhEVQP8m
         sInsZENxc/om3iYf54sR8cFleY4R7UqHvtej1N6LysE1I69RoGHPV+P5vnqr9hk7ZVaZ
         qhZs0URXBwbCuVxOcEwOpmihO1laA5cshc1qbtpUBfY7PzT9r5L6BS1eFUhe4KnN0Tc9
         2EXhvGK3euJwDlwBdgdzurN05sesjHgVbeRjMTR4hylxcHKvIIWUvyLfwNcbIa/QsgEZ
         3pYg==
X-Forwarded-Encrypted: i=1; AJvYcCWcnKK5v4uLsb9GMVLd6ghBynpYVwYtWc/0eSSoQPHKV3nEZSLZojMOLpeK5jto4KPTD5rhCqUb9f5kw4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDz1q+Bh+vk7yjRUCofO3GtkBZaGqyyb50ofi2cdgB+H2LbKAg
	T1mDdYJWyKZFszsABi3nh306qMYPEM1AAKe6yxmSyfXag9dRgLfkvBXkUMARIluION7KN0hTHpI
	u02OuuYNJMBV2odwKO+DS2Iu5TTM9MEoyTP6ngef2i/Wov0i+RxNr9vTVxVAAHw==
X-Gm-Gg: ASbGncud3iozJBYdxc1SN8fYaEr5eB9mld+BDgNoZI7vL6glkE3xeqC0B9/aOdEhXcs
	r/mSTxSFQTFAHOiEAWhh0AC+4DNGcJtf3Y3Kfufbf/UFdtf4D567PBSCKQKqXT23uj6KSVLPiOj
	otHFzY5zWaw7I8uSZAiNq10MwfklwCDhRlf0FDO+uKMV/UFDQ0qsUfSnNYTCsZC3u81/NasygI9
	/L++suZ7iL67wuaaC5PBOrxnN3BGdHf2+GAgEKVK0KAf1asGgJYwcbX9SWBQdHqjRECKb4fqFWr
	r3hPkJW6SiEOxfzzmEBoSkDcfSLiRHyOx07xSxvxIGdfknSruUA7ZXMb7ETxJEp2IpJstqBz89H
	aWg==
X-Received: by 2002:a5d:6dae:0:b0:385:e013:73f6 with SMTP id ffacd0b85a97d-385fd4358aemr2081367f8f.50.1733235130376;
        Tue, 03 Dec 2024 06:12:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcy+idlIWvQSkgkkanBxL+r+HUHonkY6filCiyNJa2RVw7yISuYzu4QI0/PKYJnAmni+KX1w==
X-Received: by 2002:a5d:6dae:0:b0:385:e013:73f6 with SMTP id ffacd0b85a97d-385fd4358aemr2081341f8f.50.1733235129950;
        Tue, 03 Dec 2024 06:12:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:1b00:fd9e:c26c:c552:1de7? (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ea9c5952sm8447173f8f.67.2024.12.03.06.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:12:07 -0800 (PST)
Message-ID: <96c92857-4850-4f85-9474-ac193c5ea48c@redhat.com>
Date: Tue, 3 Dec 2024 15:12:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the
 alloc_contig_range() gfp flags mess
To: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-5-david@redhat.com>
 <feffbbe8-4176-48e8-b503-ef53d7914197@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <feffbbe8-4176-48e8-b503-ef53d7914197@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.12.24 14:55, Vlastimil Babka wrote:
> On 12/3/24 10:47, David Hildenbrand wrote:
>> It's all a bit complicated for alloc_contig_range(). For example, we don't
>> support many flags, so let's start bailing out on unsupported
>> ones -- ignoring the placement hints, as we are already given the range
>> to allocate.
>>
>> While we currently set cc.gfp_mask, in __alloc_contig_migrate_range() we
>> simply create yet another GFP mask whereby we ignore the reclaim flags
>> specify by the caller. That looks very inconsistent.
>>
>> Let's clean it up, constructing the gfp flags used for
>> compaction/migration exactly once. Update the documentation of the
>> gfp_mask parameter for alloc_contig_range() and alloc_contig_pages().
>>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
>> +	/*
>> +	 * Flags to control page compaction/migration/reclaim, to free up our
>> +	 * page range. Migratable pages are movable, __GFP_MOVABLE is implied
>> +	 * for them.
>> +	 *
>> +	 * Traditionally we always had __GFP_HARDWALL|__GFP_RETRY_MAYFAIL set,
>> +	 * keep doing that to not degrade callers.
>> +	 */
> 
> Wonder if we could revisit that eventually. Why limit migration targets by
> cpuset via __GFP_HARDWALL if we were not called with __GFP_HARDWALL? And why
> weaken the attempts with __GFP_RETRY_MAYFAIL if we didn't specify it?

See below.

> 
> Unless I'm missing something, cc->gfp is only checked for __GFP_FS and
> __GFP_NOWARN in few places, so it's mostly migration_target_control the
> callers could meaningfully influence.

Note the fist change in the file, where we now use the mask instead of coming up
with another one out of the blue. :)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce7589a4ec01..54594cc4f650 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6294,7 +6294,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
  	int ret = 0;
  	struct migration_target_control mtc = {
  		.nid = zone_to_nid(cc->zone),
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+		.gfp_mask = cc->gfp_mask,
  		.reason = MR_CONTIG_RANGE,
  	};

GFP_USER contains __GFP_HARDWALL. I am not sure if that matters here, but
likely the thing we are assuming here is that we are migrating a page, and
usually, these are user allocation (except maybe balloon and some other non-lru
movable things).

The __GFP_RETRY_MAYFAIL should be moved to relevant callers a some point,
__GFP_HARDWALL, I really don't know ...

Thanks!

-- 
Cheers,

David / dhildenb


