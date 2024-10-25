Return-Path: <linux-kernel+bounces-381914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7969B063B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B48C283A88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C7165EE8;
	Fri, 25 Oct 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSwnIInW"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFE15DBC1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867924; cv=none; b=FeBaEMbzk8IHXLMC6mE3zvLfw+nstSX8/XmpkJutJEZEK2GOwSI6nZZnJCwoFFE9U0ot1o0UZeGa3MprmQDSa42+rr7p+VsXiq7NaQ6zHWrM8/ZMJGRjAKG0x/1zVsM4QcN4UBCgW2zFLeGDs5FtsOCeh9Oe6FSwExT8IFB2cZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867924; c=relaxed/simple;
	bh=Tpjg+FtmDNYW3Q3q2EP2J57WPEMbN0cjGpOXFFJF6SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUo07sQ1KjZsbFV87bd65z/Lz8jyXIsCJ6LSur3jWDjq939Wyfr1LzFi3KXlMJ49StLPmHziaCoR93Da9KvSLjtNeLjJSM6wjyjVPHuw1Za/PUQGho4Bp3zohiRvsEzso70wC2hJuBJjt9Ow6fWRXxb6O2FiAugg8cPeBiYsLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rSwnIInW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f6e1f756so2541624e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729867920; x=1730472720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OdmEA9Pt4hPLy+Gk+oZV9nXry2EKovQw8Q5PC4Q8Ego=;
        b=rSwnIInWDQYhqTvfhe+12UleYzdiG00AXvbaKSi0vs/2IqkGsv8bpUJRcrWqwDJ1Ax
         fwHX5mskXDR/BtbdGg/6LhvxFNlfXTPmNSwrHO2GB91st18r9SVXQ69A7Ks0U4c7+/P6
         pnBBd+ucO4ZBEBxsNaH3kKKyJcEv39AgauoIS3wnwamx2g1YeYUeMZrVCCHIwRMqJxju
         TA/vyn+B5vBiub0GbeU4wEcJiEPr/E/h+OgihrivUl2Bm+ugOm1YmUWSc6nUlIMmnPNX
         U52d61ztjWN5Au5XSg9Gni2LTwb/3ExTUuXHatzN9SnhU6Y8WjcMu24mEQ2xZIpQuM0u
         Xvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867920; x=1730472720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdmEA9Pt4hPLy+Gk+oZV9nXry2EKovQw8Q5PC4Q8Ego=;
        b=KRUEKVgIiTFkD1R3N1n3s0u/5yI5mShzz8Khe2hICWOwCPtMAf1Vkyz1TUFBcrrV31
         JpaVD1fFq9ETHbvow8HdpICKcw/hVcNLnTxL7hLxAfJI/6XBFd1MBKk9lfVLufVXeYBa
         PvBJRq/bALPiI7PM2iOLYzmR7SmC+AcucXaMmDMbvsjmPCBP1qvcFWSPSzeAN6gfNTHx
         wAX8Cjl2LFUB9k5Tx0C2a+LIBc0Ou2rjvslYmxauxmE7UdzKWYPE2xyya3RHMShPLmt7
         44OuxfYSv5yaGldZgpAC7GmI5RuPvRSBKahs838ahxvJqt4CmL7e2/u3dn20ozVlVNfW
         Ze4w==
X-Forwarded-Encrypted: i=1; AJvYcCXlkdI+TgDxtHs9bChNXElZ2foDiAABTQ1YU/nHT/DXlRq4UQfa70IjutPYyYly1+YQmpZCXjLdn97fHd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8/YZ5GnWpkTA808gNHjq8/wFSXuZkRELFpujeHVPq5Mm1hQE
	amgNOEppgAuBpmJVj4k4NDNQArCAeK+2RdzddPPImfZGZhd5BX3Ub0M2lKpScaC7/fzQUA9wZKU
	mEbl/V/JTFJoBOj2MqZtcQFpVloAjGzDKUbvSAkjkN9nQ9Zko
X-Google-Smtp-Source: AGHT+IGiLD1WiZTLuiIZWdX2d+oO+C5IkrqpeWeNws8Zj1oDVnmqxSUDpqiWwUI2EKDDCtTCFDT0JOMntdwiI2CJd08=
X-Received: by 2002:a05:6512:e8c:b0:539:eb82:d45b with SMTP id
 2adb3069b0e04-53b23ea0214mr3822976e87.56.1729867919707; Fri, 25 Oct 2024
 07:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017131957.1171323-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20241017131957.1171323-1-catalin.popescu@leica-geosystems.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 16:51:19 +0200
