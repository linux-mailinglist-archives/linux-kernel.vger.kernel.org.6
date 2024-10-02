Return-Path: <linux-kernel+bounces-348397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FD98E721
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8B31F24726
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37B21A7073;
	Wed,  2 Oct 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMl9BPx6"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE691A4AB3
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912211; cv=none; b=WFvuzP62XNyDO9ZS1XguNh4hIkCX033crGKqiyJi1zRWJ3PCN3kXYHTxLzC6uefuIY6jd79+MUpt+Doexv5p24KeqADAj8VUsINPENgTrCQXtveaa9pUxx9FyxyE8ErUBJ8R4YbA407ItU4MxfEqhtb7ZLP/DLsypjGf1P0E9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912211; c=relaxed/simple;
	bh=Cy8jm79kKyoeyBVmUKmg0vqDck5145Jib7RrRvUb+lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTQtbzF/uQ2tq0da1Bu4XwqnIb4vrBhRbLhwgBkASoB4ypkGHj0j1LI7Lg4JPDYi2K8QP5+htKwYPS/YDe/8RYjdw27jpHH4Uva9OnMaZUBvPVTuZMVVJVVvUrVmUhAG/rSDXKHYf72uF1carDBwonlCTsJcAYlL/enyhWE2pTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMl9BPx6; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e25d405f238so338634276.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912209; x=1728517009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cMmIsSIqxw2lLS9EL8ZWnjAaMUTml/AJZkW1/YN3TRU=;
        b=eMl9BPx6vc+8IxQsqM4UNx5ILpoyiwDcvbE8EFtgE1aUdHnYXE7ZyGtqeYL3lrNqBA
         RlGVZgFIeDCRnworsENO4/3sgeBVlvI0kF2/kldXfvs8DrRLw8MBy+UyRIe9Mr6uH85i
         +zW2KolE0oZ0+dCSwKzRa4UgJX6P0btIQyzlcZ6jIM/bf4ABlnerIS5pQuQPEysSyCj5
         z/3wwVjWmZs1kIqHSRbT/JYJORGGCCgPjM5Sn7zst9khTLk9yz67sWycv9g4/YMbEWKV
         DA5hiqVoxSkzLu7jUB7FDCXBbNii8dSwKx1l0KlDi6q/uTVytvycjut3QEfA/lofO5IE
         GfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912209; x=1728517009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMmIsSIqxw2lLS9EL8ZWnjAaMUTml/AJZkW1/YN3TRU=;
        b=nS/F2yf8vKfxc7oF0WENKRR/jQewYlZIO0c6SVmr6IWBmajBOhjaakVEc5YexcB4Cl
         Ey6Ad7eJrNBVXX5ji+EoKS2om1k/NZVmUXvTnKNjNqjqluqdbBfeplnpmbk6DQhTxwdt
         Hx1r47ldgyKezeBzszVAqytH+CDBMkgFxeGF9omAcSjvGw9/Uq0YwUKx1XylpT/kH/Wr
         9+wQ8lB6EmZBlJSlxHuEKBmwLduhNFLcr9cUkXtXa2J4xF78A3wy/iJeMyNdodI0BSFy
         +t7ohGrEzd6suuHfTM/sSsLM/Dk5Qh2OKTOp+KEfSzxcnMUiJqbjFQ+/8f29pv8lH5uW
         CDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUeV6QxiAzCqVucxYnQRc9L5IZvbykEg2UcnUEbMmXXefgJQmTq7eSC0R5EMMMI4RYiczn5kLuj6NpPwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dMuL4IGs31aytfr3k/oOt9YoUzCdXw9usPAKXvMgKKunu6a5
	iDfEaNMevqzmonO8hZiaEMaJPQih2QGenE4cTfwM4UjaB5Zw1jX3uiPCC0milUKw42yC02jEgLP
	rXjv4Iw/O795++DDauBdTVzrDbdqCPWv2KscFMQ==
X-Google-Smtp-Source: AGHT+IEtfDZUzgk/RKfYheURMvQhUbLGY40ln0Wzu7T/i625eC/l0Cs8uWSg5Wr0L3A5nhmvt0c8ctP6sFH0lfC4icc=
X-Received: by 2002:a05:6902:2389:b0:e25:cfc9:489d with SMTP id
 3f1490d57ef6-e263840ca01mr3890390276.34.1727912208827; Wed, 02 Oct 2024
 16:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923062016.1165868-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240923062016.1165868-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:36:13 +0200
Message-ID: <CAPDyKFraZUQu0hawOK1owNNNjA3WD0Nhq9_zwvcYzGy0rN+nsA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-mmc@vger.kernel.org, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 08:11, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Enable SDHCI_QUIRK_NO_LED for i.MX7ULP, i.MX8MM, i.MX8QXP and
> i.MXRT1050. Even there is LCTL register bit, there is no IOMUX PAD
> for it. So there is no sense to enable LED for SDHCI for these SoCs.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 8f0bc6dca2b0..ef3a44f2dff1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -238,6 +238,7 @@ struct esdhc_platform_data {
>
>  struct esdhc_soc_data {
>         u32 flags;
> +       u32 quirks;
>  };
>
>  static const struct esdhc_soc_data esdhc_imx25_data = {
> @@ -309,10 +310,12 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>                         | ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>  static struct esdhc_soc_data usdhc_imxrt1050_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>
>  static struct esdhc_soc_data usdhc_imx8qxp_data = {
> @@ -321,6 +324,7 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
>                         | ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE
>                         | ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>
>  static struct esdhc_soc_data usdhc_imx8mm_data = {
> @@ -328,6 +332,7 @@ static struct esdhc_soc_data usdhc_imx8mm_data = {
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>                         | ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>
>  struct pltfm_imx_data {
> @@ -1687,6 +1692,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>
>         imx_data->socdata = device_get_match_data(&pdev->dev);
>
> +       host->quirks |= imx_data->socdata->quirks;
>         if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
>                 cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
>
> --
> 2.37.1
>

