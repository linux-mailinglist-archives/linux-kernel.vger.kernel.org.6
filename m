Return-Path: <linux-kernel+bounces-521156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D26FA3B572
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D70F163C67
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F981DF74E;
	Wed, 19 Feb 2025 08:41:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B01DE2B8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954500; cv=none; b=kyFO4Cm08ypN0RIvFLGMwDwU017xo6WrAzETrB3Ch5fS1NWV1F3ir0TCXWfwdqtT3Ou9XCK+9LKsg3FnfHZr0+N7xggIoLzow68apUbxFxsJQPu6cZbRDxbaIJI2XeE1KTkiMuUlQL5TxuCCdbgfM3DDkmlibXEdod/mbYHt7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954500; c=relaxed/simple;
	bh=SMg51oO931TLeNepJkpbxQflNB7xepGXXX7uE6Z2IBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzRrDryxkEpJliAYh3cAvN0GnsKvRW5q1C2iVy10F+toS81l1XuMzFx3HqJZHKK21gvCL3TMCcMIm5vkh8k4uuoaewAzXZ7XmbHkW1UdpwAaLhBRrS43VUM76uIFVGRbT3elr3rC16wHJrxByG177+qRaBqK5Z57dF1ih5iLCJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FCE41682;
	Wed, 19 Feb 2025 00:41:57 -0800 (PST)
Received: from [10.57.84.233] (unknown [10.57.84.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D45833F5A1;
	Wed, 19 Feb 2025 00:41:37 -0800 (PST)
Message-ID: <fe95f4c8-4b09-4d8e-99c9-987ddc2761e3@arm.com>
Date: Wed, 19 Feb 2025 08:41:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at arch/arm64/mm/mmu.c:185!
Content-Language: en-GB
To: Luiz Capitulino <luizcap@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: ardb@kernel.org
References: <a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/02/2025 02:27, Luiz Capitulino wrote:
> Hi,
> 
> I'm getting the crash below with Linus tree commit
> 2408a807bfc3f738850ef5ad5e3fd59d66168996 on a Ampere Mt. Jade with two sockets
> (backtrace below).

Thanks for the bug report, I'll take a look this morning, but I'm off work
tomorrow and Friday so if I can't figure it out before end of day I won't be
able to look again until Monday, unless someone can pick it up in the meantime.

Anyway, is there a specific config you're compiling for? And what about kernel
command line args?

Is it 100% reproducible for you? How much RAM does your system have? (I have 2
socket Mt. Jade with 512G; I'll try to repro on that).

> 
> It happens very early during boot. Passing 'nokaslr' in the command-line works
> around the issue (ie. I can boot and use the system normally). Doesn't seem to
> happen with 6.13. I tried bisecting it but got nowhere...
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at arch/arm64/mm/mmu.c:185!

This is:

/*
 * After the PTE entry has been populated once, we
 * only allow updates to the permission attributes.
 */
BUG_ON(!pgattr_change_is_safe(pte_val(old_pte), pte_val(__ptep_get(ptep))));

So we have a valid -> valid PTE transition where either the PFNs are changing,
we are trying to change permissions on a contiguous entry, we are trying to
transition from non-global to global, or we are trying to change other
explicitly disallowed bits.

> [    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc3+ #8
> [    0.000000] pstate: 400000c9 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.000000] pc : alloc_init_cont_pte+0x20c/0x3d0
> [    0.000000] lr : alloc_init_cont_pte+0x204/0x3d0
> [    0.000000] sp : ffffb45836ec78b0
> [    0.000000] x29: ffffb45836ec7940 x28: ffff6fea00000000 x27: 0068000000000f07
> [    0.000000] x26: ffff6fea00200000 x25: 0000400000000000 x24: ffffffffff433000
> [    0.000000] x23: dfff800000000000 x22: 0000d01600000000 x21: 0068000000000f07
> [    0.000000] x20: ffff6fea00000000 x19: ffff6fea00010000 x18: 00000000ae5a3fb1
> [    0.000000] x17: 0000000000001114 x16: 00000000bfc60000 x15: 0000000000000200
> [    0.000000] x14: 0000000000000000 x13: 1ffff68b06dd8f1c x12: 00000000f1f1f1f1
> [    0.000000] x11: ffff768b06dd8f1c x10: ffffb45835a1ca38 x9 : 0000000000000000
> [    0.000000] x8 : 0000000041b58ab3 x7 : 0000000000000000 x6 : 0000000000000000
> [    0.000000] x5 : 006840000a861f07 x4 : 000000000000a861 x3 : 000000000000a861
> [    0.000000] x2 : 006840000a861f03 x1 : 0068400000000f07 x0 : 0000000000000000
> [    0.000000] Call trace:
> [    0.000000]  alloc_init_cont_pte+0x20c/0x3d0 (P)
> [    0.000000]  alloc_init_cont_pmd+0x20c/0x4d0
> [    0.000000]  alloc_init_pud+0x244/0x400
> [    0.000000]  create_kpti_ng_temp_pgd+0xf8/0x1c8

This is an alias for __create_pgd_mapping_locked() so I suspect we are actually
in __map_memblock().

> [    0.000000]  map_mem.constprop.0+0x1d8/0x3b8
> [    0.000000]  paging_init+0x98/0x330
> [    0.000000]  setup_arch+0xac/0x170
> [    0.000000]  start_kernel+0x74/0x3c8
> [    0.000000]  __primary_switched+0x8c/0xa0
> [    0.000000] Code: f9400301 97ffff64 72001c1f 54fffe21 (d4210000)
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [    0.000000] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal
> exception ]---
> 

So I guess either we are setting a PTE entry into a table for the first time,
where somehow the table has not been initially cleared (very unlikely) or we are
trying to update the permissions of an already mapped pte. In that latter case,
I think we should only be remapping the kernel image portion of the linear map.

I can't see any obvious recent changes in this area. I'll see if I can repro and
poke around a bit more.

Thanks,
Ryan


