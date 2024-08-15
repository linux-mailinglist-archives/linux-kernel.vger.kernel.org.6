Return-Path: <linux-kernel+bounces-287497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C466595286D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032AC1C238BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F63A8CB;
	Thu, 15 Aug 2024 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2U+zRqz"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83E2BAEF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693844; cv=none; b=bKYW9GCId2l7YA/ojKJTcJhHjpOAOAUx2wrUZ+sJ6Muda74VGC7Umrz4C9Ao0GtihKequlbRhF2gcQ/kHJxLd2yPSOQXJLOKXms+ugOn5o1zh1Qq+RK5bVHXypfCcha8LWhaMnmMh0ecTd7v74gFAX4yx9k3pXFMhQLSkV56dUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693844; c=relaxed/simple;
	bh=BzgX0aKEfGXbLlue3V8asdUmslaiiA8eFbpdUV1qmgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlE4YVbyjXpVBkyfHXVDfoi4dv3d0dFSSiXYRKsHioaJuejoWyvGbA6CSKSLcTD4WKdW3wrR54BxEVbuUDGCXeZIa3TGIiIyHIyB62TwytyHEJB3wC+2I/FBteFXGSJ/hbSesWEwKVzFJAf1bX8UXzjdGLRwMoSX+9NY4CSpgUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2U+zRqz; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-268daf61e8bso437034fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723693842; x=1724298642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Z1CUzmhClafRFyxU4gxwwLyWq/ScaI+Gv3jC0Z1Y5I=;
        b=a2U+zRqzD4Jse9VWO+AegziqA+RaIpA6orfR2CmMz+8hoYvn8NESFVy+tt1gnTcuZj
         GG0SZDFTTSFNBq2Dn3qwMKU78xv3YPBzIAe630HLZInvonhoDb5yc1Yl1gcs3vSPJSpH
         wWEarb28fEN78ORAVxoUsyHm/6Yn8jJLFG9Aef8xgbOcx3v7LBmczO1Zc4s/3jQRrsCY
         rgl3wavlQ49HXoAcbJIzyedX8bgHPblVm9GA58A6SHVq8guLKC1pInrglZfJAKl2i0cw
         50BjEEkTz6YKXl4H0JfuP/iFP9mqb3A93bTgvRkP8kSCTASA6WhtF4Oy7gbh+uvl5AzW
         NUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723693842; x=1724298642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z1CUzmhClafRFyxU4gxwwLyWq/ScaI+Gv3jC0Z1Y5I=;
        b=sYXqePMo7gVUB0oGK/5k0dang/owTW9t5SgNRG5Jp/JZWj/ezdJ75OXBmTIwp+vxim
         aGGUY+Ys5Nx4Nbt3+f/C0PWNqqKgG3vtxdTeDNVhxvcD1/Vz5+1PClT9/PYhxdAJ/8ZT
         i070BpSuFZgJfDG/7sqR0NmayRO9XhHUPgjh0Dltfae2Iydu9zAAB6rQQFcO8iE5jqqP
         vltk63HVBy7Xu67pvekM/qIHhpGdTODkND+Lf1FZmXhmggxls8xHm/39DSDxhTbrH/fI
         4linE2TN4R7paqqAJieTQ56drDGQnIKO6l7jQ4iX/X6qhaA1DEaZiEUvs2W36IQ+ZfLb
         YAOA==
X-Forwarded-Encrypted: i=1; AJvYcCUfVqEovygRWRVR4jPfCSSNv/fuXaMeidKuYcRX06kkygMquZfoyS8nqJFfKVkkzlGMvltaF24PiZlZreNQ1J21z+7qNTTp1yKbRwed
X-Gm-Message-State: AOJu0Yz36ZPRXveOQup8kwAfPWSuy6zL6YTpqAWwk2c1UTddu7BLtEHl
	osX4I2mrhmpuufOYTwoqwwC8R5Xcvn2ZRKlJwwmTbw/29P0papnz
X-Google-Smtp-Source: AGHT+IEm9NdNcXdysuTBvciuS0AClLfm6nlGkDSMqK2k7C/V8Xjjm7HW+mu1CEt7x1NizttMQG6pSg==
X-Received: by 2002:a05:6870:e3d3:b0:261:446:c405 with SMTP id 586e51a60fabf-26fe59da47dmr6119502fac.4.1723693842498;
        Wed, 14 Aug 2024 20:50:42 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1f2cesm307857b3a.181.2024.08.14.20.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 20:50:41 -0700 (PDT)
Message-ID: <5f785814-0be0-407f-87a0-4bfb4041fa2d@gmail.com>
Date: Thu, 15 Aug 2024 11:50:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, Yosry Ahmed
 <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, david@redhat.com,
 42.hyeyoo@gmail.com, nphamcs@gmail.com
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com> <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
 <c3f60e2d-8355-46ec-845e-0893dbe5e4f9@gmail.com>
 <20240815031314.GA12106@google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240815031314.GA12106@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/15/24 11:13 AM, Sergey Senozhatsky wrote:
> On (24/08/09 10:32), Alex Shi wrote:
> [..]
>>>> and we "chain" zpdesc-s to form a zspage, and make each of them point to
>>>> a corresponding struct page (memdesc -> *page), then it'll resemble current
>>>> zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
>>>> will need to maintain a dedicated kmem_cache?
>>> Right, we could do that.  Each memdesc has to be a multiple of 16 bytes,
>>> sp we'd be doing something like allocating 32 bytes for each page.
>>> Is there really 32 bytes of information that we want to store for
>>> each page?  Or could we store all of the information in (a somewhat
>>> larger) zspage?  Assuming we allocate 3 pages per zspage, if we allocate
>>> an extra 64 bytes in the zspage, we've saved 32 bytes per zspage.
>>
>> Thanks for the suggestions! Yes, it's a good direction we could try after this
>> patchset.
> 
> Alex, may I ask what exactly you will "try"?

Hi Sergey,

Thanks for question. As a quick amateur thought, the final result may like following,
please correct me if I am wrong.

1, there is a memdesc for each of memory page.

2, we kmem_alloc some zpdesc struct for specifically our needs, like zpdesc.next
   zpdesc.zspage/first_obj_offset, these current we used in zsmalloc.

3, there is a gap between memdesc and zpdesc, like .flags, _refcount, .mops etc.
   this part is still unclear that how to handle them well.

During the 2nd, 3rd steps, we may have chance to move some members from zpdesc, to
zspage? but it's also unclear. 

Thanks
Alex 


