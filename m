Return-Path: <linux-kernel+bounces-245447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC1F92B29E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1823128149F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6CF1534E7;
	Tue,  9 Jul 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei652AOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894113DB9B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515176; cv=none; b=GRmelR+wJQcNJfT/Z3Px43MXUvn72cKlpD9RM20C5yUsSoyk+L08B0OA7alexAl5Rf/84U0Wd6ORLeiypqQNVW/t/18q5rywjtqRGo5HA9F1vPXtKVHtWN8fYcUlakDS0v7LirerBcavFd+H8C6VckKzJVS8DAPpsZQpFwfhtcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515176; c=relaxed/simple;
	bh=SQQKU0KDENOuKwJyJKeP5Vmpn3HorVX9GDQnll93Gk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJLMRcX1VUWNXd9BJ6DkPDf+Ee4zniTrbfcfxrFiEgS3zT8OQqPqJtv6V6vjFDwiM2WdXscssxUODr3sJO4Fy2mwnsD2Oi3P0hu/d74HITq6RXjXUEzfdYrY8ESsX+tM82T9Yop2kaMuAolECalRT2FThysxAjLabBNgpyQ6EUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei652AOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E81AC3277B;
	Tue,  9 Jul 2024 08:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720515176;
	bh=SQQKU0KDENOuKwJyJKeP5Vmpn3HorVX9GDQnll93Gk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ei652AOk+yHKGcZ2UuaSRRRwtRsck7GQKAUB3b0w1fInsxWZ9Q90fqoCfuL58Nypk
	 gSi4mJV0DvwYXrwVIXFVgnIdU1BddZNKmmr4Dhjo7hYYNwovQSOmoBj6/fEbQKjmVz
	 LawuRb3vNy90SXbrx1K7tgrfNoNwH7kYI1afCZVePoXn3bjsEg+u7DrNheUN1X6zMt
	 Ky+bRhJQs2EodBVCT/V7v1hr/HZ4JygSmeB2WesXSib1Qjbk/xoK2xNMrDhfoTo/nG
	 j+126t8O8yr/stopkaZH44NF1B2jz1ILGEGVnLtO7MMeL/SZ2pl+BMvaI5GdeKmigG
	 jL15o5Pk+ZQEA==
Date: Tue, 9 Jul 2024 11:50:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"venkat88@linux.vnet.ibm.com" <venkat88@linux.vnet.ibm.com>,
	"npiggin@gmail.com" <npiggin@gmail.com>,
	"sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [linux-next-6.10-rc6-20240703] Warning at mm/memblock.c:1447
Message-ID: <Zoz5xcAr0tIZr0F5@kernel.org>
References: <a70e4064-a040-447b-8556-1fd02f19383d@linux.vnet.ibm.com>
 <e6dbf04ca92a021856d8da2a4e795908290c6c9c.camel@amazon.com>
 <b2a69b564f4661b2c948bf876778730c01f982f2.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2a69b564f4661b2c948bf876778730c01f982f2.camel@amazon.com>

