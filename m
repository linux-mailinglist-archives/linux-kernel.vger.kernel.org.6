Return-Path: <linux-kernel+bounces-296122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7105195A5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0108C286055
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A60170A12;
	Wed, 21 Aug 2024 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byGyzjGp"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88416EC1A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272191; cv=none; b=OQ1uYuE8pxAoe7t5IklGFwgJuIfq8hnq7/8luOchL6WAfBb47FHFDbpvR+D14NfLklGbA/FeXjh/dv8OUqCujtPUt7ceFga0M0tB7cdsZUlu2q7843EML+U5dujUzEEAKKg3E86aYgX/swJbKwErMkK+w1X9q9xzDF33apQARjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272191; c=relaxed/simple;
	bh=PKg6HUqEfOZSHRWfNlLpcUkRtzmLqhG524k4BHThR/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m17jw7rcT+9zareb9k3HYJwSNtG+yY7rnexDdqaw5Vzi8YfJeUstHMt98diUAeX10egkpvZwWTd4OFFKSqV3+cwSmoouVcZnNdxRZUvJ1J/AwUWukHMJO0z6JFC6kwQipWqI0yCmkNpYh3PRxJF80XmaFm0c3JoTVw1P++uP5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byGyzjGp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20201433461so101085ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724272189; x=1724876989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMGohLZNT4tHT1s57E5AexVYMwxNXCTuB+5zOwYpqCg=;
        b=byGyzjGp3ukAXVsmubyJ7UwBKKfR/V0IS8ECQizIVb8tSf3uMG7HQnzv9tCefmHdAM
         J95br9bQ8HwHgcrs4YIHE+MgUCqE0oge2EuJ9x64guFx3Ta1gf3PHGgsSv+oEb4sdrxr
         F63gBww5OW1U9LazcrxYRjmyb6Ee0tdeZcJecRJ07ArlCUoFccITcPZVxqw5H2iPPY9+
         KAHtYSM9I5ViksrbAQDbHk54Pe4rncyCm8c59fvx7Hx1wCwHTDNxUN/1rN+2yod64boT
         Z7npWOlLWaaR6e8bAmYKRyrOlOL2fQ6vULELFvmxuB9TDKzi/9qLMqp1hNw0ySp3/V8v
         4TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724272189; x=1724876989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMGohLZNT4tHT1s57E5AexVYMwxNXCTuB+5zOwYpqCg=;
        b=guFyuN7NIwZqKlPi0Q8aRAc/N6PUkGcjHATLRKBNBCkWIvRVPcI9g0npP8WlTbu02y
         3NIb9UuNQYkul7PZqdud+vPxAH9jVP/ByqUFn7x2N/Urluu41+mzfk1d2GmUu8mC8VRQ
         sMMn9X955q/Vq8ckPgWAauK/MKcwm9oferEvksMdXirRS3EJDziPgD0Lq4CRTLG1X6Qq
         PE+J9O8IQSLEEFL1UVxyFSVHNZdnB7Rou0xKJ/SdK40fM/igS2V9847JE3YEhvrDnfxl
         Uy6v1qSSf0y09LZg7giavd8TfdX3qG+Nk03ZtyHeZ7ppB9QPqYhVVL5M1mGAaymHjp1N
         xu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXii6vEhc+C/DIqsnqRJwY1AmNvNtljAjk1jUQ7paD+21D3Hrm5WF49LbNZ9f5Bn9Tg0HpkM6CbPG0GhaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtvAG1GgJ2LRxtlaZjnyXpG0icD2uVegLvdQmpQeJeP2MYEqlk
	rJtW/b0ouvowBftPV/y9ylHUxYJ03SLFLMyhzpKkB7i2F5a2RW77QJSYAtqsDPsIDunBhGp14UR
	kF7V1KSBRu+7jkCV3njEuZvfgeRc=
X-Google-Smtp-Source: AGHT+IEGtRum4QK+JxKr9jk5NtZWt1CaZw4I976Kw9lJP8I79xKG8phiOLq5jxX3q5+12eU8Oir2efYnr8pC3NwDzvQ=
X-Received: by 2002:a17:902:d4c8:b0:202:3e06:818d with SMTP id
 d9443c01a7336-2036819c4ecmr21669775ad.10.1724272189272; Wed, 21 Aug 2024
 13:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821064040.2292969-1-ruanjinjie@huawei.com> <20240821064040.2292969-2-ruanjinjie@huawei.com>
In-Reply-To: <20240821064040.2292969-2-ruanjinjie@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Aug 2024 16:29:37 -0400
Message-ID: <CADnq5_Of6Up9PinPKrJP9m2LgUUNaFgaJ214DR=09AgSCdeiWg@mail.gmail.com>
Subject: Re: [PATCH -next 1/5] drm/amd/display: Make core_dcn4_g6_temp_read_blackout_table
 static
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chaitanya.dhere@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
	sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	daniel@ffwll.ch, alex.hung@amd.com, aurabindo.pillai@amd.com, 
	colin.i.king@gmail.com, dillon.varone@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied 1-4.

Alex

On Wed, Aug 21, 2024 at 2:33=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> The sparse tool complains as follows:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_co=
re_dcn4_calcs.c:6853:56: warning:
>         symbol 'core_dcn4_g6_temp_read_blackout_table' was not declared. =
Should it be static?
>
> This symbol is not used outside of dml2_core_dcn4_calcs.c, so marks it st=
atic.
>
> And not want to change it, so mark it const.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  .../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_cor=
e/dml2_core_dcn4_calcs.c
> index c3c4d8d9525c..0c24f15d5067 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_d=
cn4_calcs.c
> @@ -6850,7 +6850,8 @@ struct dml2_core_internal_g6_temp_read_blackouts_ta=
ble {
>         } entries[DML_MAX_CLK_TABLE_SIZE];
>  };
>
> -struct dml2_core_internal_g6_temp_read_blackouts_table core_dcn4_g6_temp=
_read_blackout_table =3D {
> +static const struct dml2_core_internal_g6_temp_read_blackouts_table
> +       core_dcn4_g6_temp_read_blackout_table =3D {
>         .entries =3D {
>                 {
>                         .uclk_khz =3D 96000,
> --
> 2.34.1
>

