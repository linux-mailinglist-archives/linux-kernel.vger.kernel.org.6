Return-Path: <linux-kernel+bounces-284339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AE0950011
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D081F2378F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B70143889;
	Tue, 13 Aug 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="gSKoHX1y"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDB1BDDC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538430; cv=none; b=aWOCep6cuJ+r34V+dkNJ46X198yXoPK7nLBcjkUcpw2S8tW0Yjk62cZ7LPZOO1kqXgnubXtmExqooqWU+yGMwBUxdNDTVfeBaqD/W0Qbuwsk4jDogtFJEBGYIyJ7a8PBTlsnlM62yHVjTQPkzVU5chyhDGq7h7pnVuVK9uuLU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538430; c=relaxed/simple;
	bh=akXev+YNA9uQ7zhGiunl63A4R/Odt5Pc9ddezLJTHyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOMv87qz8v1f2XfBl7o+zK6hnYO2lsJzEVzUZ+a3kmCrmdPOYeBft8jSu3VlE3A9UhmVseV9hI2J3f95eLR2u+yGEggyk/NQIa03iYEFoXUmC+V6VynwaseF7KifmtrJw9wmCdNvXmvg/L11Hr+kxv2QtESAWLzu1ubQHBJdYtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=gSKoHX1y; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id AA57D1DD8F4;
	Tue, 13 Aug 2024 10:40:17 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723538417; bh=+CB3AGdZxpN1qDzpfCmR2fXPuhWenCYU98WPyCmPcbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gSKoHX1ynpXgGo54H/X1Op9pUo2k4TFLAcNL2THOGJ88fcL0FRZ6VY12qmRaM6BXW
	 10omo4GDISaZakiQcFXihpyemDW3E3Ht3YCHwCyIK+D8q+hqhUMyE1wwLZOVKxwYDd
	 0QyROvxzJLWewl6aob6mx9bMqOuqZcNG7M4BU09s8mzIqfu0vDEN9Gr9GqnTSeFp2d
	 AKgQk7frb92oqwICB00izD/6IMNT55WkatoppaiNT6LFjhOr3DprcAKd6+qL/+KFxe
	 NnHKIPj1hfwchX4wKh27babIEzyJ66CmNzTCrQ8DNR2I8jSHXNxwLmK1jTyw4jqwcj
	 nnLBdotkEtigA==
Date: Tue, 13 Aug 2024 10:40:06 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Baoquan He <bhe@redhat.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
 akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <20240813104006.520bf42d@mordecai.tesarici.cz>
In-Reply-To: <ZrJ60vopeGDXFZyK@arm.com>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
	<ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
	<ZrJ1JkyDVpRRB_9e@arm.com>
	<ZrJ60vopeGDXFZyK@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Catalin,

On Tue, 6 Aug 2024 20:34:42 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Tue, Aug 06, 2024 at 08:10:30PM +0100, Catalin Marinas wrote:
> > On Fri, Aug 02, 2024 at 06:11:01PM +0800, Baoquan He wrote:  
> > > On 08/02/24 at 05:01pm, Jinjie Ruan wrote:  
> > > > On RISCV64 Qemu machine with 512MB memory, cmdline "crashkernel=500M,high"
> > > > will cause system stall as below:
> > > > 
> > > > 	 Zone ranges:
> > > > 	   DMA32    [mem 0x0000000080000000-0x000000009fffffff]
> > > > 	   Normal   empty
> > > > 	 Movable zone start for each node
> > > > 	 Early memory node ranges
> > > > 	   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> > > > 	   node   0: [mem 0x0000000080060000-0x000000009fffffff]
> > > > 	 Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
> > > > 	(stall here)
> > > > 
> > > > commit 5d99cadf1568 ("crash: fix x86_32 crash memory reserve dead loop
> > > > bug") fix this on 32-bit architecture. However, the problem is not
> > > > completely solved. If `CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX` on 64-bit
> > > > architecture, for example, when system memory is equal to
> > > > CRASH_ADDR_LOW_MAX on RISCV64, the following infinite loop will also occur:  
> > > 
> > > Interesting, I didn't expect risc-v defining them like these.
> > > 
> > > #define CRASH_ADDR_LOW_MAX              dma32_phys_limit
> > > #define CRASH_ADDR_HIGH_MAX             memblock_end_of_DRAM()  
> > 
> > arm64 defines the high limit as PHYS_MASK+1, it doesn't need to be
> > dynamic and x86 does something similar (SZ_64T). Not sure why the
> > generic code and riscv define it like this.
> >   
> > > > 	-> reserve_crashkernel_generic() and high is true
> > > > 	   -> alloc at [CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX] fail
> > > > 	      -> alloc at [0, CRASH_ADDR_LOW_MAX] fail and repeatedly  
> > > > 	         (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> > > > 
> > > > Before refactor in commit 9c08a2a139fe ("x86: kdump: use generic interface
> > > > to simplify crashkernel reservation code"), x86 do not try to reserve crash
> > > > memory at low if it fails to alloc above high 4G. However before refator in
> > > > commit fdc268232dbba ("arm64: kdump: use generic interface to simplify
> > > > crashkernel reservation"), arm64 try to reserve crash memory at low if it
> > > > fails above high 4G. For 64-bit systems, this attempt is less beneficial
> > > > than the opposite, remove it to fix this bug and align with native x86
> > > > implementation.  
> > > 
> > > And I don't like the idea crashkernel=,high failure will fallback to
> > > attempt in low area, so this looks good to me.  
> > 
> > Well, I kind of liked this behaviour. One can specify ,high as a
> > preference rather than forcing a range. The arm64 land has different
> > platforms with some constrained memory layouts. Such fallback works well
> > as a default command line option shipped with distros without having to
> > guess the SoC memory layout.  
> 
> I haven't tried but it's possible that this patch also breaks those
> arm64 platforms with all RAM above 4GB when CRASH_ADDR_LOW_MAX is
> memblock_end_of_DRAM(). Here all memory would be low and in the absence
> of no fallback, it fails to allocate.

I'm afraid you've just opened a Pandora box... ;-)

Another (unrelated) patch series made us aware of a platforms where RAM
starts at 32G, but IIUC the host bridge maps 32G-33G to bus addresses
0-1G, and there is a device on that bus which can produce only 30-bit
addresses.

Now, what was the idea behind allocating some crash memory "low"?
Right, it should allow the crash kernel to access devices with
addressing constraints. So, on the above-mentioned platform, allocating
"low" would in fact mean allocating between 32G and 33G (in host address
domain).

Should we rethink the whole concept of high/low?

Petr T

