Return-Path: <linux-kernel+bounces-340949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A03A987965
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41ABB27394
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9A17ADFF;
	Thu, 26 Sep 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ZL4vZLs6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D141D5ABC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376472; cv=none; b=L5zquCPXCVvQ1WMH7GncLIr4bjlY/dDsL3cP3VIhmbAz3B2YMjKyb57UnKJRq+gHTd+2zrQl2DQbZ+u+85XdqsnmdhXsl24cc639uNoF+Tcfn9twgVoFT6kNE1+xBZvVfoylEpdW2+ZLJUpSLP11Kju5nPsp6LGZeR0mrVLq0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376472; c=relaxed/simple;
	bh=f7kYMUu3oM47xF2ld3Yw1s3/i1eupYaf+DH3+QdOHcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cqf6qCuI0A2DCVQs1zSI/sTRpELaRiwrcnn7o34hxywj7ZempM2+TtvAi2vRtSf89R3Vvpzdr78xg9yEIpnt9ZM+LGQCs0Lwl0v6ucwPKMJ04UffZtw/GODnRy8Hh9v6UQxLQt6VTrA/Z9R33L5YFYBeW2LXZERIm4xBo00INDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=ZL4vZLs6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-207115e3056so11214865ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727376470; x=1727981270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KusUymBZTpYYnq4WmcbbE/FZsVAjrJbZNZbABf3CAo=;
        b=ZL4vZLs6k3sNiCksBUVB4qbOxNgW49/xUqonqFGsD1vPNqS3UKYw3HZxb/xQZ/VngB
         RJrMptHyq+p2XjeAAbaeJdoDRU8BbPBkYyL64MN/gkwGEkDe7bTEswGyxYMJr8R7BQ6Z
         gLzl+8SH63y+Lm//7JgfX9OJlYj6bOo26jCNXr5E53kJArL1ix5HkVMarqRx3jWnn/Lm
         WEyAHfQrFnMXKL4JCCf/9Py45YNXv310cYKmHnn7tIhVUlvODUTdhSqKzsTz1WJZsj3J
         z8gxc3CJO/dFVEZSMxb+1LE6A30r9QY6Dc5IsAX6V+1mDoFMVOJUGVp3bwZY7p5S/ixr
         4v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727376470; x=1727981270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KusUymBZTpYYnq4WmcbbE/FZsVAjrJbZNZbABf3CAo=;
        b=SQCR/VKeTNId0Jbl2nSl03HoJr/9WnS08pF0jP2KNb3kLpz1f0OVRBFP5o+nV5w1g7
         j5dbLHlyhQy10peiPnepVoNNrtK8/deBOCA3FdUy/OVvXVwQi5ZHKXeSJE1qXILfdzCO
         AqU1lJqgd6NARyuLpuh0Zhhc5pzgs3k8y8bjJaKwm45YEmbViIKe6hLvyeS/bkZ1VOM1
         flq7Z6Prk7vPSm+bVtCDET0b5nTki9fmeYqfE7RWJWJiC8O1c4MWlzDRbbwsBDUbItIN
         WTB71thYb970FLTIa0hrOGNSS3Mqk5hWGY1mco083JsuauEBw1ZQpZbCS/fZEIh9wqsf
         5FCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB8t2mZptO/VHEJxFhBItYgtKGLl6J7AEAExLA6TZIRa/9hWKb8V5E34uaVk3aOU1Li3oXVIJJZi23elU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLGLY3N1qeCV1iH0buwHryy3haEWjk+fsO4GsC/AKi+Y5ISuG
	Pr3vd2jQwdaE27qsOESg4VoJvG44Bsm2dgqBxMdVPp8Oqx5F34qWm9GedSE7O34=
X-Google-Smtp-Source: AGHT+IGNxuTgkN1leT2RdvlA5PUTH+t79/qJCqmKY/KS0CmrWCtetVvj/vYEI9+Bz4MIXVKD0WkcsQ==
X-Received: by 2002:a17:903:2285:b0:207:7952:e6d4 with SMTP id d9443c01a7336-20b367ca162mr9258295ad.4.1727376469796;
        Thu, 26 Sep 2024 11:47:49 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4ee7bsm1571565ad.234.2024.09.26.11.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:47:49 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:47:47 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] net: stmmac: Add glue layer for T-HEAD TH1520 SoC
