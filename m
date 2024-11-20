Return-Path: <linux-kernel+bounces-415107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE0C9D31A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5ACB23B73
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE461BDDF;
	Wed, 20 Nov 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B77kN8Ej"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED810A3E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732064975; cv=none; b=HWNsF2hx4PNe2pnkwv4fi3HtCOsVXDbvA7SDUoIVSlQF6t4gOFlNM5qZBIMsYQBwR4hGBR68xoOsDudhdd6c0JWDMOkfZbwf7J6SHqDKq588oEz1Z7K4U/SZ8oQiaTfBPK40IjdmqB7NcyqE6TgCn0kpzMB1wOziAbZPeMvTSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732064975; c=relaxed/simple;
	bh=Vj355c/zFITMQdHKCKf583txuNNPyzHRszs0Cn12ivQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBh03z3gPSVF0QuztzQGTYip1hNLk51aZRFgjTaXVgGYmD/SPV6UyQ4FWM7oF4fwqbx2ZbL5cV6LCeTekhLN+pLL4IuH0WxRzdMNOEBc/EaUBw3tVBAYZzVXrfzsIl2NbySURBBJxOi2Oy78NPI24+xWmHXW0s4GKNFt4lTkW28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B77kN8Ej; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d41b209858so10665226d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732064972; x=1732669772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj355c/zFITMQdHKCKf583txuNNPyzHRszs0Cn12ivQ=;
        b=B77kN8EjGZSnqUwsRacSUr5i98AzOhvhVFfm67oOos5KeTsUjsq66VZKUMLiuHdnmf
         u84hK+uo76URV17U6oggKMzkNEwnj0K1Rfm2Ir0e9bLSNKwL5jz8utCjtdN/XbDWkurS
         Xa08OWdflmRfegX/JAQeICrYaR1rMCGQnVN3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732064972; x=1732669772;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj355c/zFITMQdHKCKf583txuNNPyzHRszs0Cn12ivQ=;
        b=Htp1FfEXkPZ4mDB0fVgI4wISI6bRkXF1KBgfZDQZle6HzOD1asPnj2NbkYap1bWNSg
         kEJ0dS31kz5bsuH9b2AHBMkRDhOUhbFhCfaKA+ZmxterOiPK39E2QGpNCJAlxs5J12+B
         MuXLX4YVbch3dK/bMvgbgCI+jAedjtTVgH43rxvwyaYDxbIAjhA2gpyFqR42Q1yDKxsE
         tBhmA+sWSFZRX68w8bNgxlKx1tYidODrVC2knjVx1KD2EzjA5VpoBjoN9pGYOsv5N5ch
         C5CiMQU9OMUQb6TvvG0CM4/xFz5c0F8vF+C3/zWOaTnwqZyPVxjP8DAriZW932Asl6fR
         okCg==
X-Forwarded-Encrypted: i=1; AJvYcCVRYZzT9Igmq+r4A25xCN3tLmy4gS8YJ6OD/2P9O3/seNVqFpOzEC61cV98dHuia+kSg//bR7ewVhQ1nuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwznmkC5Qq6HuPXqAOMRUzJrLoECqejrIjm4NCuZACO6m1opILD
	UanGdYBrVB2IxDYoHc8WVdVszFuPMeinAp78h85NoglSqA1HZd3X90HE0H8FTC9Ot4Ghr2BmGN6
	3IrH6jhHn5k/7nsReY+r3o6BQ6LiEhT5zMbdr
X-Gm-Gg: ASbGncvEGSS66iFaD9uZJAcZP88goLjjlmYWcJlkEdTf/zb22viaqG0sxziIPi7P0JQ
	MxeigHOnvVLiAxMcMtrtUG9ROQ3I6U+E4rC97/gdRYfZist/9qhuqrZsPuDk=
X-Google-Smtp-Source: AGHT+IFEQP0GoC2K78QjB5OV4UVVBTAop+qg+n0pMj+V8unQfj0rGdOhjC0ubNaryFKoIeIMuX2Cx56PFjeqpAF1wOA=
X-Received: by 2002:ad4:5ca4:0:b0:6cc:567:d595 with SMTP id
 6a1803df08f44-6d4377afcf2mr13493476d6.7.1732064972431; Tue, 19 Nov 2024
 17:09:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Nov 2024 20:09:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5kisfv22tgqwzjpxqrbx56ywr7l4r7pny3pl2r7crv4rijqbwk@azricdasttg7>
References: <phdcjgqqpjpruxp7v2mw446q73xr3eg4wfgfbjw5tasgr2pgg2@77swbk47b2tg>
 <lf7y7wpuca6kzqcglgs5d443iusf7xjocum4adi7t3npfavccx@zgsp37oyztme>
 <CAE-0n53-KmOS3zXmJPvOOZ7xxkek9-S=oBExgaY0PDnt_HjdNw@mail.gmail.com>
 <yk3xidaisbd56yndaucax7otijjauqmm7lqm6q4q633kdawlqo@qaq27lwxmvwd>
 <CAE-0n501j+8bMnMKabFyZjn+MLUy3Z68Hiv1PsfW0APy5ggN8g@mail.gmail.com>
 <gstohhcdnmnkszk4l2ikd5xiewtotgo5okia62paauj6zpaw7y@4wchyvoynm2p>
 <CAE-0n50z6MNa7WOsg-NU7k8BpFeJJyYfHX3ov6DsthLWauSNpA@mail.gmail.com>
 <hqmx7jtkvrwvb27n56hw7rpefhp37lhr3a5fawz7gsl76uuj5s@h7m6wpdhibkk>
 <CAE-0n50y1O2C47zOGJPmMjKXK_m6a=jhpEAP4nW+RymZbo2xyg@mail.gmail.com> <5kisfv22tgqwzjpxqrbx56ywr7l4r7pny3pl2r7crv4rijqbwk@azricdasttg7>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Tue, 19 Nov 2024 20:09:31 -0500
