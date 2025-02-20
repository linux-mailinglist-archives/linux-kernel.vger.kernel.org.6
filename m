Return-Path: <linux-kernel+bounces-523693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9633A3DA11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0886C423EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456B71F584E;
	Thu, 20 Feb 2025 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpHAY1VV"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA761F4639;
	Thu, 20 Feb 2025 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054398; cv=none; b=ZvcOvnxgK/UqQXKGp6iwFk3olyg5otGkRfRnYJvNfwNRtEPl2+Vq3C7CDtZdetTE53MwULP+HPyGefiO61R3C/5grqa08Wj1Qmi1AaXFkMtLIP3s2398E0tLiuxH32d2ReK9EEC0xpIWHJtgT16bkqTnjQOMPysQHrpVrSfVlVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054398; c=relaxed/simple;
	bh=/ag2+pqBfNA1YnPg2qWQBfIKIJRPfPq2nVeOyjnOjME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMR6J6zcKGvdal2azB5n/FMKOHFo4c09r+Hj0EWdvKoVE5W1K69kXKvTsXT99nO6sz9b9ylRDZLtDvALUOv5Nr6mYlAju8DLL/sqx4wzHWszDqpsq2CFJn+o4X1skinU/KciOQdSJq/NqEYt/NUbFldXb1DfQTmLC8lo3jyLakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpHAY1VV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f31f7732dso574682f8f.1;
        Thu, 20 Feb 2025 04:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054395; x=1740659195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH3DdgoKEAfwj4iaPXGOxAlwGgUTybVzhqeu1NMzPMo=;
        b=LpHAY1VV4bnUVGNwzKdm6fhXfUwM8GfItSQ55kzxwwYth7I+KgqFaGrsHNiGzsyaQL
         YdZaq5P3no0ByyE5e/x/VIEdZvgUNv1Ttp3svsN2XCwQ0lXOMDvGScugUPejXXs2F794
         fpr1g/h08de7TjVTiyav2Omwy92PF7FkqadA+gsoieqpkRi4Y8U44kmksbrwtjb0wTxC
         olwmsLUJXwuE5Ds97ib+x+cg2sdpljDI3mMUCRqmur9ZjWIchFCgSYp7EKZJhR1aIji6
         8djfrlG1xG3a87GGjCEcUMgWHpwPJjN4frp8w2fiUcjpPZTD9J3X9loPDpukmnfVEeO1
         NEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054395; x=1740659195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qH3DdgoKEAfwj4iaPXGOxAlwGgUTybVzhqeu1NMzPMo=;
        b=qDC4HRc/JvggJbTvaSo98Yn0/GaQEfuvdvaKyncZdmz7HCxgASeKNXx/CFuz13WLb1
         2STliW+enfVp2iyhoONuGqCLQ4KZ1J1Mg7vzR52eBNjlgTEmEglGCvxijv+qPS94hjXz
         nFFOPNccytJaKLz4TscfflG8XjAI3eA89guLmD5RUYEnyJjqBrK9MEGy9fBy7O75Tfko
         QQGbyhYGQytq/5dl2omFyJg/vW4wDoxQ7ha9zBjROTVi01qZmXXUA7D8Evlj2Lvi5oDN
         CyDns59s8fT2bEzd1Ykoo9LeqpOirS49iVXvi8sFnuEWZ7q9jz+FXUbBr6mwyMpwXxHe
         /Y8g==
X-Forwarded-Encrypted: i=1; AJvYcCVI9beKsgclcu3ghDef5ZGNXjCE0EEQOP+V3Wn7bRpjyU9F8yewUpRli7EQXAaNyV5BsjkChCU7Xj7L@vger.kernel.org, AJvYcCWmN1Jf4V20koCP+X2C4ne8fySZWmFQHlas/r7KSE9dulavXJ+49bZRQ0LHvCnspWp+Me4O+yVeGoOqSBbL@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjAISb/zE03bBwLJ2HnShZoIbUeidGRusfGXIpwVEL4pTL7aa
	7jssM2FemOeKotCact7tRmFwNvoUt4nmzXpwT1YRDYKr+pjb2So0Z2tqI1za6momxvlQhK9iC2L
	k1YvvEsPYb3PVAKu4SeQEJE1NX+I=
X-Gm-Gg: ASbGncudzaI081gEmvKZVZDTnLlNOBxujTKiZyUAmDTMoknG36lv890VkbH6mAS9vz2
	pmObBzkf0Rt6rKqL7FSIqz7rqEKEmzj60CWs3AOVg0SZ+1haKJPTQQMMWGtFNkPHBiKKMS9unnQ
	==
