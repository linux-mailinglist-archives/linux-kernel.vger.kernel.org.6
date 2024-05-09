Return-Path: <linux-kernel+bounces-174701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69D8C132F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58342829B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88079DE;
	Thu,  9 May 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mAVPChBb"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237AB4C85
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272954; cv=none; b=BFTaeKQfSCLzcD9JG+sT0XP02mvb73Exx3+j0+gF99pe6c72jLrbOU44r1KPrmibUiDmJs30l4hb4mMED/c/w6pIVVXcKg4UWbJ3Cs93r3Q5I/erF5DbxLJ3zwE4f+k6vPrAtucBPWbqXdQtVni66UhJL8YNWqrIIF4g6HaN//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272954; c=relaxed/simple;
	bh=k2BKqSOY6l7Nc5TSwWkEnVQPitaP0nHTC+k1JT9tQVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9/OQZ0sEXQrT9zzxGeSdqcQU1rRKYNpmGh8aRPIgk9wLTHVqBTAWGziEWOpc44Gfg9oXHjWJNV2izRD8MokSf2TSCxLGkMjH3HwzCk6iSUKQItO9iqKCQTf+Vu3tfc0TQChuBw89XkQj3WfsmMwmq0ZtqLAImhtuf0eQtgjNxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mAVPChBb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792b8d989e8so82012985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715272949; x=1715877749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jylhP92/UnOH4NiMwyBD6WrtK+UqXE3bUpoY76z2bU=;
        b=mAVPChBbrWlLVCss86MT+ZDcUPxcE4LJiceVG7lSIGJEQ/u1wH+D34weln0fi8OKTq
         lAJggDuDBqJRq3ndBJjgFiHxIW8KgLSFVgNczD+WWhSrePeghGHvzW+9SVNsvEzOInRV
         OWr7xV7kZB4+H0v0qm2exJ+yuqRAWLDE1aaJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272949; x=1715877749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jylhP92/UnOH4NiMwyBD6WrtK+UqXE3bUpoY76z2bU=;
        b=Guf+pFB34l6V8Ua9r3buuAow48FSW4kqu03Dc9eS9KWLrxE8ffbTvOW0tnt92OsrIy
         JVXKhbVYt8jzdy4gjeS1ifY0Tu1E8bXib1a1whs8p0LZn2WJd8oQJ62jMeyUadqsJltX
         3Pho7ntUN4ecsiMLYAMTSzKXA5kmDJRDe2lzzsFZ03zppiGf6mueSqEGEIvMGpmWbUqb
         6qC7HgSqXoT5Sp4o2iUqJvlq9sC9AOK7zXB9LDaiJjayX1XZRKHRwmfr2/pQbnHlP/94
         yd7Rl5yRw8Rb5kEGdBG+m/Uh/hbCFtDJm9dYdyrtZ3z25HOHsx1oRcULA7YhmajBUWg8
         SB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWw5zi6mVl74xrtE5rfeHXPqUY81f1THIrHy/sUJWgu73FGd1dieJOLc5nBve770WYX0RJO8m7wFQh/sw+busmPR+d3IZ/UmNUE3vyP
X-Gm-Message-State: AOJu0YwHYcpAnnlUHqfC8sjiVpzO3MMjBafhsaW45BDTLKDsjUkc57dJ
	80Xiq+vRO4agAsDfxIoC4iJ+Wdrehb/6YzyRX6IbCPZLpBKagEavW3LvyALwqHfJjSniTb2G/0j
	IEHX7
X-Google-Smtp-Source: AGHT+IHlC23lt30k7ZNqBS+vRUJWI6/1Zf8bG8+clZFsKCjTRNcFOoye9Afh/PkL82ga9mRzbPiQlA==
X-Received: by 2002:a05:620a:4502:b0:790:92bc:7a57 with SMTP id af79cd13be357-792bbe6749cmr506517885a.36.1715272949605;
        Thu, 09 May 2024 09:42:29 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc3dbsm84457185a.96.2024.05.09.09.42.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 09:42:28 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-439b1c72676so1101cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 09:42:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtPljECp1Cl60ji18X+YXBKI29k0ulIOBr2171e4CePPT00tNtCnqjjJkTx2zfhUHb+KL/oCkY3/OymhB7enn38tayCMrhBC4DsXEm
X-Received: by 2002:a05:622a:1f10:b0:43d:f77b:7aa2 with SMTP id
 d75a77b69052e-43df77b7cc1mr2148531cf.6.1715272947626; Thu, 09 May 2024
 09:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509015207.3271370-1-yangcong5@huaqin.corp-partner.google.com>
 <20240509015207.3271370-8-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240509015207.3271370-8-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 9 May 2024 09:42:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vd34kBy4meaqqYECQKaT1=XcCFdq3qaU5n=YBWVAVi-Q@mail.gmail.com>
Message-ID: <CAD=FV=Vd34kBy4meaqqYECQKaT1=XcCFdq3qaU5n=YBWVAVi-Q@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] drm/panel: himax-hx83102: Support for IVO t109nw41
 MIPI-DSI panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 6:53=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> +static int ivo_t109nw41_init(struct hx83102 *ctx)
