Return-Path: <linux-kernel+bounces-204624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245C18FF160
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0131C23E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289BD198E87;
	Thu,  6 Jun 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6OaxWdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921A198E71;
	Thu,  6 Jun 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689376; cv=none; b=iK1ragAi1I/hn2LCRxUUYAg8uYV4AKDwkitSirIRGGl1kSqokax9k7IVMsxyCRZnHGM3i3mwj3CgddDP03AEsntn95vaJHAKNn+ssNVc0wdQrXB4wBQOGqsM6qmFntFQ37s2B8Yxxyj4vhX50jJu1n6QzXhrSY4xnwMHsSXR9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689376; c=relaxed/simple;
	bh=KpO8JzF20TldS0blc+PrT4BkZ3qqahv212wlVVKXxhg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=A+wp3bq0ck/OWT3n0oT2t6xAS8sWRnWhCDckRLwNy295PAfkD0ZdE7J2pVKZFc6yMZLbqCgpJOwXEnaYG79ricUZptBTw4bpN4+zIiNHsgp9bZKq4ElxRK8yItcAt8AFzmw0PxJFyaiKwXWFwn5oPhck4HM6rAMsQc6A46Cif78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6OaxWdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3EAC32782;
	Thu,  6 Jun 2024 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689376;
	bh=KpO8JzF20TldS0blc+PrT4BkZ3qqahv212wlVVKXxhg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=U6OaxWdvVSIeQvMSIx+N+FFr/aK+8UDjCsgRnqvhGqK9envcCHphb+mikswmsS8M1
	 L8JhE1bWxsYTuFcxFgEQzAJIoh1kyYlNkG89i5zP+8UfDXBUvXJE1JPs4ZLDCMhi6w
	 WbycEp4NtiTv9G84BtmCdN2ktaJAbg9ZlmhKCe5FqIFILwKsKEnJAPFAsnxvWtFbaP
	 AvaXZIxRGb3ACzSw/Zj0i6zDxko5F6s8SvZ7DSAGSC0GcythidiQyZQ/iEJU1PxCj6
	 D7b55df8H6JSwf/0hRQrs+VI34vzwTOMpW2HfoXjxH/elxptpyrX9IqmmIyvZQws09
	 brfBfCYCNXGGA==
Date: Thu, 06 Jun 2024 09:56:14 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240605202703.1220203-1-Frank.Li@nxp.com>
References: <20240605202703.1220203-1-Frank.Li@nxp.com>
Message-Id: <171768925588.3793206.4383956652676926878.robh@kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio
 mu5, related memory region


On Wed, 05 Jun 2024 16:27:03 -0400, Frank Li wrote:
> Add imx8dxl_cm4, lsio mu5 and related memory region.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y freescale/imx8dxl-evk.dtb' for 20240605202703.1220203-1-Frank.Li@nxp.com:

arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: imx8dxl-cm4: power-domains: [[14, 278], [14, 297]] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/fsl,imx-rproc.yaml#






