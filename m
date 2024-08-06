Return-Path: <linux-kernel+bounces-275960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB3948C7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1985C1F22F73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617AB1BDABA;
	Tue,  6 Aug 2024 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="je9656hG"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2B1BDA84
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938304; cv=none; b=iTpJKqdo0ye48xgqJT2FDJyhWDO/w67fe7ULUeHrGl2FQ7IRUPt0ACzDR/Sj43Zt3Yzx4YhLHpGpqDJLLlZMm2PLqQjCFAbvrq8RjyKrJ3V8tDMfEE9rhe+uYoQ9yfuaoxKC71m/f2ckkFVRR5jwrH1eHtShYtw7QbFOiqxES+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938304; c=relaxed/simple;
	bh=kMm+NKRFOFvLmdxIXuTSE9MwOAwuHJpRP2KuJ5R5xVM=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnyI1tAwzlA1GImsuGvlXJullZLFRrQMQA7JTwH2pcj+hkoy/yS4+o3l1lNgxk8W1LzyG58cYA3egpCAN7VnnHubk/KklffOg82ICf2LRw4DO0stXRkMrdET8Sjgi0LOuwNuz2pH8qVFhlgg58Wr8UFrwdAG+NKISBlLcSnYP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=je9656hG; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 89D4E3F1EF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722938299;
	bh=2cCl5NWvQP7mvWlTPj6kYUEZ/fX6AeYVRRTgEXvTcx0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=je9656hGo2UBMayXelQNsf5iX3KAzezbzHsqyRKkrC4q3PRDTTKQfse5+SqoQxoxm
	 AyfuFcujeXBsBryHLRTumQhu9GsHn7CeXIzml0LoIEbyYvnn61WfWgBCnNBzgvze1s
	 9pdK875teX1CPoeDeQVUBAxpd/o2NJGm39EC8gn96EJH85RQGnYW31lxlCHNhSZfRm
	 yKaI1QANzG39qX/I4NSN6rc04QoAdzNesf/Kce/V4UG8VvDzuACpOzTTyuWxCuOcjC
	 HXqacyU+IpVV799VXIZ/7Fm1s4504YHhQJ3HHTD179SAk2cHQpBbLD0DKJuVi/dPR7
	 8Ebm8n6CN4gtw==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6506bfeaf64so6599607b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722938298; x=1723543098;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cCl5NWvQP7mvWlTPj6kYUEZ/fX6AeYVRRTgEXvTcx0=;
        b=V9g9iASLfuclejIpWIM+2s8uedpaYfvNXRH0Ho/2ABjxVdkr8qyTUim8lgbN7cFquh
         mCBvlv2dOR8qtvVltEpDMgO7CxFfpvD95jiVDQuuh2Rn5WyQbaoQW6IhDLJPJq2EO8mD
         aKhYJjhdW3YguFl+4ndGjSL7WEWkcS81sHMF6kGKgogC2lUpvPeu40cZb2dbqzwI3AyJ
         qnYSouo8IMmYJ3ANYE49hVx1CMwA1KEpLW6KWVEerBdYbaKjMiWH9LLtaPTDUamWVG4I
         0QqPbrq3tX73Bke2zbV2u7RKZtvrEPML2rZofWLCba8DqEtlrUfua563ufgyUeJuvtTV
         ClCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWkeTg2rzihpK9792Cub8UXxVRMmXFtoZgsndRbv6F7F6bmsae7RXLJCFkaOmMGShPDengwsr3u8feeMtzAMUQq/ERDlJW9wIL/piq
X-Gm-Message-State: AOJu0YzakM0WBbQMG0m2Rs0kn3FYGNSvJNOLmkRYnIZFc6vHh2ndw9Z0
	UxnCcYtGLuxFTl0pkm8IHilY4og/3Iml65ywpMLlTwykAlwgCBqWwiXR27S9ik2eDwEEkbzy3ba
	VzSjsSwo3YK6jFZR+NqpoIZ2dMLBoxpj+IVgyLkw43EEf8dZOADq/v+HVxIiAZBHoJr5XE293l7
	JJVzUG0Q0aYybz5qPS1ILiUMzWDnh1vbPoPtRWo/t18Ugg3jDGWU4i
X-Received: by 2002:a05:6902:508:b0:e0b:618f:cb9a with SMTP id 3f1490d57ef6-e0bde408a4amr13968422276.37.1722938298572;
        Tue, 06 Aug 2024 02:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1GJXQ7U5odGOP0yjOPy0Ll2tOOOgBwmuxvwHvgUXTIuxI0NrhOz7tSeIbC1T7ag81e+WPcOay5Uoe6LMqrI4=
X-Received: by 2002:a05:6902:508:b0:e0b:618f:cb9a with SMTP id
 3f1490d57ef6-e0bde408a4amr13968408276.37.1722938298152; Tue, 06 Aug 2024
 02:58:18 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Aug 2024 04:58:17 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
