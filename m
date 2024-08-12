Return-Path: <linux-kernel+bounces-282602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775DF94E64E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA281C21611
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A93114E2D4;
	Mon, 12 Aug 2024 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gl0JoiON"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8023139CFE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723442097; cv=none; b=WvrVM4qheRQ7DeBwvZAE93NVOkafWhM6tUZcmsD5h+zUrgwDKAsrO40aa8AQBZ2G2t0zSIcNFJHAANqvHwmSjzfzC7THLRF5Hhlm0nvQLJrv65npiChU861E51hgvQVgE9vAtmTlv6pW0QuB7EAiHBMDdnyUHYWRNC4Di5YrQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723442097; c=relaxed/simple;
	bh=OWFPyLk9qijbZylrTVEw9W4riew8091W+ugBuLpyJX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTrsJhTi7VcJgf4d74R6D0Xf107fh+V/a8LUmXQsbqz0L8p9DZ8H9jlNlb/0cWRKeFVGeKkCW0WHHcDIMqjOAV3URAVfEoplzY5IVlxNW3g8211VgujGwFttN8auh8H9pRHDXAefdi4nmfCAtm12R51gGEXD8TJsith6zKHSGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gl0JoiON; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aada2358fso751216566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723442094; x=1724046894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYo1INLOq156Qw62vGRe5A8jAlkKQVGuSnU9/QE+v7o=;
        b=gl0JoiON1v9v+nIw8JNCQy4vLykplCIULMoKTkzHMhv+fMjNfkfhPGfz7Q4IzoQVco
         9lSWmObcE8S60AbfaLgPuPx1OctfH0mSRveqw1rZyJzXnx8mPBeqqRIvWE10kFNk9YEU
         MG2CYT8C3JRCnn4RfRkHyuSNztBAcu3U6x2OHCZPIxfhAVnB84luzeGY3BuEs1dd7ATZ
         worLgQvaq/4AX3xDkA5GSI6ncxb/ZSWItQZaYqDvxWypU/blHr3ZwMMXkt1d0goEd38y
         DY7QrwAGKSXmh3ujrGdOLEtP1+3bTfgsiS4cXqYT6JOOHTpPf+97N7vsGcDuyKvZ2Ghv
         iivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723442094; x=1724046894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYo1INLOq156Qw62vGRe5A8jAlkKQVGuSnU9/QE+v7o=;
        b=luvdWwvShASGiDr/gLnV2B+ZvCknP6wgDJ4jyRwIZ4WewKcf+g2vt1oU0m5cUEW9v9
         9p4+/WB1WdPMc8rtEEbVXFwmi+qoKr2LWsue3IKB62NSdL5QA62DYcWaHpMUmV9CGMWv
         uAfLTLOFdrZuZIayRIv4XV+kp4LIj5gUlrpGA4vLIDd7hQ2Wz7q53FTpkY01+gVnsi4J
         6IRhp8ls8VNnDUnIxA8EaVa7MV/VnjSGUZxguWo3EHVYDPLvWt8jMHYyW9JqNrO0Q9Y9
         Knctl29EgbLai4NbRwUpWheGTAeBo3zBTHGkOgjFGOgWYb2xORv47G4YuWHryWiLWyIG
         YZWw==
X-Forwarded-Encrypted: i=1; AJvYcCX53IEmumDf9zg/XMf0IkU42C/xuPNVw9ueXkvgP8OHV7tPbPVPKiD/9LXW9OuG2Cv6hVYSstUiuRbajfiAFNil67zZlxkLCwOWIqW9
X-Gm-Message-State: AOJu0YxkULTQ+FP4amwZ3aZZOF7DrgdACiCsNvB8qpFqDfI5gnqXiHFa
	i3MjJStE8UK5oaOUXA03qWtPz0yrnSPDodPNx370DDr9wJ1FYEB5B64aBdT50Bo=
X-Google-Smtp-Source: AGHT+IEWJlWulwINR2mvPDA0F+GzST96BiyVI1VBUqXaw2VqDuwlnso7Bu+sdLf7W/E58YfrQZmfvQ==
X-Received: by 2002:a17:906:478a:b0:a73:9037:fdf5 with SMTP id a640c23a62f3a-a80ab75a8d2mr689304566b.6.1723442094028;
        Sun, 11 Aug 2024 22:54:54 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb243d78sm198422366b.224.2024.08.11.22.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:54:53 -0700 (PDT)
Date: Mon, 12 Aug 2024 07:54:52 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Ramon Fried <ramon@neureality.ai>, Elad Nachman
 <enachman@marvell.com>, Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v6 RESED 2/2] arm64: support DMA zone above 4GB
Message-ID: <20240812075452.4ef3eef5@mordecai.tesarici.cz>
In-Reply-To: <70d2c447b6dbf472b8e7fec5804deddc12692aab.1723359916.git.baruch@tkos.co.il>
References: <cover.1723359916.git.baruch@tkos.co.il>
	<70d2c447b6dbf472b8e7fec5804deddc12692aab.1723359916.git.baruch@tkos.co.il>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 10:09:36 +0300
Baruch Siach <baruch@tkos.co.il> wrote:

> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the
> max_zone_phys() calculation") made arm64 DMA/DMA32 zones span the entire
> RAM when RAM starts above 32-bits. This breaks hardware with DMA area
> that start above 32-bits. But the commit log says that "we haven't
> noticed any such hardware". It turns out that such hardware does exist.
> 
> One such platform has RAM starting at 32GB with an internal bus that has
> the following DMA limits:
> 
>   #address-cells = <2>;
>   #size-cells = <2>;
>   dma-ranges = <0x00 0xc0000000 0x08 0x00000000 0x00 0x40000000>;
> 
> That is, devices under this bus see 1GB of DMA range between 3GB-4GB in
> their address space. This range is mapped to CPU memory at 32GB-33GB.
> With current code DMA allocations for devices under this bus are not
> limited to DMA area, leading to run-time allocation failure.
> 
> This commit reinstates DMA zone at the bottom of RAM. The result is DMA
> zone that properly reflects the hardware constraints as follows:
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> [baruch: split off the original patch]
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Note that I'm not an Arm64 maintainer, so the value of my review is
limited, but AFAICS this change should work as intended.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  arch/arm64/mm/init.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index c45e2152ca9e..bfb10969cbf0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -114,20 +114,8 @@ static void __init arch_reserve_crashkernel(void)
>  				    low_size, high);
>  }
>  
> -/*
> - * Return the maximum physical address for a zone given its limit.
> - * If DRAM starts above 32-bit, expand the zone to the maximum
> - * available memory, otherwise cap it at 32-bit.
> - */
>  static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>  {
> -	phys_addr_t phys_start = memblock_start_of_DRAM();
> -
> -	if (phys_start > U32_MAX)
> -		zone_limit = PHYS_ADDR_MAX;
> -	else if (phys_start > zone_limit)
> -		zone_limit = U32_MAX;
> -
>  	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>  }
>  


