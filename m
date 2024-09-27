Return-Path: <linux-kernel+bounces-341960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A579888E0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB395B25122
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7523518BB90;
	Fri, 27 Sep 2024 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciI0Ozww"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6F1E4AE;
	Fri, 27 Sep 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453828; cv=none; b=ZUMBUjj5rk5TNMuEl7wy3zQhnFSIgmoC7WlIzq2/GN076HpHwWF5m06iqDQPcgkiB/DVvzbFksWArkQPjgcglx9lBbXymK1tTAUMaj/d+HW/L3zzf0LspYv/pC9cw4Hfrfbp/+YCCTQdsqr5Y+eJ/DNcYPBceT6CfzhBw7DU0oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453828; c=relaxed/simple;
	bh=Vm0nFv5pTtfM4Kg9IRi5F8nbyeaxRpuRYrhTeo+bloE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=KLRJhs6LIZ4+j93cAXXaVBLRwhL5ihvKoMMrZpcTSFhKU91JF31rq+edWZtuUfLn/vtGAfteqNcATK/A4AWMjLxATcihIaXl9FUBrkt/ZLVc35bLVVEbHAuf7BFRhS2wmtNlhmVzI9htP8KTBGaUPQ8reH5xBmQJ+upolamdhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciI0Ozww; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71788bfe60eso1901830b3a.1;
        Fri, 27 Sep 2024 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727453827; x=1728058627; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+yddGmNvvninROrZh27GX7gU63fOouPWzZAESW4FuI=;
        b=ciI0Ozww1Y62ozJB56Jl5fH+jfryZKTvpDh866uFMS6xazrk9Lw95oWaCkLwiOANi4
         au/tMGFZcLwndjVeLP2cWnU62vOOzmEYICwbrdK5VHu2iGBJ99pFAApR5IogTg0s+w+g
         UA6S1vrLC4mXYlYDPxrgsIPZQvHzh+gMyRkrDUoLFiNZRnsIVy6UHhheTZ3c4dVpwQUz
         K9s/rCXpOP+dIRq5gmjtSwaxT5MD9aN0MGoGwLLfOMdJgm0AHN6++HCW5pUdxOxAF/Dm
         VS53xljy0JJUEdg+HXngC8yCYcetuYSEk/Xekoi3tdxwRJe8oZKHmEiCCZR5vubIba/E
         88LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727453827; x=1728058627;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+yddGmNvvninROrZh27GX7gU63fOouPWzZAESW4FuI=;
        b=p2+fR89cj6pu6QPIYVGU8lTW67C9YdWhaorO3vDXXOPHaxGN+5j50wvYN+Du8ZG3wN
         dgrlZrjzxfm2RfkiikPqhboi0zeGdGBHP7g4RVLFmsv2QBQuef+JPmUO00chKvGvqlrS
         kYPLIxUO83DVRWWxLYf4yhmH5Z48sVt/h6ha2Jvq/opbBFeJeyAh/pKRoJWPJQSpZ9CW
         u+Dhfda76766lH5o76WSvx1NVVb4/agNf6v02DNtjuNOWP/UlQOqilJ6vKM/327GNWKV
         +IFkhcSet9dMiafSWY/Lto5AzmXL+pEveNlODvihRDWjU1Nhtnz25dh/CJ9HA54HVGlG
         3pAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuBwfpxxuyVTkXarw/C2rYLN/0R9ySFvkIMpVkfR/bTfsuUPCOI9WGdeCzHnGdNb742XOHrKPmFW1l59c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU++HWJymYNSt4uxOfqcU85ESNgr5PZk6WOBLrRtzTMcLvHC2g
	eW9eWprr/1w8mN48For/bQ54UZQIFkMH4XsStlfb1cqqyyemyLB4
X-Google-Smtp-Source: AGHT+IGozEALnQx1Er7SBfzGwW2QDie8jNd5SkYPMBx3yNF2xMOdfceVDjor2c9KEZXwlrpTM7HORA==
X-Received: by 2002:a05:6a00:17a9:b0:70d:2fb5:f996 with SMTP id d2e1a72fcca58-71b25f451e7mr5943442b3a.11.1727453826683;
        Fri, 27 Sep 2024 09:17:06 -0700 (PDT)
Received: from dw-tp ([171.76.86.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515f1asm1766740b3a.135.2024.09.27.09.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 09:17:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>, Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] powerpc: remove dead config options for MPC85xx platform support
In-Reply-To: <20240927095203.392365-1-lukas.bulwahn@redhat.com>
Date: Fri, 27 Sep 2024 21:23:45 +0530
Message-ID: <87frplay9i.fsf@gmail.com>
References: <20240927095203.392365-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Lukas Bulwahn <lbulwahn@redhat.com> writes:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit 384e338a9187 ("powerpc: drop MPC8540_ADS and MPC8560_ADS platform
> support") and commit b751ed04bc5e ("powerpc: drop MPC85xx_CDS platform
> support") removes the platform support for MPC8540_ADS, MPC8560_ADS and
> MPC85xx_CDS in the source tree, but misses to remove the config options in
> the Kconfig file. Hence, these three config options are without any effect
> since then.
>
> Drop these three dead config options.
>

Indeed these looks to be dead config remaining.

> Fixes: 384e338a9187 ("powerpc: drop MPC8540_ADS and MPC8560_ADS platform support")
> Fixes: b751ed04bc5e ("powerpc: drop MPC85xx_CDS platform support")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  arch/powerpc/platforms/85xx/Kconfig | 21 ---------------------
>  1 file changed, 21 deletions(-)

I couldn't find any relevant reference of MPC8540_ADS, MPC8560_ADS or MPC85xx_CDS
after this patch

So please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index 9315a3b69d6d..604c1b4b6d45 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -40,27 +40,6 @@ config BSC9132_QDS
>  	  and dual StarCore SC3850 DSP cores.
>  	  Manufacturer : Freescale Semiconductor, Inc
>  
> -config MPC8540_ADS
> -	bool "Freescale MPC8540 ADS"
> -	select DEFAULT_UIMAGE
> -	help
> -	  This option enables support for the MPC 8540 ADS board
> -
> -config MPC8560_ADS
> -	bool "Freescale MPC8560 ADS"
> -	select DEFAULT_UIMAGE
> -	select CPM2
> -	help
> -	  This option enables support for the MPC 8560 ADS board
> -
> -config MPC85xx_CDS
> -	bool "Freescale MPC85xx CDS"
> -	select DEFAULT_UIMAGE
> -	select PPC_I8259
> -	select HAVE_RAPIDIO
> -	help
> -	  This option enables support for the MPC85xx CDS board
> -
>  config MPC85xx_MDS
>  	bool "Freescale MPC8568 MDS / MPC8569 MDS / P1021 MDS"
>  	select DEFAULT_UIMAGE
> -- 
> 2.46.1

