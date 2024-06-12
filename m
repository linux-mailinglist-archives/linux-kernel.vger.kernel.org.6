Return-Path: <linux-kernel+bounces-212070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077E905AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E794C28351D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4942072;
	Wed, 12 Jun 2024 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dN9TB0PW"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127454757
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216925; cv=none; b=bFr2HJTfivYbJnAlrEcHaCVb2hxQlAnqQGQSTB/WsTTwVnzEBxGX17LlSE7I/3PlqeZ0DB7EPbWjiaPNThh5Ezxr4/n6yjOA09pW0gOmYcLn39t9SiORAP7t5g4wAH1rsL7ajYnBS7e+UyU8lQ1LPo1HY7DLha2/Z0zkAIXQ2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216925; c=relaxed/simple;
	bh=EJ6QMiTUGD8BpAvPeihNMjmAsqVldBn/0MSVdoeEM84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1aix/YkpQosmtVZpgURcYEi8geVfJGm5TML2Z3XjoYbHNoWrKQWxmCQ9/h7fjCpva+P36XJeZ8X8JHaA5iwKuz1nCbEn8dZWdZug/NEKG8F0sT7/MkRJrQzWOqG1v8pZzg1k0PwzG1ncBFETN68B/Lnlurd84PxkBEvU8z9Ql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dN9TB0PW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c84a21c62so245454e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718216922; x=1718821722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4A3nskQbinN2oXidgSFRXNzq96u2qf2Pg7QGZ6rhiQ=;
        b=dN9TB0PWNdbyW1kqe9Hj4w8O8IGUe8mj2zXhexLjZ4K1CBI2Wkzfp/zB25XFjJh2Mv
         a328Pe84OkkVW+Cjaj7iEg+qS52F4j1FYQEUjNV6D4HnE1V7WTvCbMUiGeqqmw8TabGq
         Pyao63JuOrRKbUPoAy5bMx16r0LzbXtqbpoxdGDKqrx1lZ+Bfz0x1uj9D5RGd8YO3nL2
         TvxF7DL/uIMqkXKSkbcbVr7nMk8YISfRuTTAuIKEuRGwpJymkq/p9GKzRQGrssdcr1DE
         WFwn/94WglmOPMIms1bEn+Ya36tp4DARSQORKVuCyYVXC8mBs7bh/HMpfStPpGonkS0A
         C27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718216922; x=1718821722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4A3nskQbinN2oXidgSFRXNzq96u2qf2Pg7QGZ6rhiQ=;
        b=lzB8IZG0rvKJlCqrNeR5iweKUh/Rkn5HAFWE2AL3IOBdZTtA2mDYQgSLve+DQlFy+a
         yW4Xdx6Cd38ybE3kSL+/Gp0YO9YICfo7MJM5lw4xsbDVPUwNNuPuAw7gBE1ZU1lZwd+Z
         uZjDZBrMiXwjlLcXJ47KWpG8A+zehjBsj7cGX7/D1tOgqYpKGOp+lcvG7MYXIhvlOXKW
         pzTd1oNCDuAeRlESp9UFOPdfeJL6eJmtqIiw+B0NAlZ/bkPnmxesx0v+BWSTvdgNj/bT
         /CMvC46n05PLfINxBIb3NFvbGbZ1HIdzdCgpjRzSsTeCefO2UQ+A4+7PfTkcX/E2BbMj
         YnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+JLeoFgGuqMFLgropcNePXqYQBf03SkyzB0Z+rOb4TfV7pYMLKEMAahoYGY9pF52hj0JZcCN7mwdPskv2t/36PC16q9lFuI31R20V
X-Gm-Message-State: AOJu0Yw7Jjwlm7l6Ef76z0oszZHZHpZGz3EUlHFIhwnO+zvZJyDogGTO
	JxqLayJZlf62H/K5Hg/vOj9Lcu7Twp+e5FxndSfI/SuiQrSwToyv4l1QBgNzOy3myaAs/eqhUz5
	XUBo=
X-Google-Smtp-Source: AGHT+IHqxWBY5W5/D7iMvIiOM+bNYgI78Otk50SorVbJ2aH6damt3orZjW3DPhMTysOg1CnepRZEIg==
X-Received: by 2002:ac2:504f:0:b0:52c:84d1:180e with SMTP id 2adb3069b0e04-52c9a406773mr1338021e87.67.1718216921351;
        Wed, 12 Jun 2024 11:28:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c8d61d17csm1380065e87.45.2024.06.12.11.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 11:28:41 -0700 (PDT)
