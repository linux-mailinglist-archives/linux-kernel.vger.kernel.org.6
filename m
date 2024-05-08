Return-Path: <linux-kernel+bounces-172886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5E18BF82A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A421BB25A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF94E1CA;
	Wed,  8 May 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhRf6AyW"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37B4D59F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155751; cv=none; b=c4yBknuWq7eiObrq1rkiw/+jYJgocwIgfFIR58bQonbTl7bYHaTzrDnIZHS7JYCzNOdZYQKAvzGpI+dJ7SlzNAb1OWJcWUfxACTiWMgzpjMeFIQz1X5xyurE6f/GONAv4Z+e/pCpuylRr+a+htvRS4pG2QjEIoJfZhjdoUv4dHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155751; c=relaxed/simple;
	bh=x2v9F1VDhB91ey8gDsIzGFW7qT7YEX73UMWKN8WTf4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhH4RGt1JNAOeMNbEC0tuq/xCPEQULSW48oc/PXF6NpeJ0yaydrwz+hCpduOhwHD0FFx0ZmgW/p+3XNxVX8ZQEHm9A1J3bPe5L8X2Um95g9zt+lYQLz4ZvIJdvOeDsMGIHiuDKuGRZjxuFnFeGwOI5YBEGHYD4lRE+G5eiLWL9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhRf6AyW; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de45dba15feso4285453276.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715155749; x=1715760549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YyPej1pI/oVXVkHLEEGi3mJmmE4iMy2MyP2y6dxfKZ0=;
        b=XhRf6AyWzL/+kQeMN23EWXf/rpMX3gv4W40NJmIHkJ42uMfbsfurV50JiholzzQHix
         tOpU8O6kahS44hL4gq9xM9H7IRLtiVr6doR2+xJTVgyA8BK6zUmRa39zCbwwTEgmpoVy
         JV1VDaQ1gaLB8m6bzy3rEvIgb6BJx5u91xlEAsFQ/U2IfcLqZTnqxMFtmDU0KT9sCCVJ
         xXCuOXVqEIui4R8vbyMPa6p/pS0h8Tx0QYAUcX4NLwAWZhPGx73RGBdjsn9uhcE90urU
         Pzgop5gNKQam0fXhd6ltGLbOfolwdyF3kymyf2hiMcJP5kQD5yfr2YSjxVLLWmUTJru2
         77/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715155749; x=1715760549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyPej1pI/oVXVkHLEEGi3mJmmE4iMy2MyP2y6dxfKZ0=;
        b=qI6+s6/LLayGPWb+5RTt15X6h/OaYfgBwtHU3NT1l0vbuiL2RbUswIMewe/pjC1NRA
         5IVV5rQalYGQrhgSdXgH5IiOnsBwoqxgzrtNJBNC0bojTYtzk5g8HMvgQd2e6u5P9mse
         IQxA3UWaTFOHvZ1vJGM1tI0cN20AhFGTSJ46XAK5OwCNAk+9C6WEFa6GJHH/hdcOWWpp
         MFni1Zd6aAv8//Km0RrIXcz1O106n/kvB0IQ36u0wae5CN0qQGmFH8AD3QpvP7ws15xg
         siAHx6psUhuL74Ddv5DThsXGTfnQbs45B+yDj7GE6vLMXwjtGkg/bbNaNYPnG6NNj3CB
         FViw==
X-Forwarded-Encrypted: i=1; AJvYcCX/5rkKRTIF9AKqqNB6JgJ6ZXMQbTWhYxlF+IbJVhC1zh9zOUuygZFiT11gfBK68AJv3ii3OQycZgRR3vblW9VgZgU8GTgmTCb+zkap
X-Gm-Message-State: AOJu0Yy5In1e6o7E+aDpi1aPNW0YJ2ZjDMgrAKbvI92Xm7aIbngEVsKv
	OIwhXqQpbzGysFBN436a8fx964chGTc1FTBwu0joDxTrd25Qd0UHzQnjhVwuJtG2Mc4KdAHyxwZ
	sItccgzr75YpISZk0UvfTTiCLN2HwkdcQ9AiWjw==
