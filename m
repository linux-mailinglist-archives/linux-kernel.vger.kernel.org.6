Return-Path: <linux-kernel+bounces-275003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E75947F63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB58B1F22B05
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F9015C128;
	Mon,  5 Aug 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0/kUfl4"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB313AD29;
	Mon,  5 Aug 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875506; cv=none; b=H+zI5aeneMhEc9A4yClpcRdELUGAQgfUGJaao/8/w9E6d7sZp1jlIHEraBqhluXYyLYI/SFA/1mHeOb2VU7tqTVSFgSmkaLC0UYk+xBT707UCG03HZKk7vW2K8cfyj9L95BR1xEHMcK8KckzeKW1lVOQGqrGwlB5/tnFvFWOgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875506; c=relaxed/simple;
	bh=CGjC+WBcE98DaN0rYYpCWu7ZVHKvKIvRrZykINZmEQQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nn58TMmZrluzYm3PV6WUAeLv2+kfhLe5JIjFjJ2A3rm3SA0FIdgSObgEaVmuW4rRWvFQycOyiNAi/kfqNz7EGt1J0oEIQ+7QTHUS3GzGpRwGfhnOUxO3OPu7sAbXYG3uE0q+T8fhhgZ8jUAbnBOY2HbgVHcbA+9kDLRyZAZe6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0/kUfl4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so23096187e87.0;
        Mon, 05 Aug 2024 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722875503; x=1723480303; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=621xkAoDI4+8AtZyzmI5ne9j+EyrefU8aEvGSj0OzNs=;
        b=e0/kUfl4noteTPITMTk+fDeDvjpaxyDfSHx27swego9JTPyujyDvbMzQ9MteYUJwXg
         ETUdhz6nNuNpp0tNsUELP3JlUohTc70goldZChvZa4zOcX8GDOCG4L8ELHRnjSEmn0og
         6zwSychpDcBmIdli/CunPEbZk9D8RxaEmmVmgCSNPXl4/awD5AQAQ9NKp0APKfXyEeSO
         r/RnXjoLDK0FHCGbi2vxiZnG5F9bAqEul1+nCFOLnjFV2AnEY9BPCyu7d7Y1USsvQ18J
         VB5LQoyQbqCPj2X/5cXVLQqJ0rUEUSjsG8h8spziJPc17RY/jDtbE95VpmHJKYE/kpss
         TKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722875503; x=1723480303;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=621xkAoDI4+8AtZyzmI5ne9j+EyrefU8aEvGSj0OzNs=;
        b=hg8ZDtlUUnwZ9zweiMRT3IVn/HbCs7+wZJCXZdZCrgzjidu/u0Swq3WUR/ceQRWjGf
         74sRS9jv8hn3copzniTb/HHnYIRYTTw03jT3hE4GXxKOs4emNN4bh+a+yRKzq+d7SaR9
         oMIw1WHcpOVuJtP/3gKcdVJ02ovzRu7Yu5e2x6xQhB+A7rppDKUCSnOvYRoE4yLoMJeO
         qZxbV7asM2r/QmzO0QWsKN2pTJhdMVPcVW1IfnHhxKQjpKYtPKsKQXenZp9Rc+z20nGZ
         9bqTOL4QOnSfcu3aRw00TzkOjq8+mNzRF2dszAVVe+R4L9ZEvBDFeNpaZkHPCXbU09kQ
         IBFg==
X-Forwarded-Encrypted: i=1; AJvYcCVzCIpvAxpF9DtI+JsNFr+pzdsxtA7DyUaBAuX1IFKx6VjWAuwjDxdQSdo1F9vi9NCIsjr1S5LBKvRG3vXUIchU0gSYjiT0KrMc+xTotusMYCIf8qvmyRMoZjtCeJlVe18gwFC6J9mAig==
X-Gm-Message-State: AOJu0YwhYdhgNozBQ8kuqPION7TP0GJFVD1X53dMyAQLkAhRQZbpWXc2
	JzOPYMn0u0iwwdSakJ4obKSfvgA2aBFWywfQ3zd+m45GoAj+QY8w
X-Google-Smtp-Source: AGHT+IEYeJQFHMlgEBC1z/7yaKc6FQUSGQKUjy5BVK+bmjwpTIsHWavy//z1nw11/GNeOkDWpg0JeA==
X-Received: by 2002:a05:6512:3b89:b0:52c:cd77:fe03 with SMTP id 2adb3069b0e04-530bb380dabmr10072630e87.14.1722875502321;
        Mon, 05 Aug 2024 09:31:42 -0700 (PDT)
Received: from smtpclient.apple (84-10-100-139.static.chello.pl. [84.10.100.139])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba08ee0sm1194849e87.57.2024.08.05.09.31.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2024 09:31:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2 0/3] Add initial support for the Rockchip RK3588 HDMI
 TX Controller
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <66b0fbcc.050a0220.30fac7.71ce@mx.google.com>
Date: Mon, 5 Aug 2024 18:31:28 +0200
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 devicetree@vger.kernel.org,
 kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B669ED19-28D8-4C4E-B89C-F7E7A6E3AA65@gmail.com>
References: <20240801-b4-rk3588-bridge-upstream-v2-0-9fa657a4e15b@collabora.com>
 <45B07EAF-4CBA-4DE4-A03B-109767D52B29@gmail.com>
 <66b0fbcc.050a0220.30fac7.71ce@mx.google.com>
To: Chris Morgan <macroalpha82@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)



