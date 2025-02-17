Return-Path: <linux-kernel+bounces-517382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA4A38014
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB57163527
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BE9213224;
	Mon, 17 Feb 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZZd+oiON"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE92918DB1C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787874; cv=none; b=CRgZxlgdBoBfdrKRIcQfqssir4qP+YYSXuKOoXTlzAf8s4LXA9MAZHklq16/5GGYjfbji7V7UcoFNgnDGPrJjCKpl4ozAAuxxg4VLyu4G4TsD6xejBhuq+bNkLCLs/YgDV22A8KI42RX9Iqb7UxOBvAGT/l7dnDYwoaHyb8Pvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787874; c=relaxed/simple;
	bh=Oa/be5s3xggDuaX9fvCMIZruPgSM0aIozNLh1Fs2UjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VT99Z795tvBbuf2y6JIO9JW1fQWQ+GJh+QhsD8O5e/bSdgEMNCKQDzogahRwz5Qy/Avhm/yGgUdmQkMJU2b1TZKeX4LuwImLxhy0FpkbonYz6sCnloG1QaYr7F74iL0iIGToN5qHs6gjgRUN2QHSYDFyjkC8S9pxbuCXnhlMysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZZd+oiON; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5452c1daabeso2263650e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739787869; x=1740392669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1DlyzfZPCWK55pzxX6TJoiWYHgMaXFWIiyI9xAGPgI=;
        b=ZZd+oiONYVTKkKFeRljDGZh2LIbzVuhJ6z7UwMT0BfmorYqwNRcqRlfX7FRJQzF8PN
         t4ljcwuyWjqzp6ffPd477pmDdhgmungnKHca7WKxDP0ltz2Xrae3t/q3YLXs6dLsxrsu
         5AExsZ7yqeQ9MI1YjaGtM9owl+eIjDI0tTZx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787869; x=1740392669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1DlyzfZPCWK55pzxX6TJoiWYHgMaXFWIiyI9xAGPgI=;
        b=w9b8I/mpPzIs3XDaBHxfdn78k3QMB/Kh4C4apGQsjCJ+87tOk3K52fYdNDeptNPijy
         jNmIs68X1NMUITPdIOHlAUnDdc3bYy3/K9zKSiBwdcZ9b7SgcQo7Wc3l5nvAbjcwkhlG
         HhgqWnZlShDxV6xkRqJWxUTJt2wxNnE1LPvif/jxl+CHRWMyErJ0r5d8hShVzUn3GCdd
         anv0W66jxLGdevJcUng46CIRYBkRjN1lyDjEwcVLjcbFLySSzeOaVG2Y5T4e3Ov9GYi6
         fxhFtBBeNQJGBeScIFYZlw9K4DZUnDIU19ZKhFqlsuT9HLk0XMeygbpdWB409LhRKIi5
         nsHQ==
X-Gm-Message-State: AOJu0YxqydPnr30tIsS7DB0Ti5Nt8w0V23OrZTq7uCzkTmvPJ2yva7DT
	BSf4eNfrRajyKZCy6t4nIYZe+tSfmAgQoAP2878M5kU+oiGN5Q3nIa5XuuZolGhg9H8Vnzdguci
	dXHN4Oq+ZExzIOy933vRN0xLLDcF/NJemKKn4
X-Gm-Gg: ASbGncuyKVK5cimsZr8+AbVjUc5qvEXke5G5QGYKakuRp6hmcjTEH43D60CDT8LXql7
	XDASO+w9keOc18L+FXwT/Ra8RRvvs4PTntz4M0Nvml8YCSqk3s1uRDMSRPkNmWpV4BaLWbO440V
	oHMX4js4zJ53vln06eLJAGYfjK