X-Google-Smtp-Source: AGHT+IEJTUmZHt18x/a4EVaHGfsjiEvSDzeEMYQTsZEr7m09QmHa6Dk5Cu5cXVAh1apSpLSOdMYco8A9NnvUxoKYV4Q=
X-Received: by 2002:a5d:58eb:0:b0:38d:b12f:60d1 with SMTP id
 ffacd0b85a97d-38f61609f19mr2169886f8f.26.1740054394477; Thu, 20 Feb 2025
 04:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140910.108175-1-clamor95@gmail.com> <20250217140910.108175-3-clamor95@gmail.com>
 <zmwn3dnnmwhms2qxqwb6ksshx27fcq2i4wujz5utuldaiqs6oz@idvy3dirrmuo>
 <CAPVz0n3bqLhuC0gxXD-=L0ETMmhOv1Ku0PrWUb_Yn09v3UNuOA@mail.gmail.com>
 <hemnpzzz3ddibdbqwkazwuoalmvuc2mekebqxfrnxiod6futni@sgdjgtrbcwza>
 <CAPVz0n24o5yar-0oO5dPb3vLzuK=Ln8+JKuaooSRwPfiaLQ9vA@mail.gmail.com>
 <jo7nnxrzwi43qqii7wtekdbc6vluakkvg4ndw266ajgkpe3y52@whd5nly34nju>
 <CAPVz0n3HsXJeyRJGP=_UMhs7d4OA-P_yXx5B9EQDU7vQCz8qoA@mail.gmail.com> <3lms6xzzu3hfhkncikcmvl6btzdcc2cwoh4kwhw53hdakecrij@yqoyl3bqmm5m>
In-Reply-To: <3lms6xzzu3hfhkncikcmvl6btzdcc2cwoh4kwhw53hdakecrij@yqoyl3bqmm5m>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 20 Feb 2025 14:26:22 +0200
X-Gm-Features: AWEUYZnht_Ew12HsnJseDT7TV_6lFwyWBz022uUOwakEZ6gmzeAR7-sBzh9_wRA
Message-ID: <CAPVz0n3YZass3Bns1m0XrFxtAC0DKbEPiW6vXimQx97G243sXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm: bridge: Add support for Solomon SSD2825
 RGB/DSI bridge
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=82, 20 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:35 Dmitry Bar=
yshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Feb 20, 2025 at 09:37:18AM +0200, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 19 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 15:34 =
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Tue, Feb 18, 2025 at 04:36:17PM +0200, Svyatoslav Ryhel wrote:
> > > > =D0=B2=D1=82, 18 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16=
:20 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > > >
> > > > > On Tue, Feb 18, 2025 at 02:45:19PM +0200, Svyatoslav Ryhel wrote:
> > > > > > =D0=B2=D1=82, 18 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=
=BE 14:31 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > > > > > >
> > > > > > > On Mon, Feb 17, 2025 at 04:09:10PM +0200, Svyatoslav Ryhel wr=
ote:
> > > > > > > > SSD2825 is a cost-effective MIPI Bridge Chip solution targe=
ting mainly
> > > > > > > > smartphones. It can convert 24bit RGB interface into 4-lane=
 MIPI-DSI
> > > > > > > > interface to drive display modules of up to 800 x 1366, whi=
le supporting
> > > > > > > > AMOLED, a-si LCD or LTPS panel technologies for smartphone =
applications.
> > > > > > > >
> > > > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/bridge/Kconfig   |  14 +
> > > > > > > >  drivers/gpu/drm/bridge/Makefile  |   1 +
> > > > > > > >  drivers/gpu/drm/bridge/ssd2825.c | 824 +++++++++++++++++++=
++++++++++++
> > > > > > > >  3 files changed, 839 insertions(+)
> > > > > > > >  create mode 100644 drivers/gpu/drm/bridge/ssd2825.c
> > > > > > > >
...
> > > > > > >
> > > > > > > From v1:
> > > > > > >
> > > > > > > Most of these flags should be set depending on the
> > > > > > > mipi_dsi_device.mode_flags.
> > > > > > >
> > > > > > > > +             ssd2825_write_reg(priv, SSD2825_PLL_CTRL_REG,=
 0x0001);
> > > > > > > > +             ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, =
0x0000);
> > > > > > >
> > > > > > > Why? Why do you need this special handling for the
> > > > > > > MIPI_DCS_SET_DISPLAY_ON? Why can't it just go to .atomic_enab=
le()?
> > > > > > >
> > > > > >
> > > > > > This has to be called after panel init dsi sequence completes, =
is
> > > > > > atomic_enable called after panel init dsi seq is completed? May=
be you
> > > > > > can suggest where to place it.
> > > > >
> > > > > That depends on a panel. Significant number of panel drivers call=
 all
