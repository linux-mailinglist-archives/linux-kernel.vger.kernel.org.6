Return-Path: <linux-kernel+bounces-306558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32235964075
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BE91C2436D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F83C18E35E;
	Thu, 29 Aug 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZIDtmpJ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486518DF63
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924534; cv=none; b=WfIhNG5fsb1q3D4OOVInHIkgK4T3m6DDivl7lcvZbCmKxb5t5uOqLvDJWyG3xvc35xJbKY2PB/oSbZISMsb/NCprzFiQQzei467Tl21BD3ZQmVcm/gjEsv/GwMjY8hJcnb8Gdp9+xNsxO6BfxcFI8HeYkH8PW+Asj4OWQqjgcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924534; c=relaxed/simple;
	bh=KYlbso3Q2KUdVMAwAzmMsj+bS8A261FIzTNXAseOYcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mp9XMHyXmta5oiBgcg9f2INUTZ84UPZsmO2lOfLBT62pjQGLlaU8VG0aGmyp3cjlRh4QdF+0eps97PteLun4ztpLMUlEuVTIqrdObttUzNMMmxKNwobARfGfaiSTGRsuR9/eNAe2m6QtCLyLT1dvq+LZy4U/rcYHQN8GYyHt3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZIDtmpJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71433cba1b7so333282b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724924533; x=1725529333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5Mg16IGZHR1AU9QEpDlBdQnYhxBBYTm7k573SZhd6E=;
        b=QZIDtmpJkPhkbJMBtlEisHQCWtsvc3jJ0DsXtsm3PA/IwJETh4NePdDb3EMUdIa0Qi
         slW0nrTbRee8e+Elt/2s6o4YNchtwEZ/zddBgklit2pKi9/+Pc6vMRHsx9Lni5Od5K5N
         fS9jgBb+pMhTzowJnZ81WP/G5qXHrwmJ2/ENtkLegu6xYo/MXNwMhqfpjw08dxwR9QtE
         DOviSksVhBU1tnw7IWHX5CFkXhbYiSraNamk1z6i/v2afBbLI8FLVExJBrWX2D0FTOm6
         abRjZoXScpVpC7KXFTzWqURVHs7K35o8Q+qj7j49K/kgh7Jy2J8cnjkwnVC5NBn9AjN9
         LUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924533; x=1725529333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5Mg16IGZHR1AU9QEpDlBdQnYhxBBYTm7k573SZhd6E=;
        b=gHSYOMtHeBICNdR0GN3mdkxKpam+CpEDrw105pD55EQv2Yn8LimvZV8eqOxb0bdFCT
         j3SJTAJ4VEMmE5l3fDXK8zCV7tfc4TFyES+fs0kmJHyfp8UNldZ5xjTyyjHWu31XwEXz
         fIfTRmN/bIedDrHV75YMWdEsbbwaGSaD48xTELiuaB9Dz5nPKDt4HjvUyhjB/tqA5mjC
         tAqZoKro/QlymYtrp32rMGaXbgVhgaFuh09jx0CzT7o3bQfrpQe+U2qlhyxMt/VD46Xc
         p/fVfuJx/vxxIS1DZhZyQ30PfoXMM3RjwLnTpgeHdp3/SveamfGlEbN8SjTuPmolpnkF
         i+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDXXMUx0zBjv/VH27s98/oB/zbTZHpAiEddUZV9tK4r4K2/2t7po+0Bd0J+cbmkv2mheJPFEk0q4ZiGQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR2z2ykbAZxXI+2OnO3hlMK2GYy9ZBUcT8gKl/PYvcAjpIfCd6
	EFQzSPrm0K0Uwgfl6ncelUo5AYeHMdwZaFwAzjsOvwEjun0bVWlm
