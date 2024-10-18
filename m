Return-Path: <linux-kernel+bounces-372390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A809A4800
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FC51C22072
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D420969D;
	Fri, 18 Oct 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3ObxE0D"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC02076DF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283470; cv=none; b=uY2VZvEaCA+0737u8xJiQ8TipRe1lu7hp7OZpu2rjf6gY8YeNcx70bPn0MdFPm6zsQdbGT1zyd/nhgoqsGcWd6knsp2JY4KV2I6ZX2w9LisyQRvEXV20XOHuOAv21L89J8feO1FThDACGNn4sBv7WED54QKf6iQRjtHcPsS5IXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283470; c=relaxed/simple;
	bh=VAGpQGoMLwYnaxnR58InOddbSSysIB3V2F/F27CkgHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGO2jXeQpfIE8+TwyMI8VhIMnyyVCDiS7VSPCS2e22ijTdtaH3govn7EYWSZkJ6Qi1UxTvbFqqnUHR6QW3A3PUbMhbyrF8gVJCUL7IedJZKyy8zR6UR2emph3g0GeVo5HI/BWjO5wHWZd5KWcSsrduRASrRL1PyP/TDByubIs3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F3ObxE0D; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so3053939e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283466; x=1729888266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jx2hyRRdlOA6kXYiQarT6VC7UYyaK1msCgEY9aDz3w=;
        b=F3ObxE0Db4cCywIJ2cGIntZYzgfd1Q9Juv/9G8FAIU+d05VJ8/nDohnFzktzgSLkUf
         axkfRSYXoIlHZtHIWUW0fEOze3DxWnLaKmWNf/Bq7cyDn1QreM7Rc8dAI+0EQR9pUDWo
         m3NXlnPyx+2PlLy8ZIReZ+8jKr6QDhW2SYKbtvh7zCPGtepU4nYVD7stJRdT/y8d3m+A
         yUFvXHjjIXJ33RDmYXxrqbEEKYSwNnrxRkDHgzrx6zSRdcfrXwvDfuhqB0DnjdKdQ25E
         338HgHPO9wpKkpyqPHB8Lakit+Sidt7DudxbxqerSJ2Hw1rhdbtL3UNa6nMTI1GQVF10
         HN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283466; x=1729888266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jx2hyRRdlOA6kXYiQarT6VC7UYyaK1msCgEY9aDz3w=;
        b=GXmpRhNhQfO0vTOgdomMCfsyvoXVuJIBjQHu53lAqfcFiymbPKajKsPPhxpOSVmWBC
         F8GEeyAzLrRot0hljn/kTQtYBmHZk9om1orPwMCi7gevrelKhFfq/VBsD29AjHBXmYAP
         tvaLybSXPz9t2mrL46Y7zJfqxLWmdKtwmPAcz6Obs5fQHOAgQTP78hUwuTSCIYCuMQ7/
         25FZVhBt5e6IoqfmxEYB2EQngYnVZHdynfYiNh8fJHu33fjX8PrzrcMHsqY5dnFqjW15
         laV3vqo5EaREbDhUpj0t3qOIL2s9nvpp5T55HnCd2Nrr0wdrDzFKPz73UiKuRMHeK0cU
         QUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHnBIIRM8/HR/JWvFeVWpJ5vbRwjk+gkHmkms+nbdD1tdr0CLpDenA6hQBKHhEHpalG6J9zPUkckFVf2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZDzCkGesYxdWB5Ur1rr0+gm6IS03d3eL7YWlZmpqiylHy4Fa
	mKCXzxlAUS+kkXQKbb+iQ8osbLjwhbgEF9Cpl7QANd/A2v8+yVDlQq0+Q6F1hcU=
X-Google-Smtp-Source: AGHT+IGoCQfSO2kSUpqzt7NOJ5unR0IVA7V+mIx8HO+lQQgbtXcVwSqrmHwoWbdUWAxVeQxmPVQgbw==
X-Received: by 2002:a05:6512:1285:b0:539:fc75:99c4 with SMTP id 2adb3069b0e04-53a1521968cmr2283622e87.20.1729283465756;
        Fri, 18 Oct 2024 13:31:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e4bsm312018e87.172.2024.10.18.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:31:04 -0700 (PDT)
