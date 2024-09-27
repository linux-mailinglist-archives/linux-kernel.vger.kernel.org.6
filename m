Return-Path: <linux-kernel+bounces-341543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA64988177
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC15B222D2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F21BAED6;
	Fri, 27 Sep 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hkxn8Mp8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7916B75C;
	Fri, 27 Sep 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429825; cv=none; b=Z+hhbWZ3h5D6WEPdjZghxTBeL6sYinei6gs6o2FQ0r5SxHAiMPhMqJBv1eKGYUYDGszqiwQXWQCdATalSkgauXZ2tp8yzsv/69KoZZ2KUyL6KG3mn4JLg14GFY9PPqZbLwK3eIhjyrFdHKlQMR3OcQ1JZKzR7a+XQsu002nvBDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429825; c=relaxed/simple;
	bh=SyUAj6YH4ZWfBAbLc9RBIAhggRIMEKY1PFIqF4T7pRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmV2YAiShz8KKAiubSrPT2QHzthqhbdFXOmIz3lUsJCZ5dmnaPM7LuUGicdAL4DgFzd+vxAUGtwFBhA1dSTtifxN+/1X+SmWO4A5xyVdXbFQkKCHXAJ80s+/MVLtifQS1XBg3D8cQlHHddhzfET+/jhRpwf5cOKrFqoqwL+FK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hkxn8Mp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9CCC4CEC4;
	Fri, 27 Sep 2024 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727429824;
	bh=SyUAj6YH4ZWfBAbLc9RBIAhggRIMEKY1PFIqF4T7pRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hkxn8Mp8CzphuZ480+VHOuXSuKHwmeCfwN4Vl3uBdwUd2qUaesBeFZeg+CR8YBPmF
	 YHseFh2rCE4m4jb5vvPxjHcL0oYSfkCPTlG5OQuZXMSCU/HKvqTxfq9jgCZ7w0RsjA
	 XRhqX1oYrtWTrlxqfi0Xwhe8pfJMx92oy0rf1OrxbNvoS+d4GDinu4oQMG/lMJILn3
	 fVm0/d/FQZ0nKYQcVemdtj8hqpYw0dtP++aAHmQjIHWAIXE5ZC5gRWKs9GiUlT2fnr
	 5OWy0rJqBvNtFwjYn90Zjc+rk5VOyQ9fkyXvuBM8N+jR5H1bxYDGiX2jFG/ejHnUzL
	 OlxD3EVbSXDbA==
Date: Fri, 27 Sep 2024 11:37:01 +0200
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
	linux-arm-kernel@lists.infradead.org, Moudy Ho <moudy.ho@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v2] dt-bindings: display: mediatek: split: add clocks
 count constraint for MT8195
Message-ID: <pnpj4pexz6nff72kmk6thupwvp2dgkz32ye7o44qdpuctbewb4@kpokc7c2rflr>
References: <20240927055140.19688-1-moudy.ho@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927055140.19688-1-moudy.ho@mediatek.com>

On Fri, Sep 27, 2024 at 01:51:40PM +0800, Moudy Ho wrote:
> From: Moudy Ho <moudy.ho@mediatek.corp-partner.google.com>
> 
> The display node in mt8195.dtsi was triggering a CHECK_DTBS error due
> to an excessively long 'clocks' property:
>   display@14f06000: clocks: [[31, 14], [31, 43], [31, 44]] is too long
> 
> To resolve this issue, apply the limit by setting 'maxItems: 3' in MT8195
> additional condition.
> 
> Fixes: 4ed545e7d100 ("dt-bindings: display: mediatek: disp: split each block to individual yaml")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Your SoB does not match.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run  and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

> --
> The purpose of this patch is to separate the corrections for
> MediaTek SPLIT CHECK_DTBS error from the original mailing list
> mentioned below:
> https://lore.kernel.org/all/20240924103156.13119-2-macpaul.lin@mediatek.com/
> 
> Changes since v1:
>   - Adding functional descriptions and quantity restrictions.
> ---
>  .../bindings/display/mediatek/mediatek,split.yaml           | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> index e4affc854f3d..bce1b8b866ce 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> @@ -57,6 +57,9 @@ properties:
>    clocks:
>      items:
>        - description: SPLIT Clock
> +      - description: HDMI RX Clock
> +      - description: HDMI Metadata Clock
> +    minItems: 1
>  
>  required:
>    - compatible
> @@ -72,6 +75,9 @@ allOf:
>              const: mediatek,mt8195-mdp3-split
>  
>      then:
> +      properties:
> +        clocks:

missing minItems

Missing constraints for all the variants.

Best regards,
Krzysztof