X-Google-Smtp-Source: AGHT+IH9gN5YJTH71LWEmw/LJ7x5bIsw0qExseukjNX/GJNfnDKLYSgNbTmWWID5aEYOg1bUr9eTNw==
X-Received: by 2002:a05:6a21:9101:b0:1c4:a49b:403 with SMTP id adf61e73a8af0-1cce1103f2cmr1698490637.46.1724924532411;
        Thu, 29 Aug 2024 02:42:12 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b3b7feasm1071382a91.47.2024.08.29.02.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 02:42:11 -0700 (PDT)
Message-ID: <9a6e3169-2ebd-47a5-b2e6-953a8a6730db@gmail.com>
Date: Thu, 29 Aug 2024 17:42:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
To: Vishal Moola <vishal.moola@gmail.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
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
 <20240814060354.GC8686@google.com>
 <66ce5eed.170a0220.387c4d.276d@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <66ce5eed.170a0220.387c4d.276d@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/28/24 7:19 AM, Vishal Moola wrote:
> On Wed, Aug 14, 2024 at 03:03:54PM +0900, Sergey Senozhatsky wrote:
>> On (24/08/08 04:37), Matthew Wilcox wrote:
>> [..]
>>>> So I guess if we have something
>>>>
>>>> struct zspage {
>>>> 	..
>>>> 	struct zpdesc *first_desc;
>>>> 	..
>>>> }
>>>>
>>>> and we "chain" zpdesc-s to form a zspage, and make each of them point to
>>>> a corresponding struct page (memdesc -> *page), then it'll resemble current
>>>> zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
>>>> will need to maintain a dedicated kmem_cache?
>>>
>>> Right, we could do that.  Each memdesc has to be a multiple of 16 bytes,
>>> sp we'd be doing something like allocating 32 bytes for each page.
>>> Is there really 32 bytes of information that we want to store for
>>> each page?  Or could we store all of the information in (a somewhat
>>> larger) zspage?  Assuming we allocate 3 pages per zspage, if we allocate
>>> an extra 64 bytes in the zspage, we've saved 32 bytes per zspage.
>>
>> I certainly like (and appreciate) the approach that saves us
>> some bytes here and there.  zsmalloc page can consist of 1 to
>> up to CONFIG_ZSMALLOC_CHAIN_SIZE (max 16) physical pages.  I'm
>> trying to understand (in pseudo-C code) what does a "somewhat larger
>> zspage" mean.  A fixed size array (given that we know the max number
>> of physical pages) per-zspage?
> 
> I haven't had the opportunity to respond until now as I was on vacation.
> 
> With the current approach in a memdesc world, we would do the following:
> 
> 1) kmem_cache_alloc() every single Zpdesc
> 2) Allocate a memdesc/page that points to its own Zpdesc
> 3) Access/Track Zpdescs directly
> 4) Use those Zpdescs to build a Zspage
> 
> An alternative approach would move more metadata storage from a Zpdesc
> into a Zspage instead. That extreme would leave us with:
> 
> 1) kmem_cache_alloc() once for a Zspage
> 2) Allocate a memdesc/page that points to the Zspage
> 3) Use the Zspage to access/track its own subpages (through some magic
> we would have to figure out)
> 4) Zpdescs are just Zspages (since all the information would be in a Zspage)
> 
> IMO, we should introduce zpdescs first, then start to shift
> metadata from "struct zpdesc" into "struct zspage" until we no longer
> need "struct zpdesc". My big concern is whether or not this patchset works
> towards those goals. Will it make consolidating the metadata easier? And are
> these goals feasible (while maintaining the wins of zsmalloc)? Or should we
> aim to leave zsmalloc as it is currently implemented?

Uh, correct me if I am wrong.

IMHO, regarding what this patchset does, it abstracts the memory descriptor usage
for zswap/zram. The descriptor still overlays the struct page; nothing has changed
in that regard. What this patchset accomplishes is the use of folios in the guts
to save some code size, and the introduction of a new concept, zpdesc. 
This patchset is just an initial step; it does not bias the potential changes to 
kmem_alloc or larger zspage modifications. In fact, both approaches require this
fundamental abstract concept: zpdesc.

So I believe this patchset is needed.

Thanks
Alex

