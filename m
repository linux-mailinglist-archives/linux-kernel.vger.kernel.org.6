Return-Path: <linux-kernel+bounces-382495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21AA9B0EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF101F2746C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C814620D512;
	Fri, 25 Oct 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsYx+8AH"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B910A0E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884448; cv=none; b=mJS8M4fCEPYc8QO+o6BF7w3OWdfIBVQvST8O5J08ve4PYqAWG02I2ACJKlqGwROk1yM/N8N3e7u1AAE7jmbSmJiMMk3VR5i3FcGpZAGqHksNsbgQ7wkIo4dRm17Q0H7yZqosxuw3i9vdOdXyYNrn0cojSoSeD3e2Tk8fzIe1eS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884448; c=relaxed/simple;
	bh=JOSJ1m84HeGCMFspvLRHJwXEqwtSZwl+jf5K6cEB+KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zlk/4OnyyEZo8CzJkh0DzWMLPvgEOpJkztDQyVbop/tgPI/zTlc8TvY2lElCfXDUM/+pZ6T9z7i7o8nmRx8OWHrL1Kxfu1WHJZymqctD0Vf0XFAh87Dl/u68e1Q29NpkFIzc5PJ63YKujs+umTPbsZkMWEG3/7yVc2owAwOfeNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FsYx+8AH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e3f35268so3163300e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729884444; x=1730489244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pwYpRZq9PPWTjqEmVLXgvWDDt4y6jIawQPnKi8Ky4g=;
        b=FsYx+8AHDU/N1EmlJvmSTpo5C0OpQ0zhNFfzGkC+pLMwvra/GCA52t1zE758giVF4a
         MhfpqLlFktzZTs/vIDzHKaU/qKraotaUo5eLyPgffUzpQllFHDyvEq6WMDborAB+a9GU
         1ECqsumeL9B7zzkJXzfXgC3fE/EACJhU/uIjxzjHdrfvnkLOZrT1H76duqU6meiPdFA4
         hwiPclpipoDKbjLDVjrVpMcbwl+tVG630Qh3TXkPV54JSmFPmNS0aaeVH/r+vA2IxN8s
         rxO7jEjHOLjMul5PQcz5hFHFVP+2O4FVZycgSsDbMFDQEmGUonHRyJbaNv/9MPxZP5rx
         SBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884444; x=1730489244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pwYpRZq9PPWTjqEmVLXgvWDDt4y6jIawQPnKi8Ky4g=;
        b=SeY/bxHillibKL6DbuDDV5wFLBI5lXM+ijBW3RbLf/h9WPBSqobLSZPouyv+sT+xp8
         PfjQiUX+/hatfwGUL97EKxwuzheqjEA1Dq2ny0kVUoFFYJZSJDRQoxdTDahnpXHNVmwD
         ++mbtU/uyVE9AHNTnk5VPgFJLzsRaFlzoALYImkDMbDGjIdBO8Y9cJj3vrGuyspFTIxZ
         nvjTT4cPZNzePwrbUVIrilrF7/4kbCYs6UPLPIJQw2aBZQF2W2JPKVnz0Pf6O+4xQGrV
         Ni3tIfwTrfNNX9LxWUb40SqXIwVJ3Qh7Gu+nvRNbEZeHNR5rXO2Wkqgk7HNiNhwAWGZv
         tyaA==
X-Forwarded-Encrypted: i=1; AJvYcCW1eKQUEf/9smaJHXxH2Lj2JwSDqQd+Fs8J/SvYzfaSaDpcQZSDIvcYSEV9RovcVq5/4Nq+6EzlcskOADA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3i6tdKO471F0tAI+DjSmf/DI3IghNCfmUNiBx4306B/R0PKk
	oTB3vOYf5ARd1lm2nA6LKVasKWCJAKn7WYd/RICXJEfr4WvoAWsrA31gI5vSCFmAjg1B/kntg1o
	56ASCsStHNq91K01OdHyrSH8zEL0/89Pz70FwDA==
X-Google-Smtp-Source: AGHT+IEU/O6qCLZRAQIxMa9TAuHKrJb2KzdM54UvELz6OzL/NUpAjy4OtKxqFoLA2zXlLI9eK2wTMT28bKNPV/O7PFo=
X-Received: by 2002:a05:6512:31c6:b0:53b:1fe4:3fb9 with SMTP id
 2adb3069b0e04-53b34a2d88emr154603e87.49.1729884443592; Fri, 25 Oct 2024
 12:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729738189.git.jahau@rocketmail.com> <594cc48e98b551cfeeba0fb475755a41b83283a0.1729738189.git.jahau@rocketmail.com>
In-Reply-To: <594cc48e98b551cfeeba0fb475755a41b83283a0.1729738189.git.jahau@rocketmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 21:27:11 +0200
Message-ID: <CACRpkdYOgymfjOD3cAMXt7u8SH0vvVzwt75gamJvXuyyjdsMPw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm/panel: samsung-s6e88a0-ams427ap24: Add
 brightness control
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakob,

thanks for your patch!

On Thu, Oct 24, 2024 at 5:18=E2=80=AFAM Jakob Hauser <jahau@rocketmail.com>=
 wrote:
