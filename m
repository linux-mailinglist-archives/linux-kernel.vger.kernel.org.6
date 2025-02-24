Return-Path: <linux-kernel+bounces-528738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D409A41BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D98D7A80E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EC5257445;
	Mon, 24 Feb 2025 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLLnySqy"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC124C66A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394257; cv=none; b=u8IyEZQxefu5NSMJY1cv0Rr34NrxIG3CwHqOnBoWDklSpj2R+1rOC6yq6vf0fcKz1lf123dB/ShH7Szd+t68hs5B3k8o9LEC2L7riWVx424W5wrxDb8VNB5gGmosO//nR/7ez1MMsoveHQAcgd49fWEVDMbGUIEA+osMGzXIvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394257; c=relaxed/simple;
	bh=LdrLPe3NM9nT1PR1y7v3JkWuBK/3OAgCKHXOQ92A5WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOYZ5YGPfWByyBGvx9a8c+y3o/DDX2kqwXuPx37YXUX1plkdS3fdd/hTtvFJuzRUcOdWGgU00xdnoa/MfuO5cTXad7st08vK2rGaq4wKpgusVXlSKNseMoK8pj7os00vyRRkzx4NVUmWU76EX3kqPWecdsxGcXceKlDu7NkAxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OLLnySqy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so47091651fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740394253; x=1740999053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33I10h+7nHN9WWkfMc3v+GlsOaYaEyXk/K9NAesnYxA=;
        b=OLLnySqy9ccY2d883J0buLGExcyzAiaNYuKE7ZMyTbN4sXD6cEUMrQK1JGjFlPSL6T
         xqApaZ9hTeiRES74dHNLtkhm94VolV5pLg42fRJCXn2ZBLqr/lOkrQZnpyBb90ChnKwd
         gzm8goNMZ/FptKIkYXwVazoj4+JsOEsng4t6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740394253; x=1740999053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33I10h+7nHN9WWkfMc3v+GlsOaYaEyXk/K9NAesnYxA=;
        b=Xq7qQvr9OvxFZbdUyzEAIrep+hU2zNBOSFSlQ8ky3M5NIoxho6deGjcii+F77rk3SR
         VlybRCgAXJ5vnznXJvYy0d5ZPh8aBoHEtywxJwC8ua1b2totXiqbelo4702OcTFCodXu
         YqoYcDZVhH9YWYSXnZmA+E3q5RkJElH02jVj/kUqPr9X2iUxWcp1/SujMT/LOxmfZweZ
         hc3EtFEW/FHqL9tK3D9ICgPPdxTNNjkkhzXvuNUBdkzEB6Tc9zGM3oXfS4hdaYYTBtT9
         h6BAAqdjKcp19YnYUs1hv6YwHIalIxozhw6Lb9eTlT4+HFVeydQPYLRIM2FdyXqk3xdh
         5iRw==
X-Forwarded-Encrypted: i=1; AJvYcCWQlA/Lzp6ZtI/yIqLZPSYt5XZyNgrLhAYLE/SD118SL5IZG6a+wWrur1k6O8XwOvgMyIzHhPkETbLVjIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQV17kX951c/t32QumTHtWJEXyS7/REMjSBTnI5ubjlY0Ix3F
	gvYHbx1ZvkXiRqeY27SzK/NADs5AZ5yjBxzjshmF+db0mOOqLPBqlytZAv5JYYNd1n9suJgkFft
	hwbvS0jLJxRKwMnS0nsfJ7zKVquAQkJxr0WjI
X-Gm-Gg: ASbGncuIXZEnKfbeMF2JwGnxQ2YwZklH2u/CdIlnvdY457S2dK4UA8bWH9qcB37mw5f
	ZKpOLoYTZmwv6hsFXNhu1HISVSPBGC8LA3xcVkhdVNsEBUPukH0E5aFBCK+Ouy4SYTn1I0OJZzx
	UC0ZQko9KOKkD0QjF5fc1MRrZKcMl4OdTYptw=
X-Google-Smtp-Source: AGHT+IHNRMFdVG+U7OWDssiE+FdC7MFPSlPh3k/wUhdWTrMt1I2HXTRNphSxg61+hQ7uwUEjQWDTi1xNW22wWxWU8i0=
X-Received: by 2002:a2e:8197:0:b0:308:f3f7:49bc with SMTP id
 38308e7fff4ca-30a59895e21mr41620201fa.16.1740394253010; Mon, 24 Feb 2025
 02:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220110948.45596-1-angelogioacchino.delregno@collabora.com> <20250220110948.45596-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250220110948.45596-2-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 24 Feb 2025 18:50:41 +0800
X-Gm-Features: AWEUYZm0UHtGw-8b7DN3edPwKb-1ZcVXmj8EE7bXKkQWur4lNuL40yg5sa6u8YU
Message-ID: <CAGXv+5EBiYwjNeocGh0ZjWi5mzOZr_CfS6H+7au5vgQgeigUfg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: mediatek: mt8188: Add base display
 controller graph
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com, pablo.sun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The display related IPs in MT8188 are flexible and support being
> interconnected with different instances of DDP IPs and/or with
> different DDP IPs, forming a full Display Data Path that ends
> with an actual display output, which is board specific.
>
> Add a common graph in the main mt8188.dtsi devicetree, which is
> shared between all of the currently supported boards.
> All boards featuring any display functionality will extend this
> common graph to hook the display controller of the SoC to their
> specific output port(s).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org> # On MT8188 Ciri (int. and ext=
.)

