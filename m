Return-Path: <linux-kernel+bounces-207692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92730901A89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940771C2280D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759E39AF9;
	Mon, 10 Jun 2024 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lVpmfPeY"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1822EED
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998799; cv=none; b=Hk+Cm84BJeaoqx+hQTnix2zT91ItGDRd5kYcn49eTa5/wbKCcAXgnxXRgingF07hmN7Jx0hYxVkj94X5ldBxaOBrVU5QXpHxKDsq5Reuyqi304n2vhmBuIpCOAWKApkYwkrwl3Pphf2LsgOBCLyCyhN47AkirEwbytbeG8a6Tuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998799; c=relaxed/simple;
	bh=irF8ph+PrFtqkoPopgFU4I8t5Afbf3NJWtvx9cvnnNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n36rHpjw6tCvzi+obnHXQTB/FqshxApTvoU2it0AVKna+lhc5SdLBQkUi7snq0H/dEY0HyCwdXCU5kVkrc0lyVc2qAfkDDzLdhm9bp5YWtqvkFSamqIK9fwl9LfctxNzJ9XdNYEmeEeKGmFsoModUxIdgPfNr12GC4WdZkQmMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lVpmfPeY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f1c209893so1256538f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717998796; x=1718603596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1bnbZBagSaTn2JXJEWNJzTIrkukPRASk2JO9D05+bKc=;
        b=lVpmfPeYKugBdCI73C8xvFZN8+yWzNJWjZTdXNwtqGc0ynTdTXiPqK6USARFrMPUKC
         cSDz/PfjoWLgYYdrxLxPxr+Q+pyhshmBIlWSD/wjMbYbrVg0Gy5YsANPthcsl+DMB7Dd
         tgCM0rgz2/lABsnfT0P2d3bS1LB3RSZ0dy24Nzra+Uu1+w6Ks5X1ikjf1o81jrLPi4I0
         3olxMxVPm2J6LIGPzTV9V3HFppAqCUsr18CEUC24vIPxN2eZ1OBIgTQNjyOHuWG4pjFy
         q9+oudRypJnmxSd3mZhbac7D4ESUhG8gO5tnBkv8bgS9sXr1ZUc3T5QwLByQvYkQxP12
         lSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998796; x=1718603596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bnbZBagSaTn2JXJEWNJzTIrkukPRASk2JO9D05+bKc=;
        b=QrHfGx3G+YqQN26SOf99cunjLo9nDj4dH74VGd+pvTTGCfhlLWkZgCFVcfN/RNdFoc
         waQkjC6zRtE99KdXhtjltH+vIcrTNVUPuSzk2emgW2jdMKg9Yk5hym00puJF+7gboMJj
         ANgvfR0FdfP+lnJQlatwxqutvZGYUk47XEujKeVRnyNGDQIcNfoSLMI5QeXD/uLVkSdh
         ufw1zq9NR0xNdB9yL9ItdVTQyJATlzOXK8gWWkyIVSDYqCnOKfmeT15Rndp7vTOU42ck
         dSCgWaPjmGEHSibXggKrQuhSv4zfEroI4SmtS3dCXfZxI/QwiJXki8oS/uBycmtCmI4N
         Gu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGzRfFcOI7C/ZEOhgAmI8jZ8D1zlixmgnP5Sh8gzlnvADxkJcqTc48BxxyJCkiSaJBWVsce2fLMautetRKjPtjwGVK6aCHUlQzjYzI
X-Gm-Message-State: AOJu0YzSZ1K/GlX9mM4UkJf/Db29q0oaBYzJR0M/2trUJa1P98t4Vtw+
	D8a+UTxJJskSr7IaO87r3T9ybFRam+u9VJMA8kLzsLska6z8yvRpR5FADLQ85eo=
X-Google-Smtp-Source: AGHT+IHkqS3HnQXP1SM4LUXFiNo/Si5rJY65Z+dzTqZYGUmZoPX12HJYXMHMRVy8hlem/Uo5GeZbEw==
X-Received: by 2002:a05:6000:1e81:b0:35f:650:e8ff with SMTP id ffacd0b85a97d-35f0650ebb8mr5580030f8f.28.1717998796001;
        Sun, 09 Jun 2024 22:53:16 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421cc89e055sm25464975e9.13.2024.06.09.22.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 22:53:14 -0700 (PDT)
Message-ID: <48262d5c-4dde-40c5-991c-f373f24b2018@tuxon.dev>
Date: Mon, 10 Jun 2024 08:53:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] pinctrl: renesas: pinctrl-rzg2l: Validate power
 registers for SD and ETH
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240530173857.164073-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240530173857.164073-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240530173857.164073-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.05.2024 20:38, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> On RZ/V2H(P) SoC, the power registers for SD and ETH do not exist,
> resulting in invalid register offsets. Ensure that the register offsets
> are valid before any read/write operations are performed. If the power
> registers are not available, both SD and ETH will be set to '0'.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S

> ---
> v2->v3
> - Included RB tag
> 
> RFC->v2
> - Update check to != 0 instead of -EINVAL
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 89716e842c63..6e3b1adb95f6 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -2503,8 +2503,10 @@ static int rzg2l_pinctrl_suspend_noirq(struct device *dev)
>  	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
>  
>  	for (u8 i = 0; i < 2; i++) {
> -		cache->sd_ch[i] = readb(pctrl->base + SD_CH(regs->sd_ch, i));
> -		cache->eth_poc[i] = readb(pctrl->base + ETH_POC(regs->eth_poc, i));
> +		if (regs->sd_ch)
> +			cache->sd_ch[i] = readb(pctrl->base + SD_CH(regs->sd_ch, i));
> +		if (regs->eth_poc)
> +			cache->eth_poc[i] = readb(pctrl->base + ETH_POC(regs->eth_poc, i));
>  	}
>  
>  	cache->qspi = readb(pctrl->base + QSPI);
> @@ -2535,8 +2537,10 @@ static int rzg2l_pinctrl_resume_noirq(struct device *dev)
>  	writeb(cache->qspi, pctrl->base + QSPI);
>  	writeb(cache->eth_mode, pctrl->base + ETH_MODE);
>  	for (u8 i = 0; i < 2; i++) {
> -		writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
> -		writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
> +		if (regs->sd_ch)
> +			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
> +		if (regs->eth_poc)
> +			writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
>  	}
>  
>  	rzg2l_pinctrl_pm_setup_pfc(pctrl);

