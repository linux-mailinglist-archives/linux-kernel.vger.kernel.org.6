Return-Path: <linux-kernel+bounces-414401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BAB9D276E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C329285492
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7F61CD200;
	Tue, 19 Nov 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsJTgP7O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB91CCB3A;
	Tue, 19 Nov 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024544; cv=none; b=gvSYBoLfN+SUlr8OxwPK5wUE+ArjKGBxUMVSsDXKEXvqKxYkWxk+OxVQqApmfMX6DaLVSCydNjTsqTyn2ij+v6uziNRcxVzCx4+mm3thCh2c5CUt/TRqFG5UaY7+P+Y3JSW7iLXu9wGh+CzMM7Uj4SHQkqYgsEwlGsbqVnuPsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024544; c=relaxed/simple;
	bh=9LG7YsYWIp1ZG6/QT8ybq/ypWUP4L1y8uQRWVVB9QP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6anivfhziH1qpDR00SNooxXNedoCII96jydtQfRjyy9wiBdIJDOQNHKe2U1YHE9sBdDba0+SMIZefKGMw8arMN4wwuZD8aCan+kcpbrOZF53nwlitFUEfwNlp2bWX5t1DOngwGlBi3XyPLFMKwtFtREZ2Zr98MdjyKZHA/2yas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsJTgP7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0853BC4CECF;
	Tue, 19 Nov 2024 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732024544;
	bh=9LG7YsYWIp1ZG6/QT8ybq/ypWUP4L1y8uQRWVVB9QP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsJTgP7OUZXIMWJKyeMZcw4oMRTjB1QzhjHU/XJieZKkFtaSxjcm9jGsL7QOnJKKP
	 9wsiTgZtAdfc5ex+Z8lcLcYfEiEn+9Afb5BCY2x10kZlXSoxFZp83/ZWqLdJ2aCf1K
	 CuJLa+09f/K/pMwUbFhndD9j3Ot270HHENLdGagME3rJY+CzSLulnnciXpoC1OoZgn
	 xu0c5/sedTXc9/qCF4BgPlYIVeZ3JAIs+Lx12ixMbYd8anoM0NBDZ5EghYg51zSHl1
	 YWKHDpfs9BTixmrv5H4BiUZOx0uFpLhD31mnpCZS8gn0RBoLVY9jc8Cul0SbE+PMSw
	 hB8/YN7rz4kiA==
Date: Tue, 19 Nov 2024 07:55:42 -0600
From: Rob Herring <robh@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, catalin.marinas@arm.com, will@kernel.org,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, joao.goncalves@toradex.com,
	marex@denx.de, hvilleneuve@dimonoff.com, peng.fan@nxp.com,
	hiago.franco@toradex.com, frieder.schrempf@kontron.de,
	alexander.stein@ew.tq-group.com, mwalle@kernel.org,
	m.othacehe@gmail.com, Max.Merchel@ew.tq-group.com,
	tharvey@gateworks.com, quic_bjorande@quicinc.com,
	geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
	konradybcio@kernel.org, neil.armstrong@linaro.org, arnd@arndb.de,
	nfraprado@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, ping.bai@nxp.com,
	ye.li@nxp.com, aisheng.dong@nxp.com, frank.li@nxp.com
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Message-ID: <20241119135542.GA1076739-robh@kernel.org>
References: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
 <20241118051541.2621360-2-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118051541.2621360-2-pengfei.li_1@nxp.com>

On Mon, Nov 18, 2024 at 01:15:38PM +0800, Pengfei Li wrote:
> Add the board imx91-11x11-evk in the binding docuemnt.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>

You missed Conor's ack. Please add tags when sending out new versions.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 6e0dcf4307f1..5951317ce900 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1332,6 +1332,12 @@ properties:
>                - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
>            - const: fsl,imx8ulp
>  
> +      - description: i.MX91 based Boards
> +        items:
> +          - enum:
> +              - fsl,imx91-11x11-evk       # i.MX91 11x11 EVK Board
> +          - const: fsl,imx91
> +
>        - description: i.MX93 based Boards
>          items:
>            - enum:
> -- 
> 2.34.1
> 

