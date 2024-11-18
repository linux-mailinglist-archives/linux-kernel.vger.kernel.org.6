Return-Path: <linux-kernel+bounces-413174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44F9D1494
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0E12833A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659919F135;
	Mon, 18 Nov 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmTgQk/v"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10123D551
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944292; cv=none; b=oGqrUz5G4ZsRm8tVaQhJzgT8U4e7c7ziakPKzYrno5dg8+BUXA4eSfexLVe+2dA6RpdihqJAUTHCyf6+1cLp9XnA1sPfNNSrvNnmLZwu85izCYheLIENb2twLd5IpekKjtX/pqohm12Q2sakhmvVQP/O1+QbNd2bMosshX/A7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944292; c=relaxed/simple;
	bh=xssovgwPh0aXh0vGONlIt+CzPPCXM5FhKwNGLrYqKaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFC7Ha5ekLyqg+PAJglgrL43d/jt7beuoPcY6VgREHIWK3VYzdVzpeAjJGXgG8KyFznG/ENwTcvUjpeS0z4/eu0XvLO3CPWp3XRKJy8KJ22mjjDyhh9BOOSWKUEEQdStxnTBRmKPA5NYIaOsWX5pOf2lYqCZ+VQKDQyAbXuYfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmTgQk/v; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ea46465d69so112940a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731944290; x=1732549090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTYbN1OsvdU5Dd4t4uAh14jyVMSTfclkWku0ijH9Wm8=;
        b=EmTgQk/vFHHkeaW3MaCI8p3RtIUrpdDt8+ERxnomYis9pi2ovOgFYMXKg+5AzZwmTl
         Z8rXfnAa0AmSEqxqBO7XqxwHBz6OFJ+rLKsaeo/OVnAyG4Zy6Mcn4HDOStCJi30kIrMb
         j7XDsXP9aIE1sPUPV1FUesk5vN8lvhjcl1WLymYAdMQCqAmoMLmI1gJNotMaApdhuIVB
         bu72V9Vnm0gyp8sWpAXDQbcbh3Vj53ZYUNolkh4wt6mNniM0zmJf5D2NIN+M3SS+sGUx
         zg/pEse2zScuO8blrSynd80D9SIjxEqIJ4itVtD+08v0yAG1LhfcafKaF5c1G/0iz2Xx
         Q/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731944290; x=1732549090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTYbN1OsvdU5Dd4t4uAh14jyVMSTfclkWku0ijH9Wm8=;
        b=Huh7r51YGhlb5qjzOaH8YcpLfmSfICDXjQ+9k4Z4Il3W8bwHw3DZMlUNJvt6GTKdgb
         55CEehxer+Acu7UXxuglIKfHn4wl5NZcjS3tgk3UqJi6MHkB5A4SF0VfvNWhGmdLcBEu
         SviPcmNJDXhf0Q3xEax/UKUV+/nbruY2zxQtw4e3oCcFoS1OnyoUq7x90/j3kbAbSZkI
         a8o4BA0jyeuM1Iok0GkZNVXvAMnpJy0el7F+E+rmkFn3QQpl+DecE0OmKbtfrlRjcnmB
         Wbta2Xk6ebkh8u2u93IAyspkydTd5ZCcrBTzlJ5EvDQAfCHfqkXQJt23jMQinoT3AKsP
         QkBw==
X-Forwarded-Encrypted: i=1; AJvYcCXDzutLbeVtTGf7dFn3oGzwbV2JACpW+ImTQDSaLpEBL0AYVas/0pS/VDefSSrAymL2G4f9wGK/Z4ELUn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaG6fL+nM3OWizF8o4TRptruDg79b0IxVMly8a3AQVIzJR7v4c
	HOjmrEETk9JShLUqI8cRm8hjRyh+Jsec8sppgucpA5kKzzRfnat+IVUYqoBm161gzHSNr/r1AnT
	fqJ0FqnK/UAvRvA8H655JOW9PRYVCzw==
X-Google-Smtp-Source: AGHT+IEN02qRQSfSFYKEmvCrxizXKdSQjzhxs2MHTfZpG06Cqh+0iQYE11DVNoao0qWezYQn+s8IlKyg0rbWaOn2IjI=
X-Received: by 2002:a17:90b:3803:b0:2e2:a60f:289e with SMTP id
 98e67ed59e1d1-2ea151f4782mr6268389a91.0.1731944290121; Mon, 18 Nov 2024
 07:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-hdmi-audio-radeon-connectors-v1-1-d6d66d3128dd@chromium.org>
In-Reply-To: <20241115-hdmi-audio-radeon-connectors-v1-1-d6d66d3128dd@chromium.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Nov 2024 10:37:58 -0500
Message-ID: <CADnq5_MmRYfd-Be-GYs6cowfcjX6XLfmD-FVoM_FpZA6so+y2w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix spurious unplug event on radeon HDMI
To: "Steven 'Steve' Kendall" <skend@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Takashi Iwai <tiwai@suse.de>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Sat, Nov 16, 2024 at 4:51=E2=80=AFAM Steven 'Steve' Kendall
<skend@chromium.org> wrote:
>
> On several HP models (tested on HP 3125 and HP Probook 455 G2),
> spurious unplug events are emitted upon login on Chrome OS.
> This is likely due to the way Chrome OS restarts graphics
> upon login, so it's possible it's an issue on other
> distributions but not as common, though I haven't
> reproduced the issue elsewhere.
> Use logic from an earlier version of the merged change
> (see link below) which iterates over connectors and finds
> matching encoders, rather than the other way around.
> Also fixes an issue with screen mirroring on Chrome OS.
> I've deployed this patch on Fedora and did not observe
> any regression on these devices.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1569#note_1603002
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3771
> Fixes: 20ea34710f7b ("drm/radeon: Add HD-audio component notifier support=
 (v6)")
> Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>
> ---
>  drivers/gpu/drm/radeon/radeon_audio.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/rade=
on/radeon_audio.c
> index 47aa06a9a942..5b69cc8011b4 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -760,16 +760,20 @@ static int radeon_audio_component_get_eld(struct de=
vice *kdev, int port,
>         if (!rdev->audio.enabled || !rdev->mode_info.mode_config_initiali=
zed)
>                 return 0;
>
> -       list_for_each_entry(encoder, &rdev_to_drm(rdev)->mode_config.enco=
der_list, head) {
> +       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +               const struct drm_connector_helper_funcs *connector_funcs =
=3D
> +                               connector->helper_private;
> +               encoder =3D connector_funcs->best_encoder(connector);
> +
> +               if (!encoder)
> +                       continue;
> +
>                 if (!radeon_encoder_is_digital(encoder))
>                         continue;
>                 radeon_encoder =3D to_radeon_encoder(encoder);
>                 dig =3D radeon_encoder->enc_priv;
>                 if (!dig->pin || dig->pin->id !=3D port)
>                         continue;
> -               connector =3D radeon_get_connector_for_encoder(encoder);
> -               if (!connector)
> -                       continue;
>                 *enabled =3D true;
>                 ret =3D drm_eld_size(connector->eld);
>                 memcpy(buf, connector->eld, min(max_bytes, ret));
>
> ---
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> change-id: 20241115-hdmi-audio-radeon-connectors-f8ffac989b0d
>
> Best regards,
> --
> Steven 'Steve' Kendall <skend@chromium.org>
>

