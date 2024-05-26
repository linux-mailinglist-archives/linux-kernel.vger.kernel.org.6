Return-Path: <linux-kernel+bounces-189746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7C18CF470
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF97B20C4C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B814003;
	Sun, 26 May 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEoxygiQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99760FC1C
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716731817; cv=none; b=Wtl3uLVMe2osV5XAmcjkK48b8kK3RgCTXw9JzQdltfhha3yef3uJAX9zCzkrKm5tjsgSUBsk22m0gDXy+XtGhu/qDPPHXQsIOzcAhcwYM3YzBsjYH1SapjiOUitJZaZzSARcjH/aOuJIj8kXVneQZfSPYKlLFTJp2GDCYSSvy8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716731817; c=relaxed/simple;
	bh=5krnBIVZ4dxE084sNLxLTA0q1E2w2NM4RO+BibuxlMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv3QK7ScNu2w3t3sz/0lwEvho62nU2TLvTGxBos09FqUlNXQVtiS2c2VTqF6G/qhe3V8eqJXjSn9g2eDuqnfDyZSMZUjIJDtXpZlXfCuLygJDLAyKzWQvZORMgrTiMkSkB4RvELUQ/5bk0XEMjuA2avzzV22OxObLm95SQhN6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEoxygiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CFBC32782;
	Sun, 26 May 2024 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716731817;
	bh=5krnBIVZ4dxE084sNLxLTA0q1E2w2NM4RO+BibuxlMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEoxygiQ8sk8AedVDHE6TRmYRugAfDR8g8jEx5U7Vbh8pU1Z3SCnLUQMLWFCplcbT
	 y2QPvBdN6By4VqFw2dim0T+zGYfe8dbsEHkfjP1behElRJy5+fHXFYOLSMvtv0I+Bn
	 0NDRzu/OFfIMD5cgY8WALcRuSEmhoRlN2N8bffaqqPy5Z0V/mULGO+ns7Z5kEejOgL
	 q+D7DVnZEl5RgoUVTQAqb8VJJMtq7hAnGMFGGFET88cW1n9oshJ5ArKNIPpcE/qbF1
	 EySY8+nG1kNXsWq6UM4tBghyd9cGLsBAMWR/10sTlZ4jRqhxz/poeiQgCG1jYsDJnV
	 bGuzgxu21/1Tw==
Date: Sun, 26 May 2024 16:55:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
	"tkjos@google.com" <tkjos@google.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Pintu Agarwal <pintu.ping@gmail.com>
Subject: Re: (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <ZlM_Ndng_JstAee3@kernel.org>
References: <Zk9UCsZdizqC1_36@kernel.org>
 <ZkxN0yQ7Fb0X26hT@kernel.org>
 <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p2>
 <20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>

Hi Jaewon,

Please use reply-all!

I just realized my previous reply went off-list :(

On Fri, May 24, 2024 at 06:07:15PM +0900, Jaewon Kim wrote:
> >On Tue, May 21, 2024 at 07:17:53PM +0900, Jaewon Kim wrote:
> >> >On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
> >> >> >--------- Original Message ---------
> >> >> >Sender : 김재원 <jaewon31.kim@samsung.com>System Performance Lab.(MX)/삼성전자
> >> >> >Date   : 2024-05-21 11:40 (GMT+9)
> >> >> >Title  : [RESEND PATCH 00/10] memblock: introduce memsize showing reserved memory
> >> >> >?
> >> >> >Some of memory regions can be reserved for a specific purpose. They are
> >> >> >usually defined through reserved-memory in device tree. If only size
> >> >> >without address is specified in device tree, the address of the region
> >> >> >will be determined at boot time.
> >> >> >
> >> >> >We may find the address of the memory regions through booting log, but
> >> >> >it does not show all. And it could be hard to catch the very beginning
> >> >> >log. The memblock_dump_all shows all memblock status but it does not
> >> >> >show region name and its information is difficult to summarize.
> >> >> >
> >> >> >This patch introduce a debugfs node, memblock/memsize, to see reserved
> >> >> >memory easily.
> >> >> 
> >> >> This is actually RESEND as it was introduced 2 years ago.
> >> >> Please refer to https://lore.kernel.org/linux-mm/YkQB6Ah603yPR3qf@kernel.org/#t
> >> >> 
> >> >> > But you never provided details about *why* you want this information exposed.
> >> >> 
> >> >> For your question, I'd like to say ;
> >> >> We can see the same format and exact information between different version of kernel status.
> >> >> 
> >> >> 1) Internally we can check if the reserved memory changes.
> >> >> 2) Externally we can communicate between chipset vendors and OEM, with a same format.
> >> >
> >> >Why the existing debugfs interface is not sufficient?
> >> 
> >> debugfs/memblock/memory & debugfs/memblock/reserved have changed its
> >> format but still does not show name, reusable, kernel size.  If memory is
> >> reserved from memblock, and did not freed back to memblock. Memblock does
> >> not know even after the memory is freed to system.  I think a simple
> >> debug interface is needed to easily communicate with others or compare
> >> different SW releases.
> >
> >I still don't understand what problem are you trying to solve with these
> >patches. 
> 
> I think we need a common API to easily see the reserved memory status.
> Through MemTotal on /proc/meminfo, we can only see only the total size
> of reserved memory. We don't how big kernel init size within the the
> total size. I think this really helps to compare different kernel and
> communicate with others.

As was already mentioned on this thread, something like

$ dmesg | grep Memory:
[    0.000000] Memory: 8058204K/8388608K available (35392K kernel code, 8706K rwdata, 23320K rodata, 16832K init, 848K bss, 297636K reserved, 32768K cma-reserved)

already shows init, rodata and bss sizes.

And size -A vmlinux provides detailed breakdown of the kernel image into
sections.
 
> I think the debugfs API or early boot log shows quite much information
> for the reserved memory information defined in device tree. But it is
> difficult to see after boot, as the boot log already was removed ouf of
> the kernel log buffer.

Kernel log is persisted, isn't it?

> And it does not show some information like kernel init size, late free
> pages. AFAIK if some memblocks are merged to a memblock data structure,
> the debugfs memblock API show it a one memblock rather than showing what
> each memblock request.

The reason to merge reserved regions is to save memory and CPU and in vast
majority of cases it is not important from where memblock_reserve() was
called. If it's really important to keep some of the reservations distinct,
it can be achieved by e.g. using .flags field in the reserved regions.

Your repost of the patches still does not address my comment from two
years ago:

	You propose complex mechanism that seems to fit very particular
	scenario and sprinkle some calls to this mechanism at random places
	because you need to "compare reserved memory map with other map".

As I said then, I don't mind providing more visibility into reserved memory
attributes in general, but I'd like to see something way more simple and
localized with a clear description what problem it solves and how it works
in a general case.
 
> BR
> Jaewon Kim

-- 
Sincerely yours,
Mike.