> ---
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi | 140 +++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8188.dtsi
> index c226998b7e47..4437b1820f26 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -2868,6 +2868,23 @@ ovl0: ovl@1c000000 {
>                         iommus =3D <&vdo_iommu M4U_PORT_L0_DISP_OVL0_RDMA=
0>;
>                         power-domains =3D <&spm MT8188_POWER_DOMAIN_VDOSY=
S0>;
>                         mediatek,gce-client-reg =3D <&gce0 SUBSYS_1c00XXX=
X 0x0000 0x1000>;
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@0 {
> +                                       reg =3D <0>;
> +                                       ovl0_in: endpoint { };
> +                               };
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       ovl0_out: endpoint {
> +                                               remote-endpoint =3D <&rdm=
a0_in>;
> +                                       };
> +                               };
> +                       };
>                 };
>
>                 rdma0: rdma@1c002000 {
> @@ -2878,6 +2895,25 @@ rdma0: rdma@1c002000 {
>                         iommus =3D <&vdo_iommu M4U_PORT_L1_DISP_RDMA0>;
>                         power-domains =3D <&spm MT8188_POWER_DOMAIN_VDOSY=
S0>;
>                         mediatek,gce-client-reg =3D <&gce0 SUBSYS_1c00XXX=
X 0x2000 0x1000>;
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@0 {
> +                                       reg =3D <0>;
> +                                       rdma0_in: endpoint {
> +                                               remote-endpoint =3D <&ovl=
0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       rdma0_out: endpoint {
> +                                               remote-endpoint =3D <&col=
or0_in>;
> +                                       };
> +                               };
> +                       };
>                 };
>
>                 color0: color@1c003000 {
> @@ -2887,6 +2923,25 @@ color0: color@1c003000 {
>                         interrupts =3D <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0=
>;
>                         power-domains =3D <&spm MT8188_POWER_DOMAIN_VDOSY=
S0>;
>                         mediatek,gce-client-reg =3D <&gce0 SUBSYS_1c00XXX=
X 0x3000 0x1000>;
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@0 {
> +                                       reg =3D <0>;
> +                                       color0_in: endpoint {
> +                                               remote-endpoint =3D <&rdm=
a0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       color0_out: endpoint {
> +                                               remote-endpoint =3D <&cco=
rr0_in>;
> +                                       };
> +                               };
> +                       };
>                 };
>
>                 ccorr0: ccorr@1c004000 {
> @@ -2896,6 +2951,25 @@ ccorr0: ccorr@1c004000 {
>                         interrupts =3D <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0=
>;
>                         power-domains =3D <&spm MT8188_POWER_DOMAIN_VDOSY=
S0>;
>                         mediatek,gce-client-reg =3D <&gce0 SUBSYS_1c00XXX=
X 0x4000 0x1000>;
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@0 {
> +                                       reg =3D <0>;
> +                                       ccorr0_in: endpoint {
> +                                               remote-endpoint =3D <&col=
or0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       ccorr0_out: endpoint {
> +                                               remote-endpoint =3D <&aal=
0_in>;
> +                                       };
> +                               };
> +                       };
>                 };
>
>                 aal0: aal@1c005000 {
> @@ -2905,6 +2979,25 @@ aal0: aal@1c005000 {
>                         interrupts =3D <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0=
>;
>                         power-domains =3D <&spm MT8188_POWER_DOMAIN_VDOSY=
S0>;
>                         mediatek,gce-client-reg =3D <&gce0 SUBSYS_1c00XXX=
X 0x5000 0x1000>;
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@0 {
> +                                       reg =3D <0>;
> +                                       aal0_in: endpoint {
> +                                               remote-endpoint =3D <&cco=
rr0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       aal0_out: endpoint {
> +                                               remote-endpoint =3D <&gam=
ma0_in>;
> +                                       };
> +                               };
> +                       };
>                 };
>
>                 gamma0: gamma@1c006000 {
> @@ -2914,6 +3007,23 @@ gamma0: gamma@1c006000 {
>                         interrupts =3D <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0=
>;
>                         power-domains =3D <&spm MT8188_POWER_DOMAIN_VDOSY=
S0>;
>                         mediatek,gce-client-reg =3D <&gce0 SUBSYS_1c00XXX=
X 0x6000 0x1000>;
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@0 {
> +                                       reg =3D <0>;
> +                                       gamma0_in: endpoint {
> +                                               remote-endpoint =3D <&aal=
0_out>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       gamma0_out: endpoint { };
> +                               };
> +                       };
>                 };
>
>                 dither0: dither@1c007000 {
> @@ -2923,6 +3033,21 @@ dither0: dither@1c007000 {
>                         interrupts =3D <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0=
>;
>                         power-domains =3D <&spm MT8188_POWER_DOMAIN_VDOSY=
S0>;
>                         mediatek,gce-client-reg =3D <&gce0 SUBSYS_1c00XXX=
X 0x7000 0x1000>;
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@0 {
> +                                       reg =3D <0>;
> +                                       dither0_in: endpoint { };
> +                               };
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       dither0_out: endpoint { };
> +                               };
> +                       };
>                 };
>
>                 disp_dsi0: dsi@1c008000 {
> @@ -3005,6 +3130,21 @@ postmask0: postmask@1c01a000 {
>                         interrupts =3D <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH 0=
>;
>                         power-domains =3D <&spm MT8188_POWER_DOMAIN_VDOSY=
S0>;
>                         mediatek,gce-client-reg =3D <&gce0 SUBSYS_1c01XXX=
X 0xa000 0x1000>;
> +
> +                       ports {
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               port@0 {
> +                                       reg =3D <0>;
> +                                       postmask0_in: endpoint { };
> +                               };
> +
> +                               port@1 {
> +                                       reg =3D <1>;
> +                                       postmask0_out: endpoint { };
> +                               };
> +                       };
>                 };
>
>                 vdosys0: syscon@1c01d000 {
> --
> 2.48.1
>
>

