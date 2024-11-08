Return-Path: <linux-kernel+bounces-401628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A1A9C1D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFC1B259BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11951E5703;
	Fri,  8 Nov 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thlXps8Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BB1DA21;
	Fri,  8 Nov 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069129; cv=none; b=FbL2hOpF+/ICsc4MwG9355uSvhXW99Qzh65OFjQP8PEoHcyX1WU79AKZka5I2JLpbNy4BUyjFET4nB+YzD+u60TM8IMFMYwpRya31M7gb/4a1PV8BE3SDILFX3AdnKE2u6WYWMXgkSFmFjJHcgTsDXsJ8xty64rV0fqIObHXZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069129; c=relaxed/simple;
	bh=OTSjLYZ9CZLdTvXs6M+Ao3qZ+7v2e9k19DVGtbucSic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh07bxZzXjE0sDVA157DKyxGG+ZN7JruqWWGuLr1V+sBhVYyiHAFU2IQAO/7ah6MgAwfrXUqZPsRO9kQZsa80F/1YH7Y47jn62S69bCxdQQUuqqAZmAEXlCzn+/XTBG1+sR5kOE2iifuRCdZol1p/Glm8lkWGheCya2whjiK3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thlXps8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185C2C4CECD;
	Fri,  8 Nov 2024 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731069128;
	bh=OTSjLYZ9CZLdTvXs6M+Ao3qZ+7v2e9k19DVGtbucSic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thlXps8ZJocdFA3UPRDrvXaiiCEru2GJimSp8zo+cSiFyBtaPPVWIyjv57IESI9AF
	 O+xIRj7hmQNOrdrK2C4kxu+ngrYBxXEI2vtqxr1FKjF2RTeDqxUh9hTOhEm6zxWy9+
	 NmbH/K0z8F/UVdswFtDc7uGiKtR7enBggiINeMQdk6Lp1F4UuEW/B/K/y3xGkEc5xQ
	 QX8HnYdMQu/mpsx7Y1DEDpQjDI+XfRi5EfDAUult+xkXxwYgYqeG43PuRkTXq61bIe
	 kne8JaI1PlfgdR+0LoHJhCNE7vAuzNdvHmvs0//W4jVFSEQ4tS9iR+KnLt18rulb8p
	 yAX6LV9uPrztg==
Date: Fri, 8 Nov 2024 13:32:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: add stm32mp25 support for sai
Message-ID: <3nkoutm4uixuhetf5cputloooqzpvwhcnq6wklhu3euazmrybe@mjtjqnehfnvg>
References: <20241107155143.1340523-1-olivier.moysan@foss.st.com>
 <20241107155143.1340523-2-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107155143.1340523-2-olivier.moysan@foss.st.com>

On Thu, Nov 07, 2024 at 04:51:41PM +0100, Olivier Moysan wrote:
> Add STM32MP25 support for STM32 SAI peripheral,
> through "st,stm32mp25-sai" compatible.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/sound/st,stm32-sai.yaml          | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> index 68f97b462598..4a7129d0b157 100644
> --- a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> @@ -20,6 +20,7 @@ properties:
>      enum:
>        - st,stm32f4-sai
>        - st,stm32h7-sai
> +      - st,stm32mp25-sai
>  
>    reg:
>      items:
> @@ -43,9 +44,11 @@ properties:
>      const: 1
>  
>    clocks:
> +    minItems: 1
>      maxItems: 3
>  
>    clock-names:
> +    minItems: 1

This actually fixes the binding because it lacked minItems before :/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


