Return-Path: <linux-kernel+bounces-274350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FFA947712
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBA1F218BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1750F14F9F7;
	Mon,  5 Aug 2024 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKHGrOTJ"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3714EC79
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846023; cv=none; b=h0JbXG9JRN/6Se/I7bofNhHxbgAtJ4oaMUl4YVMdDd3YlcA1TgvxUNRMIUMdx0Aj/MrS13wul/ncM5lpJVsAnJZndSV5m20Rp4290o9aYmwb3CRswekfqN2q7Qs3TxJ34ZnvT39iNw2lMd0rXjvpp9bDXSNYgoJ9LXwrvQTvz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846023; c=relaxed/simple;
	bh=BSB/iX2X5QHoKHPFacoNatwOo33uqLX7EADf+rBHQM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/R9hquihkyB0IxBat17GGrB1biB4bq23yMom+gzz/FHV367lwbLHmPoxf9oXQKOJozQvu6ZYpMJAdldVt5zlYdbh7xIQDlLK91RfeflCNekDgvKsNku3MyC4GxNuPS3OT8PInrIDAXVWV79HQaUx+IFggc6Ep9Tr5DQ1eaLbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKHGrOTJ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39834949f27so46971635ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722846021; x=1723450821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fi+vj00+JjvH+mj3sa9KgQtZBR2qBmi2SsAqsNdYE0=;
        b=OKHGrOTJpQosGt4ZOOm+XvOzpYF3BnT3S/Vp7ZYIlk4cJgTFd2YCIW32zrv5jNG1MZ
         xIkVcyP3OMM8BrOYLTfNQHZOE0zlW08ZFb8bqc80droLFUpvBfEfAF2adGi5sxq7gV8R
         SZBoUBKydjqMwjmW9RdJzHbYl0yBnc42s1oraPIBbHcdhSZP6oU7zFb0HQN/XmIPZTAb
         y8JTXp37VEGxrUu5tFZBSbcuqK+gftSaXjwQefpOzgQkyWZR2D1D0Qe3elS1e3nDn17G
         B9GdDh6Zp64SdfN7NYAEem1cpedieUpSA9tVbQxo2IhS58sUMJP4vSpA6pv2Khp165ZZ
         GZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722846021; x=1723450821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fi+vj00+JjvH+mj3sa9KgQtZBR2qBmi2SsAqsNdYE0=;
        b=DYO2lWcL/9zOq2NMX9CrerE7jliTEQdi3P3QFIccQMwtDwCwgP7TEuhDf6A/qAbFN5
         +dT4o2l0Vyt1A0CtDeCQ7p5aLBpgzUhZY0KxDd2btoP7zWOt/cqVuboMd5LiX6a+PekD
         IYLPqg/qdRdDKkM56RFghz6KKr4AaBlgxOBgi1eHyS4Yg8MXc+XEeD5rKNbo/8QPhXOV
         KMfP1IzORmDRJmSrJzdUipBI7BeD0UEdtSQBCGtCmkHKV2NC0dOXzJnIzH30OS2ZDLj/
         COjUAazJOZ+kFE/Jx4qsrT4VJ3o2FJN5QqtxxluKbuZdrx7mEQq/6Y2MBwp6CAXXh5Iu
         /Vbg==
X-Forwarded-Encrypted: i=1; AJvYcCUBsubgueaT8OaSGYRek5ugz4MZMnuUVxaR0P9dlYLhGtYUlxQUbmLke+n/0hVcmX8N3CBKfgT1F9wBBRJjdfjeVPYdgWGfwxyn4PqN
X-Gm-Message-State: AOJu0Yz66NLn3u1CbIRSKx3TLQbDUUO4iOmi9Pb7HRpfn2wONxAE1lVX
	oRXyRA6OlcDp6Yvg+svHgFfNc4YCM7e+jxwAIsNxMB50eomrfLmq
