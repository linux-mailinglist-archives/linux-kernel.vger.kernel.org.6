Return-Path: <linux-kernel+bounces-437054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C197A9E8E80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B606161175
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3AF21571A;
	Mon,  9 Dec 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBfYEHyj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A421507C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735791; cv=none; b=IXN3PCJee/lM2IiCTY2K2lOHTrfzLiNotJI+ss856YAn815CYjeH2vfhN9jBnY32BfB9yLVoPa3g9hdW3q5EEAsOLcPbew7WMdxEGOdhhZ6fpxw0QlZhEXknAAu4v4rJGiMfsFHPZyKePYctZrZ+ZZhjONvCJSONGG5DjE1n30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735791; c=relaxed/simple;
	bh=ARGkv4ntz7jCE6PFcFxgUUU57UgViLfgVP34aJh89X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kceiUcgnLBdAAX9OOvMeA/gS4gcaP4C8k6lF/oO9eAxzjvU5iuSBzzio+TEBC3LtJ51k98+jW1cXVC+1k6mx9T85J6k5LCYaLWzpWRPO+FV89wL2EoX+XUGIolSHMwh1WCOAuvvT6Hr2enimifXEgoT0I6h7B/+Qt+th3SCCVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBfYEHyj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733735786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y9+V5wEE4kJPR8DGm5Rdxd9W/bKVqSLnVntDcNoQ2jw=;
	b=SBfYEHyjMymyHy5Rpiwn6a2Eo9uaIq5v5mEzMemSmTjL1Zm7wa+W058Dw8yY1QkC8f/KDr
	aXdYaDZVEQMBKhloj5CFkb7bfjA1kaUgKhkLX1AqZbGfnNtf2KwXv+XVWC1Jl0lCq92O4N
	g3E0jMLvSbovgrGyJOVIpNYzAxq2JPc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-GZIjJuP0NgiJETF2vBYfNQ-1; Mon, 09 Dec 2024 04:16:25 -0500
X-MC-Unique: GZIjJuP0NgiJETF2vBYfNQ-1
X-Mimecast-MFC-AGG-ID: GZIjJuP0NgiJETF2vBYfNQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-386333ea577so665450f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733735784; x=1734340584;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9+V5wEE4kJPR8DGm5Rdxd9W/bKVqSLnVntDcNoQ2jw=;
        b=rB8s664lMq9ku3UlCw8uxdz4YfvczRXRgytHuWXoz3WPpN5HVJmnZOrgp78r57JNUQ
         AVvbD3yPzH7HanDdZnXzyI3Hs/KCIFIaOSPBtRQCOUei0gKW9zMsHRA0yl4ABAJby4QR
         0qrGFGbXqeaSQHwgcbjp1p9U27KBQpAKxf15F5NqR8o8vlK2Mr2RjG5jcnlEPDuxdLZy
         UYFwqd1m51bKCAw0swGZ6jzh0EKysGDW2PaaCiwhgRUePqEXMZZRkoiPp3UyH5gRQ1ub
         +E/bJ5jEY38UMATt/VfUq7izxhC3nKtp0nTJnCL6D/EOsM0lNUaPfHRcgFy2yEvvNPCN
         43dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7+hyAfUYnIY9swfdoKOVDT64uaIEkEJ5ESWX++ChsdYmIJtizg7tPZEcewvG6AKskQwyywVC3usPKWao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNHpljpfF2wdVn49hrCwZ0I8ao4bF6GnkbUPVf5pKJneM1DbY
	hpAvnp89Mzao8bBzqssKO3LnhPpCvJ5H5DGxKKyvNomr722PnhviS7OccAKCVq7OzIZbrJmWc85
	ZSeaNoT3+1q6lIqrONgbhuDhNIDFe2/t+4J/jUNNbZV705+cSGpLtKmlXXh5w1g==
X-Gm-Gg: ASbGnctr7dG6eqhdKuaUFx2RKk4nEyoYL1hRwwQvQYbVIHro0WYtn923yFi9CcD4ZKH
	i9O3mkLY0nqXUbKQbuaQxrBt9kGUSAFxAk/rlG0OLSA5ETF/yhQnxk2ZLFuR0jfQX/qIjpt/75T
	b8dSA2QgEhRreOUZuAKF3ljSuo8gdLyJZTXvKFL8HeU3rkoX4k14W/B+6d62k/GpusYd7rmpuY5
	YYacS3zxShPlxxNDmqSxfvxfnBUb1RKmBISLfljBsdxn/qr3u1OG/LstcxQvs+/q6vtVFW7fR8D
	8BRoTgLc
X-Received: by 2002:a05:6000:1448:b0:385:db11:badf with SMTP id ffacd0b85a97d-3862b368a01mr7879228f8f.22.1733735784112;
        Mon, 09 Dec 2024 01:16:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC4sl9lsOKWTqh4e+6SaVND/oRtDqVhK38O6+lMSfLy643RklWz5qUGoRMQ3oc6rRpSjHh+A==
X-Received: by 2002:a05:6000:1448:b0:385:db11:badf with SMTP id ffacd0b85a97d-3862b368a01mr7879204f8f.22.1733735783599;
        Mon, 09 Dec 2024 01:16:23 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219096b8sm12964400f8f.84.2024.12.09.01.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 01:16:22 -0800 (PST)
Message-ID: <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
Date: Mon, 9 Dec 2024 10:16:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.12.24 20:16, Lorenzo Stoakes wrote:
> There are a number of means of interacting with VMA operations within mm,
> and we have on occasion not been made aware of impactful changes due to
> these sitting in different files, most recently in [0].
> 
> Correct this by bringing all VMA operations under the same section in
> MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
> with VMA as there needn't be two entries as they amount to the same thing.
> 
> [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   MAINTAINERS | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e930c7a58b1..95db20c26f5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15060,18 +15060,6 @@ F:	tools/mm/
>   F:	tools/testing/selftests/mm/
>   N:	include/linux/page[-_]*
> 
> -MEMORY MAPPING
> -M:	Andrew Morton <akpm@linux-foundation.org>
> -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> -R:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Jann Horn <jannh@google.com>
> -L:	linux-mm@kvack.org
> -S:	Maintained
> -W:	http://www.linux-mm.org
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> -F:	mm/mmap.c
> -
>   MEMORY TECHNOLOGY DEVICES (MTD)
>   M:	Miquel Raynal <miquel.raynal@bootlin.com>
>   M:	Richard Weinberger <richard@nod.at>
> @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
>   S:	Maintained
>   W:	https://www.linux-mm.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	mm/madvise.c
> +F:	mm/mlock.c
> +F:	mm/mmap.c
> +F:	mm/mprotect.c
> +F:	mm/mremap.c
> +F:	mm/mseal.c
> +F:	mm/msync.c

Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that 
the real "magic" they perform is in page table handling and not 
primarily VMA handling (yes, both do VMA changes, but they are the 
"easy" part ;) ).

They have much more in common with memory.c, which I wouldn't want to 
see in here either. Hm.

-- 
Cheers,

David / dhildenb


