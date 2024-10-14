Return-Path: <linux-kernel+bounces-363930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF7A99C8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3668B2AE38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE0F1A7AE3;
	Mon, 14 Oct 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ve6xDzpA"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E41AB6ED
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904596; cv=none; b=oF+P1EablG/NkomYIkoMkk+kebnvxBpoUkPO8s7T4cKRNEfnxx94khMO2a+hh4EHbSnLRxIq7OSuV3Bf4qy7afmEr9C86m0I3Hny315yuj6kGjCfSe9KoXROd3DcPOXqexKUxKgp8tFIwDDArFuVX3RtwRH3SKYklkI6NGnGZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904596; c=relaxed/simple;
	bh=q8xn13G2JLnINWn7XM/JZSqwR/jIxOEPsASBJ+UhOFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7vkHddGzDZvcB4WWuwomtwu+rM/rMGwW1kiHmg/ow2hZrU/gILlLdpHE7Sm1OwIyZBwPy/cNAKD/SSKJ4rF7+3qNpOrMJZTMSISBtJajv8s23tTpu5gFE3w7l6eAr1XkzCpbVqA0zWQC/zXozYm3iqZ2DeVDlYozgSSUGsVeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ve6xDzpA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb51f39394so6376891fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728904593; x=1729509393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iKMYh9oSOiPHX5MB8zVYm5Uz7Q4gZEo4Fjhxbd/uKo=;
        b=ve6xDzpA2y7WtmUBJet57yxraZQdz8FAyydO1mjxXlpRi5D3+DipI+MK+zS5WZGphZ
         9fvx2y5XTwN6FJXamrqyzEiR6JpXJbEEk23bs0gXFWrVyiC3vWusA61jcggBSptgAw+U
         RD+657zwYeYyk4dHkVVTmMFVzQYVScXCrHuTjcNgaMFUoTFSCHEvXBbzcM8d94Mk7iY+
         oZ95SMbAH0g9OJYztANDhT8gFAEsDskS1Si519Gr59tV8rCQXdINwoUls5YuRCerUjjH
         UPnViiE9fdI29CcTavgXVC9WfRjb2yO/UK1UAyClQbztdxa2f72PMTrmvyZ+KOpeFYGW
         PaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728904593; x=1729509393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iKMYh9oSOiPHX5MB8zVYm5Uz7Q4gZEo4Fjhxbd/uKo=;
        b=tFo3zUly7PlhT2v3NeGd/Utm/YrZYdb5x3vgyANDW+rw/B8IwnFc7mjdOAy8LaDrPL
         5jVCPmikfFNK9eaHpKjr0wogD5zLeVqSIR7s4ywjtKys91UrwB9RmhPw/Rzi/rxU4Hqm
         40hWfzXX5CaT1BEG8KrlW2v1355GMA+Rj3oVzbV9s0HEhCq9xdXPisBUlvp5NsP7uL4G
         xhvmrHjpRM8eVjYPbVINM6lXsh0GINKb96rZQ+zxDXzeNusle9NE6hv/lvEIDNYCmfYF
         DMaCjaVBoyGcEPHSPtOfO/2HUY+gxZ8dKBu/ELyySIL0eIg8wSt4JOCLv3REATv1pYn1
         9ENQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB6UgYqBrCSehyoZIi21oz7qAxBmGUqbmBr99jLSEKmEmsVIXHRuxXF/vMuOHWQE1+l6d6aNQmIUKc2gM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5tT62/+vjLEt/NUxTOxJFqvn/8m3Fp2K+ToHVxQDjQTBQ/4K
	oXDVRUOwwveW0g2p+ObtsPIAYkNETOs/89BguF9UZ9IeLFPOoVE+exi2am11wxI=