X-Google-Smtp-Source: AGHT+IE3i0Mznvv4AsHVZT8Dj/f1n9k/WLI0IP0WQ84pkRHFqFusZH4zNFJ+0GmwxW5RsHUWiqkpQfCi3IN0/dhZ7xI=
X-Received: by 2002:a05:6512:1155:b0:545:296e:ac1d with SMTP id
 2adb3069b0e04-5452fe95f54mr2682853e87.51.1739787868862; Mon, 17 Feb 2025
 02:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115063555.32492-1-ot_cathy.xu@mediatek.com>
 <20250115063555.32492-2-ot_cathy.xu@mediatek.com> <nmyxygrya6cpalmirsunvkx32uox3kjxd4l5ggdhjtj7edyizz@yodolm5ktboo>
 <f7ba63c8afcef1d1925d51e35e4b81f0d0e773ff.camel@mediatek.com>
 <d04bc250-2104-4e02-9bf8-5785f4444c8d@kernel.org> <d11076d3eb2f92018fd3e26cae665a47f71ca838.camel@mediatek.com>
 <b212d05d-de3b-41b2-bc48-c6b79ae54a8b@kernel.org> <bec17d1e215a11daa1fdede78c8070c8e1763c72.camel@mediatek.com>
 <e7d49bda-8aaa-4897-8117-ab889fb27be0@collabora.com> <8ca2e369be804697ef71491dfd366cf6afcca9bd.camel@mediatek.com>
 <CAGXv+5EYMM=hn8nKig3iHqD3KhxHVQyteweL-OiSoCV8mD2iew@mail.gmail.com> <81368f21fabb9d6a6ee29bba0542e921b3636016.camel@mediatek.com>
In-Reply-To: <81368f21fabb9d6a6ee29bba0542e921b3636016.camel@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 17 Feb 2025 18:24:17 +0800
X-Gm-Features: AWEUYZm4KUwGawqhHvCsHclABlWLLfJKFpFZMVEY_E4rBjH-DyVCVrr2frjLpEs
Message-ID: <CAGXv+5FSj-FY87Zo7EFec87fLHszO7776dZiinYP-iZm+Hry9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: mediatek: add support for mt8196
To: =?UTF-8?B?Q2F0aHkgWHUgKOiuuOWNjuWptyk=?= <ot_cathy.xu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	=?UTF-8?B?TGVpIFh1ZSAo6Jab56OKKQ==?= <Lei.Xue@mediatek.com>, 
	"krzk@kernel.org" <krzk@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	=?UTF-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, 
	=?UTF-8?B?R3VvZG9uZyBMaXUgKOWImOWbveagiyk=?= <Guodong.Liu@mediatek.com>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "sean.wang@kernel.org" <sean.wang@kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 5:45=E2=80=AFPM Cathy Xu (=E8=AE=B8=E5=8D=8E=E5=A9=
=B7) <ot_cathy.xu@mediatek.com> wrote:
>
> On Tue, 2025-01-21 at 18:03 +0800, Chen-Yu Tsai wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > On Tue, Jan 21, 2025 at 5:58=E2=80=AFPM Cathy Xu (=E8=AE=B8=E5=8D=8E=E5=
=A9=B7) <
> > ot_cathy.xu@mediatek.com> wrote:
> > >
> > > On Mon, 2025-01-20 at 13:42 +0100, AngeloGioacchino Del Regno
> > > wrote:
> > > > External email : Please do not click links or open attachments
> > > > until
> > > > you have verified the sender or the content.
> > > >
> > > >
> > > > Il 20/01/25 10:17, Cathy Xu (=E8=AE=B8=E5=8D=8E=E5=A9=B7) ha scritt=
o:
> > > > > On Thu, 2025-01-16 at 11:20 +0100, Krzysztof Kozlowski wrote:
> > > > > > External email : Please do not click links or open
> > > > > > attachments
> > > > > > until
> > > > > > you have verified the sender or the content.
> > > > > >
> > > > > >
> > > > > > On 16/01/2025 09:18, Cathy Xu (=E8=AE=B8=E5=8D=8E=E5=A9=B7) wro=
te:
> > > > > > > On Thu, 2025-01-16 at 08:28 +0100, Krzysztof Kozlowski
> > > > > > > wrote:
> > > > > > > > External email : Please do not click links or open
> > > > > > > > attachments
> > > > > > > > until
> > > > > > > > you have verified the sender or the content.
> > > > > > > >
> > > > > > > >
> > > > > > > > On 16/01/2025 03:20, Cathy Xu (=E8=AE=B8=E5=8D=8E=E5=A9=B7)=
 wrote:
> > > > > > > > > > > +          bias-pull-down:
> > > > > > > > > > > +            oneOf:
> > > > > > > > > > > +              - type: boolean
> > > > > > > > > > > +              - enum: [100, 101, 102, 103]
> > > > > > > > > > > +                description: mt8196 pull down
> > > > > > > > > > > PUPD/R0/R1
> > > > > > > > > > > type
> > > > > > > > > > > define value.
> > > > > > > > > > > +              - enum: [200, 201, 202, 203, 204,
> > > > > > > > > > > 205,
> > > > > > > > > > > 206,
> > > > > > > > > > > 207]
> > > > > > > > > > > +                description: mt8196 pull down RSEL
> > > > > > > > > > > type
> > > > > > > > > > > define
> > > > > > > > > > > value.
> > > > > > > > > >
> > > > > > > > > > Not much improved.
> > > > > > > > >
> > > > > > > > >    I have removed the content related to 'resistance
> > > > > > > > > value', we
> > > > > > > > > use
> > > > > > > > > 'RSEL' instead of 'resistance value'.
> > > >
> > > > This is wrong.
> > >
> > >   Sorry, I think I may not have expressed myself clearly. What I
> > > meant
> > > is that the attribute 'mediatek,rsel-resistance-in-si-unit' is not
> > > supported. In the dts, can write the resistance value, for example:
> > > bias-pull-up=3D<1000>, but can't use 'mediatek,rsel-resistance-in-si-
> > > unit
> > > =3D <xxx>'.
> >
> > `mediatek,rsel-resistance-in-si-unit` is supported in
> > drivers/pinctrl/mediatek/pinctrl-paris.c
> >
> > Angelo is requesting that you continue that support and make it
> > exclusive, i.e. not support the RSEL macro magic numbers, and
> > _only_ support ohm values, in the device tree.
> >
> > ChenYu
>
>   Thank you for your response. Can I understand that in next version, I
> should remove the RSEL macro magic numbers and add `mediatek,rsel-
> resistance-in-si-unit`?

You should remove the RSEL macro magic numbers, and add an option to
|struct mtk_pin_soc| so that the argument to "bias-pull-up" are always
treated as values in SI units as if "mediatek,rsel-resistance-in-si-unit"
was set in the DT.

ChenYu