Date: Fri, 18 Oct 2024 23:31:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Abhishek Sahu <absahu@codeaurora.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/11] clk: qcom: videocc-qcs615: Add QCS615 video clock
 controller driver
Message-ID: <ig4hdtslj3qpu4arke3ejdensc5rs4jti22h3bpduub4uzglrc@gjirgpwgfvi7>
References: <20241019-qcs615-mm-clockcontroller-v1-0-4cfb96d779ae@quicinc.com>
 <20241019-qcs615-mm-clockcontroller-v1-10-4cfb96d779ae@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019-qcs615-mm-clockcontroller-v1-10-4cfb96d779ae@quicinc.com>

On Sat, Oct 19, 2024 at 12:45:46AM +0530, Taniya Das wrote:
> Add support for the video clock controller for video clients to
> be able to request for the clocks on QCS615 platform.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig          |   8 +
>  drivers/clk/qcom/Makefile         |   1 +
>  drivers/clk/qcom/videocc-qcs615.c | 332 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 341 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ed610310699696f92b4a5938635e7b2ab757358c..7ef2037b3b0dd01fec0c6be8b6030ebaab182117 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -494,6 +494,14 @@ config QCS_GPUCC_615
>  	  Say Y if you want to support graphics controller devices and
>  	  functionality such as 3D graphics.
>  
> +config QCS_VIDEOCC_615
> +	tristate "QCS615 Video Clock Controller"
> +	select QCS_GCC_615
> +	help
> +	  Support for the video clock controller on QCS615 devices.
> +	  Say Y if you want to support video devices and functionality such as
> +	  video encode and decode.
> +
>  config SC_CAMCC_7180
>  	tristate "SC7180 Camera Clock Controller"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index a45b6fa28c1d04fd42dcde6e6f22378baa7c8e60..b024e75e49435a3d2f449bbdb9c2cef8e7958eca 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_QCS_DISPCC_615) += dispcc-qcs615.o
>  obj-$(CONFIG_QCS_CAMCC_615) += camcc-qcs615.o
>  obj-$(CONFIG_QCS_GCC_404) += gcc-qcs404.o
>  obj-$(CONFIG_QCS_GPUCC_615) += gpucc-qcs615.o
> +obj-$(CONFIG_QCS_VIDEOCC_615) += videocc-qcs615.o
>  obj-$(CONFIG_QCS_Q6SSTOP_404) += q6sstop-qcs404.o
>  obj-$(CONFIG_QCS_TURING_404) += turingcc-qcs404.o
>  obj-$(CONFIG_QDU_ECPRICC_1000) += ecpricc-qdu1000.o
> diff --git a/drivers/clk/qcom/videocc-qcs615.c b/drivers/clk/qcom/videocc-qcs615.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..cebe1ab591f38ce5cbb527c12b1e997b88d6502d
> --- /dev/null
> +++ b/drivers/clk/qcom/videocc-qcs615.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,qcs615-videocc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	DT_BI_TCXO,
> +	DT_SLEEP_CLK,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_SLEEP_CLK,
> +	P_VIDEO_PLL0_OUT_AUX,
> +	P_VIDEO_PLL0_OUT_AUX2,
> +	P_VIDEO_PLL0_OUT_MAIN,
> +};
> +
> +static const struct pll_vco video_cc_pll0_vco[] = {
> +	{ 500000000, 1000000000, 2 },
> +};
> +
> +/* 600MHz configuration */
> +static struct alpha_pll_config video_pll0_config = {
> +	.l = 0x1F,

lowercase the hex, please. LGTM otherwise.

> +	.alpha_hi = 0x40,
> +	.alpha = 0x00,
> +	.alpha_en_mask = BIT(24),
> +	.vco_val = 0x2 << 20,
> +	.vco_mask = 0x3 << 20,
> +	.main_output_mask = BIT(0),
> +	.config_ctl_val = 0x4001055b,
> +	.test_ctl_hi_val = 0x1,
> +	.test_ctl_hi_mask = 0x1,
> +};
> +

-- 
With best wishes
Dmitry

