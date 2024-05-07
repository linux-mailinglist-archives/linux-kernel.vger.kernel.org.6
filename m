Return-Path: <linux-kernel+bounces-172523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 191D98BF30B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F4F1F21043
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535286249;
	Tue,  7 May 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lJ9ugwbB"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1D131720
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124951; cv=none; b=Y0gZhx6KX953sZsFfn4AgbjLpTFlJXLnjJjppFFCtrzsDp3kSe/b0CiAA2qaHgc/70JsvpIGefxIVdNfhrpY/1QGIna17Tec6gsd15sD3QPEgcfcYCJlNOqjxE4JplaVxr8xqwaq+Ri9niFVqWrCECu/lC38ENB/FVKbHFeLUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124951; c=relaxed/simple;
	bh=DRfh8mxfHC4v8J5+Q/B6rVWSMe0dXRR8yj2bIrilXPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxIPk9wX6grvlpHpSrpWeeXo0UZaYP/OADp0gSpR6WtWlSD5egy8Up3qB+W9p19HcbzibuIQvRdWs7s9IV6VG9k2nB+qzpN6/+b5JwB6SJEt8ZBtagH+nVa++6a4HGn3bGJjYKd1HET1RRLwCwEUHquOb2acGdSb58fnvwWF8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lJ9ugwbB; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7928c351c6bso336831785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715124944; x=1715729744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/ZrICv95N59yamAuqq9jxVRDu2Fdzxj2JJ/JZTWUpg=;
        b=lJ9ugwbB5+t8T5wUv/6sOuaDzXqF2PwlqMXbNFIxmFrwiTceCn+EINuJoLlHuw+fSG
         Gwxmj6jEbgt+A0HXpfujBw3WatarYe4XhJGSAKmWkkDByppU1BfSvuXXS+WiHBL4RjkE
         RZD4hFfCVjQHQflyY6dB3KrXcIvFeD3pZtvrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715124944; x=1715729744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/ZrICv95N59yamAuqq9jxVRDu2Fdzxj2JJ/JZTWUpg=;
        b=oVEAwl4p+BfL/3Ljfp2bHSmsbA/XMKtL/LPfHiVBq6guFo/gKcMeVPYfbdoMr9iEPl
         oHpn5cLOp/mtzaP4n4TnhuG3NnYUtDO/i4q0BSIzXKzKdVqQV9bsSZyYczRF3c3Az2Zx
         QJIEToXwrpPoWd4NwJ6jywWkN7I4hacv8NBHILiI1K2hE8RFhjYvD4lQhqyTJvCSnMnb
         EuBo2RffCxrAYy0COOSOGey1Z9SRGbUOzaTCLGxN+mCi+REb1XXRpFrh30WXM7PhHO0j
         0mP7pLgnXVdNvG1eQG9nf2iezaqUZpX7OjR94OzdS6/b2ijop9s/VSYvM5o27pOxdg0p
         74jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlK3J3zkIqUGFRUVG4zVvEeydnA3ssstuMhDMWgk5K/RA/KsUi/DT+nnnsvci92PqItiOAeC0mnBizXWT78E0Maw8lGz9MPcDnSUgS
X-Gm-Message-State: AOJu0Yw9I26PoQvG/E6orw3TOxZThC4uD5P79BMMhBL3hHxk6jte1w55
	yoHs6EPfYr1cOL6NDcDk/Vfps+kO831VKuoe0fFDg2vZ5TR+jScg4IMdhMqo2kVUcreMwgOTIDc
	=
X-Google-Smtp-Source: AGHT+IEr319rpYWmYVlvCPNEZ9Ay/v93R4Gvm+enIvQ3KHnjtl28po3M8ETheChHU18LeE71IbJYog==
X-Received: by 2002:a05:6214:d62:b0:6a0:ab13:e05a with SMTP id 6a1803df08f44-6a1514e4095mr17105646d6.25.1715124943844;
        Tue, 07 May 2024 16:35:43 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id u12-20020a0562140b0c00b006a10eee7023sm2688206qvj.74.2024.05.07.16.35.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 16:35:40 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43d361a2124so150231cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 16:35:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2cqKqVVPprTZHiiXat+wksbAhfbsuWVnUn/wLTZX57gJwXHV2OpFJI33FK0iBcDLRg5WY2PqhkAvCfhSN4i+SkEXrqAXZ6/o7WoSj
