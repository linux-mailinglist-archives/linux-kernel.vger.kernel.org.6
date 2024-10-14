Return-Path: <linux-kernel+bounces-363321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28EC99C0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677992838C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118B8145B21;
	Mon, 14 Oct 2024 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9PkUwvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624031304AB;
	Mon, 14 Oct 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889367; cv=none; b=sVKFMRMwGkYcc8p640oC3pKZGXkB+7ul77lWMLBdsnSEXQPXOiYYkowYib853qmg1+tQK/kSuq9nLh0rzrr2GbBOXkbPFTvWG7sDPHv/KH0tthr/2K6cic6nH35BRM9CoMMadfVPD/o5gY2FoBanmxHB9poH2w9NxK+zGCVMAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889367; c=relaxed/simple;
	bh=ae/kuewhXaYvT16f5rZyfMGwIHi+UjJJqJCdjw98xhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oycxmiG1uNjMiB3R+gU+YuameNlOI/kRqwm/j+Lg6Xj/T8Fq0jqrVggO6tqsjQlZxc7PxRnlXn6ylXHswL2fQRwbqJY56CZT5ehKm4x/L+Rz8k5R77pPf78YCWr6bQft9pvHUWEH4m+O2FQmfsw417VYBwp5lGsLPGrJB3XU1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9PkUwvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D624FC4CEC3;
	Mon, 14 Oct 2024 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728889366;
	bh=ae/kuewhXaYvT16f5rZyfMGwIHi+UjJJqJCdjw98xhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9PkUwvL/DZPMffblDZ5NlPm/D7muXaHDxRNet2UPtrfh9YgHR+Ox4o4rAIqFYrDf
	 +BcR01Immntq8icNXrPzgkY5wilbo2y3NAdLMtvuC5lVNRuyvBbJbYW2PQ6KQAZMvK
	 ZyJqXNzg8CAuKM4keGaDolHbiAkdu1NgTDWtUkTYoTq7kRKs+MgejDXPaF1Fi95dCT
	 zirCM0YkGr0Rp0SovnFguLA3QGJPkm+k7vyWG96yp70QX/h1mjsVddA1Rv6+7bnlJ5
	 gINVLvAg+X5wwX4hc7IxhRQOejQ3Qt5tthj2nrPwLqtUzAV6TJxH0Gnsq7r1/5xVF3
	 DlMbDpvjZo/og==
Date: Mon, 14 Oct 2024 09:02:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, ping.bai@nxp.com, ye.li@nxp.com, peng.fan@nxp.com, 
	aisheng.dong@nxp.com, frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com, 
	linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: clock: Add i.MX91 clock support
Message-ID: <cisnwpu3duvvbe4diy4jcwsfvho7mqmbhjqvq3af3wq3ubwvbd@vk7cwspeetq4>
References: <20241014182438.732444-1-pengfei.li_1@nxp.com>
 <20241014182438.732444-4-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014182438.732444-4-pengfei.li_1@nxp.com>

On Mon, Oct 14, 2024 at 11:24:37AM -0700, Pengfei Li wrote:
> i.MX91 has similar Clock Control Module(CCM) design as i.MX93, only add
> few new clock compared to i.MX93.
> Add a new compatible string and some new clocks for i.MX91.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
>  include/dt-bindings/clock/imx93-clock.h                  | 5 +++++
>  2 files changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


