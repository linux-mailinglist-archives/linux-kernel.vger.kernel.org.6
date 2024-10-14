Return-Path: <linux-kernel+bounces-363969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D0999C90E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1911C22FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93F19E7E3;
	Mon, 14 Oct 2024 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TKL8NUmV"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45914E1CA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905717; cv=none; b=VhVYUwLcswibPT4y/ZBmcdibOI55I09EHAT/SOIFhkiFRhUaEVspsU9mnH3+J3Ul3ZozNiTh2lyow8jl6N8wFLkYWXgTlsH2EvvSgHfA6jVIokVVeLiK97WGGxEFMdqGQAsihG8BYYSi1/fBUdtkbMVaPoYs4s24LCjz0/yMemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905717; c=relaxed/simple;
	bh=rYRSUvKHH9MRtgwzcSaVBscTMnX6k5sDrSA5jmrU9Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6k9v3K3CeQtC/SBweu6nUaYEFy1ObNC2z4+SLKBKnMLPRoD5g4AiQ0pYp4Rk2XfsPiCS1Jf1yXoF4/KNZM0ToOws2XBtv6gLhGnjUQ6QMHH8DtK2iyaC1cDUPLVDCqPEN74n2fq3LzRZ8reZBfgYu2vvEnP6snqj4qPfkEttvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TKL8NUmV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdda5cfb6so10564555ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1728905715; x=1729510515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snz/6shGNFzAdeteNvkrsQdTR7sYmyEMdXJIej7ZazI=;
        b=TKL8NUmVPdQCMJ4PaIBUg3LC+IBqjaCr8Jb3VuOQ2LXXNbe0jrCTB0DFd99h3d4CRQ
         R1c9sEorKzuletyRmDmC6oWBfMDKJohclcy//EYbG4k3MJrEhgBzih+QmKZO1Q75YspT
         x9ycv+r2jpodnWnscqQONN2Ldu8w3U6NibamNld0H5mSboUfAkPMFroiy502GUwK7/RE
         7oO7IXnLhN0WQ2qFQfqhaQLQ2F0/Iapk1nMeBDqHTyOW110wgfFhE+Mf8i7j91EMIXd7
         vL5CPfHWPePyuz/L6kTunX+R83YsLUmzwKtlF/2JFC8V0q7HR+4ccGDGJclKu+QoVIDs
         N3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728905715; x=1729510515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snz/6shGNFzAdeteNvkrsQdTR7sYmyEMdXJIej7ZazI=;
        b=KgB9laxKSdMvqd3Vo9b3pX1+ZX0gPqYOf/cG+OUzGB6K9+1GdPeCeafmXgYmwu0wQt
         5HQijnsaU7YZlSKyxIsrQRHRgsXLqJhBS3wIHC3/gRyDBKfapXSt+Rx6Lw8/YJAzBoNf
         AdPHZj4hu75wC+R6TRIOwVkcWixcQ++i8GaAzpjzPFBHyLGAqSY2RQobko+MaUEhT+1k
         NBB3RxPOqs/Ja4KSj2Y0ttfl9Pn2iJh3Sbk/M7Y671fvE8NP41Gu+gThGtxPN1YWynwF
         it9pifplEwYfKSWjNBefzsUwvC/HVh7z4xdlhY/Ta3QnRwYMr192JJDtijUvNWBAbBqR
         yOUA==
X-Forwarded-Encrypted: i=1; AJvYcCWpg30p4Q3OUMo+nbhm14L/Qnoll2T9W89hOAGEHBLVeeCN/eboF8y1K1snlpd10M7iyg2M4v6Ao/AGVfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDYz3QGo8wmxatOkghGWkYOKhBan8LIJBJkGoO0dDfenF80aq
	y48gfsWdHPugHBxfBG8yt34iCYbhcBzQeU9B2HNdI3YmuzewOjRlZQc5RAkjYmo=
X-Google-Smtp-Source: AGHT+IGKqFRVq7FAJ5tVZzOxYuKOJPgD+oJeoyWNOgNGtSMTpyAoZrNEO24fTtipgTDktQfY/8QGaQ==
X-Received: by 2002:a17:903:40ce:b0:20c:5c6b:2eac with SMTP id d9443c01a7336-20ca16d2da4mr154491475ad.49.1728905714839;
        Mon, 14 Oct 2024 04:35:14 -0700 (PDT)
Received: from sunil-laptop ([106.51.192.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad3385sm63925665ad.42.2024.10.14.04.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:35:14 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:05:07 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
	alexghiti@rivosinc.com, jeeheng.sia@starfivetech.com,
	haibo1.xu@intel.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: ACPI: fix early_ioremap to early_memremap
Message-ID: <Zw0B6_k7ejVtBTRC@sunil-laptop>
References: <20241014094705.71775-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014094705.71775-1-cuiyunhui@bytedance.com>

Hi Yunhui,
On Mon, Oct 14, 2024 at 05:47:05PM +0800, Yunhui Cui wrote:
> When SVPBMT is enabled, __acpi_map_table() will directly access the
> data in DDR through the IO attribute, rather than through hardware
> cache consistency, resulting in incorrect data in the obtained ACPI
> table.
> 
> The log: ACPI: [ACPI:0x18] Invalid zero length.
> 
> We do not assume whether the bootloader flushes or not. We should
> access in a cacheable way instead of maintaining cache consistency
> by software.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 6e0d333f57e5..3177c9af8764 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
>  	if (!size)
>  		return NULL;
>  
> -	return early_ioremap(phys, size);
> +	return early_memremap(phys, size);
>  }
> 
I think __acpi_unmap_table() also needs similar change. You might need
to typecast to suppress the sparse error [1] then.

[1] - https://lore.kernel.org/oe-kbuild-all/202305201427.I7QhPjNW-lkp@intel.com/#r

Thanks,
Sunil

