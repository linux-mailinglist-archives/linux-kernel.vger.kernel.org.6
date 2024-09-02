Return-Path: <linux-kernel+bounces-311737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C9968CEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C6D1F232BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5431C62DB;
	Mon,  2 Sep 2024 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDSOHung"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865071C62C3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299002; cv=none; b=YTuyMffMeY+TnsRv8TcfpZUXvaYDmFeJdr0u9wEScnhENW+JjhqeQc3ISzi/aUKr7hvSBhP3PR26ih12VKdGhzRkcuHgHd1Ph7F4bfA3Lvz66n0jvWLn7sVOruWLOUFQteie5rsJN4It8N4rzuXVf+qdWqLhyQCWUVwv6tGJwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299002; c=relaxed/simple;
	bh=+PVE2BE0hCOuoyGx4L9PZC+Duiu/od1+1laH5fT0KPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDx7Szm2IOR75FUhK3IZqhQYhF9hxpZ252PPbGhzJPwHa5fbvQpOwLtpxpK2qX2uf6eA6N1upNzoerVrBWP5IAvrweLAaZBPbxusqEsNyunFf+4K+C8SO5cKO+0j+guPKZD7x9sEkTgwF1YqzeMgWllmfKv2kqg9vVUe5+muC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDSOHung; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2055a524017so566785ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725299000; x=1725903800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1Y4xLoBMjp3sOTUCmMpURmHtSqY58C0Dbpo7vkEAHg=;
        b=VDSOHung/ecsIY37+LFvr6lJTTNntfLSKUMInAP0WcJBlhjxNOfFRJEUXBFyDYYOSB
         By3YeP5lttGfq7IDASC0wU/ee+iraOPwo2574B++ppp1NPBaAqi9EIJWTEXICVGzXY32
         9dYeN5vT6NhpwMQclx7D+bOMVg92/rvedDFqHmR6iRjWSxGiVahCgLWFjGa1pNIfyDah
         mPQze/V20zh8jF9x9WaS/7A1Dnmmz4asyXfJugTKVLLQrQxZ/Rj/1VNLfvDwgclQiEaB
         GFMS/zeS6JDMOiSEy5KfqQxYKwixSw9nvnsvGu6f5wBGGhiTzqB5htAD4F44IIyakVga
         3h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299000; x=1725903800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1Y4xLoBMjp3sOTUCmMpURmHtSqY58C0Dbpo7vkEAHg=;
        b=Js6qMHEEHXovXgECTri9LrPHG9322IgQn75OfZ/22zBYiqccz0j7UwclNfQ8zXNqP9
         6L/2GXwXgWdtWMxcCzT9gzAyJRc1oduq1co0/NVBluAml8gdMDUmSm8DagL0EuhC/w7t
         NeQEWV4ZM2w6OKLE5emg5/4goGdt7J3ycdqrgF8tdI/ZwcUzsUXbViPCy8/+L/cplQeY
         VF8r8W8y4S6Te9mAy4A1uLL/WUguKGptohZSGQuV4+W5xJv1gqtPxY5p+Z/sPIaJyFBn
         gYMlVR24dPZ65FcDrw7cjn5+1ARoMh9wMsD0acbJOIwe5EyStIg1JTgQbRL46XJrPEDG
         EAlg==
X-Forwarded-Encrypted: i=1; AJvYcCVyQrHRutacd1u9z2j1qAiAr4uvd/LE7AVXpKII2Qlo3gY8qQ3iQbaEn/u9u6OLpgrM8KqCthCVfjkZs2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5K9xaxmLulbxAFfWvYqZwQRmzMUF4oLWmRRf7sPvLrVmwK7F/
	2+IVAYhmOAl+Nw/OPJyZizGyjeF/g+DXscuSZBfDodXpMOg3lBVQyW0kQXRsYToWFVZXWgSCLJI
	gceYDwzu3g8BqI+sy4SSjctuX2krthw==
X-Google-Smtp-Source: AGHT+IEfFDhE0Cdt/LAKBpKKXNaAe3MnoIOSWwH2RMO0h9YyJyv6leTurOP8FeU0UlwFR/9vrWhOfz1BCfbBHfgMVFY=
X-Received: by 2002:a17:903:1103:b0:202:18d7:7ffb with SMTP id
 d9443c01a7336-20528847f02mr66200305ad.11.1725298999623; Mon, 02 Sep 2024
 10:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830072554.128132-1-yaolu@kylinos.cn>
In-Reply-To: <20240830072554.128132-1-yaolu@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Sep 2024 13:43:08 -0400
Message-ID: <CADnq5_NhytCVtif=3OLvBkJqq1zTtm_Hkmrt1m4fREC9CSbf+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add raven1 gfxoff quirk
To: Lu Yao <yaolu@kylinos.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	sunil.khatri@amd.com, Prike.Liang@amd.com, Felix.Kuehling@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, liupeng01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Fri, Aug 30, 2024 at 3:26=E2=80=AFAM Lu Yao <yaolu@kylinos.cn> wrote:
>
> From: Peng Liu <liupeng01@kylinos.cn>
>
> Fix screen corruption with openkylin.
>
> Link: https://bbs.openkylin.top/t/topic/171497
> Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 2929c8972ea7..0cd5fd3fa18b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1301,6 +1301,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxo=
ff_quirk_list[] =3D {
>         { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
>         /* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
>         { 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
> +       /* https://bbs.openkylin.top/t/topic/171497 */
> +       { 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2},
>         { 0, 0, 0, 0, 0 },
>  };
>
> --
> 2.25.1
>

