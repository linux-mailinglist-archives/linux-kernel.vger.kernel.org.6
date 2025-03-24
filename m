Return-Path: <linux-kernel+bounces-573142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8FAA6D386
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE46B166EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9775813957E;
	Mon, 24 Mar 2025 04:19:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC26291E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742789990; cv=none; b=A1asAmgaUUTl0HVGjyS0P/hmQWYWJmvyC1skn7W9IR+vVltjzAT2SIDBaeujCNeOaBIcz3UQb3drzZm7qvm74cdeqX4H3JFa2zCkYyu+jSL95NS/f82Gqi4foZh68An70+Uu0KqR7Dm7Kx7luP7hy24SNper+ylIoFup9wKg6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742789990; c=relaxed/simple;
	bh=Np3KjeOB/lXHZPg2YWaeBM6tSWtXlukkY92ZoAbgx+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLmReyqzc3It+pAlXG1pMV3pLS0nFV/AS/2hhIPDBONqKJX+4zIUs6TwAxCUlCalUnzDT6z7k1smX0GQfGkV+GqLC8qvOJ4fa5alZslsZXSNBpwexdw/VbHW7oCja/DrTPCTtoIurC/o6pA23vEcAKjOPjBHJ7+n95C7rxtNAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 061741A2D;
	Sun, 23 Mar 2025 21:19:53 -0700 (PDT)
Received: from [10.162.16.153] (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1B843F58B;
	Sun, 23 Mar 2025 21:19:41 -0700 (PDT)
Message-ID: <48f15771-ed1a-4e30-b825-70ee3c323d37@arm.com>
Date: Mon, 24 Mar 2025 09:49:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: Correct the update of max_pfn
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>, catalin.marinas@arm.com,
 david@redhat.com, will@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, ardb@kernel.org, yangyicong@hisilicon.com,
 joey.gouly@arm.com, quic_cgoldswo@quicinc.com, quic_sudaraja@quicinc.com,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
References: <20250321070019.1271859-1-quic_zhenhuah@quicinc.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250321070019.1271859-1-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 12:30, Zhenhua Huang wrote:
> Hotplugged memory can be smaller than the original memory. For example,
> on my target:
> 
> root@genericarmv8:~# cat /sys/kernel/debug/memblock/memory
>    0: 0x0000000064005000..0x0000000064023fff    0 NOMAP
>    1: 0x0000000064400000..0x00000000647fffff    0 NOMAP
>    2: 0x0000000068000000..0x000000006fffffff    0 DRV_MNG
>    3: 0x0000000088800000..0x0000000094ffefff    0 NONE
>    4: 0x0000000094fff000..0x0000000094ffffff    0 NOMAP
> max_pfn will affect read_page_owner. Therefore, it should first compare and
> then select the larger value for max_pfn.
> 
> Fixes: 8fac67ca236b ("arm64: mm: update max_pfn after memory hotplug")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  arch/arm64/mm/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 1dfe1a8efdbe..310ff75891ef 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1361,7 +1361,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  		__remove_pgd_mapping(swapper_pg_dir,
>  				     __phys_to_virt(start), size);
>  	else {
> -		max_pfn = PFN_UP(start + size);
> +		/* Address of hotplugged memory can be smaller */
> +		max_pfn = max(max_pfn, PFN_UP(start + size));
>  		max_low_pfn = max_pfn;
>  	}
>  

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

