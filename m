Return-Path: <linux-kernel+bounces-357568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA289972B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336671F21722
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D31D0E38;
	Wed,  9 Oct 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+NTzhOt"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38A1974FA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493968; cv=none; b=JZI+FuEIwWU2BvOsxOIL3hpORP+bKGf8UEdXRwROWawiVFEI4Ja+JnZYZNNhZljgvQOozycmDrYMhYW+W5dq4uzCxM5ahUrEVwG3orf43bVe+g0NqIa04lcK6DYnmEjFRB32K2R/lIEU3ufIkiK3SFfJH9zyrW8SPvir1+siMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493968; c=relaxed/simple;
	bh=x0LEBgWFX8/Z5rjwx4c5FdHyR/TFMtesUDLgaOgpdKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrQuthYEbmuuPGMKZmgrSihqNAEk4iiY1H3Fe3+tUHUEWtab/7XTPe9TkFj2hM2GEzUziHM8R4eKVWozlNZc1MFo8snEEbHmO2orVXssXvhTDowOHBncX0llc3qdhsBB2F+tRnWIO3+pwNUYVi8C9uxJmKppxgfFxfr0gnKptTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M+NTzhOt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db238d07b3so6057619a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728493967; x=1729098767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRxBrMYRUSC9IHay/khuquxAWPmwQ/uGbdb2V63yZG0=;
        b=M+NTzhOtUG5JVV6Vrh8BHrawWthdt6JTOHDZKe9nYIEHEt33wsZDrgsstMTVYT5cCO
         HpjkCOHAMOKJYC+imT+krMOvR4rLEolNBCjOwoJ9i/Qik0ucxUQwC8Ac8RlBLE5eYq5d
         oYDrorQIFM898Jnq9x/aW9PkII4D7+4xFx6+adoiaOQKRO4Yiot2XUtvihLc1q+tCzGQ
         WS3jGc6HSvNP+HkhfCsYhgYmBXjlogmOaeRfLdGXVg6ooafPavs/asDbgqI+PXdFx+hy
         NMgV2FhvykbdnV4GDx9Bt23AqXi7wlxlzS8z1FQ7dBakUcdhJQJcpQ4H9cArh2+nNqsQ
         vaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493967; x=1729098767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRxBrMYRUSC9IHay/khuquxAWPmwQ/uGbdb2V63yZG0=;
        b=PUcUUIKba2z4Kfoit0d0u1C6h1S8FRJsWXSW0LHf5T5jPlHnBEBPM0Lpco+oBHqp0y
         OVT/2fdsJJY0dFi0XV87zgDvT3JDy9/AUY/30NQeXx2AjnffqXBaK7QmuYO4Bw8hKlj4
         PoED0dGfCPyQWG2qAzLy7UMF3YOScbKBD98FE5Go+40VmbeUvAuStq2p4w8KcPol8Hb0
         A9ILHHQcp1hDiJF/UWRibXlVce3cmgf9nxhvRDoB0KpWN5kfJcHRsjCcqivK4m3MA+5C
         u1s28FkHcQcWiq94MeoYqFYG6/i+el7Zc2md4YbPQmrIwIY2l3EO0TFQEQKABk+Td0sK
         lynA==
X-Forwarded-Encrypted: i=1; AJvYcCVV22GsdmukjFHbIAEEbIZ3BNcWAalDKhAG3XsSULnvJRJzbkwo+p4BgzTcnmy8pvoIms1XLmed5g8FBXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvX8O2JFDdjl8fNRd1iUTiMozz3Dyy6eBfrcx0v7RYPlePHAJb
	AZZcHmVwTQ2Wv7gr25tZH5h3LTJl2wiGzLjkg5rBFv2ZakJ9kglBJ5Zn/3s5+5A=
X-Google-Smtp-Source: AGHT+IEgU0bC4X1ELyC1ooAWtFNdIa8KYx6CitYmInZjHOZYWppcnP1NV3hwhofuYX0ra1wvSuIsZw==
X-Received: by 2002:a05:6a20:b58b:b0:1cf:337e:9920 with SMTP id adf61e73a8af0-1d8a3cbcb83mr6015899637.47.1728493966656;
        Wed, 09 Oct 2024 10:12:46 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1199:5ae1:92cd:b017])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4a1f4sm8005204b3a.113.2024.10.09.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:12:46 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:12:43 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andrew Davis <afd@ti.com>,
	Martyn Welch <martyn.welch@collabora.com>,
	Hari Nagalla <hnagalla@ti.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox, remoteproc: k3-m4+: fix compile testing
Message-ID: <Zwa5i69JWgp9cG6v@p14s>
References: <20241007132441.2732215-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007132441.2732215-1-arnd@kernel.org>

Hi Arnd,

On Mon, Oct 07, 2024 at 01:23:57PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The k3-m4 remoteproc driver was merged with incorrect dependencies.
> Despite multiple people trying to fix this, the version 6.12-rc2
> remains broken and causes a build failure with CONFIG_TI_SCI_PROTOCOL=m
> when the driver is built-in.
> 
> arm-linux-gnueabi-ld: drivers/remoteproc/ti_k3_m4_remoteproc.o: in function `k3_m4_rproc_probe':
> ti_k3_m4_remoteproc.c:(.text.k3_m4_rproc_probe+0x76): undefined reference to `devm_ti_sci_get_by_phandle'
> 
> Fix the dependency again to make it work in all configurations.
> The 'select OMAP2PLUS_MBOX' no longer matches what the other drivers
> dependencies. The link failure can be avoided with a simple 'depends
> do, so turn that into the same 'depends' to ensure we get no circular
> on TI_SCI_PROTOCOL', but the extra COMPILE_TEST alternative is what
> we use elsehwere. On the other hand, building for OMAP2PLUS makes
> no sense since the hardware only exists on K3.
> 
> Fixes: ebcf9008a895 ("remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem")
> Fixes: ba0c0cb56f22 ("remoteproc: k3-m4: use the proper dependencies")
> Fixes: 54595f2807d2 ("mailbox, remoteproc: omap2+: fix compile testing")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/remoteproc/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 955e4e38477e..62f8548fb46a 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -341,9 +341,9 @@ config TI_K3_DSP_REMOTEPROC
>  
>  config TI_K3_M4_REMOTEPROC
>  	tristate "TI K3 M4 remoteproc support"
> -	depends on ARCH_OMAP2PLUS || ARCH_K3
> -	select MAILBOX
> -	select OMAP2PLUS_MBOX
> +	depends on ARCH_K3 || COMPILE_TEST
> +	depends on TI_SCI_PROTOCOL || (COMPILE_TEST && TI_SCI_PROTOCOL=n)
> +	depends on OMAP2PLUS_MBOX

I have tested this patch with CONFIG_TI_SCI_PROTOCOL=m on Arm and allmodconfig on
x86-64 - both compilation work.

I can apply this patch as is or you can send me another one with the
modifications you did for TI_K3_DSP_REMOTEPROC and TI_K3_R5_REMOTEPROC in your
previous [1] attempt to fix this.

Thanks,
Mathieu


[1]. https://lore.kernel.org/all/20240909203825.1666947-1-arnd@kernel.org/
>  	help
>  	  Say m here to support TI's M4 remote processor subsystems
>  	  on various TI K3 family of SoCs through the remote processor
> -- 
> 2.39.2
> 

