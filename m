Return-Path: <linux-kernel+bounces-184571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1C48CA8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 278DCB2288C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3821A54277;
	Tue, 21 May 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Degd8G0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD553E0A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276797; cv=none; b=hKMlx0FTGQLoqIWWDHwAKZ4X/yjdl377gdbsoRWgMPJcXqXQm+SD2BMliQLv1UjSz6ULSQuzDl2wu6P+cz2OswcujaDd6rrii6VQqESW0ek14f0Zgvsf5BuOQr2LAO81kRQgiA4zYaPJ8l0ZsslY51C/IAx0FHkmOqqHd99hYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276797; c=relaxed/simple;
	bh=DvwhrxxsccQSrw9QTfMS9cC8aa8Ng49TDT7sFzlr740=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+SgCjDUzo40xwyRQJPgfC6l/0ehA7nj4A77JS5Yu/g1iIgODWdJj/WXjS9lYOgB2QyL0JaFaBg95Fr0CjFbM3UUD0keIYDf9uejfV+BtgqUyqDuIlkGciU7fPOjvEqCmq2XwD6vkOnEk5h10rmV+81HmPd2aXZ6f/XRcmIrnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Degd8G0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996B0C4AF07;
	Tue, 21 May 2024 07:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716276797;
	bh=DvwhrxxsccQSrw9QTfMS9cC8aa8Ng49TDT7sFzlr740=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Degd8G0mcC24obZPCioMA8GZLLkhmrbvq97vKhDminCEXOieMRtSfj16TjW1afYlu
	 JeTfVFrYSgrfjhFw220IL/rvqfUbvGQts5I0aO6/hFOJ+vNhKT4aR4t9e6SvweYZms
	 oZFmWsxKcB0LWLo2Zs9SdI1fAsBf6gAzSfE4hr2mDhNJVzHbzs1EL1p5oicA1hdfGg
	 BCLD+XzW7sUumjHEQ6STLt4n7XXY6mChMkapkkGETW40yvV9WEUj8+z9cvHCYSrXSz
	 iLRvo/R3UleCpZ14PLwqlumuhWfKzqpebWuQGZO+IIy+9rvbSRS+8Yvy4LDdp8LF1I
	 1lyDUZaXn42iw==
Date: Tue, 21 May 2024 10:31:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
	"tkjos@google.com" <tkjos@google.com>
Subject: Re: [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <ZkxN0yQ7Fb0X26hT@kernel.org>
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

On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
> >--------- Original Message ---------
> >Sender : 김재원 <jaewon31.kim@samsung.com>System Performance Lab.(MX)/삼성전자
> >Date   : 2024-05-21 11:40 (GMT+9)
> >Title  : [RESEND PATCH 00/10] memblock: introduce memsize showing reserved memory
> >?
> >Some of memory regions can be reserved for a specific purpose. They are
> >usually defined through reserved-memory in device tree. If only size
> >without address is specified in device tree, the address of the region
> >will be determined at boot time.
> >
> >We may find the address of the memory regions through booting log, but
> >it does not show all. And it could be hard to catch the very beginning
> >log. The memblock_dump_all shows all memblock status but it does not
> >show region name and its information is difficult to summarize.
> >
> >This patch introduce a debugfs node, memblock/memsize, to see reserved
> >memory easily.
> >
> >Here's an example
> >
> >$ cat debugfs/memblock/memsize
> >
> >0x0000000000000000-0x0000000000000000 0x02000000 (?  32768 KB )?  map reusable linux,cma
> >0x0000000000000000-0x0000000000000000 0x01000000 (?  16384 KB )?  map reusable vxxxxx
> >...
> >0x0000000000000000-0x0000000000000000 0x004e0000 (? ? 4992 KB ) nomap unusable unknown
> >0x0000000000000000-0x0000000000000000 0x00400000 (? ? 4096 KB ) nomap unusable cxxxxx
> >0x0000000000000000-0x0000000000000000 0x00e00000 (?  14336 KB ) nomap unusable gxxxxx
> >
> >Reserved? ? : 1223856 KB
> > .kernel? ? :? 275208 KB
> >? .text? ?  :?  16576 KB
> >? .rwdata?  :? ? 1963 KB
> >? .rodata?  :?  11920 KB
> >? .bss? ? ? :? ? 2450 KB
> >? .memmap?  :? 186368 KB
> >? .etc? ? ? :?  55933 KB
> > .unusable? :? 948648 KB
> >System? ? ? : 11359056 KB
> > .common? ? : 10306384 KB
> > .reusable? : 1052672 KB
> >Total? ? ?  : 12582912 KB ( 12288.00 MB )
> >
> >Jaewon Kim (10):
> >? memblock: introduce memsize showing reserved memory
> >? memblock: detect hidden memory hole size
> >? memblock: handle overlapped reserved memory region
> >? memblock: take a region intersecting an unknown region
> >? memblock: track memblock changed at early param
> >? memblock: recognize late freed size by checking PageReserved
> >? memblock: track kernel size on memsize
> >? memblock: print memsize summary information
> >? memblock: print kernel internal size
> >? memblock: support memsize reusable to consider as reusable
> >
> > drivers/of/fdt.c? ? ? ? ? ?  |? 11 +
> > drivers/of/of_reserved_mem.c |? 12 +-
> > include/linux/memblock.h? ?  |? 29 ++
> > init/main.c? ? ? ? ? ? ? ? ? |? 13 +-
> > kernel/dma/contiguous.c? ? ? |?  9 +-
> > mm/Kconfig? ? ? ? ? ? ? ? ?  |? 16 ++
> > mm/memblock.c? ? ? ? ? ? ? ? | 502 ++++++++++++++++++++++++++++++++++-
> > mm/mm_init.c? ? ? ? ? ? ? ?  |?  6 +-
> > mm/page_alloc.c? ? ? ? ? ? ? |? 10 +-
> > 9 files changed, 597 insertions(+), 11 deletions(-)
> >
> >-- 
> >2.25.1
> 
> Hello Mike 
> 
> This is actually RESEND as it was introduced 2 years ago.
> Please refer to https://lore.kernel.org/linux-mm/YkQB6Ah603yPR3qf@kernel.org/#t
> 
> > But you never provided details about *why* you want this information exposed.
> 
> For your question, I'd like to say ;
> We can see the same format and exact information between different version of kernel status.
> 
> 1) Internally we can check if the reserved memory changes.
> 2) Externally we can communicate between chipset vendors and OEM, with a same format.

Why the existing debugfs interface is not sufficient?
 
> This helps us to communitcate well, to easily detect changes or just to see differences.
> 
> Jaewon Kim
> 

-- 
Sincerely yours,
Mike.