> +{
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +       msleep(60);
> +
> +       hx83102_enable_extended_cmds(&dsi_ctx, true);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x2c, 0x=
ed, 0xed, 0x0f, 0xcf, 0x42,
> +                                    0xf5, 0x39, 0x36, 0x36, 0x36, 0x36, =
0x32, 0x8b, 0x11, 0x65, 0x00, 0x88,
> +                                    0xfa, 0xff, 0xff, 0x8f, 0xff, 0x08, =
0xd6, 0x33);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETDISP, 0x00, 0x4=
7, 0xb0, 0x80, 0x00, 0x12,
> +                                    0x71, 0x3c, 0xa3, 0x22, 0x20, 0x00, =
0x00, 0x88, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x35, 0x35=
, 0x43, 0x43, 0x35, 0x35,
> +                                    0x30, 0x7a, 0x30, 0x7a, 0x01, 0x9d);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xcd);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x84);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETVDC, 0x1b, 0x04=
);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_BE, 0x20);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPTBA, 0xfc, 0xc=
4);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSTBA, 0x34, 0x3=
4, 0x22, 0x11, 0x22, 0xa0,
> +                                    0x31, 0x08, 0xf5, 0x03);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xcc);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTCON, 0x80);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xd3);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTCON, 0x22);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc6);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETRAMDMY, 0x97);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPWM, 0x00, 0x1e=
, 0x13, 0x88, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK, 0x08, 0x=
13, 0x07, 0x00, 0x0f, 0x34);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPANEL, 0x02, 0x=
03, 0x44);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc4);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCASCADE, 0x03);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPCTRL, 0x07, 0x=
06, 0x00, 0x02, 0x04, 0x2c,
> +                                    0xff);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0, 0x06, 0x0=
0, 0x00, 0x00, 0x00, 0x08,
> +                                    0x08, 0x08, 0x08, 0x37, 0x07, 0x64, =
0x7c, 0x11, 0x11, 0x03, 0x03, 0x32,
> +                                    0x10, 0x0e, 0x00, 0x0e, 0x32, 0x17, =
0x97, 0x07, 0x97, 0x32, 0x00, 0x02,
> +                                    0x00, 0x02, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP1, 0x25, 0x2=
4, 0x25, 0x24, 0x18, 0x18,
> +                                    0x18, 0x18, 0x07, 0x06, 0x07, 0x06, =
0x05, 0x04, 0x05, 0x04, 0x03, 0x02,
> +                                    0x03, 0x02, 0x01, 0x00, 0x01, 0x00, =
0x1e, 0x1e, 0x1e, 0x1e, 0x1f, 0x1f,
> +                                    0x1f, 0x1f, 0x21, 0x20, 0x21, 0x20, =
0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
> +                                    0x18, 0x18);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xaa, 0xa=
a, 0xaa, 0xaa, 0xaa, 0xa0,
> +                                    0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0, =
0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGMA, 0x04, 0x04=
, 0x06, 0x0a, 0x0a, 0x05,
> +                                    0x12, 0x14, 0x17, 0x13, 0x2c, 0x33, =
0x39, 0x4b, 0x4c, 0x56, 0x61, 0x78,
> +                                    0x7a, 0x41, 0x50, 0x68, 0x73, 0x04, =
0x04, 0x06, 0x0a, 0x0a, 0x05, 0x12,
> +                                    0x14, 0x17, 0x13, 0x2c, 0x33, 0x39, =
0x4b, 0x4c, 0x56, 0x61, 0x78, 0x7a,
> +                                    0x41, 0x50, 0x68, 0x73);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0x07, 0x10=
, 0x10, 0x1a, 0x26, 0x9e,
> +                                    0x00, 0x4f, 0xa0, 0x14, 0x14, 0x00, =
0x00, 0x00, 0x00, 0x12, 0x0a, 0x02,
> +                                    0x02, 0x00, 0x33, 0x02, 0x04, 0x18, =
0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x01, 0x=
7f, 0x11, 0xfd);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK, 0x86);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0, 0x00, 0x0=
0, 0x04, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0x00, 0x0=
0, 0x00, 0x00, 0x00, 0x00,
> +                                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0,
> +                                    0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0, =
0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0x02, 0x00=
, 0x2b, 0x01, 0x7e, 0x0f,
> +                                    0x7e, 0x10, 0xa0, 0x00, 0x00, 0x77, =
0x00, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x02);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPTBA, 0xf2);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK, 0x03, 0x=
07, 0x00, 0x10, 0x79);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xff, 0xf=
f, 0xff, 0xff, 0xfa, 0xa0,
> +                                    0xff, 0xff, 0xff, 0xff, 0xfa, 0xa0);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0xfe, 0x01=
, 0xfe, 0x01, 0xfe, 0x01,
> +                                    0x00, 0x00, 0x00, 0x23, 0x00, 0x23, =
0x81, 0x02, 0x40, 0x00, 0x20, 0x6e,
> +                                    0x02, 0x01, 0x00, 0x00, 0x00, 0x00, =
0x00, 0x00, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x03);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xaa, 0=
xaa, 0xaa, 0xaa, 0xaa, 0xa0,
> +                                    0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0, =
0xff, 0xff, 0xff, 0xff, 0xfa, 0xa0,
> +                                    0xff, 0xff, 0xff, 0xff, 0xfa, 0xa0, =
0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0,
> +                                    0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0, =
0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +                                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc6);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x03, 0xff=
, 0xf8);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_E1, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_D2, 0xff, =
0xff, 0xff, 0xff, 0xff, 0xff);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc4);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x96);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc5);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x4f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
> +       if (dsi_ctx.accum_err)
> +               return dsi_ctx.accum_err;

Since this is a new panel you're adding support for and there's no
excuse that we don't want to change the old command sequence, it seems
like you should add the call to:

hx83102_enable_extended_cmds(&dsi_ctx, false);

If for some reason that would be a bad idea, let me know.

-Doug