Message-ID: <CAE-0n50Bxi2GfnxOmMwe-F+k5jMSiyAVPDb6K8pYm-i6hpJTOA@mail.gmail.com>
Subject: Re: [PATCH v4 15/18] dt-bindings: usb: Add ports to
 google,cros-ec-typec for DP altmode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-11-15 09:17:15)
> On Mon, Nov 11, 2024 at 06:16:27PM -0800, Stephen Boyd wrote:
> > Quoting Dmitry Baryshkov (2024-11-08 23:05:18)
> > > On Thu, Nov 07, 2024 at 04:28:24PM -0800, Stephen Boyd wrote:
> > > > Quoting Dmitry Baryshkov (2024-10-31 15:54:49)
> > > > > On Thu, Oct 31, 2024 at 02:45:29PM -0700, Stephen Boyd wrote:
> > > > > > Quoting Dmitry Baryshkov (2024-10-31 11:42:36)
> > > > > > > On Tue, Oct 29, 2024 at 01:15:51PM -0700, Stephen Boyd wrote:
> > > > Long story short, I don't see how we can avoid _any_ lane assignment
> > > > logic in drm_bridge. The logic shouldn't walk the entire bridge chain,
> > > > but it should at least act on the bridge that is a DP bridge. I think
> > > > you're saying pretty much the same thing here, but you want the lane
> > > > remapping to be done via the typec layer whereas I want it to be done in
> > > > the drm_bridge layer. To me it looks out of place to add a
> > > > typec_switch_desc inside each DP drm_bridge because we duplicate the
> > > > logic about USB type-c DP altmode lane assignment to each DP bridge. A
> > > > DP bridge should just think about DP and not know or care about USB
> > > > type-c.
> > > >
> > > > This is what's leading me to think we need some sort of lane assignment
> > > > capability at the DP connector. How that assignment flows from the DP
> > > > connector created in drm_bridge_connector.c to the hardware is where it
> > > > is less clear to me. Should that be implemented as a typec_switch_desc,
> > > > essentially out of band with drm_bridge, or as some drm_bridge_funcs
> > > > function similar to struct drm_bridge_funcs::hdmi_*()? If you look at
> > > > IT6505 in it6505_get_extcon_property() it actually wants to pull the
> > > > orientation of the type-c port with extcon_get_property(EXTCON_DISP_DP,
> > > > EXTCON_PROP_USB_TYPEC_POLARITY). Maybe pushing the orientation to the DP
> > > > bridge is backwards and we should be exposing this as some sort of
> > > > connector API that the drm_bridge can query whenever it wants.
> > >
> > > And it6505_get_extcon_property() / EXTCON_PROP_USB_TYPEC_POLARITY is a
> > > Type-C code, isn't it?
> > >
> >
> > Sort of? It's combining DP and USB_TYPEC enums there so it's not very
> > clear if it's one or the other instead of just both.
>
> But EXTCON_PROP_USB_TYPEC_POLARITY is just a Type-C, nothing about DP in it.

It's extcon_get_property(it6505->extcon, EXTCON_DISP_DP,
EXTCON_PROP_USB_TYPEC_POLARITY, ...) which has EXTCON_DISP_DP in there,
so there's something about DP there. That's all I'm saying.

> >
> > I understand that the QMP PHY driver has implemented the lane control
> > for orientation with a typec_switch_desc, but the QMP PHY is a plain DP
> > PHY in this scenario. How would the type-c handlers work here? We
> > couldn't call them through the type-c framework as far as I can tell.
>
> If QMP PHY is a plain DP PHY, it usually has no support for lane remapping
> (e.g. phy-qcom-edp doesn't).
>
> Let me reiterate, please: lane management is outside of the DisplayPort
> spec, at least as far as I can understand it. All lane remapping
> (especially a dynamic one) is a pure vendor extension to the standard.
> I'm trying to find a way to support Corsola and Trogdor without adding
> "this is done specially for Google" kind of API. Usually that doesn't
> fly in the long term.

Got it.

>
> I understand that using Type-C API for the DRM bridge sounds strange.
> But even the mentioned bridge uses Type-C API. It asks for the Type-C
> polarity, not the DP polarity.
>

I understand that lane assignment isn't part of the DisplayPort spec,
while it is part of the USB Type-C DisplayPort Altmode spec.

I'm not entirely convinced that lane assignment is _only_ part of the
altmode spec and should be implemented with a typec switch though,
because I imagine some hardware design could be created that has two
DisplayPort connectors, just like these two USB-C connectors, and some
sort of HPD redriver logic similar to the EC that decides which DP port
"wins" and should have DP sent to it. Or perhaps 2 lanes DP to a DP
connector and 2 lanes DP sent to a DP to HDMI bridge (shudder). In
either case, USB type-c isn't involved.

It sounds like we're debating how to handle lane assignment in the
kernel. Either way, the code is going to be implemented in the bridge
driver because it's the one that has to change what physical lane a
logical lane is assigned to. The question is if it should be some sort
of bridge_funcs callback, or should bridge drivers hook into the typec
framework to expose an orientation switch, or something else?

I'm thinking we should introduce some sort of bridge_funcs callback that
can be called from the DP altmode driver, either parallel to the
drm_connector_oob_hotplug_event() function or from it directly. If we
can pass the fwnode for the usb-c-connector to the oob_hotplug_event
callback, maybe that's all we need to figure out which lanes go where.
And then in the 2 DP connector muxing world we can call
drm_connector_oob_hotplug_event() with one or the other DP connector
node, which will likely be children nodes of the "HPD redriver" device.

