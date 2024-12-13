Return-Path: <linux-kernel+bounces-444465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363829F0749
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB8D188BCF5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE21AE01B;
	Fri, 13 Dec 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTI6w383"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D71A01BE;
	Fri, 13 Dec 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081004; cv=none; b=JF2a58MFOq7advq+t0+QX0oDuIGXDmC9f+to+ej2neFK6gDjVTzx1HjdoEEI9lvrWhZhrHOuDD8Goe3fyCFR6/WC7TxyuQnfNrWkHO+CsbL8u020ySfgypor1ffxjzAXANnJLSW1utuETVZD4RZhYfLYPo8bvUTOz8h3tT7cc2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081004; c=relaxed/simple;
	bh=KbKB5YCDZA9yTA+Iw1bKR35cULdYFoJwU4n57hnFdQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zzf1ce/w2HOgBmXBFbDSESUDj6aRboRXeK1lipaORGsV4p058JaMSEUE5HfYg8LaCkwt3Z1ZEetlUnDub2ArHwxMqpP1ec0jVq5dBImWZl1IVbQ1VV9i5JnjfGGjIjaeKt1ZrVrFs2aq3p8BEV9oLERAr+44uHzyqvvySIsnNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTI6w383; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7878C4CED0;
	Fri, 13 Dec 2024 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734081004;
	bh=KbKB5YCDZA9yTA+Iw1bKR35cULdYFoJwU4n57hnFdQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTI6w383/zO6snxSzwKcY6fY1VJBftSajaKNIdR2NhVa4WpBwZ9zSQH9WwU4DXCVP
	 5ua5f/chT6s4C7bHfjSWb0V0PQWgtYAkd/1lgD1wRL6dDQmjJ7xhcjvBiTF9x1OPvF
	 Ja68dUdu/kdw+zSguTifgup7JuD9qB8AGtue/xbj5nO14AigiYA3VSqVzcVeFVOoZD
	 Ly+UQYf4gqfoiMnkBaksnaH616p1TiIg9MFC7l/BBe6LWTDe7/kXGBPL5+WaW7h0mm
	 QbqGW4OqXqr0l7FGPkVfaeehX/gqRapF8RplOjNLwGdxbwIRchIfyEo/+jTlEWV/Cn
	 V9QiFC+bySLlQ==
Date: Fri, 13 Dec 2024 10:10:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: dp83822: Add support
 for GPIO2 clock output
Message-ID: <wsebu52wdc42bktrlwja2fzzp23axlqidwgxrmh3h4naswedwm@ifi7m4wipud4>
References: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
 <20241212-dp83822-gpio2-clk-out-v3-1-e4af23490f44@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212-dp83822-gpio2-clk-out-v3-1-e4af23490f44@liebherr.com>

On Thu, Dec 12, 2024 at 09:44:06AM +0100, Dimitri Fedrau wrote:
> The GPIO2 pin on the DP83822 can be configured as clock output. Add
> binding to support this feature.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  .../devicetree/bindings/net/ti,dp83822.yaml        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


