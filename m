Return-Path: <linux-kernel+bounces-297064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F395B286
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D901C21975
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFD217B401;
	Thu, 22 Aug 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="il5oJpKt"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9316A943
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320933; cv=none; b=JxLDaA1QJuHIrrYkTI4hgN6NeosqZwjHbGCi7LPgnvnpwbUCPkfGDYDyrUeS0qn/JIbxhkDSY9aBr8Csgd1ilF6x+Vy9IA/GGYKd2rIq9f9OSAX4lVvFsNAv2xuECYsSjdJyMB3tCR3t1Ft0YVXeJ+JKzfAD9ycR4gFahGaXPWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320933; c=relaxed/simple;
	bh=V4OaQBUenX/H1bRY8VHxTXuWvHGWj6WrQK1PRfSRnkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dd9wWZrOpQQ5/1OVsVnCFlWX083EP+k/ETKwhV+VMOKnSoMpw5zRFfKVhPbIwelF0965fyf9j25CItkrWIDb7dYF81TrxJWzzjIuxlkXQv5p+z0ZdqRzxWBCM+iMH7Jy1Wchqhg1UkAAlLtrVgMcDsUzm4TkBB3SrNyvdxZT4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=il5oJpKt; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so470464a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724320931; x=1724925731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnbOQjCg+wnSShYnMDRJ5uxlxTbiQhZfM0vBsJUAup8=;
        b=il5oJpKtilAdmkLIcaPyIbIW5tOAv5UMyq9A+itB9FJW0q3xt0VFELtsYQ9X2BlOWD
         21hYvfad8OTXOC2CtcvaOGIWdUSJ9c/actGqG8MWZa0dAw8ph0CD07sFO80SgOBdq27N
         K6I5FKq/cNi24UC54SLotmXNbHLyHLq7mlqlj1q/JU7X2yDlVbCkTVblV/MkhCvdEbyQ
         7Sct/sb2UwJg8JjK8QjahfDsluMK7Y6fz1yx2cj5dIK5WyLhZ2iVOJ864dzPAoJYnLeb
         I/ttXo0krUO0oXchEJpIHY5enIUG9ErQvRKO78OjHSD6HVEt/J5RfwoL5e2evB7j8foY
         +jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320931; x=1724925731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnbOQjCg+wnSShYnMDRJ5uxlxTbiQhZfM0vBsJUAup8=;
        b=h3dNR37Xmzjiwktp7oKI+IJbYDNTuKC6R/kDRHdHBPRcjjpcXKx7cgP1GokrLlqO5w
         yd2nGcuf71BW0bKsTSIuT7hXc8+VKbUeJeg5d9+K2/7b0LJFePTwFPJvuRlEvYrEq7bO
         Hqbja0qt25ATD8c5tlkPL5Hs+w7qlJiVmXDxvdWUn8kvCMhYzK9LCNEm6J+fYqdF9ymZ
         U5sQ0f1dNDGLRqbfY1F48EmeEPgrDg5QfReU1I98kg4Ks+TiYCEX4BxWkk+M1BjhlkEv
         Tl9TOd+IVeS6L17VEvld53rA5A4CSgqAMml6248IYi7ZZLCVfaenu8tQ0jAxsuH0fZHr
         rEqw==
X-Forwarded-Encrypted: i=1; AJvYcCXrIEhzl135RfXw1XeTBd4os7pkwzzS9QChXgbydihxbeYe1lMGTJGrUbs0u+8Zb2zgBardTpbkx+WChNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2N1SZDtPDfskaASkjol4wp6+JRfZMQ5bSqVwPx9kN691sZbh
	V7WeNJ5a3TizKmheCUlLgXC34liPEGmsQf/DLqEvuFIlpfXiHDKR4//rzNG9Rc5fmw+k/fHrrnx
	b4BpgN+dxTOPCpY2nsX9NcAHBfLOi1IFRIAwNFg==
X-Google-Smtp-Source: AGHT+IHFPSOd6NREw9A278ECg7mZRm4KbY500kEKTD7MayZF2O5OrCXgPgHLK0oSuFdKLdnGItooyTY+XoN1oFKjZrM=
X-Received: by 2002:a17:90a:9114:b0:2d3:bd5c:4ac8 with SMTP id
 98e67ed59e1d1-2d5ea4c61d0mr5881422a91.27.1724320931442; Thu, 22 Aug 2024
 03:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822093442.4262-1-hanchunchao@inspur.com>
In-Reply-To: <20240822093442.4262-1-hanchunchao@inspur.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Thu, 22 Aug 2024 18:01:59 +0800
Message-ID: <CAHwB_N+1a9pWTVZmWb6tDTR0S1G5tCj7zJx9xaOL_tBTS5oTtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: fix null pointer dereference in hx83102_get_modes
To: Charles Han <hanchunchao@inspur.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	liuyanming@ieisystem.com, Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Charles Han <hanchunchao@inspur.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8822=E6=
=97=A5=E5=91=A8=E5=9B=9B 17:34=E5=86=99=E9=81=93=EF=BC=9A
>
> In hx83102_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a possible NULL
> pointer dereference on failure of drm_mode_duplicate(). Add a
> check to avoid npd.
>
> Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate dri=
ver")
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/dr=
m/panel/panel-himax-hx83102.c
> index 6e4b7e4644ce..7c2a5e9b7fb3 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -565,6 +565,10 @@ static int hx83102_get_modes(struct drm_panel *panel=
,
>         struct drm_display_mode *mode;
>
>         mode =3D drm_mode_duplicate(connector->dev, m);
> +       if (!mode) {
> +               dev_err(&ctx->dsi->dev, "bad mode or failed to add mode\n=
");
> +               return -EINVAL;
> +       }

 In my V2 series, Doug suggested:
"nit: no need for an error message when drm_mode_duplicate() fails.
It is incredibly unlikely that the allocation will fail and the Linux"

https://lore.kernel.org/all/CAD=3DFV=3DV2O2aFDVn5CjbXfgcOLkmNp-G3ChVqQKouB2=
mDB+NZug@mail.gmail.com/

>
>         mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
>         drm_mode_set_name(mode);
> --
> 2.31.1
>

