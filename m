Return-Path: <linux-kernel+bounces-351729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671BC99156E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A913282E8C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117E613C9C7;
	Sat,  5 Oct 2024 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bc7f31KM"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE44685260
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728118652; cv=none; b=It2Z82haEny+6y30Nlh0cRPqljpzRa3I0ihLWHChbF0kT40VVBRsp199dBEqx6543pzsOvCGGITkkJeD6nhmshuFVcc3j0Hh6rG8TrPbHaQEugQn1z+Vv6W05n7GEqcy2pXxFzycXyKjZeNYphBQ35xRgtqfDzNjrfpT9j9jV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728118652; c=relaxed/simple;
	bh=OObl/UyuFTAd1nMb6WKlWlyjc57t3qQdMV4ahGdPYiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDu3p4sPZm5H+1BHgWBbTH1r3BNTSksqTth1odNQg7YyUfRWGoCPQW9nYNM08GZLBIIEVRMrJguDGBdF6wDXpbQBhDrKyxiJq8takA0OVOOAdeygRPQ8aPXt7+UM3u5NluvA5mum4iLz0F3EWo0nbaqgGjWGcdf97cJE0Oj70x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=bc7f31KM; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e25d11cc9f0so2377785276.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728118650; x=1728723450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfgT2yflkbkyl0YVzv5lFdOMwbcuqZBZZgYThVVHyBM=;
        b=bc7f31KMIhJEEZ92mXUz5ytfrZ+lxj9Da9w6uG1s8NLO8RIzXH1jmmB0Emp/kefLY8
         wB1ooqkoWV6Ys+GT0NFoFn15ks4eN/qT3JDH6GxxPsE3fPQaQznIkAFsi/sGya0hfomf
         /3vA7KFpXyBl6OmJ7OgpCNiWG7f2/BCPRZtWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728118650; x=1728723450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfgT2yflkbkyl0YVzv5lFdOMwbcuqZBZZgYThVVHyBM=;
        b=Bf7NhR0QN6sf5Zot1JWOuXwgtF2FicQpzc4oHxEBJfZL2wY6I3VAw8FOEBgPy7E+eD
         YbuJV4ESjYEEkY+xLO2IPy6+xex3IKOEa0+fkZmwLKT8xGUAwwYAPOKIOdaMQFukX9Yq
         Sgydttyt1AMFta4tFRDCo5oR0NWB4Iji33UZ07QBh3qPyOxW8Nn8RL9MwwAoCj2D4BzB
         ktwZpCv7tDp5yFPLoAHKRO9KvkVSyy9ORd35IJNLKNxI2o3jHN5yEE1CJp2E5cBv4I65
         j0Nr0e8CfGElq0tf2g6sEt/mRu34fNkbBjMmTTHdvs/kQIjnSWrKbmy7gk5omkani8qe
         s64g==
X-Gm-Message-State: AOJu0YwiFInnOL8EAxhhORA7kN/ngpAEW/B5bqkWrzUmcyx0gRoukt+f
	fBm/kMUEq+Pv9WCKzhnyzz+/V6QiUg8KcZQgMP+dmge1kjWAdDWmej+b2B5zzIn6crYQOo90k52
	/goXAE4fI08EfWyzwCuWFV18l9ZWVSrM/uJAfKA==
X-Google-Smtp-Source: AGHT+IHyPDWXx3rPyEtAvD2Z65J7MaAjnomS2UWEjzzTksih/UuIR2EN+kxrUyqv86Cb6CkAyA0Fg72wiOEqiF+4buA=
X-Received: by 2002:a05:6902:2e0a:b0:e28:75c6:6d55 with SMTP id
 3f1490d57ef6-e28936d4176mr4929636276.16.1728118649704; Sat, 05 Oct 2024
 01:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928083804.1073942-1-dario.binacchi@amarulasolutions.com>
 <20240928083804.1073942-2-dario.binacchi@amarulasolutions.com>
 <566859c1-a397-4465-987e-0682b07a703e@kernel.org> <CABGWkvqqg-PGAZTCz=MMLRx5F93jaN_=z8zJt1sDd3PHXd80PQ@mail.gmail.com>
 <6c3e6071-822f-4230-b76b-276330de07ef@kernel.org> <CABGWkvrU507BHoP94Y7fEyFr=chuuy3o=oBHtuWRvwTw3GnxXw@mail.gmail.com>
 <82db5037-bbd3-4005-bde9-02df1bf4c475@kernel.org>
In-Reply-To: <82db5037-bbd3-4005-bde9-02df1bf4c475@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 5 Oct 2024 10:57:18 +0200
Message-ID: <CABGWkvqXZ+YAvo-AtUy+Ftdu0xxXKuhOwcSTwO5Fv6D3yzttNg@mail.gmail.com>
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

