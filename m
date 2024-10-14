Return-Path: <linux-kernel+bounces-363970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A7699C911
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06771292AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563F1922CA;
	Mon, 14 Oct 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkYpQu61"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9B18B49A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905787; cv=none; b=IaZ02GCydM2477oh6sIuGGBTWzo2y6ZmrmKNA3vHWFKXUo5SbhAI3QqPioASW6HA0NZ+oqQtwcsGPwEC572AtlgknjuQCKBp3tNv0wZwW6/sb/c0L/vPfgB7Sh2M10ZxkmJT/Euq00zwshMtKgofApDtON0ACyw9kSqzi0IkCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905787; c=relaxed/simple;
	bh=SXHKxT2y7Z7lNf5pYB6RCgpmwrOCpynfldpInI1bKIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpVLSrWF8Qv5rq8AbdnK4pLubhiWNLT2AxKIk6Ntrg3UTTlxuPNSuFED89Wdug/h/Lqmo2Cua12wOJbkzVAi0pC9LAneDzICOnlX/mJ9wv7B77GAHB1t0cNwxZg3cQqaZUuDu0Vd4E8NBTM8vtEeojSftLjXtyBvzxlAAvxIOME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OkYpQu61; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539d0929f20so3195769e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728905783; x=1729510583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbTXzF0osqbJDrE5clHyzGt3K+Yl/D9mRlBFQz2gB+k=;
        b=OkYpQu61bpklNGbTNobj8egiSbP6qSGAZoyk5SDwch8TXt6AJKz6rl3MLhioUqQ/eA
         MQcdL99nLxeXQ9dqLInp6J+CH1NGq6BPbXc8DQYcp4yz37VtkyLE9Xvvxx6KxSseD4WA
         8ssIMezkxdrOhawVqbl3WrfNo2VOnmZxawbaiP+Wom6ummUTKntNSMtkKXl5P4TXRzx+
         G1zMcqbq4+MUWAyR6rhDZ8/RFcq/MI4m+o5gOXjWANz+MT5M0zQfsgTcjnSgMfJJePHF
         L8yxmkMP5qMQsSKTQcZYEN9lQPC7kNfq6nTH8eLcD+AJ/IhV7GN6VO7hyQNZMwvh1tmP
         ejrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728905783; x=1729510583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbTXzF0osqbJDrE5clHyzGt3K+Yl/D9mRlBFQz2gB+k=;
        b=KfwtewWxYmLw8jCUBVfhTiGxeJaaLk+NdbQoNLSgfg3Wc86vrEn+xlL9/e1whciabP
         t9gunEcGY+4WX7TjbpBxOFxLRwwgLHxg2v8JjNk5sTyeMAHAvRlnN/UEJ8iaYzXlYboL
         fnhhRg77L1JAK2UXBh3KWMSgsbmzk9BFKoSTGbVP37xcc2GwZr9QWfwHPjd9MOv9NW37
         zDwi0S/s3H43vJVs+rnCbT3V6AK3uzcp2XhpX0kHSXYyjg3yaEMGqrLAN81n7f6Rte8Z
         pv9jSFjCYjOxe1uuJ2ll2OGpv4wXf1D7uK5EAOPtCSaul0zQ7lwKsY9ZU8zLs3CHzmF6
         d5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXUEHnPsrezy873anEQ1rYEvNFKJCFTSBL01YKUzobcloIftnWIsDe0Peca2GAVnUsJ7BRaLtcGJ/4SUDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQRTLsI+kiv2Fn/GMM0s7CFuJmekcZKXb1qUmJ8NbTMfuasK7
	3sSSngNxExWZm7V2yRdPCj6hKNjqfRMT4s9fxF3KMGZWsxyUq1H045YQFRORUsY=
