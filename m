Return-Path: <linux-kernel+bounces-569798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E0CA6A7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3FC16EDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD482AD16;
	Thu, 20 Mar 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai+9J+4c"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44858221D86
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478707; cv=none; b=WvDUJRWmx1ZYAHA9pLZLtl+7qWBxnqxvoGtdQu03wOzHptIR334IfFZwexTgKRmdArgf4KKJA2frCiaky3prhTkMZInc3TnIlgTJK6x44AjRCUtNQLVFtRoFM/h8TASeyeTvxBNkbz4BxA1oyMpQgCIMynB6/kJIa15h56deLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478707; c=relaxed/simple;
	bh=S7JHhr8dXjkvKlG1RIAyMU/gRIFQULOthVPd0AKDFNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDof1PAqe/n0O1l/DdcxHlncaYAvmjnzI9a5vmVH9PI9nLtFWnxC/Drsy1c/IfXDAR9OoL7kEm9ybMW/mRGkOtthObkZbHjEdBLD2Nv8Z+cv6Rookc4/tgZEBZJe9ZLmPJZgE57idNfkY/BSgeEWpdu9indSuriJXbz4PgrG6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai+9J+4c; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so218628a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742478704; x=1743083504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7erTFxl9qbF0cki4kWlzFBXfpGMesZ1fGg6yms+cYk=;
        b=Ai+9J+4cwR6/Y5HSNMdCAmoEnjJB7FNbn5D4fqVGdokgLq8pGsuOGin0odGh2KD+97
         H7BPVZuIzvVhfZjgGEeRF5m0aH4DOtR+4cQ97YhDBEr8F4NzzPT8QMCxo4ZixdoGEKk6
         Sx3vE7ZGTAXB3qEL5jJdbJ36yhE2DvsUHWlAIsRwjb/g36PZLroOMnod2hglmWcKEloW
         Vj3M4pXovP8pC60DECWbo7f614m4F0INIM2pdbR9Z3fQJ5SQAoXvfJ9X3A7k3D/kFNH8
         Sk6YgipgnxG1tvyS6qJml7W0m/sDBkynv/mjvMO9rejQIqvmi5JN437GxT7sVvwZFGlY
         nd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478704; x=1743083504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7erTFxl9qbF0cki4kWlzFBXfpGMesZ1fGg6yms+cYk=;
        b=ZcW312+GxrqT+HlW8SopEseiC+stViPqDjEBAQGFiFmSE9lRDxiDtGZ5LMOMwDXifa
         er0d5x2pCDmUCB8kwlyAeEjffnTNmvrJAb0xBSTUOALuRpc7jIE/kwq5SkZ5QgajShu7
         3oHmZRtWC3gqp9PiMA9gcP8Swk+OmCf5SlvEtm7mzCDdvvCzy8zxX27iydHnnNptorv/
         G140FYrRY/VDP8OG+SPRU2zE5+YXXzB2IeuSE7PKGogxGqhzhrJ32QY+3duHJCmnIWbm
         6cP3ltgoBs0EnvaoaXp3Ggj9EuLa9JAB98O3S4vLeVohoYNNaLVEJXxCjs/awb7E5NbJ
         NiSw==
X-Forwarded-Encrypted: i=1; AJvYcCWX34ACENd8AHeVmShk+PlvRELpllq6v873Gt6Y6C8N+4jk6uV99DA9XlsHpJ7unjGOZzHbE1zUqLcKKLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfYK0ki4MWLJRY8X3ja6drtbMJFfOF4xmqyUmnk4A8m6/b1+t
	j0cT/nCOXINQNkSxqKSmq8m1uqHHoLR6QC7gbMGki4H8c+wqSw9SSB7gg4QKBJojybKnJAHPLIp
	5pgl86Vjp1O9dc1vToNl+wdRKYo4=
X-Gm-Gg: ASbGncvRCFsEK1cM/Yn1hOYer+6t7b8uFezl7Zk0B4vA1MmsNKkm3n0R42ymjUVXOly
	1PhOKjdRkMHoH6M+Mc2fD+gfXAltotq5ix5004SVZRNq70FdD1vQPRPEzaFbmKDG8RhW4+wMTfZ
	/qhwAEtQdZ3/WdIV2OcZDHxagJ5g==
X-Google-Smtp-Source: AGHT+IGZ29ppi8Q/aHl9D3R4X6WxrguirTGL8EmINroDy/P9gN71N9O3DW5RQlxvvWM4c3ickYedZNAqyE1REFlIFYk=
X-Received: by 2002:a17:90b:3e84:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-301bfc8e80cmr3858419a91.5.1742478704558; Thu, 20 Mar 2025
 06:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320093517.5247-1-arefev@swemel.ru>
In-Reply-To: <20250320093517.5247-1-arefev@swemel.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Mar 2025 09:51:32 -0400
X-Gm-Features: AQ5f1Jqe4I4M1h-_f5WGteQV-BugVutwvAg74TEnxpanzpsPBBbz6fU0OuNFIlY
Message-ID: <CADnq5_O+TMVD0B28Q6CgzhAi1aDR5ofjogE18HDXrJOJ1XwbDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/smu11: Prevent division by zero
To: Denis Arefev <arefev@swemel.ru>
Cc: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lijo Lazar <lijo.lazar@amd.com>, 
	Ma Jun <Jun.Ma2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Yang Wang <kevinyang.wang@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:11=E2=80=AFAM Denis Arefev <arefev@swemel.ru> wro=
te:
>
> The user can set any speed value.
> If speed is greater than UINT_MAX/8, division by zero is possible.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1e866f1fe528 ("drm/amd/pm: Prevent divide by zero")
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Thanks.  While you are at it, can you fix up all of the other fan
speed cases?  I quick grep shows:
drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c:    tach_period =3D 60 * xclk
* 10000 / (8 * speed);
drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c:    tach_period
=3D 60 * crystal_clock_freq * 10000 / (8 * speed);
drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c:
tach_period =3D 60 * crystal_clock_freq * 10000 / (8 * speed);
drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c:
tach_period =3D 60 * crystal_clock_freq * 10000 / (8 * speed);
drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c:    tach_period =3D 60
* crystal_clock_freq * 10000 / (8 * speed);
drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c:    tach_period =3D 60 *
crystal_clock_freq * 10000 / (8 * speed);
drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c:    tach_period =3D 60 *
crystal_clock_freq * 10000 / (8 * speed);

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 189c6a32b6bd..54229b991858 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1200,7 +1200,7 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context =
*smu,
>         uint32_t crystal_clock_freq =3D 2500;
>         uint32_t tach_period;
>
> -       if (speed =3D=3D 0)
> +       if (!speed || speed > UINT_MAX/8)
>                 return -EINVAL;
>         /*
>          * To prevent from possible overheat, some ASICs may have require=
ment
> --
> 2.43.0
>