X-Google-Smtp-Source: AGHT+IFyRE26TjB4tT/MsFr8imPfDicH3NsN5nWBwmwpqRjbY5FCggbJmvwRTRVlwm6RGPRd3jbmvQ==
X-Received: by 2002:a2e:e19:0:b0:2f5:2e2:eadf with SMTP id 38308e7fff4ca-2fb3270ab14mr38619491fa.10.1728904592591;
        Mon, 14 Oct 2024 04:16:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb50148d25sm3695571fa.97.2024.10.14.04.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:16:31 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:16:28 +0300
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
Message-ID: <p42wdftkplib2c3hrnobinhytglok53cunqywtbcdfcp4gg7cg@4oclcixgcxso>
References: <20241012073543.1388069-1-victor.liu@nxp.com>
 <20241012073543.1388069-6-victor.liu@nxp.com>
 <4a7rwguypyaspgr5akpxgw4c45gph4h3lx6nkjv3znn32cldrk@k7qskts7ws73>
 <07b47f70-5dab-4813-97fa-388a0c0f42e9@nxp.com>
 <dvcdy32dig3w3r3a7eib576zaumsoxw4xb5iw6u6b2rds3zaov@lvdevbyl6skf>
 <90e0c4ac-1636-4936-ba40-2f7693bc6b32@nxp.com>
 <TY3PR01MB11346530A53C8085561713B6086442@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ki7zj2qvf64oi45kcnxl4maoxfvxtawko3vcdikg7dc5q6gw7u@5obyfvyylb3w>
 <TY3PR01MB113463A0E53DAA7481926219186442@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113463A0E53DAA7481926219186442@TY3PR01MB11346.jpnprd01.prod.outlook.com>

