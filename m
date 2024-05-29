Return-Path: <linux-kernel+bounces-194230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD08D38B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B15281DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22F1EB46;
	Wed, 29 May 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8HcQ16N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB91DDD1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991593; cv=none; b=P4IiLsQOhAksIXl9mHpkty+t2Nfj7RQtuYtHChfh+KMQCbvQtzZuZM9ugSqbwHVzKbHVS+/aZvuaWt1D93MvFxGYO2sXi0dz40jpx60Vas4HItfs1eiJbjlOXApclIyzOQKw/cfo9N9axoHvLUlqQKi+GrXhaH0HdUrlGk+MPsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991593; c=relaxed/simple;
	bh=xpmET28viFR3TkIrXW9pSkeAEoSPmQ/nszpOTyWdkAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6Ulg6OEPjTqMY0/VfhlIPwpox/JFw69DPu4qnWUhDeK5ilMIxZm26yVu1Ns6qMFoamCpG2jguYX1BZ7i1s+ODqulm0/rKqD/vo0LnD7jOtfgxGrhmn/5YLtIfJZjcy2ul2xs5qejct0RPtJdTcUuGHyV5Gnm2NmMhE1v90Buuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8HcQ16N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D42C4AF08
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716991593;
	bh=xpmET28viFR3TkIrXW9pSkeAEoSPmQ/nszpOTyWdkAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p8HcQ16NxOe8VYg0EAmIgZuY2Tr0jlUy591iQEqoUc26vWFARjUGWS1FbQ46CatfP
	 M63gFnzA19JNtrBUolfrRVZ/BS2tTldalee8zalu/Hsrl9vyudAfDIOFs2rGqCwgZp
	 PP+yVK0WA1dLN72Tfk7WwzPlJTWKCItQUa8ET8//rbi4ACW22q6jLz2ZwuYUIE4d8J
	 MU7wWl/urjs5gaDZcfkd1TTmsoC76yRDbFML8XD51lvkW3nZMzCQR6E3ZRX534Q6/G
	 h7zxnjCxWip1JzS6K8COsiS+eO5QGCMEsfjcudi7kPl7+wyK1Zw9MNnMoVN3/jxqgl
	 PE0fTzONyenuw==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a0873c6e4so21462257b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:06:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUO2Iw4cEm5BXyMLF2DLashIVUCUJqi65t0I2LsTQxIhJQUlS6CZXw0m8YmXEt712xSAWIlUJVMTDpIDfCFPag0OZH8psQbz79vJxFD
X-Gm-Message-State: AOJu0YwpCqhRYWqGkctP5W7O3Xc8IOtDQ5BPo9dg6+siMjd0halqb6Zc
	YEWoHsJQKqaDzmaI+Jow8YPxmH1yMb7Nw4RIBmoVbI+ESMHeE4wpz2FlnUrckLEvGRCEoZ3F0Sg
	TSwsT4c2ze1N+ZNhAN2oC78xtGTrV4Ao3gmbBsA==
X-Google-Smtp-Source: AGHT+IFBJyJ5c+nU3TDkR5W3R/2SqCf3C5wlu9+3163jsp7yhDX8h4YZLzfCDcYFu9L37VEIoGKgGbp7JBQ/pg/44OU=
X-Received: by 2002:a05:690c:802:b0:627:7871:e172 with SMTP id
 00721157ae682-62a08fdc095mr172764587b3.51.1716991592506; Wed, 29 May 2024
 07:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516062455.106266-1-alexander.stein@ew.tq-group.com> <20240516062455.106266-4-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240516062455.106266-4-alexander.stein@ew.tq-group.com>
From: Robert Foss <rfoss@kernel.org>
Date: Wed, 29 May 2024 16:06:21 +0200
X-Gmail-Original-Message-ID: <CAN6tsi4VCnRD7gj0c0feFdfjcRbYVGdud8M=qEit-uGHrnqyTQ@mail.gmail.com>
Message-ID: <CAN6tsi4VCnRD7gj0c0feFdfjcRbYVGdud8M=qEit-uGHrnqyTQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/bridge: tc358767: Support write-only registers
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 8:25=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Most registers are read-writable, but some are only RO or even WO.
> regmap does not support using readable_reg and wr_table when outputting
> in debugfs, so switch to writeable_reg.
> First check for RO or WO registers and fallback tc_readable_reg() for the
> leftover RW registers.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 40 ++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/t=
c358767.c
> index 8874713bdd4a4..04c98ab1991bd 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -2086,19 +2086,31 @@ static const struct regmap_access_table tc_precio=
us_table =3D {
>         .n_yes_ranges =3D ARRAY_SIZE(tc_precious_ranges),
>  };
>
> -static const struct regmap_range tc_non_writeable_ranges[] =3D {
> -       regmap_reg_range(PPI_BUSYPPI, PPI_BUSYPPI),
> -       regmap_reg_range(DSI_BUSYDSI, DSI_BUSYDSI),
> -       regmap_reg_range(DSI_LANESTATUS0, DSI_INTSTATUS),
> -       regmap_reg_range(TC_IDREG, SYSSTAT),
> -       regmap_reg_range(GPIOI, GPIOI),
> -       regmap_reg_range(DP0_LTSTAT, DP0_SNKLTCHGREQ),
> -};
> -
> -static const struct regmap_access_table tc_writeable_table =3D {
> -       .no_ranges =3D tc_non_writeable_ranges,
> -       .n_no_ranges =3D ARRAY_SIZE(tc_non_writeable_ranges),
> -};
> +static bool tc_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +       /* RO reg */
> +       switch (reg) {
> +       case PPI_BUSYPPI:
> +       case DSI_BUSYDSI:
> +       case DSI_LANESTATUS0:
> +       case DSI_LANESTATUS1:
> +       case DSI_INTSTATUS:
> +       case TC_IDREG:
> +       case SYSBOOT:
> +       case SYSSTAT:
> +       case GPIOI:
> +       case DP0_LTSTAT:
> +       case DP0_SNKLTCHGREQ:
> +               return false;
> +       }
> +       /* WO reg */
> +       switch (reg) {
> +       case DSI_STARTDSI:
> +       case DSI_INTCLR:
> +               return true;
> +       }
> +       return tc_readable_reg(dev, reg);
> +}
>
>  static const struct regmap_config tc_regmap_config =3D {
>         .name =3D "tc358767",
> @@ -2108,9 +2120,9 @@ static const struct regmap_config tc_regmap_config =
=3D {
>         .max_register =3D PLL_DBG,
>         .cache_type =3D REGCACHE_MAPLE,
>         .readable_reg =3D tc_readable_reg,
> +       .writeable_reg =3D tc_writeable_reg,
>         .volatile_table =3D &tc_volatile_table,
>         .precious_table =3D &tc_precious_table,
> -       .wr_table =3D &tc_writeable_table,
>         .reg_format_endian =3D REGMAP_ENDIAN_BIG,
>         .val_format_endian =3D REGMAP_ENDIAN_LITTLE,
>  };
> --
> 2.34.1
>


Reviewed-by: Robert Foss <rfoss@kernel.org>

