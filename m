Return-Path: <linux-kernel+bounces-228501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4299160BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597D8B23B61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A41474A7;
	Tue, 25 Jun 2024 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm4Eg9mn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654991494D6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303116; cv=none; b=dBeEMChEbJXVvGAKTi4oEtNwoD6UhRUJuhqVMMMcUUXzT1TSGij7E4viOZPiIfcwHdtydKPbGFVnhM/E/42FbidER5Xxbtv6M4fijD08PAcG2mESSJX7lykj1tHyYVvcV4Rh1BxOLthkMvh3i9twFdLkMqh0TopKhhSCAhxKiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303116; c=relaxed/simple;
	bh=VUsIz2vTdsie8hzhkMYPRsYWv/ZM6EQvzC0XgOvL6Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mxbxa053yqMsohyF+tlN6jaQkhXGGIvE8qI366LPA+mPzlr1H2hYSqzpqN9gmby1zptHTtyt0X12AiIj+pS4f6xJ+/EUoo7k2A6su4o92Ikk1eVZLPrd3Rern09chGKCoIsqOVfID5eXeqvGmTZug/bNYWPD0qpEVGTb4UJy6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm4Eg9mn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa1a542466so19158365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719303115; x=1719907915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyV1PLjpvylr46DPQBxqwExK5HpcwEmrJO3AyCumHiw=;
        b=dm4Eg9mnGW+LR1WBTkI+hCwsUEVpmWSYSE2Tlv+h94Cq6bAQwWxDEW1qsooSSfNPaS
         u8kC9LT7isBdcW+dtikOnxq+zU+YzVHMG+tQ2C/tWXowN0jI1XzEvIKNnq8AkBgP5g7E
         zH/JMs5hjBhL+nNHhyIU8yk/VVBgaH7YpJtA8KcA/wmN0DKv17lMXch6qvIXNc1Tubua
         n5453Tgxa1XF+j0FEr2hkf4DDyZ640zXsyXNg1+3BL0X5nkuzye3vVOT1UFyAlGJyvQp
         JlHDH8dcCWfF5F5eCYtrsOCQkf4a5zLzZCqXwj+CFHdq71z5tthhMbsK8BPMDKulpBdc
         m4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303115; x=1719907915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyV1PLjpvylr46DPQBxqwExK5HpcwEmrJO3AyCumHiw=;
        b=FvNiHJ+ymZRwKmiB2y972iF2C14uR4hsUc32DZrdGujcwzifPZ9w29RrBqT8oXDzuN
         m3fuWOk99nurvMBJP7kBDXi0Dbf3frP6LpjX7KsouwOZ9TnA34sZ8orMmkADZE3BO+gW
         ryfiy44Zpl34Vt90Mo89J2SnTIC6tbewHlEpzS6M+dGRApCUbURL2UEgCdPKmrjeeIvH
         JXfXvnEv9h7QfD0ef3oJRvblZALbsPkBJ4uVw1YyR/cnYgYqa9xvFcVtd+iRq1Len8rt
         ilSOwHuNCtWXqWQQB7ZZ2b68wb9BPpIls2NezSOlvO+mZihrXryJ2av3aGb25UIOfv9k
         Xv9A==
X-Forwarded-Encrypted: i=1; AJvYcCUUkv9E3zoO+wtBoLPApRxDZXzqrjnMXNiWBUpS+LYBr57nXiCXS3OjMrq0dEn8tLSojv2nEGul9jxoqcoygXTmBvPqp7uhzEsEsCmd
X-Gm-Message-State: AOJu0Yw4GHnOlIsfUZ8mLYLD2b1KisvXim0Xi4lqI+OPY9cVsBkKqmLb
	vzn4symj9sFNg13BFRKxRGBcZQQ0v/sV46CvgXA4r6nW1vdSBAwq
X-Google-Smtp-Source: AGHT+IHe5NrIZJkjGCkdCHb+86lcOYYXgALNf5tDLIhfYrHcwD7+9ye7Vt7UXVyNjTntM1PDitFDdA==
X-Received: by 2002:a17:902:f545:b0:1f9:ec87:284e with SMTP id d9443c01a7336-1fa5e698121mr46151945ad.16.1719303114078;
        Tue, 25 Jun 2024 01:11:54 -0700 (PDT)