On Mon, Oct 14, 2024 at 08:09:44AM +0000, Biju Das wrote:
> Hi Dmitry,
> 
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: Monday, October 14, 2024 9:04 AM
> > Subject: Re: [PATCH v2 5/9] dt-bindings: display: bridge: Add ITE IT6263 LVDS to HDMI converter
> > 
> > On Mon, Oct 14, 2024 at 07:39:16AM +0000, Biju Das wrote:
> > > Hi Liu and Dmitry,
> > >
> > > > -----Original Message-----
> > > > From: Liu Ying <victor.liu@nxp.com>
> > > > Sent: Monday, October 14, 2024 6:34 AM
> > > > Subject: Re: [PATCH v2 5/9] dt-bindings: display: bridge: Add ITE
> > > > IT6263 LVDS to HDMI converter
> > > >
> > > > On 10/14/2024, Dmitry Baryshkov wrote:
> > > > > On Sat, Oct 12, 2024 at 05:14:13PM +0800, Liu Ying wrote:
> > > > >> On 10/12/2024, Dmitry Baryshkov wrote:
> > > > >>> On Sat, Oct 12, 2024 at 03:35:39PM +0800, Liu Ying wrote:
> > > > >>>> Document ITE IT6263 LVDS to HDMI converter.
> > > > >>>>
> > > > >>>> Product link:
> > > > >>>> https://www.ite.com.tw/en/product/cate1/IT6263
> > > > >>>>
> > > > >>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > >>>> ---
> > > > >>>> v2:
> > > > >>>> * Document number of LVDS link data lanes.  (Biju)
> > > > >>>> * Simplify ports property by dropping "oneOf".  (Rob)
> > > > >>>>
> > > > >>>>  .../bindings/display/bridge/ite,it6263.yaml   | 276 ++++++++++++++++++
> > > > >>>>  1 file changed, 276 insertions(+)  create mode 100644
> > > > >>>> Documentation/devicetree/bindings/display/bridge/ite,it6263.yam
> > > > >>>> l
> > > > >>>>
> > > > >>>> diff --git
> > > > >>>> a/Documentation/devicetree/bindings/display/bridge/ite,it6263.y
> > > > >>>> aml
> > > > >>>> b/Documentation/devicetree/bindings/display/bridge/ite,it6263.y
> > > > >>>> aml
> > > > >>>> new file mode 100644
> > > > >>>> index 000000000000..bc2bbec07623
> > > > >>>> --- /dev/null
> > > > >>>> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it62
> > > > >>>> +++ 63.y
> > > > >>>> +++ aml
> > > > >>>> @@ -0,0 +1,276 @@
> > > > >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > >>>> +%YAML
> > > > >>>> +1.2
> > > > >>>> +---
> > > > >>>> +$id:
> > > > >>>> +http://devicetree.org/schemas/display/bridge/ite,it6263.yaml#
> > > > >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > >>>> +
> > > > >>>> +title: ITE IT6263 LVDS to HDMI converter
> > > > >>>> +
> > > > >>>> +maintainers:
> > > > >>>> +  - Liu Ying <victor.liu@nxp.com>
> > > > >>>> +
> > > > >>>> +description: |
> > > > >>>> +  The IT6263 is a high-performance single-chip
> > > > >>>> +De-SSC(De-Spread
> > > > >>>> +Spectrum) LVDS
> > > > >>>> +  to HDMI converter.  Combined with LVDS receiver and HDMI
> > > > >>>> +1.4a transmitter,
> > > > >>>> +  the IT6263 supports LVDS input and HDMI 1.4 output by conversion function.
> > > > >>>> +  The built-in LVDS receiver can support single-link and
> > > > >>>> +dual-link LVDS inputs,
> > > > >>>> +  and the built-in HDMI transmitter is fully compliant with
> > > > >>>> +HDMI 1.4a/3D, HDCP
> > > > >>>> +  1.2 and backward compatible with DVI 1.0 specification.
> > > > >>>> +
> > > > >>>> +  The IT6263 also encodes and transmits up to 8 channels of
> > > > >>>> + I2S digital audio,  with sampling rate up to 192KHz and
> > > > >>>> + sample size up to 24 bits. In addition,  an S/PDIF input port
> > > > >>>> + takes in compressed audio of up to 192KHz
> > > > frame rate.
> > > > >>>> +
> > > > >>>> +  The newly supported High-Bit Rate(HBR) audio by HDMI
> > > > >>>> + specifications v1.3 is  provided by the IT6263 in two interfaces:
> > > > >>>> + the four I2S input ports or the  S/PDIF input port.  With
> > > > >>>> + both interfaces the highest possible HBR frame rate  is supported at up to 768KHz.
> > > > >>>> +
> > > > >>>> +properties:
> > > > >>>
> > > > >>> No LVDS data-mapping support?
> > > > >>
> > > > >> It is enough to document number of LVDS link data lanes because
> > > > >> OS should be able to determine the data-mapping by looking at the
> > > > >> number and the data-mapping capability of the other side of the LVDS link.
> > > > >
> > > > > From what I can see, data-mapping is specified on the consumer
> > > > > sink side of the LVDS link. This means it should go to the bridge's device node.
> > > >
> > > > Then, I won't define data-lanes, because data-mapping implies it,
> > > > e.g., jeida-24 implies data lanes 0/1/2/3, see lvds-data-mapping.yaml.
> > > >
> > > > Please let me know which one you prefer.
> > >
> > > Assume a top level use case where a user changes the format from JEDAI
> > > to VESA using On screen display or modetest(if some one adds support
> > > for lvds-mapping) then setting of the lvds data mapping should be dynamic.
> > >
> > > Maybe for initial version hardcode with JEDAI or VESA as default and
> > > provide a way to override the host driver and bridge with requested lvds-data mapping dynamically
> > later??
> > 
> > The ite,lvds-link-num-data-lanes property should be removed, it is not standard. I foresee two ways to
> > specify the number of lanes used: either the data-lanes property or the data-mapping property. Granted
> > that data-mapping replaces the data-lanes functionality for LVDS links, I think it's better to use it
> > from the start.
> > 
> > Frankly speaking, what is the usecase for specifying the data mapping dynamically? What kind of uAPI
> > do you have in mind and what is the usecase for it?
> 
> It simple just want to change from VESA to JEDAI, how do you change it with existing DRM framework?

Why do you want to change it on the fly?

> Currently I see LVDS panel driver use drm_of_lvds_get_data_mapping(bus_node) to get this info.
> IT6263 bridge device can use that API to get that info.
> 
> Some vendors use VESA as default LVDS data mapping whereas some others use JEDAI.

I think this is logical. Bus format is set by the system design
constraints. In theory one can use buf format negotiation for the same
purpose.

> 
> Cheers,
> Biju

-- 
With best wishes
Dmitry

