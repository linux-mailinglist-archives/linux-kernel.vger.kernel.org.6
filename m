Return-Path: <linux-kernel+bounces-540605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C2AA4B2D4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476C83A7F58
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3171E9B00;
	Sun,  2 Mar 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLEwWNmR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C81E3761;
	Sun,  2 Mar 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931622; cv=none; b=bmXbSBoD944EhsnOQh/K2gjEnVHLByBN9lfXbPAD3URFHjRfqVPDb8DL7kncwn/yrSGDgSGofdEBgYHrplnOWH3A2SNjRcZFjFTlCasO6CjJBjjfBj54DoXguZD/O/JYaZ0hHnduOuYEtBAxm3+HwHYHaexLMWP+j7e5y034FU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931622; c=relaxed/simple;
	bh=6Z1K2XeEqTJ+PjSTHPmZvbQCAwrBgXMnsTzeuQ32us4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYQM4fY3UUQXX0jw016HfZ/JbNSVgOWTq3LJ3PHnoX75L2mEZzmkW19Yhjz4rdO58r9WyXWb27frb+JTHTyuujiNvjeTyWL75OQgV/EyrGKSvcUd0a6RGOGVby8Fq5Z0uiol+hV2VnRgvzpDFBbSruqNIMXBG/99xy4AMoIXG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLEwWNmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D08C4CEEA;
	Sun,  2 Mar 2025 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740931621;
	bh=6Z1K2XeEqTJ+PjSTHPmZvbQCAwrBgXMnsTzeuQ32us4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TLEwWNmRzoxu50gGetzLmCrV55ix9FhhrsO+ah2335y0pn9Qi3RFBfkZYkYOMS2ab
	 j9TjFANBQb+7XL6fMzePFbbvwAN7fMzd+fPngIunbIpQ5mhvfdDzuEFiBkS9YU4WVs
	 zpJ38yLhwZYTN79b/EvKXeFBpHgyPRR1LG8yei1iV882TMyauEBkHI0lhsvb9Udwhj
	 khewVtukix9yqVAnPHB5w3JAXCfWS0Vtx3NR/1vcQp8NkoOoZZ97hBHfMdKuOTWxK3
	 MpXDyRlc4Btp+XN74DkPAyeUa0/j+hd/C0QFzKjkDfGb4Ke4tQ/96asbH8mU6mELPR
	 oVWCFltGcEQvg==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso644254a91.1;
        Sun, 02 Mar 2025 08:07:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUW5ouLqluKhtR6kbgCKj2q+0GW4GMPQrgkzX5JFiL6iwOUICAqtWM1/mlwvq2TeKUv8NlX8gSroXxM@vger.kernel.org, AJvYcCVlQXwbHDOh/s5LWPhOKrDFATodg+a9Hy0hsgC97/QTQNbrhXMRCIg9BC22JBnWOV8fVEkzGgV0iGuUW33e@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJRKvg2xCQjlHWwbH23HZUZM/worhMBcwdQnrZYs1vLRvhKxE
	oewGa9koFhDNeFyOPlnSOyYTWiEFaCE8HLTwhrKbynQQN+b9lpQc54WkYi+gv89PoooXF84pMgg
	pVC96yKObqRuaS55tZ3k+cgRbwg==
X-Google-Smtp-Source: AGHT+IGgpVK4aKVTw1AYLTQHunnH0lP0Xo7e0HySRK7+dlps4YjnoiELgWFMnKkx9EIddZ2irPPWBjpXbYwY6LnMy7Q=
X-Received: by 2002:a17:90b:3511:b0:2fa:1f1b:3db2 with SMTP id
 98e67ed59e1d1-2febabcfedfmr14936364a91.25.1740931620948; Sun, 02 Mar 2025
 08:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218090427.20318-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250218090427.20318-1-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 3 Mar 2025 00:07:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY__aFqL=LnE5vU2RP9JHmQEgkrvPmiYjxmETWo9CvwiwLA@mail.gmail.com>
X-Gm-Features: AQ5f1JrHQ_avSblgi4HZQ7x19rsI4_LP2M6FFBaV9IRM5Ur_SJsfW7MiHzcF_cw
Message-ID: <CAAOTY__aFqL=LnE5vU2RP9JHmQEgkrvPmiYjxmETWo9CvwiwLA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: mediatek: dsc: Add MT8188 compatible
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com, pablo.sun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2025=E5=B9=B42=E6=9C=8818=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:0=
4=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add compatible for Display Stream Compression (DSC) IP found in
> the display controller of the MT8188 SoC.
>
> This IP is fully compatible with the one found on MT8195.

Applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsc.yaml     | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.=
yaml
> index 846de6c17d93..a5b88eb97e3b 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yam=
l
> @@ -22,6 +22,9 @@ properties:
>      oneOf:
>        - enum:
>            - mediatek,mt8195-disp-dsc
> +      - items:
> +          - const: mediatek,mt8188-disp-dsc
> +          - const: mediatek,mt8195-disp-dsc
>
>    reg:
>      maxItems: 1
> --
> 2.48.1
>