References: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 6 Aug 2024 04:58:17 -0500
Message-ID: <CAJM55Z-_sOvRnaa8BuGcupsUksaK=tuTbTmF=AtzmzkCo7y5jA@mail.gmail.com>
Subject: Re: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xingyu Wu wrote:
> CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz. But now
> PLL0 rate is 1GHz and the cpu frequency loads become 250/333/500/1000MHz
> in fact. The PLL0 rate should be default set to 1.5GHz and set the
> divider of cpu_core clock to 2 in safe.
>
> To keeo the cpu frequency stable when setting PLL0, the parent clock of
> the cpu_root clock needs to be switched from PLL0 to another parent
> clock and add notifier function to do this for PLL0 clock. In the
> function, the cpu_root clock should be operated by saving its current
> parent and setting a new safe parent (osc clock) before setting the PLL0
> clock rate. After setting PLL0 rate, it should be switched back to the
> original parent clock.
>
> To keep the DTS same in Linux and U-Boot and the PLL0 rate is 1GHz in
> U-Boot, the PLL0 rate should be set to 1.5GHz in the driver instead of
> DTS.
>
> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>
> Hi Stephen and Emil,
>
> This patch is to fix the lower rate of CPUfreq by adding the notifier
> for PLL0 clock and changing the PLL0 rate to 1.5GHz.
>
> To keep the DTS same in Linux and U-Boot as Conor wants[1] and the PLL0
> rate is 1GHz in U-Boot, the PLL0 rate should be set to 1.5GHz in the
> driver instead of DTS.
>
> [1]: https://lore.kernel.org/all/20240515-reorder-even-8b9eebd91b45@spud/
>
> Thanks,
> Xingyu Wu
>
> ---
>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 54 ++++++++++++++++++-
>  drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 +
>  2 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> index 8f5e5abfa178..7469981fb405 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -385,6 +385,32 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>  }
>  EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
>
> +/*
> + * This clock notifier is called when the rate of PLL0 clock is to be changed.
> + * The cpu_root clock should save the curent parent clock and swicth its parent
> + * clock to osc before PLL0 rate will be changed. Then swicth its parent clock
> + * back after the PLL0 rate is completed.
> + */
> +static int jh7110_pll0_clk_notifier_cb(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct jh71x0_clk_priv *priv = container_of(nb, struct jh71x0_clk_priv, pll_clk_nb);
> +	struct clk *cpu_root = priv->reg[JH7110_SYSCLK_CPU_ROOT].hw.clk;
> +	int ret = 0;
> +
> +	if (action == PRE_RATE_CHANGE) {
> +		struct clk *osc = clk_get(priv->dev, "osc");
> +
> +		priv->original_clk = clk_get_parent(cpu_root);
> +		ret = clk_set_parent(cpu_root, osc);
> +		clk_put(osc);
> +	} else if (action == POST_RATE_CHANGE) {
> +		ret = clk_set_parent(cpu_root, priv->original_clk);
> +	}
> +
> +	return notifier_from_errno(ret);
> +}
> +
>  static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>  {
>  	struct jh71x0_clk_priv *priv;
> @@ -413,7 +439,11 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>  		if (IS_ERR(priv->pll[0]))
>  			return PTR_ERR(priv->pll[0]);
>  	} else {
> -		clk_put(pllclk);
> +		priv->pll_clk_nb.notifier_call = jh7110_pll0_clk_notifier_cb;
> +		ret = clk_notifier_register(pllclk, &priv->pll_clk_nb);
> +		if (ret)
> +			return ret;
> +
>  		priv->pll[0] = NULL;
>  	}
>
> @@ -501,7 +531,27 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> -	return jh7110_reset_controller_register(priv, "rst-sys", 0);
> +	ret = jh7110_reset_controller_register(priv, "rst-sys", 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set the divider cpu_core to 2 and set the PLL0 rate to 1.5G. */
> +	pllclk = clk_get(priv->dev, "pll0_out");
> +	if (!IS_ERR(pllclk)) {
> +		struct clk *cpu_core = priv->reg[JH7110_SYSCLK_CPU_CORE].hw.clk;
> +
> +		ret = clk_set_rate(cpu_core, clk_get_rate(cpu_core) / 2);
> +		if (ret)
> +			return ret;
> +
> +		ret = clk_set_rate(pllclk, 1500000000);
> +		if (ret)
> +			return ret;
> +
> +		clk_put(pllclk);
> +	}
> +
> +	return 0;

I'm still not a fan of hardcoding cpu frequencies in the driver. You've added
the notifiers exactly so that we can use the standard device tree settings for
this.

In other words I much prefer v5 of this patchset.

/Emil

>  }
>
>  static const struct of_device_id jh7110_syscrg_match[] = {
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
> index 23e052fc1549..e3f441393e48 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
> @@ -114,6 +114,8 @@ struct jh71x0_clk_priv {
>  	spinlock_t rmw_lock;
>  	struct device *dev;
>  	void __iomem *base;
> +	struct clk *original_clk;
> +	struct notifier_block pll_clk_nb;
>  	struct clk_hw *pll[3];
>  	struct jh71x0_clk reg[];
>  };
> --
> 2.34.1
>

