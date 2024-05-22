Return-Path: <linux-kernel+bounces-186325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C98CC2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECEF1C22139
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F0F1411FE;
	Wed, 22 May 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8b7ynyg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228E140E3C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386720; cv=none; b=NSijlHwVUoECU80D0QwqcW+/H+hwWl850KMHBN25G6Z8M5V4GhMTlW4D425Mu52OpWtXoSBDkJTM5HUtvGSARCLc1LPCjyh+RpukQciKgbCMNPTbmGSbRXYN6XgpR2dc1G9wl6vGFElDXA4QFgiyRbEpKtheloymu+HCeT2zU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386720; c=relaxed/simple;
	bh=yXncDLbx4wHlyvUMLd/6HAnYq1ZGJrdD41FjP1/tMlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRRbN0r1KhKV4z54jzKA9xkjSdF0/cNHijFLGHKOy+0Zbgga9coYVsC+SqBy+TpnP37ji+9DXf2+yipCbieDLREKpcUIVNKmZJ5YRqlaT1D/f091v6RfOS7kPOOJENrVndCKQX+iPOuEv9mQeYoSLtlBaxAbXLE2Lb7lGCWH0Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8b7ynyg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716386717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OMeL/YM3HV59tP5mC2CmVuJi/ZQBIb6+JSCQRtjak7Y=;
	b=H8b7ynygvHh97+DmDv99tDUgdgWBnzg4CRHhfFdY7uh59ADgsOk+v5AFauJcJaISNzlbbI
	M8i8xiAJEsHpduJVFlkhYOXSco9aA3DDXecbknolDpldvDoQuC1s24chTN9ATG144vB4Th
	BxbVcirona+7O8cwtWrRMDYfQGDshi0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-qYRnJ5B1NaajKgGtqllKUw-1; Wed, 22 May 2024 10:05:16 -0400
X-MC-Unique: qYRnJ5B1NaajKgGtqllKUw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e2ce98f9c6so2269901fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386715; x=1716991515;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OMeL/YM3HV59tP5mC2CmVuJi/ZQBIb6+JSCQRtjak7Y=;
        b=rJOnOQJk9PNM0rgcaY/yTW3KUrlhO9QpCrqA1hTigNHlSGHTb1zhEa9LrP9DrdciaX
         OjkQLwEka0XN0v62eQAAupgyN8Jo+wtax3VeFsoMKNPj6L+Rr+/ySu+fh0rbQfbxIDKK
         ibXvnXLbx0R5+/lzA7yBCWWII2KWFpircsGX8/bDBJViLRI109noVQM2OpiX+i427Waf
         6IQyOAO8ioHcxVwmKDGh/dSgsQVxVf0XhzSORVSPEQPHIK9C/CBnijyIUD7KvASrvNly
         25VYOMeg+JovMcwK8sf3Z9kOQEEX+PWcbT/2tPdFNJH5MXlbTQ90HxkZB+MsPuZbGBb/
         sHMA==
X-Forwarded-Encrypted: i=1; AJvYcCUCbh9p213vXiz5ZVWHeJJES66IlRPMDz/C03v1WlFUzWiT7nxjm7dTE2WTvJFVeIMosqytCDcZyAH5cC+qlHOQjh23KPoO84BFO58/
X-Gm-Message-State: AOJu0YyBdMu1T2EJ+4AHqRcwvyD3fTK49iLHGMMtxQFwyhn1OGbCqIzT
	0UADG0KDOIhWyyBfs4dulfCzoFjKQPUSBuIC+ngwe116GKg7dHCGq92dqZfd2UazUehI1ccF3AD
	9WwpsYYObQnVCdlc9RbWgP1wzB8yONZ4OV8p1iYkGPhCaOylH/h/+lDj5tEXfhA==
X-Received: by 2002:a2e:9804:0:b0:2d8:67a0:61b2 with SMTP id 38308e7fff4ca-2e94948fb55mr11606811fa.20.1716386714654;
        Wed, 22 May 2024 07:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9th4KI3IcbSy0XZ903PuPNGbPIY/n9sC8Yo2138urwxc/3ZNQUaiw+Cc7+2ss/zC0zmMLFg==
X-Received: by 2002:a2e:9804:0:b0:2d8:67a0:61b2 with SMTP id 38308e7fff4ca-2e94948fb55mr11606601fa.20.1716386714067;
        Wed, 22 May 2024 07:05:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d500:4044:6d4c:f060:f677? (p200300cbc709d50040446d4cf060f677.dip0.t-ipconnect.de. [2003:cb:c709:d500:4044:6d4c:f060:f677])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354f276a49bsm722171f8f.96.2024.05.22.07.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 07:05:13 -0700 (PDT)
Message-ID: <9c23d824-f2c7-4f9a-ade2-e8dd3a0d30af@redhat.com>
Date: Wed, 22 May 2024 16:05:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized
 zone data
To: Brendan Jackman <jackmanb@google.com>, Oscar Salvador
 <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Pavel Tatashin
 <pasha.tatashin@soleen.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.24 14:57, Brendan Jackman wrote:
> These fields are written by memory hotplug under mem_hotplug_lock but
> read without any lock. It seems like reader code is robust against the
> value being stale or "from the future", but we also need to account
> for:
> 
> 1. Load/store tearing (according to Linus[1], this really happens,
>     even when everything is aligned as you would hope).
> 
> 2. Invented loads[2] - the compiler can spill and re-read these fields
>     ([2] calls this "invented loads") and assume that they have not
>     changed.
> 
> Note we don't need READ_ONCE in paths that have the mem_hotplug_lock
> for write, but we still need WRITE_ONCE to prevent store-tearing.
> 
> [1] https://lore.kernel.org/all/CAHk-=wj2t+GK+DGQ7Xy6U7zMf72e7Jkxn4_-kGyfH3WFEoH+YQ@mail.gmail.com/T/#u
>      As discovered via the original big-bad article[2]
> [2] https://lwn.net/Articles/793253/
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   include/linux/mmzone.h | 14 ++++++++++----
>   mm/compaction.c        |  2 +-
>   mm/memory_hotplug.c    | 20 ++++++++++++--------
>   mm/mm_init.c           |  2 +-
>   mm/page_alloc.c        |  2 +-
>   mm/show_mem.c          |  8 ++++----
>   mm/vmstat.c            |  4 ++--
>   7 files changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 194ef7fed9d6..bdb3be76d10c 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1018,11 +1018,13 @@ static inline unsigned long zone_cma_pages(struct zone *zone)
>   #endif
>   }
>   
> +/* This is unstable unless you hold mem_hotplug_lock. */
>   static inline unsigned long zone_end_pfn(const struct zone *zone)
>   {
> -	return zone->zone_start_pfn + zone->spanned_pages;
> +	return zone->zone_start_pfn + READ_ONCE(zone->spanned_pages);

It's weird to apply that logic only to spanned_pages, whereby 
zone_start_pfn can (and will) similarly change when onlining/offlining 
memory.

-- 
Cheers,

David / dhildenb


