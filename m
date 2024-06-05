Return-Path: <linux-kernel+bounces-203085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070A8FD639
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E894284BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12B13B598;
	Wed,  5 Jun 2024 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F90hb6rs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79313AD38
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614456; cv=none; b=kWuu3wLAeej8IpPHDjBmFYan1h0BSCXhwT+hP/8av3ZuERKK1RPZi4/4stac1o0g1C6oDZdVT3+VQuSIyaDZlKxuqQDZiJKXJLkPYaCYa+1Jn86CPjkVcTGZcS906Vfk349ngABruiYo36umyy5w3WxLUWMlW8Z4XkuiklI3/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614456; c=relaxed/simple;
	bh=gCo6Eol2ctS05tCdqJWNTMs2vsC5Ydi8gXHw/eab5mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2psTn2pg2AQDnxijoiKH4bvRd0HDtIzq5//NxtNuJ4XuWL3pJzIEoEr1m0Yp+pwuVbtja7cZwl+QstL8wVfj8iAuN5Q9hxhzQ5/r23VmjNIusUQsG6vvw2ipjqJ56PdmNGNxd83BOZXXJBfJUWAiKpE4E9iuD3BWar7sZe56V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F90hb6rs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1AEC2BD11;
	Wed,  5 Jun 2024 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717614456;
	bh=gCo6Eol2ctS05tCdqJWNTMs2vsC5Ydi8gXHw/eab5mA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=F90hb6rsLvHfMl50YI96RcTTLZ80o5uiqOYZadcf4fxJZBJqmKTAPRMHIDn9s8I77
	 P0eg+ovQGCChXpNa7Jqp+Q5P+pIXv2rpOshQIJf8EaM/8Yqth2DUaAk6Zd0RkLLd9J
	 oD2Dg1liJvxHodYYCGmhra//Tu8KxhTAsvgIcAekLlB7F+/1qlgFLB6YYVetqA2/Ql
	 jYVmrZwRAlO//NLmClf5+SyUl6F/sD+7tUORrNzkaYZz06eW9nXn6jGO3eYAzmR8Q7
	 ppHE4FMy/rbB2kyRwZ0CWB4F9xWg7ev70NsHcVCSwa/g6daUzGH56FA5GXWUzx76VO
	 0x0twe2Asyq1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5BC2CE0A73; Wed,  5 Jun 2024 12:07:35 -0700 (PDT)
Date: Wed, 5 Jun 2024 12:07:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	lkft-triage@lists.linaro.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, jbeulich@suse.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: x86: WARNING: at mm/memblock.c:1339 memblock_set_node - Usage of
 MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
Message-ID: <315d6873-d618-4126-b67a-de62502d7ee2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYsGFerOtoxwpKLOYcRtyJkmgjdP=qg4Y5iP5q-4Lt17Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsGFerOtoxwpKLOYcRtyJkmgjdP=qg4Y5iP5q-4Lt17Lg@mail.gmail.com>

On Mon, Jun 03, 2024 at 07:19:21PM +0530, Naresh Kamboju wrote:
> The following kernel warnings are noticed on x86 devices while booting
> the Linux next-20240603 tag and looks like it is expected to warn users to
> use NUMA_NO_NODE instead.
> 
> Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
> 
> The following config is enabled
> CONFIG_NUMA=y

I am seeing this as well.  Is the following commit premature?

e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")

Maybe old ACPI tables and device trees need to catch up?

Left to myself, I would simply remove the WARN_ON_ONCE() from the above
commit, but I would guess that there is a better way.

							Thanx, Paul

> Boot log:
> --------
> [    0.008547] ------------[ cut here ]------------
> [    0.008547] Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
> [    0.008553] WARNING: CPU: 0 PID: 0 at mm/memblock.c:1339
> memblock_set_node+0xed/0x100
> [    0.008559] Modules linked in:
> [    0.008561] CPU: 0 PID: 0 Comm: swapper Not tainted
> 6.10.0-rc1-next-20240603 #1
> [    0.008563] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.7 12/07/2021
> [    0.008564] RIP: 0010:memblock_set_node+0xed/0x100
> [    0.008567] Code: ea ea ff 00 74 0b 41 bc ff ff ff ff e9 6c ff ff
> ff 48 89 75 d0 c6 05 5e ea ea ff 01 90 48 c7 c7 c8 e1 c7 a0 e8 d4 36
> df fd 90 <0f> 0b 90 90 48 8b 75 d0 eb d2 e8 74 bb f3 fe 0f 1f 40 00 90
> 90 90
> [    0.008568] RSP: 0000:ffffffffa1003de0 EFLAGS: 00010086 ORIG_RAX:
> 0000000000000000
> [    0.008570] RAX: 0000000000000000 RBX: ffffffffa149b510 RCX: 0000000000000000
> [    0.008572] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 00000000ffffdfff
> [    0.008572] RBP: ffffffffa1003e10 R08: 00000000ffffdfff R09: ffffffffa1003b90
> [    0.008573] R10: 0000000000000001 R11: ffffffffa1079440 R12: 0000000000000040
> [    0.008574] R13: 0000000000000000 R14: 000000008ad25c18 R15: 0000000000014770
> [    0.008575] FS:  0000000000000000(0000) GS:ffffffffa135e000(0000)
> knlGS:0000000000000000
> [    0.008577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.008578] CR2: ffff9ac23fe01000 CR3: 00000003ff246000 CR4: 00000000000200f0
> [    0.008579] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    0.008579] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    0.008580] Call Trace:
> [    0.008581]  <TASK>
> [    0.008582]  ? show_regs+0x68/0x80
> [    0.008586]  ? __warn+0x91/0x140
> [    0.008589]  ? memblock_set_node+0xed/0x100
> [    0.008591]  ? report_bug+0x175/0x1a0
> [    0.008594]  ? fixup_exception+0x2b/0x2f0
> [    0.008597]  ? early_fixup_exception+0xb3/0xd0
> [    0.008600]  ? do_early_exception+0x1f/0x60
> [    0.008603]  ? early_idt_handler_common+0x2f/0x40
> [    0.008606]  ? memblock_set_node+0xed/0x100
> [    0.008609]  ? __pfx_x86_acpi_numa_init+0x10/0x10
> [    0.008612]  numa_init+0x8b/0x610
> [    0.008615]  ? topo_register_apic+0x3a/0x130
> [    0.008617]  x86_numa_init+0x23/0x70
> [    0.008620]  initmem_init+0x12/0x20
> [    0.008622]  setup_arch+0x8a3/0xd60
> [    0.008624]  ? _printk+0x64/0x80
> [    0.008628]  start_kernel+0x76/0x810
> [    0.008630]  x86_64_start_reservations+0x1c/0x30
> [    0.008632]  x86_64_start_kernel+0xca/0xe0
> [    0.008634]  common_startup_64+0x12c/0x138
> [    0.008637]  </TASK>
> [    0.008638] ---[ end trace 0000000000000000 ]---
> 
> metadata:
>  git_ref: master
>  git_describe: next-20240603
>  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240603/testrun/24170391/suite/log-parser-boot/tests/
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2hM1TaqYoxFAhzHCIRxz84OeUaj
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2hM1QI6QEe9bjg1sQrFs41ZSYmk
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2hM1QI6QEe9bjg1sQrFs41ZSYmk/config
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

