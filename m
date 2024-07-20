Return-Path: <linux-kernel+bounces-258032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E949938250
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9A41C20F2A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1691482F2;
	Sat, 20 Jul 2024 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="nJBVhH0K"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A642BCF4
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721497099; cv=none; b=SGPo38Z+26QA+RQf3mHTgwjMsRCvRLsKSeMdBnucLTsk1vhnk88aQV0yYeV6v2QQmux7oUoJCK4b1YIP3AQJKy1AFCs24tcqUb4I5aJc+2GjzRC1JiWmAzl5gG7C5x1UOzydzqy2sYOHp3+PUjzl/38OF4Pfw+4JZKN2BvBf1/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721497099; c=relaxed/simple;
	bh=tE3tp8gaxhwp2gKoWeh8kQuL//yIMJqCdlXobYU4jTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN13wpwnIPmWkZCuZNRv/kKBUh2o3zJwjuPcNChwQd7vLfJD7vOHodvJuF+VidAlkf3dxz3suozb0QMAjh6phCdRyVZWkD1al1g0tLx5Y9fGbZqXODTeHMdye7sF5Ta1umWff8ytcLapC4dXQAjFuACCgHr4v2+FXSZbRI8nxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=nJBVhH0K; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b1207bc22so1483914b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1721497097; x=1722101897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWCpCh1RT5YH2JXj048b4CuDC0szEul1kcrCj/vFPLU=;
        b=nJBVhH0KNsK7pgmuTgmT4SaW3nBO0Kip5u5Tc9FmUXIRpongXy0+nrX8TxlgaH3BER
         SxeO5poQ49EXDXPJS3qnXzUWUNwQZ7thGTcx/n1x8ex5m/ALJuBQza944KSqRI+brC4B
         +W5U8Xd/Ue8iMCmxCVaOw3uwCb8K2jE3qB80sCSDfjRHTmdPCm4nuFwvq+60IQrEVldZ
         N7vdGPPs6Kd1gQVIoGNE29cBeX5PVm2I5tximXlXOsiZL2QxlGCemrrORSLA+4OqTpRV
         G7wa3/GU0tPIX4809opnjUr8f7gjInmMtWDtOScjtmpmQD3dfiM9oHXpQ274l7kTgkQZ
         F8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721497097; x=1722101897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWCpCh1RT5YH2JXj048b4CuDC0szEul1kcrCj/vFPLU=;
        b=F9cb9LqeZ1DHUu93eywmZ2one5MTXtgQVuVUyzBxcrnwXp73pAgOrZJ06Bi3crHaTI
         ChTFhmQ3/Dp2QCPu4g6sNMud7ZMUyQBWXr3Cgw69Soe6HLs0zsxGT2bBJapM5dHnlp9W
         /qwsfeU8aAEQHCEpc9YB6cmE1f5jyNtSbSqV/gvstq/4i/KfsHzXmhvAwoE5m/aaLsHu
         0vwOYLg4x74TuJ4FkpVza+6j2iTeavFwB05Ys7QWmRC2BURDwgrEDUwK/axmd5n1PfZI
         8pgxOPAqextjECmP4uE0Bqlaky9X3/t8PokxSMew+2byiL4CF3NgLdmj9Byh2kJk/bCa
         NgYg==
X-Forwarded-Encrypted: i=1; AJvYcCXU7cZXfCkz2diWglsVvAHr1FpCRsXZ9qTURoTWwyVjWAzrSexHl2CXBkKzr0+UyrNUVs8J1Qarst5VLwMEGs81M4MVXZBoC/5gvJgp
X-Gm-Message-State: AOJu0YzZ65y/S5o3Rxuyhffh3e2NKr3K+3PQxNf4ukMfAeSwjfkkB0gO
	VJTlsFZrCY0PWgZtHBW7fpJ8VV2PfSHeJ8fqdHFV5Lk1BW5UaDFJsf8TKQ02zy5BoA8ZlNpBSux
	q
X-Google-Smtp-Source: AGHT+IEZBuHQCUjuHktI2zZF92KPVH9iMx+hzhdgFbNzWtZpsCoZ0ZRMaTcAb2VDQAUawu8u74y0Qg==
X-Received: by 2002:a05:6a00:3e21:b0:70b:2ffd:424f with SMTP id d2e1a72fcca58-70d084f41bamr4758393b3a.15.1721497097427;
        Sat, 20 Jul 2024 10:38:17 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:9097:70ec:aab6:b6a8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d19312aa1sm388877b3a.121.2024.07.20.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 10:38:17 -0700 (PDT)
Date: Sat, 20 Jul 2024 10:38:14 -0700
From: Drew Fustini <drew@pdp7.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, jszhang@kernel.org,
	dfustini@tenstorrent.com, frank.li@vivo.com,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: T-Head: Disable on 32-bit Targets
Message-ID: <Zpv2Btw3dUXaJxp9@x1>
References: <20240719151027.16152-1-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719151027.16152-1-palmer@rivosinc.com>

On Fri, Jul 19, 2024 at 08:10:27AM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> This fails to build on 32-bit targets because of a missing __udivdi3.
> IIRC the right way to fix that is to avoid the division, but I just want
> a tree that builds and the only real T-Head platforms are 64-bit right
> now.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  drivers/clk/thead/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/thead/Kconfig b/drivers/clk/thead/Kconfig
> index 1710d50bf9d4..95e0d9eb965e 100644
> --- a/drivers/clk/thead/Kconfig
> +++ b/drivers/clk/thead/Kconfig
> @@ -3,6 +3,7 @@
>  config CLK_THEAD_TH1520_AP
>  	bool "T-HEAD TH1520 AP clock support"
>  	depends on ARCH_THEAD || COMPILE_TEST
> +	depends on 64BIT
>  	default ARCH_THEAD
>  	select REGMAP_MMIO
>  	help
> -- 
> 2.45.2
> 

Acked-by: Drew Fustini <drew@pdp7.com>

Sorry about that. This patch makes sense as the TH1520 SoC is 64-bit
and I see no valid use case to run a 32-bit kernel on it.

Drew

