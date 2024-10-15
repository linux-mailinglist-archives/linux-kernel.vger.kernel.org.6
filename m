Return-Path: <linux-kernel+bounces-366081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8AB99F09A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AE21C23579
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9D51CB9EB;
	Tue, 15 Oct 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uWWWDsB0"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0C1CB9E5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004585; cv=none; b=Lo/WfBuJ12CH2Pz7+MGs4kRkTvixd45QYrd1b8JhSa3iMnaJCOTayVLJUaZkXKpChLPJWdT8PZPxDHoOjJrjuIj+wMyJHWhtKImm8JUIfhFE0mhfO830sED88u+pVmfffolb3Omih8Fq67WYXdfSmtEqShpGBum+1b6ksZea7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004585; c=relaxed/simple;
	bh=vlyzC5BUbbJNVNWScwOO85MGiapIng12QT6Y4wU6baY=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRDWCBlVIefjRBRRPe6ZkmCCh2lgigs5YAjhdTWPhbhRh4I69hhVwwUkKedeOC5sACYNMh2sQR9cDQkgBrkb81oW6knPrqfbL4m5jM7irsx5U4AuaTElZljh0/OHiimjnLdPJFQLCY0WTASEWxxkEGHY6tp3GpAvypCH1bYVv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uWWWDsB0; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XScbd3N0vz9skM;
	Tue, 15 Oct 2024 16:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1729004141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSIjeIVkRNDw92J7H472zgM1PRJ1wxwFlN1v7e85EYw=;
	b=uWWWDsB0hcyw+DfJI27FfJl3Uv39GXthwnjhASdkfpao3VruviGbYuq12OrZYXixZiHjPb
	tupIS29zmFZUfObsA3/zBIfZOa/RXCzRRJsaAv8c8iGEY1QTaR4CuDy4aQL7qoog5f6ITw
	f1/qooi4E/QdntSEuRjOLIW1HzpUs9iz5lJnDAJ4lS3uXKiXf5bDt0BquYKNfyG7oVnos8
	bH66SC79WrQEOde8FkdW07CIszFHTpA2J/EaSLpD6IXo5NDh8dSiPMLWPbk0jaHMYP2Ftb
	AG+KZyO93n9TwIgDj/CSRK97RYBH0IrBLkU/hxmx+lJxJa0NOpL1QKPkEjjE9w==
Date: Tue, 15 Oct 2024 16:55:39 +0200
From: Erhard Furtner <erhard_f@mailbox.org>
To: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
 max8rr8@gmail.com
Subject: Re: "WARNING: CPU: 0 PID: 67 at arch/x86/mm/ioremap.c:461
 iounmap+0xda/0xe0" at initializing PCMCIA serial card (Thinkpad T60,
 v6.12-rc2)
Message-ID: <20241015165539.35fb42b8@yea>
In-Reply-To: <20241009191507.7ed7511b@yea>
References: <20241009191507.7ed7511b@yea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9909428950e9d4acda7
X-MBO-RS-META: mutm9ftonxgmc4w95c8nxwddn3sjmnsh

On Wed, 9 Oct 2024 19:15:07 +0200
Erhard Furtner <erhard_f@mailbox.org> wrote:

