Return-Path: <linux-kernel+bounces-369812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE89A231A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0086284D18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCF71DE4E6;
	Thu, 17 Oct 2024 13:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEw5DLXG"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDAF1DE3AB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170483; cv=none; b=iEgnsjKK1Wd8dc9/FmkanEioRJD+nhbtjXoSv9KrOa4iDm+Xn0hLHdpFspdQFzNCRq1+IOVmqDXJZdTlM6c9nbmvx30R3qk9E+83yL0ydR7zFHtKqPvEVo578al8dj1+wu2pMnqvulK2CE7zvQZebZueZ+wFpWjqGkd/UQbopqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170483; c=relaxed/simple;
	bh=c0bfB1CKojeKX92hRJPTg5p5/+lQ8IefKxOSkHcyjO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5o25H0xvZYAqWqWwAbEg4Sqx3nLB9PqEN21bdd9FhovdRFfpElwI3kD60hGj02a800rYx+G3Ay4oG6onR+p4HA/w1VrcQkkDHx3tFo42Xk8VHVoKU6cZLQ6Vh4Mjej2U+rivqGBnkR+9nL1cH8Ui9VOx0QidCIoBW7V/O3HB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qEw5DLXG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e396a69062so9186837b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729170478; x=1729775278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZazD9r+QSLhnAO9QyZ44wGVSQLeXIw2HIXMUQofmO6w=;
        b=qEw5DLXGznRdbFqkSd1ii9xqzJaKiG0n4TIn7Lf0XvMDHHQxWs6Fsp4+3HI8kP1l8H
         MTg2LT1Zr6Izvtx/U+GyGUOJuYNwVSJa/pxCqT20JL8e0mbHSJDAsCFiegMyAiWdotgk
         I6OzWank3tVFYzfyi1ma8wV+7b7qm0x4Fs+azVruIc5mKa21vIatjyFmGbEcW28Stdm2
         rOhwhapUY/K9pq85vz9OR8c3ejTbA2GmpK7z/AiGR5REsi0RCdzU7MrF+pTfz/Mwr9Xk
         zC/3JSnwQY7TeVlPeFO/zDCZ4ghgoYIAQknI1nXA9dlp+nhZe+8IY2NZ3n4eW+2ZUW7I
         Xu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729170478; x=1729775278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZazD9r+QSLhnAO9QyZ44wGVSQLeXIw2HIXMUQofmO6w=;
        b=Du13dBp30x8Vl8Odb8mPK7UNrGMj77IJJWZOFUlnarFzzDIAjFdY26pXwzUItTpQxT
         3ANmsjr4+3l4p2mkCSi4NFbWkHjVnF375JTiVR57P16Djif4Pr+WTElhN3oqUKFcr9tt
         HAxc77XMkClA/owCGd4yZPIk3kBOlhmSsAPLupeHRVPho1kpIyq7EJge++vO1CG+sF6b
         H5/7Eiwxegsvok4KI0l4h3bQoD/u4RkC14lf/zj4VXYufUb1Z2CSqpq6NdWs88RG5LL9
         ZgbC2tCrarE990QKcjK7zFIs6PW/VkbAaUZVWfnk8XALa9BvDXzVocIrp3fE3D+2WF5+
         VO/w==
X-Forwarded-Encrypted: i=1; AJvYcCXq0GPxngpcjpEaFCDCHbCyLCCJzPj/5jNyVEUfEySJoZMYCJIViDxx0mYHjb0TcUpMVd2m6P7gOo3WCpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7qAtvtdSSYTbzEC/rxgRnB2MAAVB6VYqxZOTXkD8Y6vLdmtZ6
	Dx3ay5BeixcO3vJRUBSIoKFHiRITwPb2r752FW8P+ylJIeOBLu1DS+ZD2HGYxJlMgqioCMf0D/3
	GiPZRon5dJlotAi2AYRqAgwZp58oUW59zvm8RynCNNiop4oKjgrs=
X-Google-Smtp-Source: AGHT+IFD/gjUzQbbNJWQ5oL5BN76j/UHFd9jGMXlet0DrOEnAF5gNXy8XvWpGdFQ9Exj+PRU+DXn5f1++kiRqKhMIr0=
X-Received: by 2002:a05:690c:389:b0:64b:5cc7:bcbc with SMTP id
 00721157ae682-6e347c48627mr218937157b3.32.1729170478430; Thu, 17 Oct 2024
 06:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014060130.1162629-1-haibo.chen@nxp.com> <20241014060130.1162629-3-haibo.chen@nxp.com>
