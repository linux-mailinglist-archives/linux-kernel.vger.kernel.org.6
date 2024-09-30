Return-Path: <linux-kernel+bounces-344680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF96A98ACAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C531C20C74
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A719993A;
	Mon, 30 Sep 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nNPgnn0T"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4415E97;
	Mon, 30 Sep 2024 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723885; cv=none; b=QEgCkfhzmohEOHA7uZu9sUO5i9NWr/17EAXLMieEZYGxB4QV0sBmOjFOC/QeB8q3n+B2NdPNMGnCxmn+Oswy66gRsRBlXYc/ux73ICVPV3EuRxyv/03hBvt2kjt/VYp90AoCKYfHJOs4cPP1gKk6aUThjHFmZ/tjDYobFmWajDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723885; c=relaxed/simple;
	bh=ukhf8G9BYIQqBAXdD/uKYiwph8lfzGIQAREJxwy2jbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blkTif4rX/ZLtx6wIne5XJNx0EeNUdgoZ5KyQlD0XLNVHgMDZfLbz2//buXxnr7Xpj8ezk3/1exjk/1IOYq8KIqsSE/i8tQl2H1/azPEtdygJZ1ynBsNVAfa68LPvNN6Ec1sFJ0Onv1KaC4bcvdzGiRsUzH7GCS3mGtNG3trmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nNPgnn0T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=qWKbZygsjr2RtwDX9i0gKQDPrH5sR1FZSuwO6Sb/yHg=; b=nN
	Pgnn0T2J6vaMpt3LVADX2ibEAgbSWUP92VRtTwiNb88MiU/nH3G/GW1wKD1Ff3MGcwu1El2EOjc40
	3O9c3kwVDGDkhWy8IVAnartJoavH1AwXBTtTqkT3DunEMyVjZ/EombOb+NiXY03KmrZcYdpxBu0L3
	SoYbrAseQGz1Si0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svLtx-008ekj-TD; Mon, 30 Sep 2024 21:17:45 +0200
Date: Mon, 30 Sep 2024 21:17:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: Re: [PATCH net-next] stmmac: dwmac-intel-plat: remove redundant
 check dwmac->data in probe
Message-ID: <ea008e5e-be22-4a59-9243-682be313fea2@lunn.ch>
References: <20240930183926.2112546-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930183926.2112546-1-mordan@ispras.ru>

On Mon, Sep 30, 2024 at 09:39:26PM +0300, Vitalii Mordan wrote:
> The driver’s compatibility with devices is confirmed earlier in
> platform_match(). Since reaching probe means the device is valid,
> the extra check can be removed to simplify the code.
>  
>  	dwmac->data = device_get_match_data(&pdev->dev);
> -	if (dwmac->data) {

You say this cannot fail, but my guess is, there are static code
analysers which cannot determine it cannot fail. As a result, those
developers blindly following bots are going to want to test the return
value from device_get_match_data().

You might want to prevent such patches by adding a comment:

/* This cannot fail because....

   Andrew

