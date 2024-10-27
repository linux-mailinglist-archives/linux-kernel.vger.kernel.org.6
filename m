Return-Path: <linux-kernel+bounces-383823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF639B2094
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB41C20ABC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EF818454E;
	Sun, 27 Oct 2024 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEzL4258"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8341DFE8;
	Sun, 27 Oct 2024 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062325; cv=none; b=YKgYp2u/rBOmPdqPsPsg8U14NNi6A95NQqNYKkrq/TL2qr3RbUIb25unMp5aCfaczG+08Gy1QqE6yKDU+mEJ29Vmhy62HF8JbRI0OVZix1ScF5okIJ4TMugJ6/HNHGZGdYJeGIe2K/vqeLd1Qm+TI58Fg85/yvlW0m9avCD/ds8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062325; c=relaxed/simple;
	bh=YQvA8AaVapsjmTVTAY2FtWHoPIl3pWww+615y5P3MVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2CRM7IyU2AT96uL9JR3IsuuOYNquxqgWGjk/ncVfc4JKQWAs2CU6iEhSoL/nNwrikBOuFXYonhifiPZEy9FEkDYvkg7OzSGUAkB0/ADlvGOp5HxIEnFCx9DdkWcPquZQjyq6UH7k51f6L6EF10ZjmH144GSZaySQ4g5ws55txU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEzL4258; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C105C4CEC3;
	Sun, 27 Oct 2024 20:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730062324;
	bh=YQvA8AaVapsjmTVTAY2FtWHoPIl3pWww+615y5P3MVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEzL4258ubi7gLAucsKes8CpIkt/0PJUde2W0lNeLxNeYwAvkwEj6ml8A1lXS/l64
	 11G430dKvGGQyQNTK8z0QlGR8QvcdQi82gcIP5Aey1ZzlKGGpWy6VF6Nw7j+A+zgtJ
	 WRh4hhPnsY5xoNfwUmOiuQbAXQhSyBIj8pMrLeCikpZqu59DAeW1ALwZLjFSaVbuqL
	 BttcfwHQLxxHclh2wq4Ci+WD3q6ABNtl4EJsZMdQ5YY2hYz8fI+DFVU8glTznoVnDb
	 aZmJ/kqWVwMQzUVhp6taLq0in7zgRqxNx3OAO49fU9c0OqeE8EAuCSFrAINoQL/2cN
	 iYX5BYYX2Ik/Q==
Date: Sun, 27 Oct 2024 21:52:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Airlie <airlied@gmail.com>, Jitao shi <jitao.shi@mediatek.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: display: mediatek: dp: Add #sound-dai-cells
 property
Message-ID: <5vjaxo652w5hici5hxi3t6o2r5vkggrz25lqvm3or5fip3svke@fttqk5wabxqb>
References: <20241025104310.1210946-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025104310.1210946-1-fshao@chromium.org>

On Fri, Oct 25, 2024 at 06:42:45PM +0800, Fei Shao wrote:
> The MediaTek DP hardware supports audio, and the "#sound-dai-cells"
> property is required to describe DAI links and audio routing.
> 
> Add "#sound-dai-cells" property to the binding and filter out non-DP
> compatibles, as MediaTek eDP doesn't support audio.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  .../bindings/display/mediatek/mediatek,dp.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> index 2aef1eb32e11..c05c2b409780 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> @@ -42,6 +42,9 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  "#sound-dai-cells":
> +    const: 0
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      properties:
> @@ -87,6 +90,19 @@ required:
>  

You need to reference dai-common instead, since this is DAI.

>  additionalProperties: false

and this becomes unevaluatedProperties: false

Best regards,
Krzysztof


