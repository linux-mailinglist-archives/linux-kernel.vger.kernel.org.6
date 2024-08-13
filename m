Return-Path: <linux-kernel+bounces-285533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A761950F16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9613B24F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A31AD401;
	Tue, 13 Aug 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/vQeNHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD871A76D3;
	Tue, 13 Aug 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583853; cv=none; b=YpvLuNxXMiHGlLqsKovEBkFgKZa11sysua32tRRaxCWkuaPxam6OOT4O82/w6RGtT3poWvysDa8+Nd9NQ9x+V8aKZHXcWI+zhK6gI87McybiqaTUAGA+llbtoSYMLkDZqthGglIGmtt50b/voaw8huUdWOGl0jTxgqnRU+PDgCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583853; c=relaxed/simple;
	bh=f8OaPGcl40vzbwoZPTs9LPTXcTWTU3nBPqiaH+u+E0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV5GKA46ppSEkfn4jzCm7BHEwPoW4uHigc6RJi9iwZRzxhnRJDH1lvCIwUt9yM/zfHM4e3y8rlrgftTb8OrOhGHXpR748H1OHR/ngbToe/VqSRYqWR/b2b4ffxjyTYXALwIrk6vCD7eFBuA18rclO+UhruYYHu01uyVUOTdmRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/vQeNHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BDBC32782;
	Tue, 13 Aug 2024 21:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723583852;
	bh=f8OaPGcl40vzbwoZPTs9LPTXcTWTU3nBPqiaH+u+E0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/vQeNHnbznjuzhkE83iNElju93C9cWc5oB2ALvimGmR1o+rdZ2XGvu8wqcaK/9oc
	 Y3d2C8OsEGl6560d987xGg7/HCDYti7uVx1wgT+zDB/tmuEyjAJSWFkvwUfuPhR8El
	 R6qfArw/0jnU73abNeKPFdNx80djvda0+fnhYbzN7lXk/ihOalrw0QWucJOnCg2KuS
	 P+nPrP2iRR8nwuvc483sKuoE9aU0DBy4lVRL3eVoAhjykdVjFJksbZco1ogih370Ub
	 xUJOO+fVLcp47dA8B5/3egDC0Eqk6g1s3Bar+XhhEUc+msNCY0VeCmPUyKqNEqfDXy
	 xA8uqQHnn+dMA==
Date: Tue, 13 Aug 2024 15:17:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v4 1/2] of/irq: Prevent device address out-of-bounds read
 in interrupt map walk
Message-ID: <172358384538.2043855.85185364158874598.robh@kernel.org>
References: <20240812100652.3800963-1-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812100652.3800963-1-stefan.wiehler@nokia.com>


On Mon, 12 Aug 2024 12:06:51 +0200, Stefan Wiehler wrote:
> When of_irq_parse_raw() is invoked with a device address smaller than
> the interrupt parent node (from #address-cells property), KASAN detects
> the following out-of-bounds read when populating the initial match table
> (dyndbg="func of_irq_parse_* +p"):
> 
>   OF: of_irq_parse_one: dev=/soc@0/picasso/watchdog, index=0
>   OF:  parent=/soc@0/pci@878000000000/gpio0@17,0, intsize=2
>   OF:  intspec=4
>   OF: of_irq_parse_raw: ipar=/soc@0/pci@878000000000/gpio0@17,0, size=2
>   OF:  -> addrsize=3
>   ==================================================================
>   BUG: KASAN: slab-out-of-bounds in of_irq_parse_raw+0x2b8/0x8d0
>   Read of size 4 at addr ffffff81beca5608 by task bash/764
> 
>   CPU: 1 PID: 764 Comm: bash Tainted: G           O       6.1.67-484c613561-nokia_sm_arm64 #1
>   Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.01-12.24.03-dirty 01/01/2023
>   Call trace:
>    dump_backtrace+0xdc/0x130
>    show_stack+0x1c/0x30
>    dump_stack_lvl+0x6c/0x84
>    print_report+0x150/0x448
>    kasan_report+0x98/0x140
>    __asan_load4+0x78/0xa0
>    of_irq_parse_raw+0x2b8/0x8d0
>    of_irq_parse_one+0x24c/0x270
>    parse_interrupts+0xc0/0x120
>    of_fwnode_add_links+0x100/0x2d0
>    fw_devlink_parse_fwtree+0x64/0xc0
>    device_add+0xb38/0xc30
>    of_device_add+0x64/0x90
>    of_platform_device_create_pdata+0xd0/0x170
>    of_platform_bus_create+0x244/0x600
>    of_platform_notify+0x1b0/0x254
>    blocking_notifier_call_chain+0x9c/0xd0
>    __of_changeset_entry_notify+0x1b8/0x230
>    __of_changeset_apply_notify+0x54/0xe4
>    of_overlay_fdt_apply+0xc04/0xd94
>    ...
> 
>   The buggy address belongs to the object at ffffff81beca5600
>    which belongs to the cache kmalloc-128 of size 128
>   The buggy address is located 8 bytes inside of
>    128-byte region [ffffff81beca5600, ffffff81beca5680)
> 
>   The buggy address belongs to the physical page:
>   page:00000000230d3d03 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1beca4
>   head:00000000230d3d03 order:1 compound_mapcount:0 compound_pincount:0
>   flags: 0x8000000000010200(slab|head|zone=2)
>   raw: 8000000000010200 0000000000000000 dead000000000122 ffffff810000c300
>   raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
>   page dumped because: kasan: bad access detected
> 
>   Memory state around the buggy address:
>    ffffff81beca5500: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffffff81beca5580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   >ffffff81beca5600: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                         ^
>    ffffff81beca5680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffffff81beca5700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>   ==================================================================
>   OF:  -> got it !
> 
> Prevent the out-of-bounds read by copying the device address into a
> buffer of sufficient size.
> 
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  drivers/of/irq.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Applied, thanks!


