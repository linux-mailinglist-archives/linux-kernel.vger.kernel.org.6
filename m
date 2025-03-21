Return-Path: <linux-kernel+bounces-571657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D682A6C040
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEEB27AC29C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888F22C35D;
	Fri, 21 Mar 2025 16:40:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A521EFFAD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575238; cv=none; b=d1Uj0rpnlec+xLjZYPSIbxelWkQ7EUvlP+MU+BSRnhsEF7g07H+deMuRbrt/oKbn2G0w3/NXESKHhdV2LH1T+k7bxD29wzjeZIDDhS7UMVW9riGVrX9oc+9xiw4WAttSSc49QtD9lespS0ZZNv3xGG7lkugYVWxYOz9TvgYkkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575238; c=relaxed/simple;
	bh=iFvB5gLyYPKrOiUejPgDczx2sEFUoPE3SBevXuCUEtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/DNeZIpX1xIrcq1+WL/enk7f0mNiqdPGJqc4I8TZUkle0oTFcXxleU1GwfWvFMxQqEfilETSJ9bOIzvNUeC4h3P1QUV5VqMlcO8uPSFoii9nnYRlsdca7iqxAswdBrrwItL9giQCyg0gaDU90yK1Sqp5F8zkl/8jmVVdw+EVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D976C4CEE3;
	Fri, 21 Mar 2025 16:40:35 +0000 (UTC)
Date: Fri, 21 Mar 2025 16:40:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: anshuman.khandual@arm.com, david@redhat.com, will@kernel.org,
	ryan.roberts@arm.com, mark.rutland@arm.com, ardb@kernel.org,
	yangyicong@hisilicon.com, joey.gouly@arm.com,
	quic_cgoldswo@quicinc.com, quic_sudaraja@quicinc.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com
Subject: Re: [PATCH] arm64: mm: Correct the update of max_pfn
Message-ID: <Z92Wf8SDt8lzFs7F@arm.com>
References: <20250321070019.1271859-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321070019.1271859-1-quic_zhenhuah@quicinc.com>

On Fri, Mar 21, 2025 at 03:00:19PM +0800, Zhenhua Huang wrote:
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

I think this makes sense and also matches what x86 does. I'll queue it
at -rc1 as a fix.

Thanks.

-- 
Catalin

