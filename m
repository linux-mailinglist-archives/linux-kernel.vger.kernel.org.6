Return-Path: <linux-kernel+bounces-556456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603AFA5C9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD09B1891938
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CEF260A49;
	Tue, 11 Mar 2025 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PexjdJN+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8831925FA26
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708649; cv=none; b=B5G3FC/lvWUltZAzE62V2Zi/jgpPwfL0fE4ls6sGBszqRaF2dI4E9IFZKKR0t0YLftAVHwbLVd4eI4iZv67xI4q3ozNfG2aZBJZjcKKOjTH0OEy1G/4z7mf/Tu8dMt1odR8yXBQh6qTMH6s5HzIzS9u0sWqXMz/akTcCyFzr410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708649; c=relaxed/simple;
	bh=hAJYtbMjNLrldTe/Ke+tjWgQR2+x33wOZmSvOMQ3hoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qubejWIGuY+tS+TL5ku7AzePc0zBPFqVeyXQYspP9FRU6+3iOYpPKVQeyPyQkR4NrExMk5hw8NiYF4ReDdrXrX1byEG38aKaroCj76m5dhT6ZxnqO5YO+bwfrv6S5ZhEtAma4YuLnPUkOPVN+OePpzprtjLxchFDLInNRGo9r50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PexjdJN+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so4589032a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741708645; x=1742313445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aSw78de2mCMGc1nBdrYo0b6FIM8P0VsjFuePWhw/p0=;
        b=PexjdJN+LKyWyp1Gn45Hgrc4/j7CuFnnE1GvOrLczUBYm+6nKSPxrWw/grvRZKaU08
         dsqK3VJq20pithKVbKVukWERldIJ2+aYZ2bxB2VkTFTN3u2hV5ec6mGLvE22Tp8yF9v/
         x6Arj+CsTADhuZWjIuXMY43RG+3+jcZsVxzJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708645; x=1742313445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aSw78de2mCMGc1nBdrYo0b6FIM8P0VsjFuePWhw/p0=;
        b=tMxctgFN1vRbljAdJoEEgjcG1SjQ40AE/vqzojCCS8DTqWxTmfa7jgn9tr8b2qssk0
         p+wxtHQZiL2BX3s/liDJULqy5oY8kORDAafLx+FgJwLTsVFQU27UTiX8j9LPBQHVzVCz
         iSHZYOZ9gyhxpG3qUmIfU6+SNUtgYFlA+u5KcuI7iZYlj1hh1uW85SQM5bBSyr1PeAjS
         hqWCx1PjKGGHKF7jQwAF+5JLf1jSgTCmFCnlj970XAE/AENp4xn/ysdEgH+zhD1DNgvb
         1ucb04aDqZv16nonrPneqM+qnCEmREUyUswPQRaDbm9xf1/LE3akKUcCvjVylgYUh4Gl
         Nx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVA++e6aquIcSbPYIDShQtLN+I4g15lPTxQRWW7GT6KLZLwdwdfh9yrAmyETegIRys0/9fEXH6jcY212BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOm6iDZCh09VFsLnGbMIBd6hz0uJqnADpaDzCmAhe8qHuKlxc/
	Ou7cm84KU1whpC5+Z2CMDNhnLGKhwTTdkdVBP1jcflZyUC0kVEuaMI/h4bzIYkibNos4qBY0Sjc
	kvHG/
X-Gm-Gg: ASbGncv6bFwQqyZV7I9FigzNBEc9463Vni7pK59iDrBY+PQvcCyBaWM+e1jcVBwNywO
	qrEB/uT7vk81SGG30Y+C0lyEu1Hy4vLX4iXOY4/hnqjLRRKnz33HTmWQcm+t0Lo+5n9ta2aLQdB
	FmljXzYJXAkgFfZmPBYXicsO8V5veM05la+JOkiPsIa44lZmTwlcX0hwnND0twGxpX26J/ndfxz
	gk/NU+E39zCgv3/TndaAJLYPDm9y271JjykLOd/pFSEocGB1IlxzsiuLdtSVMjkuavBsGHyWMNV
	WurxYLp8r5KkX1OI9ml2QRoK/oWnDALjI2UVM4UuLt4SH2DvclE+UaVORsYagZZqlxkkvaNZ14W
	fa0aiVlGN