> +static const int s6e88a0_ams427ap24_br_to_cd[NUM_STEPS_CANDELA] =3D {

(...)
> +       /* brightness till, candela */

Brightness to candela conversion table? Edit comment?

> +static const u8 s6e88a0_ams427ap24_aid[NUM_STEPS_AID][SEQ_LENGTH_AID] =
=3D {

If you know that the sequence 0xb2, 0x40, 0x08, 0x20 means "set AID"
(or is it AOR??) you can #define

#define S6E88A0_SET_AID 0xb2

Then make a small buffer:

u8 set_aid[5] =3D { S6E88A0_SET_AID, 0x40, 0x08, 0x20, 0x00, 0x00 };

then you can strip the first three bytes from the entire table,
just copy in the two relevant bytes into set_aor[]
and send that.

> +static const u8 s6e88a0_ams427ap24_elvss[NUM_STEPS_ELVSS][SEQ_LENGTH_ELV=
SS] =3D {
> +       { 0x28, 0x14 }, /* 10CD ~ 111CD */
> +       { 0x28, 0x13 }, /* 119CD */

Command 0xb6 is
#define S6E88A0_SET_LVSS 0xb6

Same comment: just define
u8 set_lvss[2] =3D {S6E88A0_SET_LVSS, 0x28, 0x00};
copy the second byte into the command, this becomes
an array of single bytes.

> +static const u8 s6e88a0_ams427ap24_gamma[NUM_STEPS_CANDELA][SEQ_LENGTH_G=
AMMA] =3D {
> +       /* 10CD */
> +       { 0x00, 0xc8, 0x00, 0xc4, 0x00, 0xc5, 0x8c, 0x8a, 0x8a, 0x8c, 0x8=
b,
> +         0x8c, 0x87, 0x89, 0x89, 0x88, 0x87, 0x8c, 0x80, 0x82, 0x88, 0x7=
b,
> +         0x72, 0x8c, 0x60, 0x68, 0x8c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0 },

This array looks fine though, it seems to be all unique gamma calibration.

> +static int s6e88a0_ams427ap24_set_brightness(struct backlight_device *bd=
)
> +{
> +       struct s6e88a0_ams427ap24 *ctx =3D bl_get_data(bd);
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
> +       struct device *dev =3D &dsi->dev;
> +       int brightness =3D bd->props.brightness;
> +       int candela_enum;
> +       u8 b2[SEQ_LENGTH_AID + 1];
> +       u8 b6[SEQ_LENGTH_ELVSS + 1];
> +       u8 ca[SEQ_LENGTH_GAMMA + 1];

Rename them to something like my suggestions so we understand what it is
all about. It seems the infrastructure for what I suggested is mostly alrea=
dy
there.

See comment above how to modify arrays to contain stuff that is always
the same.

> +       /* get aid */
> +       b2[0] =3D 0xb2;

Use a define per above.

> +       switch (candela_enum) {
> +       case CANDELA_10CD ... CANDELA_105CD:
> +               memcpy(&b2[1], s6e88a0_ams427ap24_aid[candela_enum],
> +                      SEQ_LENGTH_AID);
> +               break;
> +       case CANDELA_111CD ... CANDELA_172CD:
> +               memcpy(&b2[1], s6e88a0_ams427ap24_aid[CANDELA_111CD],
> +                      SEQ_LENGTH_AID);
> +               break;
> +       case CANDELA_183CD ... CANDELA_300CD:
> +               memcpy(&b2[1], s6e88a0_ams427ap24_aid[CANDELA_111CD + 1],
> +                      SEQ_LENGTH_AID);
> +               break;
> +       default:
> +               dev_err(dev, "Failed to get aid data\n");
> +               return -EINVAL;
> +       }
> +
> +       /* get elvss */
> +       b6[0] =3D 0xb6;

Use a define per above.

> +       if (candela_enum <=3D CANDELA_111CD) {
> +               memcpy(&b6[1], s6e88a0_ams427ap24_elvss[0], SEQ_LENGTH_EL=
VSS);
> +       } else {
> +               memcpy(&b6[1], s6e88a0_ams427ap24_elvss[candela_enum - CA=
NDELA_111CD],
> +                      SEQ_LENGTH_ELVSS);
> +       }
> +
> +       /* get gamma */
> +       ca[0] =3D 0xca;

#define S6E88A0_SET_GAMMA 0xca

> +       memcpy(&ca[1], s6e88a0_ams427ap24_gamma[candela_enum], SEQ_LENGTH=
_GAMMA);
> +
> +       /* write: key on, aid, acl off, elvss, gamma, gamma update, key o=
ff */
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x5a, 0x5a);

0xf0 is clearly an unlocking key as per comment in the previous patch.

> +       mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, b2, ARRAY_SIZE(b2));
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x00);

0x55 is MIPI_DCS_WRITE_POWER_SAVE in <video/mipi_display.h>

> +       mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, b6, ARRAY_SIZE(b6));
> +       mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, ca, ARRAY_SIZE(ca));

> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf7, 0x03);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);

Clearly this locks the L2 access again.

Yours,
Linus Walleij

