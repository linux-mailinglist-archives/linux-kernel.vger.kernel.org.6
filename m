Return-Path: <linux-kernel+bounces-207707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB432901AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9904A1C23A99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F176F302;
	Mon, 10 Jun 2024 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lj1I9LOC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815DD6F2EA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998959; cv=none; b=rBp5+//V9kCC2NXmp01nAzGHwBkiBS6OXU3rqa1IpdJaLFR3zIWelPjljF3PSnvbGR7O+QvV0bNQKrPma8gRCVcPIUBN8z4SCXFylGVid/9nMGSASAvGNOCOcpHUybpOapfzoU98O/A3ude5PqrHBJLhlJlE4CrGTsmnVA5xzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998959; c=relaxed/simple;
	bh=/4bTdn+7lYje1vS+9sA6z9rJp7vNEVVidi+fNF+Y1xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rj0K9WSpVjJqMEcZaAAS86OeF9EHj6IkRNW+PRzUJIoYPsENJ9Bm5Gu+NrsfbLem5Jd2wgUmwluB2h5hH/iRclASBt3y4b7LJoesrs5smkPFJI+ydVjrGcAuC+dzQvdgDlSIx1AzMzVIbSGAzZS5aUXFzeUjFc115SsFfPQu5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lj1I9LOC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421798185f0so14645455e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717998956; x=1718603756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqHacm+5UkiBiSGZpqsb1GsXtipING5TXbDuGZxX8J8=;
        b=lj1I9LOCFAXTREcEmHOOfrvV2+9qGespvXmtdWv2OLWGIG2Pl+78FBQdXhRVylDLDs
         iRF90CE0N7zrAnTtNtW5Dy7nAgGeWxWjn9jAC92wg5iVGgYW8LMC5sK0VmgskebOuqJm
         xoWE+QLYwaT1LcE8gQDZZt1hREf547arHCIuyMDkV5pvW4+6pVE17S2pQIpI50tJoDj7
         A1CYJ9N6FsorG5bXvBvmuw6/oARZw8sly4+e4a22YgVsBat/qnZfONBeBqd02b0N6pfo
         dz5yEWmpXATGJX0WeYwKudLjpPtnQJGbZQvR3YdB95kANFhu/tPQWjbTX8UAbx7HWGLf
         aJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717998956; x=1718603756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqHacm+5UkiBiSGZpqsb1GsXtipING5TXbDuGZxX8J8=;
        b=A2R8GN/w9i2EZLUDrhcJGHm8QnHssbse5/vH/p5gbWPG4Y+5ve5vvfy6NaeGq1G11S
         W6ISko5sue+Djav+jeSWVXKSuBBenTpKq9NIiV7vyMMUc9UdL83fdW+DQNF+ZCDl0EYx
         H2o+WUEVjbTmaQvWEAya9p7SNTKaefV3kqcrOXcCPRu/Kio7Ju4db50KqC147ym4H1Ef
         TRyLPVh6+2f0TL8wxYT9CdzmlmHqQw/08YXkhA880SGizyAa4PXyGUNITQTrPwo6ZRJc
         +WQzM6vBG45A0tNInJ6n7Wvyn1zpmC9lD2Qwp3yzqp6LpqxW6FzzkaabsDdBKToEgvzw
         pB4w==
X-Forwarded-Encrypted: i=1; AJvYcCU8yTg+VBtupySp+VgzYQ5+PXwtjmzpL9unNvS9cDogUa74FMJowCxzenpboseqw0THljt/6y/5khXFqatlYKpfKIUmFu3XOANmBZRY
X-Gm-Message-State: AOJu0Yx79054kRGXB1feDOWDyUSzm4V6E918OW6VpSGwLDsAtsYTgxHu
	qKBb2VRlJ4iXW9N3Gk8d8ehrSJbmzgzLwDzTGQqG6xmK2nIIdi8yvoKYUYq+W84=
