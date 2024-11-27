Return-Path: <linux-kernel+bounces-423598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 386929DAA2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA494B21C41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC171FF7BF;
	Wed, 27 Nov 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cqc0hW1u"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A871FF7AB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719090; cv=none; b=PahgRd6kWy0zvIy8eGExt7k7guhTbOsPyoPGGmAfYZELA+GaL19vhz9LE0Xpz0mp9FtswYeUAovLo0oNyu2UavEeui+K34X9BqzuvafzEnTU8u0PIggR8fCVsrO5IRjYyvQLqmHsH4/qnsOFDan1GprQ+GqJaKV59Tn+pF+9wLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719090; c=relaxed/simple;
	bh=8IPmXPA9vlrfIWt+Un6Qmb35TWs/KQ1dfAq90W49uMg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C74OEYUsGesYZYZdppG/7ojBKor8xOp/E35+6EuJ8WNmlcNA9EZpryeHey6gNgwPUSIpdWoNdP4lSHklAWjey5OxVxvqxpwlTmY02vGYra1yELpUab88HUAghp6BWj2f/ttjzZR8wAUiXSc8lu/FhZfnjV+Ev6F+OW4gLKRYCr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cqc0hW1u; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5747340CE5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732719083;
	bh=ddTmmaktStUX+KyiWQA7QlRxka08sVdAlnNv34gi4rQ=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cqc0hW1uD0jRhYLJnPXSGUFUDywfizbkPvUkImeQQTLFw7g3vMnMX7TC8B8F1h9Qs
	 nO/3eFpVNdln4gZWZE5brKmpoyrIuXvscAUoYC7uzXJr3LqhhHuraMzWacRBbkRaqb
	 iT0lNFSW83dappjtk0AN4aj2aVSqC8LcHt18bnmJmMoxrCozq4pVYEigbF9op+ZVX9
	 YOXm1R4Y3vXBXZ6Y+gspd3arqac7YButyD4EEshSG5fc8AYlCqM70612zbwnU7wAI6
	 nIXRT55O9rDcStbxIcbP+rsVyEXBvvdmVPhsOahj4N66+jzf+xa9lbBdTnYl3wGpIB
	 BYyZb/bXq8SUA==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5f1d5f7afd4so650127eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719081; x=1733323881;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddTmmaktStUX+KyiWQA7QlRxka08sVdAlnNv34gi4rQ=;
        b=WfyihaaOkDhsOnj4URRja7rTN46VWbwGdJPN/wQJ8wL8VVH67cqC6WAbP29Au57y3K
         tO54eOAyVdJmI8OggB/unQlZtYWNlpxZYS3Bs+UkHljpHcsAYFnF2CRQwWCNElm845o0
         XLFTqYBLjkmFzzQYx1SXt5jYBDPcHx61Q42iJCAjKElD2M8uYIDo3xQsbQGcSpDx8XGW
         zIgHL/sVZqai8yq7E4vMVROStV4fMN3I7CR8Qfuyw2xzC0xEdJWDgNWKdXXl9Sp0Jzby
         jq1U0EpBn4BpCD92Z8MEO2/EqcQJNEDElIra/K6hLSKUbTVHLU2tCGPCZuEhAUGk/iB7
         x00Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvRLHqhOjZ8f2EYYm0dHekSizkOGb8bYhaVyUCiOJuP9fLjMjpsrTBohi6yytK1F211mFZ8uWTG2cWWok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzq/GUN1a3uBKw3aMH1khROxrHt6D/MV9tCcVyys5Q3qA3F3aV
	bZsdqJ5iKDGmwWPf56eK5q/E6Ayzdx5Xae91u/W/KoXYisgqWEpzWuAsutltQ3aF31QwhD4cvjk
	G1CFLvC2Vyjoo+syNzaNeCk8Bv5v5eUUrWoPiQ0m084UCpMlUwuF8d7QojsZ6Jw6JY772yUW8Pm
	xnbgSEg5qjfstYke1bWJCVbqvf4/v9RzB70L/YkN1gprljy9vo2utc
X-Gm-Gg: ASbGncuUrqrz9vlq/+z+gbzB87jzFF3fHwTav3W3PNutNjkeesqFkLoVZL7J5NNta6L
	D2N7G178FO8/ceSFfjogFSEHeFXsYRh+QiJ7In4HwVV495aUX6OFsMDg9hRLa
X-Received: by 2002:a05:6820:4981:b0:5f1:fbef:c868 with SMTP id 006d021491bc7-5f1fc43a130mr3684977eaf.0.1732719081288;
        Wed, 27 Nov 2024 06:51:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfFJGOrjEK1lKzXEW/QXPfJgWZfDO/+kYkPBQ8RDpwNJVjReUG8X0KbLCz17ehyjwvJu+WybHbfVyct/J5soQ=
X-Received: by 2002:a05:6820:4981:b0:5f1:fbef:c868 with SMTP id
 006d021491bc7-5f1fc43a130mr3684952eaf.0.1732719080947; Wed, 27 Nov 2024
 06:51:20 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Nov 2024 06:51:20 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241124-upstream_s32cc_gmac-v6-9-dc5718ccf001@oss.nxp.com>
References: <20241124-upstream_s32cc_gmac-v6-0-dc5718ccf001@oss.nxp.com> <20241124-upstream_s32cc_gmac-v6-9-dc5718ccf001@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 27 Nov 2024 06:51:20 -0800
Message-ID: <CAJM55Z9PZH3797=gvRWquHFSE7YOsO0-bcOBFjBETCiQW-YURw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v6 09/15] net: dwmac-starfive: Use helper rgmii_clock
To: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
	Minda Chen <minda.chen@starfivetech.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, 
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"

Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>
> Utilize a new helper function rgmii_clock().
>

Thanks!
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> index 421666279dd3..0a0a363d3730 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> @@ -34,24 +34,13 @@ struct starfive_dwmac {
>  static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
>  {
>  	struct starfive_dwmac *dwmac = priv;
> -	unsigned long rate;
> +	long rate;
>  	int err;
>
> -	rate = clk_get_rate(dwmac->clk_tx);
> -
> -	switch (speed) {
> -	case SPEED_1000:
> -		rate = 125000000;
> -		break;
> -	case SPEED_100:
> -		rate = 25000000;
> -		break;
> -	case SPEED_10:
> -		rate = 2500000;
> -		break;
> -	default:
> +	rate = rgmii_clock(speed);
> +	if (rate < 0) {
>  		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> -		break;
> +		return;
>  	}
>
>  	err = clk_set_rate(dwmac->clk_tx, rate);
>
> --
> 2.47.0
>
>

