Return-Path: <linux-kernel+bounces-566861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC3A67D98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12F03BDAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00A6216E24;
	Tue, 18 Mar 2025 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L7uWkj4L"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B59214A6C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327813; cv=none; b=gdjxkptO4wt0v6ruHBC8Z87+/cL1mQAfKB6WOHK2Y7SB8eRGHverfL+uW7q3Yulvpx8QRLjpH+nTWA+A77yJB4ivTDXoCiSzclLHVU5DGFK+newr2KnGy4kXzcNsjPkHWOmpsbdrJIgzjyklFXH9jztCRLbIUUBVn++krIxbN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327813; c=relaxed/simple;
	bh=d8cSUoD3Gewlqbb7cpYsy12TfPHuVdAaOoyBCXacZT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bysFbe2oJyXlWL7bQQT+nPtuKCy3wz+gg29yLQdTXUDVvbhs2GbCVQKdV08T69bjJmDuHJJKr1EfwyuzKVP8thd355nR1XL3Iou0K0YmvC5Jb8n66KERcVbIafDnJie2riHGcXHpoCMu/vcYgNPPOxVZ8dNEnqoPY2NlVG2SeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L7uWkj4L; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab78e6edb99so932147566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742327808; x=1742932608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8cSUoD3Gewlqbb7cpYsy12TfPHuVdAaOoyBCXacZT8=;
        b=L7uWkj4Ln4sQvS1xcR3eQmd2pvi5M8faoevezpiKhBKEL5WTjdLCc2AAAtNpYIX/M3
         YadM08HFL9/h7o2vGMCAAnyMySoKFIqoJ27/w/xth2okT/UAihXl0tFqSz9HgGiPIl4G
         6VP15z7rb927QYv3FdraPfdySc0NUGdTZirZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742327808; x=1742932608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8cSUoD3Gewlqbb7cpYsy12TfPHuVdAaOoyBCXacZT8=;
        b=azyhd5QUs4vJLfZBXhtNeucRtWSkdT8FqoqRXySEJT89kyNtzO4rCMewsEXdIqKb2/
         KUAKD47XTAEJeuVItDD98AtZGqrNx8C22SE5hzNBnnrTumSN+anFV9RwONoWuoMZT5Xk
         xKQQ4VkEQX5FK81g3j9EHsU6QvRQooS3InwTKrErbtZJGHQXzcVhRtLXb0bg7+E7/AQw
         OtBMF+EVcVusxcN11+dzaETaWU2mjEW5p4m0eAZsq+oF2fs7e6dW/kS76UPshztOrSTz
         XWfnKioAJqzU9GANoaegK8QWjIu/hGQfce8Bgnn+0Unz5ySYvH+tWwb1er0rKrMslYqV
         yprw==
X-Forwarded-Encrypted: i=1; AJvYcCW6IEFuYFcwlwbumUNPOtTD7I7V1A270k7aogchhswOqn2tw3oWux1/sQWYt3daWjK8hgNwWJIdg2MfXkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4ly0m+b9AgYM6T59ctDfdbpd6MQEq29ympimDe71Kgbciu33
	XbbKnxO6dehfOoNummlsk8wNNrk9lifAuOrPizJhDU7/m1jXLahjaOikNDrgYS7uUKTaZne2621
	JzPwR
X-Gm-Gg: ASbGnculImTq0v9RY4ukUs+/7TMMdi8tTuZ0cwXmpfw+EfrCsu/YKtV492VyXVcTRiD
	DVRa2BKHmXwSfkqhS6FwwTvqRAgb9+DKyPdJr+A07N7FOsaSUOzWjWXtCliE2oRhvnL1yEEXMDm
	/VgqmgKmOfAqSMdBm4Ohs0NXHZOwVigfilpKtdaZyzTGRcHHVQTfGiNEKXtJg904wLlXxQHa7kc
	WzBsS6WebVMx+aIbIFFzwh+WVpjbhqPnR/t0ARXp6MVA9g56I2wvRCA+2HTphyRDJOyzD4sOIzA
	7w7b7W9MdGumVKOYrUlBaYiThJUvqYp7FlF0rHhTmBNQI1wqb7XNmKmC4rpgLGk7xHRok5bh2h4
	ny5dZqej9VKWrQLClsYo=
X-Google-Smtp-Source: AGHT+IE2hD50judyn41kVoGJjdCgv2CQvLEdi+68+KJpzJ/SZFyD1zJOIh+UPmo63nJP8AnJdWzy0g==
X-Received: by 2002:a17:907:7d93:b0:ac2:84db:5916 with SMTP id a640c23a62f3a-ac3303013demr2028371166b.31.1742327808249;
        Tue, 18 Mar 2025 12:56:48 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146ae9c1sm909008566b.13.2025.03.18.12.56.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 12:56:47 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39130ee05b0so5933042f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:56:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUViFLhrz567iXwn96eAOAfuUJwhXWh8cF7OJdG4OqeMfw1q8iz7odAvSt0KcKH3wpeQkBV/8Ps8TbGrjg=@vger.kernel.org
