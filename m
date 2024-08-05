Return-Path: <linux-kernel+bounces-274848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8587947D87
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E866F1C21FEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E35F15FA92;
	Mon,  5 Aug 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM5LpTVv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971A15F330;
	Mon,  5 Aug 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870020; cv=none; b=Ze/tkxpPJQ3XN9KNmrQlU7v7dj8nsneOGWhFhxrohaRbo7YRGBqncR2OxRzHio29gUm7JQ0TrHvKdoJR4OUylLP6oemjT9YBDhuEjb/5SxG+CID11SB78gQzN32NVUTmqqfyAmE2eX3YuwiDlH0p3ph8+kEdWw3vvcKEyWcj41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870020; c=relaxed/simple;
	bh=tfgBwylZtYmd8rGUyotRtDhn3AR0oXSUI6WU08SNoFM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jQO3ZiB4KzRKK1hAEYOtl+un0XBvs2Yidm1T5fAsBt6dpPkcm+5qJ2FH0kvfjzxiPCI8Uw2z5ptR4QqzMc69wNIfdgv9RKdreqw/V/PtxdVp+d3qkPMUGoWG4yBA638MiktaSSv/KQkdQcXWtPjrmkacc6AQd+yzJeYgsYnw4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM5LpTVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B7DC32782;
	Mon,  5 Aug 2024 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722870019;
	bh=tfgBwylZtYmd8rGUyotRtDhn3AR0oXSUI6WU08SNoFM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eM5LpTVvX/fZXooVCAOwc4yavHLGQ1roRJNC0pbB26h1bCL8rShDYhUcpFGcOcFu8
	 XdDlgX1pnhK130l2Ud3MYs5Gq27gZeWM5NDsV7V6rg8vJ8bYc11qpnbBTZdJbG+5X5
	 LyxcEvBUg8nwW9i5EAaj8oiYWL1xQl2DiIXAfTnPJeOP7vaLQ/vhHUaa1tzNmW6oTP
	 F56lEjF1edaKRL5Y9BE93WCuIwWY0XLfXq3ucQwvucPZ8bH5U1d4E2/XO7x2de5Thh
	 ye0Y68n49cjBXkqxifFquTIISnoat1n0CW9LFWamehyLIyLg/sm0SP66PBoGSabqSE
	 1u7BjC7EGJJIQ==
Date: Mon, 05 Aug 2024 09:00:18 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 imx@lists.linux.dev, Shawn Guo <shawnguo@kernel.org>, 
 Teresa Remmet <t.remmet@phytec.de>
In-Reply-To: <20240805-imx8mp-tpm-v1-1-1e89f0268999@phytec.de>
References: <20240805-imx8mp-tpm-v1-1-1e89f0268999@phytec.de>
Message-Id: <172286967208.2710507.3691130639449006628.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: freescale: imx8mp-phyboard-pollux: Add and
 enable TPM


On Mon, 05 Aug 2024 15:33:27 +0200, Benjamin Hahn wrote:
> Add support for TPM for phyBOARD Pollux.
> 
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
>  .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-phyboard-pollux-rdk.dtb' for 20240805-imx8mp-tpm-v1-1-1e89f0268999@phytec.de:

arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb: tpm_tis@0: $nodename:0: 'tpm_tis@0' does not match '^tpm(@[0-9a-f]+)?$'
	from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#






