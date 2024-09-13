Return-Path: <linux-kernel+bounces-327463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96684977650
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5B7281953
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E2441D;
	Fri, 13 Sep 2024 01:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="00K90ats"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D34A07
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726190189; cv=none; b=j5Lr+CtHSlZ7E1kR3MWexKnVdSwpdFbAtN1tqB40vyk8p+WsFFLsvtBTQhXBy1PuErj+Ou7+39dT+9SkDxXtilEmK22drfNSZstNTkHEIYf7hwR57vZP2isuVpG1LWiGADGfomWn07tBgRowrl6nmybBr1w9qwvrRT585GNbSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726190189; c=relaxed/simple;
	bh=r/yO+OeFcLvOjY6JHwXkqX6j3rz4+wcN2tkneSV7wN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI/VzkbGO0qFkvgUtSh/65u5aXJVph3xfaCHHLs5Czdxem3Vk+85odVGAXBxOOj3EKSG1BDH4jWVMwOAWeuSadgFiQ0zkOklUtbkplTns9WnqtnkPKjPFfnCdWCybri74PU8ZRIfvQvVNZeq9ADXD9gbBclRgD6dmii6rEKA9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=00K90ats; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206e614953aso17561375ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726190186; x=1726794986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGdN0gxzpmFovSXXc4PPR7wb1goaAH/sxNtRx0azomw=;
        b=00K90atsMMhkIeOfviDeZgLYYMC+Kbv2wOkwkhJ/F4QWA5SXHcrTqnl1Cn1MxNUefB
         1003I+kUTcBfPO024bgJV4j7L4L5oVT1HvzopP5Q5vfXoewSywIxcOROSBKrc2rcxcYO
         6/5dVIu8pRBV6cIfFU6vXmQxRyAFy3OHS7xixXfc92NNS7sKRqPx1IFavjKQv9sZKyQU
         Xvvw4bEsIHA47MfuqXKerx/tfNc5iGKPNVUrsA0U0vJvLpPDHpolRlwuzP3yPtx282L0
         O1dbY12H2QGipm+1NUM288QgWj7wHA4gF/nGP+g6fIFTpXy+Lz97XiPQSpaa1MOqG0Ad
         8nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726190186; x=1726794986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGdN0gxzpmFovSXXc4PPR7wb1goaAH/sxNtRx0azomw=;
        b=ohE//hSBEj/LoQf38J84+Vh9B1jS/qi9dRq3Ov6jyQr4AGfDDo/rWtrj6y47sWiQcB
         AhpwMeqt/c4WaJA98/JI5Hz0zp2ZtUkhgR2UUKQCUu8m9CJw2ONIuRCfUlVDSXTAFNYo
         iiaSyWM59YaiELbi8vXOFD+hSIhQrvJ4vzqRSdMikeWmLiBbveQFWS6XsAC0P7jUAKdR
         27E7EONYGET6Q1xuun5Kuti/llTwa2g4/AITTVaPq+CS20kbocUxUho/+61KG/7qeivF
         faeYnNYnsonjRlx94YU9HXQCC/OhaDc+Cus9Nb2Xx0817/EuM/0+RdTQIP1MjHJCqgfY
         7zeA==
X-Forwarded-Encrypted: i=1; AJvYcCUll1YuJkDEUL2vxdDmh+OmD3HVbhTwvcw339k8Xa7ODzEEGvL6ICnBmhxsl5KkvO2LNtiCOgoLRAP07zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+lVmQoJKK3siD6T/uIH693idyxy4ZYUj1tS0BPccv4ADzVSO
	10uKpqElZry4OvyMaxnzX+IRSGr0uVXoOklQpChB3Ofm46RDzpUWDJ3+X2LU1ng=
