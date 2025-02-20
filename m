Return-Path: <linux-kernel+bounces-523345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F2A3D567
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54B43BCBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9FE1F03FF;
	Thu, 20 Feb 2025 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX0SzRmh"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99241F03DE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044903; cv=none; b=VB1emCldtFXCynMv5FzIk7Xk7fumBuLM1WQvuR0NmugaRRJDgKI16JuiANOj/tMvtKWWQyv0ab7CSvde3QXMOq4OGFthzqui5VJys5upWkbrW8YjjQVHm43Tt08zH2ImQRupyXevArC5TW6HEqs6MNtsT9Yh3QVVKNBmUDOur3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044903; c=relaxed/simple;
	bh=T0l7ZXOVLBwC3M70SuYLzm8FEBABVKHNpBCNm24xvR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmT8vtIApFRXFilfX+r0xSZ6P3+rANTitxnpaPeE6BbE2kPq0n1EfE2P7aOs5hi+ijed78S3aEho3QfHluxfqj0XjSMCK4MALIDLpk0eZoMFW5RtPIpCwKbKzvbJwx96jr4hbhttwAwmFftQcUsNORbUrMND09H6D0XPYHfR/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX0SzRmh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30761be8fcfso6903181fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740044900; x=1740649700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WnnHEBGbZXn/iLbbVbgNyyswQeQVsn6ueu7C9pryYmk=;
        b=IX0SzRmhKWuizhtkomSnDlPH7lnz9YFkgKL1X6Ei6Xw4iSVdE2nL1BRBw/fJ16oiy0
         GN2ZDr6Upk5SYbmgJD/02/8JKcasHKl70lpFL3NMoGWCzWJ35x+jmpWlyJwRJHyGu83h
         Bku6Fm3GtJ5qi/Ba/Pq7CTMzWuSFJl+SsVE+O0CigA01RWRunK2f92f++kM72c/mOBdm
         rOr6dnJ3Ey/n34w93evcDko8Y5/DJONz9kkjuMtELDoXaW5ZBfYxg+ie4Wp2MGw9AMLx
         7W7bBy9j60dz5rv+KSk9C+U1dHCdMCjw1iBW5j/U4rxCjGdUbyoIG7mk7ntdOaaxOi0J
         Ik/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044900; x=1740649700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnnHEBGbZXn/iLbbVbgNyyswQeQVsn6ueu7C9pryYmk=;
        b=ocwnCQAxvlNDFMK8QPwRx5yg/mQwoFzj6QpMeKF4yostgg/+M82ey0TD9DxBoQCWSc
         quk0RvBP4wKtHnz95uHpIK+ebMMUEVyGNZWXz3qbQemV5s36rS5ETRPS5gDgiEC061Ze
         RlrEC59MGsTvnuha0uJ8TgIJhg0DbDM/aC08m4JKS96mYCz55NQ8Z/bLk5pf9mwwZ9KC
         gdz+Oo6sXSNSClKVVD1FebKdCqQCQQQj53IezneXG1k/nfd6uqeY+lcuQg0hvDwgaOuZ
         NaV89SkJUBn1btTo+j/60FOGg+hHCdP85vnvxgmc83uCj7UCesL1aqCNGV+M2h55an5o
         Wj7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjnO1/z2aBBsJUjQDq2zZJKeIzyEqtIQyp/qohWNPnpdafdd6yvD5mEzY5XiBRL4X2Glk8XCxPkjcLkZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cpN2Kf6L4K9AhUUndbkzR9+V/ypiAMw/0Nvm+pVXRaPe/awk
	cYQ0EOpq1rXt69rvLJCR9MTpjcOtfKddFlvU06eCHOvzsML3URB/M2KLfRHxqHA=
X-Gm-Gg: ASbGncs64gO1Nwbc2CngL/I+R+KnpFcNi1jvYO90IcygAPheZfPxM+UUpDj0plchIOY
	37YGjvggSm2HTWhUstYWD/VH7k0N0Y05SMr1SK9nJJzpmJSJXh+A1AcAXruUjr0TQIv+ySLCjhf
	7GQzjhUWZCRU2JEe88xHur9b9SPuxAbWu9ImiVKALzePuny4PwN2yxzTZvU5ndHLQN5HIktocrS
	TDHhFxTkidiwntKb4Zi2Hb7097zE86iIgKQie55Ul1fYyabjSr7dVzxIhZe+xmrgcWs6AQH713s
	0BbBBzY=
X-Google-Smtp-Source: AGHT+IFalDevTONqluicJCCPb7Sdnk7diBGx2VZQCkifcqIYaN4hBEjD+cfqBSzDu3kZfFTNqaXsNg==
X-Received: by 2002:a2e:8615:0:b0:304:588a:99ce with SMTP id 38308e7fff4ca-3092797efe8mr62921121fa.0.1740044899278;
        Thu, 20 Feb 2025 01:48:19 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091d92e8ddsm22504011fa.70.2025.02.20.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:48:18 -0800 (PST)
