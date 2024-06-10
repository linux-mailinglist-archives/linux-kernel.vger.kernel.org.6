Return-Path: <linux-kernel+bounces-208888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2857902A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CCE1F239BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4857CA7;
	Mon, 10 Jun 2024 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHdfPePU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB45381A;
	Mon, 10 Jun 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052751; cv=none; b=RVv8h1l+4CzbqYbk11/0xSxXbkIBahoY5/MfCUpoKqkUAW96YFPqCWEEVumKVXPc23c5jzv7TbjpXxLajv1CbNrVm4r1XfJhkYATBSn3dt6AA8nDp//a8POs4IB8+OWnSo7P2cOYMrtzoggicQkIQdWoMAjdhF+UI3aZAtd60/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052751; c=relaxed/simple;
	bh=4hIjoTr6HdWSvD0G3QUg4Lr3Kco2HBimTods46JnAXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdAFbZ7UWy9K6bPFyz45McsxpW9ZXWQofToj09MOBTblarm7a8WIT2Tpe0TfRkn7EMqTpPT3UjlvIJxdhEU1EaONVhulMgTHNjRpC/2oq7ryaueQ0JkdCIJLmMhGJUljWXPI666rwrCMF3Ai1+gnJ731RkYV2UrdUtk/tviz5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHdfPePU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991A2C4AF48;
	Mon, 10 Jun 2024 20:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718052750;
	bh=4hIjoTr6HdWSvD0G3QUg4Lr3Kco2HBimTods46JnAXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHdfPePUc+heQmnwI98OvWFT6GG9U899x+utPnguM+6uox9EWwky8p1YE7XfixdXR
	 kgh+MOa8NDAyGqa2l20VYBAqScvFquLCPmShl8mQ1c2tVpOF+P5h3ssi19dYum9GJK
	 rFd2yJd9x8uEj4YfERBeL6vy/tdXkyexdtk8lyDLuvnOXP/mV0R/PmE37pPX56FX5C
	 eWeKjKs6s4Zt/vbRDXeeKUUnVkCKHWSgPAOD3ewEVHGoYNTztAywle8OfdvyV0ehUk
	 roDXW7X3SpY9dZ8+Q19NgDAbwTzcrIi5BRozgrTCc2wEjLgfNJIn9efUAP6ShrO491
	 uO5piI9NL+QOQ==
Date: Mon, 10 Jun 2024 14:52:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, imx@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: interrupt-controller: fsl,irqsteer:
 Add imx8mp/imx8qxp support
Message-ID: <171805274611.3064088.2841677280217853044.robh@kernel.org>
References: <20240528071141.92003-1-alexander.stein@ew.tq-group.com>
 <20240528071141.92003-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528071141.92003-2-alexander.stein@ew.tq-group.com>


On Tue, 28 May 2024 09:11:40 +0200, Alexander Stein wrote:
> Some SoC like i.MX8MP or i.MX8QXP use a power-domain for this IP. Add
> SoC-specific compatibles, which also requires a power-domain.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../interrupt-controller/fsl,irqsteer.yaml    | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 

Applied, thanks!


