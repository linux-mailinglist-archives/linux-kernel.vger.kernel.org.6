Return-Path: <linux-kernel+bounces-185907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E017A8CBCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D271F22CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9687E58F;
	Wed, 22 May 2024 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZRbCgbM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6777F30
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365812; cv=none; b=bk5aeAIO0k0CcGpbQKpp+GqPjXCjRc896rc9hUmOtWn54pn6YrLl8C9hiEuEIdEujhwlVPpo6MWKCyf8mns9IZnPjqcnUHzs2uJp4FXuZrChCZ3dkBu3vDxsktN4G7kY0vppeuqLVGZP7IkyByZ+jLaA3+WujLtfgzutZP0U+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365812; c=relaxed/simple;
	bh=brnfMtGcMMlEPk53jJhmT21576fF5GBWJDH0XGnxxLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icJU9627kXb5dGIC/o52iOwJYhbY0bD00d5qz61MPqXCbNkaNqdSpEHEKbcnndS+AN0ecSdPqdy8+OejJMiyH3xJrlVdVfqmpWIoQeMpaUO8bsC4msWu1M4RbyBDOgWs/0t694Z1PCCfHIWo+WXaloz1LE3ylsS4XMUIw5xKnx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZRbCgbM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so475891266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716365809; x=1716970609; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWF9+jISPa0SvmLgvqwBtrWZLN0MZwBJjydQ/zsUvNc=;
        b=MZRbCgbMmqxB7kTX/rK4fARPybcNs5xGq+NBH9XeW81qPDUtxYtrHellnUNeeonMhQ
         Q0z4cFAPg1MPFq9DM11QbYbW1x4jgzMa9rABhKnu1/BT+gNGYez3dJbtRDSbfXFxaIT9
         Xt8Km0FTFpUtyoN3f2p9tXAWijJc0QR3gYnwS5J8HxI7hTdgiKQ81NmE4HX3qV/6pD5o
         w1dAe8qBDlVgo+OKq2abdeJyFhj3bQQYoSW6fqQSXPz2i1GbEInzD+L2LSw2J0TtjJ2N
         1MDpoHZ0bYqyEVhglM2Lv6Yrw7zIyPh8BrqCtWvx42U577odWZjZ/1SemHZfh8pFmdBb
         802g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365809; x=1716970609;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWF9+jISPa0SvmLgvqwBtrWZLN0MZwBJjydQ/zsUvNc=;
        b=oVWhZXeo7yQTRDN/PoAJygXt+0brZ0Nz+Wsstetuz9jJnrlUSpMCwFF32zqHMHt0Ec
         l5Gp53fi2igJpEzGTEaN/cRIAfgphd0tVYroTrFgrp+tcbXkt0qLAG2v4IdPr3Q02m4X
         Hm2p5VMAZao1EQmjpAj0d4rt7M3Mk4R4xKer/3ystK8a0Vd/ZCknzWWjwbPsvzwdps4+
         dQsYE9bXh21ceXEhm2Ououw8/H2GvQwEItMAkwPHpbGO8WRxK5SVveupFouovpLi2DaH
         LEsmHcn/qyAVmhs5wsw+MJVKGV3/MFDmZR9LK+gkqyWY0RaSmFAauDBjeEfJOO9JaPHv
         6UoA==
X-Forwarded-Encrypted: i=1; AJvYcCUea5kpNioyW8jIifwSynbV/rAWgKj/Z9fSfLcAlz8+C0xaieebirMA5800WrRgct+pBllqclPZ3lgfZjyQvpiHQYEDbczrkU2D2EoQ
X-Gm-Message-State: AOJu0YxIhMHniCG63oGYoE1QkPBGrFZMIBaPkhQMhqMZIcgOnhN1wcjm
	mViLRfRTSh7/wQ5Q2JQkByXcTfncD7dqY/Zl6kr/zP+zptHWddK5
X-Google-Smtp-Source: AGHT+IFAwo2wFFZHqeFgGha0f7XN6Yby5SI6m6Aol27vpYXjkrNMUOIKkSX1cPRjU/m4x492FGLRvQ==
X-Received: by 2002:a17:906:693:b0:a5f:ae29:6a53 with SMTP id a640c23a62f3a-a62281f798fmr67350466b.66.1716365808900;
        Wed, 22 May 2024 01:16:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7da8sm1751489066b.99.2024.05.22.01.16.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2024 01:16:48 -0700 (PDT)
Date: Wed, 22 May 2024 08:16:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: Mike Rapoport <rppt@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
	"tkjos@google.com" <tkjos@google.com>
