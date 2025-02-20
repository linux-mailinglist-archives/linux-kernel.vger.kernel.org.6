Return-Path: <linux-kernel+bounces-524013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B29A3DE27
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AD47AD208
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2471FA851;
	Thu, 20 Feb 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgZX8Hpw"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF51D6194;
	Thu, 20 Feb 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064315; cv=none; b=IyxWqjbJsrFpqS6WDz8wyWIYD0xyTZlaEjdZnu0HszWYrlVyDb9N0SKR62yQFEJBVRuqv4D6jXlFPrg/dzJT681lJy3nsMSt6XQL8jwJE8SQ5H+ASRzVFKqei2JKEb/p6GhAduMh0Pyq2ejMZ9s6jvGXcpTwO6dJJbsUupnT8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064315; c=relaxed/simple;
	bh=Ztoy/fTj8rFfrb/gZvOJJv8/1c7n5UTWrfVG6C1klf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=php/4f2XMO79iHbawFEdbNoHELqZnBTMgr3zBnNs5Qyrkp+/qPbgCwml+xSeYVUfvW7zuG3svxpWjfFFIHo37oPk3tktIwI5r8t5ykLPOMoEsZsN4hTyc12BmLGRvW9Hj1PvhJKqzjB+ZLsxgYv4sSubzLqGA79jIRPQ3R+M4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgZX8Hpw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439a4fc2d65so8231685e9.3;
        Thu, 20 Feb 2025 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740064312; x=1740669112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZzXhdEGSSkZCTHaX2hw4lO1FdZswyNX5r+IEhYfpec=;
        b=SgZX8HpwBqwXM1H9MiIH69xhKPMrw0mBO9VOCvhVRWtxbMX4+wTYIvjC7vhp5jSZOy
         yi9CXwVzOj04sTvr1UaMKrtTiENrXHlY+GurCCJGthdihp5M/413Ubt+Cpmq+ynSQ1nh
         ctbqu+Ej/65qBlBzKVoTKHv6s4U7ptQck0/zYMtaSNlzWjSfi94ClT4Ow5jRuGL4hJdG
         F1eKrNTjXJIANjzhBYfR+qA60/2E6QfSEYQa27TWeImfefg58l0A4uYXD3hQm7htwWtU
         56sVLIEaa5HOG8Oc9Qut8miRWpcGLMvFRyX9vpXCSyqmZJ5uUw2r89g7GuqeLaxu2qOX
         FgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740064312; x=1740669112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZzXhdEGSSkZCTHaX2hw4lO1FdZswyNX5r+IEhYfpec=;
        b=I+6583qm8F/NsH+8Fe/WhWy4HHOccJl9/1oVA2GRHohqt+t7H5B7WMTpNzTXFA9Lh2
         hiFGWpnERMBKFjsNDV2UW9qnqYG3d+RLnynkB4tM8uowEX+iYRHi1VyfweYFiPX4RV6Y
         6SxRuVsDFtCCdXLFnU2z9E5wKREGTzAH5QB6wK1gabOuxAbZptOrTn9kT63JKTz2LnXE
         B7Xg/YgcB30hqMdUkE6RyYTxEnMGV1UURffZV44nicIwdNFHgCR2pqCnBtVtj0DIFJy4
         XAPd9c/UPrEHJMqsmg67tPuB0Qu8RynlttdnGdEgC4odmDLHhybOVvhA92sb4qArCIq8
         NXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdgI+/Mjr8NZObCInyY9xmdMLR1DkF/HDGFXWh7yBC1ZJHALzEu9dXBvEeTwRRDNcUnnYugKQndeU5@vger.kernel.org, AJvYcCVCv4Qqq+Rg+MXwdWZv6aBeDNXF1t0LKH1Z40AtcVjbMs6dqb0WqIuPuQy0s4hwtLYWuec8mSSKv9BVqRQd@vger.kernel.org
X-Gm-Message-State: AOJu0YzQd7gmoXIvJgTg+E0MRAfylRsNZS3T9nVtkzrSQDKE8TZdYWLY
	nv7YYD7WwjCoxvBM+aiC/loTQEOvvFEoxszvpGFSDQ92Jx8x9OIHneSZ9Fg7F+coRTvcQ6jUM8E
	9V8PLxk3dvVIh5cEi7Zqq6sY1vaw=
X-Gm-Gg: ASbGncsSfVy/2ALT9lL8+NhmbRsLIH9NCerzJ2psfNDdAYIgHp+jEnakkStUV/a/o3N
	0KCXehJbXRD3tFcaYUnmIBzA+/qJrOG5BSh7SA+htTRyWiwbTLHg42ur6MnuHzG21qZjdm1H6tw
	==
