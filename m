Return-Path: <linux-kernel+bounces-269879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB924943800
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7DE1C22915
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB863145B27;
	Wed, 31 Jul 2024 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mmkYjn34"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F33A1A8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461419; cv=none; b=AxCcsrXp7Dh1PGIGIuW1a3GoE+vfUKkgL1bZVRxkLRcu3m3Bjefh4WEvSpxNjDZn1ub5QtraJ0t0gcQymnSf8gNDujiryFgc+ZSTr/1ifIAZoBkUMfOmyrTGFFEfe91FZ5Mlo/KZzdR5eB4XoimjTllZ6fLmAFij+VETaZWvTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461419; c=relaxed/simple;
	bh=nBmHE4fL1pwtnE1e7OpVqpK39zR0anb08YqLNoN9hmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0HqqpsEBM3JQ21Gz1ubRLr5sIWAXuNNf1sL70Lb1+2dFVabsm6obLLzxUKiEJJY9uSJgTiqUuXPsxUFub4gPkIYOVtrdgwfi1RL7xhhupHMyvWdPCVPPuk6SUZbmljIeEqcGhq/6Fsn9vM3ao4FtRTEgllmYsKBERXLAIY+C7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mmkYjn34; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4928fb6fdceso1538762137.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722461415; x=1723066215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7v5MQa7OcjG2quU7CTmYoYXphTBDWw9No993Vj+T1kA=;
        b=mmkYjn343t/7G2hXugW0d4hJ0rI8i5pAu6n3iuMG6gZ4qI+WOUlpDrDLp8XwU9JS6K
         WkpXbdqmV2BO1DyS7dmScV7CX0QSof3ppfYY1Isn3oDgW2LjXR6lY4AL9dFppecX9V6/
         ZS4Next9DFXzvIHC2ID+P4FrP1sjb7+ya6uwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461415; x=1723066215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v5MQa7OcjG2quU7CTmYoYXphTBDWw9No993Vj+T1kA=;
        b=ocmRdgWzSa0xPaID7NlyOAiCmWgykR9L2xHzmn3b384Q6rhzzmUqVBP23rz1n04hS6
         WlVh1QQ/VeOgwIuFcBeGa944SN4BcfRiUQP5twi9kGVgTEd0ff7KyscvT7hfZnJBeNrM
         tHNC3rjjlWhsky2Ru+ta3d0i24hHZyzvp8qcmpmEo0eMO8P0k6Mhd7xxuzsIjNXHNCx2
         mXCzxomeTNaO2UBP2c12BugBEp/N0RoMV7eY1mPngtvE8IUHQfRzB0yZW/hW6vLcLw3g
         FP1q+fcq2b27lgPIGvvzSiuSVAOjgWpZ51cRB0r01FuXUGJ6mbijx8bgY15HyMBFbK0K
         h2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5JHELRyuqmqYBZTvFJm+iBgtrnfhOqyREz26QC2he8Xne1HDVtCPQb4voYMmETvgg21uxyC69VOf6tB3NmkjySE2MlcqOLbSzfJ65
X-Gm-Message-State: AOJu0YwOvYv67QXCl6icgNRiwfzteOXskXXajTpRNvyGRlxkK/DBlu7/
	N34zEMjQhmOfzVstvKxLCx5cDzAxrdff0Sf8xeWyxACZgNGREmSAgABlK2omOenXlgKnp9pG8DU
	=
X-Google-Smtp-Source: AGHT+IFNApyLimozQgkUYVZn2JdLnYE+5sDDS1l+Mh/5q+0JIdir9WIVbfh+cctS2/D5oVxcKCf0+A==
X-Received: by 2002:a05:6102:2ace:b0:493:b916:aaa6 with SMTP id ada2fe7eead31-4945099baafmr772236137.24.1722461415351;
        Wed, 31 Jul 2024 14:30:15 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d74353d9sm787853985a.93.2024.07.31.14.30.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 14:30:14 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fe76fa0b8so475061cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:30:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJOw9zpFJF5zZUAZe5KXpx41vsbnjF6MTItdpl8rFGKFZ8VNMWRazxdFnmH1dopJzK3ZaCDJGsU4G0z3rZe/Soj/eG2be+B9Bbaj+U
X-Received: by 2002:ac8:5f4e:0:b0:447:ec33:f488 with SMTP id
 d75a77b69052e-45180991b4amr131431cf.4.1722461413981; Wed, 31 Jul 2024
 14:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730060659.455953-1-tejasvipin76@gmail.com> <20240730060659.455953-2-tejasvipin76@gmail.com>
In-Reply-To: <20240730060659.455953-2-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 31 Jul 2024 14:29:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XGzQN0LK6SBOY_6P8eF-cAuP4hRwsS+NTZEaik_Os7NA@mail.gmail.com>
Message-ID: <CAD=FV=XGzQN0LK6SBOY_6P8eF-cAuP4hRwsS+NTZEaik_Os7NA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add more multi functions for better
 error handling
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 29, 2024 at 11:07=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
> +/**
> + * mipi_dsi_dcs_get_display_brightness_multi() - gets the current bright=
ness value
> + *    of the display
> + * @ctx: Context for multiple DSI transactions
> + * @brightness: brightness value
> + *
> + * Like mipi_dsi_dcs_get_display_brightness() but deals with errors in a=
 way that
> + * makes it convenient to make several calls in a row.
> + */
> +void mipi_dsi_dcs_get_display_brightness_multi(struct mipi_dsi_multi_con=
text *ctx,
> +                                              u16 *brightness)
> +{
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct device *dev =3D &dsi->dev;
> +       int ret;
> +
> +       if (ctx->accum_err)
> +               return;
> +
> +       ret =3D mipi_dsi_dcs_get_display_brightness(dsi, brightness);
> +       if (ret < 0) {
> +               ctx->accum_err =3D ret;
> +               dev_err(dev, "Failed to get display brightness: %d\n",
> +                       ctx->accum_err);
> +       }
> +}
> +EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness_multi);

I'd be interested in others' opinions, but this function strikes me as
one that *shouldn't* be converted to _multi.

Specifically the whole point of the _multi abstraction is that you can
fire off a whole pile of initialization commands without needing to
check for errors constantly. You can check for errors once at the end
of a sequence of commands and you can be sure that an error message
was printed for the command that failed and that all of the future
commands didn't do anything.

I have a hard time believing that _get_ brightness would be part of
this pile of initialization commands. ...and looking at how you use it
in the next patch I can see that, indeed, it's a bit awkward using the
_multi variant in the case you're using it.

The one advantage of the _multi functions is that they are also
"chatty" and we don't need to print the error everywhere. However, it
seems like we could just make the existing function print an error
message but still return the error directly. If this automatic
printing an error message is a problem for someone then I guess maybe
we've already reached the "tomorrow" [1] and need to figure out if we
need to keep two variants of the function around instead of marking
one as deprecated.

NOTE: If we don't convert this then the "set" function will still be
_multi but the "get" one won't be. I think that's fine since the "set"
function could plausibly be in a big sequence of commands but the
"get" function not so much...

[1] https://lore.kernel.org/r/CAD=3DFV=3DWbXdnM4or3Ae+nYoQW1Sce0jP6FWtCHShs=
ALuEFNhiww@mail.gmail.com

