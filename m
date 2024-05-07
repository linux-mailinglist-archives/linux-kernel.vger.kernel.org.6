Return-Path: <linux-kernel+bounces-171796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9C8BE8D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC04282195
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D616C44F;
	Tue,  7 May 2024 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpoiKtsC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E2165FA4;
	Tue,  7 May 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099179; cv=none; b=sYN/RKjuBxkAnRfaeKY4yN/Ghs/b3VbfzIORZaSk4YBgfvY4ZdUpKae8ddc/8wPT3WpS0MI76rJkJRL+mx+08NbZwmu2aiA2RljeSPF13Cuu2azEwVjjMF9O0JGytMMYy6A2c4jsA3DzQNn7JYx8F9AMvZPVdsajt1o5F0oc54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099179; c=relaxed/simple;
	bh=/5I1D7aRR2QRwr2mUkZwUa89+yp2b+yvvGuDrXWWovQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn2t/2RCvoR7JbjfuKUR61pnck/YmkYFMm7xzdP9gr/hGhUZVuIIxDDATQIfft+DPekDrU6ywfLcxUXZdEazOWNjvSJ3bIRD41NFmuTKHoEEWSizcsbwdnmj4pYh6XIbIKhsEuDiwlG/KvFSZd8RxE/CgDg22i34Rd84MEYpIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpoiKtsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98957C2BBFC;
	Tue,  7 May 2024 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715099178;
	bh=/5I1D7aRR2QRwr2mUkZwUa89+yp2b+yvvGuDrXWWovQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpoiKtsCDRWS9H1oYa/F6JwX9mrEjG8l7IWfcqtNn8AuxO8/CG1gIbh+CBbJ+550C
	 WAlUqrQJbhClxSfpmosuhoTg6boD5NTMroeZI9Fd8abpXOQEC8Qfb61cMnMWTcqHGJ
	 qc19+ywvq3bGZfGibwZ9QJ4MV75vqbdvXJoiTpNqc8OSCaY5cI20S51TOvsiyXl93Y
	 WXEaFYRfmR3uzX2eY9TGF9k1Vmkq5xuO8R7wXsQ5ZIef9QFo0svLZwoTEIgMskSn5t
	 fH+QFguKVRjj0sdmB5nqvzlmr5EutpSOO6F74VMLulMZCWuqpPJLvVVXw/9HQauPP4
	 YN1cqa1a8rv2g==
Date: Tue, 7 May 2024 11:26:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org, ck.hu@mediatek.com,
	airlied@gmail.com, linux-mediatek@lists.infradead.org,
	wenst@chromium.org, chunkuang.hu@kernel.org, daniel@ffwll.ch,
	tzimmermann@suse.de, matthias.bgg@gmail.com, jitao.shi@mediatek.com,
	shawn.sung@mediatek.com, linux-arm-kernel@lists.infradead.org,
	p.zabel@pengutronix.de, dri-devel@lists.freedesktop.org,
	kernel@collabora.com, yu-chang.lee@mediatek.com
Subject: Re: [PATCH v3 1/3] dt-bindings: display: mediatek: Add OF graph
 support for board path
Message-ID: <171509917467.817282.9286531892598521217.robh@kernel.org>
References: <20240502115622.248456-1-angelogioacchino.delregno@collabora.com>
 <20240502115622.248456-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502115622.248456-2-angelogioacchino.delregno@collabora.com>


On Thu, 02 May 2024 13:56:20 +0200, AngeloGioacchino Del Regno wrote:
> The display IPs in MediaTek SoCs support being interconnected with
> different instances of DDP IPs (for example, merge0 or merge1) and/or
> with different DDP IPs (for example, rdma can be connected with either
> color, dpi, dsi, merge, etc), forming a full Display Data Path that
> ends with an actual display.
> 
> The final display pipeline is effectively board specific, as it does
> depend on the display that is attached to it, and eventually on the
> sensors supported by the board (for example, Adaptive Ambient Light
> would need an Ambient Light Sensor, otherwise it's pointless!), other
> than the output type.
> 
> Add support for OF graphs to most of the MediaTek DDP (display) bindings
> to add flexibility to build custom hardware paths, hence enabling board
> specific configuration of the display pipeline and allowing to finally
> migrate away from using hardcoded paths.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,aal.yaml        | 40 +++++++++++++++++++
>  .../display/mediatek/mediatek,ccorr.yaml      | 21 ++++++++++
>  .../display/mediatek/mediatek,color.yaml      | 22 ++++++++++
>  .../display/mediatek/mediatek,dither.yaml     | 22 ++++++++++
>  .../display/mediatek/mediatek,dpi.yaml        | 25 +++++++++++-
>  .../display/mediatek/mediatek,dsc.yaml        | 24 +++++++++++
>  .../display/mediatek/mediatek,dsi.yaml        | 27 ++++++++++++-
>  .../display/mediatek/mediatek,ethdr.yaml      | 22 ++++++++++
>  .../display/mediatek/mediatek,gamma.yaml      | 19 +++++++++
>  .../display/mediatek/mediatek,merge.yaml      | 23 +++++++++++
>  .../display/mediatek/mediatek,od.yaml         | 22 ++++++++++
>  .../display/mediatek/mediatek,ovl-2l.yaml     | 22 ++++++++++
>  .../display/mediatek/mediatek,ovl.yaml        | 22 ++++++++++
>  .../display/mediatek/mediatek,postmask.yaml   | 21 ++++++++++
>  .../display/mediatek/mediatek,rdma.yaml       | 22 ++++++++++
>  .../display/mediatek/mediatek,ufoe.yaml       | 21 ++++++++++
>  16 files changed, 372 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


