Return-Path: <linux-kernel+bounces-224953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BBD912945
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03770B25EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F380BF8;
	Fri, 21 Jun 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r53N5aYq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198D3B78D;
	Fri, 21 Jun 2024 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982615; cv=none; b=RWkoTThC/H1aP5Injmak8VnSbi4sOE8xKAmAi5AjetjdXOobQ7C/GyK6S5stxCBUj4rGX0JYV14HctwUm/Kpru3YZ4+N6hnev3/yVJHqwdbJPULuKHkcEdh+ZnqvS/WiYojvxPtzy41R+h6a09kUuFev1nHeOQRlJz+F7uCMRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982615; c=relaxed/simple;
	bh=iQEwxLn6QIG/MkdhhWiNcsV9/fo3VpAg6CAxSi6yeTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXs0vxoFdi8VWmLx6jrvia02XjpI6CxeT2g2AURl+9OXdhQWOYOzzkSgsQFXolXHXF4fRPwdj1nR6LCF6060+rYZpQuRHUfnSfFHuSNrfy0MFWSsCRnyzaZf0JzdYYoz3WfXou32UcOlyEcALcqjQ2wTvPiJwRB5Qr7mS0D4jHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r53N5aYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B46C4AF0E;
	Fri, 21 Jun 2024 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718982615;
	bh=iQEwxLn6QIG/MkdhhWiNcsV9/fo3VpAg6CAxSi6yeTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r53N5aYq9bMISOM9Z8jqS6gNw8mqhwaOtJUwiUiWPg7/Gc0tYEK89Z0mFayJAsRm0
	 QxToqdrG+j1YBgz2BwI7/ellh2Rp8y7o6d2Co8uHTfq3QurDtWcvBYNR3wdjJjhtSK
	 9SuFj+vSWRviLCFl0yI2yqiQTSAn0m+NpyeRVeWdiCNz294m82+ERyflg4v7ZC61UP
	 Bv38hwCXemtGG4joqifpJRGXKroK8EcXxU1xTIQKuzubHAwA3N1+zEXj6yF8f5cSBR
	 RrO548PhjkHhd3gKIIGxBcLO4aSoU7D9/oBgIOb0s3Te4OSDsCQLRnq98Q6IjxP8lk
	 fNQLWBbiUe3Ow==
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9c2847618so18674795ad.1;
        Fri, 21 Jun 2024 08:10:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYpvraLuJksF5fEZXH+TU2x8xoSU7wpOnJtYQJMi5BCbOyGybtvEELOTwpga5HYUZnnigtYVRSOXr2shZj9VVuV5a+QjWmJ7SRjK3DxogJPJLN2Vp64yiCfL9RptewZfd88aBihLD8qA==
X-Gm-Message-State: AOJu0YweI/vvjBvacYGOe1tJbn47hFbqH9Czcl7+g59PWklxE8oFpF4M
	5YR+OecI51zG6j3adA273PToezxeOSxjC/mfzEzkUhfoyC1JIYBPgcl10WEloe/zVir5dRlNhEy
	DyacEuL0tTFowbLZv+DwKmpKnyA==
X-Google-Smtp-Source: AGHT+IF2PuJp1a6SMbW/SdQNvApziWiiOJt+0KEve4Q/7ExVqLow2RhqAS5x8tGBSiZlziTGDOzHeXpmGi8gvfXWw+Q=
X-Received: by 2002:a17:90a:d42:b0:2c8:655:87eb with SMTP id
 98e67ed59e1d1-2c806558914mr4058671a91.9.1718982614665; Fri, 21 Jun 2024
 08:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com> <20231023-display-support-v4-6-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-6-ed82eb168fb1@baylibre.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Fri, 21 Jun 2024 23:10:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-sk1aoXdG=Wq_fMAtCxqA=VC+GVOMURhaDadXnBqm_kQ@mail.gmail.com>
Message-ID: <CAAOTY_-sk1aoXdG=Wq_fMAtCxqA=VC+GVOMURhaDadXnBqm_kQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] dt-bindings: display: mediatek: dpi: add
 power-domains property
To: amergnat@baylibre.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alexandre:

<amergnat@baylibre.com> =E6=96=BC 2024=E5=B9=B45=E6=9C=8823=E6=97=A5 =E9=80=
=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Fabien Parent <fparent@baylibre.com>
>
> DPI is part of the display / multimedia block in MediaTek SoCs, and
> always have a power-domain (at least in the upstream device-trees).
> Add the power-domains property to the binding documentation.

I've tired to apply this patch but has conflict. Please rebase this
patch onto latest mainline kernel.
Other binding patches in this series is applied to mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 9273cf7d3942 ("dt-bindings: display: mediatek: convert the dpi bin=
dings to yaml")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 5=
 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 6607cb1c6e0a..169d054d81ff 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -80,6 +80,9 @@ properties:
>        - port@0
>        - port@1
>
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -99,11 +102,13 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/power/mt8173-power.h>
>
>      dpi: dpi@1401d000 {
>          compatible =3D "mediatek,mt8173-dpi";
>          reg =3D <0x1401d000 0x1000>;
>          interrupts =3D <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
> +        power-domains =3D <&spm MT8173_POWER_DOMAIN_MM>;
>          clocks =3D <&mmsys CLK_MM_DPI_PIXEL>,
>               <&mmsys CLK_MM_DPI_ENGINE>,
>               <&apmixedsys CLK_APMIXED_TVDPLL>;
>
> --
> 2.25.1
>

