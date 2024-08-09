Return-Path: <linux-kernel+bounces-281556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC794D81E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B433A1C22E47
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D516849C;
	Fri,  9 Aug 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yiD3owdv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F88160860;
	Fri,  9 Aug 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235351; cv=none; b=m45R70IVEwCiubZAcpeFffcUdmQn+Ih9L1TF6eOh0eMK4rD2h9VUxIp+paABKnuy4fQApz8DOHH+jkLbqSPfC7CCSkYseJ2dPiuUmm6vQnb6P9iHSup32Mv+d8xfom+awD9PuI5e+LasMPX2/pVw0WDLTRpfSKLaN0P7Y2KRkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235351; c=relaxed/simple;
	bh=nVqkkeyrmTGgcnXfRITtsKBO6z2Z2/JVkTYqk/m0Kvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdxR1NClyzpR1K5GC33g9HUQHRkix/nvlWNqwwRdmpInpL3YPb2ncLjDprpA1slkMPHoZHCxh1SUQSY1U485gxG8TNQa+QcEbePuAvfXbm0nG+qJPgU88/osU2ThU82YrBNuAoLPWXFSe0kFPehacG+vQQbfErI5Zc7xWVWi0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yiD3owdv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=isLbLvrwXTiBIaXavkcKvINqHF3YJCSZSXuu1C1UwDM=; b=yiD3owdv4/je/By6Ovp+AfbJa3
	tiNOosS+uRqMilg5a1oJjpDHtaAbAGe08MK5zFHvqRbDJHTPD+sz8uqoXDQ6hA7RO3F3XytTeWsM/
	zaWIvS+H/+1KiQcFL0wgSeN3WbUjpSyduQjvVSUC6yLcdrVGzPuP0l//IdU/8f1G3rjU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scWEM-004PfJ-MO; Fri, 09 Aug 2024 22:28:58 +0200
Date: Fri, 9 Aug 2024 22:28:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ende.tan@starfivetech.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, leyfoon.tan@starfivetech.com,
	minda.chen@starfivetech.com
Subject: Re: [net-next,1/1] net: stmmac: Set OWN bit last in
 dwmac4_set_rx_owner()
Message-ID: <6ad2c74c-b187-4ac7-9303-c661e02b9b1a@lunn.ch>
References: <20240809153138.1865681-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809153138.1865681-1-ende.tan@starfivetech.com>

On Fri, Aug 09, 2024 at 11:31:38PM +0800, ende.tan@starfivetech.com wrote:
> From: Tan En De <ende.tan@starfivetech.com>
> 
> Ensure that all other bits in the RDES3 descriptor are configured before
> transferring ownership of the descriptor to DMA via the OWN bit.

Please leave at least 24 hours between versions. If you notice
something wrong with your own patch, please reply to it and point out
the problem. And then wait the needed 24 hours before posting a new
version.

Also, this should be v2, and you should include under the --- how this
version is different to v1.

    Andrew

---
pw-bot: cr

