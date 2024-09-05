Return-Path: <linux-kernel+bounces-317705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D261796E286
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86673289989
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB3E188A2F;
	Thu,  5 Sep 2024 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="jes/yyjZ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C518593C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725562616; cv=none; b=hVEA+Sy6M56vtZekb3w/6m7uGKhNS6Ra/+F8Q89T9XF2+jYTYUhG3YfcFtKO0milnrAYeLptwluNwsfTSikj6q+ob8t5ZnTc/UHPuHoraUPGigD5XmpxtnqRBViP4gWlzr60NdWraACKBOwzuOlVl3l2H1PR9WfoEnxsxTrmhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725562616; c=relaxed/simple;
	bh=5Kl2tZr706GSf18Hbk3w3yTELR9WRKf0WWMV0a8g2Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPVVgyFRNsbdyVWptpwZbhiYqlka+qD3nhUeB56H6Gd7i5yUt5aTtNvMYG/FehyRdHSLwYG15zJC6ViXBhnpZZ/pRgJAnHD84fCWA8+jNv8QQ6h6TS1pylU4jDzir2K+J8pJy3SxmaaiAIfN7neVFs+MH80MmMtLW5zycJpEG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=jes/yyjZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86859e2fc0so157402666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1725562613; x=1726167413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AimnlZvO4vX1o0LABlUFzAbcpYQGtu+zhlXenwh5uE=;
        b=jes/yyjZansc89GH8X8Lw1V1MtwB7mpZMxA+igfDhW9Un3ssExfbOtUr3sXepUhIQY
         dndyXhzHvstvEv5ISq32QTdI9V+EhypXHm8N1SHM33HqiPYMv3Pdwc4cFFVO7UCMhUqM
         b7KmguXkDt9XNYOpboWN4p6wrUizZQKUfmExLotD6VglXs9hXGrw4Dk7vs6pNP0o2IwY
         cfTtIJVcPAUvwov55LcZDZr8nfCSl1yk7tPTr6p5iyvbO9vigkdPNE0cuGgI1kVmcKjb
         rxOReW1TagrwcXw4b7YUGp1g9G+0Ugz8NRv1TEHenaSzs3ME2E4YnDwqUR7cFKcuWMdA
         QZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725562613; x=1726167413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AimnlZvO4vX1o0LABlUFzAbcpYQGtu+zhlXenwh5uE=;
        b=rTWR8lgMm1R/6hfnUdHpZrQ4eWkke+PLrGtTW+ln2YK9hudZbs1PgC3kFs0PZPlaBZ
         drsphIuXaWD7OqqRkvA2MSE/s027r2xFgNChHFmahPxnXeujHQq056ea4omuO62w6iuF
         61pr22c2snRXkKH8cxKChYtkF858EXUny4c5AJS9RjQeymTLVif1auS21FEe6TMJvqfQ
         joU2mab98tcbJpqJjoknLI4I3uyfKMOGOL3BqQtJkExc2h3tgHw8CQr/V6L+96xrTfr+
         ZCDYZXzKntqzNdsYAa6x6CNRMCGqboarndeO4eb9EvQbBCD0ZZh99Nj1A2sx+XsHe/EY
         jVMw==
X-Forwarded-Encrypted: i=1; AJvYcCX4fIt85YL5G/L0QuBfO0xDfdTv82cUwrA4F4jzsUfuYZrHlkC56a399o9wKtqkbHq3wP8GdlPdM6FHzFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyif2MqPSx2Dbbuk5qkfydQgdaaP7eBF+XHa5FT67eTx4EZgFZE
	iBw98O27mjDSmcfvogoxmzrQhUx5yGsyEiWYO+L3L9IqOfxXsjdji5A3cRrE/FdT5BHpnE5YwJq
	V35MBUJ4G1skOsMQWqlT/Y7fTa6RctV5qoFZIfQ==
X-Google-Smtp-Source: AGHT+IGdoYNXI+zkFvkIv/Pf0iKRQ0TdFYopTZLghqtcSzK7K7EJ5wlRtOTdvPGPRBWz6UTGgTXgE416ziaIjjvKK9Y=
X-Received: by 2002:a17:907:2da5:b0:a86:9cff:6798 with SMTP id
 a640c23a62f3a-a8a32ed4b43mr754624966b.30.1725562612865; Thu, 05 Sep 2024
 11:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com> <20240807-fsl_dts_warning-v2-3-89e08c38831a@nxp.com>
In-Reply-To: <20240807-fsl_dts_warning-v2-3-89e08c38831a@nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 5 Sep 2024 11:56:41 -0700
Message-ID: <CAJ+vNU3ZsJG-eoqf3JcHTyDwjp4uOW1XiEhnOfWZ1FJ-q1Y9Hw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: imx8mm-venice-gw7901: add
 #address(size)-cells for gsc@20
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:54=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add #address-cells and #size-cells for gsc@20 to fix below warning:
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb: gsc@20: '#address=
-cells' is a required propert
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> index 136cb30df03a6..35ae0faa815bc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
> @@ -364,6 +364,8 @@ gsc: gsc@20 {
>                 interrupts =3D <16 IRQ_TYPE_EDGE_FALLING>;
>                 interrupt-controller;
>                 #interrupt-cells =3D <1>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
>
>                 adc {
>                         compatible =3D "gw,gsc-adc";
>
> --
> 2.34.1
>
>

Hi Frank,

I just noticed this patch (along with a few others to
imx8m*venice*dts* which undoes what was done in commit 3343ab4cc698
"arm64: dts: freescale: imx8m*-venice-*: fix gw,gsc dt-schema
warnings" which my commit message states: Fix the dt-schema warnings
due to #address-cells/#size-cells being unnecessary when there are no
children with reg cells.

With your patch applied I now see warnings again:
$ touch arch/arm64/boot/dts/freescale/imx8m*venice*.dts*; make dtbs W=3D1
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx-0x.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts:361.14-467.4:
Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
0a20000/gsc@20: unnecessary #address-cells/#size-cells without
"ranges", "dma-ranges" or child "reg" property
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts:311.14-418.4:
Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
0a20000/gsc@20: unnecessary #address-cells/#size-cells without
"ranges", "dma-ranges" or child "reg" property
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts:277.14-364.4:
Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
0a20000/gsc@20: unnecessary #address-cells/#size-cells without
"ranges", "dma-ranges" or child "reg" property
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dtb
arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts:330.14-411.4:
Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
0a20000/gsc@20: unnecessary #address-cells/#size-cells without
"ranges", "dma-ranges" or child "reg" property
  DTC     arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb
arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts:309.14-416.4:
Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@3
0a20000/gsc@20: unnecessary #address-cells/#size-cells without
"ranges", "dma-ranges" or child "reg" property
arch/arm64/boot/dts/freescale/imx8mn.dtsi:1128.11-1138.7: Warning
(graph_child_address): /soc@0/bus@32c00000/isi@32e20000/ports: grap
h node has single child node 'port@0', #address-cells/#size-cells are
not necessary
  DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx-2x.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx-2x.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx-2x.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx-2x.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rpidsi.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.d=
tbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.d=
tb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rpidsi.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rpidsi.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.d=
tbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.d=
tb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtb
  DTC     arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-rpidsi.dtbo
  DTOVL   arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-rpidsi.dtb

Is this some case of dueling dt-schema checks for dtb checks?

Best Regards,

Tim

