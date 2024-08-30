Return-Path: <linux-kernel+bounces-308754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43196616B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF238283C05
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E3199FDC;
	Fri, 30 Aug 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX6Gpw1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D516F0DD;
	Fri, 30 Aug 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020300; cv=none; b=UzLAl+rnpPaxdQS5JdChZII0tJ90XvYwhgzgWuKZl3guOUarCAsnVRr6dQ33SEjBrCvY1Eg9unj/QbxQLZ7/BDSpD2p1QVtmwywhe8UiL+39Sz7TZgmR8EOu4+68I+oc/i1giD37mOOV9sAJeRAilZAtCuJ8er7W3yV79khiYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020300; c=relaxed/simple;
	bh=fzW3G+TfB+bO5ebL/bX9LdeCTen9lbExGhAdJz/gUE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCOYKhNKdjUkdcVhM/ZCo+oFU42QmpQJuYH2L8iFPtW2daQpwZmiOMVj7MrDE0wrORDCBfVyq3vQwj38PFDFslDTGxFuYBV0q7FLkJNcNghOrugRiaiiHNGhmT79puVsk7Ap+cp7UvAFoyXZMpgUBnFmBpsVJlHgXp/NYRetDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX6Gpw1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15310C4CECD;
	Fri, 30 Aug 2024 12:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725020300;
	bh=fzW3G+TfB+bO5ebL/bX9LdeCTen9lbExGhAdJz/gUE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YX6Gpw1iAM1qcXKu7BASnn7Qo45teZi4XXjDrmwn/Vm4TnZW3bXHuZf+aIV8rnhz0
	 7VJ9gf240vFlFx69v7Gytuo+daKbx/S4payvqKJCL+wpO6Oj2vwKuHWo7VYnjGJPaH
	 41rQ1hCheK7YWyiteSj1QCLB193pxleVPtw7pyJvPaKHgasT2isgNCGwpSMjSXlqGC
	 ec5a8ppcWoJn+0Tc8EDxaWlAPdgEfZCp/oJarZBv6gWXXd/cQRri2pRcMwEFPnD7H/
	 vm9Fdfxn+WilUW8TBmM/UkaC0ahgKu+wuig8BUCdyRxxq9ujl/xkxdJs1NJJWOBhSV
	 9hwmywR7owrdQ==
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2050b059357so14245875ad.2;
        Fri, 30 Aug 2024 05:18:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXia+W3NVa7gtupN3ZW7E5a69dWHXAOBZKOExiNEcgK+aMknr1uJU1/LCEnqrMbp1sJTt5eBeIBLeoF@vger.kernel.org, AJvYcCXuq8I5bvvPEh33rK6ZFWaVaR3JSkTHIYpHcXe73y9u4n/hIbGZ2kafFllWjG6v7/R8v8TSOnU0iSgfGXWi@vger.kernel.org
X-Gm-Message-State: AOJu0YxBycV7wOumDV8CFvOKEhOdZ1otB3WiZgZFO0yAW5NiEcV+R1jN
	Nw6Zl4xA3U7JRdkR6FJ5FYiy4yqMqp8LhpMDhFs7DcCuHMOnV/cWw/JRO71Qr3yrYgSY3u7nYjx
	sLEH2iC0Xoy+hE830XxKtOpbhNg==
X-Google-Smtp-Source: AGHT+IF2p5CQY3b8HPQl1+/RqA1ZHqHcuWEQh2qoVHx4PAKoc7yqtJdfN0iZ0lNlEvXu5ud9ENOdM8aJpEyK48XB/pY=
X-Received: by 2002:a17:903:124c:b0:202:18de:b419 with SMTP id
 d9443c01a7336-2050c524e84mr78003075ad.63.1725020299631; Fri, 30 Aug 2024
 05:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830084544.2898512-1-rohiagar@chromium.org> <20240830084544.2898512-2-rohiagar@chromium.org>
In-Reply-To: <20240830084544.2898512-2-rohiagar@chromium.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Fri, 30 Aug 2024 20:18:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-1bT-=jU4vCZTfe18Ks6WiAL=7M3y0eK3DyGkfWmsFKA@mail.gmail.com>
Message-ID: <CAAOTY_-1bT-=jU4vCZTfe18Ks6WiAL=7M3y0eK3DyGkfWmsFKA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: display: mediatek: dpi: Add power domains
To: Rohit Agarwal <rohiagar@chromium.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	ck.hu@mediatek.com, jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Rohit:

Rohit Agarwal <rohiagar@chromium.org> =E6=96=BC 2024=E5=B9=B48=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:46=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Add power domain binding to the mediatek DPI controller
> for MT8186.
> Also, add power domain binding for other SoCs like
> MT6795 and MT8173 that already had power domain property.

For this patch, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 5ca7679d5427..3a82aec9021c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -62,6 +62,9 @@ properties:
>        - const: default
>        - const: sleep
>
> +  power-domains:
> +    maxItems: 1
> +
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
>      description:
> @@ -76,6 +79,20 @@ required:
>    - clock-names
>    - port
>
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - mediatek,mt6795-dpi
> +                - mediatek,mt8173-dpi
> +                - mediatek,mt8186-dpi
> +    then:
> +      properties:
> +        power-domains: false
> +
>  additionalProperties: false
>
>  examples:
> --
> 2.46.0.469.g59c65b2a67-goog
>

