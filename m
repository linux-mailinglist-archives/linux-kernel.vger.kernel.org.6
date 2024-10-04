Return-Path: <linux-kernel+bounces-349923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4795A98FD66
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17141F234FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B012E1CD;
	Fri,  4 Oct 2024 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw2MCGp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD012AAC6;
	Fri,  4 Oct 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728023714; cv=none; b=YZfsKMFH5OCabS33jfoDhsfXm23iys6J90uv7BPrp031zXQEux/pSzycXlNchCpYEE3XTfoAdVu5mhuSraU5E5ay8zpIaLo3vK+R3m4FRBSpvkUgiANncgaEqLMX6LuRXSWOkWHVeRd4jU39WSxHPI+3l0Y2pkbBz6dO+fbENoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728023714; c=relaxed/simple;
	bh=jl7T+5WwqtroqvfChKzcUHISh4+13GhKzPmF41T9kb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfZzLW0sOYORVYfwgZL/Ht0npUF3K/oDoFnFdhHclIi3wfm/QJawwwTiVvBDnA2hPLokY2tSUy4gVFd3iD7Tu+fD7h5QhLCITKC6dssWUxIoy/9Y/APphT8EbPSEt1TzIIjIlyjKaMhmhYAYGwKuzGgJ1QPEnj/0c0fuCwf6+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw2MCGp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04550C4CEC6;
	Fri,  4 Oct 2024 06:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728023713;
	bh=jl7T+5WwqtroqvfChKzcUHISh4+13GhKzPmF41T9kb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gw2MCGp4xo+Jr9zBJnBd23K/f47mAe6echPEvacE0G3+nEMudx1iKOP9pWMUxsKkn
	 tp6GB+nSIfbQOr3BUn/wLowrU3ypk5dTbDd0NPFCF0uzwUnkYkZuoVcWyPkUJo5tTn
	 2YVYY0WwClMxyzmBlqQBsH9c+f1viVw7YXP/swCc30oKXm9ajBlE0gwK4JZrxIvLyI
	 DMb2rsII3cDJYqvAm8oo4kg8s2zh9DsubrnASD6Dbs9YqERGoj+SeSRU3mQS5eDLhK
	 A8i4wpwRlAQpdyNG8HQVYPMXJT2pAD0UjQqH6Nd48iRDqE6vhqJ5XBiapPjgzabRnD
	 zqd5krKAy4zFg==
Date: Fri, 4 Oct 2024 08:35:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Moudy Ho <moudy.ho@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "jason-jh . lin" <jason-jh.lin@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] dt-bindings: display: mediatek: split: add subschema
 property constraints
Message-ID: <ajydpbq4ygrfr3ahs5nuh72pdmbttus2kgjb6csxc3p4tcq5l2@dlmucrzchvgl>
References: <20241004031245.27514-1-moudy.ho@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004031245.27514-1-moudy.ho@mediatek.com>

On Fri, Oct 04, 2024 at 11:12:45AM +0800, Moudy Ho wrote:
> The display node in mt8195.dtsi was triggering a CHECK_DTBS error due
> to an excessively long 'clocks' property:
>   display@14f06000: clocks: [[31, 14], [31, 43], [31, 44]] is too long
> 
> To resolve this issue, the constraints for 'clocks' and
> other properties within the subschema will be reinforced.
> 
> Fixes: 739058a9c5c3 ("dt-bindings: display: mediatek: split: add compatible for MT8195")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> 
> --
> This is based on [v2] dt-bindings: display: mediatek: split: add clocks count constraint for MT8195
> 
> Changes since v3:
>   - Correct the compatible name for the mt8173 split in the subschema.
> 
> Changes since v2:
>   - Revise the commit message.
>   - Enhance the descriptions of 'clocks'.
>   - Strengthen the conditions within the subschema.
> 
> Changes since v1:
>   - Adding functional descriptions and quantity restrictions.
> ---
>  .../display/mediatek/mediatek,split.yaml      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> index e4affc854f3d..87f8477a7be8 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> @@ -57,6 +57,9 @@ properties:
>    clocks:
>      items:
>        - description: SPLIT Clock
> +      - description: Used for interfacing with the HDMI RX signal source.
> +      - description: Paired with receiving HDMI RX metadata.
> +    minItems: 1
>  
>  required:
>    - compatible
> @@ -72,9 +75,30 @@ allOf:
>              const: mediatek,mt8195-mdp3-split
>  
>      then:
> +      properties:
> +        clocks:

minItems, nothing in your commit msg says that clocks are optional

> +          maxItems: 3
> +
> +        power-domains:
> +          maxItems: 1

This should be in top-level, not here.

Best regards,
Krzysztof