X-Google-Smtp-Source: AGHT+IFv3mm8BosDVuUoYD6ZuSyCzqWu39XVhD2hLRoRfB63/AW2Ggul+KaGrJVT8GCGojLDKiksMg==
X-Received: by 2002:a05:6402:40ca:b0:5e6:e842:f9d2 with SMTP id 4fb4d7f45d1cf-5e6e8430a5cmr10997270a12.29.1741708644714;
        Tue, 11 Mar 2025 08:57:24 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768f98asm8429744a12.68.2025.03.11.08.57.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:57:23 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2b10bea16so282357366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:57:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5lF7DBfqvrsS3oBgxFepS1kkgPgfUZUno+XbLTxRQXCVZWwspL27UhAJEfj4PPtxGvcyi5aMqznvpehI=@vger.kernel.org
X-Received: by 2002:a05:6512:39c7:b0:542:28b4:23ad with SMTP id
 2adb3069b0e04-54990e5da4dmr7908205e87.16.1741708321042; Tue, 11 Mar 2025
 08:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-mipi-synaptic-1-v2-1-20ee4397c670@redhat.com>
In-Reply-To: <20250310-mipi-synaptic-1-v2-1-20ee4397c670@redhat.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Mar 2025 08:51:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WW1ak-_MEBVks==Yr1tUdfFZ3K16_gcdJQ9rwE4ZduNg@mail.gmail.com>
X-Gm-Features: AQ5f1JqjhYIh-K-V6kVV6ysPirVcNFNTBtRezYB438xMMjh4zAHshLydS3Jw1pI
Message-ID: <CAD=FV=WW1ak-_MEBVks==Yr1tUdfFZ3K16_gcdJQ9rwE4ZduNg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel/synaptics-r63353: Use _multi variants
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Tejas Vipin <tejasvipin76@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 10, 2025 at 1:58=E2=80=AFPM Anusha Srivatsa <asrivats@redhat.co=
m> wrote:
>
> @@ -70,6 +70,7 @@ static int r63353_panel_power_on(struct r63353_panel *r=
panel)
>  {
>         struct mipi_dsi_device *dsi =3D rpanel->dsi;
>         struct device *dev =3D &dsi->dev;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>         int ret;
>
>         ret =3D regulator_enable(rpanel->avdd);
> @@ -78,7 +79,7 @@ static int r63353_panel_power_on(struct r63353_panel *r=
panel)
>                 return ret;
>         }
>
> -       usleep_range(15000, 25000);
> +       mipi_dsi_usleep_range(&dsi_ctx, 15000, 25000);

No. None of the conversions in this function are correct.
mipi_dsi_usleep_range() is only for use when you're in the middle of a
bunch of other "multi" calls and want the sleep to be conditional upon
there being no error. Here there is no chance of an error because no
_multi() are used. Go back to the normal usleep_range().

> @@ -106,53 +107,46 @@ static int r63353_panel_power_off(struct r63353_pan=
el *rpanel)
>  static int r63353_panel_activate(struct r63353_panel *rpanel)
>  {
>         struct mipi_dsi_device *dsi =3D rpanel->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int i, ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
> +       int i;
>
> -       ret =3D mipi_dsi_dcs_soft_reset(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to do Software Reset (%d)\n", ret);
> +       mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
> +       if (dsi_ctx.accum_err)
>                 goto fail;
> -       }

This isn't how the _multi() functions are intended to be used. The
whole idea is _not_ to have scattered "if" statements everywhere and
to just deal with errors at the appropriate places. You just trust
that the _multi() functions are no-ops if an error is set and so it
doesn't hurt to keep calling them. In this case you'd just have a pile
of _multi() functions with no "if" checks and then at the very end of
the function you check for the error. If the error is set then you set
the reset GPIO and return the error.

-Doug