Date: Wed, 12 Jun 2024 21:28:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, 
	Oded Gabbay <ogabbay@kernel.org>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
Message-ID: <zbpia232dh4ojfsvhcqxrp6cwfygaalu5cycdrs47pqmnrisvk@dq24nww26gkm>
References: <20240612064731.25651-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612064731.25651-1-quic_ekangupt@quicinc.com>

On Wed, Jun 12, 2024 at 12:17:28PM +0530, Ekansh Gupta wrote:
> Move fastrpc.c from misc/ to misc/fastrpc/. New C files are planned
> to be added for PD notifications and other missing features. Adding
> and maintaining new files from within fastrpc directory would be easy.
> 
> Example of feature that is being planned to be introduced in a new C
> file:
> https://lore.kernel.org/all/20240606165939.12950-6-quic_ekangupt@quicinc.com/
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  MAINTAINERS                          |  2 +-
>  drivers/misc/Kconfig                 | 13 +------------
>  drivers/misc/Makefile                |  2 +-
>  drivers/misc/fastrpc/Kconfig         | 16 ++++++++++++++++
>  drivers/misc/fastrpc/Makefile        |  2 ++
>  drivers/misc/{ => fastrpc}/fastrpc.c |  0
>  6 files changed, 21 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/misc/fastrpc/Kconfig
>  create mode 100644 drivers/misc/fastrpc/Makefile
>  rename drivers/misc/{ => fastrpc}/fastrpc.c (100%)

Please consider whether it makes sense to move to drivers/accel instead
(and possibly writing a better Kconfig entry, specifying that the driver
is to be used to offload execution to the DSP).

> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..e9c79e9063f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18501,7 +18501,7 @@ M:	Amol Maheshwari <amahesh@qti.qualcomm.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> -F:	drivers/misc/fastrpc.c
> +F:	drivers/misc/fastrpc/
>  F:	include/uapi/misc/fastrpc.h
>  
>  QUALCOMM HEXAGON ARCHITECTURE
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index faf983680040..630e8ccd8669 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -276,18 +276,6 @@ config QCOM_COINCELL
>  	  to maintain PMIC register and RTC state in the absence of
>  	  external power.
>  
> -config QCOM_FASTRPC
> -	tristate "Qualcomm FastRPC"
> -	depends on ARCH_QCOM || COMPILE_TEST
> -	depends on RPMSG
> -	select DMA_SHARED_BUFFER
> -	select QCOM_SCM
> -	help
> -	  Provides a communication mechanism that allows for clients to
> -	  make remote method invocations across processor boundary to
> -	  applications DSP processor. Say M if you want to enable this
> -	  module.
> -
>  config SGI_GRU
>  	tristate "SGI GRU driver"
>  	depends on X86_UV && SMP
> @@ -602,4 +590,5 @@ source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
>  source "drivers/misc/pvpanic/Kconfig"
>  source "drivers/misc/mchp_pci1xxxx/Kconfig"
> +source "drivers/misc/fastrpc/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 153a3f4837e8..f83d73844ea5 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -16,7 +16,6 @@ obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
>  obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
>  obj-$(CONFIG_PHANTOM)		+= phantom.o
>  obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
> -obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
>  obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
>  obj-$(CONFIG_SENSORS_APDS990X)	+= apds990x.o
>  obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
> @@ -69,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
>  obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
>  obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+= nsm.o
> +obj-y				+= fastrpc/
> diff --git a/drivers/misc/fastrpc/Kconfig b/drivers/misc/fastrpc/Kconfig
> new file mode 100644
> index 000000000000..3243dc56b2a0
> --- /dev/null
> +++ b/drivers/misc/fastrpc/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Qualcomm FastRPC devices
> +#
> +
> +config QCOM_FASTRPC
> +	tristate "Qualcomm FastRPC"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on RPMSG
> +	select DMA_SHARED_BUFFER
> +	select QCOM_SCM
> +	help
> +	  Provides a communication mechanism that allows for clients to
> +	  make remote method invocations across processor boundary to
> +	  applications DSP processor. Say M if you want to enable this
> +	  module.
> \ No newline at end of file
> diff --git a/drivers/misc/fastrpc/Makefile b/drivers/misc/fastrpc/Makefile
> new file mode 100644
> index 000000000000..77fd2b763b6b
> --- /dev/null
> +++ b/drivers/misc/fastrpc/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc/fastrpc.c
> similarity index 100%
> rename from drivers/misc/fastrpc.c
> rename to drivers/misc/fastrpc/fastrpc.c
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