X-Google-Smtp-Source: AGHT+IG+Ka6XHmtx1m9DEXkQI65DTYddxM7NeYZJRMR7V9qR3AtwZaFiJJeSQAcC1WQ+BpJYbi2S6eFyvsVDWAZxTV8=
X-Received: by 2002:a25:dc4c:0:b0:dcb:f7a0:b031 with SMTP id
 3f1490d57ef6-debb9e3d259mr2017607276.50.1715155748788; Wed, 08 May 2024
 01:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502090326.21489-1-quic_kbajaj@quicinc.com>
 <CAA8EJprPLqj7GQM0vmN25U2+3kDow=NH8=-VC2N-0p92Ub3iCA@mail.gmail.com>
 <5134c012-60b1-4c07-9e1f-c48c3d88d404@quicinc.com> <CAA8EJppK7fMmX_cePhaK4Xy-+gfZfYZSWJDbEnVvq_60B32Rig@mail.gmail.com>
 <737b595c-3433-8ad8-ca89-7af77098f589@quicinc.com>
In-Reply-To: <737b595c-3433-8ad8-ca89-7af77098f589@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 8 May 2024 11:08:57 +0300
Message-ID: <CAA8EJppshtYL0O=C5FAGNRfEnxZohWjW69P9YV=gw_ira-AANQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add devicetree support of USB for QDU/QRU1000
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, quic_wcheng@quicinc.com, 
	quic_ppratap@quicinc.com, Jack Pham <quic_jackp@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 09:12, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
>
>
> On 5/2/2024 5:14 PM, Dmitry Baryshkov wrote:
> > On Thu, 2 May 2024 at 12:48, Krishna Kurapati PSSNV
> > <quic_kriskura@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 5/2/2024 2:39 PM, Dmitry Baryshkov wrote:
> >>> On Thu, 2 May 2024 at 12:04, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
> >>>>
> >>>> This series adds devicetree nodes to support interconnects and usb for qdu/qru1000.
> >>>> This is based on previously sent driver series[1].
> >>>>
> >>>> ------
> >>>> Changes in v3:
> >>>> * As per comments on upstream[2], to get role-switch working on QDU/QRU1000, it was recommended to
> >>>>     use the actual TI switch driver. Since driver doesn't have the functionality to provide role-switch
> >>>>     based on gpio, thus reverting back USB dr_mode to peripheral and removed the remote end-point nodes
> >>>>     and usb-conn-gpio based role switch functionality.
> >>>
> >>> This is not correct. The recommendation was to describe hardware properly.
> >>> Which means adding schema description, adding  ti,your-switch
> >>> compatible to the usb-conn-gpio.c driver, etc.
> >>>
> >>
> >> Hi Dmitry,
> >>
> >>    Sorry for the confusion. In the comments [1],
> >>
> >> "So the compatible string should be "ti,hd3ss3220". Which is fine to be
> >> used in the platform driver. Just describe the differences in the
> >> schema."
> >>
> >> The compatible "ti,hd3ss3220" is already associated with a TI switch
> >> driver [2]. But it works based on I2C. So we assumed you wanted us to
> >> make changes to [2] by adding GPIO functionality (which usb-conn-gpio
> >> exactly does), since the compatible you suggested matched with the TI
> >> driver.
> >
> > First of all, please don't make assumptions. It's better to ask rather
> > than making assumptions which turn up to be incorrect.
> >
> > Compatibles describe hardware. DT describes hardware. There are no
> > drivers in question (yet).
> > You have TI switch on your board, so you have to use "ti,hd3ss3220" to
> > describe it.
> >
> > Existing schema describes it as an I2C device. You have to extend the
> > schema to allow non-i2c attachment. Describe GPIOs, make reg optional.
> > Make this description purely from the datasheet and usb-c-connector
> > point of view.
> >
> >> If it was to add compatible in usb-conn-gpio, then we can support OTG
> >> functionality with no schema changes I believe, but the compatible
> >> string might need a different name to avoid clashing with the name in [2].
> >
> > And this is the second, largely independent question. The
> > usb-conn-gpio driver is a platform driver.The existing hd3ss3220.c
> > driver is an I2C one. There is no clash between them.
> >
> > Note, unlike plain gpio-b-connector, the switch supports more pins and
> > actually provides USB-C information to the host even when used in the
> > dumb mode. Thus it might be better to add a separate driver that
> > registers typec port and reports USB-C events.
>
> Hi Dmitry,
>
> Regarding the comment:
> "Note, unlike plain gpio-b-connector, the switch supports more pins and
> actually provides USB-C information to the host even when used in the
> dumb mode. Thus it might be better to add a separate driver that
> registers typec port and reports USB-C events."
>
> We are also aligned with your statement of expressing the hardware
> correctly. Since this needs quite a bit of effort to write a new driver
> for TI switch or modifying existing TI driver to add GPIO support, can't
> we go ahead with peripheral support only since the driver support is
> absent currently.