X-Google-Smtp-Source: AGHT+IEmoQGWsqbdS/Y71TWQyCne2B8Vg3LIq/p3oN1l6RdE9reNdpeH4okRGhBZs7zW8gKO8H9b7w==
X-Received: by 2002:adf:ce85:0:b0:35f:122e:bd8c with SMTP id ffacd0b85a97d-35f122ebdd0mr3226887f8f.17.1717998955898;
        Sun, 09 Jun 2024 22:55:55 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29e57sm10097602f8f.2.2024.06.09.22.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 22:55:55 -0700 (PDT)
Message-ID: <bbc6cc82-3209-44a4-ab46-577348972cce@tuxon.dev>
Date: Mon, 10 Jun 2024 08:55:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] pinctrl: renesas: pinctrl-rzg2l: Add function
 pointers for reading/writing OEN register
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
 <20240530173857.164073-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240530173857.164073-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.05.2024 20:38, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> This patch introduces function pointers, oen_read() and oen_write(), in the
> struct rzg2l_pinctrl_data to facilitate reading and writing to the PFC_OEN
> register. On the RZ/V2H(P) SoC, unlocking the PWPR.REGWE_B bit before
> writing to the PFC_OEN register is necessary, and the PFC_OEN register has
> more bits compared to the RZ/G2L family. To handle these differences
> between RZ/G2L and RZ/V2H(P) and to reuse the existing code for RZ/V2H(P),
> these function pointers are introduced.
> 
> Additionally, this patch populates these function pointers with appropriate
> data for existing SoCs.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S

> ---
> v2->v3
> - Renamed read_oen->oen_read
> - Renamed write_oen->oen_write
> - Updated commit message
> 
> RFC->v2
> - No change
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index f8a1a1f2eebe..807851c33e48 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -255,6 +255,8 @@ struct rzg2l_pinctrl_data {
>  	unsigned int n_variable_pin_cfg;
>  	void (*pwpr_pfc_lock_unlock)(struct rzg2l_pinctrl *pctrl, bool lock);
>  	void (*pmc_writeb)(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset);
> +	u32 (*oen_read)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin);
> +	int (*oen_write)(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin, u8 oen);
>  };
>  
>  /**
> @@ -1035,7 +1037,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
>  		break;
>  
>  	case PIN_CONFIG_OUTPUT_ENABLE:
> -		arg = rzg2l_read_oen(pctrl, cfg, _pin, bit);
> +		arg = pctrl->data->oen_read(pctrl, cfg, _pin, bit);
>  		if (!arg)
>  			return -EINVAL;
>  		break;
> @@ -1144,7 +1146,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
>  
>  		case PIN_CONFIG_OUTPUT_ENABLE:
>  			arg = pinconf_to_config_argument(_configs[i]);
> -			ret = rzg2l_write_oen(pctrl, cfg, _pin, bit, !!arg);
> +			ret = pctrl->data->oen_write(pctrl, cfg, _pin, bit, !!arg);
>  			if (ret)
>  				return ret;
>  			break;
> @@ -2623,6 +2625,8 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
>  #endif
>  	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
>  	.pmc_writeb = &rzg2l_pmc_writeb,
> +	.oen_read = &rzg2l_read_oen,
> +	.oen_write = &rzg2l_write_oen,
>  };
>  
>  static struct rzg2l_pinctrl_data r9a07g044_data = {
> @@ -2636,6 +2640,8 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
>  	.hwcfg = &rzg2l_hwcfg,
>  	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
>  	.pmc_writeb = &rzg2l_pmc_writeb,
> +	.oen_read = &rzg2l_read_oen,
> +	.oen_write = &rzg2l_write_oen,
>  };
>  
>  static struct rzg2l_pinctrl_data r9a08g045_data = {
> @@ -2648,6 +2654,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data = {
>  	.hwcfg = &rzg3s_hwcfg,
>  	.pwpr_pfc_lock_unlock = &rzg2l_pwpr_pfc_lock_unlock,
>  	.pmc_writeb = &rzg2l_pmc_writeb,
> +	.oen_read = &rzg2l_read_oen,
> +	.oen_write = &rzg2l_write_oen,
>  };
>  
>  static const struct of_device_id rzg2l_pinctrl_of_table[] = {

