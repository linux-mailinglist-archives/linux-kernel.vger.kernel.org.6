Return-Path: <linux-kernel+bounces-443518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97809EF335
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552F3290D72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74C21E085;
	Thu, 12 Dec 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp/QFf5s"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFCB21639E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022199; cv=none; b=Qki9lLrZT+2A/WAqRRKvePIUvYH06wUq7uYre2cq8T5+SZ4E6ySPUw0sR/no9VqclV7EnAGUS2hY4f+cA8DhGk325Ms4oSFx9+IPaheZGIGEG4dYOYCJQXvDiT/hnhibbd2/mLlwPc3kPCbm3EH3qsGdiHdYFSEt4ntK76Agf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022199; c=relaxed/simple;
	bh=Gnrw88AY/KnCsmiTahZtOgEP2BHqHDTiQ5PfqGsWgMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/XHwuC0L7IKhb8og22BPENsmRDBw3JWK4u4FcSjef3rvDZprrF3R+Da+6PHhsuKF5AR5HZDD3xwzAve25K2NUtjGJBchZjHy3UF+zdqMEAMRccJf9gViMQdGLwfUM9YdPfK4kRlgWu3n9MoBmLtMY2NjGlCZNOA/fcjv6jvvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp/QFf5s; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7eadb7f77e8so80691a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734022197; x=1734626997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep0U+ID3D7MVAJ+LCtsE76Z/dmWp4CPTtQb6wuqT31c=;
        b=Dp/QFf5sErI6RA/ZGOC89QvYjQlh9jWOU8rjf0IugtDqPnt687q/gf67V8O2sv2WFL
         B+6dOIA8CvKr7OiTLyY67D2nON96PMnXIwcjeDU3TXQuBrUgLi5JhgzR14MmBAq5viRl
         we3uAaFxWN58ZEHZhETbWmZh5wxCtwgGjP1tsbuGlPC+V1VqIWv3GuqFuEwFxyBoPu4m
         whiYJhpGDIeWVVsAyVI02uXeB12x3iuz8ViQACquAD2hVI+5V0yH/c+4+zgwJHbrNP5V
         892LER586ZBkSK15kHPMVdpAKfp1KK0RD9bi9/QnLAau0GwclguWwuyOKUu7B//cx/8H
         KQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022197; x=1734626997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep0U+ID3D7MVAJ+LCtsE76Z/dmWp4CPTtQb6wuqT31c=;
        b=rTKVpetMCJrjOHtjDmTY5lyRaBlaXI/6qydjr78vdTSMod4a8dakXJeWiUbgQq1F/Q
         7vc28dXDtiKtazR9hc+J8DcBlDH/NHvBUgRAFqP9H+q1zBA/12Z/8m29jiKpYbyrx3yk
         YWLiwZ6GDrQYEuhLMUprkeOOG+J14cJXvjJjDfewzED84CTI1zCFX4WVZ2yNB0GXeAu2
         OqEqTbhmqOyUageJ7W0LN1OgXn9XrUJlWvLFC12YqA72SyRkAVUMx4U73J/qH3Y7ZftN
         jlhhsh1a+ip5PACPDKR82Vn77OL+H3mo8wNUkObAGe7ReFFMgozVq6mimtJPjpwkDykb
         EEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMsZiKGinXeonudd+YdJa8JDfe0Yt0cxYXDJX1wx2nMUVUrTPNZGXIkMT/7TT1EJ5LRy8sRRsyOgMC634=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7SKnS05kS82ynQCcdtydNi4Dj+JehhkQdAma51OtPolzD4mz+
	fw1kLBf4VbxfSrQ16DMOt8HCBm6KVhtfpaVXEod9xJDcLo51xOk1Xm8B9PSFntfKI7Daa1Hlfr0
	Sn8s1j2R3WGZgNeJLD47V+342S6Y=
X-Gm-Gg: ASbGnctd06v+HvMMktobfkN5wd8SxevrdopZNgjcqW1unj87AcFFIIjkuiYELQltCbN
	aBv/75gBJBSbpWr3Hk7AnFoSJ6xls0ndOZTrX3A==
X-Google-Smtp-Source: AGHT+IGQS+ajJVfdydep2zLW7YQ43auFsikDF5sJxBaTtkOo0qYDloNm6tM59UfROiINvuJyNUr523mafV7gsTyVoQA=
X-Received: by 2002:a17:90b:4ace:b0:2ee:f1e3:fd0c with SMTP id
 98e67ed59e1d1-2f12807b34bmr4185920a91.8.1734022197316; Thu, 12 Dec 2024
 08:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212105624.35877-1-dheeraj.linuxdev@gmail.com>
In-Reply-To: <20241212105624.35877-1-dheeraj.linuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Dec 2024 11:49:45 -0500
Message-ID: <CADnq5_OxYp-Q1ugfgJWvzAwe5SScykujHJrF4gYX0-ztKBn9Lw@mail.gmail.com>
Subject: Re: [PATCH drm-next] drm/amdgpu: simplify return statement in amdgpu_ras_eeprom_init
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:18=E2=80=AFAM Dheeraj Reddy Jonnalagadda
<dheeraj.linuxdev@gmail.com> wrote:
>
> Remove the logically dead code in the last return statement of
> amdgpu_ras_eeprom_init. The condition res < 0 is redundant since
> res is already checked for a negative value earlier. Replace
> return res < 0 ? res : 0; with return 0 to improve clarity.
>
> Fixes: 63d4c081a556 ("drm/amdgpu: Optimize EEPROM RAS table I/O")
> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?select=
edIssue=3D1602413
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>

Applied.  thanks!
I've dropped the fixes tag however since, this is not a bug fix, it's
just removing logically dead code.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 0d824f016916..52c16bfeccaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1390,7 +1390,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom=
_control *control)
>         }
>         control->ras_fri =3D RAS_OFFSET_TO_INDEX(control, hdr->first_rec_=
offset);
>
> -       return res < 0 ? res : 0;
> +       return 0;
>  }
>
>  int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
> --
> 2.34.1
>

