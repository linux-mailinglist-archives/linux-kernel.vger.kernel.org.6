Return-Path: <linux-kernel+bounces-576005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52409A709C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF93842028
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05381F3FD3;
	Tue, 25 Mar 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="l+8Fezu9"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A11F3B9D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928668; cv=none; b=pgnYYAggnpgPJK2bFipy3r2GnE5CMl6dRnY50RaPxEfwxnDcRKCk9E5TiAMGS9t8LAKWyTMOdq4eUXNW8SigN5dT4j84g3Lc2tTDcUTKMTafpuCV9j278/UHt55ivuI2uvsGTl6GFbsKY7ZzWGYzPN3tepA9zyxVD8RhY1jn1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928668; c=relaxed/simple;
	bh=9LXbgpoOCiVQGaVF3eaFZ78LjOK6T4XMFnOl9Fypu/8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pY++SOvlwBdy5BOJREWDti96taYwS2BaFXnzRiGJ9ZG/uAj61oYMht/6UBR4oa4UAEl3BnwMBreO4hB4i1DgBnz7PvwvmTykUKTpeUv/vbGBQgnkEBoR+Mx/Yl6BOdp0ieMNin/LRM8mgXRkY97uR3G+qZqMLWLJESkyXSblNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=l+8Fezu9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso975215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1742928665; x=1743533465; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKFyRYKxF1WM7/Qzxwsb5esyJjWasxcKEvmo6HpGkec=;
        b=l+8Fezu9lKnFO1vakZYrnDeGzq89y7YQIGvcEv0x2c69aIML9E2wNPGUWovNrbn+d+
         RyHeeNLdsSKjxGdbCG5ldajKJugYNe/EFvDNy7vy42Lhxqg2bQVTIqjna4jSD0oOwMAA
         Y5Z736XXuKaDn0ETHWLSLIlx+/AG50s1E9yGvFPxQr9q/ihD/tudsYzQgmReVIYJPkxw
         kNi9fmvfOzmtNwKEwHUmL5TzbeUvpZOARJKexnu8mOeu9QL0cjAKqEwy0hasENtrXl7G
         c/L69gkrAedzR6fFNasClcFxoDLad5U/Ihovpzq9nlJLd4OOXiNXefpF2Gdjp4inr70O
         jmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928665; x=1743533465;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKFyRYKxF1WM7/Qzxwsb5esyJjWasxcKEvmo6HpGkec=;
        b=jD365IewTLXOK0tXoPbrkPphGkTeWuHjADZp3f4xV2PG+19YMkiABteKxLzO3Xr1hU
         kmNdMASbAW/yGGCdJCecXac6jwjSztZGJJMAmtjI7HQEfZ/1IsA5xJtw2T6fPeHKComu
         +qE633WCcnhmRyIoNcciIhw/DQPs8cjpVs+rcDjQpP/O3EElVImcmJrJs3OF8t42OefN
         Inj9qnNlPP300IcOIQWcSUVtlIwZBmGx7glEfAYfCyHl48386cpwbMSG6LptvW9awf0w
         HtcVWoeyAHEY1R1eiFnoE5KlRhkkk2ML3iwIImFnu2NaylRxFcnGbueHpcPrchAvmOhj
         ky+w==
X-Forwarded-Encrypted: i=1; AJvYcCU4dtWdF8VQIgp9noKEufhL5hJ8hiv5VmcOgiSc3gnTNwQqlDhrl3lVZyThvMjrN+0IDR5vCoeJPGJbDMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbR/SaAgX+Owfsyfkqt5RvYNPeUCKOBoLqDXsgzIkcIl08oErc
	NEYll/4QfLjwUJEA2NeFhgMhiCsyrmufGEFb14etqK7u5yGNqPSoK9PU+L2Cxsk=
X-Gm-Gg: ASbGnctad5HTOKH+ldrKNIzUXCVICN5Hzq99Rpe1nu1Nmzll9xyksvqSyXMLs3Ttel1
	cJ7Zpu0UiVF/MwS9sAW5fcqIznm+ASnnuNyDbB+GcFenS3/ebKo9Uc12K8kfuJamXAEEw4UB42C
	x1ceYxqVqF74nd06N9PyO8Jov957uDw0aNHsXUujX3pV2ezY7LTvc0XXtCo4CRdOMyvyfUylIVT
	vhQFZ4An28cZMALXIiVuYk1MXDDlLVJK79E8roCxTSQqVqvqR7NNIPXgA4BewI/0RPyTx0Na6sX
	/EwNyAOcMRkq3M+WJxCQzC9knVoOHhG70kP88bu+DJR7EYlzJBr2sUjllw==
