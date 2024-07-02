Return-Path: <linux-kernel+bounces-238385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E4A9249BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F031F22E3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB693201276;
	Tue,  2 Jul 2024 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0jF5n0X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD320126E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954380; cv=none; b=BLBkAprTxMQKz70AiDM7UQQI0vdET5PrKfktWiNpbanB1MpMEgYgpzO+aiwFcU+iMgRapg/DDWrW4xmSra3ikDr5CfwayB2HQ6HhBlmk7enWQ86RF7XM2TPjGlSsPnSxJAnaK7WcVPEqhwaMeCrT9miEh/WxN3n4T7YIpcmTEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954380; c=relaxed/simple;
	bh=NyzwM0fsXKf4dXOAJKkuMhvtpscp3UAXzQ88ePFkdHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsBLUwCMseoN+KmPInNzJzow8GOwfUFLT4Z+Mh9mUjShSgImCit0gZZ63+QcF4P7j0/zmKs2lIq9odVxRil0BUzZzKu00IQZjT3hsSbhaQ/B/lEjeRO3IJlrvW+h6eugfLvP6nmFq9sBCx5BK1rMIoJXIdVXUYaD83hYgY4PLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0jF5n0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7ACC4AF0F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719954379;
	bh=NyzwM0fsXKf4dXOAJKkuMhvtpscp3UAXzQ88ePFkdHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T0jF5n0XmYOBWCFsIhEiFwCW709AF2iNAJBXPHQDhZ3ouUIflhHJtwIPSeAQkemwl
	 uvh5nDRj8MsScENuyxikrGs7trBmvGpceQ90A9jThyM6OwHTK1hSB47GteIED0mkfp
	 yIXfQgx1XVTTfS14P6B441+5oNJT53fpMKqRINxMzkGSKAywbiMtggfLmF/5MhXRyE
	 MR2OEIi2KWdc0w+AofhLDxqqtYNvgWMUcCMzmTV90XllmcI+M2rs3uGRjmGpiIo+bY
	 S7E4wTeW1JLVmvZdlftDTuGLXlMEsznlapdBUQq2P/lZic0fAeIbHo/yvEPyuqkLW8
	 0fIXzDl9OJV+g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cecba8d11so5683389e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:06:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRlKiGNUFPruzdTvHukTxFmRBXEUrWn4nRtKMiDPlPuUjrKnsmpVbuyw8FHBPh5fuhRwDmL+7lnl3Smy1cNm4XNTAxBVxw7oPxK8yf
X-Gm-Message-State: AOJu0YwEocLttv7gmykbD+9881A2JfNNTr5qztWyAJ/Q5Sc5dglp+u7f
	YemliLtiD86tI2ZkN8KxO0QFlgMs1rpTpzEYLVoaDWChMw4rfiK1ON+wm+cymltlOV3ghVFMKvI
	oluI5QXUW81lhpL2jD+J7NSX5NsxN1+vTW563eg==
X-Google-Smtp-Source: AGHT+IGUxDpnfmOI+j4i7sET5B6iGTwPCxoZxCFPXJYFFkWMGwCKQTKuc3id2P0lUND+5DiDyxhNNJ4MNomLGxiA7Lo=
X-Received: by 2002:a17:906:f185:b0:a72:b1b1:eb3a with SMTP id
 a640c23a62f3a-a751447b093mr634755766b.19.1719954357446; Tue, 02 Jul 2024
 14:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org> <20240614-dt-bindings-thermal-allof-v1-11-30b25a6ae24e@linaro.org>
In-Reply-To: <20240614-dt-bindings-thermal-allof-v1-11-30b25a6ae24e@linaro.org>
From: Amit Kucheria <amitk@kernel.org>
Date: Wed, 3 Jul 2024 02:35:45 +0530
X-Gmail-Original-Message-ID: <CAHLCerMuG92Sf8+BdqPLqh+x3YxBjD6YdYF2k+AxQcwCqerxzw@mail.gmail.com>
Message-ID: <CAHLCerMuG92Sf8+BdqPLqh+x3YxBjD6YdYF2k+AxQcwCqerxzw@mail.gmail.com>
Subject: Re: [PATCH 11/22] dt-bindings: thermal: qcom-tsens: reference
 thermal-sensor schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Guillaume La Roque <glaroque@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Anson Huang <Anson.Huang@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Heiko Stuebner <heiko@sntech.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Pascal Paillet <p.paillet@foss.st.com>, Keerthy <j-keerthy@ti.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	zhanghongchen <zhanghongchen@loongson.cn>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Andersson <andersson@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	imx@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:17=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Device is a thermal sensor and it requires '#thermal-sensor-cells', so
> reference the thermal-sensor.yaml to simplify it and bring the
> common definition of '#thermal-sensor-cells' property.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/=
Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 99d9c526c0b6..cce6624228c7 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -217,18 +217,16 @@ properties:
>
>    "#thermal-sensor-cells":
>      const: 1
> -    description:
> -      Number of cells required to uniquely identify the thermal sensors.=
 Since
> -      we have multiple sensors this is set to 1
>
>  required:
>    - compatible
>    - interrupts
>    - interrupt-names
> -  - "#thermal-sensor-cells"
>    - "#qcom,sensors"
>
>  allOf:
> +  - $ref: thermal-sensor.yaml#
> +
>    - if:
>        properties:
>          compatible:
> @@ -292,7 +290,7 @@ allOf:
>        required:
>          - reg
>
> -additionalProperties: false
> +unevaluatedProperties: false
>
>  examples:
>    - |
>
> --
> 2.43.0
>