X-Google-Smtp-Source: AGHT+IHxzBuSXYdsI7gy+YwHTvuSjC2W0gKjQgcsdxMHXJdB25sL8phB2jb/do78k4so6lsJSE68rQ==
X-Received: by 2002:a05:6512:31d2:b0:539:e4ad:8bab with SMTP id 2adb3069b0e04-539e4ad8e8dmr2509315e87.16.1728905783155;
        Mon, 14 Oct 2024 04:36:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539dd4273cbsm1216279e87.299.2024.10.14.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:36:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:36:21 +0300
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
Message-ID: <3vdvdbgf5mof3alc4o2ahvhgcxgvfvxt2kdi2rkypptegv3pw4@7bkkwliluml2>
References: <20241012073543.1388069-6-victor.liu@nxp.com>
 <4a7rwguypyaspgr5akpxgw4c45gph4h3lx6nkjv3znn32cldrk@k7qskts7ws73>
 <07b47f70-5dab-4813-97fa-388a0c0f42e9@nxp.com>
 <dvcdy32dig3w3r3a7eib576zaumsoxw4xb5iw6u6b2rds3zaov@lvdevbyl6skf>
 <90e0c4ac-1636-4936-ba40-2f7693bc6b32@nxp.com>
 <TY3PR01MB11346530A53C8085561713B6086442@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ki7zj2qvf64oi45kcnxl4maoxfvxtawko3vcdikg7dc5q6gw7u@5obyfvyylb3w>
 <TY3PR01MB113463A0E53DAA7481926219186442@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <p42wdftkplib2c3hrnobinhytglok53cunqywtbcdfcp4gg7cg@4oclcixgcxso>
 <TY3PR01MB1134657F6286446CE3A9D168586442@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3PR01MB1134657F6286446CE3A9D168586442@TY3PR01MB11346.jpnprd01.prod.outlook.com>