> Wiadomo=C5=9B=C4=87 napisana przez Chris Morgan =
<macroalpha82@gmail.com> w dniu 05.08.2024, o godz. 18:20:
>=20
> On Sat, Aug 03, 2024 at 03:24:06PM +0200, Piotr Oniszczuk wrote:
>> Hi Cristian,
>>=20
>> Will you find some time and motivation to add CEC support to =
Quad-Pixel (QP) TX controller ?
>>=20
>> Probably you recall - I added initial CEC support to yours v1 series =
and i=E2=80=99m stuck with timing issue (cec pulses are 3x too long).
>> For me it looks like clock issue.
>> I=E2=80=99m out of ideas how to move forward with this timming =
issue=E2=80=A6.
>=20
> I wonder if using the cec-gpio on "GPIO4 RK_PC1" for the CEC gpio and
> "GPIO1 RK_PA5" for the HPD gpio is a possibility? Just a thought.
>=20
> Chris

Chris,
Oscilloscope shows pulses on cec line - issue is that cec pulses =
observed on oscilloscope have timings 2,9 times longer that should be =
(start bit is 10,7mS instead of 3.6; zero is 4.4 instead 1.5 while one =
is 1,7 instead of 0.6).
Pulses durations seems to be =E2=80=9Eproportional" (start; zero; one) - =
all are almost exact 2.9x too long.=20
For me this sounds like wrong clock issue.
I can try switch to gpio outs - but I think better is to first make sure =
that cec clock is set ok.
Im not sure what is best way to do such cec clock check...  =20
=20
>=20
>>=20
>>=20
>>=20
>>> Wiadomo=C5=9B=C4=87 napisana przez Cristian Ciocaltea =
<cristian.ciocaltea@collabora.com> w dniu 01.08.2024, o godz. 04:25:
>>>=20
>>> The Rockchip RK3588 SoC family integrates the Synopsys DesignWare =
HDMI
>>> 2.1 Quad-Pixel (QP) TX controller [4], which is a new IP block, =
quite
>>> different from those used in the previous generations of Rockchip =
SoCs.
>>>=20
>>> This is the last component that needs to be supported in order to =
enable
>>> the HDMI output functionality on the RK3588 based SBCs, such as the
>>> RADXA Rock 5B. The other components are the Video Output Processor
>>> (VOP2) and the Samsung IP based HDMI/eDP TX Combo PHY, for which =
basic
>>> support has been already made available via [1] and [2], =
respectively.
>>>=20
>>> Please note this is a reworked version of the original series, which
>>> relied on a commonized dw-hdmi approach.  Since the general =
consensus
>>> was to handle it as an entirely new IP, I dropped all patches =
related to
>>> the old dw-hdmi and Rockchip glue code - a few of them might still =
make
>>> sense as general improvements and will be submitted separately.
>>>=20
>>> Additionally, as suggested by Neil, I've sent the reworked bridge =
driver
>>> as a separate patchset [4], hence this series handles now just the =
new
>>> Rockchip QP platform driver.
>>>=20
>>> It's worth mentioning the HDMI output support is currently limited =
to
>>> RGB output up to 4K@60Hz, without audio, CEC or any of the HDMI 2.1
>>> specific features.  Moreover, the VOP2 driver is not able to =
properly
>>> handle all display modes supported by the connected screens, e.g. it
>>> doesn't cope with non-integer refresh rates.
>>>=20
>>> A possible workaround consists of enabling the display controller to
>>> make use of the clock provided by the HDMI PHY PLL. This is still =
work
>>> in progress and will be submitted later, as well as the required DTS
>>> updates.
>>>=20
>>> To facilitate testing and experimentation, all HDMI output related
>>> patches, including those part of this series, as well as the bridge
>>> driver, are available at [3].
>>>=20
>>> So far I could only verify this on the RADXA Rock 5B board.
>>>=20
>>> Thanks,
>>> Cristian
>>>=20
>>> [1]: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
>>> [2]: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY =
driver")
>>> [3]: =
https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/com=
mits/rk3588-hdmi-bridge-v6.11-rc1
>>> [4]: =
https://lore.kernel.org/lkml/20240801-dw-hdmi-qp-tx-v1-0-148f542de5fd@coll=
abora.com/
>>>=20
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>> Changes in v2:
>>> - Reworked the glue code for RK3588 into a new Rockchip platform =
driver
>>> - Moved bridge driver patches to a separate series [4]
>>> - Dropped all the patches touching to the old dw-hdmi and RK =
platform
>>> drivers
>>> - Added connector creation to ensure the HDMI QP bridge driver does =
only
>>> support DRM_BRIDGE_ATTACH_NO_CONNECTOR
>>> - Link to v1: =
https://lore.kernel.org/r/20240601-b4-rk3588-bridge-upstream-v1-0-f6203753=
232b@collabora.com
>>>=20
>>> ---
>>> Cristian Ciocaltea (3):
>>>     dt-bindings: display: rockchip: Add schema for RK3588 HDMI TX =
Controller
>>>     drm/rockchip: Explicitly include bits header
>>>     drm/rockchip: Add basic RK3588 HDMI output support
>>>=20
>>> .../display/rockchip/rockchip,dw-hdmi-qp.yaml      | 188 +++++++++
>>> drivers/gpu/drm/rockchip/Kconfig                   |   8 +
>>> drivers/gpu/drm/rockchip/Makefile                  |   1 +
>>> drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     | 430 =
+++++++++++++++++++++
>>> drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
>>> drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   4 +-
>>> 6 files changed, 632 insertions(+), 1 deletion(-)
>>> ---
>>> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
>>> change-id: 20240601-b4-rk3588-bridge-upstream-a27baff1b8fc
>>>=20
>>>=20
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>=20
>>=20