X-Received: by 2002:a05:622a:1b22:b0:43a:b186:634d with SMTP id
 d75a77b69052e-43dc2daf777mr1046151cf.10.1715124939463; Tue, 07 May 2024
 16:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-6-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240507135234.1356855-6-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 May 2024 16:35:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WR0o1Z4c4+GjrZw8mTJPZnP8uB_gWhX1QuOxxm4qhroA@mail.gmail.com>
Message-ID: <CAD=FV=WR0o1Z4c4+GjrZw8mTJPZnP8uB_gWhX1QuOxxm4qhroA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] drm/panel: himax-hx83102: Support for BOE
 nv110wum-l60 MIPI-DSI panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 7, 2024 at 6:53=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> +static int boe_nv110wum_init(struct hx83102 *ctx)
> +{
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +       msleep(60);
> +
> +       hx83102_enable_extended_cmds(ctx, true);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x2c, 0x=
af, 0xaf, 0x2b, 0xeb, 0x42,
> +                                        0xe1, 0x4d, 0x36, 0x36, 0x36, 0x=
36, 0x1a, 0x8b, 0x11, 0x65, 0x00,
> +                                        0x88, 0xfa, 0xff, 0xff, 0x8f, 0x=
ff, 0x08, 0x9a, 0x33);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETDISP, 0x00, 0x4=
7, 0xb0, 0x80, 0x00, 0x12,
> +                                        0x71, 0x3c, 0xa3, 0x11, 0x00, 0x=
00, 0x00, 0x88, 0xf5, 0x22, 0x8f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x49, 0x49=
, 0x32, 0x32, 0x14, 0x32,
> +                                        0x84, 0x6e, 0x84, 0x6e, 0x01, 0x=
9c);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xcd);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x84);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETVDC, 0x1b, 0x04=
);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_BE, 0x20);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPTBA, 0xfc, 0x8=
4);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSTBA, 0x36, 0x3=
6, 0x22, 0x00, 0x00, 0xa0,
> +                                        0x61, 0x08, 0xf5, 0x03);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xcc);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTCON, 0x80);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc6);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETRAMDMY, 0x97);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPWM, 0x00, 0x1e=
, 0x30, 0xd4, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK, 0x08, 0x=
13, 0x07, 0x00, 0x0f, 0x34);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPANEL, 0x02, 0x=
03, 0x44);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc4);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCASCADE, 0x03);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPCTRL, 0x37, 0x=
06, 0x00, 0x02, 0x04, 0x0c, 0xff);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_D2, 0x1f, =
0x11, 0x1f, 0x11);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0, 0x06, 0x0=
0, 0x00, 0x00, 0x00, 0x04,
> +                                        0x08, 0x04, 0x08, 0x37, 0x37, 0x=
64, 0x4b, 0x11, 0x11, 0x03, 0x03, 0x32,
> +                                        0x10, 0x0e, 0x00, 0x0e, 0x32, 0x=
10, 0x0a, 0x00, 0x0a, 0x32, 0x17, 0x98,
> +                                        0x07, 0x98, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP1, 0x18, 0x1=
8, 0x18, 0x18, 0x1e, 0x1e,
> +                                        0x1e, 0x1e, 0x1f, 0x1f, 0x1f, 0x=
1f, 0x24, 0x24, 0x24, 0x24, 0x07, 0x06,
> +                                        0x07, 0x06, 0x05, 0x04, 0x05, 0x=
04, 0x03, 0x02, 0x03, 0x02, 0x01, 0x00,
> +                                        0x01, 0x00, 0x21, 0x20, 0x21, 0x=
20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
> +                                        0x18, 0x18);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xaf, 0xa=
a, 0xaa, 0xaa, 0xaa, 0xa0,
> +                                        0xaf, 0xaa, 0xaa, 0xaa, 0xaa, 0x=
a0);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGMA, 0x00, 0x05=
, 0x0d, 0x14, 0x1b, 0x2c,
> +                                        0x44, 0x49, 0x51, 0x4c, 0x67, 0x=
6c, 0x71, 0x80, 0x7d, 0x84, 0x8d, 0xa0,
> +                                        0xa0, 0x4f, 0x58, 0x64, 0x73, 0x=
00, 0x05, 0x0d, 0x14, 0x1b, 0x2c, 0x44,
> +                                        0x49, 0x51, 0x4c, 0x67, 0x6c, 0x=
71, 0x80, 0x7d, 0x84, 0x8d, 0xa0, 0xa0,
> +                                        0x4f, 0x58, 0x64, 0x73);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0x07, 0x10=
, 0x10, 0x1a, 0x26, 0x9e,
> +                                        0x00, 0x53, 0x9b, 0x14, 0x14);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_E1, 0x11, =
0x00, 0x00, 0x89, 0x30, 0x80,
> +                                        0x07, 0x80, 0x02, 0x58, 0x00, 0x=
14, 0x02, 0x58, 0x02, 0x58, 0x02, 0x00,
> +                                        0x02, 0x2c, 0x00, 0x20, 0x02, 0x=
02, 0x00, 0x08, 0x00, 0x0c, 0x05, 0x0e,
> +                                        0x04, 0x94, 0x18, 0x00, 0x10, 0x=
f0, 0x03, 0x0c, 0x20, 0x00, 0x06, 0x0b,
> +                                        0x0b, 0x33, 0x0e);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xff, 0xf=
f, 0xff, 0xff, 0xfa, 0xa0,
> +                                        0xff, 0xff, 0xff, 0xff, 0xfa, 0x=
a0);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x01, 0x=
bf, 0x11);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK, 0x86);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_D2, 0x96);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc9);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0, 0x84);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xd1);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_E1, 0xf6, =
0x2b, 0x34, 0x2b, 0x74, 0x3b,
> +                                        0x74, 0x6b, 0x74);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0x02, 0x00=
, 0x2b, 0x01, 0x7e, 0x0f,
> +                                        0x7e, 0x10, 0xa0, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x02);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x02, 0x00=
, 0xbb, 0x11);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xff, 0xa=
f, 0xff, 0xff, 0xfa, 0xa0,
> +                                        0xff, 0xaf, 0xff, 0xff, 0xfa, 0x=
a0);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0xfe, 0x01=
, 0xfe, 0x01, 0xfe, 0x01,
> +                                        0x00, 0x00, 0x00, 0x23, 0x00, 0x=
23, 0x81, 0x02, 0x40, 0x00, 0x20, 0x65,
> +                                        0x02, 0x01, 0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00, 0x01, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x03);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xaa, 0xa=
f, 0xaa, 0xaa, 0xa0, 0x00,
> +                                        0xaa, 0xaf, 0xaa, 0xaa, 0xa0, 0x=
00, 0xaa, 0xaf, 0xaa, 0xaa, 0xa0, 0x00,
> +                                        0xaa, 0xaf, 0xaa, 0xaa, 0xa0, 0x=
00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc6);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x03, 0xff=
, 0xf8);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_E1, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc4);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x96);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc5);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x4f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
> +       hx83102_enable_extended_cmds(ctx, false);

It's not super important, but in panel drivers I converted to the
mipi_dsi_dcs_write_seq_multi() I checked the "accum_err" and did an
early return right before any mdelay() calls. This means that if any
of the above failed then we didn't waste time with the mdelay().

> +
> +       msleep(50);
> +
> +       return dsi_ctx.accum_err;
> +};