On Mon, Oct 14, 2024 at 11:25:00AM +0000, Biju Das wrote:
> Hi Dmitry,
> 
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: Monday, October 14, 2024 12:16 PM
> > Subject: Re: [PATCH v2 5/9] dt-bindings: display: bridge: Add ITE IT6263 LVDS to HDMI converter
> > 
> > On Mon, Oct 14, 2024 at 08:09:44AM +0000, Biju Das wrote:
> > > Hi Dmitry,
> > >
> > > > -----Original Message-----
> > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Sent: Monday, October 14, 2024 9:04 AM
> > > > Subject: Re: [PATCH v2 5/9] dt-bindings: display: bridge: Add ITE
> > > > IT6263 LVDS to HDMI converter
> > > >
> > > > On Mon, Oct 14, 2024 at 07:39:16AM +0000, Biju Das wrote:
> > > > > Hi Liu and Dmitry,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Liu Ying <victor.liu@nxp.com>
> > > > > > Sent: Monday, October 14, 2024 6:34 AM
> > > > > > Subject: Re: [PATCH v2 5/9] dt-bindings: display: bridge: Add
> > > > > > ITE
> > > > > > IT6263 LVDS to HDMI converter
> > > > > >
> > > > > > On 10/14/2024, Dmitry Baryshkov wrote:
> > > > > > > On Sat, Oct 12, 2024 at 05:14:13PM +0800, Liu Ying wrote:
> > > > > > >> On 10/12/2024, Dmitry Baryshkov wrote:
> > > > > > >>> On Sat, Oct 12, 2024 at 03:35:39PM +0800, Liu Ying wrote:
> > > > > > >>>> Document ITE IT6263 LVDS to HDMI converter.
> > > > > > >>>>
> > > > > > >>>> Product link:
> > > > > > >>>> https://www.ite.com.tw/en/product/cate1/IT6263
> > > > > > >>>>
> > > > > > >>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > > >>>> ---
> > > > > > >>>> v2:
> > > > > > >>>> * Document number of LVDS link data lanes.  (Biju)
> > > > > > >>>> * Simplify ports property by dropping "oneOf".  (Rob)
> > > > > > >>>>
> > > > > > >>>>  .../bindings/display/bridge/ite,it6263.yaml   | 276 ++++++++++++++++++
> > > > > > >>>>  1 file changed, 276 insertions(+)  create mode 100644
> > > > > > >>>> Documentation/devicetree/bindings/display/bridge/ite,it6263
> > > > > > >>>> .yam
> > > > > > >>>> l
> > > > > > >>>>
> > > > > > >>>> diff --git
> > > > > > >>>> a/Documentation/devicetree/bindings/display/bridge/ite,it62
> > > > > > >>>> 63.y
> > > > > > >>>> aml
> > > > > > >>>> b/Documentation/devicetree/bindings/display/bridge/ite,it62
> > > > > > >>>> 63.y
> > > > > > >>>> aml
> > > > > > >>>> new file mode 100644
> > > > > > >>>> index 000000000000..bc2bbec07623
> > > > > > >>>> --- /dev/null
> > > > > > >>>> +++ b/Documentation/devicetree/bindings/display/bridge/ite,
> > > > > > >>>> +++ it62
> > > > > > >>>> +++ 63.y
> > > > > > >>>> +++ aml
> > > > > > >>>> @@ -0,0 +1,276 @@
> > > > > > >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > >>>> +%YAML
> > > > > > >>>> +1.2
> > > > > > >>>> +---
> > > > > > >>>> +$id:
> > > > > > >>>> +http://devicetree.org/schemas/display/bridge/ite,it6263.ya
> > > > > > >>>> +ml#
> > > > > > >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > >>>> +
> > > > > > >>>> +title: ITE IT6263 LVDS to HDMI converter
> > > > > > >>>> +
> > > > > > >>>> +maintainers:
> > > > > > >>>> +  - Liu Ying <victor.liu@nxp.com>
> > > > > > >>>> +
> > > > > > >>>> +description: |
> > > > > > >>>> +  The IT6263 is a high-performance single-chip
> > > > > > >>>> +De-SSC(De-Spread
> > > > > > >>>> +Spectrum) LVDS
> > > > > > >>>> +  to HDMI converter.  Combined with LVDS receiver and HDMI
> > > > > > >>>> +1.4a transmitter,
> > > > > > >>>> +  the IT6263 supports LVDS input and HDMI 1.4 output by conversion function.
> > > > > > >>>> +  The built-in LVDS receiver can support single-link and
> > > > > > >>>> +dual-link LVDS inputs,
> > > > > > >>>> +  and the built-in HDMI transmitter is fully compliant
> > > > > > >>>> +with HDMI 1.4a/3D, HDCP
> > > > > > >>>> +  1.2 and backward compatible with DVI 1.0 specification.
> > > > > > >>>> +
> > > > > > >>>> +  The IT6263 also encodes and transmits up to 8 channels
> > > > > > >>>> + of I2S digital audio,  with sampling rate up to 192KHz
> > > > > > >>>> + and sample size up to 24 bits. In addition,  an S/PDIF
> > > > > > >>>> + input port takes in compressed audio of up to 192KHz
> > > > > > frame rate.
> > > > > > >>>> +
> > > > > > >>>> +  The newly supported High-Bit Rate(HBR) audio by HDMI
> > > > > > >>>> + specifications v1.3 is  provided by the IT6263 in two interfaces:
> > > > > > >>>> + the four I2S input ports or the  S/PDIF input port.  With
> > > > > > >>>> + both interfaces the highest possible HBR frame rate  is supported at up to 768KHz.
> > > > > > >>>> +
> > > > > > >>>> +properties:
> > > > > > >>>
> > > > > > >>> No LVDS data-mapping support?
> > > > > > >>
> > > > > > >> It is enough to document number of LVDS link data lanes
> > > > > > >> because OS should be able to determine the data-mapping by
> > > > > > >> looking at the number and the data-mapping capability of the other side of the LVDS link.
> > > > > > >
> > > > > > > From what I can see, data-mapping is specified on the consumer
> > > > > > > sink side of the LVDS link. This means it should go to the bridge's device node.
> > > > > >
> > > > > > Then, I won't define data-lanes, because data-mapping implies
> > > > > > it, e.g., jeida-24 implies data lanes 0/1/2/3, see lvds-data-mapping.yaml.
> > > > > >
> > > > > > Please let me know which one you prefer.
> > > > >
> > > > > Assume a top level use case where a user changes the format from
> > > > > JEDAI to VESA using On screen display or modetest(if some one adds
> > > > > support for lvds-mapping) then setting of the lvds data mapping should be dynamic.
> > > > >
> > > > > Maybe for initial version hardcode with JEDAI or VESA as default
> > > > > and provide a way to override the host driver and bridge with
> > > > > requested lvds-data mapping dynamically
> > > > later??
> > > >
> > > > The ite,lvds-link-num-data-lanes property should be removed, it is
> > > > not standard. I foresee two ways to specify the number of lanes
> > > > used: either the data-lanes property or the data-mapping property.
> > > > Granted that data-mapping replaces the data-lanes functionality for LVDS links, I think it's
> > better to use it from the start.
> > > >
> > > > Frankly speaking, what is the usecase for specifying the data
> > > > mapping dynamically? What kind of uAPI do you have in mind and what is the usecase for it?
> > >
> > > It simple just want to change from VESA to JEDAI, how do you change it with existing DRM framework?
> > 
> > Why do you want to change it on the fly?
> 
> It will reduce validation effort for LVDS and bridge driver for testing various bus formats.
> 
> By allowing on the fly, with single dtb, we can validate various bus formats.
> Otherwise each dtb for testing each bus format.

I see your point, but I don't think it falls into the uAPI area. Feel
free to propose a mechanism to change data-mapping through the debugfs
though. I think that's the best possible option.

> 
> From a product perspective, this use case is not valid.
> 
> Cheers,
> Biju
> 

-- 
With best wishes
Dmitry