Received: from [192.168.255.10] ([101.87.0.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa13fed3cbsm53864615ad.269.2024.06.25.01.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 01:11:53 -0700 (PDT)
Message-ID: <2e9ce344-e25f-41e0-8ca4-b6d80e095735@gmail.com>
Date: Tue, 25 Jun 2024 16:11:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] add zpdesc memory descriptor for zswap.zpool
To: Yosry Ahmed <yosryahmed@google.com>, alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
 42.hyeyoo@gmail.com
References: <20240621054658.1220796-1-alexs@kernel.org>
 <CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/25/24 5:46 AM, Yosry Ahmed wrote:
> On Thu, Jun 20, 2024 at 10:42 PM <alexs@kernel.org> wrote:
>>
>> From: Alex Shi <alexs@kernel.org>
>>
>> According to Metthew's plan, the page descriptor will be replace by a 8
>> bytes mem_desc on destination purpose.
>> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
>>
>> Here is a implement on z3fold to replace page descriptor by zpdesc,
>> which is still overlay on struct page now. but it's a step move forward
>> above destination.
>>
>> To name the struct zpdesc instead of z3fold_desc, since there are 3 zpool
>> usages under zswap, zbud, z3fold, zsmalloc. It looks like we may extend the
>> zpdesc to zbud and zsmalloc, combined their usage into one.
> 
> Please do not focus your development efforts on z3fold. We really want
> to deprecate/remove it, as well as zbud eventually. See [1].
> 
> For zsmalloc, there is already an ongoing effort to split zsdesc from
> struct page [2].
> 
> [1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com/

Hi Yosry,

Thanks a lot for the info and comments! It's my stupid w/o checking the email list before work on it.
Anyway don't know if z3fold would be removed, jut left this tested patchset here if someone need it.

> 
> [2]https://lore.kernel.org/lkml/20230713042037.980211-1-42.hyeyoo@gmail.com/

David had pointed out this to me few weeks ago too. This patchset hasn't updated nearly a year. If Yoo don't object I'd like to pick up from his left and update it to latest zsmalloc.c.

Thanks
Alex
> 
>>
>> For zpdesc(page), z3fold just uses the 5th member zppage_flag, which
>> match with page.private. Potentially uses the first member flags for
>> headless PG_locked, list_head lru and page.mapping|PAGE_MAPPING_MOVABLE
>> for page migration.
>>
>> This patachset could save 26Kbyetes z3fold.o size, basely saving come
>> from the page to folio conversion.
>>
>> Thanks a lot!
>> Alex
>>
>> Alex Shi (15):
>>   mm/z3fold: add zpdesc struct and helper and use them in
>>     z3fold_page_isolate
>>   mm/z3fold: use zpdesc in z3fold_page_migrate
>>   mm/z3fold: use zpdesc in z3fold_page_putback
>>   mm/z3fold: use zpdesc in get/put_z3fold_header funcs
>>   mm/z3fold: use zpdesc in init_z3fold_page
>>   mm/z3fold: use zpdesc in free_z3fold_page
>>   mm/z3fold: convert page to zpdesc in __release_z3fold_page
>>   mm/z3fold: use zpdesc free_pages_work
>>   mm/z3fold: use zpdesc in z3fold_compact_page and do_compact_page
>>   mm/z3fold: use zpdesc in __z3fold_alloc
>>   mm/z3fold: use zpdesc in z3fold_alloc
>>   mm/z3fold: use zpdesc in free_z3fold_page and z3fold_free
>>   mm/z3fold: use zpdesc in z3fold_map/z3fold_unmap
>>   mm/z3fold: introduce __zpdesc_set_movable
>>   mm/z3fold: introduce __zpdesc_clear_movable
>>
>>  mm/z3fold.c | 190 +++++++++++++++++++++++++++-------------------------
>>  mm/zpdesc.h |  87 ++++++++++++++++++++++++
>>  2 files changed, 184 insertions(+), 93 deletions(-)
>>  create mode 100644 mm/zpdesc.h
>>
>> --
>> 2.43.0
>>
>>

