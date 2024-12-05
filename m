Return-Path: <linux-kernel+bounces-433892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159229E5E6D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC710166AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0243D22D4E3;
	Thu,  5 Dec 2024 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYWosraE"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A27227B98
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424436; cv=none; b=rZZQ2F51wqzuzDxydeg6ZKtXSeVsDQnJ2Io51jriLUc4VoqUIrju7dlucKqhumLiLGimuWXiSQIk9s9fBQgQZMPiKBhPwkqFfVAEEoAfi9XT2xfYwERtOPInaugPrlE63bNZfuC6ND7nUp4+P0JpMfagyG0N2MKLKkDlATm1uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424436; c=relaxed/simple;
	bh=0Xd3Y3Tg1M4AOOd+LSTDLLjxjSv4FiUGmE38eniiojk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvCjGJHtz8IwyFA2yJPo9xzvc/lS1gunLf9o+8VuVCNCH9+Q5eJI5o5HgXf3ITn0IrbYkYQV/iRXsZ2ANu5HdLQJ5zGpr38m3zJc9V02owBA9Vil7sEfv3/JBiiYvbY0eleqIYEUHAmwo/oKlBBqEj22qij6NhiZkHW4h70as9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nYWosraE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de880c77eso1391206e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733424433; x=1734029233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2KZgasCJzLR0eGkxk5shZvmaTdK44fm0EiIl+dZ+os=;
        b=nYWosraEoV3IJW/Dn4WBiT8SY4eV8baxioyYfsLs7z4cP6KBS3E7FEctiZcTFaR0ut
         luDIgpgAU7GaH7gpQkQmPKslLmSmqaIRTjpa9eStTfv65qhYLwwjOfp7Jox+ZZ7TGByg
         p8vtwmrrrXEa0uv+zuudHhSSFSo2CiSy9FJxr9kyJXL6vwozQKAA9lHuZy1UzPE1NOX2
         FPVPfhsuDIyapqDKglUgO9pOnN7rVAORR7qMOJfQyU42wZP2LmE5RYwRMQAw8I4nCCtD
         lAY3YWXHS4g46dXetnyPflEtQSZyNnTpi1nUoE/XDgF64cECNd93Swn7YXLj32QZYrsg
         hP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733424433; x=1734029233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2KZgasCJzLR0eGkxk5shZvmaTdK44fm0EiIl+dZ+os=;
        b=dJAgWcMpYSgC1Y4xoVJ0NVoTi5r5J3AsnDS/tDRLhK9dtTACUQOEKaTHH5PylsOKwk
         Fjbo61g9eSV9PPl8yiNkRPyhRW+Wm/1HkxYLf4Lc7EC+CIgX8QkxbnnV4LKnpNhY2SnZ
         znpQ6/f90TO01EVh1ewckl6ZewN7iQVX0IrpT8yo+xxFt6UHIIHenLhoMJIOlw7pP9Vo
         ARVbr+P72YQrTS1N3MvtfFBapNDNq25gLmUKGUWd88ZXA38AAfG3vies5N0KKyWGkyT1
         reMdZtB+/bcc9FiUdw/suymabqwnurF8XQHC5hFN4GzotD6Ef3ajpCJuafmJGQ3VPiy/
         buqg==
X-Forwarded-Encrypted: i=1; AJvYcCUILbHKrfJCo55MkjX+/PySYsyiKVWRcXXnHS94MloLx8T3HF1XEtZdcpq5KWKbRPg384/2JTRsoPM3Jic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4m0IbCViArh4Ssc5PxUcyshvQWt99DyFiVDCpKEdtgzmsqBi4
	7mWTH3mN95JpGr9w6Gj/R57tRzqygL/LuESrt4oNgTtN/fD9BObTManqNJsu777C4/9qkIH2u99
	L
X-Gm-Gg: ASbGncuKRSw0nKFmoNtMSAFGyl0217o+m46nnlB0Xbedu9u3JknIOAIFefEFvPDdyBi
	1RmmIynwRweP80oO9dIoeFKP74lQ1SSoV+QUkrId8gx+szqgldHI8gzIQCXZZx5KfOeUJ+VrCRG
	3Bam+l5jnjUmPmOcdVNz1W9xiRUJAvYopTPmEwCSGGijFfBeKl+0OYeWgDTL2m0Bj/pULvlMByT
	+0G4lDJLc47DhcwRNq6dz6tHxc2MAxhL5rIFnUMRgui8s1tA/An0WFHZf3bsOsZTJFlCJmo4Czf
	AXVTHbugoQnDI0lfbpV1uCdxt+WrfQ==
X-Google-Smtp-Source: AGHT+IFz9mpVH5Uurdufw2Dv8q5pLYoVIssxSoi9mVUR6HgvpUPgwV1vo6g4uO5S/daRfryFj2eW3w==
X-Received: by 2002:a05:6512:3d29:b0:53e:136b:991d with SMTP id 2adb3069b0e04-53e2c2aae84mr10863e87.12.1733424432646;
        Thu, 05 Dec 2024 10:47:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229c95dasm306005e87.227.2024.12.05.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:47:11 -0800 (PST)
Date: Thu, 5 Dec 2024 20:47:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, devicetree@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Benson Leung <bleung@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	Guenter Roeck <groeck@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 15/18] dt-bindings: usb: Add ports to
 google,cros-ec-typec for DP altmode
