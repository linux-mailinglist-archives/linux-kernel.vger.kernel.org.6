Return-Path: <linux-kernel+bounces-185912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403618CBCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AC61C21FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9247F7C7;
	Wed, 22 May 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+3CtDRt"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F47F499
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366044; cv=none; b=AZqNTmBKbBPjsj49UIBH63j6ZCWm7NBTiuFD1lfg3KA51AqnT2+XPW3wy2BOPGjMtxPoGbtW8k7m/B0bnRdXhGwGxYDIVvpniLFCUnvejPIK1D6wgRkBQVSBGI61uxQeb+XB92lWftsQpHV+GJI+wIrEDNXUloTrtjJizVbI7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366044; c=relaxed/simple;
	bh=Q1eWuDImbm35wB1qi5iLn/MdTq6ljuFd9OXAbKrcKSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E10xXm7ORSZ1tK9vkx6dk7O52MAUi+Rp68kSvOBjbuiR8OKE3xriC5PrEBx2Ri01WyOxWMLPdDFbiIpy5z2dC8rfPBnvdyiPce32V1ab6JvtP+IWVhqH9FfLlVjZLt0BsCVByT7hgUBQBU13FXQX6doQeAV5D6XvENVRuoNzs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+3CtDRt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so9854064a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716366041; x=1716970841; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iS92QR8l4K2ydhnNlygyFvengOTywcUvqW1OE4CHbhk=;
        b=U+3CtDRtcoewqUqeFoOkyhcIv0XpoF1bdu11SLETNPLyHL688/NmeQvvTewQP0iX6M
         0vLB7zBH/OAPrLzfAniivsthqwRqodTdhVKnOPYU+xibH1t942W1fhkkNV/tPd56JGT2
         ZAYSx/DaF4I8YBhESpSCK2PljI9P90JPeWxFM3RVh1rjDmjAfjLJJSUTyPn4gQncdjx+
         7TQV41UC6SOBP6YFbPByAcn5Bg3l+ICeaUMXMew0OfdkJ/KbxjZSkRGackL9BHIcRNn+
         0FodzIBoNcqS3ruIeTWQbCn35UadTxSwvLeO8xbp0f2ucvMW/czfsjnZB0gvvzY8J5Iq
         wd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716366041; x=1716970841;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS92QR8l4K2ydhnNlygyFvengOTywcUvqW1OE4CHbhk=;
        b=awSTYx3rY3AlaW9Zgs7HQud7F/hDZZRjrkfWaWuqgqsawlpwK4hztstBh1Vxq98NK4
         IqY/G+cFmw4jwZ70YPg9wdwjH9q1v3HcChPY34C+7HnfK9mGQWjAJ5cpl3ykgSB7m5lr
         rhNakLDh3GC8JsiTH0pTGS+8Jwkzf0Tn8xMQGtLgT9xaMMDZJ+uFjs35iAmHeLfK1oVG
         14PakWvDm2P/ZZHZ0QnVIshB6AKBrKsDf1uBjjMhjr6PHIGYTjGSpdrlKCGw6K/NTdGU
         vmtEgNAW1Es1zJRIxIm1ydXbZehaGCL7dJ90avJ3yEWqQlJHy4/g4IshLmtc8U7yDDSN
         uXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOZKiYOumepKj0UkQ0aeWZpxxPIjwSnxySrYkDsULCoa5tMsuu8SK1HJCgCkdb3ffFakmPvzDfEiDkpyghOY8JIPm3OJyEW/nGtjdP
X-Gm-Message-State: AOJu0Yz4SEd+FpnZD4IthIG0vCzaiSY0T5GwIQIr25PPkpPVEGeu7cIs
	yMH1SogqN0hJ7nQ4hWIeDC4Man42V5+rr167Iet+X1CD19neXFe0
X-Google-Smtp-Source: AGHT+IHQOk2bYEFwWWuz9oTt3tD42c0nJyiejvJ69RiRMb1+m3koxpf6hfxgARuoj8pSwdqr71My6A==
X-Received: by 2002:a17:906:56c2:b0:a5b:f7b2:485a with SMTP id a640c23a62f3a-a62280ea1bbmr128240166b.30.1716366040776;
        Wed, 22 May 2024 01:20:40 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01a2esm1737397866b.185.2024.05.22.01.20.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2024 01:20:40 -0700 (PDT)
Date: Wed, 22 May 2024 08:20:39 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: "rppt@kernel.org" <rppt@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
	"tkjos@google.com" <tkjos@google.com>