On Thu, Oct 3, 2024 at 12:46=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 01/10/2024 08:29, Dario Binacchi wrote:
> > On Mon, Sep 30, 2024 at 8:45=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 29/09/2024 22:00, Dario Binacchi wrote:
> >>>>
> >>>>
> >>>>> +  properties:
> >>>>> +    compatible:
> >>>>> +      contains:
> >>>>> +        enum:
> >>>>> +          - fsl,imx8mm-anatop
> >>>>> +
> >>>>> +then:
> >>>>> +  properties:
> >>>>> +    fsl,ssc-clocks:
> >>>>
> >>>> Nope. Properties must be defined in top-level.
> >>>>
> >>>>> +      $ref: /schemas/types.yaml#/definitions/phandle-array
> >>>>> +      description:
> >>>>> +        The phandles to the PLLs with spread spectrum clock genera=
tion
> >>>>> +        hardware capability.
> >>>>
> >>>> These should be clocks.
> >>>
> >>> Sorry, but I can't understand what you're asking me.
> >>> Could you kindly explain it to me in more detail?
> >>
> >> You added new property instead of using existing one for this purpose:
> >> 'clocks'.
> >
> >>
> >>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >
> > I added this new property specifically for managing spread-spectrum.
> > Indeed, not all clocks/PLLs
> > managed by the node/peripheral support spread-spectrum, and the added
> > properties specify
> > parameters for enabling and tuning SSC for each individual PLL based
> > on the index of each list.
> > If I were to use the 'clocks' property and add a clock to this list
> > that does not support SSC, IMHO
> > the pairings would be less clear.
>
> You duplicate property with argument "pairings shall match". Well, I am
> not happy with the duplication. Clocks have specific order, thus it is
> explicit which one needs tuning. Your other properties can match them as
> well, just index from clocks is offset...

Just to check if I understood correctly what you are suggesting before
submitting version 3 of the patch.
Something, for example, like:

clocks =3D <&clk, IMX8MP_AUDIO_PLL1>,  <&clk, IMX8MP_AUDIO_PLL2>, <&clk
IMX8MP_VIDEO_PLL1>;
fsl,ssc-modfreq-hz =3D <0, 3517>, <2, 6818>;

Where the spread spectrum is enabled only for AUDIO_PLL1 and VIDEO_PLL1 and
not for IMX8MP_AUDIO_PLL2.

Is this what you meant?

Thanks and regards,
Dario

>
>
> >
> > AFAIK the confusion arises from the fact that this node, which is a
> > clock controller, was used only
> > to export its base address, but perhaps it should have also exported
> > its clocks, which the other
> > clock controller does, as shown in:
> > Documentation/devicetree/bindings/clock/imx8m-clock.yaml.
>
> You use it as clocks, so I don't understand this comment.
>
> > If I consider its 'compatible' entries:
> > - 'fsl,imx8mm-ccm' -> drivers/clk/imx/clk-imx8mm.c
> > - 'fsl,imx8mn-ccm' -> drivers/clk/imx/clk-imx8mn.c
> > - 'fsl,imx8mp-ccm' -> drivers/clk/imx/clk-imx8mp.c
> > the probe function, triggered by fsl,imx8m{m,n,p}-ccm (and not
> > fsl,imx8m{m,n,p}-anatop),
> > retrieves the anatop node solely to get its base address, also
> > registering its clocks, which
> > I would have expected to be registered by another driver, specifically
> > the one for anatop:
> >
> > static int imx8mn_clocks_probe(struct platform_device *pdev)
> > {
> > struct device *dev =3D &pdev->dev;
> > struct device_node *np =3D dev->of_node;
> > void __iomem *base;
> > struct imx_pll14xx_ssc pll1443x_ssc;
> > int ret;
> >
> > clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> >                            IMX8MN_CLK_END), GFP_KERNEL);
> > if (WARN_ON(!clk_hw_data))
> >     return -ENOMEM;
> >
> > clk_hw_data->num =3D IMX8MN_CLK_END;
> > hws =3D clk_hw_data->hws;
> >
> > hws[IMX8MN_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
> > hws[IMX8MN_CLK_24M] =3D imx_get_clk_hw_by_name(np, "osc_24m");
> > hws[IMX8MN_CLK_32K] =3D imx_get_clk_hw_by_name(np, "osc_32k");
> > hws[IMX8MN_CLK_EXT1] =3D imx_get_clk_hw_by_name(np, "clk_ext1");
> > hws[IMX8MN_CLK_EXT2] =3D imx_get_clk_hw_by_name(np, "clk_ext2");
> > hws[IMX8MN_CLK_EXT3] =3D imx_get_clk_hw_by_name(np, "clk_ext3");
> > hws[IMX8MN_CLK_EXT4] =3D imx_get_clk_hw_by_name(np, "clk_ext4");
> >
> > np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
> > base =3D devm_of_iomap(dev, np, 0, NULL);
> > of_node_put(np);
> > if (WARN_ON(IS_ERR(base))) {
> >     ret =3D PTR_ERR(base);
> >     goto unregister_hws;
> > }
> >
> > hws[IMX8MN_AUDIO_PLL1_REF_SEL] =3D imx_clk_hw_mux("audio_pll1_ref_sel",
> > base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > hws[IMX8MN_AUDIO_PLL2_REF_SEL] =3D imx_clk_hw_mux("audio_pll2_ref_sel",
> > base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > hws[IMX8MN_VIDEO_PLL_REF_SEL] =3D imx_clk_hw_mux("video_pll_ref_sel",
> > base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>
> Sorry, I am not going to dwell into drivers code. We talk here about
> bindings and new properties.
>
> Best regards,
> Krzysztof
>


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

