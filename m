Return-Path: <linux-kernel+bounces-549164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E6A54E69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93360165683
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478BD18A6BA;
	Thu,  6 Mar 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAj4mlLY"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03231502BE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273075; cv=none; b=KKOPUJhtUJtGSKarJ8rUl0svqE05y7zZgMwBhEaQRYPU9DMdYZ6LrH870HzmpWrOOJgOgE9LXaPe357XaB2p6/Hv4MkV1i/NmA5xuO/tlkiLa02jKwaufu/A1g1f6Z2uA/Rkb5scsVgf7NI29t/xshDhnFJPZAs2l9FRJHsdSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273075; c=relaxed/simple;
	bh=zo8u0DasFg1csuJDF3CXQgTgKt9UBpsvhzOndwlaORE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtBSpeRm40uNfh0j5FXRXFKvVL5+Zfp35i78OYNj+GckNGqqFL5w1DhZETBgVFSLW5j//FFBDeLSxgI8g8PWOSFTHmYUZTZO/JrkdIqNNSfd3RNTpV2rU1RpOdK1R2Z1N1Or+q+6q4Ivmzu0shaxMuJNCIuIvz4Z0nHwMg6OJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAj4mlLY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so87757a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741273072; x=1741877872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukUCWGxvoTM5xaocQvMdv9IPv4xm083YArvGDeKyolg=;
        b=VAj4mlLY2UMLwka7Oilet9A0L//ZM4F1/NOpmh8aS8htYoCpd+AX8wAXhuOfsRqRM5
         AoJ5V48P43hyn4pG8B8zon3psQuAuwrE1Q/znwrHCMppb3LAk+EsWhRTLAGXV4W1lG0x
         KDB3pA7GEhRNMx9L8uvCCiEmK7azNAi8Di6YgG+slknTYE3Lt6KCoRHhhhz+zh2QGI1Z
         +vGvEeyApPHzdTZbgYVErnbXVVRcGqnVOviShheqm5xBn9Z+nTFxTh7khucwqWqdHo8k
         uXzbvjyyYZHDouYpQiBcjIp8rPXhFfdj6lDIPS+ww5JJJ2dFc1Ogvmavu7PYJ9Nusuqk
         dTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741273072; x=1741877872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukUCWGxvoTM5xaocQvMdv9IPv4xm083YArvGDeKyolg=;
        b=WSY53moV22Xz89tcCAj4VdmWEi1vAOlirCupRW18nMLsIx83A0tBZYqui+JExDCAlO
         rJOaOIFEsITIQzRdBSfgpOn0Leo28sBzK4fZSTWJ8Zovh76PP8ugrzd6lxgv4GAoIBep
         aE/dHC6yxeQO8qJ6Z8WnAkA4v9qzFB5oF/J9Lz4j8B8oTTqgLNYECfDRv05wLrO0wL+7
         t3f7rXw0UmwBa7wFJEicfefGTQUz1NqtoZ00tzX/7GpLndo3JWQfYTYdXmz4lQFr6WkG
         r1kC4lAizT98O3kHsnv12z1CxI0Z4cZ2icQznVwBnDELD2YgDvnpYwa9JIxSP9aLk4LN
         4bqA==
X-Forwarded-Encrypted: i=1; AJvYcCUxm8hF9PU1mB/oYQZFaukW50y2y8Tot/tAU7bbX4gTraQYlLbWTxmxsgnnKobYJjqXqKSzyX8/EI3xK3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTCmcBHuAuOSqwY0CNVP5ZhKuvwACROjD3KNZk7dvrJ8hTtQ8
	L8OVQD3H8kMN8ayCH6jrSKLMCSt9R0nyUpUs46JDdx5aHo71rDbDSgKovq8bl4pkrwaN3bWzmJU
	i/9AjPBsaoaFZ37gs6tAXbA9g0gM=
X-Gm-Gg: ASbGncvTBDvbPSaC0hoVv3CW78m66gOq/GYZsDMe3eoocQoqcNs+qYOq7FqOPItLyuS
	vGBjgdQpt4dn37cGoVpIclODeXLDTE/Rk+Snmw9F9Ta9oqxhudBcB1nHCQKaKLhvkgFwwKuhz8N
	bQsq2TXjpvyPgthowbMXS6E2P4+g==
X-Google-Smtp-Source: AGHT+IFFvTkNxjyxH3OhwMrPOCnoGirYk4RRPl4wpFL3uc4YUYEn6uPwllrEZdOoh/5mgKss4M3aXC3fAJNdB6X8MJk=
X-Received: by 2002:a17:90b:17c1:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-2ff49815d68mr37955a91.4.1741273072132; Thu, 06 Mar 2025
 06:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306075148.2382-1-vulab@iscas.ac.cn>
In-Reply-To: <20250306075148.2382-1-vulab@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 09:57:40 -0500
X-Gm-Features: AQ5f1JobaKMBHvrjKb5uUx8V2l7PIiJtkP8GoC3q6xiyWznC0Pev0Zr1rfxKQPA
Message-ID: <CADnq5_OAvMKvSZUVA1ktk5Oc7Huu+Jx-0WbSGA_r+fZ+jQDE5g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: handle amdgpu_cgs_create_device() errors
 in amd_powerplay_create()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: kenneth.feng@amd.com, christian.koenig@amd.com, alexander.deucher@amd.com, 
	Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com, 
	Jun.Ma2@amd.com, lijo.lazar@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks

On Thu, Mar 6, 2025 at 2:52=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wro=
te:
>
> Add error handling to propagate amdgpu_cgs_create_device() failures
> to the caller. When amdgpu_cgs_create_device() fails, release hwmgr
> and return -ENOMEM to prevent null pointer dereference.
>
> [v1]->[v2]: Change error code from -EINVAL to -ENOMEM. Free hwmgr.
>
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/pm/powerplay/amd_powerplay.c
> index 26624a716fc6..f8434158a402 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -51,6 +51,11 @@ static int amd_powerplay_create(struct amdgpu_device *=
adev)
>         hwmgr->adev =3D adev;
>         hwmgr->not_vf =3D !amdgpu_sriov_vf(adev);
>         hwmgr->device =3D amdgpu_cgs_create_device(adev);
> +       if (!hwmgr->device) {
> +               kfree(hwmgr);
> +               return -ENOMEM;
> +       }
> +
>         mutex_init(&hwmgr->msg_lock);
>         hwmgr->chip_family =3D adev->family;
>         hwmgr->chip_id =3D adev->asic_type;
> --
> 2.42.0.windows.2
>