Subject: Re: [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <20240522082039.j4zgfj3lhjdwgrtc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p6>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
>>--------- Original Message ---------
>>Sender : 김재원 <jaewon31.kim@samsung.com>System Performance Lab.(MX)/삼성전자
>>Date   : 2024-05-21 11:40 (GMT+9)
>>Title  : [RESEND PATCH 00/10] memblock: introduce memsize showing reserved memory
>>?
>>Some of memory regions can be reserved for a specific purpose. They are
>>usually defined through reserved-memory in device tree. If only size
>>without address is specified in device tree, the address of the region
>>will be determined at boot time.
>>
>>We may find the address of the memory regions through booting log, but
>>it does not show all. And it could be hard to catch the very beginning
>>log. The memblock_dump_all shows all memblock status but it does not
>>show region name and its information is difficult to summarize.
>>
>>This patch introduce a debugfs node, memblock/memsize, to see reserved
>>memory easily.
>>
>>Here's an example
>>
>>$ cat debugfs/memblock/memsize
>>
>>0x0000000000000000-0x0000000000000000 0x02000000 (?  32768 KB )?  map reusable linux,cma
>>0x0000000000000000-0x0000000000000000 0x01000000 (?  16384 KB )?  map reusable vxxxxx
>>...
>>0x0000000000000000-0x0000000000000000 0x004e0000 (? ? 4992 KB ) nomap unusable unknown
>>0x0000000000000000-0x0000000000000000 0x00400000 (? ? 4096 KB ) nomap unusable cxxxxx
>>0x0000000000000000-0x0000000000000000 0x00e00000 (?  14336 KB ) nomap unusable gxxxxx
>>
>>Reserved? ? : 1223856 KB
>> .kernel? ? :? 275208 KB
>>? .text? ?  :?  16576 KB
>>? .rwdata?  :? ? 1963 KB
>>? .rodata?  :?  11920 KB
>>? .bss? ? ? :? ? 2450 KB
>>? .memmap?  :? 186368 KB
>>? .etc? ? ? :?  55933 KB
>> .unusable? :? 948648 KB
>>System? ? ? : 11359056 KB
>> .common? ? : 10306384 KB
>> .reusable? : 1052672 KB
>>Total? ? ?  : 12582912 KB ( 12288.00 MB )
>>
>>Jaewon Kim (10):
>>? memblock: introduce memsize showing reserved memory
>>? memblock: detect hidden memory hole size
>>? memblock: handle overlapped reserved memory region
>>? memblock: take a region intersecting an unknown region
>>? memblock: track memblock changed at early param
>>? memblock: recognize late freed size by checking PageReserved
>>? memblock: track kernel size on memsize
>>? memblock: print memsize summary information
>>? memblock: print kernel internal size
>>? memblock: support memsize reusable to consider as reusable
>>
>> drivers/of/fdt.c? ? ? ? ? ?  |? 11 +
>> drivers/of/of_reserved_mem.c |? 12 +-
>> include/linux/memblock.h? ?  |? 29 ++
>> init/main.c? ? ? ? ? ? ? ? ? |? 13 +-
>> kernel/dma/contiguous.c? ? ? |?  9 +-
>> mm/Kconfig? ? ? ? ? ? ? ? ?  |? 16 ++
>> mm/memblock.c? ? ? ? ? ? ? ? | 502 ++++++++++++++++++++++++++++++++++-
>> mm/mm_init.c? ? ? ? ? ? ? ?  |?  6 +-
>> mm/page_allocc? ? ? ? ? ? ? |? 10 +-
>> 9 files changed, 597 insertions(+), 11 deletions(-)
>>
>>-- 
>>2.25.1
>
>Hello Mike 
>
>This is actually RESEND as it was introduced 2 years ago.
>Please refer to https://lore.kernel.org/linux-mm/YkQB6Ah603yPR3qf@kernel.org/#t
>
>> But you never provided details about *why* you want this information exposed.
>
>For your question, I'd like to say ;
>We can see the same format and exact information between different version of kernel status.
>
>1) Internally we can check if the reserved memory changes.
>2) Externally we can communicate between chipset vendors and OEM, with a same format.
>

Maybe you can show the log difference, so that we can see how it helps you.

>This helps us to communitcate well, to easily detect changes or just to see differences.
>
>Jaewon Kim
>

-- 
Wei Yang
Help you, Help me