X-Received: by 2002:a05:6512:3984:b0:548:526c:fb99 with SMTP id
 2adb3069b0e04-549c3907de0mr10794093e87.18.1742327491228; Tue, 18 Mar 2025
 12:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205115025.3133487-1-h-shenoy@ti.com> <20250205115025.3133487-2-h-shenoy@ti.com>
 <efd89cf8-2f83-44fd-8bdf-aa348d4d9659@kernel.org> <h24gpx6cxm4s6gzcunjnswubtvqask5dewi3udulmntsuieklm@w3pw4ig3t7gm>
 <de0cb22d-d251-4b0b-8fc7-e8b5a891a527@ti.com> <vfg6hlkzmqahbswgyctzuuzcdm2aend6wmo3uci4qs74jasjtc@3hlox276hazj>
 <673e79bc-53c9-4772-ad18-8c00e4036905@ideasonboard.com>
In-Reply-To: <673e79bc-53c9-4772-ad18-8c00e4036905@ideasonboard.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Mar 2025 12:51:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W45V-AZdbo4MBfZ-A9M4vf42Lda82s8iUoW5azVwM0hA@mail.gmail.com>
X-Gm-Features: AQ5f1Jq1cec3Ts5E7j-BdKWVeJ6ZvaCtuP5LX8avGE-kg45frRP0s6LVh188_2E
Message-ID: <CAD=FV=W45V-AZdbo4MBfZ-A9M4vf42Lda82s8iUoW5azVwM0hA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: drm/bridge: Add no-hpd property
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>, Harikrishna Shenoy <a0512644@ti.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Harikrishna Shenoy <h-shenoy@ti.com>, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jani.nikula@intel.com, j-choudhary@ti.com, 
	sui.jingfeng@linux.dev, viro@zeniv.linux.org.uk, r-ravikumar@ti.com, 
	sjakhade@cadence.com, yamonkar@cadence.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 18, 2025 at 8:50=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 12/03/2025 14:52, Dmitry Baryshkov wrote:
> > On Wed, Mar 12, 2025 at 11:56:41AM +0530, Harikrishna Shenoy wrote:
> >>
> >>
> >> On 05/02/25 19:03, Dmitry Baryshkov wrote:
> >>> On Wed, Feb 05, 2025 at 12:52:52PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 05/02/2025 12:50, Harikrishna Shenoy wrote:
> >>>>> From: Rahul T R <r-ravikumar@ti.com>
> >>>>>
> >>>>> The mhdp bridge can work without its HPD pin hooked up to the conne=
ctor,
> >>>>> but the current bridge driver throws an error when hpd line is not
> >>>>> connected to the connector. For such cases, we need an indication f=
or
> >>>>> no-hpd, using which we can bypass the hpd detection and instead use=
 the
> >>>>> auxiliary channels connected to the DP connector to confirm the
> >>>>> connection.
> >>>>> So add no-hpd property to the bindings, to disable hpd when not
> >>>>> connected or unusable due to DP0-HPD not connected to correct HPD
> >>>>> pin on SOC like in case of J721S2.
> >>>>>
> >>>>> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> >>>>
> >>>> Why are you sending over and over the same? You already got feedback=
.
> >>>> Then you send v2. You got the same feedback.
> >>>>
> >>>> Now you send v3?
> >>>>
> >>>> So the same feedback, but this time: NAK

I only spent a few minutes on it, but I couldn't find a v2. If there's
a link I'm happy to read it, but otherwise all my comments below are
without any context from prior verisons...


> >>> Krzysztof's email forced me to take a look at the actual boards that =
you
> >>> are trying to enable. I couldn't stop by notice that the HPD signal
> >>> _is_ connected to a GPIO pin. Please stop hacking the bridge driver a=
nd
> >>> use the tools that are already provided to you: add the HPD pin to th=
e
> >>> dp-controller device node. And then fix any possible issues coming fr=
om
> >>> the bridge driver not being able to handle HPD signals being delivere=
d
> >>> by the DRM framework via the .hpd_notify() callback.
> >>>
> >>> TL;DR: also a NAK from my side, add HPD gpio to dp-controller.
> >>>
> >> We tried implementing a interrupt based HPD functionality as HPD signa=
l is
> >> connected to GPIO0_18 pin, we were able to get interrupt based HPD wor=
king
> >> however to route this signal to SoC we are loosing audio capability du=
e to
> >> MUX conflict. Due to board level limitations to
> >> route the signal to SoC, we will not be able to support interrupt
> >> based HPD and polling seems a possible way without loosing on audio
> >> capability.
> >
> > Still NAK for the no-hpd property. HPD pin is a requirement for
> > DisplayPort to work, as it is used e.g. for the 'attention' IRQs being
> > sent by the DP sink. I'm not sure what kind of idea you HW engineers ha=
d
> > in mind.
>
> It's true that for normal DP functionality the HPD is required, but
> afaik DP works "fine" without HPD too. This is not the first board that
> has DP connector, but doesn't have HPD, that I have seen or worked on.
> Polling can be used for the IRQs too.

