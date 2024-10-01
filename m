Return-Path: <linux-kernel+bounces-345303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B098B45E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E4DB237DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B672B1BBBC4;
	Tue,  1 Oct 2024 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="o+pxph/V"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C21BBBE2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764175; cv=none; b=Zec4c38nn19prWOSwWY4P2+PHvr4x+Il4xu6sNSUZkyp18s2ONHiSLIxKhJ0glTATRTlsxPKxqKBM5u4htb2sAJLXxK3X5DT+KsTUUR3MazjOGhFuYCcOqNR1ayKLfI4GNctuAqRDpMq2OB0rT9iezg9k3zZcQUhF0Hoct3BAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764175; c=relaxed/simple;
	bh=0oXgs2FUFI9fseHKwZY5hlanmumWroHDydWI1JMx7ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcGkpuY5q/2T9mmb8njvZHqyv0UnGFV8s7hIHobFw3LWilZbChaJrprTpoPSt/Un63SM6u03cCV2g2pVdd8XMvyZmEkoF47QYJZ+Q633GMXfy+X+xMJqoOOE7g107BeIHuOZJKHToiSFQmgLAZx2o4hOuF7QT9b5KVokliZfmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=o+pxph/V; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4484292276.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727764172; x=1728368972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTEgHFsXebuB87QyA3c3rHB+YSLXi5vaJNlefJqZ5RA=;
        b=o+pxph/VN0oqstC616wM9sfylwPjOFOCavTG4jTej8Zo0GgeBJPKPXn/ifv6Mh1hHd
         1IkZDTuq5LeEcNVkgMyaXfjwhQM7V06EstpQKNKtq4RqphFXemL5EdmVdDJJDaS3k9QR
         WwgmV3lR5KsHHrXnYB+ZrRIQ0wYZ4TaXvU4u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727764172; x=1728368972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTEgHFsXebuB87QyA3c3rHB+YSLXi5vaJNlefJqZ5RA=;
        b=DNWSNbCVFkNKTuXj8DUswlB6sUUfaa75Fo8l6ZrSquGG43/Q475SCEPECN9RWqr+gb
         XU1YCUyxbfM/cJQJWjvXXzD5uL3pQ91CQgf8hzyfnKpxlUcARzkkNbBF1okftRnbv7yV
         NyzgR7zzn2ByzZkeFoXLANs3X2bLIbzW6wOVq+/QrR+trq7KO6WUh5VEokhWvtBznLDa
         Yf9DP0ny2JbmEZLHdHw2ReN7X0IL9kosWhOSEzJURYVxAbdseL43sxuydPCIALw6IhmS
         KE2gSNrYSnqXTlOSK7mTdn0mjeFRemyZAzbfMX3/A9dVxNdSIiwu0OSR57V8Kn+EwSAR
         FkLg==
X-Gm-Message-State: AOJu0Yx2CXnFuT835ePJeOrmnwLv7NX8CNLnnze+qWp7DGypyJq1RkJz
	/VbfzVUzOqEA62OhVgmfhH2JIF7+XK0EYH5+y7WtUYMgJvOmEo2ftYSyUNFWcZagmzoXOSU6sJg
	20cJkjF8A7kefIfJjCfYT9TIHYMHVAaC1IXiZsuzdQzKIRnCh/F4G9g==
X-Google-Smtp-Source: AGHT+IHIQeqzdKeaRHimI4voaiumfcMwSGMQB57E+GcRU6g/uktv6tWOs9TtJod9TVUxHSLxwZxM0Uw83dIaeeyz8V4=
X-Received: by 2002:a05:6902:100b:b0:e20:296e:48bd with SMTP id
 3f1490d57ef6-e2604b284dcmr13188403276.2.1727764172468; Mon, 30 Sep 2024
 23:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928083804.1073942-1-dario.binacchi@amarulasolutions.com>
 <20240928083804.1073942-2-dario.binacchi@amarulasolutions.com>
 <566859c1-a397-4465-987e-0682b07a703e@kernel.org> <CABGWkvqqg-PGAZTCz=MMLRx5F93jaN_=z8zJt1sDd3PHXd80PQ@mail.gmail.com>
 <6c3e6071-822f-4230-b76b-276330de07ef@kernel.org>
