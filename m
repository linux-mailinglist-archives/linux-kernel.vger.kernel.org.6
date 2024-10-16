Return-Path: <linux-kernel+bounces-368143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6349A0BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FA91F24A23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD2220ADDA;
	Wed, 16 Oct 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnmk1Ht2"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2C15B13C;
	Wed, 16 Oct 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086395; cv=none; b=pdurnNkgqyPuReWnsfg4bEq7tg7pfa6yUw/he0dIVQz6pI9o2GRIgJs1wxSTTojlA0qicv1HxyiKyMUqZKvTHsTfkh1JcVGH6vfi3865OEmN6VlQTLD6u1BhqODhNGKkg72bFjDYKmUvVlJO0BzxYuMl70TbgrlduKtfXSVJHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086395; c=relaxed/simple;
	bh=Go9Lpt6P6lduc1QG5NHEFhmQEuEpLhDeEKe4LtkOWVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRH+oUu5kLwhUCY8RYh2D4TWeg6dFdNcpdZ8vqH7t+/xPJUJ1Vdjj62hdTf8tZcAW/T0jAoGgX5K7HSYjESYJyA3fkTaXHwYLPGxDAVmPDRGTz4KUFdiKMlJFfhBbsqkvI4FBzMK74nnCYY5B9gq7KBzcgd0BFAoJ0BDbAmLJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnmk1Ht2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2ee0a47fdso1074891a91.2;
        Wed, 16 Oct 2024 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729086393; x=1729691193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPG0IcYOOjj5wHuVKKI6JRMlVaZc1FuwPVrIRPhC8NY=;
        b=hnmk1Ht2v/P5VUuxn3ZYfyhvujTKGQk2aq7RFPa6myHusJKYnEAS1lq6riCOC8e2zZ
         bGjRVflPgKXSPmPYiLK9D2pxyXRrMEiYACTJdyfUa3VLjnx/JpvFVwKN7Vl449lkVlh3
         n1GRYEnFuVidWSgkgDD5FOpBOHvws+fN89He3tWoTAdEY+3SOHVIQp+k3BbdAXox84+k
         HHkz2dZS2ZwHUDKCDXUjREbTMZUgUm97KBLItbPIM5jNhawJvvU1xphbDED7jvCAikMC
         Ion4nP1icuQDTUdIBf0/VjOjnPoGzkTmX+I3PUlb4v9oELdzQrswx7/kgzzpgRD3gz9x
         pVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729086393; x=1729691193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPG0IcYOOjj5wHuVKKI6JRMlVaZc1FuwPVrIRPhC8NY=;
        b=Jl43rx9IjSyJAMh7B8T3lq/tBqRns+SrbY4+koTATdHYmuSrt2/yNDH7wC/RPeH/rO
         OzpeEDGg4grtrL9gL7NZsEpSDl68R0gwVccNUMh/N/eeDtr/ia/ZdxNAav9HBTVvMcJz
         FtA4Fe7E5mQEKxLW/D75UDd0UmhCVtBqLKZ9VDQwXcgJps80yuYloYOnRKB04sJwJJuH
         ovbKJz2t3h/JD7SVmNPmz6BViILmnGH/EAO/Op5QQqBlA+mq9/tUSqYawjgyJu1Oba9R
         10RgTZ4fjhBGjYWk2inDjDvlLuC/TQbo+g4QYfLn9XtEjq9tG6kTmfsb5E4de4lwsUEt
         Jw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYhs1yemMj1ws1ZSLP+CiKyBTioVCkhDe+o5DEjzyP2STKs003N4Q/mw/Cp8ClcVGTFzRMaBbrbdOtC1sq@vger.kernel.org, AJvYcCXlgJJIYHNqEdT7qfaJUbJVqNay3114aPny/ufUIUZK1+hlu4N776HM95ZZsPPUptP5fj7T5dak7rwwhhJfTuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJKHhu8CxPZdGYks7yPKltHnSQDt3/w+NzvnYmKxu2nk5Gq14
	qa5gdP21b8MlLqDfn72YXDoEU8EQegToBE7kX0Evi/ubZKRcm5WNhe/s19AG3Ft2s14AihkwjVy
	ncopjxLAgNbqRmCaqOisa0E8RD4s=
X-Google-Smtp-Source: AGHT+IEoKuilAg8K+XtVXLqF5yfwI5xMJwIGApMZqNyYsDLitBiVCJtxvmZTCf5OM5yAAauiAQRQ1RzI6SsBKSnROvE=
X-Received: by 2002:a17:90a:9a1:b0:2d8:9f4e:1c3d with SMTP id
 98e67ed59e1d1-2e2f0d7750dmr9535838a91.5.1729086393193; Wed, 16 Oct 2024
 06:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016090812.280238-1-colin.i.king@gmail.com>
In-Reply-To: <20241016090812.280238-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Oct 2024 09:46:20 -0400
Message-ID: <CADnq5_NF1R=jNL1XT5JO9Obvq-bpr4qgsSE0mO+r17WkUSf6GA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix spelling mistake "tunndeling"
 -> "tunneling"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Oct 16, 2024 at 5:18=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in a dm_error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capabi=
lity.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 518e5d1f3d90..e05b8fddf2af 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1637,7 +1637,7 @@ static bool retrieve_link_cap(struct dc_link *link)
>         /* Read DP tunneling information. */
>         status =3D dpcd_get_tunneling_device_data(link);
>         if (status !=3D DC_OK)
> -               dm_error("%s: Read tunndeling device data failed.\n", __f=
unc__);
> +               dm_error("%s: Read tunneling device data failed.\n", __fu=
nc__);
>
>         dpcd_set_source_specific_data(link);
>         /* Sink may need to configure internals based on vendor, so allow=
 some
> --
> 2.39.5
>

