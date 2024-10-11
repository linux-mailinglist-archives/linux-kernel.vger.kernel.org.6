Return-Path: <linux-kernel+bounces-361310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC099A692
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A551F23DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6A198A0C;
	Fri, 11 Oct 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS2i+gM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D145194136;
	Fri, 11 Oct 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657583; cv=none; b=idGcsXD6Trsp1Zqe7VY20SLxo8vkxYKxKgR+/lRnVmUcf45/HJdlTzd8vp013AEPAT+MXv1UzfLhFAbA2P9MeULS7zJHtXi/Y+ufkOi9xFh5vRHDnMr8OFswg669CU1XO8Z5dK4HTISTnXkh65uJwsm4RgB3gHjL/j35ry781QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657583; c=relaxed/simple;
	bh=pBEN1/vyriIRFf2Gu/9qrft6Go0BIv2zaruzGi1JSIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH6T0TOGmjfze8TEClOdvv96cPcCLrZEI/LqvDb7/TWioYsuSkncGXuHyfhbHMTRmUAHEgy6NhxA49TymhwiEQQectyPvMG777PE/NQvyqSum1BwqoHYK0AjDpl3GRy5UPMXKQrgK2+ByXkTM5fYdeWq7BenI8KxztmoiNB2rC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS2i+gM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4633AC4CEC3;
	Fri, 11 Oct 2024 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657583;
	bh=pBEN1/vyriIRFf2Gu/9qrft6Go0BIv2zaruzGi1JSIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kS2i+gM4pFMJMW284jPDb8tGBN8RM5rkp8g+Ao34Mjc2iDr3iiNwi0SH3tJpB9jkQ
	 YpehaCNWVAfHg9C2ulhwQwBy6jpINJdrghj4/qB3Rhddwcjy+sikyIy7ATn1/rD/Xd
	 PcBRX6T/AkQXHR4MLppdSHA6SwyKtB8btDMgB8jaHl2BMPL7DKFdmy8IBzDWzQNvh6
	 RzGEsHdyR42U/7yBxBFqKV33LhmTvFVszhsKg220sTghOtH4MY+Tvp2pA7qVh3DH22
	 FPWMxkxwyxuy83i0PBZ119uwuDsDxgpAbI1yYiK9hFsdJYYuDgXNAyMJyiNWKBA6ve
	 xE3TbzOTx/5mg==
Date: Fri, 11 Oct 2024 16:39:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, ping.bai@nxp.com, ye.li@nxp.com, peng.fan@nxp.com, 
	aisheng.dong@nxp.com, frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com, 
	linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: Add i.MX91 clock support
Message-ID: <h7tcpsze6gskue3gogiihl6leqy2cmfc2k7525pcqpxugewsew@l3melszsbsr4>
References: <20241011045736.308338-1-pengfei.li_1@nxp.com>
 <20241011045736.308338-2-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011045736.308338-2-pengfei.li_1@nxp.com>

On Thu, Oct 10, 2024 at 09:57:34PM -0700, Pengfei Li wrote:
> i.MX91 has similar Clock Control Module(CCM) design as i.MX93.
> Add a new compatible string for i.MX91.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