X-Google-Smtp-Source: AGHT+IEvzlGQG1DU5sAenS+ngpsQ68verMtVLUc4c+qzKZTmgYmforjQMlP9JolotZUa0h+Xjc0uvg==
X-Received: by 2002:a92:c64d:0:b0:381:fa54:fb33 with SMTP id e9e14a558f8ab-39b1fc1e182mr129162445ab.17.1722846020730;
        Mon, 05 Aug 2024 01:20:20 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7653b4c74sm4978190a12.82.2024.08.05.01.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 01:20:20 -0700 (PDT)
Message-ID: <a3cc7157-6ea0-4493-8baf-c988b9fa4dcb@gmail.com>
Date: Mon, 5 Aug 2024 16:20:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/22] mm/zsmalloc: convert create_page_chain() and its
 users to use zpdesc
To: Vishal Moola <vishal.moola@gmail.com>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
 42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-7-alexs@kernel.org>
 <66ad2ef0.170a0220.8fae7.6e38@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <66ad2ef0.170a0220.8fae7.6e38@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/3/24 3:09 AM, Vishal Moola wrote:
> On Mon, Jul 29, 2024 at 07:25:18PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> Introduce a few helper functions for conversion to convert create_page_chain()
>> to use zpdesc, then use zpdesc in replace_sub_page() too.
> 
> As a general note, I've been having trouble keeping track of your helper
> functions throughout your patchset. Things get confusing when helper
> functions are "add-ons" to patches and are then replaced/rewritten
> in various subsequent patches - might just be me though.

Right, maybe too much helper doesn't give necessary help.

> 
>> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> ---
>>  mm/zpdesc.h   |   6 +++
>>  mm/zsmalloc.c | 115 +++++++++++++++++++++++++++++++++-----------------
>>  2 files changed, 82 insertions(+), 39 deletions(-)
>>
>> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
>> index 79ec40b03956..2293453f5d57 100644
>> --- a/mm/zpdesc.h
>> +++ b/mm/zpdesc.h
>> @@ -102,4 +102,10 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
>>  {
>>  	return page_zpdesc(pfn_to_page(pfn));
>>  }
>> +
>> +static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
>> +					const struct movable_operations *mops)
>> +{
>> +	__SetPageMovable(zpdesc_page(zpdesc), mops);
>> +}
>>  #endif
>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>> index bbc165cb587d..a8f390beeab8 100644
>> --- a/mm/zsmalloc.c
>> +++ b/mm/zsmalloc.c
>> @@ -248,6 +248,41 @@ static inline void *zpdesc_kmap_atomic(struct zpdesc *zpdesc)
>>  	return kmap_atomic(zpdesc_page(zpdesc));
>>  }
>>  
>> +static inline void zpdesc_set_zspage(struct zpdesc *zpdesc,
>> +				     struct zspage *zspage)
>> +{
>> +	zpdesc->zspage = zspage;
>> +}
>> +
>> +static inline void zpdesc_set_first(struct zpdesc *zpdesc)
>> +{
>> +	SetPagePrivate(zpdesc_page(zpdesc));
>> +}
>> +
> 
> I'm not a fan of the names above. IMO, naming should follow some
> semblance of consistency regarding their purpose (or have comments
> that describe their purpose instead).
> 
> At a glance zpdesc_set_zspage() and zpdesc_set_first() sound like they
> are doing similar things, but I don't think they serve similar purposes?

zpdesc_set_zspage() only used in one place, a helper maynot needed. Let me remove it.
Same thing for the alloc_zpdesc() and free_zpdesc(), they could be merge into using place.

Thanks
Alex
> 
>> +static inline void zpdesc_inc_zone_page_state(struct zpdesc *zpdesc)
>> +{
>> +	inc_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
>> +}
>> +
>> +static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
>> +{
>> +	dec_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
>> +}
>> +
>> +static inline struct zpdesc *alloc_zpdesc(gfp_t gfp)
>> +{
>> +	struct page *page = alloc_page(gfp);
>> +
>> +	return page_zpdesc(page);
>> +}
>> +
>> +static inline void free_zpdesc(struct zpdesc *zpdesc)
>> +{
>> +	struct page *page = zpdesc_page(zpdesc);
>> +
>> +	__free_page(page);
>> +}
>> +
>  