X-Google-Smtp-Source: AGHT+IEwoeMX6J12QmDEt5R/RC24PUelKkUWkycdwX0ajlm0bv3hfNZz3IVQDRDCtgAizzn0zwTuxN+WYiZbdKRX/9M=
X-Received: by 2002:a5d:6051:0:b0:38a:2b39:9205 with SMTP id
 ffacd0b85a97d-38f33f39a1bmr20654393f8f.33.1740064311723; Thu, 20 Feb 2025
 07:11:51 -0800 (PST)
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
 <CAPVz0n3HsXJeyRJGP=_UMhs7d4OA-P_yXx5B9EQDU7vQCz8qoA@mail.gmail.com>
 <3lms6xzzu3hfhkncikcmvl6btzdcc2cwoh4kwhw53hdakecrij@yqoyl3bqmm5m>
 <CAPVz0n3YZass3Bns1m0XrFxtAC0DKbEPiW6vXimQx97G243sXw@mail.gmail.com> <eard52ujlocxwshi6ynoimmvfyktpx6f5gcwfn2chaxul2l7my@e24kauxjsw2a>
In-Reply-To: <eard52ujlocxwshi6ynoimmvfyktpx6f5gcwfn2chaxul2l7my@e24kauxjsw2a>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 20 Feb 2025 17:11:39 +0200
X-Gm-Features: AWEUYZmsx4vnO4A4WUOKNBHW3jf2mgl2CcCyXot5MfN6b4F3ATdvpJehnSNkALE
Message-ID: <CAPVz0n3p2Zbe44RB5AJmq9Zdpmi0gHPZisB-Kv4L9XA7oc70Gg@mail.gmail.com>
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

=D1=87=D1=82, 20 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 17:07 Dmit=
ry Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Feb 20, 2025 at 02:26:22PM +0200, Svyatoslav Ryhel wrote:
> > =D1=82, 20 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:35 Dmitry=
 Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Thu, Feb 20, 2025 at 09:37:18AM +0200, Svyatoslav Ryhel wrote:
> > > > =D1=81=D1=80, 19 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 15=
:34 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > > >
> > > > > On Tue, Feb 18, 2025 at 04:36:17PM +0200, Svyatoslav Ryhel wrote:
> > > > > > =D0=B2=D1=82, 18 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=
=BE 16:20 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > > > > > >
> > > > > > > On Tue, Feb 18, 2025 at 02:45:19PM +0200, Svyatoslav Ryhel wr=
ote:
> > > > > > > > =D0=B2=D1=82, 18 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =
=D0=BE 14:31 Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=
=88=D0=B5:
> > > > > > > > >
> > > > > > > > > On Mon, Feb 17, 2025 at 04:09:10PM +0200, Svyatoslav Ryhe=
l wrote:
> > > > > > > > > > SSD2825 is a cost-effective MIPI Bridge Chip solution t=
argeting mainly
> > > > > > > > > > smartphones. It can convert 24bit RGB interface into 4-=
lane MIPI-DSI
> > > > > > > > > > interface to drive display modules of up to 800 x 1366,=
 while supporting
> > > > > > > > > > AMOLED, a-si LCD or LTPS panel technologies for smartph=
one applications.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/gpu/drm/bridge/Kconfig   |  14 +
> > > > > > > > > >  drivers/gpu/drm/bridge/Makefile  |   1 +
> > > > > > > > > >  drivers/gpu/drm/bridge/ssd2825.c | 824 +++++++++++++++=
++++++++++++++++
> > > > > > > > > >  3 files changed, 839 insertions(+)
> > > > > > > > > >  create mode 100644 drivers/gpu/drm/bridge/ssd2825.c
> > > > > > > > > >
> > ...
> > > > > > > > >
> > > > > > > > > From v1:
> > > > > > > > >
> > > > > > > > > Most of these flags should be set depending on the
> > > > > > > > > mipi_dsi_device.mode_flags.
> > > > > > > > >
> > > > > > > > > > +             ssd2825_write_reg(priv, SSD2825_PLL_CTRL_=
REG, 0x0001);
> > > > > > > > > > +             ssd2825_write_reg(priv, SSD2825_VC_CTRL_R=
EG, 0x0000);
> > > > > > > > >
> > > > > > > > > Why? Why do you need this special handling for the
> > > > > > > > > MIPI_DCS_SET_DISPLAY_ON? Why can't it just go to .atomic_=
enable()?
> > > > > > > > >
> > > > > > > >
> > > > > > > > This has to be called after panel init dsi sequence complet=
es, is
> > > > > > > > atomic_enable called after panel init dsi seq is completed?=
 Maybe you
> > > > > > > > can suggest where to place it.
> > > > > > >
> > > > > > > That depends on a panel. Significant number of panel drivers =
call all
> > > > > > > DSI programming in .prepare because some DSI hosts can not tr=
ansfer
> > > > > > > commands after starting DSI video stream.
> > > > > > >
> > > > > > > So these commands should go to your .enable().
> > > > > > >
> > > > > >
> > > > > > This is weird and counter intuitive to send dsi commands in pre=
pare,
> > > > > > there should be smth like enable_post. Oh well, fine, I will tr=
y to
> > > > > > fit this somehow.
> > > > > >
> > > >
> > > > Who had made this cursed framework?
> > > >
> > > > Functions are called in the next seq
> > > >
> > > > panel_prepare > bridge_pre_enable > bridge_enable > panel_enable
> > >
> > > Use drm_bridge.pre_enable_prev_first or drm_panel.prepare_prev_first.=
 I
