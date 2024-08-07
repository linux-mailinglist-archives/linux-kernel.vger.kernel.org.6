Return-Path: <linux-kernel+bounces-277445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6C094A192
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626091F23C5E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772F1C7B81;
	Wed,  7 Aug 2024 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhu//RNG"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367B1C68BB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015322; cv=none; b=MAXH34tnBvLnOclHYMZBD2wBOmAcXVrVVZc1Mbn67dvA2pz0qtw0HJVDYcxUqEiS+Ninoz46Q5SGG9rSD4veqYdmdfxcZ7YBBwWKsNQyYglHj9y7EmEwgFZcmVs8dwZXkvjegmvS9n7taXQNiAqqM3u6a0OD+UxOZ8MaZCYGhI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015322; c=relaxed/simple;
	bh=c9Fgd+CvqrIcTVANL9HT4gwJxDC87bPFWIy+NP5QHg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A16ZlIcEYrFl/lhwHYXkbXg14vTRC0ATY8x7z/RgoPqT1KoH5JaCuQl9X40eRONLwVgYvb4AfOKsZhzZQYawRAQnWHrBGjIM5fZjEV2dicuf8uYVHmWTrdkj6xJYvd7IHOJeOnQk49+yOFXH0X3sFoH23zrO3dO51YVxMvjqdoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhu//RNG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd90c2fc68so14118755ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723015320; x=1723620120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilA1m314lbZqv1tPUGhWgc40E5KXbW4axTQQfjbWuK0=;
        b=mhu//RNGCF5gzzwpieLZa0pdYjXpYWX/V+iFLVbuSd84oFaUai4XPSSOVjCpTnLsn/
         simWJ9fkVKBrVDeDzmIJuixdejsfoE6tvY0ZPUF4fuelX5+MsNIxo3LkJpmG7OeBSjwl
         Rs6RW7MF0fWPcFYH/tzPXvex5sXDyc3jCAox7ZW0Ih5ecCiKWqod0DZCafIZt4m1VjSW
         9+N9vUNLCDnSTjP+ONxR242CZOrO8M2yyFrWNYboc3o6tovXpng8WVAep3QY/gWe/J4u
         eFYtsxOBtfTxl5Sf3r0d9eJMPie+8fjb3zEFg89HcmxhgsHDzDk9IH4oRKX/To/zNhRh
         Lslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723015320; x=1723620120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilA1m314lbZqv1tPUGhWgc40E5KXbW4axTQQfjbWuK0=;
        b=MTZvufrza98ek+sPLdz/I6mV3S12UsJVrVU3f2LDYz95pFoCzL8BhHiCJY/kdoJdwq
         czRaE1b/0FhEyx9uR2eqP3gsGC9bzSZi0Opc45JqDDR2dh0PvWd0giD+bNJqBjoVzLmr
         3+CgXrRAQPgsPTHw9Sms2zzBTKAyNrwl5RmX4FVdYEUd31LkXxrcmfo+cX3K+7c7zSXv
         TMMx3/QCObH27s6m2+Z4RJkeuHT/vMpk6uTgnHdx4MWVhRrdZbTFyI5vr3LeyMqh+1Mu
         Tqa+TAxebCVEvufx6zM1zpvI5GA0pgAL/V44Z9L6NqDBbTqb7pEbMn6EChxPSWjJ6pUk
         KlSA==
X-Forwarded-Encrypted: i=1; AJvYcCUm7EhBgKoMDlZaQqCskr/zy5jWbxuqyswNbCNCAKCgK7tj82qbXkxV1OdhDpPVEirggTt34Y+jYOs35zokjxwOeS0QovnvAxBNNAO/
X-Gm-Message-State: AOJu0YzA0SivgIUa6E+sRM3tB70rIkwH4w3iqHtCTYsWL8E/yf2BJwKW
	6mkQJRqMhxaRkHQeKsZmnJoUUxwj+egAZL1/hCCLwKccP9uOpWIF
X-Google-Smtp-Source: AGHT+IFEJRSyYDcqXxgJTNj++slLPETQqnGWVLmxL5nt0hFK4rS5XJCjEcJhkpC+q+6M7GET+9SLDg==
X-Received: by 2002:a17:902:f54b:b0:1ff:56b8:2c1b with SMTP id d9443c01a7336-1ff574b0706mr176758005ad.60.1723015320269;
        Wed, 07 Aug 2024 00:22:00 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592ac8f4sm98957155ad.274.2024.08.07.00.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 00:21:59 -0700 (PDT)
Message-ID: <e99b33ad-4345-438f-9273-922d40c5ef40@gmail.com>
Date: Wed, 7 Aug 2024 15:21:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
 Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 david@redhat.com, 42.hyeyoo@gmail.com, nphamcs@gmail.com
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240807051754.GA428000@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/7/24 1:17 PM, Sergey Senozhatsky wrote:
> On (24/08/06 12:34), Yosry Ahmed wrote:
> [..]
>>> So the sole reason for this work is as a part of the mem_desc
>>> conversion.  I'd like to hear from others who are to be involved in
>>> that conversion, please - it this patchset something we should be
>>> merging?
>>>
>>
>> Matthew asked an important question here that needs to be answered by
>> zsmalloc experts:
>> https://lore.kernel.org/lkml/Zq0zucMFsOwATsAC@casper.infradead.org/
> 
> Iff "zsmalloc experts" include me: I was under impression that there was
> a zsmalloc conversion plan otherwise this zpdesc effort is a little
> confusing, and, frankly, it hasn't appeared to me that this is "my problem"
> now.
> 
>> Do you allocate a per-page struct zpdesc, and have each one pointing
>> to a zspage?
> 
> I'm not very knowledgeable when it comes to memdesc, excuse my
> ignorance, and please feel free to educate me.
> 
> So I guess if we have something
> 
> struct zspage {
> 	..
> 	struct zpdesc *first_desc;
> 	..
> }
> 
> and we "chain" zpdesc-s to form a zspage, and make each of them point to
> a corresponding struct page (memdesc -> *page), then it'll resemble current
> zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
> will need to maintain a dedicated kmem_cache?

Yes, it would be a better way moving to memdesc, and using kmem_cache for zpdesc-s
seems workable.

Thanks
Alex