Date: Thu, 20 Feb 2025 12:48:16 +0300
From: Sergey Matyukevich <geomatsi@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] riscv: select DMA_DIRECT_REMAP by RISCV_ISA_SVPBMT and
 ERRATA_THEAD_MAE
Message-ID: <Z7b6YGiUiUYp9lU-@curiosity>
References: <20250116172950.1989748-1-geomatsi@gmail.com>
 <199526de-4351-4fd7-8f6a-9e8dbf05c184@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199526de-4351-4fd7-8f6a-9e8dbf05c184@ghiti.fr>

Hi Alexandre,

On Mon, Feb 17, 2025 at 01:23:28PM +0100, Alexandre Ghiti wrote:
> Hi Sergey,
> 
> On 16/01/2025 18:29, Sergey Matyukevich wrote:
> > Select DMA_DIRECT_REMAP for the RISC-V extensions that allow to set
> > page-based memory types in PTEs according to the requested DMA
> > attributes. This is the purpose of Svpbmt or XTheadMae extensions.
> > Zicbom or XTheadCmo serve a different purpose, providing instructions
> > to flush/invalidate cache blocks.
> > 
> > Fixes: 381cae169853 ("riscv: only select DMA_DIRECT_REMAP from RISCV_ISA_ZICBOM and ERRATA_THEAD_PBMT")
> > 
> > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > ---
> >   arch/riscv/Kconfig        | 2 +-
> >   arch/riscv/Kconfig.errata | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d4a7ca0388c0..a5dabb744009 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -603,6 +603,7 @@ config RISCV_ISA_SVPBMT
> >   	depends on 64BIT && MMU
> >   	depends on RISCV_ALTERNATIVE
> >   	default y
> > +	select DMA_DIRECT_REMAP
> 
> 
> From what I read, DMA_DIRECT_MAP relies on the ability to map pages uncached
> (pgprot_dmacoherent() here
> https://elixir.bootlin.com/linux/v6.13.2/source/kernel/dma/pool.c#L104). But
> CONFIG_RISCV_ISA_SVPBMT does not guarantee that the underlying platform
> supports svpbmt so to me it is wrong to select DMA_DIRECT_MAP, we would need
> some runtime check instead.

IIUC this function highlights coherent dma allocation options and their
requirements even more clearly:
- https://elixir.bootlin.com/linux/v6.13.2/source/kernel/dma/direct.c#L222

> >   	help
> >   	   Adds support to dynamically detect the presence of the Svpbmt
> >   	   ISA-extension (Supervisor-mode: page-based memory types) and
> > @@ -787,7 +788,6 @@ config RISCV_ISA_ZICBOM
> >   	depends on RISCV_ALTERNATIVE
> >   	default y
> >   	select RISCV_DMA_NONCOHERENT
> 
> 
> And in the same way, we should not enable RISCV_DMA_NONCOHERENT since
> CONFIG_RISCV_ISA_ZICBOM does guarantee the presence of zicbom. Because then
> in mm/dma-noncoherent.c, the cache flush operations are nops.
> 
> Or am I missing something?

This is my understanding as well. In fact this patch is almost useless.
It would only allow to enable DMA_GLOBAL_POOL for platforms that support
Zicbom, but do not support Svpbmt.

The actual problem is that the RISC-V kernel image cannot have both
DMA_DIRECT_REMAP and DMA_GLOBAL_POOL since they are now mutually
exclusive in kernel/dma/Kconfig. This limitation is not convenient for
RISC-V, where kernels can be built with support for multiple extensions
and errata. But on boot only appropriate subset of them is enabled based
on the chip's VENDOR_ID and selected dtb.

Currently a portable RISC-V kernel is suitable only for platforms with
support for both Zicbom and Svpbmt or their vendor-specific alternatives.
So it doesn't really matter where DMA_DIRECT_REMAP is selected. Platforms
without Svpbmt need to build their own non-portable kernels anyway,
enabling support for DMA_GLOBAL_POOL. For instance, Starfive and Andes
in arch/riscv/Kconfig.errata and drivers/soc/renesas/Kconfig respectively.

Maybe one possible option would be to revert commit da323d464070
("dma-direct: add dependencies to CONFIG_DMA_GLOBAL_POOL") and add runtime
checks in dma_direct_alloc for dma_alloc_from_global_coherent.

In that case RISC-V kernels could be built with support for both
DMA_GLOBAL_POOL and DMA_DIRECT_REMAP. Global pool code path could be
enabled only for platforms that explicitly specify it in their dtbs.

Regards,
Sergey

