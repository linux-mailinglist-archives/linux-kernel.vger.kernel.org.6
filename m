Return-Path: <linux-kernel+bounces-232118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54391A3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7450E283EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80313D8A2;
	Thu, 27 Jun 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ag5L9Z+I"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081C17F3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484120; cv=none; b=bUfoLrFWoNKG1x92Cvnl5lbRbfKuv6KcGA+IZ+Tl2RKrb/P/w0li1DanojAdsAaxB4ccjcxVKWEy9OiAFQLSLLNgashB684Kt8CzfcTz/SJXw0s0TlF4s0cT0yVYWB2ybA4LZbR+sZg6LpvEvtkVTfY5xREoFZ7VzaoyM0DHItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484120; c=relaxed/simple;
	bh=BRoEnDNLMGfgwmz/D3lIxdbFxaFE0Rva7NuUJrNHIUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOBsCwl8PZmYMhr2B3cEzDuGa9c4keFEE/2sCKG1grT3Ek7tSKniIgisAUP15RezmyQNYpStp+QZOIiAB9yVseoDENwpXGHsBAU96ZGRu04CsH10TVsdUJj+tjJ2i5DCQv+m7OZu340zAv8ZIXQjl6fLYCYMBJUpPKandjDugCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ag5L9Z+I; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cdb9526e2so1517294e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719484117; x=1720088917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CSObqPp2o1ZiYQ9QL2aHPTL2pT8TeTrCT9cgEet+VS0=;
        b=Ag5L9Z+I592aqHXctVkLrZJ9h/DUblkid9UEZiBEVmJQ+7sj5l3j87WUN0V9Bm1AyJ
         vYiYKaDUGHKBQmTusJ5o7C7/teErxYAIm5R43Z0fcwJHo5gtBTLnLCN7t0dHEMg0Xd1Z
         cdOWFBXhCwpnS4lR64bJ8MnIYnL5RdSw3F7Bfb7yLOCuNbMqhHk+jGsIi+X/g3kiCM2X
         wqSEZ4tStZQa4g8pCfOIJW74wkcJHtgvsIpd/2kFqxjz6GwDciKLzlHccMr2c8TAN7fj
         Sr6/VNfBZAzmP/fbxhGRKDZIto1yYRGQCYBNT5//fXTNqvrXmygrrnWM+4E6d1nbJuBF
         6SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484117; x=1720088917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSObqPp2o1ZiYQ9QL2aHPTL2pT8TeTrCT9cgEet+VS0=;
        b=JSKDAeGt+GGJAx54uZaUcP+7bpL4lJ2ZZnzWgRLXNK1WgLRqMzy+HbqHE5k82/rYHQ
         PQqLr93YJF8sgq4Kg3pikAaMbRhCWeNcs/876zAhGGEwKWo24n2InoGUiHrS1PReWj9Z
         tdhfCgsm0muZgzccJ9BjVCPmDDLFonPwgDecw3+RvKLGI4Eq8yqInyNw/2wYlIW+boVI
         jtWHOtjxWrFG5PKg0nauBHq7PYshutHbMJ+qVY6tTJW9Bmkauf25gnDDYdb27+nRlkaV
         HIjsd8D0OFQnmhFVO2xfFVAzgpWEQQiTr5/zbMKWRJD3OVtJ/f+PXqggeiw1UFVNz3Yy
         /EIw==
X-Forwarded-Encrypted: i=1; AJvYcCWeQf5X36vTzauIQeIWZ6yXlfgL09MRR1BmsVN6ahxE6gszEsubQzPAe+ksVE3U/MVF5Kb7KYmPN6IiCkeuEXIniBGqSyEUszIAWOqx
X-Gm-Message-State: AOJu0YzPRD/Arm1RMO+OrTlDfPlV4BF6p+sRTRWrn+/91H8I9pb8SuQ8
	91kACCM+W36xJ+wFpFv5tuwYWii/cdLgccwtZmS1JyuRqyc2dkGswSgyiQRqfVE=
X-Google-Smtp-Source: AGHT+IFKQsbMqpoVnTPZEnzGX8hY6FDAKEvfJirsH2ST3SdWpnd2QjBxD18elzS2fRWAkQeb/uWTSQ==
X-Received: by 2002:a05:6512:158b:b0:52c:dbdd:92e with SMTP id 2adb3069b0e04-52e703a40cbmr471883e87.26.1719484115347;
        Thu, 27 Jun 2024 03:28:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e71305ebbsm154630e87.126.2024.06.27.03.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:28:34 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:28:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v2] misc: fastrpc: Move fastrpc driver to misc/fastrpc/
Message-ID: <jxfdfponl5eo42imhsut7rckqafolnqooifpn77fgsn26elkwi@rsvxfjzvkjxp>
References: <20240627084628.1590453-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627084628.1590453-1-quic_ekangupt@quicinc.com>

On Thu, Jun 27, 2024 at 02:16:27PM GMT, Ekansh Gupta wrote:
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
> Changes in v2:
>   - Updated Kconfig.
> 
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

> diff --git a/drivers/misc/fastrpc/Kconfig b/drivers/misc/fastrpc/Kconfig
> new file mode 100644
> index 000000000000..7179a44eda84
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
> +	  Provides a communication mechanism that facilitate high-speed
> +	  Remote Procedure Call (RPC) mechanisms between the host CPU and
> +	  offload processors Qualcomm Digital Signal Processors (DSPs).
> +	  Say M if you want to enable this module.
> \ No newline at end of file

Nit: ^^

Nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

