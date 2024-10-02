Return-Path: <linux-kernel+bounces-346987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F21898CBB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704EE1C22699
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF9817996;
	Wed,  2 Oct 2024 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcVQM9e4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28C10A1F;
	Wed,  2 Oct 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841126; cv=none; b=YsKIYEqz6rFTLY/mcMisVMeF/NPkuhuS/oW11fheV/1P1AJkIfHR5DlL0wsu+nINK/iIAM3mTxQ2Qa4/EKtVPLTPbwDCxVNrzfZ5frRKXqChuqwK6PnWDsiiDRoqAoR9DQiPWrPlOlD4OQCiQD0XPt1b/wykZWSI+Jaajq4SVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841126; c=relaxed/simple;
	bh=bkjM4FOye5eJpAHMz4sA1rmPcGIjGRVUfeo2bqAcmAw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=DmnHZdV3PcpKzISEIZZ+wLMVDOBpUu3DBTkaIOo4r1cKnOqKjTn4NmWaOX4EZuNO5A/XW7wGGTECU9r1zhgQNhRuIRJnbFYmOiRjuID+yf2VeiJsX8tmWpm+WU4AT0EyOlYuZyOqPVl8v37kuj2YWQfKEvGVerYtdMH7AXPfdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcVQM9e4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBBEC4CEC5;
	Wed,  2 Oct 2024 03:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727841126;
	bh=bkjM4FOye5eJpAHMz4sA1rmPcGIjGRVUfeo2bqAcmAw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jcVQM9e43YW3P8p5vuY3BthF+i3Y2xldlx5G4mvxzUSIk+Vc6V5FhM5qiLdXnKdcr
	 2Acnz+jVDQ1oO/Swf0/2psiFIjM7l/qLr7jIQvYwZNOO/pcU0WuxMRpCOCJFVkbzC/
	 NMXjDQFiWV1/Gpp5+eQM1RBv5+JL4BP1r0qSSs0/6GH52R5HnMoKTdlQR9EijhyeLA
	 JcMk1rMaPsLdPEQp+v1+Zi8GXEnr1oJTquIKA09qgesUPtk+Ygozq/kPvF46/YK8M+
	 3eSkh1CqtVaDohNG9HQRshLzowvhEjAUb3/0Jq/M7lfvPpAUEewUXHr+5eFEPyQTu3
	 DVDwCjEyaASaA==
Date: Tue, 01 Oct 2024 22:51:01 -0500
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
Cc: linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, 
 Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240930212604.118756-1-Frank.Li@nxp.com>
References: <20240930212604.118756-1-Frank.Li@nxp.com>
Message-Id: <172784021530.525807.17173207157125562594.robh@kernel.org>
Subject: Re: [PATCH 1/6] arm64: dts: imx8qxp-mek: add bluetooth audio codec


On Mon, 30 Sep 2024 17:25:58 -0400, Frank Li wrote:
> Add bluetooth audio codec.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8qxp-mek.dtb' for 20240930212604.118756-1-Frank.Li@nxp.com:

arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: usbphy@5b100000: 'nxp,sim' is a required property
	from schema $id: http://devicetree.org/schemas/phy/fsl,mxs-usbphy.yaml#






