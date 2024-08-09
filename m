Return-Path: <linux-kernel+bounces-280314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F6E94C896
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DA52836F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94483179A8;
	Fri,  9 Aug 2024 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQfYbFUV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4F175B1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723170769; cv=none; b=B0FO5aTAJ+CwHeP/DIeqmk8JBXVRDrXNg06W+HXxL8+5QdFN3jMKTmOyLCPxw9rI9//cDkocZUfs9Kr/WDbW9GLEchmdL3r+cbSUB0mYu9fJi+/XJtH6t/f4Npd+OQuB+W6MuwZF/ppkXeSUC9osNyIjFhbj970eKXNwBbX3bJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723170769; c=relaxed/simple;
	bh=RVezjgx3Fl5Kho7OjgLZ3nlVOnlP3es3/N041D3rJY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeA1R5t+wwDsJA646PnFXfsQlZZLDT0MmudrUO6NkiEZbBOwcVcbzkxxVCA5D+VFFt+IRyFE1InVsumkee1gQ1aDyrhZ9jGktLtujptWsNKAATWTrE2m7eVRpKzp4CBrYXT2LUpnu7Nzz6WQFE5PLHiwGeXE7T/ZglGcEx32Lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQfYbFUV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso1392529b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723170766; x=1723775566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTs3IAlMbr1gJBCL/OvELDq9lICZRD1rhPZfhbtHB7o=;
        b=BQfYbFUV4PbZRWikkUkyLpa5N2Aw25Sq/OlI+Ysma96Yb8t2Yzm1kGBwxau8DNHh14
         UaU6OBLThWAZDDdpqs2SR4ez7YRXAb6vnchyQkXONNosv4eEsNY6RAaobvDXU8LZG1N1
         kvD9I6h3L7MfOVG77BojKXZ6Hs26imow+CY7zEkCoCkqY0P5HqSMbquYzm1ONqWtDGgF
         xwsQUZ5VzdPAiMJG1AVTHNpMQI7LUluk1veTXVxQMRTsh+esw/OE1WklQb8TdWL60Ksh
         qjzMitJc62/hhuVNMGLAIgh86J5pGdIBGgr89VjvIfuqLQ999puJuq6gjpJkoskCZiQ4
         du6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723170766; x=1723775566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTs3IAlMbr1gJBCL/OvELDq9lICZRD1rhPZfhbtHB7o=;
        b=UA51bEGrGKnsOPQvR2xRozvAMEZklWb4aWuxxB75jBdfFm84pq0W5ksNmrh4cpiiBs
         OE+I6vkr2qX1BhJuKuaC80f7fSMZqdjv8KHxme93LVtJf2LKnzP20tvMraGRHgF1P70R
         oeZW4ioh5B6bjgZvZMSzo8FG0P48RT84UvC+WBGROhAb/D6fDkvw7e2m/rZiVkC+4zC4
         +1CsDPq54MB4yVXJlE/RSvuZQ6DvbLyCKhffGpa5moS/96ugps1VC2DgcHquEpzwa9FC
         k7/GJarm8NTOTvn02BmyaPBaB5mDKlLB1iVZhD/hbIMZD30S5/DYkGJeCDmjBNrIL0mP
         op/w==
X-Forwarded-Encrypted: i=1; AJvYcCViPjzIGr+d1zAdTFAYqUbc0iB3zg1zae0gW208PHMCYl5BHfRfybFTBh1FCXwCY5HxBXr4PGwBthRJ/95BcVaWW5eQeHX/Dw9bA6On
X-Gm-Message-State: AOJu0YznCNsrwPR2Nx6Y8/MV/0qT+bc1TFgy2ncYOTvygVv6qWqA5Nzn
	B6u//f+Tg7z9bjWXc/2uXmqCHWDmjG7sHpjUgVkob9sKoJ5EzFtR
X-Google-Smtp-Source: AGHT+IECU7ETquIij23PHnyoGRnnjIBFv+llld7icXBTl5CgvoLf35mOyxQBb9yLHSiI/bxsw7ld4A==
X-Received: by 2002:a05:6a00:39a1:b0:705:b0c0:d7d7 with SMTP id d2e1a72fcca58-710dc6959a5mr119465b3a.7.1723170764937;
        Thu, 08 Aug 2024 19:32:44 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a671sm1752622b3a.24.2024.08.08.19.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 19:32:44 -0700 (PDT)
Message-ID: <c3f60e2d-8355-46ec-845e-0893dbe5e4f9@gmail.com>
Date: Fri, 9 Aug 2024 10:32:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Matthew Wilcox <willy@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
 Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 david@redhat.com, 42.hyeyoo@gmail.com, nphamcs@gmail.com
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com> <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/8/24 11:37 AM, Matthew Wilcox wrote:
> I've written about it here:
> https://kernelnewbies.org/MatthewWilcox/Memdescs
> https://kernelnewbies.org/MatthewWilcox/FolioAlloc
> https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

Thanks for sharing!

> 
>> So I guess if we have something
>>
>> struct zspage {
>> 	..
>> 	struct zpdesc *first_desc;
>> 	..
>> }
>>
>> and we "chain" zpdesc-s to form a zspage, and make each of them point to
>> a corresponding struct page (memdesc -> *page), then it'll resemble current
>> zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
>> will need to maintain a dedicated kmem_cache?
> Right, we could do that.  Each memdesc has to be a multiple of 16 bytes,
> sp we'd be doing something like allocating 32 bytes for each page.
> Is there really 32 bytes of information that we want to store for
> each page?  Or could we store all of the information in (a somewhat
> larger) zspage?  Assuming we allocate 3 pages per zspage, if we allocate
> an extra 64 bytes in the zspage, we've saved 32 bytes per zspage.

Thanks for the suggestions! Yes, it's a good direction we could try after this
patchset.

Thanks for you all!

