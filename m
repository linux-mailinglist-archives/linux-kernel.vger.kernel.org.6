Return-Path: <linux-kernel+bounces-287873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B31952D79
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BDC1F24189
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCFC7DA9D;
	Thu, 15 Aug 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmS/IRXm"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C121AC891
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721343; cv=none; b=Gsr5XdoKV0oYSZgHoGLcP9RBo6FlrfrJBWTP4kKnbk3eYnVvQRAXPhrlj8xRcxF+k5C98J3DvNyNOTHS0coogC4mHJG+Evmg7sZy5hMarwcI+DJfkgt2xw/5IUIj6CX86bHB2t11padza2IRJ7B0zBQ9o4V3IIUiR3bbzjTEWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721343; c=relaxed/simple;
	bh=0Zxz5gzHjDE3jmotW+wUKiwCtCm0/O3DMaAWLrKCUE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fqxcl5T+ZhJo2eYkwIXdlnjai2E0vTQUIOlc61fXm3R3TaInwqyLBiARiJdzyf4VQxo2VCGgZR0aPo0VP4P/n/8IBsudGaoR6ejxorzoMvhQmm6xPZv3o4QpBcfJ0NXwOUzk/VTwLa7GCKKUAoq9hLvY9CgchLD3LRPN/v8DrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmS/IRXm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so398257a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723721340; x=1724326140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HH/zpKWeTFmyxm1eNt1YcoQ4GGYAIZEDWavm5tzL+nY=;
        b=GmS/IRXm+cmiHCWsReZPjPvq/d9XgaqEQNACwRlYniw0QC9Z6AqS72EX731ByjaKMg
         kDh0EajMga5Zgd8sHAYdYeMyQTMp+vXi/bXZIeLZUWweX3IPSMBrjauwVQ+RKd17mFf8
         nsR3KYRYJFMXDZsez+s/wjpEH9HS/pjB3HMnR+WTFmo4xda2p/WBcvI2nhQ6TjTwO1aq
         /rWDfpDtZfKjucQNJK8ZDHK+QW2SkmfNaGwW6gxF6UdYInx5AEvCRP3H4thVvcUm78SD
         XW361rZPpJc2gaoqNggUcIZgWVCtQAKVf110tRYU3PmwDLnF1Xv0S69wdymFQnhkp+go
         5vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721340; x=1724326140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH/zpKWeTFmyxm1eNt1YcoQ4GGYAIZEDWavm5tzL+nY=;
        b=bUnH3VNv4w2uWtZk79NtqdVbRsYqysrAzFoNTjZlSdXUTeWFKGGVULrBTMU1fou6N1
         8YUxSq/zZ4a8ktjkrVJbT4m1M5Z5xk8Qn4Jugsp1kMbdQJO2V/G0gaRDiQbA8OOeAwJh
         UPQ92LxE1vxfrxoeTxlscf6Ry9fBGhEJLIAaCC8c+8n6dp1xocUCEfOOW0VEnw8vmLBB
         oPbyW6f2RvarHXJ5LYSWuOqj0+hTCob8KivA49PMgoo+vY9orH1fptcFwmNZX/hodzmx
         wMawAhRUlOpiPGyTquQYl5JOeRohnF1NioQ8sfCAgp9gvdHEP7D5VB95jGWOYFcIeicN
         A9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUTtqce5F4mM7yyYXslUDIfRJIbBSJgTR5sO/BpyFBP3ThizLCMdRfkYrvcmPc0S4OEL9TGdhNz/2FTG/TYbXgmVDFWV5GKjK4lr5Wf
X-Gm-Message-State: AOJu0YwuEN0K7h0y1vdCncPTEcwut8OCxJtBNsk6cRsgpk3OofT5xvLw
	Ts7X8VOykQIXbVfPo1smuUJ2KjSsCrqLy2dpfNIgE9fjH4nl2YNovwQVnrgm94Q=
X-Google-Smtp-Source: AGHT+IGweg8JNiNuxijevvNkiZoEQZAItT79/Kj/VOyrtADtkncjFrFOpRhsZwl2875459IMKahghQ==
X-Received: by 2002:a17:907:9705:b0:a6f:e7a0:91cf with SMTP id a640c23a62f3a-a837cdc005bmr228386866b.24.1723721339965;
        Thu, 15 Aug 2024 04:28:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396b7b3sm86750066b.194.2024.08.15.04.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:28:59 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:28:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Roger Quadros <rogerq@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v5 2/2] net: ti: icssg-prueth: Add support for
 PA Stats
Message-ID: <cd15268f-f6d3-4fca-bd7f-c94011f55996@stanley.mountain>
References: <20240814092033.2984734-1-danishanwar@ti.com>
 <20240814092033.2984734-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814092033.2984734-3-danishanwar@ti.com>

On Wed, Aug 14, 2024 at 02:50:33PM +0530, MD Danish Anwar wrote:
> Add support for dumping PA stats registers via ethtool.
> Firmware maintained stats are stored at PA Stats registers.
> Also modify emac_get_strings() API to use ethtool_puts().
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 17 +++++-----
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++++
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  5 ++-
>  drivers/net/ethernet/ti/icssg/icssg_stats.c   | 19 +++++++++--
>  drivers/net/ethernet/ti/icssg/icssg_stats.h   | 32 +++++++++++++++++++
>  5 files changed, 67 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index 5688f054cec5..51bb509d37c7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -83,13 +83,11 @@ static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
>  
>  	switch (stringset) {
>  	case ETH_SS_STATS:
> -		for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
> -			if (!icssg_all_stats[i].standard_stats) {
> -				memcpy(p, icssg_all_stats[i].name,
> -				       ETH_GSTRING_LEN);
> -				p += ETH_GSTRING_LEN;
> -			}
> -		}
> +		for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
> +			if (!icssg_all_stats[i].standard_stats)
> +				ethtool_puts(&p, icssg_all_stats[i].name);
> +		for (i = 0; i < ICSSG_NUM_PA_STATS; i++)

It would probably be better to use ARRAY_SIZE(icssg_all_pa_stats) so that it's
consistent with the loop right before.

> +			ethtool_puts(&p, icssg_all_pa_stats[i].name);
>  		break;
>  	default:
>  		break;
> @@ -100,13 +98,16 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
>  				   struct ethtool_stats *stats, u64 *data)
>  {
>  	struct prueth_emac *emac = netdev_priv(ndev);
> -	int i;
> +	int i, j;
>  
>  	emac_update_hardware_stats(emac);
>  
>  	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
>  		if (!icssg_all_stats[i].standard_stats)
>  			*(data++) = emac->stats[i];
> +
> +	for (j = 0; j < ICSSG_NUM_PA_STATS; j++)
> +		*(data++) = emac->stats[i + j];

Here i is not an iterator.  It's a stand in for ARRAY_SIZE(icssg_all_stats).
It would be more readable to do that directly.

	for (i = 0; i < ICSSG_NUM_PA_STATS; i++)
		*(data++) = emac->stats[ARRAY_SIZE(icssg_all_stats) + i];

To be honest, putting the pa_stats at the end of ->stats would have made sense
if we could have looped over the whole array, but since they have to be treated
differently we should probably just put them into their own ->pa_stats array.

I haven't tested this so maybe I've missed something obvious.

The "all" in "icssg_all_stats" doesn't really make sense anymore btw...

Sorry for being so nit picky on a v5 patch. :(

regards,
dan carpenter


