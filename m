Return-Path: <linux-kernel+bounces-177852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852088C4554
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3421F249D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C69210EC;
	Mon, 13 May 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0F0/V78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5920DC4
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619013; cv=none; b=o+1AWDRvtY50LLLy90acIFWak2J4QAcoLg29Yi+8EsENwL102+RDoHFTGTtcci7xCb1NiI6/TsjjIhtjx2YYF5rAf6F6x6VukeFC7yea0TcC14nU2mi2dhZ12kQyPmCL2UXGyWx2B7CqxoXAb9XLyvUWvVSR2OVda98K4PNiqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619013; c=relaxed/simple;
	bh=kVSNLmMVb3ishC+4udHKioz5ZxxHmqDWUUUuuA8nWc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPBF//zf0LqhWfNARDDWl1Y4T5PX91LSkeSuuyv/LeT4iYPoBrNxOOGdAnqsCmJq0S4d6KIHrx5PtGkPgOns2Lld/xDrNq8EaR1306iA1AKuDWyMX9aq7RPjApoI2PrFHUxChrst1F8SOPGwwGfeXWrj/xRJsbqA74PuRBPoMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0F0/V78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA4BC4AF0D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715619013;
	bh=kVSNLmMVb3ishC+4udHKioz5ZxxHmqDWUUUuuA8nWc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B0F0/V78joq/yEbhD0tf92fIRwmf60l5/p80nc+aV20iAs3E6+rXxrkcb6OakynYA
	 DY12ZdC+uJNi2gz0XEKapwThxCA+nX7OmtJrD0/fejcce5672zFYPXlFfFtMpDV/JC
	 lEI8Fv1zgWo9eSQO08Lam0LNMQXaIeBhEuzXmCzsJ7wjRPfn/skTXVBOSqUgzdGTpJ
	 dwaxCOFE0NvKt6TTqYHw9yg6utRaXGrOgXHi0Ec9DcQiLcn1aB/0/l/kNPinWAIi7+
	 taqDQruFTtl7XlVeVNND/EQHCEvM2Hz7mgB4a0gqnT9TzDYzpGH5ZNvXi6a0CPtBUR
	 F05CKP2vwYK9A==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-241572c02efso2821631fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:50:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVunrd6wyaL3DGiAAd2u9/A5wEGwA8FY/IDB7qUagPIyXk1cspOtuK4NemBfrqb6qafEfw4acRwVGo+rR59kTc9dWc7koZ19OAYHnVB
X-Gm-Message-State: AOJu0YymQT+2FKKMIx+JN8KzvFZ3xUJDNj03uZ8YNJBcoH3NusDFt5CD
	L8/NSy12FGIrvw5Tl/BAl5VTS3+xRLXA+PJQ7HsSLW3lOA3MoqS/u9ZPmq0pXlGm1B5saEb2Mjp
	Rww3hCZnSCrjHaZ7nQ2wLGzTf3pEhyra0zVypmg==
X-Google-Smtp-Source: AGHT+IG9etvbYxYHR0fWxJzpfBkuEGL2PwOBWLMig6t/Z5/hSFgr76RJXGAeEjvXkZP26WGn9lBOmLwbuqRzLnLTm6Q=
X-Received: by 2002:a05:6870:4191:b0:23c:6cb5:24f6 with SMTP id
 586e51a60fabf-241728f480cmr13074398fac.7.1715619012605; Mon, 13 May 2024
 09:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513080243.3952292-1-victor.liu@nxp.com> <4b6e49ee-d2fd-4e54-88d5-ab06d8ebf644@bosc.ac.cn>
