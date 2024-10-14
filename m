Return-Path: <linux-kernel+bounces-363442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9199C27B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0AD1C23043
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C714A0A3;
	Mon, 14 Oct 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIHfPUOg"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343FB1487DD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893055; cv=none; b=dWJcVlChUqZWkNxDqIwUOLxsMbSo4MktY2wWvGekXvYV0lbMltepjz+EpFmjwU0A9wvCB1AC+EHpu0mRNYmDs+RzXgVtmCA+GHZF2SdLsq1pt1TNY4VOWmBtaCJG9y8AiKuKZ+8Bk462e3TI1sEz91uKYOUHJz1Xw9KRYLI1b4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893055; c=relaxed/simple;
	bh=z14LnEzbw8ecnz2pepCIwD/33XkeC75KpcnYPH7d/W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTRZV4ABCL3T2ayZEY5HQcFFXQmCDrbuOtksXyKlNLIyO9CYmOWUTJ+igas/Ts1rQskO6Sn7rNdHFF0i6uFLLoOJPTGLFkCMP8OZ4ygqqdXSTD4Hz5ON4Q6qUaApi+dXo3SVwLtywoQfnz5VQE0lUT7xAACKEzx1U+oV/l4zMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gIHfPUOg; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso448462e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728893051; x=1729497851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRbPdgNIVrqSTf/1E3KOMlBjVq1ghJobEnRvorOgv2Y=;
        b=gIHfPUOgXYJqDjRgU9JwHznFc6N3fzL7YP9MhDdROOiLBAquTxbdHQRTkaaLfOwWzi
         ACWSDILZcHJELPZwfA05ljCtKxFBliy/4oFU9aWJd29IyNrTcpcdV0IvxnMZ0ak3xGrb
         3dLqIp+0jxJNkSf1Z0tWVi+IcIguh5hZKU3rT76B8psVxOKTHwVVIpXVszbDyqZ8e34B
         DN8rrjNkO6PEXP6UnVHpmAM2cDwmIlh0Msp6pENNWCYP0C3bZ+6v1oQTa2OqX2A78Cql
         GsJctpdaNta43WZ6LyxkN/M3vFRn/lwl3ncJsuVi4l/v0dHkjZttuGA4oHli+v39bGjF
         up0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893051; x=1729497851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRbPdgNIVrqSTf/1E3KOMlBjVq1ghJobEnRvorOgv2Y=;
        b=TKVwGX4jnZSTdY+WPP46MDJJsDAUxHzzglCWVxdOP3dmE6f5B98tS6t5md+2WQ0kl8
         WkqjohBI1ITppxF7fprGS92xdAShtF1z7mySOzcHwL5V9Kq3aQKRYHzpOEneCBHnCaeX
         IZLwy8BHr1jpKD9h+z2Vl3EbA3VBtGEdgmHxriI0T8WU4YgTn2fY9kRTP1k6X4RZl5wT
         Zmdaskjy8x9xDkgZMuGr36VRTj5hKXUf6ZLG7YGIYD6XZT08sl9Zm/Zn3PFKyRicU+TP
         8/EUB8hUJJJFOa7kuXKbmZS3+YCZQsXnPWbjtG+z+Mn7OQdnz/PDwBikjxzCfmDrpU4L
         50Lw==
X-Forwarded-Encrypted: i=1; AJvYcCU3jH7Txy0tkjGoobBjtXyabBjuKBUbNWt9PUv/VEQdpJq7gQm3iRyRYM2cyYhM2wP8xJy3N3epJnPW5UA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuwjvoq/gm/otnbUOxnnFC6X6Qi9n9aFGi+xV9Hs2LOCDXpNLV
	HgO5XKUEX9SpNLHilsF7NWVEBAfD0leT4htCEgG2CtgP/FlTL9dogm4vNy8Vt4s=
X-Google-Smtp-Source: AGHT+IGMVMiVX34iHP51EtutG0xflfB9SX3ApfsR35FJAr5dmbDQdsvuJ7+4vRPFrG4oPA0bt0o7Hg==
X-Received: by 2002:a05:6512:114f:b0:535:6992:f2cb with SMTP id 2adb3069b0e04-539da586e45mr4472475e87.42.1728893051314;
        Mon, 14 Oct 2024 01:04:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e9b46546sm738844e87.301.2024.10.14.01.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:04:10 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:04:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Liu Ying <victor.liu@nxp.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "rfoss@kernel.org" <rfoss@kernel.org>, 
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>, "geert+renesas@glider.be" <geert+renesas@glider.be>, 
	"arnd@arndb.de" <arnd@arndb.de>, "nfraprado@collabora.com" <nfraprado@collabora.com>, 
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "y.moog@phytec.de" <y.moog@phytec.de>, 
	"marex@denx.de" <marex@denx.de>, "isaac.scott@ideasonboard.com" <isaac.scott@ideasonboard.com>
Subject: Re: [PATCH v2 5/9] dt-bindings: display: bridge: Add ITE IT6263 LVDS
 to HDMI converter
Message-ID: <ki7zj2qvf64oi45kcnxl4maoxfvxtawko3vcdikg7dc5q6gw7u@5obyfvyylb3w>
References: <20241012073543.1388069-1-victor.liu@nxp.com>
 <20241012073543.1388069-6-victor.liu@nxp.com>
 <4a7rwguypyaspgr5akpxgw4c45gph4h3lx6nkjv3znn32cldrk@k7qskts7ws73>
 <07b47f70-5dab-4813-97fa-388a0c0f42e9@nxp.com>
 <dvcdy32dig3w3r3a7eib576zaumsoxw4xb5iw6u6b2rds3zaov@lvdevbyl6skf>
 <90e0c4ac-1636-4936-ba40-2f7693bc6b32@nxp.com>
 <TY3PR01MB11346530A53C8085561713B6086442@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346530A53C8085561713B6086442@TY3PR01MB11346.jpnprd01.prod.outlook.com>

