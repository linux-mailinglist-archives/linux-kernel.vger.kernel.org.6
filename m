Return-Path: <linux-kernel+bounces-528316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6BFA4162D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2ACA16B5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172420AF7D;
	Mon, 24 Feb 2025 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI3RgGvQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A24414;
	Mon, 24 Feb 2025 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381852; cv=none; b=cr/Kq3ih4FueFnmKFB+NobwUfX7O4l2PTef4DvehYSWmHfd28xpiRrJB3JfGkW4vwQCVCZl0JPCTOdtGV3kkBoJOy5GEVYaujysMMuNPFQQlIdWK64XHDGB6Q1e+0yav15f7rhlppuyqwq317bdyER1E7vNOF6SJov0JPE2Sn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381852; c=relaxed/simple;
	bh=HcKu4yIRHuwzIxCrUkvvi908VVOmFvkI+QsjzNjrqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Epe7kFR/6jmfjrgkb/5DE+EoHS6yndpD1J3e5M3BQlliPNDf7UlKwVOsZP0GgnjUWVInoG48i9kXmk0JT7I+AQJBX4Idn2szRbxBKOJJ3onVaFt9koRjs6iGBzu065d8SX8Hj3ZiifqIMxMXO+aNtaZ5NVnfgouRwLu0wAcsLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI3RgGvQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f2f391864so2205274f8f.3;
        Sun, 23 Feb 2025 23:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740381848; x=1740986648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WttiCaJQvwomhQd1EI/0udfL207Jhy9knOnlIAkEOdg=;
        b=BI3RgGvQcP9ZK8F3ggmELg/cejbY4tKdqiYQz76g+Ia6RGpj88UAVFjeecRvCSQoBC
         ZQiB2qJ5izx0l/h9I4IUCahaUpnF+ZRDnuF9Q9Q1cgu3IF1mlugtfRfZ6ELr5oplOsIV
         /l9ygXJVzwYAKQZ9PduhZbpHmonkNxlnogI4AJ27ithRqJSI63KnqpgTWvQYc/YYASUp
         rnquKQl3ssYH6sAxl1K6HIu/b+ED6Q4ptnVShoOMJd49hXaEraSyI939EDasTeZfcs4/
         LmnFS9Q9/tgGqxr369p/7dWmH2Th/hTxHMuwOuR93R1vhT7mHWbPKGHmnB1GXJnrSDvU
         BFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381848; x=1740986648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WttiCaJQvwomhQd1EI/0udfL207Jhy9knOnlIAkEOdg=;
        b=IiqSiU/rAg42W6DkvDyLMlsHf9geyjbVHEwsyUaraF8/U3R+DiTk13g+kX9hpSRmoQ
         GJkBaoUYPftG5t8steFs9mf6Q26V9TNFWWvOeoz2YJIvsgKbztvZPl7z8TGPLgUM76Y8
         HLphPm6z1TiN6kOltnnpPDXkj2hsjKsRCL/QP+Xh8RxH34duFapwbfxiqp2pHZcCjBTp
         a/F4V8f0DeRS3zTIjYQo1GM2SUP0MLluNgsdNMIRVs+t6dr31kfKr5YxyuBWlR8DS5hK
         8R6wZEaaIQvBkZ2ZWKdp34JCNaiZyypxbIwuaeXeIE/5j9rsSFGHeOw6OFDBp7uwCZgI
         ceqg==
X-Forwarded-Encrypted: i=1; AJvYcCW/GDdJEmw8SrjS5QvA+zrJrSPdk0GdIy9OIkOWsaMk92OLn7Cw98P1taMFkteB9RRa5isDo36JsUzr@vger.kernel.org, AJvYcCWNs/Tj5Wbr661EiFmewLmHCGZNUiedQe121SlHrj8GMM0+g6XDhhMNBiFRXHWg+Nth+PIhEfGIkgxorTNz@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFQps6SqGyPwXkMfcHiIjGM/JuMyrieHPsyJqbWZx5Pb/7BGK
	ju/NXfwkKpuUSPVMtAyfSvmN+WABuFex0ZfKDJf0ZMeETiG3JHg1J4bw0/2nLqNPToEkkl8+fi7
	QZkx4ynAf6yKh9QXMG43ADsheI6c=
X-Gm-Gg: ASbGncsrAint3+Pc8PlRQloUEgNMZmmrPyz4f6AEPmKF6NWd/P+4t1WFKfHaVY2EYTy
	dP4TdKhVg2sqscgG+kPnDMD8iA3vq3BzWaU1ixvgvDk5cAUspyWF9M1dw0vtvc8J1KlsbWCTJgM
	aEw3L22Bm4
