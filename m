Return-Path: <linux-kernel+bounces-355362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515C99512E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7A42839FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1FE1DFDB5;
	Tue,  8 Oct 2024 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ty/r3emr"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF231DE2AE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396779; cv=none; b=rLfRJcIzTXRXOpfoyCeLLBEKnIWkmS4sCgsAJECXzzXn00JLar7X8KRp3rYFa/eMUg4mCvBp0bwIa7rEWCGIOnsRbnPxBXO/aaLx9srCbMVbXw5s2s4SK0wAAkYZU/+FOooQld53oLTCHNqDMAHOxTXiosrR1Od6Zr4i75/P5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396779; c=relaxed/simple;
	bh=68NbXlc6ErTKvDdKfTBzhFam0ZAZ3bvQYRdnZfnDNO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZvxmdYltTGM+B6pb19t1B9rU+jlEIvl3IVDCTfmmy9aapF5DfMJcLV1l9IhDML8EO+IBfhnygloD6jpW2iWMWNkyK0GYYABJ1P1T63z+BIJv84EudjglayM+GmegysLflANMy9PYEPjZwD0SxsRRJ5d1jPqABgCvufqOEYmvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ty/r3emr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b64584fd4so54681675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728396777; x=1729001577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdz/P/YgLIpgF5LDJZ0vnmgihR7pjVttUHO6lvnedj8=;
        b=Ty/r3emr+9NUHXqwaXLxaPkTvkz6n6UoMolI6Pf7xoJCS3KxlSqSSybOV2z9XkA4RV
         7D8bkKp72mdO4sxu18dP5yiHXc1Yztc8uCi0ZOD3w3DQfXXfvksJzYQQ/WEbbNXfIJcj
         77zEPu4zpd50TARrjB1yTBUmD5gLJXNlRhqCHiDcq1o2/wkxbeCRu4D+soUTlFh65Itw
         QQ8hQawmzTJYCjGlG4VXxJbFLDpB0ZXMIk4xeO69ePPQf8B7xZttKCxcloDTxPI4pRQH
         CTNUX7RupGhYszDnbF+S4SW+yCzwnKySh71x6YuYGfJZE6fZKsRJblyztUoFrFRqEAA7
         YDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396777; x=1729001577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fdz/P/YgLIpgF5LDJZ0vnmgihR7pjVttUHO6lvnedj8=;
        b=nWNAChBpjq1ZqNxxtPd5i02dHVksT22bMnKh7p3nZLUYV11bZXEIuq//gPAV6zOZ26
         eQ8AtXcs2e3WedT8PfXMyrREWPMDXPUqRcFWF/JQcwxfrmwACt1oG6DkToAxGboBx/Tk
         BuU0cBJ3x4iQMCU1MHG5n649wL/6jgaBNMh8+6A0yxzaiju5lYiBwvSE3HDUK+N7Q/iI
         b1g8SKEQRSL+zOgeJjIDDJdXeTJHmZyO7eJgP4mEMhha3oSlUNcpf+hSJ0QMa6jg/18K
         lqdEKLSNU5TVltOSgnk4tZV9eNHapL7ChpsSu0ShJB4BlsGxy3e6RtRcnCoSIZEJc+z7
         jqLA==
X-Forwarded-Encrypted: i=1; AJvYcCVok6G3dRddY5v2TBbbpsApW2rRK/g8cHvkUVEINzLLGDodZlCjLHCW+HBom6IvJFhnPOo9jg6ywIwJYc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEhPjgI4RdBTLEJW5EYtOO4VVC/VtlCvYzLpuknAXebCUHodV3
	0vBy4KBP/cRf5imhER0NvHAeXjMDL84BIR0/murLNdS8aEpOvjh2Uy7y4i9qCEE=
X-Google-Smtp-Source: AGHT+IETIz9D680TqfPPi14OhcJTCce++YlCJVtGFCgaeiH2J9QxoyUipjIog0IewX5/qXnrJYcwqQ==
X-Received: by 2002:a17:902:b201:b0:20b:968e:2583 with SMTP id d9443c01a7336-20bfe023e04mr150588355ad.2.1728396777142;
        Tue, 08 Oct 2024 07:12:57 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e3a0:1c0:95c8:8b16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a292sm56215365ad.173.2024.10.08.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:56 -0700 (PDT)
Date: Tue, 8 Oct 2024 08:12:53 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andrew Davis <afd@ti.com>,
	Martyn Welch <martyn.welch@collabora.com>,
	Hari Nagalla <hnagalla@ti.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox, remoteproc: k3-m4+: fix compile testing
Message-ID: <ZwU95d+JjoipFy0s@p14s>
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

On Mon, Oct 07, 2024 at 01:23:57PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The k3-m4 remoteproc driver was merged with incorrect dependencies.
> Despite multiple people trying to fix this, the version 6.12-rc2
> remains broken and causes a build failure with CONFIG_TI_SCI_PROTOCOL=m
> when the driver is built-in.
>

(Sigh)

I will do my own testing and will get back to you.

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
>  	help
>  	  Say m here to support TI's M4 remote processor subsystems
>  	  on various TI K3 family of SoCs through the remote processor
> -- 
> 2.39.2
> 

