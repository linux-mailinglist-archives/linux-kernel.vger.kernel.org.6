Return-Path: <linux-kernel+bounces-286425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64C951ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D0E1C20D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191411B0128;
	Wed, 14 Aug 2024 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7sR6p68"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87201ABEC6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638465; cv=none; b=Ykp1TAbwFC6Lugs75oOLaqkptBs86csvDkKmcwGGBdvaGPWzNr4SGerAh746s44HBtB2B+0eVI82KWJoTgZrjkrOyEU+pY7AcFiW9pMVNO9o1qRDuzD+qsCzrUmznQrvrU0pBsg5VevRK5QytZDkktyw4GkcFquzkMCNLiWeEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638465; c=relaxed/simple;
	bh=MCOk87ltZF6H24V4o3EuaT8TEO85EAEEdjQr/69xPv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUsNiw19D6HR3JLzv9Mvyp9qp2YYS2QnHwz+oxXlD4Es4M0O4Md7WAW4I0A0GI8X0kxEDR6J46aM+geC3Tnxibhi0qoqtwnR3NO9BNCjIe+EGnk6JWyIlKW37XATGc8J98D9FgaZrdNc4bE2K0nrJYA9GceJZhKhJpRNJ1Nljik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k7sR6p68; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso6334067276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723638462; x=1724243262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9qLRZtDKTr0jSAm7vgxxCmZiYCAFJZ6KbzLPsYTR78E=;
        b=k7sR6p68TNyMvDbNuMi7MIKE0abbXQn+tQJsMWlCcQRm1R5fMzmTfypX41WMOYjiMn
         zx9gEpYHfZVzaOuSyWHfIxsg9oLRCUq1gXAT0QBhM3Zd/cJ5jDREDxKVLZzD2drB2bcR
         vbFEQSW0E8HVdsvvfjqSBnClpAoU936DP+W9NLT3yJ+7CJ8+Q+2teJN0vvUWdgJZdHmt
         xmAtrCLeDqRbwsEbibskG4NtDptg52e0Txg7itMHQVCRYibigmTXRcGo86d1WDsZUFzx
         ybNZ1goL6WeghuM+j+1FXXhdgGoyltSPAopUaWQ2S9UBPCE8uUhmlsureH4cjYPMYN5G
         Gdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723638462; x=1724243262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qLRZtDKTr0jSAm7vgxxCmZiYCAFJZ6KbzLPsYTR78E=;
        b=m5b0xV8OYhAKR7ZyFxDqrTdnE6tx9CWkDTFrxEq32pMBxGDWUprVKG6e0fCsN/Ts/B
         fN8wOx2tVjnp2PRECWzGdVTvSR1bqFb0FJH4ia0ZXLkstCq5lniDD5+vEKG/l+Odo0dt
         CZ8ASjzxjtjqunz3uIXYQI8Brdvw6KNcz5zVr7BQP8cYKjTkKkyCN3ymI76LXNzrWvjr
         eMEhJeArySp9CnSA0wlm2g1vnHZ2dGRUG5fGwx35LMzxsgEzfEUq55ZBywxW/7xWRqTZ
         BME/ZyZP4F+1MIOyvxcvEvbEYe1jG64BLVuIiFYRw1QmE6GNrxgKR/aUbj4Smk8cwFrP
         eLZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUDMnpNsxs7lMKraI4XtKa0HIS654cEzigsl/qAuK23lsPIYdpaIS0YglYL8Prd/bgD35jQOtIxXzg/CYwoihGfrySUz2HRZmz2g/s
X-Gm-Message-State: AOJu0YyJPmjJaZIYwrHmZTzAIMHDubmKhPrkVBuxTIa5RKr2PLGO+u9u
	nt6zIQHbDNDg+V1kHeSULlGHesCO+nVoSbmUglw2aCXbHy0X/kjLctAneUBXxTgfCWqBuq7JRLG
	vG3z0NL73x4kSa0+DFrd5VQQ/RdKMG2rxxPKMiW5mtV2npBC7
X-Google-Smtp-Source: AGHT+IGZNeDFwFKcA5hs1O9iOJjIbT4kC9fliekBbf25Kpj2PSN73rKcDwW575WyFIjWIU4Us23LFsHtHqbVvg9DljI=
X-Received: by 2002:a05:6902:2e0d:b0:e08:8d4e:ccc1 with SMTP id
 3f1490d57ef6-e1155bdce60mr2569783276.54.1723638461945; Wed, 14 Aug 2024
 05:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813085748.2144637-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240813085748.2144637-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 14:27:06 +0200
Message-ID: <CAPDyKFo_R3=MK9pRzzG2mV4s3HZKGuoZ1kxoNVLwGAqFirupNw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: wait SSAR when i.MX93 power domain on
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Aug 2024 at 10:49, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> With "quite" set in bootargs, there is power domain failure:
> "imx93_power_domain 44462400.power-domain: pd_off timeout: name:
>  44462400.power-domain, stat: 4"
>
> The current power on opertation takes ISO state as power on finished
> flag, but it is wrong. Before powering on operation really finishes,
> powering off comes and powering off will never finish because the last
> powering on still not finishes, so the following powering off actually
> not trigger hardware state machine to run. SSAR is the last step when
> powering on a domain, so need to wait SSAR done when powering on.
>
> Since EdgeLock Enclave(ELE) handshake is involved in the flow, enlarge
> the waiting time to 10ms for both on and off to avoid timeout.
>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Should we add a stable and a fixes tag for this too?

Kind regards
Uffe

> ---
>
> V1:
>  Downstream R-b tag kept
>
>  drivers/pmdomain/imx/imx93-pd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
> index 1e94b499c19b..d750a7dc58d2 100644
> --- a/drivers/pmdomain/imx/imx93-pd.c
> +++ b/drivers/pmdomain/imx/imx93-pd.c
> @@ -20,6 +20,7 @@
>  #define FUNC_STAT_PSW_STAT_MASK                BIT(0)
>  #define FUNC_STAT_RST_STAT_MASK                BIT(2)
>  #define FUNC_STAT_ISO_STAT_MASK                BIT(4)
> +#define FUNC_STAT_SSAR_STAT_MASK       BIT(8)
>
>  struct imx93_power_domain {
>         struct generic_pm_domain genpd;
> @@ -50,7 +51,7 @@ static int imx93_pd_on(struct generic_pm_domain *genpd)
>         writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
>
>         ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> -                                !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
> +                                !(val & FUNC_STAT_SSAR_STAT_MASK), 1, 10000);
>         if (ret) {
>                 dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
>                 return ret;
> @@ -72,7 +73,7 @@ static int imx93_pd_off(struct generic_pm_domain *genpd)
>         writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
>
>         ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> -                                val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
> +                                val & FUNC_STAT_PSW_STAT_MASK, 1, 10000);
>         if (ret) {
>                 dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
>                 return ret;
> --
> 2.37.1
>