> >
> > > > > > > >
> > > > > > > > So the value in Ohms was removed? I assume above do not
> > > > > > > > have
> > > > > > > > known
> > > > > > > > value
> > > > > > > > in Ohms?
> > > > > > >
> > > > > > >    Yes, value in Ohns was removed, no code have knowm
> > > > > > > value.
> > > > > >
> > > > > > Does the hardware have known value in Ohms?
> > > >
> > > > It does.
> > > >
> > > > >
> > > > >    What do you mean by 'hardware'? When writing to the rsel
> > > > > register,
> > > > > the value written is 0-7.
> > > > >
> > > >
> > > > Hardware means "the pin controller of the mt8196 SoC" :-)
> > > >
> > > > Anyway.
> > > >
> > > > The RSEL registers' function is to select a specific resistance
> > > > value
> > > > to
> > > > pullup/down a pin, or a group of pins.
> > > >
> > > > Devicetree bindings require to specify values in known units, so
> > > > in
> > > > device tree
> > > > you *need* to specify the RSEL resistance in Ohms.
> > > >
> > > > You cannot specify RSEL register value in device-tree. That's
> > > > unacceptable.
> > > >
> > > > Regards,
> > > > Angelo
> > >
> > >  Yes, I understand what you mean. However, I was referring to
> > > writing
> > > the rsel register in the driver, not in dts.
> > >
> > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > +            description: |
> > > > > > > > > > > +              For pull down type is normal, it
> > > > > > > > > > > doesn't
> > > > > > > > > > > need
> > > > > > > > > > > add
> > > > > > > > > > > RSEL & R1R0.
> > > > > > > > > > > +              For pull down type is PUPD/R0/R1
> > > > > > > > > > > type,
> > > > > > > > > > > it
> > > > > > > > > > > can
> > > > > > > > > > > add
> > > > > > > > > > > R1R0 define to
> > > > > > > > > > > +              set different resistance. It can
> > > > > > > > > > > support
> > > > > > > > > > > "MTK_PUPD_SET_R1R0_00" &
> > > > > > > > > > > +              "MTK_PUPD_SET_R1R0_01" &
> > > > > > > > > > > "MTK_PUPD_SET_R1R0_10"
> > > > > > > > > > > &
> > > > > > > > > > > +              "MTK_PUPD_SET_R1R0_11" define in
> > > > > > > > > > > mt8196.
> > > > > > > > > > > +              For pull down type is PD/RSEL, it
> > > > > > > > > > > can
> > > > > > > > > > > add
> > > > > > > > > > > RSEL
> > > > > > > > > > > define to set
> > > > > > > > > > > +              different resistance. It can support
> > > > > > > > > > > +              "MTK_PULL_SET_RSEL_000" &
> > > > > > > > > > > "MTK_PULL_SET_RSEL_001" &
> > > > > > > > > > > +              "MTK_PULL_SET_RSEL_010" &
> > > > > > > > > > > "MTK_PULL_SET_RSEL_011" &
> > > > > > > > > > > +              "MTK_PULL_SET_RSEL_100" &
> > > > > > > > > > > "MTK_PULL_SET_RSEL_101" &
> > > > > > > > > > > +              "MTK_PULL_SET_RSEL_110" &
> > > > > > > > > > > "MTK_PULL_SET_RSEL_111"
> > > > > > > > > > > define in
> > > > > > > > > > > +              mt8196.
> > > > > > > > > > > diff --git a/include/dt-bindings/pinctrl/mt8196-
> > > > > > > > > > > pinfunc.h
> > > > > > > > > > > b/include/dt-bindings/pinctrl/mt8196-pinfunc.h
> > > > > > > > > > > new file mode 100644
> > > > > > > > > > > index 000000000000..bf0c8374407c
> > > > > > > > > > > --- /dev/null
> > > > > > > > > > > +++ b/include/dt-bindings/pinctrl/mt8196-pinfunc.h
> > > > > > > > > > > @@ -0,0 +1,1572 @@
> > > > > > > > > > > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-
> > > > > > > > > > > Clause
> > > > > > > > > > > */
> > > > > > > > > > > +/*
> > > > > > > > > > > + * Copyright (C) 2025 Mediatek Inc.
> > > > > > > > > > > + * Author: Guodong Liu <Guodong.Liu@mediatek.com>
> > > > > > > > > > > + */
> > > > > > > > > > > +
> > > > > > > > > > > +#ifndef __MT8196_PINFUNC_H
> > > > > > > > > > > +#define __MT8196_PINFUNC_H
> > > > > > > > > > > +
> > > > > > > > > > > +#include <dt-bindings/pinctrl/mt65xx.h>
> > > > > > > > > > > +
> > > > > > > > > > > +#define PINMUX_GPIO0__FUNC_GPIO0 (MTK_PIN_NO(0) |
> > > > > > > > > > > 0)
> > > > > > > > > > > +#define PINMUX_GPIO0__FUNC_DMIC1_CLK
> > > > > > > > > > > (MTK_PIN_NO(0) |
> > > > > > > > > > > 1)
> > > > > > > > > > > +#define PINMUX_GPIO0__FUNC_SPI3_A_MO
> > > > > > > > > > > (MTK_PIN_NO(0) |
> > > > > > > > > > > 3)
> > > > > > > > > > > +#define PINMUX_GPIO0__FUNC_FMI2S_B_LRCK
> > > > > > > > > > > (MTK_PIN_NO(0)
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > 4)
> > > > > > > > > > > +#define PINMUX_GPIO0__FUNC_SCP_DMIC1_CLK
> > > > > > > > > > > (MTK_PIN_NO(0) |
> > > > > > > > > > > 5)
> > > > > > > > > > > +#define PINMUX_GPIO0__FUNC_TP_GPIO14_AO
> > > > > > > > > > > (MTK_PIN_NO(0)
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > 6)
> > > > > > > > > >
> > > > > > > > > > I do not see how you resolved my comment from v1. In
> > > > > > > > > > v2 I
> > > > > > > > > > reminded
> > > > > > > > > > about
> > > > > > > > > > it, so you responded that yopu will change something,
> > > > > > > > > > but
> > > > > > > > > > I
> > > > > > > > > > do
> > > > > > > > > > not
> > > > > > > > > > see
> > > > > > > > > > any changes.
> > > > > > > > > >
> > > > > > > > > > So explain: how did you resolve my comment?
> > > > > > > > > >
> > > > > > > > > > These two examples where you claim you will change
> > > > > > > > > > something,
> > > > > > > > > > but
> > > > > > > > > > send
> > > > > > > > > > the same. I skipped the rest of the patch.
> > > > > > > > >
> > > > > > > > >    Thank you for your patient response, here is my
> > > > > > > > > explanation
> > > > > > > > > for
> > > > > > > > > you
> > > > > > > > > question:
> > > > > > > > >
> > > > > > > > >    In v1, I undertand that you meant I didn't sent a
> > > > > > > > > real
> > > > > > > > > binding,
> > > > > > > > > and
> > > > > > > >
> > > > > > > >
> > > > > > > > The comment is under specific lines, so I said these
> > > > > > > > defines
> > > > > > > > are
> > > > > > > > not
> > > > > > > > a
> > > > > > > > real binding. You sent them again, but they are still not
> > > > > > > > bindings,
> > > > > > > > because they are not used in the driver. Maybe the usage
> > > > > > > > is
> > > > > > > > convoluted,
> > > > > > > > so which part of implementation are these connecting with
> > > > > > > > DTS?
> > > > > > > > IOW,
> > > > > > > > which part of driver relies on the binding?
> > > > > > >
> > > > > > >    I got you. This binding define many macros, which will
> > > > > > > be
> > > > > > > used
> > > > > > > for
> > > > > > > 'pinmux' setting in the DTS. The usage like this:
> > > > > > >
> > > > > > >    adsp_uart_pins: adsp-uart-pins {
> > > > > > >                  pins-tx-rx {
> > > > > > >                          pinmux =3D
> > > > > > > <PINMUX_GPIO35__FUNC_O_ADSP_UTXD0>,
> > > > > > >                                   <PINMUX_GPIO36__FUNC_I1_A
> > > > > > > DSP_
> > > > > > > URXD0
> > > > > > > > ;
> > > > > > >
> > > > > > >                  };
> > > > > > >          };
> > > > > >
> > > > > >
> > > > > > That's DTS, not driver, so not a binding. Drop the header
> > > > > > from
> > > > > > bindings.
> > > > >
> > > > >    Sorry, I don't quite understand the relationship between
> > > > > binding
> > > > > and
> > > > > driver. Driver will parse this macro to get gpio number and
> > > > > function.
> > > > >
>
> ************* MEDIATEK Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including it=
s
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or beli=
eve
>
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