> > > think that fixes your order issues.
> > >
> >
> > This seems to have no effect. I have set panel.prepare_prev_first =3D
> > true in the panel probe, which should result in
> > bridge_atomic_pre_enable be called before panel prepare,
> > and yet I still have this:
>
> I've cc'ed you on the patch that should fix this behaviour.
>

Thank you. For the fix and suggestions.

> >
> > [   45.280653] renesas_r61307_prepare start
> > [   45.300873] renesas_r61307_prepare end
> > [   45.301070] ssd2825_bridge_atomic_pre_enable start
> > [   45.317248] ssd2825_bridge_atomic_pre_enable end
> > [   45.317287] ssd2825_bridge_atomic_enable start
> > [   45.331650] ssd2825_bridge_atomic_enable end
> > [   45.331677] renesas_r61307_enable start
> > [   45.520959] renesas_r61307_enable end
> >
> > With or without the flag it is same
> >
> > > > There is no gap in between bridge_pre_enable and bridge enable, hen=
ce
> > > > I cannot call dsi commands in panel_prepare since bridge is not eve=
n
> > > > pre_enabled, and if I call then in panel_enable, I cannot complete
> > > > bridge configuration since bridge enable is called before. like WTF=
!
> > > >
> > > > I enclose log with function call seq
> > > >
> > > > DSI commands in panel prepare
> > > > [   75.149700] ssd2825_dsi_host_transfer start  << this is panel pr=
epare
> > > > [   75.149737] ssd2825 spi0.2: Bridge is not enabled
> > > > [   75.149750] panel-renesas-r61307 spi0.2.1: Failed to exit sleep =
mode: -19
> > > > [   75.149779] ssd2825_bridge_atomic_pre_enable start
> > > > [   75.178518] ssd2825_bridge_atomic_pre_enable end
> > > > [   75.178552] ssd2825_bridge_atomic_enable start
> > > > [   75.179026] ssd2825_bridge_atomic_enable end
> > > >
> > > > DSI commands in panel enable
> > > >
> > > > [  102.821580] ssd2825_bridge_atomic_pre_enable start
> > > > [  102.852000] ssd2825_bridge_atomic_pre_enable end
> > > > [  102.852057] ssd2825_bridge_atomic_enable start
> > > > [  102.852840] ssd2825_bridge_atomic_enable end
> > > > [  102.852866] ssd2825_dsi_host_transfer start  << panel enable
> > > > [  102.853876] ssd2825_dsi_host_transfer end
> > > > [  102.948420] ssd2825_dsi_host_transfer start
> > > > [  102.949289] ssd2825_dsi_host_transfer end
> > > > [  102.978389] ssd2825_dsi_host_transfer start
> > > > [  102.979567] ssd2825_dsi_host_transfer end
> > > > [  102.980117] ssd2825_dsi_host_transfer start
> > > > [  102.981248] ssd2825_dsi_host_transfer end
> > > > [  102.981809] ssd2825_dsi_host_transfer start
> > > > [  102.982851] ssd2825_dsi_host_transfer end
> > > > [  102.983537] ssd2825_dsi_host_transfer start
> > > > [  102.984556] ssd2825_dsi_host_transfer end
> > > > [  102.986743] ssd2825_dsi_host_transfer start
> > > > [  102.988078] ssd2825_dsi_host_transfer end
> > > > [  102.989445] ssd2825_dsi_host_transfer start
> > > > [  102.990411] ssd2825_dsi_host_transfer end
> > > > [  102.990912] ssd2825_dsi_host_transfer start
> > > > [  102.992274] ssd2825_dsi_host_transfer end
> > > >
> > > > In both cases there is no gap in between bridge pre_enable and enab=
le
> > > >
> > > > > > > But what is the case for these calls? Are you manually implem=
enting the
> > > > > > > MIPI_DSI_MODE_LPM flag? What exactly do they do? What happens=
 if the
> > > > > > > panel driver asks for the MIPI_DCS_SET_DISPLAY_ON command aft=
er you've
> > > > > > > programmed those registers? What happens if the panel asks fo=
r the
> > > > > > > backlight control?
> > > > > > >
> > > > > >
> > > > > > Backlight is externally controlled, at least on my device, so I=
 cannot
> > > > > > test other cases. If I configure those registers before dsi seq=
uence
> > > > > > is completed panel stays black. If I simply remove those
> > > > > > configuration, panel stays black.
> > > > > >
>
> --
> With best wishes
> Dmitry

