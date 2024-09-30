Return-Path: <linux-kernel+bounces-344394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D698A905
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EA12813DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DE190667;
	Mon, 30 Sep 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8A95C/P"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38318BBA9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711376; cv=none; b=lOT0dZAnVzrWMheX/2d68M75A7FxeuZBW1VEF3T2g5WdD9ofsAA1cqoC40px04cACfdR2fw+ipZz4pqrZKzM3q49UidUZK5SQv7W1cMvL55lhaB42L2IU2TPFnlOuNmuLZJhxB55QSMhMjDTTlxyrVCPEEnFjXD17eRMM9vf5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711376; c=relaxed/simple;
	bh=mrxRryVknGaRSAlKtoYSLQXMET+qnRxGWm3ttCC2FGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGFxpRxfv5Ml/YvXNT8Vq5OBVurw59wgTMC+CQwnF0RpKZERX7m1ZMYfhdO8i5Agi71et4opBb680GSG8SKYdM1AtsJYzj0ZPsJ/GgCXAiK/Csxmgeik3tCsd4cgyhcuKcuFwtxvCy4IMppQPn2xyea3RiS4ptAP9UbGFvJ8iM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8A95C/P; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e6bac92bf6so333530a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727711374; x=1728316174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q8VOr+aRJdcUf16Ay//IQ3TQ8L8t3ZXCDFmufxzXSc=;
        b=N8A95C/P6+fJyIaKCTzP96MdIGPX/STd5GqRyw0TxuSYGAGZs3GSh9IEb/9fcZC2pG
         m1hv74igi9nJ/f3t7uDEkmj9Fpl3Tjbr9+ojQLCfsk0XaH6TXi5EWfURnvHDhGFSrZtH
         TId9iDhbJcrq+yiIWBi61N/sZXeFt0DoVT2351ZkIpImU0Idvg9kyfKmOJseAOWIxqRn
         wsfktWibgWO8kjf6tV0MaBnM9GRWebgJt2XljAm0Q0ma9lg/F07pq2b0BNmenyYxK8Zu
         S+0CjPySzIFM5ShRV427xqsyJdS/W7ND+Yo4e+fW9ZExqwvZwbrpwjh5b8wH9xd8WOCt
         YOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727711374; x=1728316174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+q8VOr+aRJdcUf16Ay//IQ3TQ8L8t3ZXCDFmufxzXSc=;
        b=R8eyWiAhUJS79UkmdLJEWUcrvveo9iPwiHS8f5DWNWjzWHspYQYodHZgZo8+aw29EL
         PHBDfJ3c0RUAjGUBd2/YrN9DlcF9BS/fg4QoG2PH9bKl2OKlYQcMYB3BlqBQ9rpJbPOe
         mG6O9sv1rFyELAKLfxlNH7Pqh2MBBROkrxVoi9OLcALV7w9Vp4dhVR3koFnzDJfGi5sI
         ggoKqaPHYJddHEpunwyC2+0Y2UXnyKGmYrub2xAT3bua0yqeO/qGY0KhUFBYOAMK2ERS
         I6qadf6IZ3e0avJGjC0wqwTvLr1S27oDWsy3L9VY0m75qcDYeM6wviGR5ABXD/Gdichz
         8Wzg==
X-Forwarded-Encrypted: i=1; AJvYcCVfpxeSmGMfQ0Q72thMFfYr7K3yNYOg0fXg2kTyZB0sx4fe1TVP4slTgcUh9YnL7kDqqyB2HHlY6OTZETo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/0nyA8wGnSnJ633ykNd6pVb0C1GAsdTJOzZ0GYIO186p0N8q
	sz/I+/x36nTMjJG39ghKhPIokVWqxwML2wQZ3MVF9ghfAOtDJvRqqTvKXwqrkjDQkQQEqOZO5Y1
	UW6HIXgCUaijVN8QLGpBM7/OwTks=
X-Google-Smtp-Source: AGHT+IFq/iE3aElnPOuCP9DKQvEjbGBpk613KgJlE7+aVGD1RqPXBUEW0GIQXjPQCIYKQU5+51L2ka5tsPpXb6apOLQ=
X-Received: by 2002:a05:6a21:78a0:b0:1cf:4e49:bc74 with SMTP id
 adf61e73a8af0-1d509b8a3d1mr6134049637.9.1727711374087; Mon, 30 Sep 2024
 08:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927150719.1432625-1-Igor.A.Artemiev@mcst.ru>
In-Reply-To: <20240927150719.1432625-1-Igor.A.Artemiev@mcst.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Sep 2024 11:49:22 -0400
Message-ID: <CADnq5_P6UT+sbR_4g9cmZ0fHZ4CgU5WLr-NZJ_uqnfEsJdZD_w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
To: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 8:08=E2=80=AFPM Igor Artemiev <Igor.A.Artemiev@mcst=
.ru> wrote:
>
> It is possible, although unlikely, that an integer overflow will occur
> when the result of radeon_get_ib_value() is shifted to the left.
>
> Avoid it by casting one of the operands to larger data type (u64).
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

The chips supported by this code only support a 32 bit internal GPU
address space, so it should never overflow.  That said, I've applied
the patch.  We already cast other similar code in that file.

Alex

> ---
>  drivers/gpu/drm/radeon/r600_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r6=
00_cs.c
> index 1b2d31c4d77c..ac77d1246b94 100644
> --- a/drivers/gpu/drm/radeon/r600_cs.c
> +++ b/drivers/gpu/drm/radeon/r600_cs.c
> @@ -2104,7 +2104,7 @@ static int r600_packet3_check(struct radeon_cs_pars=
er *p,
>                                 return -EINVAL;
>                         }
>
> -                       offset =3D radeon_get_ib_value(p, idx+1) << 8;
> +                       offset =3D (u64)radeon_get_ib_value(p, idx+1) << =
8;
>                         if (offset !=3D track->vgt_strmout_bo_offset[idx_=
value]) {
>                                 DRM_ERROR("bad STRMOUT_BASE_UPDATE, bo of=
fset does not match: 0x%llx, 0x%x\n",
>                                           offset, track->vgt_strmout_bo_o=
ffset[idx_value]);
> --
> 2.39.2
>

