Return-Path: <linux-kernel+bounces-547473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF41FA509E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398373A3B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9E1C6FF9;
	Wed,  5 Mar 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSLrw7Ba"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EF14884C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199153; cv=none; b=aQ7mW3ULnoG+elNArigJh40unCGm77pjOlWYKZPYXoR1fmjrb5zHVtqCwDpxWNym5DdlaeyvurlnFnhoZKnePDxfAiP+WCm/X2Y72hzuLP7xd/uqJJFXiObjS9lmLwbJ0HDSsSe6di+Zt7DY5xC2OnUZtGw4Z+M3p1HxtgF0jF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199153; c=relaxed/simple;
	bh=6gnCXqwbgsx1UO2zGs/yVTvH4q8EPOWoomYMuytONa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2AYTZXlCg9cdtRXX6pb99tLYTPIM6rkizjzZDc9dwEjDE4NfOIPyE356iYUFc52hI+PtD1x4obLL1lhr4zWAyqKJsCC7a3WQ4keE74V5XoMGbI2AYAAcn5UZxnqFY19Nm+CIw9qZpUDR+/FRnP/vXrZWhLMezdCNrXkq3yskss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSLrw7Ba; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fe9596a582so1643704a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 10:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741199151; x=1741803951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6ub0LI2sdOj4nWBdarlcwFS6czB6x3ubY+sbg/M77k=;
        b=kSLrw7Ba9p80b7qrLfVtfOxwb5jCoUt0HlcZ1QiTY7Bd2hatiR2RSD5r6w6i2M94tG
         4cNhSiYm6it3Em/CfdBN0WvflIaJ1Y6LYvmq5OWQMkdCud9jFQMYEUgtFcEkAZfmoLwq
         80t+dxZJt4TyxG4TpMNjHa60/tZ2sOtnX+PaITs2bySBvECxlBunzIyzN0AUVW4UtW3n
         5k9lwyTd1mSatOIr2ew6NYAfWUs7OkFfJNOszyfpNscO2GgDtNBkDoue+GyAqnCRc7Gc
         izHry0OtW2uvPQEQK4ZBInwR610Iqdf2yDQEfa5BXdQuWvhoWXb8u3YO129JuN+1Eu1t
         44qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199151; x=1741803951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6ub0LI2sdOj4nWBdarlcwFS6czB6x3ubY+sbg/M77k=;
        b=aV7Hzf5FoYfjKFviSxAah/BAdrXiyitgCQfsaVxDHISU5h8YrYuCBX5g8T5g8UHp7L
         eGSYLpVd9cc7d11NVBWRvmTybl23VolqI4kxXPCKcVWH6FhN/lLRIOcbps/l1h4KHRxr
         4wrNlrRFx18t2bKcK5m83tq1B81PffocXFkkqdQekmpO5ceyAXfvFU3dBPeBg/GiHl/m
         iwCPHbNXgLgUtHWXGJAWYQZt8ANKMv91QRNBFp6T8+0dlH2gU9aMmnlyatZoYNSVlsAe
         Fk+O394MuhZ+mN47W4l8NU8JVxELvCIGE6WiAwEwsaNZ5K6jq4BAsHz8ALHvjDdbrOnQ
         /p1w==
X-Forwarded-Encrypted: i=1; AJvYcCXEJOGUzVUHUX4+UYhM/2GQe24I6zBYs0DNwUC8gdk/xXZOPHQbvCVMDD3YPb1BfhPcuf0rxQbV4fLJjWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvCfC36XYlkpp3RhkFPmI/9pb/CSz1EpBzvDtwUY166ZCi7RHw
	23md3PBFHzhpkrarrCJuwMh/23uzuxI77Se75gFGhWOoKQYLeSjQX9ieb8ldzQWQe/cuhhyClEl
	rEpnuroMlkdQmo9JkwvpGg7dx0p8=
X-Gm-Gg: ASbGnct73ssx/RAUmQNk5DEk0IPjrMyiLUR8qmE4TsKfcXW7xKI8qdUra69MvPxiMQL
	ZxtOMMdECnUBOWYrW7/7JChtj74yK4nYBv/liwHZGUxhnN1/P+Zxwc2DZ2EVR4q57x4I34XRn96
	9khlas1Jt35znmbG5Z8V1h4yWTOA==
X-Google-Smtp-Source: AGHT+IHUUUMr0eXBfhB2k8mdAzcSo+xudwlQStKnJTUoHPgc7DWqIflQaDWzZFDkNYAWuQOPHhJZONCvrg9pJIRT4gg=
X-Received: by 2002:a17:90b:3ec7:b0:2fe:8e19:bcd7 with SMTP id
 98e67ed59e1d1-2ff49837979mr1415861a91.5.1741199150789; Wed, 05 Mar 2025
 10:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304071030.2166-1-vulab@iscas.ac.cn>
In-Reply-To: <20250304071030.2166-1-vulab@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Mar 2025 13:25:39 -0500
X-Gm-Features: AQ5f1JpsrrkkoNp9IkrO3SOJNFhknOQdq3tpUg-npUaJDMdg63QZADBLS2CqICA
Message-ID: <CADnq5_Nc62v7aB9xof1ZiTq0TQPJvxwjtvTO2KkaWwvfxEg03Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: kenneth.feng@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
	Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com, 
	Jun.Ma2@amd.com, lijo.lazar@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:29=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wro=
te:
>
> Add error handling to propagate amdgpu_cgs_create_device() failures
> to the caller. When amdgpu_cgs_create_device() fails, immediately
> return -EINVAL to stop further processing and prevent null pointer
> dereference.
>
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/pm/powerplay/amd_powerplay.c
> index 26624a716fc6..2cb05614466f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -51,6 +51,8 @@ static int amd_powerplay_create(struct amdgpu_device *a=
dev)
>         hwmgr->adev =3D adev;
>         hwmgr->not_vf =3D !amdgpu_sriov_vf(adev);
>         hwmgr->device =3D amdgpu_cgs_create_device(adev);
> +       if (!hwmgr->device)
> +               return -EINVAL;

Please return -ENOMEM here.  Also, you need to free hwmgr as well in this c=
ase.

Alex

>         mutex_init(&hwmgr->msg_lock);
>         hwmgr->chip_family =3D adev->family;
>         hwmgr->chip_id =3D adev->asic_type;
> --
> 2.42.0.windows.2
>

