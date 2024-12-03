Return-Path: <linux-kernel+bounces-429702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 773049E28D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4C6B846B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E61F75B3;
	Tue,  3 Dec 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LnB4d1FL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6E1F7071;
	Tue,  3 Dec 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237940; cv=none; b=S7Uz1uV6GCnJNVlTAA3vrMQFovf1P7VVxesB5PSfHNbTN4J6HG+IMiRH1RobFrL0UQI8O9w4h9NdRBQcVy+yEPW/qqqvOMc5tb19IZzBRXreXwgxPMJUhnglzvUDbqN+fciLkRpkU+qo978F7xhGo+mEblGjVRCNp1ADdheav24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237940; c=relaxed/simple;
	bh=tInhdEsQvO5/sVLGY5Zzicbns+gadmFD8V+laCIIyfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkKtelMCP4KizCguYw/Od7TjN6GOmAv76m4++3R9iMTHNBo8297YiMa6TeHtYhhibuL1lgfc9qLYN46RQ+zLMIn6s58vd83KcLrvNqxk69HIspzj+UP4dSd0QqLjPYXxIXPuZJ6cUukR9APZY+3UbYjvIHnmsYYIkeonKWGQCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LnB4d1FL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=AQfWXnwBtjN4+gVX0bHkzy3HHnT2/jPXP6zHmg2fCvs=; b=Ln
	B4d1FLm6hFKT1zzUVBGaUbFqCSIXxlRMFuTgS6FHvoDQDHLEdDcUOJ8gi8ngmraFhNAug/S96vt/i
	t3QOSt5H8yDbjbaPbKmXFEjhTgrH+vleuSIwL0JbIp+/p6Xs3FsMCIm+Nafv2zdnT/daIZdJpICGx
	oZHrT0RltarQVX4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIUMM-00F6Nb-5j; Tue, 03 Dec 2024 15:58:42 +0100
Date: Tue, 3 Dec 2024 15:58:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
Message-ID: <ba09cea2-4cf7-4203-ae98-ea5d8413f69e@lunn.ch>
References: <20241202023643.75010-1-a0987203069@gmail.com>
 <20241202023643.75010-4-a0987203069@gmail.com>
 <9f2c8532-8e52-439a-b253-ad2ceb07b21b@lunn.ch>
 <75eb13d7-b582-4056-b707-706865611706@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75eb13d7-b582-4056-b707-706865611706@gmail.com>

On Tue, Dec 03, 2024 at 05:12:24PM +0800, Joey Lu wrote:
> Dear Andrew,
> 
> You're correct. In the stmmac_hw_init function within stmmac_main.c, whether
> pmt is true is determined by checking the pmt_remote_wake_up bit in the
> hardware feature register. However, our hardware configuration only supports
> magic packet and not remote wakeup, so it must be overwritten in the glue
> driver.

Please add a comment explaining this. 


I'm not sure why the original code doesn't include magic packet as part
> of pmt.
> 
> source code:
> 
>         stmmac_hw_init() @net/ethernet/stmicro/stmmac/stmmac_main.c
> 
>         priv->plat->enh_desc = priv->dma_cap.enh_desc;
>         priv->plat->pmt = priv->dma_cap.pmt_remote_wake_up &&
>                 !(priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL);
>         priv->hw->pmt = priv->plat->pmt;
> 
> Or modify the condition as follows:
> 
>         priv->plat->pmt = (priv->dma_cap.pmt_remote_wake_up || priv->
> dma_cap.pmt_magic_frame) &&
>                 !(priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL);

Are there other glue drivers which would benefit from this? It is hard
for me to say if you hardware is odd, or if this should be a generic
feature which other glue drivers would use.

	Andrew

