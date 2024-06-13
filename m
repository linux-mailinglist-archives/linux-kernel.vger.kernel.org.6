Return-Path: <linux-kernel+bounces-212827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73639066E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BC41F221F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF713DDC3;
	Thu, 13 Jun 2024 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kgbv4JZ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5213D8B4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267424; cv=none; b=VGxfZwky0TAZSRwgF1ryPSzNCgpBusC1tlFT31RnA9Vzt0Qykh9/9gh49VT7adnK3p+vkiCyh7c2KcQrEusWItLpQ+778QJ+eAXRPAdh43pcsaO+VJ0qUXtoIkDKe9RG9rIKuvKhcCFp81LTz3NZDhUK+0zE8zAWaTg42xcJ24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267424; c=relaxed/simple;
	bh=olYDvaq1sibUVzUMbpKd5cTm6kBqZtlOrcMpTOMa9XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrSzSPih+DK3X5ZFqGMb5WoWiChJHhA7DOMR6meSPAa9GYbAAqQyv//o3eF8p9yXksPv/5svc8A6ShhVwcizlTsSo3yL/O0u1ojqKmZqdLPllEkVjHgnhzPtd0rmjCKtVr0affyP4A1EQgChmntUjqYDeENWnnV02yZy5meK/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kgbv4JZ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718267421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yAhyS+L6IMUnGJVeQyXFhggpAUPl4/mtNvhZR9+eZ5s=;
	b=Kgbv4JZ60T5wZiPm/WuqOaU7ZtSofzdQDvG8xQwZkgT4AWKqN4Ac6d+W8VVx5jvlN20kPp
	M6aWZZwayzZeNEp7gjTvZtmlWU9FWzr/r+yBsO+RRrEH7znN1AKc4/uYYVxYGIEDIihrAG
	fzxF02zHAWvAvgFlPmVGdxGMaUxctnM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-HLpET5YfMAasoe92gZSR2A-1; Thu, 13 Jun 2024 04:30:18 -0400
X-MC-Unique: HLpET5YfMAasoe92gZSR2A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebf97174f5so4860641fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267417; x=1718872217;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yAhyS+L6IMUnGJVeQyXFhggpAUPl4/mtNvhZR9+eZ5s=;
        b=MbGOE1/95iCvEKPn2JBQJf7VhbtI5GU6b86ygQ5ZrxmeSszNTBiJcmDby7n69pqcXN
         wsdCkfH73I8EPDi/Fu3opvzhTpVC0TeE/45RXeBY5tMaVb9Rb161xXX1WMMatGFPxuRy
         A/oZYF8fym0ef18HJfayk1bk2rGi/k6GaZA4cBR7fRZFE11f9YQxQImxMYpxwI0nhNMG
         w6569ydi5fs55vRwS8/qkshFKsMJTM2wYCLTtZF9khs43YnRMTnvkrNNpuXHVQZqrB0G
         wdRQWeGAhkS24K8MPB8dMI3K+QTN996RnnoAgCGHwKsLbGZKTTi0K4DmyoNrIhCs4Cvt
         0QqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtF+JEPJtN4eTfNrRZsC3vJUPEZR/3veV62sIeO/d5RU1qm9wDSAHWiz2cz2qc3PsH3PCp5xdp5EnidA5acbC9KT6iuYzQSeOPlLxH
X-Gm-Message-State: AOJu0YzIZPiYOjNnrLNHo0ApWw7qQUNbGfID8gPicoxEaBLHGRIDMSWr
	zGq44i1PvJ2tLao0nplPKEUXdSNMmMB1WzYD0MdMfcWspQDF0ACSpWdWMJpK3ZF3ng06JOdSSBp
	WjqPAswsmL/1POxzYNmT1sPtrbJn34E+4KdiPAtycWo1kpc09oKrZ/z2a0ZP5og==
X-Received: by 2002:a2e:bc0e:0:b0:2eb:ebc1:f20a with SMTP id 38308e7fff4ca-2ebfc8d622amr31250401fa.20.1718267417410;
        Thu, 13 Jun 2024 01:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJDfD8HHPrKnvA4HVjWp/eNm28R+o0mbxj0GevtUzStggO0dABQW864ExNmwsXcnWw2lEqyg==
X-Received: by 2002:a2e:bc0e:0:b0:2eb:ebc1:f20a with SMTP id 38308e7fff4ca-2ebfc8d622amr31250011fa.20.1718267416941;
        Thu, 13 Jun 2024 01:30:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e6b63sm53141465e9.39.2024.06.13.01.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 01:30:16 -0700 (PDT)
Message-ID: <b0d551a9-ee70-46a7-a0d6-c422f0baf91e@redhat.com>
Date: Thu, 13 Jun 2024 10:30:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] mm/rmap: add helper to restart pgtable walk on
 changes
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, baolin.wang@linux.alibaba.com,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240610120209.66311-1-ioworker0@gmail.com>
 <20240610120209.66311-3-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240610120209.66311-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.24 14:02, Lance Yang wrote:
> Introduce the page_vma_mapped_walk_restart() helper to handle scenarios
> where the page table walk needs to be restarted due to changes in the page
> table, such as when a PMD is split. It releases the PTL held during the
> previous walk and resets the state, allowing a new walk to start at the
> current address stored in pvmw->address.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   include/linux/rmap.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 7229b9baf20d..5f18509610cc 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -710,6 +710,28 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
>   		spin_unlock(pvmw->ptl);
>   }
>   
> +/**
> + * page_vma_mapped_walk_restart - Restart the page table walk.
> + * @pvmw: Pointer to struct page_vma_mapped_walk.
> + *
> + * It restarts the page table walk when changes occur in the page
> + * table, such as splitting a PMD. Ensures that the PTL held during
> + * the previous walk is released and resets the state to allow for
> + * a new walk starting at the current address stored in pvmw->address.
> + */
> +static inline void
> +page_vma_mapped_walk_restart(struct page_vma_mapped_walk *pvmw)
> +{
> +	WARN_ON_ONCE(!pvmw->pmd);

Can we have this more general, like

WARN_ON_ONCE(!pvmw->pmd && !pvmw->pte);

And then setting both to NULL below?


> +	WARN_ON_ONCE(!pvmw->ptl);

This is confusing: you check for ptl below. What would be clearer is

if (likely(pvmw->ptl))
	spin_unlock(pvmw->ptl);
else
	WARN_ON_ONCE(1);


> +
> +	if (pvmw->ptl)
> +		spin_unlock(pvmw->ptl);
> +
> +	pvmw->ptl = NULL;
> +	pvmw->pmd = NULL;
> +}
> +
>   bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
>   
>   /*

I'd suggest squashing that into the next patch.

-- 
Cheers,

David / dhildenb


