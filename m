Return-Path: <linux-kernel+bounces-203806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4258FE0AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A74B24199
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D613BC26;
	Thu,  6 Jun 2024 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5k+5/z/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5535F13A898
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661637; cv=none; b=VDWrCAZ9ypo2X1N+LnOhlpNQ35z7RPfZfr+cDPlwBmjVSCifXu9E2yFfGN9MOS9hjAV4Kpy2w5wv584O4dzyKDliDLc3RtIuGvpaZ4Thc27o5TADhEQgM4644bpDaLOybNWYQtdpmX5xhfNqaK0ZskRhcFhZVsR++umlST7WdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661637; c=relaxed/simple;
	bh=m6kggCWyoo1jG+ph/k5GuYO/v1WOziXgW2/+xkEzjvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=matF8sGIZjxHJNmjWK3bhvkZoFp8ucHWm0eEJ+DZDrI9d0Povz7ydcNUJEcf1L8mvRjzFMotVzFMuFAKCT29MJbphREKyReGCFaRxrKvH64Ji/OWMKvPvjsxYnRZEtScebw6zT9SyNn4Fp0nq0p7YAMR00+RdV6cUgLX983Uidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5k+5/z/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717661634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WdxyzghmFFitc8Rrh31w2EHwBg5wAxQHRBZrWVev8SA=;
	b=I5k+5/z/jyZ8ynk8oY1kfV9KSgQ87a7gF3a64NEBRJYdPHi20GfuybPA4i8z4yJa+LESUR
	7nJ1859WHYZ9xlOiUbCy0CuONFN6M8XtNewkAiHp27ifHGMkIP5Y416ZYRLFWV40l0mdQk
	mYQDfXzLDZfqeRVBV2UJMJ/DMh2OlNU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-wx9RiJdNNz6ZY3h3PnypJw-1; Thu, 06 Jun 2024 04:13:52 -0400
X-MC-Unique: wx9RiJdNNz6ZY3h3PnypJw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4210d151c5bso6610985e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717661631; x=1718266431;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WdxyzghmFFitc8Rrh31w2EHwBg5wAxQHRBZrWVev8SA=;
        b=Y5zQckUKoVCYi+0O3FZNJ0jcYzPDFDw9jSujGIfky+ms+flcrnkicwZFQsVPOKPgO/
         jsgETRGcPX+HBFiCACg5mqA5mYsAuYkDOMpAPaUVWScBd6kh7S/hyX4Qkv3wkqvG/eFi
         R60L0jY8Sfcbt8eaQgE9KfNXP5eKP6FPbJX7B63eIyMym5mAphJiDbvhuuVeVoAz0MFM
         8tDp/hPuysgAMrGXPpyz6+AQIBNYmnQjAceekZGSNb7hz2ETYrKGMlckW2AfwQpw2nBw
         vgc0mbtJNbFf2aOPvE6WeYQSPXVXtR/e/m/uqQLxrBE7orZT0cRh2OQqU54sQtniCwm9
         hdcA==
X-Forwarded-Encrypted: i=1; AJvYcCVjfAoYzJ/tD8rCoMO6oPrBgk38Rp2AsY1KovOwjCIMQCEfSenvGNuqnlpDDshgS4VVQtLUoD7chO0n3Jc4owCpDyRD6G4c2LhRGw+F
X-Gm-Message-State: AOJu0YwxhHVWys1TLIqq/zyCPZxgtn53r1aw1egg7RczuUBudakO3X39
	D36d+rLzvkDKTqZ/2i1xTMfszkNEoqrVimPaB43g0suyd9r7qX5/s+I5S0QbwPx8gpv1PZwbISq
	J815gX5GRiwpipL2XACxErCaXTs55JdSe4ZhVxiMkKSA2jZY3uD4RrJBxnSlxBQ==
X-Received: by 2002:a05:600c:3ca1:b0:41a:ff7d:2473 with SMTP id 5b1f17b1804b1-421562df268mr37691155e9.4.1717661631199;
        Thu, 06 Jun 2024 01:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2qQc9HZD3CqwAoQ8BTpFkF3/Bnvvc/9e9nelc3Ay+VnbkGLFuQMpV053sk5h80kB80PqUuQ==
X-Received: by 2002:a05:600c:3ca1:b0:41a:ff7d:2473 with SMTP id 5b1f17b1804b1-421562df268mr37690995e9.4.1717661630821;
        Thu, 06 Jun 2024 01:13:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d49de3sm872356f8f.37.2024.06.06.01.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:13:49 -0700 (PDT)
Message-ID: <01c1e542-867a-437f-8abd-8f06cf3812cf@redhat.com>
Date: Thu, 6 Jun 2024 10:13:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory_hotplug: prevent accessing by index=-1
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240606080659.18525-1-abelova@astralinux.ru>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240606080659.18525-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 10:06, Anastasia Belova wrote:
> nid may be equal to NUMA_NO_NODE=-1. Prevent accessing node_data
> array by invalid index with check for nid.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online policy")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   mm/memory_hotplug.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 431b1f6753c0..db78d1b725fc 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -846,7 +846,6 @@ static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
>   	unsigned long kernel_early_pages, movable_pages;
>   	struct auto_movable_group_stats group_stats = {};
>   	struct auto_movable_stats stats = {};
> -	pg_data_t *pgdat = NODE_DATA(nid);
>   	struct zone *zone;
>   	int i;
>   
> @@ -857,6 +856,8 @@ static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
>   			auto_movable_stats_account_zone(&stats, zone);
>   	} else {
>   		for (i = 0; i < MAX_NR_ZONES; i++) {
> +			pg_data_t *pgdat = NODE_DATA(nid);
> +
>   			zone = pgdat->node_zones + i;
>   			if (populated_zone(zone))
>   				auto_movable_stats_account_zone(&stats, zone);

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Cheers,

David / dhildenb