Message-ID: <ZvWsUxyBoiHws1TE@x1>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-2-f34f28ad1dc9@tenstorrent.com>
 <a64eb154-30b9-4321-b3ef-2bcb1e861800@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64eb154-30b9-4321-b3ef-2bcb1e861800@lunn.ch>

On Thu, Sep 26, 2024 at 08:32:00PM +0200, Andrew Lunn wrote:
> > +static int thead_dwmac_init(struct platform_device *pdev, void *priv)
> > +{
> > +	struct thead_dwmac *dwmac = priv;
> > +	int ret;
> > +
> > +	ret = thead_dwmac_set_phy_if(dwmac->plat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = thead_dwmac_set_txclk_dir(dwmac->plat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(dwmac->apb_regmap, GMAC_RXCLK_DELAY_CTRL,
> > +			   GMAC_RXCLK_DELAY_VAL(dwmac->rx_delay));
> > +	if (ret)
> > +		return dev_err_probe(dwmac->dev, ret,
> > +				     "failed to set GMAC RX clock delay\n");
> > +
> > +	ret = regmap_write(dwmac->apb_regmap, GMAC_TXCLK_DELAY_CTRL,
> > +			   GMAC_TXCLK_DELAY_VAL(dwmac->tx_delay));
> > +	if (ret)
> > +		return dev_err_probe(dwmac->dev, ret,
> > +				     "failed to set GMAC TX clock delay\n");
> > +
> > +	thead_dwmac_fix_speed(dwmac, SPEED_1000, 0);
> 
> Is this needed? I would expect this to be called when the PHY has link
> and you know the link speed. So why set it here?

Good point.  I've removed this line and the probe still completes okay
and the Ethernet connection is working okay.

> > +
> > +	return thead_dwmac_enable_clk(dwmac->plat);
> > +}
> > +
> > +static int thead_dwmac_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct stmmac_resources stmmac_res;
> > +	struct plat_stmmacenet_data *plat;
> > +	struct thead_dwmac *dwmac;
> > +	void __iomem *apb;
> > +	u32 delay;
> > +	int ret;
> > +
> > +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "failed to get resources\n");
> > +
> > +	plat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> > +	if (IS_ERR(plat))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> > +				     "dt configuration failed\n");
> > +
> > +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> > +	if (!dwmac)
> > +		return -ENOMEM;
> > +
> > +	/* hardware default is 0 for the rx and tx internal clock delay */
> > +	dwmac->rx_delay = 0;
> > +	dwmac->tx_delay = 0;
> > +
> > +	/* rx and tx internal delay properties are optional */
> > +	if (!of_property_read_u32(np, "thead,rx-internal-delay", &delay)) {
> > +		if (delay > GMAC_RXCLK_DELAY_MASK)
> > +			dev_warn(&pdev->dev,
> > +				 "thead,rx-internal-delay (%u) exceeds max (%lu)\n",
> > +				 delay, GMAC_RXCLK_DELAY_MASK);
> > +		else
> > +			dwmac->rx_delay = delay;
> > +	}
> > +
> 
> So you keep going, with an invalid value? It is better to use
> dev_err() and return -EINVAL. The DT write will then correct their
> error when the device fails to probe.

My intention was to keep the default of 0 if the dt property exists and
exceeds the max value. I had considered failing the probe but I wasn't
sure that was too severe of a reaction to a bad value for the delay.

> 
> If you decide to keep this... I'm not sure these properties are
> needed.

Given your reply to the cover letter, I think it does make sense for me
to remove handling of these delay properties since the units of the
delay bit field are unknown and the hardware I have is okay with the
default delay.

> 
> > +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
> 
> Please add a second author, if you have taken over this driver.

Yes, Jisheng is no longer working on it, so I will add myself.

Thanks,
Drew