X-Google-Smtp-Source: AGHT+IHmuylp5CwLVA1IYwFWOeYvtiMnpzSvI/RJzNxXxIyoWRaTdnpaf8jYgz8j+JBsOyYGE4ztNWyFe7oWQUCwews=
X-Received: by 2002:a05:6000:4014:b0:38f:452f:9fa9 with SMTP id
 ffacd0b85a97d-38f7d1ff2b0mr4710935f8f.2.1740381848433; Sun, 23 Feb 2025
 23:24:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223153244.149102-1-clamor95@gmail.com> <20250223153244.149102-3-clamor95@gmail.com>
 <hz6amgqdmvr6tow5k3gj6n2bnaayejrdv6yhj6sjzs7v3dbjbv@3dcm45ydkkd3>
In-Reply-To: <hz6amgqdmvr6tow5k3gj6n2bnaayejrdv6yhj6sjzs7v3dbjbv@3dcm45ydkkd3>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 24 Feb 2025 09:23:57 +0200
X-Gm-Features: AWEUYZktBbGH02zZg4r3HvOntXY1RXWZ2G2bHw8JfAZ9BZfYMA_8iSUtK4-0qsU
Message-ID: <CAPVz0n0w6fNCkWzAD5qGUeeF3nEY-irvSQPxoB+AOvvKtx4XEQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm: bridge: Add support for Solomon SSD2825
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

=D0=BF=D0=BD, 24 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 04:10 Dmit=
ry Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Feb 23, 2025 at 05:32:44PM +0200, Svyatoslav Ryhel wrote:
> > SSD2825 is a cost-effective MIPI Bridge Chip solution targeting mainly
> > smartphones. It can convert 24bit RGB interface into 4-lane MIPI-DSI
> > interface to drive display modules of up to 800 x 1366, while supportin=
g
> > AMOLED, a-si LCD or LTPS panel technologies for smartphone applications=
.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig   |  13 +
> >  drivers/gpu/drm/bridge/Makefile  |   1 +
> >  drivers/gpu/drm/bridge/ssd2825.c | 821 +++++++++++++++++++++++++++++++
> >  3 files changed, 835 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/ssd2825.c
> >
>
> > +
> > +     if (buf =3D=3D MIPI_DCS_SET_DISPLAY_ON) {
> > +             /*
> > +              * NOTE! This is here since it cannot be called in bridge=
 enable because
> > +              * bridge pre enable and bridge enable have no gap in bet=
ween.
> > +              *
> > +              * Existing framework bridge-panel seq is:
> > +              *      panel_prepare > bridge_pre_enable > bridge_enable=
 > panel_enable
> > +              *
> > +              * Using prepare_prev_first was tested, but it switches s=
eq like this:
> > +              *      bridge_pre_enable > panel_prepare > bridge_enable=
 > panel_enable
> > +              *
> > +              * This will not work since panel hw MUST be prepared bef=
ore bridge is
> > +              * configured. Correct seq should be:
> > +              *      panel_prepare > bridge_pre_enable > panel_enable =
> bridge_enable
> > +              *
> > +              * Last two functions are swapped related to existing fra=
mework. I am not
> > +              * aware about method which allows that.
> > +              *
> > +              * Once there will be such method/flag, code below should=
 be moved into
> > +              * bridge_enable since it is basically a bridge configura=
tion completing
> > +              * after initial panel DSI sequence is completed.
>
> Will bridge_pre_enable -> panel_prepare (including
> MIPI_DCS_SET_DISPLAY_ON) -> bridge_enable work?
>
> The rest looks good to me.
>

I wish. I have tested that configuration already and panel did not
work. Problem here is that panel must be enabled before bridge.
Correct sequence should be:

Panel is enabled (power seq, reset, etc.) > bridge is enabled (power
seq, reset, initial configuration) > panel sends init DSI seq > bridge
completes setup with code below.

Basically this part of transfer should be called after last DSI
command is sent, but ATM I see no valid solution to this issue apart
this quirk (keep in mind that panel must be enabled before bridge so
drm_panel.prepare_prev_first will not work).

The most appropriate solution would be addition of atomic_post_enable
call just after panel or next bridge enable, this would ensure that
cases with bridge like I have could be properly configured. Though, I
really do not want to touch framework, since it never ended up well.
Or, alternatively, a flag for a bridge which can swap bridge enable
and panel enable, like drm_panel.prepare_prev_first does for
pre_enable and prepare.


> > +              */
> > +             config =3D SSD2825_CONF_REG_HS | SSD2825_CONF_REG_DCS |
> > +                      SSD2825_CONF_REG_ECD | SSD2825_CONF_REG_EOT;
> > +
> > +             if (dsi_dev->mode_flags & MIPI_DSI_MODE_VIDEO)
> > +                     config |=3D SSD2825_CONF_REG_VEN;
> > +
> > +             if (dsi_dev->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
> > +                     config &=3D ~SSD2825_CONF_REG_EOT;
> > +
> > +             /* Complete configuration after DSI commands were sent */
> > +             ssd2825_write_reg(priv, SSD2825_CONFIGURATION_REG, config=
);
> > +             ssd2825_write_reg(priv, SSD2825_PLL_CTRL_REG, 0x0001);
> > +             ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, 0x0000);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >
>
> --
> With best wishes
> Dmitry

