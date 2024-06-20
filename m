Return-Path: <linux-kernel+bounces-222813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E099391080D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945E81F21802
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2B1AD9DD;
	Thu, 20 Jun 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMWFSkSZ"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A102E4F211
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893369; cv=none; b=Z+b/sR+hwOL7ygX5BwX55giLx8cYCwyAp6lUJ51xR6lb8LurQDv33Qz/0SovxaWfzLBn8f5F1QbpvdGGZLB2WDwUxnoWVhOfsG8nDS+Fn9etlXoSl4nnScwGudHLvqPa6uIJGVSSB7vov+QQv8hs0B7iEmOjbgV9MRTylJpfVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893369; c=relaxed/simple;
	bh=R5I8MCxc6HrCQZOo49PzevemalXoQruR1e5Ny69+HHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWyRGXMHmL5ASo6EUVIZVPbHdNZVgednP0VbBnSVyUP8nRJhXKRAvPdnmQMAC6uvpVaeEsUsPBnHE4zucdDxs9BeSnPMaxtSYk4umxUbbKT8/VHctN+Pun/Rr3KBctcwTIn21U0lj526dnJBx/QpSaFiO8DKuBmp/Y6Hi7MpiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMWFSkSZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62ce53782f4so8156937b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718893366; x=1719498166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pb2FlnRi8qf9Ze+6GjyEuSI6u+QcvLgXicbUKY1aLM0=;
        b=JMWFSkSZhiR6H0C+ao1dNTq6cAVIfeC6Gqos4OCgGHv78P2A2Z9ErT6W/3xZ2TdlXv
         Yav1+oVwye3jwjLK4IcLCzOhTljVeF6N0O25CMex2CYMnYQkCmSoDoOYhdBkc1S2FKHv
         4yjsoeCK7QVb9KA2lSBcBmevIoEzm7WeGVyZW7dDYV4GoW1ydYF2TCQQNBdDYutMR4NM
         dvGiVc/bpPABa21GjjBjJeeSoqOj73TVETUMq0YPjMKbyxc2zTI5JYQeWE/Gr3uAR7k8
         UWQ+9YKztq2iqXdJaEog9/v4w8xZBYbcpFyVwYsvVj/eO7yxIVAEtzFnGzxjMi4vDaHu
         uL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893366; x=1719498166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb2FlnRi8qf9Ze+6GjyEuSI6u+QcvLgXicbUKY1aLM0=;
        b=J2Lz/2yyGAHaCQs0dwsyt7NHSE9vUyxzMNCtmK7ubU8UEeU8NBXrrI5u4pFmAe1v4s
         D4MLsRnyOEwMN3eth57eIR3a0PDna0aH4jP5ZfiV1RmB8p7YSCNMjWsu/S2rVtdhT6Al
         G86uaH5vpOpde//n27UCIz3gRKvIIA0XB3HVUG6SHvYW9LPvNTEoEpwztS5+HIluqjV1
         ZHxxuTQA8TjIJNw/LUUGGovkrsr4C6XFGpInngfRbtaurjxFOXjoktd6kgzmqsReERi1
         W4q2VbyHFKuSDWdTkXXOMJYKjBJAFPc/oBIKMPlB/FaBBIA+GcPyalHlLJAnuNjSpQ26
         icKw==
X-Forwarded-Encrypted: i=1; AJvYcCUoknKHeApOs2VPcQSmZxvM+rIOBjp3hBLhQlpCcYNCSKD2fNsLwTTbnkK2G/s2OIoKJ2rq08SFK5PoZ9D8FyuR7IBQOJXJ6HwEv8hb
X-Gm-Message-State: AOJu0Yzvtp/GCoXPyJtdcxQDjranjEpfq9lVU4xHOMjwG5wdXBJN1VDo
	PY5IX8OFLqDS47vxnkFwkKbwhLvM/7IEbAhanEkJOwBox4/QQVni4fAlhBrzXdfRimYQfAhyQcr
	dZY0nmneOC6F/iVjWOAewlhiKtktwOWT0OwhnDUPF8csqfr45
X-Google-Smtp-Source: AGHT+IEeEQ+wBPet0NG1PUeZIgHWiVCS8wkCOBp21eaOWmXAAk8Ryjep4aUjBcCsRpOAEVGWt4sGzL19OJEg52KNsdo=
X-Received: by 2002:a25:6942:0:b0:dfa:fed0:caee with SMTP id
 3f1490d57ef6-e02be176f4fmr6442103276.39.1718893366575; Thu, 20 Jun 2024
 07:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718213918.git.limings@nvidia.com> <2c459196c6867e325f9386ec0559efea464cfdd6.1718213918.git.limings@nvidia.com>
In-Reply-To: <2c459196c6867e325f9386ec0559efea464cfdd6.1718213918.git.limings@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 16:22:10 +0200
Message-ID: <CAPDyKFqXZ3JdQBMpTM1ccAFqUSsqUcZ2fn+Ste2aG-APS2dt2w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dw_mmc-bluefield: add hw_reset() support
To: Liming Sun <limings@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, David Thompson <davthompson@nvidia.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 00:53, Liming Sun <limings@nvidia.com> wrote:
>
> The eMMC RST_N register is implemented as secure register on
> BlueField SoC and controlled by ATF. This commit sends SMC call
> to ATF for the eMMC HW reset.

Just to make sure I get this correctly. Asserting the eMMC reset line
is managed through a secure register? Or is this about resetting the
eMMC controller?

No matter what, it looks to me that it should be implemented as a
reset provider.

Kind regards
Uffe

>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
>  drivers/mmc/host/dw_mmc-bluefield.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> index 4747e5698f48..24e0b604b405 100644
> --- a/drivers/mmc/host/dw_mmc-bluefield.c
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2018 Mellanox Technologies.
>   */
>
> +#include <linux/arm-smccc.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/mmc/host.h>
> @@ -20,6 +21,9 @@
>  #define BLUEFIELD_UHS_REG_EXT_SAMPLE   2
>  #define BLUEFIELD_UHS_REG_EXT_DRIVE    4
>
> +/* SMC call for RST_N */
> +#define BLUEFIELD_SMC_SET_EMMC_RST_N   0x82000007
> +
>  static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>         u32 reg;
> @@ -34,8 +38,20 @@ static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>         mci_writel(host, UHS_REG_EXT, reg);
>  }
>
> +static void dw_mci_bluefield_hw_reset(struct dw_mci *host)
> +{
> +               struct arm_smccc_res res = { 0 };
> +
> +               arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0,
> +                             &res);
> +
> +               if (res.a0)
> +                       pr_err("RST_N failed.\n");
> +}
> +
>  static const struct dw_mci_drv_data bluefield_drv_data = {
> -       .set_ios                = dw_mci_bluefield_set_ios
> +       .set_ios                = dw_mci_bluefield_set_ios,
> +       .hw_reset               = dw_mci_bluefield_hw_reset
>  };
>
>  static const struct of_device_id dw_mci_bluefield_match[] = {
> --
> 2.30.1
>

