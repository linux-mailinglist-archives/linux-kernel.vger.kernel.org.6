Return-Path: <linux-kernel+bounces-307081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAC9647A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD6C1F23789
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E61AD9E0;
	Thu, 29 Aug 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WI+Z8a48"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBAD18E750;
	Thu, 29 Aug 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940610; cv=none; b=J5BsxnuArn3KOIICDVQJeshgkFxj6snTGsojLw3ZU8X+ijhzYMfniDo1DFI7HVcl0ErSIAB1V3BmAiOb1/3fCwQRTZFjjpq0lDkTJcNxkbRPYo4j+QtkovbubfZLzvtTOunwj9EgOoBgv5DyZDxRrSqt87dPS9GHrTarFozrA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940610; c=relaxed/simple;
	bh=qTwOLDyuIJZS5WYFmgDfv4KEXGvXw9UoAMyimnM+OxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPsOiYosZx3yzuuT/9UeLIkRgzI/rzdFFGKtoo8Hp3n0hsccirz3nsHMneH3aawuk5y5sMky0S9RFxV9Jhk4nFMPQQeeXdK1ENo7mCjSElcFLIVM6wMueBhEkcfAN9ovLpMsJs+CU78DamIWCVw2VRLyg35TLt12PbrBFC6oCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WI+Z8a48; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C69EA40003;
	Thu, 29 Aug 2024 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724940605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u9iP8bCRJqK47kKnLBPXwytzrpV7PSNInp4gC39oES4=;
	b=WI+Z8a48GHLNMFT578dHsj4QyDLRExsKUPQ0TLHA88ybm6R1hCzAbfVmFQIgGU/6+QQbsX
	3/sZAA+/5d99NWipDtt1/z5DVbTuY1wKqgpLOp/tOdqpqSdHIQjSyjp5aPwVFO+di9F7/3
	XROqjXnbN61hjhIQGYPGlSvEqfTUOyXmVTmuYy3j177iPLiPq2dpSzxL7T7X5hm8uR4xgw
	oq+us58dKDlVcEGHCXdlLWWbzKQKB6hHFBwxrrm02m5lTHTBOJ0LNJG9bobClegUNwYvPg
	eJjXUZalKMzEaz8TJp/jEIILgeyIvZHRFjaBj4uiexGxa50xV0BGWWHtjLGD/Q==
Date: Thu, 29 Aug 2024 16:10:03 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: Add SAMA7D65 PMC compatible string
Message-ID: <20240829141003278e9ec2@mail.local>
References: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 29/08/2024 15:08:45+0530, Dharma Balasubiramani wrote:
> Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
> since the SAMA7D65 PMC shares the same properties and clock requirements
> as the SAMA7G5.

Shouldn't you rather use a fallback if you currently have no driver
change?

> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> index c9eb60776b4d..885d47dd5724 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> @@ -43,6 +43,7 @@ properties:
>                - atmel,sama5d4-pmc
>                - microchip,sam9x60-pmc
>                - microchip,sam9x7-pmc
> +              - microchip,sama7d65-pmc
>                - microchip,sama7g5-pmc
>            - const: syscon
>  
> @@ -90,6 +91,7 @@ allOf:
>              enum:
>                - microchip,sam9x60-pmc
>                - microchip,sam9x7-pmc
> +              - microchip,sama7d65-pmc
>                - microchip,sama7g5-pmc
>      then:
>        properties:
> 
> ---
> base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
> change-id: 20240829-sama7d65-next-a91d089b56a3
> 
> Best regards,
> -- 
> Dharma Balasubiramani <dharma.b@microchip.com>
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

