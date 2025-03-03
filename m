Return-Path: <linux-kernel+bounces-541771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E53A4C160
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7A1889111
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62394211A22;
	Mon,  3 Mar 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g630xg8i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCA211A10
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007492; cv=none; b=riPtpRt6mMEqJktzvZgb7yjNYkLlu12m3hoFIauO8C2ZH3QujhqkVjXLJ1rvvT/It4aLYl9jcMIiCGPucG92Nvpu+nVULEBUB6QlNAHIPCPWoaT9SxfdEo8cF4m83MUFZ4UvLGHIdO7mYA1okqBxM++0Ca4KdnMkZZKkUQKKiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007492; c=relaxed/simple;
	bh=hQheXckxx7xbkLus3xmixItjN+Peex8O+v1m+7fjsl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLkz7Br5YD4sbOSlQgWEdo+5ZpdK49GYaNYeUdjeIgpvgcTqj8RrI2cJFADnmfPTnb+nIQoSYNqV7gD4r0QTBYS/8S33k4nigxdzALu/4B6Ig2Oi1iOqJ9+LyDYv2PumP48/v7s91AdRRchcW8DEIiMCLyBSeQC0mmcSdEAuMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g630xg8i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741007489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TeffH+IIjqdN23Lg7LD9KsM1FVi9MoM4HVGY13ijq0E=;
	b=g630xg8iEHkCSq1JoIjdkPhyAPgorqiezwKH1OEVC2zOxGwuqVn5fnl6Jk2jrFPZEL9U06
	NoGHW8yOr2fPxUS4Y5pvisVPNT35K1hlggM/ur6ZJgb/KxniaIp5F7mxemPKilwAFtIX6h
	BjvqvYUKsdiQjXRHZMuhbFa0yMyh/SA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-gvUzmKmtMm2MQyD7xZ6DPA-1; Mon, 03 Mar 2025 08:11:26 -0500
X-MC-Unique: gvUzmKmtMm2MQyD7xZ6DPA-1
X-Mimecast-MFC-AGG-ID: gvUzmKmtMm2MQyD7xZ6DPA_1741007486
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso23678255e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007485; x=1741612285;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TeffH+IIjqdN23Lg7LD9KsM1FVi9MoM4HVGY13ijq0E=;
        b=KNKULgp7AwAmFJMU4D6M+4fAoI2xUxLRCW4f1OuYhlvuC0pzHlNxPlrOewQKPpAv62
         7PfHgZRre/6YkdKphQ8pn+g2oS+7p4K74BP0TDtJk16pj3j7qBrJLHmIHznlw27ZlPa9
         Z5Oalgw/d1NjP5e5KIebN6Vb1hl346K2pmdwzHeLArzSkdC8AQCnh/7OXOzaYq8zjc2s
         imM1EICf/lM4fDx0oSWGqvbzATLkEkHnhx0piOfVK0AlQe1zLb3g15yLXslsdp+yoUu9
         cocqhuHb6xVzkrwMMOwRAwQjoRstltSppJ52q93L/ArLmuLIGQgeH8N1piqtkqWy4XQO
         WkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL0AMRzEjC9okPLpk927K+BqGuz+pjcVJ0oqU830smRkEd7mStr0rY+PupoEmfV5/3mAuATFAuJFK2dBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPOWzg1KnNmg+s39+WgKMrC2twHE/lVgcpLEJujZlgVGJlwUk
	TdP8W1GgyNLnzcet+qOIvkDek12bGfW0xysEEjkKSpUPvcSIwCYfofabaRBPvDpVhbzdogis6PP
	ZdgJUMHpIl/34TA8sfNaSUe22UDdWGvylZ0W/yCjS1ZkcNXcYbFMbKf1XRtPRiA==
X-Gm-Gg: ASbGncvEc1gRWnJRtJevfeGC/UlVf+ihLPuNBWprRbmT8aojR3O1rOpLvlcupV/5vVL
	DyfCZUK1yGDZqX+DpGFv0FjcMjEy4sLZaVBmTdeVqd3oKq0boItiAjYb1SvikyInHR+rXT9wA16
	X4hJvOpJJGT9G0jmrV8yI8fcJLuStVI7QzZhDin0ejhDgmsqu/V+BWnfl13NKyBMMZLlgL3/YVy
	2wYMO5KEY/23gZrD6/3SHnTPCUA4ul0C/k+xGUBP2n2zARm4PFZLYLXUL5EncLzR3VM33Kw4FbM
	zFs9TDluao8sLUm5Shf4i8msw7tqaf+PKV24pb9t9R50ASJvXFq4aTb3O0XNGULBmwUBW1hlrjo
	moemA5FaYr8mjBGobiAnQ+lPqGiRnZ425MDnDbwWrHLk=
X-Received: by 2002:a05:600c:4693:b0:439:a1ad:6851 with SMTP id 5b1f17b1804b1-43ba675d773mr99165455e9.23.1741007485625;
        Mon, 03 Mar 2025 05:11:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQn2waD1QVxCAIUjRN+u3Z0398w8FHaVuNZLkCafXSE9x3fL2sE84LW/u04OY4lOA2aM46vQ==
X-Received: by 2002:a05:600c:4693:b0:439:a1ad:6851 with SMTP id 5b1f17b1804b1-43ba675d773mr99165255e9.23.1741007485284;
        Mon, 03 Mar 2025 05:11:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5711fcsm195845315e9.28.2025.03.03.05.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 05:11:24 -0800 (PST)
Message-ID: <4d0f0bca-3096-4fb4-9e8b-d4dcdf7eeb92@redhat.com>
Date: Mon, 3 Mar 2025 14:11:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page_alloc: Add lockdep assertion for pageblock
 type change
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250303-pageblock-lockdep-v2-1-3fc0c37e9532@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250303-pageblock-lockdep-v2-1-3fc0c37e9532@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.03.25 13:13, Brendan Jackman wrote:
> Since the migratetype hygiene patches [0], the locking here is
> a bit more formalised.
> 
> For other stuff, it's pretty obvious that it would be protected by the
> zone lock. But it didn't seem totally self-evident that it should
> protect the pageblock type. So it seems particularly helpful to have it
> written in the code.

[...]

> +
>   u64 max_mem_size = U64_MAX;
>   
>   /* add this memory to iomem resource */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 579789600a3c7bfb7b0d847d51af702a9d4b139a..1ed21179676d05c66f77f9dbebf88e36bbe402e9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>   
>   void set_pageblock_migratetype(struct page *page, int migratetype)
>   {
> +	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
> +		in_mem_hotplug() ||
> +		lockdep_is_held(&page_zone(page)->lock));
> +

I assume the call chain on the memory hotplug path is mostly

move_pfn_range_to_zone()->memmap_init_range()->set_pageblock_migratetype()

either when onlining a memory block, or from pagemap_range() while 
holding the hotplug lock.

But there is also the 
memmap_init_zone_device()->memmap_init_compound()->__init_zone_device_page()->set_pageblock_migratetype() 
one, called from pagemap_range() *without* holding the hotplug lock, and 
you assertion would be missing that.

I'm not too happy about that assertion in general.

-- 
Cheers,

David / dhildenb


