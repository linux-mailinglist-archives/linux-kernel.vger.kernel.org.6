Return-Path: <linux-kernel+bounces-224073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6147911CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F681F22DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDD316B72E;
	Fri, 21 Jun 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIK7GzkO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3012BEBE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955085; cv=none; b=Xjb4+XOM+UxvM6q7TE9F3n9vPuim5l+4FJxjGRNCvdLKxEKPdHDsqTsip0d5I72Guwe/4cCR8co+yTTyCzMN2UA7sfmn+k7QcOPJQ+XvLU56JEVUf/LmxgzRN/a7BUJd0lEovU8s8p5B9BC7tW3ecR2m4jvS1D1ey7wq3U87ABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955085; c=relaxed/simple;
	bh=ALwdtUD/YHsGnL/G8pNXuGO20B79QLbb9uTamfeIQT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFpfdfGOzbyN/x4Lp1Z8S0//YpDd/j6gLG8sDKov8aNjhWlgsi/LuwiviQ7EOyjGXfqibfzA7GNzpe7q1KoquYqSFVktKYHVVEqFcsXucsHDzX7V4N6qRWDrJPHWIhPEkIld+dNZKb2fY8vqWPyoqksQSn4PkRfyeznr6pKaOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIK7GzkO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718955083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I3hxK8GFs+pdrXE1ju6QkzGBjzD4c6Z8f6FP/BqeI0g=;
	b=dIK7GzkOyiv/RnKR08rDNgfgDRZ9cogKFd6Y3PD1EosUmAO3eGtHi8ycgQ0B6ee5LvZHrR
	pSV1J1dNtzZDGylFMV6RoMeP9CLcO8OYvDu+Je996xApWcs8ewPlzBSW28YJryroD7QF5Q
	KMDEKC//xhj8CWLv+JaO3dKjIVsE5Ik=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-t5oDru4IO0OHG3J95_Rqaw-1; Fri, 21 Jun 2024 03:31:21 -0400
X-MC-Unique: t5oDru4IO0OHG3J95_Rqaw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ec4d8ceaafso3768911fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955079; x=1719559879;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I3hxK8GFs+pdrXE1ju6QkzGBjzD4c6Z8f6FP/BqeI0g=;
        b=tu4TMRktQMDIJ3ZEtT+day6e22TYEHUbjsXlOSmln2KKEdiYV6zVepmomqg7dHldNj
         6tQgZMKtAQBgzJ3XWbwVIxKd2rQRzmnjcSAKqo9DTXoVK+bigyrVUeQUg5dQUlFOv5q9
         6FAPUg+ITDFkNA8RifV7jtF9ZiNf98OZYQ79bTgmVjO6Bdt8x5l2hs0jNRDar2qEBLQt
         Zb6Ha/I4opgUuUwlgVdFgD1rjw55ZAl+ww71Ra+ZOBI0+EAXK1gveTPziN1NGZlX5Bhb
         Uak1Vac32yXv2m+dCBvenIaadY9E7M1LrPIzTGz1fXWo/bcbpkQbOc7CBUnAXyALQ3EU
         xnyA==
X-Forwarded-Encrypted: i=1; AJvYcCXv+Gci6c5kwHFJxGC9888Hq57bQEaRvPf18glM1liMV0LwCzFdbEOFx8VSajn8smuPFaqdfrJ/1EO6fvaKEnMLLymHcp2UWkjELFpa
X-Gm-Message-State: AOJu0YyMXFiEQsNZdFJSu2YctuvaTQDAfx9wspxbu6uAOXMFFEx8o/KZ
	4lC8gj1VQkpu3Na4Gy5o7KIQu+K6AqLP9DF7N/HuPUhxY9GaROnZpPheMRaQELokahyA8UDl+x7
	yXk+G7ZVSfj25b9HEVPEqUY7iheIuY+sDmGxm07EhzlLEmgl6m2y5bE1j26qdHw==
X-Received: by 2002:a2e:8011:0:b0:2ec:575:bf9f with SMTP id 38308e7fff4ca-2ec3cfe9355mr59901951fa.37.1718955079651;
        Fri, 21 Jun 2024 00:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvSDINZZGTjSWzz8ACtz4MjhzWJ2hdBJJtS1gev/Cr5eysxRW4Ng+j3zS0YvUcof2VdpUqqA==
X-Received: by 2002:a2e:8011:0:b0:2ec:575:bf9f with SMTP id 38308e7fff4ca-2ec3cfe9355mr59901651fa.37.1718955079172;
        Fri, 21 Jun 2024 00:31:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:e600:4063:2059:fd18:9d65? (p200300cbc725e60040632059fd189d65.dip0.t-ipconnect.de. [2003:cb:c725:e600:4063:2059:fd18:9d65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6355sm51444295e9.2.2024.06.21.00.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:31:18 -0700 (PDT)
Message-ID: <10cd22d3-cb58-4ec9-a22d-5b8555044623@redhat.com>
Date: Fri, 21 Jun 2024 09:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
To: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <05b89531-4103-49cb-bbbf-5a2cfaa3106b@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <05b89531-4103-49cb-bbbf-5a2cfaa3106b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.06.24 06:07, Baolin Wang wrote:
> 
> 
> On 2024/6/21 05:29, David Hildenbrand wrote:
>> Currently we always take a folio reference even if migration will not
>> even be tried or isolation failed, requiring us to grab+drop an additional
>> reference.
>>
>> Further, we end up calling folio_likely_mapped_shared() while the folio
>> might have already been unmapped, because after we dropped the PTL, that
>> can easily happen. We want to stop touching mapcounts and friends from
>> such context, and only call folio_likely_mapped_shared() while the folio
>> is still mapped: mapcount information is pretty much stale and unreliable
>> otherwise.
>>
>> So let's move checks into numamigrate_isolate_folio(), rename that
>> function to migrate_misplaced_folio_prepare(), and call that function
>> from callsites where we call migrate_misplaced_folio(), but still with
>> the PTL held.
>>
>> We can now stop taking temporary folio references, and really only take
>> a reference if folio isolation succeeded. Doing the
>> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
>> to how we handle MADV_PAGEOUT.
> 
> s/golio/folio
> 
> Make sense to me. Feel free to add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


Thanks!

[...]

>>    	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
>>    			    nr_pages);
>> -
>> -	/*
>> -	 * Isolating the folio has taken another reference, so the
>> -	 * caller's reference can be safely dropped without the folio
>> -	 * disappearing underneath us during migration.
>> -	 */
>> -	folio_put(folio);
>> -	return 1;
>> +	return 0;
>>    }
> 
> (just a nit: returning boolean seems more readable)

"return true" on success really is nasty in a code base where most 
functions return "0" on success. Like most functions in mm/migrate.c -- 
like migrate_pages() -- do.

Thanks!

-- 
Cheers,

David / dhildenb


