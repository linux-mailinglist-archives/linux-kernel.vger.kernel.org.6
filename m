Return-Path: <linux-kernel+bounces-378272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9189ACD72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD581F22367
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91E11C9B65;
	Wed, 23 Oct 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnYAi8xh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7C1ADFE4;
	Wed, 23 Oct 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694139; cv=none; b=SR2c5Ei6xt5sYN9a7beLcc+QYvekBA1tocjJHSE9cghitpiGHqv+06Blf7jyuVvneseYN/RZMluvI8KQ9GfvN3Xga1eoqG4sIhL0zHVuZ0JY4Wh5gjEt05wKRLVy+Hh/t5OuMnOLoyd3DXs22WOSELtE4kjM54afZA3bJE6194M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694139; c=relaxed/simple;
	bh=azQJ3eGowkkRjf7a7p4DUvh4rfik/bDhwyFQa/WiKhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PshgeRM5mow8DudjLGSZUziTBHqiHsAUezvzdolEAcblOSRmP7br3fVAak2QhpHdwI/Uhx3hbGNFIZDlzZWEmqhsYUgnWPdOwEBv4VXyWHwYKdsX9/kczoTweQMZr867OGrhfIlpmrXV9rveIkVD6MbvU3fHA7lN7MNJnpTKe+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnYAi8xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D01C4CEEF;
	Wed, 23 Oct 2024 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729694138;
	bh=azQJ3eGowkkRjf7a7p4DUvh4rfik/bDhwyFQa/WiKhg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZnYAi8xhKVOwyN23dtadpHuhJyihl2MDeOhcQoE63BUztJTDrQrBBwrL0rvXULRRk
	 /EFa+6zg5Ddujjug7EamJ/cDRT+F0n5FadFPs185ur2IGAhnK07Kmcr8OjBt76bQ89
	 xdKfco3k3sJZQ9GLwbol3zWK6QVhvu+w4FRlxVHZXIFRI2mwDg7qL2wQ+HR6rKvF8G
	 kUo/FrbFc4h6odrkyoxm7pftbyFcU+pO7+Bz6hiRg52IOGIvtWkFV3jNHNRyyPyj+a
	 iXHCBRPQD5/Viy+XTVHPQU2zx7IYfNY9fpUDzARmP5MmPnJpLyUW0Gxe88IYv5BtAg
	 YvuzrVYk9TYRg==
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso5301194b3a.2;
        Wed, 23 Oct 2024 07:35:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVd2e4wVmUm5w8oiicFsTbtKdjzNqt9SNR88Luc9iM0VftISAzSnTgXVsHs3oK2TxoXCc/4Fy+vUnl@vger.kernel.org, AJvYcCVoflN/gP6E3GdpTwzKBAi0BbFflVkb4cf9+b9goh4LCa7XxOr6c+3dHwjCVudi8glWWej05aOPsXtTJuQc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4v4+f+BTDARjk9p/Jo1eH8HXeXLSBANIQ0wi7TgTVJ4Ze592
	ElsXwJ+U8FbmmBV857sNbnlelL/7wkcgFu2uGtPUveHeVDOaU1Fhun1nFJvyoJbjPEPmFKxQU5e
	b4esLO4GD6SyNwP+9pG3Qb5p2zQ==
X-Google-Smtp-Source: AGHT+IGotfPUjuCyXnHej963WsiwtwAVlBk0onYdkHZONBPgcS/jZacTHxq70ShX22L6ObDnMI+HTy8A/5j0aUTa/2E=
X-Received: by 2002:a05:6a00:3d15:b0:70b:176e:b3bc with SMTP id
 d2e1a72fcca58-72030bdca55mr4263603b3a.28.1729694137938; Wed, 23 Oct 2024
 07:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003030919.17980-1-macpaul.lin@mediatek.com> <20241003030919.17980-4-macpaul.lin@mediatek.com>
In-Reply-To: <20241003030919.17980-4-macpaul.lin@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 23 Oct 2024 22:35:58 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-6tHK7xq3JUWSX--2mZqHQE-bzfaCwzuYHY5crFtYNxQ@mail.gmail.com>
Message-ID: <CAAOTY_-6tHK7xq3JUWSX--2mZqHQE-bzfaCwzuYHY5crFtYNxQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] dt-bindings: display: mediatek: dpi: correct
 power-domains property
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Rohit Agarwal <rohiagar@chromium.org>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
	Sen Chu <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Macpaul:

Macpaul Lin <macpaul.lin@mediatek.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=883=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:09=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> The MediaTek DPI module is typically associated with one of the
> following multimedia power domains:
>  - POWER_DOMAIN_DISPLAY
>  - POWER_DOMAIN_VDOSYS
>  - POWER_DOMAIN_MM
> The specific power domain used varies depending on the SoC design.
>
> These power domains are shared by multiple devices within the SoC.
> In most cases, these power domains are enabled by other devices.
> As a result, the DPI module of legacy SoCs often functions correctly
> even without explicit configuration.
>
> It is recommended to explicitly add the appropriate power domain
> property to the DPI node in the device tree. Hence drop the
> compatible checking for specific SoCs.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 5474d49b2f79 ("dt-bindings: display: mediatek: dpi: Add power doma=
ins")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../display/mediatek/mediatek,dpi.yaml        | 24 ++++++++-----------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> Changes for v2:
>  - Because of the corresponding dts fix has been reviewed with a Reviewed=
-by: tag.
>    [1] https://lore.kernel.org/all/20240925080515.16377-1-macpaul.lin@med=
iatek.com/
>    We still need this change to fix the 2 dtbs_check errors.
>    So keeps no change here.
>
> Changes for v3:
>  - The origin patch is [2]
>    https://lore.kernel.org/all/20240926111449.9245-2-macpaul.lin@mediatek=
.com/
>  - Thanks for Conor's reminding, after MediaTek's internal discussion,
>    This patch v3 is the replacement of [2] v2.
>    Because the DPI module should has a explicit configuration with power =
domain.
>  - Drop Acked-by: tag since v3 is nearly a new patch for different approa=
ch.
>
> Changes for v4:
>  - No change. Please help to review it again.
>
> Changes for v5:
>  - Add missing Reviewed-by Tag from Krzysztof. Thanks.
>
> Changes for v6:
>  - No change.
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 3a82aec9021c..497c0eb4ed0b 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -63,6 +63,16 @@ properties:
>        - const: sleep
>
>    power-domains:
> +    description: |
> +      The MediaTek DPI module is typically associated with one of the
> +      following multimedia power domains:
> +        POWER_DOMAIN_DISPLAY
> +        POWER_DOMAIN_VDOSYS
> +        POWER_DOMAIN_MM
> +      The specific power domain used varies depending on the SoC design.
> +
> +      It is recommended to explicitly add the appropriate power domain
> +      property to the DPI node in the device tree.
>      maxItems: 1
>
>    port:
> @@ -79,20 +89,6 @@ required:
>    - clock-names
>    - port
>
> -allOf:
> -  - if:
> -      not:
> -        properties:
> -          compatible:
> -            contains:
> -              enum:
> -                - mediatek,mt6795-dpi
> -                - mediatek,mt8173-dpi
> -                - mediatek,mt8186-dpi
> -    then:
> -      properties:
> -        power-domains: false
> -
>  additionalProperties: false
>
>  examples:
> --
> 2.45.2
>

