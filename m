Return-Path: <linux-kernel+bounces-367803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083E9A070A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58C828978C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CBC207A16;
	Wed, 16 Oct 2024 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2G/BbQF"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB3207A13
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074073; cv=none; b=eCNlDK2AE2Yfhe5unbsVyJV23QdLAhyhhDAFh2KOeA+W9BkCGiKEoJsM2WpDjxeUCLJiYI5ajBhhtFGcQW0o7TVOq6eYxe1pr5sLy4np3Ayoc/xrxGGsrxsMPadHvHuCQFt2v32VvKt08u4y3EpSp7xznFTqx+UTabQIT5fWP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074073; c=relaxed/simple;
	bh=+vjxN3bVpSF0tBOfRjKZ6xoE3GHMSenDIePKfHckiZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9EWyPpBi6stGjY12o/G8j72WrDorejlWhrAKm2NxQ9RU/AQrlM1q3oUaLyRHHgPamq6MVD2Atjp2o34Aug5WOlRhF2/S5+yO3pqkIBYC4ghiJi0P6lteuMA93cbf8An4SqAXyT+vwbMPdMvgFBbwuGuMs5mk3apb9KyacdpOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f2G/BbQF; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso4042795e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729074070; x=1729678870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLdut8E3E3NtKT42b9sOuPXdXDsonyxQjz/a9BL8yAE=;
        b=f2G/BbQFpmBXJBbkDNZNNXk6xlbfgCDEpT+bXHf5tDm9aY7/5X/+xwlC9VE/rTSTjG
         VyZKPloBJecLWl29tdZiahgcRhi+4xQQ0uYocJ574gsrtgTbQinTQqFKJAujp0Uw+YJo
         6ImkbHoGzYhwBLAZNh//Ksw8af9+Bcovm7vu2Yg+HXHWSwOKppg42UY9EXMlva+RrOWe
         mHIAO5wdxDvM2HYqEFwF6wxS71TuZhLZ3lzhy6lAkSsO4BIPjGVXJT+YFqaIDo7q+Ea1
         ljf4hAmAVTZNn0I7NGI1vid4IiE2Sta7WYMYXgQIN/QK/IW2s07WCGMslg4UHEH3cSJY
         H9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729074070; x=1729678870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLdut8E3E3NtKT42b9sOuPXdXDsonyxQjz/a9BL8yAE=;
        b=MWo8SVbXquR1S0tAYtAElUCat4NQIwbRO3bpVYKiRGl+sE6/Mev/HlLZS8PAj7tyWB
         imtZti3apICl7id92fuKDWl+x+pvweF7Rs1HYHve2LqGRlTY4Cd9w6exf4GROgo5zZ3S
         +1II5ThiMf0tMGgGR2gGwYvwxSHcbvyiO+NSGnn3Ef/vC7J9ATajpKwno9GNxmqqpJeg
         rdUOZd4YwMx8HJRYm3sM5fN4XcjX/eii8js/lloUKoPk3N7vbMUZyMKuvSbBTVrg/UHH
         jmaiWNh/kxo5b0AEGwlwWkPBzSMnxtE7bVZ5eMtoK2wveTDc/dYUi2TL91IJk2kLLq2/
         7vHA==
X-Forwarded-Encrypted: i=1; AJvYcCUScH+z5Kcb7Tix9TzhhGB/4dapvbDPgoinMVBeeMWyrxF5UST//xvuBG20jB6h9xdjrRcn6c20VtQvVMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIGzB2I9BGh2/dGuX8cbTBBBHd05VyxghxGstzKgdB75qBfko
	Q6t46AvxFdnLUPPO17gxZOUE4V5rXPb5QMdCNcMZg6Vg94VJe+hN2bheADVhQ8U=
X-Google-Smtp-Source: AGHT+IHfqISBcwOLeSQZDV2YK8lfIG4NYRGTSreBdpNCo7LHjqixn5TrNwC4CIw/gihbpSQ4m5WEBw==
X-Received: by 2002:a05:6512:3d23:b0:536:7b74:ef50 with SMTP id 2adb3069b0e04-539e54e81c1mr7747993e87.18.1729074069649;
        Wed, 16 Oct 2024 03:21:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539ffff366esm407072e87.168.2024.10.16.03.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:21:09 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:21:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/4] Add GCC and RPMH clock controller for QCS615 SoC
Message-ID: <6y6bb3vbxaffmaakxv6m4l652rinbbhtzyekxeupdfdvtqooil@e5bjlq7rh2y7>
References: <20241016-qcs615-clock-driver-v3-0-bb5d4135db45@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-qcs615-clock-driver-v3-0-bb5d4135db45@quicinc.com>

On Wed, Oct 16, 2024 at 10:59:42AM +0530, Taniya Das wrote:
> Add support for Global clock controller(GCC) and the RPMH clock
> controller for the Qualcomm QCS615 SoC.
> 
> The QCS615 SoC is added as part of the below series.
> https://lore.kernel.org/all/20240913-add_initial_support_for_qcs615-v2-0-9236223e7dab@quicinc.com/
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> 
> Changes in v3:
> - Update the gcc_pcie_0_aux_clk_src to use clk_rcg2_shared_ops. [Dmitry]

Please don't send the next iteration unless all the comments are resolved.
Sending your reply to the ML and sending next version at the same time
isn't really a good way to work.

> - Remove an extra line [Dmitry]
> - Link to v2: https://lore.kernel.org/lkml/20240920-qcs615-clock-driver-v2-0-2f6de44eb2aa@quicinc.com
> 
> ---
> Changes in v2:
> - Update the compatible in alphabetical order for RPMHCC bindings and driver.
> - Remove the extra ":" from the GCC bindings.
> - Update the GCC Kconfig for some required configs and move the GCC init
>   from module to subsys_initcall().
> - Link to v1: https://lore.kernel.org/r/20240919-qcs615-clock-driver-v1-0-51c0cc92e3a2@quicinc.com
> 
> ---
> Taniya Das (4):
>       dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings for QCS615
>       clk: qcom: rpmhcc: Add support for QCS615 Clocks
>       dt-bindings: clock: qcom: Add QCS615 GCC clocks
>       clk: qcom: gcc: Add support for QCS615 GCC clocks
> 
>  .../devicetree/bindings/clock/qcom,qcs615-gcc.yaml |   59 +
>  .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
>  drivers/clk/qcom/Kconfig                           |    9 +
>  drivers/clk/qcom/Makefile                          |    1 +
>  drivers/clk/qcom/clk-rpmh.c                        |   19 +
>  drivers/clk/qcom/gcc-qcs615.c                      | 3034 ++++++++++++++++++++
>  include/dt-bindings/clock/qcom,qcs615-gcc.h        |  211 ++
>  7 files changed, 3334 insertions(+)
> ---
> base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
> change-id: 20240919-qcs615-clock-driver-d74abed69854
> 
> Best regards,
> -- 
> Taniya Das <quic_tdas@quicinc.com>
> 

-- 
With best wishes
Dmitry

