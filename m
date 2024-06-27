Return-Path: <linux-kernel+bounces-233047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18FE91B185
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF971C22510
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81581A0732;
	Thu, 27 Jun 2024 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqrAhONa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C913FF9;
	Thu, 27 Jun 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523521; cv=none; b=sd+2pU0vgIQ/rcXYpO/retYXDYGEdp0xgJXbdmGi2jVdB8D7auII0bTYFTOxX9/0gjWK0hlqjiyzXilRJ+rtNx+4pu7UHoyGdHA6aH15ch+8/o5+VRlZ94ptF3rurBKzzmU3QMTTu3MpFEDW77Aelmeg0b7gs8ZBX5zuBvPGIpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523521; c=relaxed/simple;
	bh=sw6QJkUOx6dnvHnOUYkmwDviR+5bis7nK5kklIGe8B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtJaG1g8SlEYcNxpsIaXaji/il4UgYZ8eFcExxhomP6xOf3DACZsRjuu8jIg9kGg8+fsN8fn4sDoM9gxbHKj87rMY5bToRhwiih15V8h/qolfCf33+CYxONf0DLHbNSs0XBhIZKqOz8LZz6vlWRMffMck4i1mR7sqiFThYeyW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqrAhONa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D25C2BBFC;
	Thu, 27 Jun 2024 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719523520;
	bh=sw6QJkUOx6dnvHnOUYkmwDviR+5bis7nK5kklIGe8B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqrAhONa3b8WIQ5LFtilKlUEIBKRc58ZejXGCuDCIhhNavv15R6ocbrxAtJdukAq3
	 FaqCGgq5D79cWs7DpsS+7Dt9z+vMkhEkIv9NTJ1tc7U3z/LVPxmwONgM+sqOEZP+Se
	 IrGOAiEUFtUcGpGg/2u5TXujcynjDQc3mJ2yY2PXRd3vTKnuSXgSGlu5HXcPWpNpwC
	 gCU+kumkVWCX/RNvlXnBhnDwiszNVrbQaBPuZCAxxpFSqAoO275PVFEzqXvv/NdqfX
	 Tt17cLoclyJ5KHzaBcD6uGse95ob/oOeubV3ic+nWUAhu6H2Dy0oTXl87QuTF5COsB
	 KQeM8DU5j5zGg==
Date: Thu, 27 Jun 2024 15:25:18 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, Xiubo Li <Xiubo.Lee@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>, devicetree@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 09/10] dt-bindings: sound: fsl,qmc-audio: Add support for
 multiple QMC channels per DAI
Message-ID: <171952351643.593434.7474652355291518276.robh@kernel.org>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
 <20240620084300.397853-10-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620084300.397853-10-herve.codina@bootlin.com>


On Thu, 20 Jun 2024 10:42:56 +0200, Herve Codina wrote:
> The QMC audio uses one QMC channel per DAI and uses this QMC channel to
> transmit interleaved audio channel samples.
> 
> In order to work in non-interleave mode, a QMC audio DAI needs to use
> multiple QMC channels. In that case, the DAI maps each QMC channel to
> exactly one audio channel.
> 
> Allow QMC audio DAIs with multiple QMC channels attached.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/fsl,qmc-audio.yaml         | 41 ++++++++++++++++---
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