On Tue, Jul 09, 2024 at 08:21:27AM +0000, Gowans, James wrote:
> On Mon, 2024-07-08 at 11:58 +0200, James Gowans wrote:
> > Hi Venkat,
> > 
> > On Mon, 2024-07-08 at 15:09 +0530, Venkat Rao Bagalkote wrote:
> > > Greetings!!!
> > > 
> > > 
> > > Observing below warning while booting, when fadump is configured with nocam.
> > > 
> > > 
> > > [    0.061329] ------------[ cut here ]------------
> > > [    0.061332] WARNING: CPU: 0 PID: 1 at mm/memblock.c:1447
> > > memblock_alloc_range_nid+0x24c/0x278
> > > [    0.061337] Modules linked in:
> > > [    0.061339] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> > > 6.10.0-rc6-next-20240703-auto #1
> > > [    0.061341] Hardware name: IBM,9080-HEX POWER10 (architected)
> > > 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_016) hv:phyp pSeries
> > > [    0.061342] NIP:  c000000002061610 LR: c000000002061424 CTR:
> > > 0000000000000000
> > > [    0.061344] REGS: c000000004d2f780 TRAP: 0700   Not tainted
> > > (6.10.0-rc6-next-20240703-auto)
> > > [    0.061345] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR:
> > > 44000242  XER: 20040010
> > > [    0.061350] CFAR: c00000000206142c IRQMASK: 0
> > > [    0.061350] GPR00: c000000002061424 c000000004d2fa20 c0000000015a3d00
> > > 0000000000000001
> > > [    0.061350] GPR04: 0000000000000800 00000012c0000000 0000002580000000
> > > ffffffffffffffff
> > > [    0.061350] GPR08: 0000000000000000 0000000000000002 c000000002f58c08
> > > 0000000024000242
> > > [    0.061350] GPR12: c000000000454408 c000000003010000 c0000000000112ac
> > > 0000000000000000
> > > [    0.061350] GPR16: 0000000000000000 0000000000000000 0000000000000000
> > > 0000000000000000
> > > [    0.061350] GPR20: 0000000000000000 0000000000000000 0000000000000000
> > > c00000000149d390
> > > [    0.061350] GPR24: c00000000200466c ffffffffffffffff 0000002580000000
> > > 00000012c0000000
> > > [    0.061350] GPR28: 0000000000000800 0000000000000005 0000000000000000
> > > 0000000000000000
> > > [    0.061365] NIP [c000000002061610] memblock_alloc_range_nid+0x24c/0x278
> > > [    0.061368] LR [c000000002061424] memblock_alloc_range_nid+0x60/0x278
> > > [    0.061370] Call Trace:
> > > [    0.061371] [c000000004d2fa20] [c000000004d2fa60] 0xc000000004d2fa60
> > > (unreliable)
> > > [    0.061373] [c000000004d2fae0] [c00000000206178c]
> > > memblock_phys_alloc_range+0x60/0xe4
> > > [    0.061376] [c000000004d2fb60] [c000000002017a60]
> > > setup_fadump+0x114/0x244
> > > [    0.061379] [c000000004d2fbe0] [c000000000010e78]
> > > do_one_initcall+0x60/0x398
> > > [    0.061381] [c000000004d2fcc0] [c000000002006b5c]
> > > do_initcalls+0x12c/0x218
> > > [    0.061383] [c000000004d2fd70] [c000000002006f28]
> > > kernel_init_freeable+0x238/0x370
> > > [    0.061386] [c000000004d2fde0] [c0000000000112d8] kernel_init+0x34/0x26c
> > > [    0.061388] [c000000004d2fe50] [c00000000000df7c]
> > > ret_from_kernel_user_thread+0x14/0x1c
> > > [    0.061389] --- interrupt: 0 at 0x0
> > > [    0.061390] Code: eb81ffe0 ebc1fff0 ebe1fff8 7c0803a6 7d710120
> > > 7d708120 4e800020 60000000 4afbf219 60000000 3b800080 4bfffe40
> > > <0fe00000> e8610068 7f26cb78 38a02900
> > > [    0.061396] ---[ end trace 0000000000000000 ]---
> > 
> > The purpose of that newly introduced warning is to detect incorrect
> > usage of the memblock allocator. Specifically, to find when a
> > driver/subsystem tries to do a memblock alloc after memblock has given
> > all system RAM to the buddy allocator. It has maybe caught such a case
> > now...
> > 
> > I don't have a powerpc system handy to repro your failure, but looking
> > at the code, it looks like:
> > 1. fadump_setup_param_area allocs a physical range for
> > fw_dump.param_area and zeroes that range.
> > 2. fadump_append_bootargs() marks it as reserved
> > 
> > But I believe that by this point the memory has already been handed to
> > the buddy allocator. So it's possible for that zeroing to be clobbering
> > someone else's memory, as the fadump code incorrectly assumes that it
> > has exclusive use of this region.
> 
> Just to show you where the memblock memory is given to the buddy
> allocator:
> 
> mm_core_init
>   mem_init
>     memblock_free_all
>       free_low_memory_core_early
>   kmem_cache_init
> 
> 
> That first mem_init() path gives the memory to the buddy allocator, and
> then the call to kmem_cache_init() marks the slab as UP after which
> point calls to allocate from the memblock allocator will trigger the
> warning.
> 
> I suspect that the fadump allocation in question is happening after the
> above memory initialisation calls, which I think makes it an incorrect
> use of the memblock allocator. Can you confirm that setup_fadump()
> happens after that? If so I think you should either make the fadump
> setup happen much earlier if you want to use memblock, or else use a
> normal kmalloc.

From the trace it looks like setup_fadump() is an initcall and that
surely runs after page allocator and kmalloc are initialized.

Usage of memblock_phys_alloc_range() implies that allocation should use a
particular range in the physical memory, though, so use kmalloc or vmalloc
might not be an option.

More details about how fadump uses that memory would help to understand
what's the best way to move forward.
 
> JG
> 
> > 
> > I may be wildly off, but that was the *intention* of the warning.
> > 
> > Adding PowerPC maintainers here for their opinion on whether fadump is
> > doing the right thing here or not.
> > 
> > > 
> > > 
> > > cat /proc/cmdline
> > > BOOT_IMAGE=(ieee1275//vdevice/vfc-client@300000d4/disk@50050768101535e5,msdos3)/boot/vmlinuz-6.10.0-rc6-next-20240703
> > > root=UUID=2c90ab47-3389-4017-9f06-0c94534fd9cb ro
> > > crashkernel=2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G
> > > fadump=nocma
> > > 
> > > 
> > > Reverting the below commit, issue is not seen.
> > > 
> > > 
> > > Commit ID: 0fa4ac6722127f4aae2ea9813ba246ce2bec8326
> > > 
> > > 
> > > Regards,
> > > 
> > > Venkat.
> > > 
> > 
> 

-- 
Sincerely yours,
Mike.