In-Reply-To: <20241014060130.1162629-3-haibo.chen@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 17 Oct 2024 15:07:22 +0200
Message-ID: <CAPDyKFr37wLYxdFJ-Lgbq7PbWyiQz+CuwMxwgeeP3QpMvdyjqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: host: sdhci-esdhc-imx: refactor the system PM logic
To: haibo.chen@nxp.com
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, s32@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 08:00, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Current suspend/resume logic has one issue. in suspend, will config
> register when call sdhci_suspend_host(), but at this time, can't
> guarantee host in runtime resume state. if not, the per clock is gate
> off, access register will hung.
>
> Now use pm_runtime_force_suspend/resume() in NOIRQ_SYSTEM_SLEEP_PM,
> add in NOIRQ stage can cover SDIO wakeup feature, because in interrupt
> handler, there is register access, need the per clock on.
>
> In sdhci_esdhc_suspend/sdhci_esdhc_resume, remove sdhci_suspend_host()
> and sdhci_resume_host(), all are handled in runtime PM callbacks except
> the wakeup irq setting.
>
> Remove pinctrl_pm_select_default_state() in sdhci_esdhc_resume, because
> pm_runtime_force_resume() already config the pinctrl state according to
> ios timing, and here config the default pinctrl state again is wrong for
> SDIO3.0 device if it keep power in suspend.

I had a look at the code - and yes, there are certainly several
problems with PM support in this driver.

>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 39 +++++++++++++++---------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c7582ad45123..18febfeb60cf 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1871,11 +1871,13 @@ static int sdhci_esdhc_suspend(struct device *dev)
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> -       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> -               ret = cqhci_suspend(host->mmc);
> -               if (ret)
> -                       return ret;
> -       }
> +       /*
> +        * Switch to runtime resume for two reasons:
> +        * 1, there is register access, so need to make sure gate on ipg clock.

You are right that we need to call pm_runtime_get_sync() for this reason.

However, the real question is rather; Under what circumstances do we
really need to make a register access beyond this point?

If the device is already runtime suspended, I am sure we could just
leave it in that state without having to touch any of its registers.

As I understand it, there are mainly two reasons why the device may be
runtime resumed at this point:
*) The runtime PM usage count has been bumped in
sdhci_enable_sdio_irq(), since the SDIO irqs are enabled and it's
likely that we will configure them for system wakeup too.
*) The device has been used, but nothing really prevents it from being
put into a low power state via the ->runtime_suspend() callback.

> +        * 2, make sure the pm_runtime_force_suspend() in NOIRQ stage really
> +        *    invoke its ->runtime_suspend callback.
> +        */

Rather than using the *noirq-callbacks, we should be able to call
pm_runtime_force_suspend() from sdhci_esdhc_suspend(). And vice versa
for sdhci_esdhc_resume().

Although, according to my earlier comment above, we also need to take
into account the SDIO irq. If it's being enabled for system wakeup, we
must not put the controller into low power mode by calling
pm_runtime_force_suspend(), otherwise we will not be able to deliver
the wakeup, right?

> +       pm_runtime_get_sync(dev);
>
>         if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
>                 (host->tuning_mode != SDHCI_TUNING_MODE_1)) {
> @@ -1883,12 +1885,11 @@ static int sdhci_esdhc_suspend(struct device *dev)
>                 mmc_retune_needed(host->mmc);
>         }
>
> -       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> -               mmc_retune_needed(host->mmc);
> -
> -       ret = sdhci_suspend_host(host);
> -       if (ret)
> -               return ret;
> +       if (device_may_wakeup(dev)) {
> +               ret = sdhci_enable_irq_wakeups(host);
> +               if (!ret)
> +                       dev_warn(dev, "Failed to enable irq wakeup\n");
> +       }
>
>         ret = pinctrl_pm_select_sleep_state(dev);
>         if (ret)
> @@ -1904,22 +1905,18 @@ static int sdhci_esdhc_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         int ret;
>
> -       ret = pinctrl_pm_select_default_state(dev);
> +       ret = mmc_gpio_set_cd_wake(host->mmc, false);
>         if (ret)
>                 return ret;
>
>         /* re-initialize hw state in case it's lost in low power mode */
>         sdhci_esdhc_imx_hwinit(host);

This looks like another special use-case. If I understand correctly,
on some platforms some additional re-initialization of the controller
may be needed at system resume.

If you want to move towards using pm_runtime_force_suspend|resume(), I
suggest moving the above call into the ->runtime_resume() callback. To
allow the ->runtime_resume() callback to know when this
re-initialization is needed, we can use a flag that we set here and
clear in the ->runtime_resume() callback.

>
> -       ret = sdhci_resume_host(host);
> -       if (ret)
> -               return ret;
> -
> -       if (host->mmc->caps2 & MMC_CAP2_CQE)
> -               ret = cqhci_resume(host->mmc);
> +       if (host->irq_wake_enabled)
> +               sdhci_disable_irq_wakeups(host);
>
> -       if (!ret)
> -               ret = mmc_gpio_set_cd_wake(host->mmc, false);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);
>
>         return ret;
>  }
> @@ -2011,6 +2008,8 @@ static const struct dev_pm_ops sdhci_esdhc_pmops = {
>         SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
>         SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
>                                 sdhci_esdhc_runtime_resume, NULL)
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                                       pm_runtime_force_resume)
>  };
>
>  static struct platform_driver sdhci_esdhc_imx_driver = {
> --
> 2.34.1
>

Kind regards
Uffe

