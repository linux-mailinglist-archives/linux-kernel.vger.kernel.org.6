Return-Path: <linux-kernel+bounces-574702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E237A6E8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F690173FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED71A00FA;
	Tue, 25 Mar 2025 03:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o30PFgTW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B719DFAB;
	Tue, 25 Mar 2025 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742873353; cv=none; b=kQ+LHEHCvM/FQ4dFYn6TmD7Y81OmCHy8Q2J5C5D+IwvgQNmRgvME34Gcb6DFwBs5wQzDkqUb3H09d1XlGxwwgXweoZd+kmeT3XIaM/prR1jOx7V7kcnfX5tBXMJFCk2qM2HhoUzl+2dye+0wwLc5N1hlSPDzGq562GtuURilMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742873353; c=relaxed/simple;
	bh=1+F2SiWR1EFj3utMdX7kCpEiQUqyD024EDV1S/WtZ48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogR2n2HRK/wIvkrkMQ37IfE5qj8xICVvl2tYFWmhNlPYgttHb69c/IA91x6yjOu0LxJoMmmmZmpxM30VKupQFc+0HzggylbQ/i8/gO5c/w7exNG/FWF2R3FYl+Iw7pbo1bjFi+gyVHlrCh4PsIaII7s6WSVIVNuaZNpanzaohaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o30PFgTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E1CC4CEE8;
	Tue, 25 Mar 2025 03:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742873352;
	bh=1+F2SiWR1EFj3utMdX7kCpEiQUqyD024EDV1S/WtZ48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o30PFgTW7i5eAuQ+6N5IBX9UwsrawBUIQ+zHPhdSefE7Jrd6SwDW0E4ec3cs704/Y
	 GiKwH6aZYKkRnT+07ghLQipoWdIECvaIfySbXPwJH2LYr+eAPbv5UoHIijxkfPLQbD
	 MWFn5NzZCqFi5yScLNDrKG/R5nCwqWuj3UqmVuJPoLy0oP61cfuc3DzGRdlq0e24FU
	 uuQ+5IfEDLsSZoVcilyQzXsQuu+k49rKz0gca+fxgTmIZa7FLgUF3UTD+ze/0oxzQV
	 +iuUSxRYOk6k2y3rLaopEKC/fqT7nqSgNgUbthyqpBjUMyZ3cnbLepbf8kvM+5W4Lj
	 fiI8eMehyFtyw==
Date: Mon, 24 Mar 2025 22:29:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Joao Goncalves <jpaulo.silvagoncalves@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	Joao Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev, Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: imx: document i.MX 95 Verdin
 Evaluation Kit (EVK)
Message-ID: <174287335084.1637326.11937495835125026079.robh@kernel.org>
References: <20250324234013.140440-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324234013.140440-1-marex@denx.de>


On Tue, 25 Mar 2025 00:40:01 +0100, Marek Vasut wrote:
> Document support for i.MX 95 Verdin Evaluation Kit (EVK), which
> used to be the Titan EVK.
> 
> Note that the SoM used in this EVK is a derivative SoM from Verdin
> line of SoMs, an actual i.MX95 Verdin SoM is under development.
> 
> [1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95-evaluation-kit
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Cc: Joao Goncalves <joao.goncalves@toradex.com>
> Cc: Joao Goncalves <jpaulo.silvagoncalves@gmail.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Max Merchel <Max.Merchel@ew.tq-group.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: devicetree@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


