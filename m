Return-Path: <linux-kernel+bounces-400781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE3A9C124F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20F42848EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E631219C82;
	Thu,  7 Nov 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i0SIwRnj"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839219B5B1;
	Thu,  7 Nov 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021806; cv=none; b=KiEluIopwk1szoSM+crD6MH9n4bUSQelLwgssZiVZWe90HJTkX2rPIEZ5Gf37VIN2RQiN/gKJKTNJ1amzx52wMRwL1w6gTtnfIEcDJ4rJKfpWTxVS/xl/Wzs4eY1ejnRjcRk+JgvHJiPQAqh88lrd2z0X2se83WiX8k62E1LlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021806; c=relaxed/simple;
	bh=d9A2xAkVd72dEAAGZonRfK1gqGU0jQS9H8dWTvkz83Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOrSM2agNde6lSrJuUWZjwGxo5NOTVNRBUqVgivn0VtMD+hZ8wDpokFzRIGCJLxSILxpo0kYDPlIN+ail1jtb69p72iEvs4K1Zc3suCB2VwIBRXNwGzsy2YApLMFrhz5/Z/2HF6TWIBTYtjU9jpPpC/0DetczHinkFmTJu2RhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i0SIwRnj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GmxmX7xrm7oMSRRjgOAZmJxS1krGg+CXbAgcKq/qc7Y=; b=i0SIwRnjFHYeaEkrNGftS41aij
	E4KbxduoE9eNWAH+7Z2srxeidPu/rJu4P+XRYMd1rI3Wf090hiZIWCVCRpX2S0sx+PGQV+p9TpUT7
	V11PSo9MC9SpLCfyhZNgJrqOQ/hF6evbFWa7SgGiOe3x4JH3PNBEdPo3M+SvlfU3YFwc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9BqH-00CWQL-9j; Fri, 08 Nov 2024 00:23:09 +0100
Date: Fri, 8 Nov 2024 00:23:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	ratbert@faraday-tech.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 3/3] net: ftgmac100: Support for AST2700
Message-ID: <1f8b0258-0d09-4a65-8e1c-46d9569765bf@lunn.ch>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
 <20241107111500.4066517-4-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107111500.4066517-4-jacky_chou@aspeedtech.com>

>  	/* Setup RX ring buffer base */
> -	iowrite32(priv->rxdes_dma, priv->base + FTGMAC100_OFFSET_RXR_BADR);
> +	iowrite32(lower_32_bits(priv->rxdes_dma), priv->base + FTGMAC100_OFFSET_RXR_BADR);
> +	iowrite32(upper_32_bits(priv->rxdes_dma), priv->base + FTGMAC100_OFFSET_RXR_BADDR_HIGH);

This appears to write to registers which older generations do not
have. Is this safe? Is it defined in the datasheet what happens when
you write to reserved registers?

>  	/* Store DMA address into RX desc */
> -	rxdes->rxdes3 = cpu_to_le32(map);
> +	rxdes->rxdes2 = FIELD_PREP(FTGMAC100_RXDES2_RXBUF_BADR_HI, upper_32_bits(map));
> +	rxdes->rxdes3 = lower_32_bits(map);

Maybe update the comment:
        unsigned int    rxdes3; /* not used by HW */

Also, should its type be changed to __le32 ?

> -	map = le32_to_cpu(rxdes->rxdes3);
> +	map = le32_to_cpu(rxdes->rxdes3) | ((rxdes->rxdes2 & FTGMAC100_RXDES2_RXBUF_BADR_HI) << 16);

Is this safe? You have to assume older generation of devices will
return 42 in rxdes3, since it is not used by the hardware.

>  	/* Mark the end of the ring */
>  	rxdes->rxdes0 |= cpu_to_le32(priv->rxdes0_edorr_mask);
> @@ -1249,7 +1266,6 @@ static int ftgmac100_poll(struct napi_struct *napi, int budget)
>  		more = ftgmac100_rx_packet(priv, &work_done);
>  	} while (more && work_done < budget);
>  
> -
>  	/* The interrupt is telling us to kick the MAC back to life
>  	 * after an RX overflow
>  	 */
> @@ -1339,7 +1355,6 @@ static void ftgmac100_reset(struct ftgmac100 *priv)
>  	if (priv->mii_bus)
>  		mutex_lock(&priv->mii_bus->mdio_lock);
>  
> -
>  	/* Check if the interface is still up */
>  	if (!netif_running(netdev))
>  		goto bail;
> @@ -1438,7 +1453,6 @@ static void ftgmac100_adjust_link(struct net_device *netdev)
>  
>  	if (netdev->phydev)
>  		mutex_lock(&netdev->phydev->lock);
> -
>  }

There are quite a few whitespace changes like this in this
patch. Please remove them. If they are important, put them into a
patch of there own.

> +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));

This can fail, you should check the return value.

	Andrew

