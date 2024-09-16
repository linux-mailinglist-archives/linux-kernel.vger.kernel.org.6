Return-Path: <linux-kernel+bounces-330984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2797A6D8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86783284D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FA15B130;
	Mon, 16 Sep 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KbPSoLkP"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881C158A1F;
	Mon, 16 Sep 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508371; cv=none; b=kfcfOfwjn5bnmX1O+dq0m6YEYmZTKO+qAdO6CRQlNu9aMZXygIvbEqgB11tSP3aHjf3h37c2wvR2g3nJg8TvB72FCAletMwhlLsuRufkzu/R7ZsauVvRS4ycEvVk6Tz2E7IB9X1A/aIGIo9Jd7RRibUGkQXeENDTQg8F/+fliZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508371; c=relaxed/simple;
	bh=4uA3yvxhGcyJm/hRudJ642pDYzrgInwohFwQ2QiPijI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8jPrqyuLWscCpsjFWEW4YXdr1ZA/GEIcrKEvrkTJrksQdEk76IwINCxRubUdvyQxDN05Px0NhYL+kXSaKWfDrKimrYfk9BmlzLQKyHH8IoM49mD7mxImX6yNbYDOSejleC8jOVIjc7i71eNyCT4fg/s0KqzSFEOAhq8Ep69BTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KbPSoLkP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8B2A923D79;
	Mon, 16 Sep 2024 19:39:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yp1IwWCoYNUG; Mon, 16 Sep 2024 19:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1726508365; bh=4uA3yvxhGcyJm/hRudJ642pDYzrgInwohFwQ2QiPijI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KbPSoLkPaT3Iyig84kQNoT1JHhpRH+vTj6BvS7EgQY1vQK7XqFz1xeb1apY3hjexY
	 OdpKeTOVNNk09a5Q62gq4sqks4/HFDhsBxmShdzpl8jGDhPXTFYI+qDIcS21zl969O
	 5owirBiEt9Aq/T8CYBSgsGJIYachaUBOsQXUlbmVgko51YTTzkMApXxEBxxLz4etBp
	 pkMSwuh6f31vVPoW1u8QCG3m5XsjEUk4KZjjXh8pAFTHhlVkLO8EtNyKdFezL3z/Pj
	 TMsRu4rEdG5H/XFiotaGsiVsLxVFz504S7mthCkyh6UTI73fjJf4aYBOR61pW5m719
	 c2pKS//7sgVsw==
Date: Mon, 16 Sep 2024 17:38:56 +0000
From: Yao Zi <ziyao@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: Possible misleading information in rockchip,rk3588-cru.yaml
Message-ID: <ZuhtMHgx8XlZaayp@pineapple>
References: <ZuIJgiN2xp6oPrHD@pineapple>
 <20240916-neuron-surfer-32db6440e1ad@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916-neuron-surfer-32db6440e1ad@spud>

On Mon, Sep 16, 2024 at 05:33:49PM +0100, Conor Dooley wrote:
> On Wed, Sep 11, 2024 at 09:20:02PM +0000, Yao Zi wrote:
> > Hi,
> > 
> > rockchip,rk3588-cru.yaml, dt-binding for RK3588 clock and reset module,
> > contains description of customized property "rockchip,grf",
> > 
> >   rockchip,grf:
> >     $ref: /schemas/types.yaml#/definitions/phandle
> >     description: >
> >       phandle to the syscon managing the "general register files". It is
> >       used for GRF muxes, if missing any muxes present in the GRF will
> >       not be available.
> > 
> > But after doing some searching, I found that clk-rk3588.c actually
> > defines no clock hardware with MUXGRF type. This is also true in in the
> > vendor code[1], it seems there is actually no GRF mux on RK3588
> > platform.
> 
> Have you been able to check the datasheet/register map for this piece of
> hardware? Does it have a grf register region?
> Wouldn't be surprised if it didn't, and the cause of it being in the
> binding was nothing more than copy-paste.

Have checked a public datasheet[1], RK3588 does have corresponding grf
region and there are only clock related bits in PHP_GRF_CLK_CON1[2].

But these gmac clocks bits are used in dwmac-rk GMAC driver[3]
internally, out of the common clock driver, rk3588-cru. So I don't think
the CRU needs access to the grf by design.

Best regards,
Yao Zi

[1]: https://github.com/FanX-Tek/rk3588-TRM-and-Datasheet/blob/master/Rockchip%20RK3588%20TRM%20V1.0-Part1-20220309.pdf
[2]: Page 836 in [1]
[3]: net/ethernet/stmicro/stmmac/dwmac-rk.c:1132