Message-ID: <kidsjzklpxvvamct3glvoawavoi5mjuyh3on5kbtfp6gavwxxn@eack224zuqa3>
References: <yk3xidaisbd56yndaucax7otijjauqmm7lqm6q4q633kdawlqo@qaq27lwxmvwd>
 <CAE-0n501j+8bMnMKabFyZjn+MLUy3Z68Hiv1PsfW0APy5ggN8g@mail.gmail.com>
 <gstohhcdnmnkszk4l2ikd5xiewtotgo5okia62paauj6zpaw7y@4wchyvoynm2p>
 <CAE-0n50z6MNa7WOsg-NU7k8BpFeJJyYfHX3ov6DsthLWauSNpA@mail.gmail.com>
 <hqmx7jtkvrwvb27n56hw7rpefhp37lhr3a5fawz7gsl76uuj5s@h7m6wpdhibkk>
 <CAE-0n50y1O2C47zOGJPmMjKXK_m6a=jhpEAP4nW+RymZbo2xyg@mail.gmail.com>
 <5kisfv22tgqwzjpxqrbx56ywr7l4r7pny3pl2r7crv4rijqbwk@azricdasttg7>
 <CAE-0n50Bxi2GfnxOmMwe-F+k5jMSiyAVPDb6K8pYm-i6hpJTOA@mail.gmail.com>
 <cartdeijkv6z23dgm7uif4lti3lahfqmuyxcmruzqbefhsp6yk@m6ocjhncs2ko>
 <CAE-0n51-QLLje0f7T4p3xK6Q-FRk4K0NUrVVm4cxkKoevuzktw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51-QLLje0f7T4p3xK6Q-FRk4K0NUrVVm4cxkKoevuzktw@mail.gmail.com>

On Tue, Dec 03, 2024 at 03:50:58PM -0800, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2024-11-21 14:59:42)
> > On Tue, Nov 19, 2024 at 08:09:31PM -0500, Stephen Boyd wrote:
> > >
> > > It sounds like we're debating how to handle lane assignment in the
> > > kernel. Either way, the code is going to be implemented in the bridge
> > > driver because it's the one that has to change what physical lane a
> > > logical lane is assigned to. The question is if it should be some sort
> > > of bridge_funcs callback, or should bridge drivers hook into the typec
> > > framework to expose an orientation switch, or something else?
> >
> > I was assuming that orientation switch is such kind of a hook.
> >
> > >
> > > I'm thinking we should introduce some sort of bridge_funcs callback that
> > > can be called from the DP altmode driver, either parallel to the
> > > drm_connector_oob_hotplug_event() function or from it directly. If we
> > > can pass the fwnode for the usb-c-connector to the oob_hotplug_event
> > > callback, maybe that's all we need to figure out which lanes go where.
> > > And then in the 2 DP connector muxing world we can call
> > > drm_connector_oob_hotplug_event() with one or the other DP connector
> > > node, which will likely be children nodes of the "HPD redriver" device.
> >
> > If you call it from drm_bridge_connector's oob_hotplug_event handler,
> > this should fly. Does it cover your 3-DP or 4-DP usecases?
> >
> 
> I think it will work as long as we're able to add some sort of property
> to the usb-c-connector node to indicate that the DP lanes are flipped.
> It feels like that should be in the displayport altmode node to keep
> things tidy because the SuperSpeed port is overloaded. Maybe the drm
> framework can have some API that can take the fwnode from the
> oob_hotplug_event handler and tell the bridge driver which way the
> orientation is.
> 
>  connector {
>    compatible = "usb-c-connector";
> 
>    altmodes {
>      displayport {
>        orientation-reversed;
>      }
>    };
> 
>    ports {
>      ...
>    };
>  };
> 
> 
>  int drm_dp_typec_orientation_flipped(struct fwnode_handle *fwnode)
>  {
>    struct fwnode_handle *altmodes;
>    struct fwnode_handle *dp;
> 
>    altmodes = fwnode_get_named_child_node(fwnode, "altmodes");
>    if (!altmodes)
>      return -EINVAL;
> 
>    dp = fwnode_get_named_child_node(altmodes, "displayport");
>    if (!dp)
>      return -EINVAL;
> 
>    if (fwnode_property_read_bool(dp, "orientation-reversed"))
>      return 1;

If that passes through DT maintainers, that's fine with me.

> 
>    return 0;
>  }
> 
> There's another wrinkle on some Corsola devices where the EC says
> there's a usb-c-connector on the board, but in reality the DP lanes are
> connected to a DP-to-HDMI bridge that is controlled by the EC which goes
> to an HDMI connector on the side of the laptop. The EC does the
> arbitration as usual because there's only one DP source and one or two
> usb type-c connectors physically on the laptop in addition to the HDMI
> connector.
> 
> The easiest way to imagine this is that we took the usb-c-connector and
> jammed an HDMI dongle in there with some glue so that it can never be
> removed. There isn't any USB going there either because it can't be
> used. I suppose we can continue to describe this with an
> altmodes/displayport node but then add some compatible like
> "usb-c-hdmi-connector" or another property to the altmodes/displayport
> node like "type = hdmi" that signifies this is a connector that only
> outputs HDMI.

Does that DP-to-HDMI bridge talk USB-C or just pure DP? In other words,
will it be properly discovered and handled if we just leave it as a
weird usb-c-connector (maybe with an additional annotation, we have
USB_PORT_CONNECT_TYPE_HARD_WIRED for USB ports, we might have something
similar for Type-C connectors).

-- 
With best wishes
Dmitry

