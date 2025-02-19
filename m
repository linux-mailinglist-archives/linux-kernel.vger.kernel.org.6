Return-Path: <linux-kernel+bounces-522553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE36A3CBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D87189BF43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A91257457;
	Wed, 19 Feb 2025 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4uNK/QF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F61DE88C;
	Wed, 19 Feb 2025 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001570; cv=none; b=dyy+I7ZOk3VZcyhRTftZzqwRfTK2oyP7jkUai9i/nedbcQ24j26z9uDpvQmZIbcEp+pDmr4ZZHMP6Hu13CC5FppYxt1Hm+i0b/G5yfXrrVb/TxXWyWpQTfhBqSuHYY8Mo+BP1hSooustgyLjel8ycCfc8/u5qu18CUDm4Wg0Zio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001570; c=relaxed/simple;
	bh=V7MoC2zW7sWj9u+pbh19DBSYNN547r5t17dp94udUps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZSy13OKR/gugrC995z0ojctWYmEdrZVaMP16IhRzd6jFgbBq7t2JVu8ciIPWqAtSis643XUczD4GTcxHw/03kWVdk3vIm+i8sh6v21GyMk9rgfgY0A37f7MPa8WxC+TTlzPIl9idtojgk4Z478W06gFiyEtAm/qlwY7w9N4SN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4uNK/QF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AEFC4CED1;
	Wed, 19 Feb 2025 21:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740001570;
	bh=V7MoC2zW7sWj9u+pbh19DBSYNN547r5t17dp94udUps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4uNK/QFChz31+NC+j93t7UkCweE7BJU+8DRtb5qgKMD17V9p+kNw2zDIIO1vcf4V
	 7blwlLDwnpnB5h3WQw8/R1wV+Z4BBR1gTWNuWT3e2X2QVzYwjVah/M5hA7uckzcEwX
	 WjAfPnV+wUDh70Nr6UHgVwTqA1LFuis5Be73wYFNK5+F8dPRMKLX0ZM3NYaQZAVLGO
	 p2Ntz7KzCdvedb7XHLHJmdNQsGgax8m/NF3ynNcTpJv+utMaBoqsIhqEcZ3frnR39k
	 /zVKGzlZimahEhGWr4De65FYDeOA5ReS7PPHrku4HCIy076XjZEKIcjLso0NLjNaOH
	 lJ/qVSgQcUz3A==
Date: Wed, 19 Feb 2025 15:46:08 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: firmware: Add i.MX95 SCMI LMM and
 CPU protocol
Message-ID: <20250219214608.GA3003788-robh@kernel.org>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-2-3aee005968c1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-imx-lmm-cpu-v2-2-3aee005968c1@nxp.com>

On Wed, Feb 12, 2025 at 03:40:24PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX SCMI Extension protocols bindings for:
> - Logic Machine Management(LMM) Protocol
>   intended for boot, shutdown, and reset of other logical machines (LM).
>   It is usually used to allow one LM to manager another used as an offload
>   or accelerator engine..
> - CPU Protocol.
>   allows an agent to start or stop a CPU. It is used to manage auxiliary
>   CPUs in an LM (e.g. additional cores in an AP cluster).
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/firmware/nxp,imx95-scmi.yaml     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> index 1a95010a546b14b1d3d97aa990c0305a551f2620..75f63819285b191a815dc4287e34d299983b1c40 100644
> --- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> @@ -11,6 +11,14 @@ maintainers:
>    - Peng Fan <peng.fan@nxp.com>
>  
>  properties:
> +  protocol@80:
> +    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
> +    unevaluatedProperties: false

Please add 'description' to these to say what the protocol is.

> +
> +    properties:
> +      reg:
> +        const: 0x80
> +
>    protocol@81:
>      $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
>      unevaluatedProperties: false
> @@ -19,6 +27,14 @@ properties:
>        reg:
>          const: 0x81
>  
> +  protocol@82:
> +    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x82
> +
>    protocol@84:
>      $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
>      unevaluatedProperties: false
> 
> -- 
> 2.37.1
> 