I think you are again mixing things here. You don't have to use the
existing TI driver. Instead you can start with the
gpio-b-usb-connector driver and later push a new driver for the switch
instead. This has nothing to do with the hardware description of the
device.

>
> We will plan to submit the patches in upcoming days for this. Since we
> usually enable USB in peripheral mode so that USB debug (adb) will work,
> I am thinking we can merge this and take up the OTG/host mode
> separately. Please let me know your feedback on this.

Well, granted that we are now close to the release, you can not merge
anything. So you have about three weeks before the next patches can
hit Bjorn's tree. I think this leaves plenty of time to develop a
proper solution.

>
> Thanks
> Komal
>
> >
> >>
> >> [1]:
> >> https://lore.kernel.org/all/CAA8EJppNZrLzT=vGS0NXnKJT_wL+bMB9jFhJ9K7b7FPgFQbcig@mail.gmail.com/
> >>
> >> [2]:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/typec/hd3ss3220.c?h=v6.9-rc2
> >>
> >> Regards,
> >> Krishna,
> >>
> >>>> * Link to v2: https://lore.kernel.org/linux-arm-msm/20240319091020.15137-1-quic_kbajaj@quicinc.com/
> >>>>
> >>>> Changes in v2:
> >>>> * Changes qmpphy node name
> >>>> * Changes dr_mode to otg and added USB-B port USB role switch
> >>>> * Dropped maximum-speed property from usb dwc3 node
> >>>> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240311120859.18489-1-quic_kbajaj@quicinc.com/
> >>>>
> >>>> [1] https://lore.kernel.org/linux-arm-msm/20240502082017.13777-1-quic_kbajaj@quicinc.com/
> >>>> [2] https://lore.kernel.org/all/CAA8EJppNZrLzT=vGS0NXnKJT_wL+bMB9jFhJ9K7b7FPgFQbcig@mail.gmail.com/
> >>>> ------
> >>>>
> >>>> Komal Bajaj (3):
> >>>>     arm64: dts: qcom: qdu1000: Add USB3 and PHY support
> >>>>     arm64: dts: qcom: qdu1000-idp: enable USB nodes
> >>>>     arm64: dts: qcom: qru1000-idp: enable USB nodes
> >>>>
> >>>>    arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  23 +++++
> >>>>    arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 120 +++++++++++++++++++++++
> >>>>    arch/arm64/boot/dts/qcom/qru1000-idp.dts |  23 +++++
> >>>>    3 files changed, 166 insertions(+)
> >>>>
> >>>> --
> >>>> 2.42.0
> >>>>
> >>>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry

