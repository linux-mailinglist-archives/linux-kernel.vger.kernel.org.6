Return-Path: <linux-kernel+bounces-243770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEEF929A5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 02:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07891F21290
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BCB138C;
	Mon,  8 Jul 2024 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElUm7gm3"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF0184F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720399158; cv=none; b=a90oQRVZa8MPDVC0vc+49rmzjkLNp2eSXJdbm4QF2Bq5KShIIfDd11zuwxlT7DTafUqkXpS/NNsZOydnP+UG0vpZXZc3Dppn5m6RYv+FHGCM6XQQU6GPJpSq6+dF8LC0oCGzT2MmFvguATOZ07tWk9Ta0f8SggYYLOjQPr4dCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720399158; c=relaxed/simple;
	bh=vFg3bdUlUvg5V5WaLCa7QL/Xu5lSClGH5THgputqVPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx1tVvTOT5wfmjPP2gcoO/YjAjDXbW0laePAvfI9IvWa7phGM3LIpvJnzAP+yVOKAaJpIq6RoecfVmT2QSJVJ9cfT2+oIsekQuqEv7Mum7ZVCCOJFdSv8yePFDerxWh9TifWGhiKm4DhecpN5n0bipiNlzSjIdxL2SRj06UfLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElUm7gm3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so322846966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 17:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720399155; x=1721003955; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuTbglylbJkLgy3nA6Vq1cwMPZqasK0i2Sp9zGzr5H8=;
        b=ElUm7gm37WmoHZvSBFwssfKShluAL/fKjqwV35D0DDSclZVWoE9QihLlWnGP+DcOHi
         E10Cdbcz1nqFhhXTwC7e7aGm92LyEQMEzpr6VssAOxOGIaRiBXsevpCmWLgNajzdOGnK
         Ft3m28VtO/2NgQ8IFp/Y08zW6ngyLXahcE5qSvMaZOOJsJNTFLP20spS7jZ2ALrDGhdf
         BNXVOdbFn0eR1dtTQrxp9fG22ZYyuKZCsHx+a1hRyJWK0Sa6axz5KPZVIwuen11LwHF4
         yFg4k26JqRKbu+5NiJ+SvwRbj6xVXvGvymQbP7OIWV4CazhwYyH5/uWihybIt5wa8kHd
         mzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720399155; x=1721003955;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iuTbglylbJkLgy3nA6Vq1cwMPZqasK0i2Sp9zGzr5H8=;
        b=lnvuPlgQHUiGFZtbi6SAjeIINLzpZI5GkakRDsw7GbghKifn1umQoFivK422Y133Az
         WgrlsTYYkTh5+MOZovXhnbp3FnhQ4EKV9ukgMyspF5MXB5I8VZX9NA52KhAIXbh727xF
         kZ29XlDHGDqrZSGBnRZPm8XfurepsU5PwrfxeMzzdI4KY6jmYK/U5jWQUCIxVRUfJhWI
         8JFFNsTsgKEJX6GEuvjw+vLNGGpPe/N5WCbEICnNzTJTLiV82g8Y5wO/uBn0hUuQkw8W
         psRsM7HalrGZLUzN31ue63YUG3VKUELKKoO3aWcY1PcULrGoTeFdtTvpJNE/LFihJbLo
         WMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW59QX9zx5z29jFFXYzt/yCw1oh/cz55jxuiIqMcrsFh98lHoKYlx0Cs84VVtPkE/NOm6YlyUuheIa41I969UiehWsp813vrJgWngSm
X-Gm-Message-State: AOJu0Yw8XDsPzB5T8IcTAApt1RGp20X2hI+mez1D831HuNv+oA3PS+Zi
	9twMm6q0A06GKCz9PnBgkBlPfqF5VlVITiRF1deSUDtOgqnEXTK8
X-Google-Smtp-Source: AGHT+IEZYkuoB+ZC6xUPDOzY48LVIjj5y7t1QTXvwb1eeL6uK5oRMd40fxkQrc9e+5upf8vNuXBYNw==
X-Received: by 2002:a17:907:1189:b0:a77:f5fc:cb61 with SMTP id a640c23a62f3a-a77f5fccfaamr182021766b.0.1720399155008;
        Sun, 07 Jul 2024 17:39:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c0dff4a5sm314833266b.27.2024.07.07.17.39.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jul 2024 17:39:14 -0700 (PDT)
Date: Mon, 8 Jul 2024 00:39:13 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Mike Rapoport <rppt@kernel.org>,
	akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
	mjguzik@gmail.com, tandersen@netflix.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_pages()
Message-ID: <20240708003913.dcf7sfklrdpyhom7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240703005151.28712-1-richard.weiyang@gmail.com>
 <Zoe4XN-gKJnjJtzi@kernel.org>
 <20240706012805.uuvysz2qgapgqj6p@master>
 <9f38e4f1-0ad3-4cd4-bcb7-5ec287859051@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f38e4f1-0ad3-4cd4-bcb7-5ec287859051@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Jul 07, 2024 at 10:17:27AM +0200, David Hildenbrand wrote:
>On 06.07.24 03:28, Wei Yang wrote:
>> On Fri, Jul 05, 2024 at 12:09:48PM +0300, Mike Rapoport wrote:
>> > On Wed, Jul 03, 2024 at 12:51:49AM +0000, Wei Yang wrote:
>> > > Instead of using raw memblock api, we wrap a new helper for user.
>> > 
>> > The changelog should be more elaborate and explain why this function is
>> > needed.
>> > 
>> > > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> > > ---
>> > >   include/linux/memblock.h |  1 +
>> > >   mm/memblock.c            | 19 +++++++++++++++++++
>> > >   2 files changed, 20 insertions(+)
>> > > 
>> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> > > index 40c62aca36ec..7d1c32b3dc12 100644
>> > > --- a/include/linux/memblock.h
>> > > +++ b/include/linux/memblock.h
>> > > @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>> > >   phys_addr_t memblock_phys_mem_size(void);
>> > >   phys_addr_t memblock_reserved_size(void);
>> > > +unsigned long memblock_estimated_nr_pages(void);
>> > >   phys_addr_t memblock_start_of_DRAM(void);
>> > >   phys_addr_t memblock_end_of_DRAM(void);
>> > >   void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>> > > diff --git a/mm/memblock.c b/mm/memblock.c
>> > > index e81fb68f7f88..c1f1aac0459f 100644
>> > > --- a/mm/memblock.c
>> > > +++ b/mm/memblock.c
>> > > @@ -1729,6 +1729,25 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>> > >   	return memblock.reserved.total_size;
>> > >   }
>> > > +/**
>> > > + * memblock_estimated_nr_pages - return number of pages from memblock point of
>> > > + * view
>> > 
>> > This function returns the estimate for free pages, not the number of pages
>> > in RAM.
>> > 
>> > How about memblock_estimated_nr_free_pages()?
>> > 
>> > > + * some calculation before all pages are freed to buddy system, especially
>> > > + * when CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
>> > 
>> > I'm failing to parse this sentence. The return value here won't depend on
>> > CONFIG_DEFERRED_STRUCT_PAGE_INIT.
>> > 
>> > > + *
>> > > + * At this point, we can get this information from memblock. Since the system
>> > > + * state is not settle down and address alignment, the value is an estimation.
>> > > + *
>> > > + * Return:
>> > > + * An estimated number of pages from memblock point of view.
>> > 
>> >                             ^ free
>> > 
>> > > + */
>> > > +unsigned long __init memblock_estimated_nr_pages(void)
>> > > +{
>> > > +	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
>> > > +}
>> > > +
>> > >   /* lowest address */
>> > >   phys_addr_t __init_memblock memblock_start_of_DRAM(void)
>> > >   {
>> > > -- 
>> > > 2.34.1
>> > > 
>> 
>> Thanks for review. Is this one looks better?
>> 
>> Subject: [PATCH] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
>> 
>> During bootup, system may need the number of free pages in the whole system
>> to do some calculation before all pages are freed to buddy system. Usually
>> this number is get from totalram_pages(). Since we plan to move the free
>> pages accounting in __free_pages_core(), this value may not represent
>> total free pages at the early stage, especially when
>> CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
>> 
>> Instead of using raw memblock api, let's introduce a new helper for user
>> to get the estimated number of free pages from memblock point of view.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/memblock.h |  1 +
>>   mm/memblock.c            | 22 ++++++++++++++++++++++
>>   2 files changed, 23 insertions(+)
>> 
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index 40c62aca36ec..7d1c32b3dc12 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>>   phys_addr_t memblock_phys_mem_size(void);
>>   phys_addr_t memblock_reserved_size(void);
>> +unsigned long memblock_estimated_nr_pages(void);
>>   phys_addr_t memblock_start_of_DRAM(void);
>>   phys_addr_t memblock_end_of_DRAM(void);
>>   void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index e81fb68f7f88..00decc42e02b 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1729,6 +1729,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>>   	return memblock.reserved.total_size;
>>   }
>> +/**
>> + * memblock_estimated_nr_free_pages - return estimated number of free pages
>> + * from memblock point of view
>> + *
>> + * During bootup, system may need the number of free pages in the whole system
>> + * to do some calculation before all pages are freed to buddy system. Usually
>> + * this number is get from totalram_pages(). Since we plan to move the free
>> + * pages accounting in __free_pages_core(), this value may not represent total
>> + * free pages at the early stage, especially when > + * CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
>
>These historical details should be dropped. "Since we plan ..." will easily
>get outdated soon.
>
>* During bootup, subsystems might need a rough estimate of the number of *
>free pages in the whole system, before precise numbers are available
>* from the buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the
>* numbers obtained from the buddy might be very imprecise during bootup.
>

Pretty better, thanks :-)

>?
>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>
>-- 
>Cheers,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

