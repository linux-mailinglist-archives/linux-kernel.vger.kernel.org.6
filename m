Return-Path: <linux-kernel+bounces-374890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45029A7195
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1232837E6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08201F7088;
	Mon, 21 Oct 2024 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrK/QYz2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B61F131C;
	Mon, 21 Oct 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533511; cv=none; b=YYBTBz9+9u/jmMegADpYTZXv+5wrwlFeVS8mndlHL3olGbFyTvsVXeNtbd7HW5zxbl9dVQXlQbvAkVRlwgFx53PvH3ukm15MFZR+KV6UVU+lYOnZ16U2PoCo5JtjDV8v07i3qYhCu+0Tl6uagoOwbSlhd5tzuiTkfjpUrfdXAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533511; c=relaxed/simple;
	bh=4PjbEw1WHe2byrx6rgRj932kUF7KpoXEY8hA0mTormw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=C0jjVa/R19j8FlIXvjTcXW+w7X+b65DqSqeeevFsoMp1YFqz945XXHNcEec3CLKkpoAC+apNDPxXb/KdobB1yu1eU7MsnfpVsjJi46qcbAo+rgCPq5z4q3NzUvWdjAbaAa5nGjrqM1BKP4bZZUA2Sp+8hndqV2cnEwtXba13Eas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrK/QYz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD11C4CEC7;
	Mon, 21 Oct 2024 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533510;
	bh=4PjbEw1WHe2byrx6rgRj932kUF7KpoXEY8hA0mTormw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=LrK/QYz2Z52/mNh5/0IP06LC15qWJZOAa/dCgA2ltP8mEfIQG6WCCgY0Xqr8HxEVb
	 NtQDNsfHfjUGFaCRly2p9y4SzhULkgCmuK/t2MWZbo35QonTLk5Kws3gcrHclW4jrK
	 Jh2CNlDqN4GIg+eqkrzPOKF2T9TWJjrdCLhm6nqL4Uzx8SH6mHAM8TdiFw1IafanVA
	 bLsQod1rciIXbzRWi4z4qG8OmhNDSoRLorwMwXXpaW4xR+9JwBJ7CMQAhSoShjLQ7i
	 tc/4ufobEQXk6KFVwpHwP+b/N4332qpKB57DEjMI/7bx68Upv61e80OPWd0FQ5BseO
	 XPBXFD/R7Zcpw==
Date: Mon, 21 Oct 2024 12:58:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241018182444.817848-1-tharvey@gateworks.com>
References: <20241018182444.817848-1-tharvey@gateworks.com>
Message-Id: <172953336997.748149.3894675959431217817.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add Gateworks GW82XX-2x dev
 kit


On Fri, 18 Oct 2024 11:24:45 -0700, Tim Harvey wrote:
> Adds support for the Gateworks GW82XX-2X development kit
> based on a GW82XX baseboard and a GW702X System On Module.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-venice-gw82xx-2x.dtb' for 20241018182444.817848-1-tharvey@gateworks.com:

arch/arm64/boot/dts/freescale/imx8mp-venice-gw82xx-2x.dtb: magnetometer@1e: st,drdy-int-pin: False schema does not allow 1
	from schema $id: http://devicetree.org/schemas/iio/st,st-sensors.yaml#