> > > > > DSI programming in .prepare because some DSI hosts can not transf=
er
> > > > > commands after starting DSI video stream.
> > > > >
> > > > > So these commands should go to your .enable().
> > > > >
> > > >
> > > > This is weird and counter intuitive to send dsi commands in prepare=
,
> > > > there should be smth like enable_post. Oh well, fine, I will try to
> > > > fit this somehow.
> > > >
> >
> > Who had made this cursed framework?
> >
> > Functions are called in the next seq
> >
> > panel_prepare > bridge_pre_enable > bridge_enable > panel_enable
>
> Use drm_bridge.pre_enable_prev_first or drm_panel.prepare_prev_first. I
> think that fixes your order issues.
>

This seems to have no effect. I have set panel.prepare_prev_first =3D
true in the panel probe, which should result in
bridge_atomic_pre_enable be called before panel prepare,
and yet I still have this:

[   45.280653] renesas_r61307_prepare start
[   45.300873] renesas_r61307_prepare end
[   45.301070] ssd2825_bridge_atomic_pre_enable start
[   45.317248] ssd2825_bridge_atomic_pre_enable end
[   45.317287] ssd2825_bridge_atomic_enable start
[   45.331650] ssd2825_bridge_atomic_enable end
[   45.331677] renesas_r61307_enable start
[   45.520959] renesas_r61307_enable end

With or without the flag it is same

> > There is no gap in between bridge_pre_enable and bridge enable, hence
> > I cannot call dsi commands in panel_prepare since bridge is not even
> > pre_enabled, and if I call then in panel_enable, I cannot complete
> > bridge configuration since bridge enable is called before. like WTF!
> >
> > I enclose log with function call seq
> >
> > DSI commands in panel prepare
> > [   75.149700] ssd2825_dsi_host_transfer start  << this is panel prepar=
e
> > [   75.149737] ssd2825 spi0.2: Bridge is not enabled
> > [   75.149750] panel-renesas-r61307 spi0.2.1: Failed to exit sleep mode=
: -19
> > [   75.149779] ssd2825_bridge_atomic_pre_enable start
> > [   75.178518] ssd2825_bridge_atomic_pre_enable end
> > [   75.178552] ssd2825_bridge_atomic_enable start
> > [   75.179026] ssd2825_bridge_atomic_enable end
> >
> > DSI commands in panel enable
> >
> > [  102.821580] ssd2825_bridge_atomic_pre_enable start
> > [  102.852000] ssd2825_bridge_atomic_pre_enable end
> > [  102.852057] ssd2825_bridge_atomic_enable start
> > [  102.852840] ssd2825_bridge_atomic_enable end
> > [  102.852866] ssd2825_dsi_host_transfer start  << panel enable
> > [  102.853876] ssd2825_dsi_host_transfer end
> > [  102.948420] ssd2825_dsi_host_transfer start
> > [  102.949289] ssd2825_dsi_host_transfer end
> > [  102.978389] ssd2825_dsi_host_transfer start
> > [  102.979567] ssd2825_dsi_host_transfer end
> > [  102.980117] ssd2825_dsi_host_transfer start
> > [  102.981248] ssd2825_dsi_host_transfer end
> > [  102.981809] ssd2825_dsi_host_transfer start
> > [  102.982851] ssd2825_dsi_host_transfer end
> > [  102.983537] ssd2825_dsi_host_transfer start
> > [  102.984556] ssd2825_dsi_host_transfer end
> > [  102.986743] ssd2825_dsi_host_transfer start
> > [  102.988078] ssd2825_dsi_host_transfer end
> > [  102.989445] ssd2825_dsi_host_transfer start
> > [  102.990411] ssd2825_dsi_host_transfer end
> > [  102.990912] ssd2825_dsi_host_transfer start
> > [  102.992274] ssd2825_dsi_host_transfer end
> >
> > In both cases there is no gap in between bridge pre_enable and enable
> >
> > > > > But what is the case for these calls? Are you manually implementi=
ng the
> > > > > MIPI_DSI_MODE_LPM flag? What exactly do they do? What happens if =
the
> > > > > panel driver asks for the MIPI_DCS_SET_DISPLAY_ON command after y=
ou've
> > > > > programmed those registers? What happens if the panel asks for th=
e
> > > > > backlight control?
> > > > >
> > > >
> > > > Backlight is externally controlled, at least on my device, so I can=
not
> > > > test other cases. If I configure those registers before dsi sequenc=
e
> > > > is completed panel stays black. If I simply remove those
> > > > configuration, panel stays black.
> > > >