Subject: Re: (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <20240522081647.zlwenenrbrjemlp6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <ZkxN0yQ7Fb0X26hT@kernel.org>
 <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p5>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, May 21, 2024 at 07:17:53PM +0900, Jaewon Kim wrote:
>>On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
>>> >--------- Original Message ---------
>>> >Sender : 김재원 <jaewon31.kim@samsung.com>System Performance Lab.(MX)/삼성전자
>>> >Date   : 2024-05-21 11:40 (GMT+9)
>>> >Title  : [RESEND PATCH 00/10] memblock: introduce memsize showing reserved memory
>>> >?
>>> >Some of memory regions can be reserved for a specific purpose. They are
>>> >usually defined through reserved-memory in device tree. If only size
>>> >without address is specified in device tree, the address of the region
>>> >will be determined at boot time.
>>> >
>>> >We may find the address of the memory regions through booting log, but
>>> >it does not show all. And it could be hard to catch the very beginning
>>> >log. The memblock_dump_all shows all memblock status but it does not
>>> >show region name and its information is difficult to summarize.
>>> >
>>> >This patch introduce a debugfs node, memblock/memsize, to see reserved
>>> >memory easily.
>>> >
>>> >Here's an example
>>> >
>>> >$ cat debugfs/memblock/memsize
>>> >
>>> >0x0000000000000000-0x0000000000000000 0x02000000 (?  32768 KB )?  map reusable linux,cma
>>> >0x0000000000000000-0x0000000000000000 0x01000000 (?  16384 KB )?  map reusable vxxxxx
>>> >...
>>> >0x0000000000000000-0x0000000000000000 0x004e0000 (? ? 4992 KB ) nomap unusable unknown
>>> >0x0000000000000000-0x0000000000000000 0x00400000 (? ? 4096 KB ) nomap unusable cxxxxx
>>> >0x0000000000000000-0x0000000000000000 0x00e00000 (?  14336 KB ) nomap unusable gxxxxx
>>> >
>>> >Reserved? ? : 1223856 KB
>>> > .kernel? ? :? 275208 KB
>>> >? .text? ?  :?  16576 KB
>>> >? .rwdata?  :? ? 1963 KB
>>> >? .rodata?  :?  11920 KB
>>> >? .bss? ? ? :? ? 2450 KB
>>> >? .memmap?  :? 186368 KB
>>> >? .etc? ? ? :?  55933 KB
>>> > .unusable? :? 948648 KB
>>> >System? ? ? : 11359056 KB
>>> > .common? ? : 10306384 KB
>>> > .reusable? : 1052672 KB
>>> >Total? ? ?  : 12582912 KB ( 12288.00 MB )
>>> >
>>> >Jaewon Kim (10):
>>> >? memblock: introduce memsize showing reserved memory
>>> >? memblock: detect hidden memory hole size
>>> >? memblock: handle overlapped reserved memory region
>>> >? memblock: take a region intersecting an unknown region
>>> >? memblock: track memblock changed at early param
>>> >? memblock: recognize late freed size by checking PageReserved
>>> >? memblock: track kernel size on memsize
>>> >? memblock: print memsize summary information
>>> >? memblock: print kernel internal size
>>> >? memblock: support memsize reusable to consider as reusable
>>> >
>>> > drivers/of/fdt.c? ? ? ? ? ?  |? 11 +
>>> > drivers/of/of_reserved_mem.c |? 12 +-
>>> > include/linux/memblock.h? ?  |? 29 ++
>>> > init/main.c? ? ? ? ? ? ? ? ? |? 13 +-
>>> > kernel/dma/contiguous.c? ? ? |?  9 +-
>>> > mm/Kconfig? ? ? ? ? ? ? ? ?  |? 16 ++
>>> > mm/memblock.c? ? ? ? ? ? ? ? | 502 ++++++++++++++++++++++++++++++++++-
>>> > mm/mm_init.c? ? ? ? ? ? ? ?  |?  6 +-
>>> > mm/page_alloc.c? ? ? ? ? ? ? |? 10 +-
>>> > 9 files changed, 597 insertions(+), 11 deletions(-)
>>> >
>>> >-- 
>>> >2.25.1
>>> 
>>> Hello Mike 
>>> 
>>> This is actually RESEND as it was introduced 2 years ago.
>>> Please refer to https://lore.kernel.org/linux-mm/YkQB6Ah603yPR3qf@kernel.org/#t
>>> 
>>> > But you never provided details about *why* you want this information exposed.
>>> 
>>> For your question, I'd like to say ;
>>> We can see the same format and exact information between different version of kernel status.
>>> 
>>> 1) Internally we can check if the reserved memory changes.
>>> 2) Externally we can communicate between chipset vendors and OEM, with a same format.
>>
>>Why the existing debugfs interface is not sufficient?
>
>debugfs/memblock/memory & debugfs/memblock/reserved have changed its format but still does not show name, reusable, kernel size.

Would you mind showing which information matters to you most in the following
example log message? What you expect to see and helps you on locating problem?

0x0000000000000000-0x0000000000000000 0x02000000 (   32768 KB )   map reusable linux,cma
0x0000000000000000-0x0000000000000000 0x01000000 (   16384 KB )   map reusable vxxxxx
.
0x0000000000000000-0x0000000000000000 0x004e0000 (    4992 KB ) nomap unusable unknown
0x0000000000000000-0x0000000000000000 0x00400000 (    4096 KB ) nomap unusable cxxxxx
0x0000000000000000-0x0000000000000000 0x00e00000 (   14336 KB ) nomap unusable gxxxxx

Reserved    : 1223856 KB
 .kernel    :  275208 KB
  .text     :   16576 KB
  .rwdata   :    1963 KB
  .rodata   :   11920 KB
  .bss      :    2450 KB
  .memmap   :  186368 KB
  .etc      :   55933 KB
 .unusable  :  948648 KB
System      : 11359056 KB
 .common    : 10306384 KB
 .reusable  : 1052672 KB
Total       : 12582912 KB ( 12288.00 MB )

>If memory is reserved from memblock, and did not freed back to memblock. Memblock does not know even after the memory is freed to system.

You mean we may reserve memory in memblock.reserved, but still have it freed
to system? This sounds a bug to me.

>I think a simple debug interface is needed to easily communicate with others or compare different SW releases.
>
>> 
>>> This helps us to communitcate well, to easily detect changes or just to see differences.
>>> 
>>> Jaewon Kim
>>> 
>>
>>-- 
>>Sincerely yours,
>>Mike.
>
>

-- 
Wei Yang
Help you, Help me

