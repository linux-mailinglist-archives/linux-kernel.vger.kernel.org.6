Return-Path: <linux-kernel+bounces-401256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 524399C17CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81BDB2451B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9B1E1051;
	Fri,  8 Nov 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqZ47e3J"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901C1E0E10
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054082; cv=none; b=qFYUYhxndXJGa07YprpUED64wmWB9Wcr22AbwZ+njAn4nwYVcmm86hEsHDm9UZHl3NagZIPYEol0lht8Zzcq0TBdPNvlPeyACLTQdZGS0phlfWalBusnJUX2iRfcAxiw1eVKv9LVSI6CqD4qEWWMRYY8Pq3sBuoYfEINm5RESVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054082; c=relaxed/simple;
	bh=eWjhfFl0lxuSZTAzDN6LrwZdoPNmukVNi4I1AQ4yInM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw1UGdSiwttWPgRjNNsqvdVCo1Mtzp95hFtUDXKIYjc/r70EVmnYjfofbGu8g8ltrBCp0TTaYT61FbT/ZqLBoZ1zxFxX53WM5lu7ht0XCwv3zdTCVz1VP1yu0f/BBvnqHnw30/eeXcWFtLfQMJJ1/I3kBHsvrkQrP4ofhLoIA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WqZ47e3J; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539fe76e802so1938051e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731054079; x=1731658879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4o7fhe2V5dd+UE3dA/uAT0KHoDiGtLUhf89NGPnqv0=;
        b=WqZ47e3JDJW0cVbUiikMLQJF947kEb9C96g9AMeL08ZaL5TXYfRJud4fKZWxYDu2Dx
         3HVpRvYhUgGw07OX30bSleJWjtWuj+MoaeaO4sxZ3PSfwEo6Ibb+C67wqN1WkNgt2ko8
         tCeKqFk0JkCxaCrpTihYNPkZwoJS4hUK06A7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054079; x=1731658879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4o7fhe2V5dd+UE3dA/uAT0KHoDiGtLUhf89NGPnqv0=;
        b=eZCrDzpA+7TeMFEkN4JxGdG+3HueH673aasG672byfJJUBjoWAzkH2iybFcGV1kWZs
         sIzhqpNTF0qeZT3rtHF5lv7Q22c7ny+Rnd8Oq1a+uVsdg+1YeHdrJ6kkLZDmZLjSfvRk
         ICVqq/gws44saycN+s2IwUW7f3KecJFi5CACOAPh7E3K/t4KSg/jyNly7JG/v4YUmndI
         UaJot95i/7ML36N5llfO0wUuIKQPLYdVbdhjTI2zhJcaK//ZykVkk4Et8JptMiYBHNok
         45+x/5rP2sHouSHO1NuA4bpwD0kMsFiWwGloJ+hfoJdZ8/dlsmWJn4QMXqmmU3xJ7eEt
         V7dw==
X-Forwarded-Encrypted: i=1; AJvYcCWocztIi5qXgLCB4ptOiYeskv7w3OYBpWU6Lht8x3Cp52t1eddQq8hfY2MkOXPYDnaAiDuTKGP+f+zJqes=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+eTiKIQ2PXLZXJ4rz3K/mTHZcZufR7McrRhrk9uU2SW6ka3E
	lZILdkxUjycbQR9q8ktbFLlP/9A16WUG0yr0GFEuD79k6dZeT519XIy/KqSeJA+gO0CS64e4wxB
	IGYoY4HA7ZByBek4z5EoXBgEVL1i2wXalyCWZ
X-Google-Smtp-Source: AGHT+IE2S4gjvQOpSK8kJaaKxLV5rdskh4etefXYjl17eLQ1scFoBJFDNNCqeEcFChM7or3BIVTeHmM7tSYZlf0ID34=
X-Received: by 2002:a05:6512:ac3:b0:539:e513:1f66 with SMTP id
 2adb3069b0e04-53d862fe1cfmr903159e87.37.1731054078864; Fri, 08 Nov 2024
 00:21:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-lvts-v1-1-eee339c6ca20@chromium.org>
In-Reply-To: <20241108-lvts-v1-1-eee339c6ca20@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 8 Nov 2024 16:21:07 +0800
Message-ID: <CAGXv+5EOcg0pQxj=iOn_ff8-t6pyGKwemA9mdn=VCpxg6Uzt+g@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Switch to IMMEDIATE_MODE
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 2:51=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> Currently, MT8192 cannot suspend with FILTERED_MODE. Switch to
> IMMEDIATE_MODE will fix this.
>

Probably should have a Fixes tag.

Also, Nicolas previously reported that the threshold interrupts don't
work with the immediate mode [1], which is why filtered mode was used
in the final version.


ChenYu

[1] https://lore.kernel.org/linux-mediatek/37680c5e-e61c-410b-b48d-82991420=
0e4a@notapiano/

> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 1997e91bb3be94a3059db619238aa5787edc7675..daad52f14fc03d0c4131f2ffd=
f3eb6b49a4a43d0 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1541,7 +1541,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
>                 },
>                 VALID_SENSOR_MAP(1, 1, 0, 0),
>                 .offset =3D 0x0,
> -               .mode =3D LVTS_MSR_FILTERED_MODE,
>         },
>         {
>                 .lvts_sensor =3D {
> @@ -1552,7 +1551,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
>                 },
>                 VALID_SENSOR_MAP(1, 1, 0, 0),
>                 .offset =3D 0x100,
> -               .mode =3D LVTS_MSR_FILTERED_MODE,
>         },
>         {
>                 .lvts_sensor =3D {
> @@ -1567,7 +1565,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
>                 },
>                 VALID_SENSOR_MAP(1, 1, 1, 1),
>                 .offset =3D 0x200,
> -               .mode =3D LVTS_MSR_FILTERED_MODE,
>         }
>  };
>
>
> ---
> base-commit: 906bd684e4b1e517dd424a354744c5b0aebef8af
> change-id: 20241108-lvts-f7beb36efc59
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>
>