X-Google-Smtp-Source: AGHT+IE3tPDzR9UC+jvepT8+s1j1/v6Ba1MUiSkiWeQVK07RICCfaGQOUUCB6kQZK6oyqwZkxgnC/w==
X-Received: by 2002:a05:600c:5247:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-43d775fbf63mr8654245e9.9.1742928664501;
        Tue, 25 Mar 2025 11:51:04 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3c2csm14167481f8f.46.2025.03.25.11.51.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Mar 2025 11:51:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH] iommu: riscv: Split 8-byte accesses on 32 bit I/O bus
 platform
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20250325144252.27403-1-luxu.kernel@bytedance.com>
Date: Tue, 25 Mar 2025 18:50:53 +0000
Cc: tjeznach@rivosinc.com,
 joro@8bytes.org,
 will@kernel.org,
 robin.murphy@arm.com,
 alex@ghiti.fr,
 lihangjing@bytedance.com,
 xieyongji@bytedance.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F043708-3BB6-46CF-BEC3-2636E9A388B7@jrtc27.com>
References: <20250325144252.27403-1-luxu.kernel@bytedance.com>
To: Xu Lu <luxu.kernel@bytedance.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)

On 25 Mar 2025, at 14:42, Xu Lu <luxu.kernel@bytedance.com> wrote:
>=20
> Introduce a new configuration CONFIG_RISCV_IOMMU_32BIT to enable
> splitting 8-byte access into 4-byte transactions for hardware platform
> whose I/O bus limits access to 4-byte transfers.
>=20
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>

Is such a platform conformant to the specification? Either way, why is
this a static build-time configuration choice rather than a dynamic
run-time choice based on the FDT / ACPI tables / some other platform
probing method?

Jess

> ---
> drivers/iommu/riscv/Kconfig |  9 +++++++++
> drivers/iommu/riscv/iommu.h | 28 +++++++++++++++++++++++-----
> 2 files changed, 32 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> index c071816f59a6..b7c9ea22d969 100644
> --- a/drivers/iommu/riscv/Kconfig
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -18,3 +18,12 @@ config RISCV_IOMMU_PCI
> def_bool y if RISCV_IOMMU && PCI_MSI
> help
>  Support for the PCIe implementation of RISC-V IOMMU architecture.
> +
> +config RISCV_IOMMU_32BIT
> + bool "Support 4-Byte Accesses on RISC-V IOMMU Registers"
> + depends on RISCV_IOMMU
> + default n
> + help
> +  Support hardware platform whose I/O bus limits access to 4-byte
> +  transfers. When enabled, all accesses to IOMMU registers will be
> +  split into 4-byte accesses.
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 46df79dd5495..0e3552a8142d 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -14,6 +14,10 @@
> #include <linux/iommu.h>
> #include <linux/types.h>
> #include <linux/iopoll.h>
> +#ifdef CONFIG_RISCV_IOMMU_32BIT
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#endif
>=20
> #include "iommu-bits.h"
>=20
> @@ -69,21 +73,35 @@ void riscv_iommu_disable(struct riscv_iommu_device =
*iommu);
> #define riscv_iommu_readl(iommu, addr) \
> readl_relaxed((iommu)->reg + (addr))
>=20
> -#define riscv_iommu_readq(iommu, addr) \
> - readq_relaxed((iommu)->reg + (addr))
> -
> #define riscv_iommu_writel(iommu, addr, val) \
> writel_relaxed((val), (iommu)->reg + (addr))
>=20
> +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, =
timeout_us) \
> + readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, =
\
> +   delay_us, timeout_us)
> +
> +#ifndef CONFIG_RISCV_IOMMU_32BIT
> +#define riscv_iommu_readq(iommu, addr) \
> + readq_relaxed((iommu)->reg + (addr))
> +
> #define riscv_iommu_writeq(iommu, addr, val) \
> writeq_relaxed((val), (iommu)->reg + (addr))
>=20
> #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, =
timeout_us) \
> readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
>   delay_us, timeout_us)
> +#else /* CONFIG_RISCV_IOMMU_32BIT */
> +#define riscv_iommu_readq(iommu, addr) \
> + hi_lo_readq_relaxed((iommu)->reg + (addr))
>=20
> -#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, =
timeout_us) \
> - readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, =
\
> +#define riscv_iommu_writeq(iommu, addr, val) \
> + ((addr =3D=3D RISCV_IOMMU_REG_IOHPMCYCLES) ? \
> + lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
> + hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))
> +
> +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, =
timeout_us) \
> + readx_poll_timeout(hi_lo_readq_relaxed, (iommu)->reg + (addr), val, =
cond, \
>   delay_us, timeout_us)
> +#endif /* CONFIG_RISCV_IOMMU_32BIT */
>=20
> #endif
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


