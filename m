Return-Path: <linux-kernel+bounces-442119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A259ED835
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F392828D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79AF2288D2;
	Wed, 11 Dec 2024 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UG0Nrv9R"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423C820B20A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951478; cv=none; b=rh/Zd6cvuIo/8+Z7VdfqaO+GghpfUr2USn0TM/WOPO3KTY+GuhMINEXb0aDmzdpq7QuTo6GwTWAofzzRaDjI6iZ4c7rVpVCrRdInFuqDe0/ZX7yaLBvowWF4MX4oYHF7ncZ7vv8pkGBEJRYNe0fCFXNWJXM96fVwR1G0Syvb4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951478; c=relaxed/simple;
	bh=fL4AZO7DuUqncD1hviX7Ju8fEoY0KFiDTXpqXPG3i0I=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDLQZduO9ipn+S695oKRfoXkgofI5k6gNfZnIoPXxJ7rD4QJqKTj8gA9l5o3Sy56NdR3xUC+cgUP2Jm05/daCHJjcLvM0JRL2j6+lZHLta/XWO/FIfX9JfnXIA6tYaXfRRwy9WKhvrr/MfIreFR/EjflT6WiIq/z3cF9esR/xLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UG0Nrv9R; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so5527311276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733951475; x=1734556275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fL4AZO7DuUqncD1hviX7Ju8fEoY0KFiDTXpqXPG3i0I=;
        b=UG0Nrv9ROYrAh4RJlrrpGCknqqheVtFgQIF0xNEOcCam9+JC8M0XeVs/iLWkgKbOxv
         cU57kRf90yJ1qpxYrLK8bFk2TEFNTjOt7dkKoHkb+Ku6gIAdPxXfF/e8tPZOWyWduie3
         b5PENYqPFGSy6nARcOTLv9Gtxa9Tf13qTIZ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951475; x=1734556275;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL4AZO7DuUqncD1hviX7Ju8fEoY0KFiDTXpqXPG3i0I=;
        b=bTHPUgx+5zhpJZIXtc8AbBHRXBLATi+hDTnqEEeHVz+lACYFHGNFdCa/rp2WRKaDBU
         dyIw5cN1AyWIMkvXjnCakvts0xrYtFF5YHo6dPHPXy79GoV9ocHDtCXywNK0CfOq9SBA
         PJdaEURNiI86KUhloDqkAbUXkJpVQLzWi9yR0JuTIJ0TTqZ+6phtngGis2iaxfKA/Gnx
         Sy75qCHFX5K8k+8jCd+wrB6stZJLPdJ4kQC9Qt9Cxw+i1Dacc3JXqvfIXEgPdSwnSEcY
         PFcSpy+uCtcxgTgYXzzwYHmWKYQzZcr2o+A/5GiDSRFgc2ab33rzUDcLp50MFucKcc5I
         dMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlsxpakqUmZ7kyM0p151wc44lnWNbAVqA0lQV8deU6ZmjxAEkudcBnIBFo9O3L6K1s7opkd2W/FTVYz0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuDUkzlTR/Nmif9POZ9awMYNyrqoEDPtLa04g3u9JzOooFeji
	6Hh2PHpNRgjDBQeqDVNyguyHgcZlqIYgOX4SdvR2lcLFeclzLfPbjVFOPlRnpaE3NLwhFos1cNc
	rGWiFHJNAtC9Aa4the4f73ERRCUS0sm2VKT43
X-Gm-Gg: ASbGnctiW0zMe9+SOlGKGhDa0gtuXRVovCq1iK2Rvvp9tqZJivyPdS+EvlCMEHn8Rt+
	rFRE9DD10EDgCXn8kHXE6OQ0wKi5Xmc7kFUuSJqpOMwfyR6uY0ve9hYRzAoPiysk=
X-Google-Smtp-Source: AGHT+IGR6ED4gGgHGmi77s2dwB+gnLghGdTv2zo6xXg1u+pxnZVS/4VVQlWKhmq+504JY9ZZ4GSEuX2qWpyqxoxUo7A=
X-Received: by 2002:a05:6902:1b87:b0:e39:7a24:a5c3 with SMTP id
 3f1490d57ef6-e3da1eed190mr753786276.32.1733951475289; Wed, 11 Dec 2024
 13:11:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 13:11:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <kidsjzklpxvvamct3glvoawavoi5mjuyh3on5kbtfp6gavwxxn@eack224zuqa3>
References: <yk3xidaisbd56yndaucax7otijjauqmm7lqm6q4q633kdawlqo@qaq27lwxmvwd>
 <gstohhcdnmnkszk4l2ikd5xiewtotgo5okia62paauj6zpaw7y@4wchyvoynm2p>
 <CAE-0n50z6MNa7WOsg-NU7k8BpFeJJyYfHX3ov6DsthLWauSNpA@mail.gmail.com>
 <hqmx7jtkvrwvb27n56hw7rpefhp37lhr3a5fawz7gsl76uuj5s@h7m6wpdhibkk>
 <CAE-0n50y1O2C47zOGJPmMjKXK_m6a=jhpEAP4nW+RymZbo2xyg@mail.gmail.com>
 <5kisfv22tgqwzjpxqrbx56ywr7l4r7pny3pl2r7crv4rijqbwk@azricdasttg7>
 <CAE-0n50Bxi2GfnxOmMwe-F+k5jMSiyAVPDb6K8pYm-i6hpJTOA@mail.gmail.com>
 <cartdeijkv6z23dgm7uif4lti3lahfqmuyxcmruzqbefhsp6yk@m6ocjhncs2ko>
 <CAE-0n51-QLLje0f7T4p3xK6Q-FRk4K0NUrVVm4cxkKoevuzktw@mail.gmail.com> <kidsjzklpxvvamct3glvoawavoi5mjuyh3on5kbtfp6gavwxxn@eack224zuqa3>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 13:11:14 -0800
Message-ID: <CAE-0n52F+cvVyXm8g8idN2eMfx4bpaEpWQRchr8=AO87N7E3fg@mail.gmail.com>
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

Quoting Dmitry Baryshkov (2024-12-05 10:47:08)
> On Tue, Dec 03, 2024 at 03:50:58PM -0800, Stephen Boyd wrote:
> >
> > The easiest way to imagine this is that we took the usb-c-connector and
> > jammed an HDMI dongle in there with some glue so that it can never be
> > removed. There isn't any USB going there either because it can't be
> > used. I suppose we can continue to describe this with an
> > altmodes/displayport node but then add some compatible like
> > "usb-c-hdmi-connector" or another property to the altmodes/displayport
> > node like "type = hdmi" that signifies this is a connector that only
> > outputs HDMI.
>
> Does that DP-to-HDMI bridge talk USB-C or just pure DP? In other words,
> will it be properly discovered and handled if we just leave it as a
> weird usb-c-connector (maybe with an additional annotation, we have
> USB_PORT_CONNECT_TYPE_HARD_WIRED for USB ports, we might have something
> similar for Type-C connectors).

It is pure DP. Maybe we can have a google,cros-ec-usbc-hdmi compatible
string here because this is a weird design.

