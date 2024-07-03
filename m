Return-Path: <linux-kernel+bounces-239512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E623D926176
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245331C2298F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC117967E;
	Wed,  3 Jul 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oy2yvwqr"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0118EB8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012224; cv=none; b=WpSyUcbuCw+EYeCkSJxNqLuVEh5JQ0+G/5ygY7Y9YPpxK5YHp8Zyd9GdBIu5/MMnjnADsq2+tYzX/VFPGyi+LG7MxWLYgoQOHbTW/IWTRHAYfMZj5S3hOIR4dw+vLD+3e0nyH+tsZ3aF6sHJiAlSqzke3PUTVnhhfWuIYSwpyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012224; c=relaxed/simple;
	bh=+6hclvf7yvoRrs1xdE0WelBIDAexx3qJiuVoLAxjsGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCiQRw6KzsrYafq+1OcNZAHMPBC/r0WNDtncJOMSynoD+eYZIv4CxxR4wBn+whRXfIm6x38/0fX/96WEHbMP/wzlzmHQTYk1JGz/DP/RbbaxxmnGT6Rt+nZPeRhqFMRLxMQDNKSG2y0liXU8d+gVyTCvAHwtJ38SnA8/vPvOxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oy2yvwqr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee794ec046so16554581fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720012221; x=1720617021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYNKyC7r0lY93w+1DA2lEanB3Pazmm2DrUBGKs4HZ0o=;
        b=oy2yvwqrAK6JETmusojCN8LJu+CSRqHzg9I7tCVJy2scyEXGLGun+RRv3Zt55lmvzi
         68rnZPg9WScq8Oq24if+t5a/OFt3M6NITyFibdlGhGOfO0za7F5eA1OpeBmQxeH/pyzJ
         N2eGW2+FzlaTifudBzgdl0/tkdjU2Buo15NK+XVgI9ID6XvI11M9stO6F6Hvvj5xLi9t
         y5+Fagd2y2npas6DsDReBmAoEKWT9zdmUJRZzIafPAsR1Z9v+3SSjq3Cef2mO996MwTH
         ONFXM7M5tcylYTVGAilCzMvDU1L7UNxZTCNYTvJkCjn7kq9Xd5YP8DewFZ/jHlzMWK7V
         a7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720012221; x=1720617021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYNKyC7r0lY93w+1DA2lEanB3Pazmm2DrUBGKs4HZ0o=;
        b=NjK1jnzr+M3KN4IMHSDnbsClbakC3r8W32be+TMZrnUoXdabjnZYNB2hNWgl0erfb2
         28qIyF0GEfgbBq7CMteeWOA8opuaVBnOWaFmhh/UGbc6b1R60YkMK2fCHuIupiaqmU4I
         ZK7TH4FZVR0qEgJjWwaKLtxnoNDevmHqAm6CVf+KdmpqpwbwBG9jnk9DlmhnTISCaab6
         DXOJFKAKAeymDuA4FOWVlBXQr4KAr/tmwA8CC1kH23YHagqhh3Ve5JX7k/btmjRpU3eZ
         5FswBJ7BuxlUKwUoCi7MDVP3ARFffATc55VUYOQkjRziiCwRSoSihqS52IglcB0burc/
         jBpA==
X-Forwarded-Encrypted: i=1; AJvYcCUs/8Yky4w3p/y6yS2L/3CXNAVPhL98AT172MtPTRAgO0a2zywvswQKikblEdiTyH8W1XnwoQ55AxevdPD/AhqNRxzwIdctwpZROQdF
X-Gm-Message-State: AOJu0YwADJ7gfBXcMm12848fnWMStzv8bMg1kjgNau/qgUnlQubOa9sY
	dPmcjHCXgY25Yjpnc0JO3kaeQrH4UJfLushPYPB3maE46Oqlvz/dbosgrXt3MES9xs98Q993lXe
	JnwpOSBJlg/G+yYLJ3p4eJE33Tsi/m4MhYbbTxQ==
X-Google-Smtp-Source: AGHT+IF2tkib/oC3Qiv+r3vhOaGqxlEBIzZGIynLySjW51phBdlrQV9rmjY1VJWS6M/DGM6KhRIAswSjPmSVX6S2YU4=
X-Received: by 2002:a2e:b5cb:0:b0:2ee:8555:473e with SMTP id
 38308e7fff4ca-2ee85556516mr7890711fa.46.1720012221282; Wed, 03 Jul 2024
 06:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com>
 <20240702130138.2543711-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240702130138.2543711-3-yangcong5@huaqin.corp-partner.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 15:10:09 +0200
Message-ID: <CACRpkdY+nuSWz7rnVVUpF_mZOfDUb_6fgoJpnG2Pt-+AGLqt0g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: jd9365da: Support for Melfas
 lmfbx101117480 MIPI-DSI panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	dianders@chromium.org, swboyd@chromium.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, 
	lvzhaoxiong@huaqin.corp-partner.google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:02=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:

> The Melfas lmfbx101117480 is a 10.1" WXGA TFT-LCD panel, use jd9365da
> controller, which fits in nicely with the existing panel-jadard-jd9365da-=
h3
> driver. Hence, we add a new compatible with panel specific config.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

This is certainly OK
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> +static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
> +{
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard->dsi =
};
> +
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);

Until this point *all* displays have the same init sequence, what about
a follow-up patch that start to break things that are always the
same into helper functions?

These sequences all have a lot of the same magic bytes, so if
you guys have a datasheet for this display controller then start
adding gradually some #defines for the e0, e1, e2 etc commands
please.

Yours,
Linus Walleij

