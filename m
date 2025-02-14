Return-Path: <linux-kernel+bounces-514590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA318A358F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E525B7A4904
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB67224AF8;
	Fri, 14 Feb 2025 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfSACwOF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C31F8908;
	Fri, 14 Feb 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521938; cv=none; b=KnU+JhUPSKnzjRh5M/XJ25BqQ1MctjM48utfkiCvRNpkAiXMpx5B4tcck1TevhMvYYNpb4G/gQh2vXQlcgPELYhOVoFvTf+SXWeHLAnvaBqAC7MSs/y07E7jV+jO4YPO2W4KjQiOeWdUV6iyznnB9rZpl5T2COChIRNFWI7YwJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521938; c=relaxed/simple;
	bh=tN0i1b2Ryo0EmqvdxJO9z1k6BEAOIIN5zWxqbfV8Kcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRgLqIbj+tgiF7H0Ml0w7Tk5cPWm3RctJAVgL+a5hbn/+pjJGq4inz1JtOp9ZTSP/o2m6ocGbiunKSz9sOc36xq62WUiIGxkGNQ/l3oo0M2v4KvZLKxzyDcQ7Wmhw7Xx+cDguVIqMuuiu0aHrn7L2hRz4h7/XbW9QY2uOfjMVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfSACwOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBABC4CEE2;
	Fri, 14 Feb 2025 08:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739521935;
	bh=tN0i1b2Ryo0EmqvdxJO9z1k6BEAOIIN5zWxqbfV8Kcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfSACwOFvN5KyJiGTJqktnaWcX+SReQU4KYs6iAqH4s+/mrv+SSAVc1pK1U7lNkti
	 gWukz6DpiK91mpEqJ75i9hS2rm6AnQ/RK4ktEz9MlGk8uO7JgX5G9NjtJa9/gV2yPp
	 YK95AGwC0zTSpwC0woI2ZVPHjWqoMGhPrKaABi108etXJ43b71cLsZzDpe0Bp4WbKw
	 58XIztO7Z3y1+lnF2yoYdszq2HMaxd1zPPvlYO0iKDcgEamFah14e+1CT+S8mWnOVo
	 3StLEcFoeUgDPDt5pOmJRl1m7DMK4Ndspc72aN8efgaqqRgaxusNPv/fruSjqXv/27
	 vMJH8H2MTcboA==
Date: Fri, 14 Feb 2025 09:32:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>, 
	Kever Yang <kever.yang@rock-chips.com>, Tim Lunn <tim@feathertop.org>, FUKAUMI Naoki <naoki@radxa.com>, 
	Michael Riesch <michael.riesch@wolfvision.net>, Weizhao Ouyang <weizhao.ouyang@arm.com>, 
	Elon Zhang <zhangzj@rock-chips.com>, Alexey Charkov <alchark@gmail.com>, 
	Stephen Chen <stephen@radxa.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add Radxa ROCK 4D
 board
Message-ID: <20250214-sophisticated-toad-of-cleaning-e9c359@krzk-bin>
References: <20250213145921.133412-1-detlev.casanova@collabora.com>
 <20250213145921.133412-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213145921.133412-2-detlev.casanova@collabora.com>

On Thu, Feb 13, 2025 at 09:57:15AM -0500, Detlev Casanova wrote:
> The board is based on the Rockchip rk3576 SoC.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


