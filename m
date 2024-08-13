Return-Path: <linux-kernel+bounces-285400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1DB950CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC35286F76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E83A1A4F05;
	Tue, 13 Aug 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnk0fI1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9E1BF53;
	Tue, 13 Aug 2024 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576496; cv=none; b=e7J+yWsxE5kD41LWaeieUIu1JYOz4+g7Cn5yaixMHlE8pCOr6U26RawPn/B5/zfNramdGXuq5wTaP13Q8YI7qU13AmrwfipUjmCDeK/IAzr2vhTHgjXCmEJ9F5ZdO8j/Nn2mp2+PVOcK81QYyMCbLcF/8CO5G4Q67qOyVxupDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576496; c=relaxed/simple;
	bh=TFZ49Ns7Kf0xRnS/LrkyPrwzUsMYbfghsSEb2PzGBT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMJ7Y587xUyvJR9ycnsYcjj2UtCfxK3pApyaPfyqypJJO+B81KtVykFdQYuapARRkxzLPut2xpGDJ8+h2wQ1idt+ob7L40SkyNbN0BnlinwCJ+mtbP073GP4dw6zc+jVl3+5BXQ4kKozDz69CgW8hB/slAxmLWG+icKvy7wKvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnk0fI1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F82C32782;
	Tue, 13 Aug 2024 19:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723576496;
	bh=TFZ49Ns7Kf0xRnS/LrkyPrwzUsMYbfghsSEb2PzGBT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnk0fI1St0ZpMvptwuW4HlnIFE7UJY3sYdJ8s62UjJSMRmtKJAxfl5NIqVZrnaWet
	 7c1ymTPG0F3kg8uKcEc9f1yrHxEHbHoLhHthsb26qCyoYDYSyRQCunU66s+VZrNjwX
	 I+r2a3R4sFGqpA38mMRnJlp4djS/u60zR8IWFZhxZUsKd1S1+148k//9h719/1xQIU
	 6LbBEVcHgcbyPe2WqL0asT3pgwRSiYg4rq2Uhc+fLlteKtID6Gk5003d4ci57adHkI
	 ZZw8LWoVvPo/BiXpphFan8ZaVdLdZxl+Mfhp5E8Ryle9071cAnKGdL2Eby5ZWYc+ko
	 k3GLg+vTNq1zA==
Date: Tue, 13 Aug 2024 13:14:54 -0600
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
Message-ID: <20240813191454.GA1570645-robh@kernel.org>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>

On Fri, Aug 09, 2024 at 06:10:22AM +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
> >
> > On 09/08/2024 07:55, Ryan Chen wrote:
> > >> Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
> > >> AST2700
> > >>
> > >> On 08/08/2024 09:59, Ryan Chen wrote:
> > >>> Add compatible support for AST2700 clk, reset, pinctrl, silicon-id
> > >>> and example for AST2700 scu.
> > >>>
> > >>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > >>> ---
> > >>>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 31
> > >> +++++++++++++++++--
> > >>>  1 file changed, 29 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git
> > >>> a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > >>> b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > >>> index 86ee69c0f45b..c0965f08ae8c 100644
> > >>> --- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > >>> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> > >>> @@ -21,6 +21,8 @@ properties:
> > >>>            - aspeed,ast2400-scu
> > >>>            - aspeed,ast2500-scu
> > >>>            - aspeed,ast2600-scu
> > >>> +          - aspeed,ast2700-scu0
> > >>> +          - aspeed,ast2700-scu1
> > >>
> > >> What are the differences between these two?
> > >
> > > The next [PATCH 4/4] is scu driver that include ast2700-scu0 and
> > > ast2700-scu1 CLK_OF_DECLARE_DRIVER(ast2700_soc0,
> > > "aspeed,ast2700-scu0", ast2700_soc0_clk_init);
> > > CLK_OF_DECLARE_DRIVER(ast2700_soc1, "aspeed,ast2700-scu1",
> > > ast2700_soc1_clk_init);
> >
> > What are hardware differences? Entirely different devices?
> 
> AST2700 have two soc die connected each other.
> Each soc die have it own scu, so the naming is ast2700-scu0 for soc0, another is ast2700-scu1 for soc1.

Didn't I see in another patch one die is cpu and one is io? Use those in 
the compatible rather than 0 and 1 if so.

Rob


