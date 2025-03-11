Return-Path: <linux-kernel+bounces-556489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A4A5CA80
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9558E3AF6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F125B69D;
	Tue, 11 Mar 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM9ZmwsM"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478225F964
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709518; cv=none; b=DFc1jvYf34JRjO+3XX0Gkg60pbdon+cufE/ASy+XPdBkYblTVd1tKpk0BhsZX8wKkPIEhS/7gn/iomfl7c7AhZO2VXaEBJlH3n4qhz58v0DEpk2cUZFl+fXNL8xMOd3LDn1EqJ7kwHn/Ax8ZTXGqp2Y69bWuTChlqcsLJl9DdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709518; c=relaxed/simple;
	bh=k/54jlr9krgPTZhYjJWI7nxNZq0ii+sTeh+z9w0PQwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjK7bYIW/frJvwp263us2TrFR7WYjRh2icXkRfbM0KmxtSpoWFLvkOuZc0JpgLu0T0/8xsAHUGW6GKM1NfmDD/9wdcc0yAbJwu4Ivn2KkWYrYG/MFhdEm32n1xzkSNYfqOcrOFah2v0HJ6IH/lRUsw4Cv9luH1vOOGnBPyI2gtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM9ZmwsM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so1562000a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741709514; x=1742314314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbXgDbQe6odtzN7qJt3Hn9EsxbW1Jh0Po6Yo1yHTQZY=;
        b=lM9ZmwsM+GF4eulkMYfRztNk5Cs6w1BQI/mcwsNMdpKtWfUlsAW24XyKb1PHqCwdxp
         UhH0Zvt9kr6qfLZxCU/Bd7OMzQX9ZPjEBz8UWHSveIFmhDx4gy0VZnK+j8s+/taBHyDF
         855b7d9bHFbFhIWI2h9HKeiG/YIq33sE8XgfSyKB7oge62gw5T061M+M5Rn9YvMdFXxj
         2bljFnEJ+tOdMw8221cFasMLtJqtKoNq5F6UicwbWe4AeeuQoOl02KC9dhbKZlo3b0hO
         jc4FyOHecRRQYk4lxOclx2gqDACTT1xhWMzXDPmBLCJnl2EFuNG6r2SnH6yb0gfW1rhE
         4zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709514; x=1742314314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbXgDbQe6odtzN7qJt3Hn9EsxbW1Jh0Po6Yo1yHTQZY=;
        b=J2jPStwatZlqQQlLYfFiO6AQySJDss+58lKCp/fK8aGcEEY+xKPkbvNZ8DZFNaMX/b
         /8JkUlAo9kG5VXc+77aD69jmK1xIeb5EIaBzDhHYFXgBhRsTbuEM6hgdo6mrv7sUpqE7
         irSEFl9uEsA/1SZYmRgOIGyE3NTJ/cNCI9/XpgHVvaZ1KAYXv1599/7KIqSGAjCcCHBh
         0Lqi/nl5cHACZrv4iOaryibUCxqrfXbcqiCyKs6kkF2d0q4+oiZKbQjo65CZ0BKdST9b
         Oivd6EpMqVBUqHLiB+Eznbk3erdzxQz2R44DzlEy62dC0cdeNrWN1Fyv0sg5totMPGnj
         TFUw==
X-Forwarded-Encrypted: i=1; AJvYcCWviypjbdfodbaZVNUDKys8g66tlBMoOKnYv3O2OlcbKgTXjjdPv6+C4McQz5QCp8N+Y1KEZd3jbQMPSgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDz2q1r+hJAdU1L+JyB47zWhplwb9glD85y3q95aFUlRiReFv6
	V69PhtLLend3eovuCTFkwYESf7FqT67QHKq/wvwhY/sI7xYuURHZgKUVbNN0fzWi5aJZ0iibd7Y
	t6vscHtIMFdoinXGuFtzgWkBk+FA=
X-Gm-Gg: ASbGncub1jEEmJJMR3W6wUrduJFFOlv7FqWZKhsr2vi93yu/S04j0dZJOmsTnlEL6Bo
	H2GlAl40fxEj9uXABGP5fW6leivS2uECey/SysAFMKDSzi+lPNXXM+XxrD/2QMpDjrOsnBgdFYn
	WrRSfckpJsQ/CyiDPBBGhkXRAUIQB41Uo75hS0
X-Google-Smtp-Source: AGHT+IHoUI2IVDeSuvbHPxuzIsIzy8DbeE/xia2Z5IbkvUSauYjGSV2OlB5NBKJvQwzYZ9fQklzxpagAfdTPP7TP2rY=
X-Received: by 2002:a17:90b:4d0b:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-300ff720794mr2092338a91.2.1741709513631; Tue, 11 Mar 2025
 09:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311111501.9190-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20250311111501.9190-1-n.zhandarovich@fintech.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Mar 2025 12:11:41 -0400
X-Gm-Features: AQ5f1Jo_n7znu1k53mWqt5ocAdZXDWFpNjqsQGbU5mMQMuEwRLuEpw7wKFxIBH4
Message-ID: <CADnq5_M0vVpU-puopwNjJcaSKfHr3ZDS3_n-Cmf5MWAA_4qViQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Mar 11, 2025 at 7:23=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> On the off chance that command stream passed from userspace via
> ioctl() call to radeon_vce_cs_parse() is weirdly crafted and
> first command to execute is to encode (case 0x03000001), the function
> in question will attempt to call radeon_vce_cs_reloc() with size
> argument that has not been properly initialized. Specifically, 'size'
> will point to 'tmp' variable before the latter had a chance to be
> assigned any value.
>
> Play it safe and init 'tmp' with 0, thus ensuring that
> radeon_vce_cs_reloc() will catch an early error in cases like these.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: 2fc5703abda2 ("drm/radeon: check VCE relocation buffer range v3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/gpu/drm/radeon/radeon_vce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon=
/radeon_vce.c
> index d1871af967d4..2355a78e1b69 100644
> --- a/drivers/gpu/drm/radeon/radeon_vce.c
> +++ b/drivers/gpu/drm/radeon/radeon_vce.c
> @@ -557,7 +557,7 @@ int radeon_vce_cs_parse(struct radeon_cs_parser *p)
>  {
>         int session_idx =3D -1;
>         bool destroyed =3D false, created =3D false, allocated =3D false;
> -       uint32_t tmp, handle =3D 0;
> +       uint32_t tmp =3D 0, handle =3D 0;
>         uint32_t *size =3D &tmp;
>         int i, r =3D 0;
>