On Mon, Oct 14, 2024 at 07:39:16AM +0000, Biju Das wrote:
> Hi Liu and Dmitry,
> 
> > -----Original Message-----
> > From: Liu Ying <victor.liu@nxp.com>
> > Sent: Monday, October 14, 2024 6:34 AM
> > Subject: Re: [PATCH v2 5/9] dt-bindings: display: bridge: Add ITE IT6263 LVDS to HDMI converter
> > 
> > On 10/14/2024, Dmitry Baryshkov wrote:
> > > On Sat, Oct 12, 2024 at 05:14:13PM +0800, Liu Ying wrote:
> > >> On 10/12/2024, Dmitry Baryshkov wrote:
> > >>> On Sat, Oct 12, 2024 at 03:35:39PM +0800, Liu Ying wrote:
> > >>>> Document ITE IT6263 LVDS to HDMI converter.
> > >>>>
> > >>>> Product link:
> > >>>> https://www.ite.com.tw/en/product/cate1/IT6263
> > >>>>
> > >>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > >>>> ---
> > >>>> v2:
> > >>>> * Document number of LVDS link data lanes.  (Biju)
> > >>>> * Simplify ports property by dropping "oneOf".  (Rob)
> > >>>>
> > >>>>  .../bindings/display/bridge/ite,it6263.yaml   | 276 ++++++++++++++++++
> > >>>>  1 file changed, 276 insertions(+)
> > >>>>  create mode 100644
> > >>>> Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml
> > >>>>
> > >>>> diff --git
> > >>>> a/Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml
> > >>>> b/Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml
> > >>>> new file mode 100644
> > >>>> index 000000000000..bc2bbec07623
> > >>>> --- /dev/null
> > >>>> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6263.y
> > >>>> +++ aml
> > >>>> @@ -0,0 +1,276 @@
> > >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > >>>> +1.2
> > >>>> +---
> > >>>> +$id: http://devicetree.org/schemas/display/bridge/ite,it6263.yaml#
> > >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>>> +
> > >>>> +title: ITE IT6263 LVDS to HDMI converter
> > >>>> +
> > >>>> +maintainers:
> > >>>> +  - Liu Ying <victor.liu@nxp.com>
> > >>>> +
> > >>>> +description: |
> > >>>> +  The IT6263 is a high-performance single-chip De-SSC(De-Spread
> > >>>> +Spectrum) LVDS
> > >>>> +  to HDMI converter.  Combined with LVDS receiver and HDMI 1.4a
> > >>>> +transmitter,
> > >>>> +  the IT6263 supports LVDS input and HDMI 1.4 output by conversion function.
> > >>>> +  The built-in LVDS receiver can support single-link and dual-link
> > >>>> +LVDS inputs,
> > >>>> +  and the built-in HDMI transmitter is fully compliant with HDMI
> > >>>> +1.4a/3D, HDCP
> > >>>> +  1.2 and backward compatible with DVI 1.0 specification.
> > >>>> +
> > >>>> +  The IT6263 also encodes and transmits up to 8 channels of I2S
> > >>>> + digital audio,  with sampling rate up to 192KHz and sample size
> > >>>> + up to 24 bits. In addition,  an S/PDIF input port takes in compressed audio of up to 192KHz
> > frame rate.
> > >>>> +
> > >>>> +  The newly supported High-Bit Rate(HBR) audio by HDMI
> > >>>> + specifications v1.3 is  provided by the IT6263 in two interfaces:
> > >>>> + the four I2S input ports or the  S/PDIF input port.  With both
> > >>>> + interfaces the highest possible HBR frame rate  is supported at up to 768KHz.
> > >>>> +
> > >>>> +properties:
> > >>>
> > >>> No LVDS data-mapping support?
> > >>
> > >> It is enough to document number of LVDS link data lanes because OS
> > >> should be able to determine the data-mapping by looking at the number
> > >> and the data-mapping capability of the other side of the LVDS link.
> > >
> > > From what I can see, data-mapping is specified on the consumer sink
> > > side of the LVDS link. This means it should go to the bridge's device node.
> > 
> > Then, I won't define data-lanes, because data-mapping implies it, e.g., jeida-24 implies data lanes
> > 0/1/2/3, see lvds-data-mapping.yaml.
> > 
> > Please let me know which one you prefer.
> 
> Assume a top level use case where a user changes the format from JEDAI to VESA using On screen 
> display or modetest(if some one adds support for lvds-mapping) then setting of the lvds data mapping
> should be dynamic.
> 
> Maybe for initial version hardcode with JEDAI or VESA as default and provide a way to override
> the host driver and bridge with requested lvds-data mapping dynamically later??

The ite,lvds-link-num-data-lanes property should be removed, it is not
standard. I foresee two ways to specify the number of lanes used: either
the data-lanes property or the data-mapping property. Granted that
data-mapping replaces the data-lanes functionality for LVDS links, I
think it's better to use it from the start.

Frankly speaking, what is the usecase for specifying the data mapping
dynamically? What kind of uAPI do you have in mind and what is the
usecase for it?

-- 
With best wishes
Dmitry