X-Google-Smtp-Source: AGHT+IEHKm3UNTMeYi9FcEOsLtiVsBpfeVoViEjIu4klChUXmqp/JF2zUsw5pdnzmHwyVdvF9TzQWQ==
X-Received: by 2002:a17:903:249:b0:206:8eec:c087 with SMTP id d9443c01a7336-2076e354d05mr65687755ad.16.1726190185980;
        Thu, 12 Sep 2024 18:16:25 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c98f1fsm382550a91.20.2024.09.12.18.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 18:16:24 -0700 (PDT)
Date: Thu, 12 Sep 2024 18:16:20 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 03/10] riscv: Add CSR definitions for pointer masking
Message-ID: <ZuOSZPJLBUeoTMA9@ghost>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
 <20240829010151.2813377-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829010151.2813377-4-samuel.holland@sifive.com>

On Wed, Aug 28, 2024 at 06:01:25PM -0700, Samuel Holland wrote:
> Pointer masking is controlled via a two-bit PMM field, which appears in
> various CSRs depending on which extensions are implemented. Smmpm adds
> the field to mseccfg; Smnpm adds the field to menvcfg; Ssnpm adds the
> field to senvcfg. If the H extension is implemented, Ssnpm also defines
> henvcfg.PMM and hstatus.HUPMM.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
> 
> (no changes since v3)
> 
> Changes in v3:
>  - Use shifts instead of large numbers in ENVCFG_PMM* macro definitions
> 
> Changes in v2:
>  - Use the correct name for the hstatus.HUPMM field
> 
>  arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 25966995da04..fe5d4eb9adea 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -119,6 +119,10 @@
>  
>  /* HSTATUS flags */
>  #ifdef CONFIG_64BIT
> +#define HSTATUS_HUPMM		_AC(0x3000000000000, UL)
> +#define HSTATUS_HUPMM_PMLEN_0	_AC(0x0000000000000, UL)
> +#define HSTATUS_HUPMM_PMLEN_7	_AC(0x2000000000000, UL)
> +#define HSTATUS_HUPMM_PMLEN_16	_AC(0x3000000000000, UL)
>  #define HSTATUS_VSXL		_AC(0x300000000, UL)
>  #define HSTATUS_VSXL_SHIFT	32
>  #endif
> @@ -195,6 +199,10 @@
>  /* xENVCFG flags */
>  #define ENVCFG_STCE			(_AC(1, ULL) << 63)
>  #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
> +#define ENVCFG_PMM			(_AC(0x3, ULL) << 32)
> +#define ENVCFG_PMM_PMLEN_0		(_AC(0x0, ULL) << 32)
> +#define ENVCFG_PMM_PMLEN_7		(_AC(0x2, ULL) << 32)
> +#define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
>  #define ENVCFG_CBZE			(_AC(1, UL) << 7)
>  #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
>  #define ENVCFG_CBIE_SHIFT		4
> @@ -216,6 +224,12 @@
>  #define SMSTATEEN0_SSTATEEN0_SHIFT	63
>  #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
>  
> +/* mseccfg bits */
> +#define MSECCFG_PMM			ENVCFG_PMM
> +#define MSECCFG_PMM_PMLEN_0		ENVCFG_PMM_PMLEN_0
> +#define MSECCFG_PMM_PMLEN_7		ENVCFG_PMM_PMLEN_7
> +#define MSECCFG_PMM_PMLEN_16		ENVCFG_PMM_PMLEN_16
> +
>  /* symbolic CSR names: */
>  #define CSR_CYCLE		0xc00
>  #define CSR_TIME		0xc01
> @@ -382,6 +396,8 @@
>  #define CSR_MIP			0x344
>  #define CSR_PMPCFG0		0x3a0
>  #define CSR_PMPADDR0		0x3b0
> +#define CSR_MSECCFG		0x747
> +#define CSR_MSECCFGH		0x757
>  #define CSR_MVENDORID		0xf11
>  #define CSR_MARCHID		0xf12
>  #define CSR_MIMPID		0xf13
> -- 
> 2.45.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

