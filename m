Return-Path: <linux-kernel+bounces-541802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F6A4C1D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA401885AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EBE212B04;
	Mon,  3 Mar 2025 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/AhB5qE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65120D4E9;
	Mon,  3 Mar 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008131; cv=none; b=ol7rqZUFTCC46B78RIjRH0jvOaXgk857K5xDY4w5mdmcXtNtIRNfcAo33dgxCybqBosF7u/CbbaEowxF6wI3AUaHPW2LJpgCTRHs78syQdhU/U9bKAc0Dj49AGPpFf9wrzFncc3A3jMmx0+booMex/hEL8jg8u5t4n9wm52F7No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008131; c=relaxed/simple;
	bh=cyAIDvH42HlK42zH1AZZ7W0u8yvqehARnSYevut+Mvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkHl/q+t3xNiM9e03RQ5mO5PSKAraOfaWxM3dS8vUiGvJvYTQbCnWqeeIoVtEwc3DpCkbXFaWQYTbstRWpu+RqTh2p1cu2DFHB6adVuUI/PR3JRwRvLZxUBHjE0X4zjVNLyNRQMrSJQ0zXVq787n6O4r8P23D7zDE2Qsgdv3uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/AhB5qE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DA6C4CEEC;
	Mon,  3 Mar 2025 13:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741008130;
	bh=cyAIDvH42HlK42zH1AZZ7W0u8yvqehARnSYevut+Mvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c/AhB5qEabaK+aGFMVK/mFIuucVYjGzZAk7HdUEOEz2mZCuWZRzB9TmVLCrERWDN5
	 OC3uJ8TorONGnXWfIFQmcnQmo1J+tPz7jKCiWTOrHgzEzM6TjKgawRn5EjTjpfa+Vd
	 hQbJAAo8DaI/V4nFvyoBVzOlg2VyPBFMczw0uHOJF4cvkb3FC2jgJWI9k3gCwACoBT
	 QyXng99JRn6+4oOBzcoxgc+0yF81Wre66HialtHEmysgApJfX9TYc/pCrPFm0+nEWV
	 YlKl7U1UpJaE6vvS5QoHCrEsqQCKCMysMl4JglksrOiXPPCibfyukuN5ukmr78zUnS
	 SCd6ppVo7A+6g==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2feb9076a1cso6824201a91.0;
        Mon, 03 Mar 2025 05:22:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1Igr/TanK2soVcvesdVKYXrB4JqCExqU5/Faky6KF9LAynw5xt43eq+kkVKFjUQwcfRaI+VMZXJdv@vger.kernel.org, AJvYcCXl9brJFjfH1J6lEweohgkUOW7gBLrW9dXEGdBuBZB8Zb1XGrMibFyJvxVhbwE/fg8qofmgm19obkXjVNCv@vger.kernel.org
X-Gm-Message-State: AOJu0YwpYcyE0gpnZXOGnBIMwkbcSj1haZn5bjQ7Q1NsE5QK/0yTY4qD
	8VByGPY2MqftkYq51dD7+LGDbNvTUkq8XHm6VxlvnFURhnC44voO6KzQwoyzV58RBDt8ArjsM/Z
	GtXErXVzSARgsru7qrR2Vx4opVA==
X-Google-Smtp-Source: AGHT+IHQLK7la/7RxxVx5xQub2rrCyzIXTBwqCYNHPZA1L5Z+HvrKvHgKF1EVP50ng2pCoNbxnqwqT1ThMWF+DeLMfM=
X-Received: by 2002:a17:90b:1cc6:b0:2fc:3264:3657 with SMTP id
 98e67ed59e1d1-2febaa92594mr25361600a91.0.1741008129875; Mon, 03 Mar 2025
 05:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023-display-support-v7-0-6703f3e26831@baylibre.com> <20231023-display-support-v7-1-6703f3e26831@baylibre.com>
In-Reply-To: <20231023-display-support-v7-1-6703f3e26831@baylibre.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 3 Mar 2025 21:22:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8c4xeE=c4MTGopenORaP-PL66exLG+erKSV1fpoGJU+g@mail.gmail.com>
X-Gm-Features: AQ5f1JrckMOh9P4yJQbwlfuWcX_03D8O22eeIcknRD2YAlMiCLxngtVQQLy-TeY
Message-ID: <CAAOTY_8c4xeE=c4MTGopenORaP-PL66exLG+erKSV1fpoGJU+g@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: display: mediatek: dpi: add
 power-domains example
To: amergnat@baylibre.com
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Amergnat:

<amergnat@baylibre.com> =E6=96=BC 2025=E5=B9=B41=E6=9C=8810=E6=97=A5 =E9=80=
=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Fabien Parent <fparent@baylibre.com>
>
> DPI is part of the display / multimedia block in MediaTek SoCs, and
> always have a power-domain (at least in the upstream device-trees).
> Add the power-domains property to the binding example.

Applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 9273cf7d3942 ("dt-bindings: display: mediatek: convert the dpi bin=
dings to yaml")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 2=
 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index 0f1e556dc8ef..d5ee52ea479b 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam=
l
> @@ -116,11 +116,13 @@ examples:
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

