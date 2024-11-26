Return-Path: <linux-kernel+bounces-421906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828519D91D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F793286528
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A11684A4;
	Tue, 26 Nov 2024 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="vM8eFXd3"
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CBC653
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602948; cv=none; b=cjcMu3jfGpl0c8lODRpMEXL6ia72yhpPY5n5Pm5h6gBte59wEz3YkUXlD26jUPqFcnPYH/3R68JMTbjU8gG9diuMW2tFHpU/Ai1xOeGPqj7h/mK36ys9pvAwRG1bkXo4Qv6OZuL3WKNIUa2nCMnQAbKgG8NZLeQaxPjkiAAqjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602948; c=relaxed/simple;
	bh=udoK2qW83uXeBOCAIZ44JnfDHyuvD0+EsOfZ541mR6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CXT38kaoDr36OUNayCNGuP3HWIZU1FgGAmA2Q9GmBXIpEgruLEQO9uz9IMMd4t/Z59j3KXF6qQjxWPXVzOOgbCrAXjw4Y1KfO0KvP3m5bSuH9q1yHFNc8Do+VWYP2w0u3/c+sgEEjKWqv6LUMHnmyRH2RMUrUzty8H53vAUK86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=vM8eFXd3; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from localhost (unknown [10.0.8.2])
	by mail.tkos.co.il (Postfix) with ESMTP id EE487441037;
	Tue, 26 Nov 2024 08:23:33 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1732602214;
	bh=udoK2qW83uXeBOCAIZ44JnfDHyuvD0+EsOfZ541mR6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vM8eFXd3nNwLJ8ZpNyfsru415A8oDTaFWKjBfHADSHIC+BTsvqynp6XC+UaDS/dJy
	 ey/oagwRLiTq6cR2MpOXLS52XKovgga+T091fC60LrKZ3E1U3qRJxmraIAvFsTOCfo
	 //7yf4kC08/45gHQvQ2PjRHoznOZRbez0YJyZjcI/hjVVqh3FrGqF+r5f0PL1VV4gD
	 vVuezGRLbsqheA/zG/36tLjijOKXpDOqjka2wjPMf5vz3xOttWOtYNbuRv4Zqp+evU
	 Tde2QbddyL3b14tZzttIilm0a1RddJnazsQRMmtBFntdLjaUWGMn/Y0IwXALs3sIkj
	 2Wrod0Wmq6LYw==
From: Baruch Siach <baruch@tkos.co.il>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: catalin.marinas@arm.com,  will@kernel.org,  ptesarik@suse.com,
  hch@lst.de,  jiangyutang@os.amperecomputing.com,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: fix zone_dma_limit calculation
In-Reply-To: <20241125171650.77424-1-yang@os.amperecomputing.com> (Yang Shi's
	message of "Mon, 25 Nov 2024 09:16:50 -0800")
References: <20241125171650.77424-1-yang@os.amperecomputing.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 26 Nov 2024 08:27:19 +0200
Message-ID: <87ttbu8q7s.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Yang,

On Mon, Nov 25 2024, Yang Shi wrote:
> The commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
> zone_dma_limit") changed how zone_dma_limit was calculated.  Now it
> returns the memsize limit in IORT or device tree instead of U32_MAX if
> the memsize limit is greater than U32_MAX.

Can you give a concrete example of memory layout and dma-ranges that
demonstrates this issue?

> This resulted in DMA allocations may use GFP_DMA even though the devices
> don't require it.  It caused regression on our two sockets systems due
> to excessive remote memory access.

That is, DMA zone used to cover all memory before commit ba0fb44aed47,
but now DMA zone is limited to the smallest dma-ranges. Is that correct?

Thanks,
baruch

> Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
> Cc: <stable@vger.kernel.org>    [6.12+]
> Reported-by: Yutang Jiang <jiangyutang@os.amperecomputing.com>
> Tested-by: Yutang Jiang <jiangyutang@os.amperecomputing.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/mm/init.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index d21f67d67cf5..ccdef53872a0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -117,15 +117,6 @@ static void __init arch_reserve_crashkernel(void)
>  
>  static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>  {
> -	/**
> -	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
> -	 * bus constraints. Devices using DMA might have their own limitations.
> -	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
> -	 * DMA zone on platforms that have RAM there.
> -	 */
> -	if (memblock_start_of_DRAM() < U32_MAX)
> -		zone_limit = min(zone_limit, U32_MAX);
> -
>  	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>  }
>  
> @@ -141,6 +132,14 @@ static void __init zone_sizes_init(void)
>  	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
>  	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
>  	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
> +	/*
> +	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
> +	 * bus constraints. Devices using DMA might have their own limitations.
> +	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
> +	 * DMA zone on platforms that have RAM there.
> +	 */
> +	if (memblock_start_of_DRAM() < U32_MAX)
> +		zone_dma_limit = min(zone_dma_limit, U32_MAX);
>  	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