I have less familiarity with DP than with eDP, but from what I know
I'd agree with Tomi here that it would probably work "fine" by some
definition of "fine". As Dmitry says, the "attention" IRQ wouldn't
work, but as I understand it that's not really part of the normal flow
of using DP. As evidence, some people have made "ti-sn65dsi86" (which
is supposed to be for eDP only) work with DP. While the ti-sn65dsi86
hardware _does_ support HPD, because of the forced (slow) debouncing
it turned out not to be terribly useful for eDP and we designed our
boards to route HPD to a GPIO. ...and because of that nobody ever
wrote the code to handle the "attention" IRQ. Apparently people are
still using this bridge w/ some success on DP monitors.


> For eDP HPD is optional, and some of the cases I've worked with involved
> a chip intended for eDP, but used with a full DP connector, and no HPD.

I definitely agree. The eDP spec explicitly states that HPD is
optional even though it's also documented to be an "attention" IRQ
there. We've hooked up large numbers of eDP panels and the lack of the
attention IRQ wasn't a problem.


> However, in this particular case the DP chip supports full DP, so it's
> just a board design error.
>
> My question is, is J721s2 EVM something that's used widely? Or is it a
> rare board? If it's a rare one, maybe there's no point in solving this
> in upstream? But if it's widely used, I don't see why we wouldn't
> support it in upstream. The HW is broken, but we need to live with it.
>
> Another question is, if eDP support is added to the cdns-mhdp driver,
> and used with a panel that doesn't have an HPD, how would that code look
> like? If that would be solved with a "no-hpd" property, identical to the
> one proposed in this series, then... There's even less reason to not
> support this.
>
> Disclaimer: I didn't study the schematics, and I haven't thought or
> looked at how eDP is implemented in other drm drivers.

I spent lots of time working through this on ti-sn65dsi86. How it
works today (and how it's documented in the bindings) is that it's
possible to specify "no-hpd" on both the eDP panel node and on the
bridge chip. They mean different things.

The HPD-related properties that can be specified on the panel are
a) <nothing> - HPD hooked up to the bridge
b) no-hpd - HPD isn't hooked up at all
c) hpd-gpios - HPD is hooked up to a GPIO

The HPD-related properties that can be specified on ti-sn65dsi86 are:
a) <nothing> - HPD is hooked up to the bridge
b) no-hpd - HPD is not hooked up to the bridge

NOTE: The "ti-sn65dsi86" controller needs to be programmed to ignore
its HPD line if HPD isn't hooked up. IIRC the hardware itself will not
transfer things over the AUX bus unless you either tell the controller
to ignore HPD or HPD is asserted.


Here are the combinations:

1. Panel has no HPD-related properties, ti-sn65dsi86 has no
HPD-related properties

HPD is assumed to be hooked up to the dedicated HPD pin on the bridge.
Panel driver queries the bridge driver to know the status of HPD. In
Linux today ti-sn65dsi86 doesn't really implement this and the bridge
chip just has a big, fixed, non-optimized delay that tries to account
for the max delay any panel could need.

2. Panel has "hpd-gpios", ti-sn65dsi86 has no HPD-related properties

In theory, I guess this would say that HPD goes _both_ to a GPIO and
to the HPD of the bridge. Maybe handy if the bridge doesn't provide a
"debounced" signal but still wants HPD hooked up to get the
"attention" IRQ?

3. Panel has "no-hpd", ti-sn65dsi86 has no HPD-related properties

Doesn't really make sense. Says that panel should delay the max amount
but there's no good reason to do this if HPD is hooked up on
ti-sn65dsi86.

4. Panel has no HPD-related properties, ti-sn65dsi86 has "no-hpd"

Doesn't really make sense. Says that the panel should assume the
bridge has HPD hooked up but then the bridge doesn't.

5. Panel has "hpd-gpios", ti-sn65dsi86 has "no-hpd"

This is the sc7180-trogdor config. Says the panel should use the GPIO
to read HPD for power sequencing purposes. Tells us that HPD is not
hooked up to the bridge chip so we should program the bridge chip to
ignore HPD.

6. Panel has "no-hpd", ti-sn65dsi86 has "no-hpd"

Says HPD is just not hooked up at all. panel-edp will delay for
"hpd-absent-delay-ms". Bridge chip should be programmed to tell the
hardware to ignore the HPD signal.


How we got there was fairly organic and quite a long time ago, but it
all sorta makes sense even if it is a bit convoluted.

-Doug