In-Reply-To: <6c3e6071-822f-4230-b76b-276330de07ef@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 1 Oct 2024 08:29:21 +0200
Message-ID: <CABGWkvrU507BHoP94Y7fEyFr=chuuy3o=oBHtuWRvwTw3GnxXw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: clock: imx8m-anatop: support spread
 spectrum clocking
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 8:45=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 29/09/2024 22:00, Dario Binacchi wrote:
> >>
> >>
> >>> +  properties:
> >>> +    compatible:
> >>> +      contains:
> >>> +        enum:
> >>> +          - fsl,imx8mm-anatop
> >>> +
> >>> +then:
> >>> +  properties:
> >>> +    fsl,ssc-clocks:
> >>
> >> Nope. Properties must be defined in top-level.
> >>
> >>> +      $ref: /schemas/types.yaml#/definitions/phandle-array
> >>> +      description:
> >>> +        The phandles to the PLLs with spread spectrum clock generati=
on
> >>> +        hardware capability.
> >>
> >> These should be clocks.
> >
> > Sorry, but I can't understand what you're asking me.
> > Could you kindly explain it to me in more detail?
>
> You added new property instead of using existing one for this purpose:
> 'clocks'.

>
>
>
> Best regards,
> Krzysztof
>

I added this new property specifically for managing spread-spectrum.
Indeed, not all clocks/PLLs
managed by the node/peripheral support spread-spectrum, and the added
properties specify
parameters for enabling and tuning SSC for each individual PLL based
on the index of each list.
If I were to use the 'clocks' property and add a clock to this list
that does not support SSC, IMHO
the pairings would be less clear.

AFAIK the confusion arises from the fact that this node, which is a
clock controller, was used only
to export its base address, but perhaps it should have also exported
its clocks, which the other
clock controller does, as shown in:
Documentation/devicetree/bindings/clock/imx8m-clock.yaml.
If I consider its 'compatible' entries:
- 'fsl,imx8mm-ccm' -> drivers/clk/imx/clk-imx8mm.c
- 'fsl,imx8mn-ccm' -> drivers/clk/imx/clk-imx8mn.c
- 'fsl,imx8mp-ccm' -> drivers/clk/imx/clk-imx8mp.c
the probe function, triggered by fsl,imx8m{m,n,p}-ccm (and not
fsl,imx8m{m,n,p}-anatop),
retrieves the anatop node solely to get its base address, also
registering its clocks, which
I would have expected to be registered by another driver, specifically
the one for anatop:

static int imx8mn_clocks_probe(struct platform_device *pdev)
{
struct device *dev =3D &pdev->dev;
struct device_node *np =3D dev->of_node;
void __iomem *base;
struct imx_pll14xx_ssc pll1443x_ssc;
int ret;

clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws,
                           IMX8MN_CLK_END), GFP_KERNEL);
if (WARN_ON(!clk_hw_data))
    return -ENOMEM;

clk_hw_data->num =3D IMX8MN_CLK_END;
hws =3D clk_hw_data->hws;

hws[IMX8MN_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
hws[IMX8MN_CLK_24M] =3D imx_get_clk_hw_by_name(np, "osc_24m");
hws[IMX8MN_CLK_32K] =3D imx_get_clk_hw_by_name(np, "osc_32k");
hws[IMX8MN_CLK_EXT1] =3D imx_get_clk_hw_by_name(np, "clk_ext1");
hws[IMX8MN_CLK_EXT2] =3D imx_get_clk_hw_by_name(np, "clk_ext2");
hws[IMX8MN_CLK_EXT3] =3D imx_get_clk_hw_by_name(np, "clk_ext3");
hws[IMX8MN_CLK_EXT4] =3D imx_get_clk_hw_by_name(np, "clk_ext4");

np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
base =3D devm_of_iomap(dev, np, 0, NULL);
of_node_put(np);
if (WARN_ON(IS_ERR(base))) {
    ret =3D PTR_ERR(base);
    goto unregister_hws;
}

hws[IMX8MN_AUDIO_PLL1_REF_SEL] =3D imx_clk_hw_mux("audio_pll1_ref_sel",
base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
hws[IMX8MN_AUDIO_PLL2_REF_SEL] =3D imx_clk_hw_mux("audio_pll2_ref_sel",
base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
hws[IMX8MN_VIDEO_PLL_REF_SEL] =3D imx_clk_hw_mux("video_pll_ref_sel",
base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));


Thanks and regards,
Dario

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

