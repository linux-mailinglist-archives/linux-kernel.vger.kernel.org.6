Return-Path: <linux-kernel+bounces-524529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5568BA3E429
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5786B189C9D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1468E262D37;
	Thu, 20 Feb 2025 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfYG8yng"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463041E3761;
	Thu, 20 Feb 2025 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077276; cv=none; b=h/JLkBqeAaE9jgNsAawgoLESQgObfFJ+o54lgad2IWwDuw79KxDNwIxk1dfP7qRk2fh1H26AZZY5mdaHPpfOXrdxllH3xB+dgiVJ7sP3hn7GQpupuMuoyjjudGIQjgXItMS15DCBirEsKfBGbcHDsoywMrpMxj+QGploz+8mmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077276; c=relaxed/simple;
	bh=U/v7Z2RwsmYdj4bE/uoN4+EXjKlJnSaWg6pKH5TQUQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC6NWt83ikCoPycKMIVC/U0aS7HFAHLYPqYltj3IPuw2t3imSMMzfrBvi6q2zeYvnrjCxedk7DByUW2k91LTAJmQuh0ik6kmX1L4Kx52xSm815GtFWLX9PYlzV4hCYjvKfRJbGfzMEkIoS7byxNO2Uncs2vQsik6ahFW/yLwrkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfYG8yng; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so764033f8f.2;
        Thu, 20 Feb 2025 10:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740077272; x=1740682072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYowbf1CODQB9n/ooqpW/RrguAGNvEkQlicasZTK5YI=;
        b=CfYG8yngsK1fyHL9G8RvxYoSuJj/xFeBUq1AU5wThBpq/LE94w38crCJduaEBafE8a
         F4mV3fTeQ+USHwJ7ts45uzqtVyFNep942XQ7esTor6PRLIErC8J0Vjwfepf9DBJeQFMW
         Lkzg2kXn0w3MGY0kUp79ITC/h7p2nWYYy+Eq5eIcKQYEPrZHNyQSojukEsoVUJQ+TwQM
         +Ojf/EggWlNgb3EemK5yAornFDWW3nEK+NEi8hECZ5Sgz193qD0Qm5uU+ZWtpcvfV99R
         7rAE+4CmTsGF9z/aU4vQ2QB9bvY1HAyTvBFtuBduGab/G3BAnUluFvsRCCKyvpGR4FrY
         tMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077272; x=1740682072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYowbf1CODQB9n/ooqpW/RrguAGNvEkQlicasZTK5YI=;
        b=rGrMSA9cV2JTif/bGYAe0884dtUAIoc8PYEZFcKhw9nk7agSFKKjOjgc+n5CMs+erA
         BL0+SihHq3dgV4cURx/BH6OtCYQp02r7H5YdY4/fbR3oCKMNZopXqck9Z/SNpKcQEAmX
         2KReucfy/alZEEcSqbt38DgcKxpQLDEGa9R4u5KEgb2/PELweUVTYu36ZjxXpzSODc/a
         wf/Q9ztuhNx9GmImsa9FsSHNGLPUcNXNP0K7XF8i6P+pwRDstFnm4DgVwibGylwHyG0y
         Nf3yPeafVbYU/uxIcSZh/0AsKYsC7LGDawuHqSg6rnVH2Y0jrOSlpy4ey5EVPA4bMPxq
         h8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyH17x8H18yB3YXiJZOlE5EFNEI74bLLSbRqm3yQD6JHnmyPloykkxWkgESOtbCam5e3T6+g1wk1PMpfRl@vger.kernel.org, AJvYcCX8QECsLtorzVNoS1WXRVAxqIuz7FP0konE8Q5B6zm4J0SJbfYYzn7/VOxRMpahd3q45svjXJXBT5Li@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/X+bVzNv3qn5eJfK/MKnmH94ybujT9HA6IWHujw9ZAuWwWtEx
	uB4/PHJ9mVnNlkqE0loaRjzlwr9ifXB3PtZP2Ofyowf3vWIo2RP57bwUJHrIH+DLhW7tAOJ6xHt
	5utUHf1xAQydLsePbahz294YXFus=
X-Gm-Gg: ASbGncvrEix12eUmvjFWhkYyItaaZPnYxhm1O5JPi64tG7RQ0PFAkoiKVkWdbsqkYbV
	PkoEyjK+obx8AryZ1WEWppph5iPKOa4EpCaQ9U4Xi8FOeDMSvmRJHcqCft8X1e1L0CO51dvJ5eg
	==
X-Google-Smtp-Source: AGHT+IG1h/GefZOV4P1HsTrp8FNSeQFVHto9fM1VgGfcvU3zZQIk8JhTxjoMYMD9GYGAM+8+jDBfjPdO0nrQTyxDfco=
X-Received: by 2002:a5d:588c:0:b0:38d:ddf2:afea with SMTP id
 ffacd0b85a97d-38f6e95f301mr354116f8f.13.1740077272198; Thu, 20 Feb 2025
 10:47:52 -0800 (PST)
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
Date: Thu, 20 Feb 2025 20:47:41 +0200
X-Gm-Features: AWEUYZl-KaoI55H_XPbgbTsfitI_Et-bq7N7i7G6bn1Yk0vigS5xOUWgbobezIQ
Message-ID: <CAPVz0n3GqWhMvos_dacsgEyiv3dV5_VnYR7YuNGe2XTLWe30jQ@mail.gmail.com>
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

And this did not resolve my issue. I managed to configure panel to
work, but it makes panel degrade.

With the flag above seq is better bridge_prep > panel_prep > bridge_en
> panel_en but this is still not enough.

It seems that my panel hw must be enabled before bridge_pre_enable,
preferable just before it is called, if I contain all in panel_prepare
I get no image with light halo in the middle. If I set hw
configuration in panel probe as a last step, it will be active and
panel degrades so I end up with flickering once image appears.

This partially is related to a 6.13 regression which causes bridge to
be pre/enabled extremely late, approx 75 sec from start and it skips
entire bootanimation.

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