In-Reply-To: <4b6e49ee-d2fd-4e54-88d5-ab06d8ebf644@bosc.ac.cn>
From: Robert Foss <rfoss@kernel.org>
Date: Mon, 13 May 2024 18:49:59 +0200
X-Gmail-Original-Message-ID: <CAN6tsi5uZf57G26PmSiUZMCCPAV1dhWGDWT35HPmpVDevVJoxA@mail.gmail.com>
Message-ID: <CAN6tsi5uZf57G26PmSiUZMCCPAV1dhWGDWT35HPmpVDevVJoxA@mail.gmail.com>
Subject: Re: drm/bridge: adv7511: Attach next bridge without creating connector
To: Sui Jingfeng <suijingfeng@bosc.ac.cn>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dmitry.baryshkov@linaro.org, biju.das.jz@bp.renesas.com, aford173@gmail.com, 
	bli@bang-olufsen.dk, robh@kernel.org, jani.nikula@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 6:30=E2=80=AFPM Sui Jingfeng <suijingfeng@bosc.ac.c=
n> wrote:
>
> Hi,
>
>
> On 5/13/24 16:02, Liu Ying wrote:
> > The connector is created by either this ADV7511 bridge driver or
> > any DRM device driver/previous bridge driver, so this ADV7511
> > bridge driver should not let the next bridge driver create connector.
> >
> > If the next bridge is a HDMI connector, the next bridge driver
> > would fail to attach bridge from display_connector_attach() without
> > the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> >
> > Add that flag to drm_bridge_attach() function call in
> > adv7511_bridge_attach() to fix the issue.
> >
> > This fixes the issue where the HDMI connector bridge fails to attach
> > to the previous ADV7535 bridge on i.MX8MP EVK platform:
> >
> > [    2.216442] [drm:drm_bridge_attach] *ERROR* failed to attach bridge =
/hdmi-connector to encoder None-37: -22
> > [    2.220675] mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] us=
ing ADMA
> > [    2.226262] [drm:drm_bridge_attach] *ERROR* failed to attach bridge =
/soc@0/bus@30800000/i2c@30a30000/hdmi@3d to encoder None-37: -22
> > [    2.245204] [drm:drm_bridge_attach] *ERROR* failed to attach bridge =
/soc@0/bus@32c00000/dsi@32e60000 to encoder None-37: -22
> > [    2.256445] imx-lcdif 32e80000.display-controller: error -EINVAL: Fa=
iled to attach bridge for endpoint0
> > [    2.265850] imx-lcdif 32e80000.display-controller: error -EINVAL: Ca=
nnot connect bridge
> > [    2.274009] imx-lcdif 32e80000.display-controller: probe with driver=
 imx-lcdif failed with error -22
> >
> > Fixes: 14b3cdbd0e5b ("drm/bridge: adv7511: make it honour next bridge i=
n DT")
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> >   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu=
/drm/bridge/adv7511/adv7511_drv.c
> > index dd21b81bd28f..66ccb61e2a66 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -953,7 +953,8 @@ static int adv7511_bridge_attach(struct drm_bridge =
*bridge,
> >       int ret =3D 0;
> >
> >       if (adv->next_bridge) {
> > -             ret =3D drm_bridge_attach(bridge->encoder, adv->next_brid=
ge, bridge, flags);
> > +             ret =3D drm_bridge_attach(bridge->encoder, adv->next_brid=
ge, bridge,
> > +                                     flags | DRM_BRIDGE_ATTACH_NO_CONN=
ECTOR);
>
> As a side note, I think, maybe you could do better in the future.
>
> If we know that the KMS display driver side has the HDMI connector
> already created for us, we should pass DRM_BRIDGE_ATTACH_NO_CONNECTOR
> from the root KMS driver side. Which is to forbidden all potential
> drm bridge drivers to create a connector in the middle.
>
> The KMS display driver side could parse the DT to know if there is
> a hdmi connector, or merely just hdmi connector device node, or
> something else.
>
> However, other maintainer and/or reviewer's opinion are of cause
> more valuable. I send a A-b because I thought the bug is urgency
> and it's probably more important to solve this bug first. And
> maybe you can Cc: <stable@vger.kernel.org> if you like.
>

Reviewed-by: Robert Foss <rfoss@kernel.org>

