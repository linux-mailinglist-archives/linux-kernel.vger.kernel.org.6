Return-Path: <linux-kernel+bounces-194402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3198D3B98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD401C24282
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BC1181D02;
	Wed, 29 May 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOYvQ2DT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0F42044
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998423; cv=none; b=ePvdtfuyFtnZrMIggno1pSsy1ZD7ogPanQ6gKwAnjMTrer0joKC4rOPTAEuxXiHsIujk8X6T81JpcjSXlseNHRvhDx981OipeWg4IB771x7Wr8mqBZm22QPTGN15g1pq+G4lV8W83BF52/cP8OvuZQ1QTDZCkStFGFYZivGukSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998423; c=relaxed/simple;
	bh=KsZu+itOh+MvfBKf5n9Y+aAS9H5rId/yaV+Uhx0XvC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTwmVpDQehUQS9RXCP32uzZXgqmcZe79MeOnjlFdBz1Wnqu7EVSFJxpnALnlwc9OC2k6PkyR/RDPpFgnyJwAa/q5GLsXFliNeQjYyLXzJta7I+AcsHzOI3BVgcSawnmp6dRHOhEPoexJTEQsY5rCMMkcEUyB0UTeiOEtf7YCQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOYvQ2DT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716998420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TKuzCUSELONIqgQVNbotEXKxMenfyryDdt7x3lwA7YA=;
	b=TOYvQ2DTSUCtJ7nR8biJyD0vb/AKFybKYwTxCsxzZMukiyt97OyMxSnCEqjHdCAEZtMOUI
	BR4rLBquDRW5gY8SDh0Txj4kAC45KbFMNcaXde30aXbrk1oFNjM8L314ecMlAWseTFdudO
	eynHl5rxckxINNzSs5oJ5Kk1VHvQnKY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-1KQV612JMsqFg3JAQFOwDw-1; Wed, 29 May 2024 12:00:19 -0400
X-MC-Unique: 1KQV612JMsqFg3JAQFOwDw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42109a85f5cso19435675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716998418; x=1717603218;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKuzCUSELONIqgQVNbotEXKxMenfyryDdt7x3lwA7YA=;
        b=F0F0VTdRciSz1sreu349a9UCGpZdylBWz32jR2u54wcRS+dAB+A4Fn19LnWi2TlL9e
         qkcbu9NVmZHw6kCtyCEmbbc5Br/F68zLGT5axOJ4avuka+y8WbmcJwgSyikQ7zFA7awe
         QLr4Wh/LedCggkzB9AA5lFJgg1Pvh5wLOCwgJV7ADsJpjSqWsLPDoTlPGMJP2y1F4fMo
         5KWibKsvkR2DKD9r2qU9mQDccZJbriD8SZbgPFpQAsXrMNHPXPpWCUjHh6mwsovOjVoQ
         vQ4GdooEmBlNG/DOcSrxduKlW6Y0gnoGPMI+sEBgwhCo7y6aB58nBbTEUN9NzasbskN1
         G9NA==
X-Gm-Message-State: AOJu0YwRScdbyezqFufUm0gdboSrR1kHKpRbDL3bKfkyV8jhMXCO7CyI
	eyHn0NwBOtDPs+jpyJfbZkY+T4D2R88/mQThkrI9QBkj6eXkTh7O2HUGy01WZAkwZKST0UXWvkp
	yneb6It7Uq/KtEn/z7Or2nxbWDfoe1RJKUxmSPgCnXEk3QzB3XP6iV3VttHL1tS1NMIcohNLYUk
	NfMJ6uYHYl1agBB9l4F2Ckqagel2R7EpLkEyKX23q+lA==
X-Received: by 2002:a05:600c:1c02:b0:41c:23f3:65fa with SMTP id 5b1f17b1804b1-42108a99cf6mr139879435e9.28.1716998417964;
        Wed, 29 May 2024 09:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8bbffO2pA5kZPA0yZ0/Ri9Y9WYow5IoHfXWKW/IOMPNF3jzZkCRpZ2AaxOoaN45KGr1mHHg==
X-Received: by 2002:a05:600c:1c02:b0:41c:23f3:65fa with SMTP id 5b1f17b1804b1-42108a99cf6mr139878855e9.28.1716998417343;
        Wed, 29 May 2024 09:00:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:3c00:686e:317c:3ed4:d7b8? (p200300cbc70c3c00686e317c3ed4d7b8.dip0.t-ipconnect.de. [2003:cb:c70c:3c00:686e:317c:3ed4:d7b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212348aa22sm29163965e9.36.2024.05.29.09.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 09:00:16 -0700 (PDT)
Message-ID: <f9b78c91-ae2f-4bb3-bf01-8f157284b2c2@redhat.com>
Date: Wed, 29 May 2024 18:00:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] mm: allow reuse of the lower 16 bit of the page
 type with an actual type
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, wang wei <a929244872@163.com>
References: <20240529111904.2069608-1-david@redhat.com>
 <20240529111904.2069608-3-david@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240529111904.2069608-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index d1bdbaaccc964..f060db808102c 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -945,15 +945,19 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
>    * mistaken for a page type value.
>    */
>   
> -#define PAGE_TYPE_BASE	0xf0000000
> -/* Reserve		0x0000007f to catch underflows of _mapcount */
> -#define PAGE_MAPCOUNT_RESERVE	-128
> -#define PG_buddy	0x00000080
> -#define PG_offline	0x00000100
> -#define PG_table	0x00000200
> -#define PG_guard	0x00000400
> -#define PG_hugetlb	0x00000800
> -#define PG_slab		0x00001000
> +#define PAGE_TYPE_BASE	0x80000000
> +/*
> + * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
> + * allow owners that set a type to reuse the lower 16 bit for their own
> + * purposes.
> + */
> +#define PG_buddy	0x40000000
> +#define PG_offline	0x20000000
> +#define PG_table	0x10000000
> +#define PG_guard	0x08000000
> +#define PG_hugetlb	0x04008000

As Wang Wei points out, the 0 and 8 look too similar on my screen ;)

This should be

#define PG_hugetlb	0x04000000

-- 
Cheers,

David / dhildenb


