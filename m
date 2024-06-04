Return-Path: <linux-kernel+bounces-201362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9E8FBD86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB971C22C75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB2C14B977;
	Tue,  4 Jun 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGnOnSbd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2E14658E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534334; cv=none; b=HCS+vPkSOc/LyyIgjQ2nVv9rH5NLNcZ0b0DASLDAlRJ9OOfSOa75rRt2DHUF5XPuXGNZetOTMaS/O9bgbtsVmLb91UY2rrTa+NcIPVEoZyS0gtKIcV9JwlBcZYP4o5n1By/1ToMp9rDuoR4AdwtpP3uWp7A3Z/Xrog9Kyx9XxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534334; c=relaxed/simple;
	bh=y+8CKHrB4O4j80cxj7GlaoyAv7eWMbh8YsZykcrvLj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEaQKrILToWAZ4v8z9Q12f3MsAw8ag7KMyY97l4GkeEWJg3u3j7QQmICCuOG6pzcU8jX70irXBwbX9IYqS9oM/M7Yhp7Hv6Iq2TyhlCngrPHRsifQjWhlmZ45rfhnOJ/NkjQAbLKTl+JaHSgRLARJDSZax76bb+aHm9i5n3UQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGnOnSbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A9DC2BBFC;
	Tue,  4 Jun 2024 20:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717534334;
	bh=y+8CKHrB4O4j80cxj7GlaoyAv7eWMbh8YsZykcrvLj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BGnOnSbd85K0EPEFf3nTeVbhYOtDqa45A97NwY2zZBnWV4ojBrqYs0IcfHwTfsIOJ
	 joJnGI1VJ/EwD0prkDWc/P43JZKVMOCCMVLTUuAdlqMVgxZbboaYnOcnFNoiZoW3J0
	 2xmB1ByBVgutfJsC8iD37OAus1bzrPOMab0j1ap61vCefTDHP7nfNGJa+WDPtO0Bgg
	 AGYlYht2Ca5HdLUXLA8YXiNCGXU/9QjkE3K9dAwERt9nF4HyW+X7VPeV0kEsqsjnDW
	 Bc2Ie90vXwIDb+F5KdGiR0IJezHMoHknk827GbopURf5wTW9VT0DvygiDOzzCdx1+S
	 thIUZ5OAxOruw==
Message-ID: <5c69cee6-f101-4c86-b38a-7c5c8679ea9b@kernel.org>
Date: Tue, 4 Jun 2024 22:52:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
To: Yosry Ahmed <yosryahmed@google.com>, Erhard Furtner <erhard_f@mailbox.org>
Cc: Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
Content-Language: en-US
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/24 1:24 AM, Yosry Ahmed wrote:
> On Mon, Jun 3, 2024 at 3:13 PM Erhard Furtner <erhard_f@mailbox.org> wrote:
>>
>> On Sun, 2 Jun 2024 20:03:32 +0200
>> Erhard Furtner <erhard_f@mailbox.org> wrote:
>>
>> > On Sat, 1 Jun 2024 00:01:48 -0600
>> > Yu Zhao <yuzhao@google.com> wrote:
>> >
>> > > The OOM kills on both kernel versions seem to be reasonable to me.
>> > >
>> > > Your system has 2GB memory and it uses zswap with zsmalloc (which is
>> > > good since it can allocate from the highmem zone) and zstd/lzo (which
>> > > doesn't matter much). Somehow -- I couldn't figure out why -- it
>> > > splits the 2GB into a 0.25GB DMA zone and a 1.75GB highmem zone:
>> > >
>> > > [    0.000000] Zone ranges:
>> > > [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
>> > > [    0.000000]   Normal   empty
>> > > [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
>> > >
>> > > The kernel can't allocate from the highmem zone -- only userspace and
>> > > zsmalloc can. OOM kills were due to the low memory conditions in the
>> > > DMA zone where the kernel itself failed to allocate from.
>> > >
>> > > Do you know a kernel version that doesn't have OOM kills while running
>> > > the same workload? If so, could you send that .config to me? If not,
>> > > could you try disabling CONFIG_HIGHMEM? (It might not help but I'm out
>> > > of ideas at the moment.)
>>
>> Ok, the bisect I did actually revealed something meaningful:
>>
>>  # git bisect good
>> b8cf32dc6e8c75b712cbf638e0fd210101c22f17 is the first bad commit
>> commit b8cf32dc6e8c75b712cbf638e0fd210101c22f17
>> Author: Yosry Ahmed <yosryahmed@google.com>
>> Date:   Tue Jun 20 19:46:44 2023 +0000
>>
>>     mm: zswap: multiple zpools support
> 
> Thanks for bisecting. Taking a look at the thread, it seems like you
> have a very limited area of memory to allocate kernel memory from. One
> possible reason why that commit can cause an issue is because we will
> have multiple instances of the zsmalloc slab caches 'zspage' and
> 'zs_handle', which may contribute to fragmentation in slab memory.
> 
> Do you have /proc/slabinfo from a good and a bad run by any chance?
> 
> Also, could you check if the attached patch helps? It makes sure that
> even when we use multiple zsmalloc zpools, we will use a single slab
> cache of each type.

As for reducing slab fragmentation/footprint, I would also recommend these
changes to .config:

CONFIG_SLAB_MERGE_DEFAULT=y - this will unify the separate zpool caches as
well (but the patch still makes sense), but also many others
CONFIG_RANDOM_KMALLOC_CACHES=n - no 16 separate copies of kmalloc caches

although the slabinfo output doesn't seem to show
CONFIG_RANDOM_KMALLOC_CACHES in action, weirdly. It was enabled in the
config attached to the first mail.

Both these changes mean giving up some mitigation against potentai
lvulnerabilities. But it's not perfect anyway and the memory seems really
tight here.