Message-ID: <CAPDyKFoZRc1K1EqY2+1UJft9vE5VsKRKv4xBPu_F6sANOUXOCQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: pwrseq_simple: add support for one reset control
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, m.felsch@pengutronix.de, 
	bsp-development.geo@leica-geosystems.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 15:20, Catalin Popescu
<catalin.popescu@leica-geosystems.com> wrote:
>
> Reset controls being refcounted, they allow to share gpios across
> drivers. Right now, reset framework and reset-gpio driver supports only
> one reset gpio, so add support for one single reset control. If more
> than one reset gpio is configured in the device tree, then fallback to
> classic gpio control.
>
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
>  - drop DT bindings patch
>  - use reset control with 1 reset gpio and fallback to gpio with
>    multiple reset gpios
> ---
>  drivers/mmc/core/pwrseq_simple.c | 44 +++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 9e016b0746f5..24e4e63a5dc8 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -17,6 +17,8 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
>  #include <linux/property.h>
> +#include <linux/of.h>
> +#include <linux/reset.h>
>
>  #include <linux/mmc/host.h>
>
> @@ -29,6 +31,8 @@ struct mmc_pwrseq_simple {
>         u32 power_off_delay_us;
>         struct clk *ext_clk;
>         struct gpio_descs *reset_gpios;
> +       struct reset_control *reset_ctrl;
> +       bool use_reset;
>  };
>
>  #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
> @@ -67,14 +71,21 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
>                 pwrseq->clk_enabled = true;
>         }
>
> -       mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
> +       if (pwrseq->use_reset) {
> +               reset_control_deassert(pwrseq->reset_ctrl);
> +               reset_control_assert(pwrseq->reset_ctrl);
> +       } else
> +               mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
>  }
>
>  static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
>  {
>         struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
>
> -       mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
> +       if (pwrseq->use_reset)
> +               reset_control_deassert(pwrseq->reset_ctrl);
> +       else
> +               mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
>
>         if (pwrseq->post_power_on_delay_ms)
>                 msleep(pwrseq->post_power_on_delay_ms);
> @@ -84,7 +95,10 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
>  {
>         struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
>
> -       mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
> +       if (pwrseq->use_reset)
> +               reset_control_assert(pwrseq->reset_ctrl);
> +       else
> +               mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
>
>         if (pwrseq->power_off_delay_us)
>                 usleep_range(pwrseq->power_off_delay_us,
> @@ -112,6 +126,7 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
>  {
>         struct mmc_pwrseq_simple *pwrseq;
>         struct device *dev = &pdev->dev;
> +       int ngpio;
>
>         pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
>         if (!pwrseq)
> @@ -121,12 +136,23 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
>         if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
>                 return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock not ready\n");
>
> -       pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
> -                                                       GPIOD_OUT_HIGH);
> -       if (IS_ERR(pwrseq->reset_gpios) &&
> -           PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
> -           PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
> -               return dev_err_probe(dev, PTR_ERR(pwrseq->reset_gpios), "reset GPIOs not ready\n");
> +       ngpio = of_count_phandle_with_args(dev->of_node, "reset-gpios", "#gpio-cells");
> +       if (ngpio == 1)
> +               pwrseq->use_reset = true;
> +
> +       if (pwrseq->use_reset) {
> +               pwrseq->reset_ctrl = devm_reset_control_get_optional_shared(dev, NULL);
> +               if (IS_ERR(pwrseq->reset_ctrl))
> +                       return dev_err_probe(dev, PTR_ERR(pwrseq->reset_ctrl),
> +                                            "reset control not ready\n");
> +       } else {
> +               pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
> +               if (IS_ERR(pwrseq->reset_gpios) &&
> +                   PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
> +                   PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
> +                       return dev_err_probe(dev, PTR_ERR(pwrseq->reset_gpios),
> +                                            "reset GPIOs not ready\n");
> +               }
>         }
>
>         device_property_read_u32(dev, "post-power-on-delay-ms",
>
> base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
> prerequisite-patch-id: 0000000000000000000000000000000000000000
> --
> 2.34.1
>

