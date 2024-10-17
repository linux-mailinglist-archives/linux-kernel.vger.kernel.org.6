Return-Path: <linux-kernel+bounces-369459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0679A1D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40181C23420
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD191D2F73;
	Thu, 17 Oct 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8wePuxR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C6154454
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155091; cv=none; b=KPHHZijjC0E2kl2zMJWhL+3KePlaChYouxMtUK9JmGzhSoeYXSz4Sb0QgbAeyQSUu0L5JOH1xM6qeIjMWQrCjjLIGkQLKgstduAoWjKcCzfBcN2o9yjmNlHLCZ12Op8agj93aEE1abwvFdE1XGqkhf+Z+h/lhMwEQqiSY4P0x3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155091; c=relaxed/simple;
	bh=hSRcn9gRi+91P5hs8fRDo4gEPJR7TvticdGrlQUqw5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO7zWc2ITvJNbA0aG0OL8Av197/fDHiq1No0+qyGiLjGBvKOX1DfLu6ufLwKqaJ+3RUKthhqWSk2Tt003dAFx5r3AswKvZ1l6fiJmmTpfXmkeS3OW7lUM74zwavGWpEMyoAPNLwu6UC6iW8Ikgboyhoix2tfUgvqTwSZiG1s8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8wePuxR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729155086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EN/Eizswj47pmoV3qDsAgb+fvVuBqxHIhwGCCsZ/BBk=;
	b=c8wePuxRR8/9O9iFsYRE5HqQ83CXitGvKKBwrcAlWAR/OchSizFadNZwSWgOYsSEoJAFoU
	aR2/6PZymr3dZDeJYkOF/8eiaayYolODJ6lG2IG1kRKDkvcmB9SUakKL+czY1mtLkYpC6C
	ZJrCbWPIC9tZCDOEH5UhH3P8gwVNH+0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-mSYxazipNm-KDe6eOCmAzQ-1; Thu, 17 Oct 2024 04:51:24 -0400
X-MC-Unique: mSYxazipNm-KDe6eOCmAzQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43056c979c9so5642485e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155084; x=1729759884;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EN/Eizswj47pmoV3qDsAgb+fvVuBqxHIhwGCCsZ/BBk=;
        b=XED5RuDQPyYgMG0SuPrae2O+0rKKv72HfAxJwf5e5x1Pdk6dFNjPXPqnlKe2oiD9nB
         nww0ssxtwizOALepiTGv/ZjZouctpdCRm8pozYutMDIQ+kym3Kf4qSNt27VFl+fmtvoK
         Y5VOQm7+5SSgFvgk+z5BKFuiykjrr0JPBB3ggSIbE6O8pKluzIL/p7dGF4HinS7yIAwc
         ytjeJLKvq5Cl/8OWBPP4QkKvflnpAV3b9Dc/fLuyfy7NhA0nlfDhoVCErW6L28LTVQuw
         Ryc6y5v20EyUvtqHAyIYir1leevm1GCucpDY3k0ak5eLk1CCRFsNBgtVmB9WMkuvRaRj
         psWg==
X-Gm-Message-State: AOJu0YyWzlYxqn9XRojCkBvXIwGOFRosPGwaOfihexPsnS5OR8CK0pVS
	xPVBFoaHOxS9V9U2bAkQj9V4jNyNQKv//YUxy/isRr7b7FwZRnb/Lm6a9gXkgLnF9A2g5LED9hp
	Vbd8YPbP0gsaapJdC2JnZ1FzwFEL43E+3OS3Aec6LzCF0UNl2EnCzbKVg3+9j1A==
X-Received: by 2002:a05:600c:3c9c:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-4314a32333bmr50976105e9.20.1729155083677;
        Thu, 17 Oct 2024 01:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYYhBoPFvFWP0XlaQg+uyhe3vARcgCr9/+6i0JB3VhiAXicmKPY9C+kRks11rZ04Pl5CnMrA==
X-Received: by 2002:a05:600c:3c9c:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-4314a32333bmr50975865e9.20.1729155083293;
        Thu, 17 Oct 2024 01:51:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc12dbcsm6666212f8f.96.2024.10.17.01.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:51:22 -0700 (PDT)
Message-ID: <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
Date: Thu, 17 Oct 2024 10:51:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Alistair Popple <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241016202242.456953-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.24 22:22, John Hubbard wrote:
> If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
> family of functions, and requests "too many" pages, then the call will
> erroneously leave pages pinned. This is visible in user space as an
> actual memory leak.
> 
> Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM) calls
> to exhaust memory.
> 
> The root cause of the problem is this sequence, within
> __gup_longterm_locked():
> 
>      __get_user_pages_locked()
>      rc = check_and_migrate_movable_pages()
> 
> ...which gets retried in a loop. The loop error handling is incomplete,
> clearly due to a somewhat unusual and complicated tri-state error API.
> But anyway, if -ENOMEM, or in fact, any unexpected error is returned
> from check_and_migrate_movable_pages(), then __gup_longterm_locked()
> happily returns the error, while leaving the pages pinned.
> 
> In the failed case, which is an app that requests (via a device driver)
> 30720000000 bytes to be pinned, and then exits, I see this:
> 
>      $ grep foll /proc/vmstat
>          nr_foll_pin_acquired 7502048
>          nr_foll_pin_released 2048
> 
> And after applying this patch, it returns to balanced pins:
> 
>      $ grep foll /proc/vmstat
>          nr_foll_pin_acquired 7502048
>          nr_foll_pin_released 7502048
> 
> Fix this by unpinning the pages that __get_user_pages_locked() has
> pinned, in such error cases.
> 
> Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Shigeru Yoshida <syoshida@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   mm/gup.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a82890b46a36..24acf53c8294 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2492,6 +2492,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   
>   		/* FOLL_LONGTERM implies FOLL_PIN */
>   		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
> +
> +		/*
> +		 * The __get_user_pages_locked() call happens before we know
> +		 * that whether it's possible to successfully complete the whole
> +		 * operation. To compensate for this, if we get an unexpected
> +		 * error (such as -ENOMEM) then we must unpin everything, before
> +		 * erroring out.
> +		 */
> +		if (rc != -EAGAIN && rc != 0)
> +			unpin_user_pages(pages, nr_pinned_pages);
> +
>   	} while (rc == -EAGAIN);

Wouldn't it be cleaner to simply have here after the loop (possibly even 
after the memalloc_pin_restore())

if (rc)
	unpin_user_pages(pages, nr_pinned_pages);

But maybe I am missing something.

>   	memalloc_pin_restore(flags);
>   	return rc ? rc : nr_pinned_pages;


-- 
Cheers,

David / dhildenb