> On kernel v6.12-rc2 this warning shows up when my PCMCIA serial card gets initialized on my Thinkpad T60:
> 
> [...]
> pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
> pcmcia_socket pcmcia_socket0: cs: memory probe 0xe46d0000-0xe7ffffff:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 67 at arch/x86/mm/ioremap.c:461 iounmap+0xda/0xe0
> Modules linked in:
> CPU: 0 UID: 0 PID: 67 Comm: pccardd Tainted: G        W          6.12.0-rc2-P3 #3
> Tainted: [W]=WARN
> Hardware name: LENOVO 2007F2G/2007F2G, BIOS 79ETE7WW (2.27 ) 03/21/2011
> EIP: iounmap+0xda/0xe0
> Code: c7 75 2b 89 f8 e8 6a 27 16 00 5e 5f 5b 5d 31 c0 31 c9 31 d2 c3 56 68 9c 8e 92 c9 e8 e8 c3 73 00 83 c4 08 e8 3c 33 74 00 eb e0 <0f> 0b eb dc 0f 0b 55 89 e5 56 89 c6 25 00 f0 ff ff 31 d2 b9 00 10
> EAX: f7dfe000 EBX: c1b7b578 ECX: 00000000 EDX: 00000000
> ESI: 00000000 EDI: c1a95e40 EBP: c1a95e10 ESP: c1a95e04
> DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
> CR0: 80050033 CR2: ffbff000 CR3: 09b7c000 CR4: 000006f0
> Call Trace:
>  ? show_regs+0x4e/0x5c
>  ? __warn+0x87/0xdc
>  ? iounmap+0xda/0xe0
>  ? report_bug+0x94/0x108
>  ? exc_overflow+0x3c/0x3c
>  ? handle_bug+0x41/0x60
>  ? exc_invalid_op+0x17/0x40
>  ? handle_exception+0x101/0x101
>  ? exc_overflow+0x3c/0x3c
>  ? iounmap+0xda/0xe0
>  ? exc_overflow+0x3c/0x3c
>  ? iounmap+0xda/0xe0
>  readable+0x69/0xb8
>  ? do_mem_probe+0x190/0x190
>  do_validate_mem+0x8a/0x154
>  do_mem_probe+0xa8/0x190
>  ? do_mem_probe+0x190/0x190
>  pcmcia_nonstatic_validate_mem+0x45/0x80
>  ? do_mem_probe+0x190/0x190
>  ? readable+0xb8/0xb8
>  pcmcia_validate_mem+0x14/0x1c
>  pcmcia_card_add+0x3c/0xb0
>  pcmcia_bus_add+0x3a/0x44
>  socket_insert+0xc7/0xcc
>  pccardd+0x143/0x370
>  kthread+0xc4/0xd0
>  ? pcmcia_register_socket+0x28c/0x28c
>  ? kthread_blkcg+0x24/0x24
>  ? kthread_blkcg+0x24/0x24
>  ret_from_fork+0x31/0x3c
>  ret_from_fork_asm+0x12/0x18
>  entry_INT80_32+0xf0/0xf0
> ---[ end trace 0000000000000000 ]---
>  excluding 0xe4df4000-0xe5185fff 0xe5fce000-0xe635ffff 0xe6e16000-0xe71a7fff 0xe7ff0000-0xe8381fff
> pcmcia (null): pcmcia: registering new device pcmcia(null) (IRQ: 16)
> serial_cs 0.0: trying to set up [0x0279:0x950b] (pfc: 0, multi: 2, quirk: c980f7c0)
> 0.0: ttyS4 at I/O 0xa108 (irq = 16, base_baud = 115200) is a 16450
> [...]

I successfully bisected the issue back to:

 # git bisect bad
50c6dbdfd16e312382842198a7919341ad480e05 is the first bad commit
commit 50c6dbdfd16e312382842198a7919341ad480e05 (HEAD)
Author: Max Ramanouski <max8rr8@gmail.com>
Date:   Sun Aug 25 01:01:11 2024 +0300

    x86/ioremap: Improve iounmap() address range checks
    
    Allowing iounmap() on memory that was not ioremap()'d in the first
    place is obviously a bad idea.  There is currently a feeble attempt to
    avoid errant iounmap()s by checking to see if the address is below
    "high_memory".  But that's imprecise at best because there are plenty
    of high addresses that are also invalid to call iounmap() on.
    
    Thankfully, there is a more precise helper: is_ioremap_addr().  x86
    just does not use it in iounmap().
    
    Restrict iounmap() to addresses in the ioremap region, by using
    is_ioremap_addr(). This aligns x86 closer to the generic iounmap()
    implementation.
    
    Additionally, add a warning in case there is an attempt to iounmap()
    invalid memory.  This replaces an existing silent return and will
    help alert folks to any incorrect usage of iounmap().
    
    Due to VMALLOC_START on i386 not being present in asm/pgtable.h,
    include for asm/vmalloc.h had to be added to include/linux/ioremap.h.
    
    [ dhansen: tweak subject and changelog ]
    
    Signed-off-by: Max Ramanouski <max8rr8@gmail.com>
    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Alistair Popple <apopple@nvidia.com>
    Link: https://lore.kernel.org/all/20240824220111.84441-1-max8rr8%40gmail.com

 arch/x86/mm/ioremap.c   | 3 ++-
 include/linux/ioremap.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)


And indeed reverting 50c6dbdfd16e312382842198a7919341ad480e05 on top of v6.12-rc3 makes the warning disappear.

Regards,
Erhard

