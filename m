Return-Path: <linux-kernel+bounces-306260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45BD963C08
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB651C2376A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32916B754;
	Thu, 29 Aug 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D2246czU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05812F399
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914614; cv=none; b=ToJJ66Drese/sL9Q/KuGIz8hOsDtnjhioV5XtvLYPuQ9RJL/uCgvyDah5Z4aXkwv7SkLUSBewb2ZuwbIxTkdQHJmEsVb2CTl7xw0yXgQYkDqNtRj9BQSiZ8OJ8Uiul8GWQW8qwdZrtR9arLgsmPTxdabBVWjxen/gDoHkIllUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914614; c=relaxed/simple;
	bh=En+aku83y5SuC94GfVDdlZsm9Cjo7uaGjUNgLOYqw9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGml2QJOqYtDozBs06OUM13I8ojYNzL+Gifzb2IgoG9yGwZLcOiv5BgRYFppnPWhqJn9wTB6x5hoC1afqA5jwi2mWZPj2gBFQzeGeVlxamMsvT9y05q7ikFpOmXqtxquSgBAPtN6WYd2LqVUhPmijXZV8BALdqhZjD7huY7CiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D2246czU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9765540E01C5;
	Thu, 29 Aug 2024 06:56:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g6A0xYLpyh2V; Thu, 29 Aug 2024 06:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724914605; bh=1ZXApR1+GZ1FH426Qf5vWIUp5KFywe0qhwO5Now6BX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2246czUypOpmivyIDZ59Jqub8rq+tD6rIyMhO/A9zuBFeGpcK2DhXWUmblvhkrxb
	 0XJj1tfAYysIMd3bMUG2/+uyb7DTHkBOLkcWVpukhgPLZmi9XfgykPlxVeoHPR9nXC
	 Z9o8Glg/cb1dH78xuRsr3BeF4JbJWoOhc1WWLW33B1fQ07MdsJvgyMAyBo8Z8+UMPm
	 l/sDDCuSXg5NZk0mZdNsa7RztIUFJ0bmEGL9dAXCIbMO2T++J6sbQyN1+Q+zAClR2e
	 nb/PSRPkjujlfvikkJe9YKZOBHvbMxND71x/EtCHmuVSnAn/wzt4mgAHnV4g0jrct3
	 vMcUkD6392zvnsNGnXWlo274PX0Zk/HmkXgwiFLFG3JNFjpQd6vRMVWeXsbDPzk+ei
	 1uWhPhfeAmY+hS/YGiOrYLZdGz53pMDmuIL6ybs1aHrsSoK06Oa5mnxllw3+7grQgF
	 BTl2IUYKrnelGVgbkwLlmPesrnW0DZA068L71wugmK7b3UH6fzSM3L7MP6j3T37Cru
	 tXA4w6viXKq7jQSoZcT3U0WCnIJyRKXhGX5HhHsypwA/dUqsGhZnoTH7oBzZwfJxn6
	 zAAfwyNB1F2P6MQ/Xoiefax+it9UdUHXOyS896WNX1L7APTE54Gx0mV7Da3YyCX374
	 BPUuEzSnD4lKlE35I1rHwCsY=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 061D340E0169;
	Thu, 29 Aug 2024 06:56:36 +0000 (UTC)
Date: Thu, 29 Aug 2024 08:56:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v2 0/7] Provide support for RMPREAD and a segmented RMP
Message-ID: <20240829065636.GBZtAbpOVh0lHr7VxG@fat_crate.local>
References: <cover.1722368407.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722368407.git.thomas.lendacky@amd.com>

On Tue, Jul 30, 2024 at 02:40:00PM -0500, Tom Lendacky wrote:
> This series adds SEV-SNP support for a new instruction to read an RMP
> entry and for a segmented RMP table.
> 
> The RMPREAD instruction is used to return information related to an RMP
> entry in an architecturally defined format.
> 
> RMPREAD support is detected via CPUID 0x8000001f_EAX[21].
> 
> Segmented RMP support is a new way of representing the layout of an RMP
> table. Initial RMP table support required the RMP table to be contiguous
> in memory. RMP accesses from a NUMA node on which the RMP doesn't reside
> can take longer than accesses from a NUMA node on which the RMP resides.
> Segmented RMP support allows the RMP entries to be located on the same
> node as the memory the RMP is covering, potentially reducing latency
> associated with accessing an RMP entry associated with the memory. Each
> RMP segment covers a specific range of system physical addresses.
> 
> Segmented RMP support is detected and established via CPUID and MSRs.
> 
> CPUID:
>   - 0x8000001f_EAX[23]
>     - Indicates support for segmented RMP
> 
>   - 0x80000025_EAX
>     - [5:0]   : Minimum supported RMP segment size
>     - [11:6]  : Maximum supported RMP segment size
> 
>   - 0x80000025_EBX
>     - [9:0]   : Number of cacheable RMP segment definitions
>     - [10]    : Indicates if the number of cacheable RMP segments is
>                 a hard limit
> 
> MSR:
>   - 0xc0010132 (RMP_BASE)
>     - Is identical to current RMP support
> 
>   - 0xc0010133 (RMP_END)
>     - Should be in reset state if segment RMP support is active
> 
>       For kernels that do not support segmented RMP, being in reset
>       state allows the kernel to disable SNP support if the non-segmented
>       RMP has not been allocated.
> 
>   - 0xc0010136 (RMP_CFG)
>     - [0]    : Indicates if segmented RMP is enabled
>     - [13:8] : Contains the size of memory covered by an RMP segment
>                (expressed as a power of 2)
> 
> The RMP segment size defined in the RMP_CFG MSR applies to all segments
> of the RMP. Therefore each RMP segment covers a specific range of system
> physical addresses. For example, if the RMP_CFG MSR value is 0x2401, then
> the RMP segment coverage value is 0x24 => 36, meaning the size of memory
> covered by an RMP segment is 64GB (1 << 36). So the first RMP segment
> covers physical addresses from 0 to 0xF_FFFF_FFFF, the second RMP segment
> covers physical addresses from 0x10_0000_0000 to 0x1F_FFFF_FFFF, etc.
> 
> When a segmented RMP is enabled, RMP_BASE points to the RMP bookkeeping
> area as it does today (16K in size). However, instead of RMP entries
> beginning immediately after the bookkeeping area, there is a 4K RMP
> segment table. Each entry in the table is 8-bytes in size:
> 
>   - [19:0]  : Mapped size (in GB)
>               The mapped size can be less than the defined segment size.
>               A value of zero, indicates that no RMP exists for the range
>               of system physical addresses associated with this segment.
>     [51:20] : Segment physical address
>               This address is left shift 20-bits (or just masked when
>               read) to form the physical address of the segment (1MB
>               alignment).

I could very well use that nicely gathered together info on segmented RMP if
it were, say, in a section in

Documentation/arch/x86/amd-memory-encryption.rst

for example.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

