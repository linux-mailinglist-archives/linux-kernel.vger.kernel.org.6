Return-Path: <linux-kernel+bounces-181544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E415D8C7D76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0AD284138
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8A156F55;
	Thu, 16 May 2024 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzHTHcbB"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226FD271
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888991; cv=none; b=S3w3340aytPIvAVHmEu/HGVP+lvYpAhBlnlaODf0fFoyVE1h2yedIC1FswjpYBtFA+4LvpD86DNDz6/7yXv8W/sEp7vLU0BeTFQ+gP7PFtTWDKdcIkt7LY+VHhjczRVXqbRNxrSeO6/f2eLGnLphQDfKoJ/f1mA/USlNPoOl0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888991; c=relaxed/simple;
	bh=0p374y+uMsMQtR/4CfZqKLd9w2DHJE+tMmkzJ5ltTqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvVDCZ1sMV1We3SAcnMXvXdBvuN875RVY02u55B8Ro2mhlvqDbLr508SOrDKv0/I+PBjBXtqpk/oHuaLZjumosMs7HYYOhzcPrsGOCmlN10nnELbb19xRSSk/MModNhv4ciKYrHWuHZhPH7VzX+zRt4McY7Skf2s4ahcSZIPgug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzHTHcbB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b12b52fbe0so453717a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715888990; x=1716493790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMYV96lYb81BflDXHkzjhpZxuga4YZNOpQVldb0+fDk=;
        b=AzHTHcbBGaX1P5izYin9CBw9iMN7dBFf78GnI+96XPI0q7kdkXUphtmuzxEg7+DGT+
         0AVQbXBNUsoUcCJlg2BeqmeiIQ/GDxydWcnhJ4QXKmxWFG2p7xyXTdgFob3l1wnr6Noh
         lLjQ4aRXv6JBqfRQ33meiONWEkLrUi1yxoDQOZMOR5+JBMjdaOBBALnj/SI1nT62//As
         D3ENYj/cv3IQAexdzb57vEKVfkrkyF79jqGfdD6BEausn7S+1IQDtzw5TQroE6SKj/Z4
         bY4RssWKPS4NIzfJQBe205po5dx+roLBIN2y6BT3PfLPikyYBOk5thenBqo5ZqEDhhKW
         50Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888990; x=1716493790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMYV96lYb81BflDXHkzjhpZxuga4YZNOpQVldb0+fDk=;
        b=OwETnMvRIEMESevqp592pLWTKKk9IEIp1ZjIFk96ADcARKjPwjutBXognduZPc7Bs6
         PB+8PDqvJ5pZpN7XZKNNHFJaKJ6TU1oiun2VlIsXehXLFjBUrHRuJQvXWxIkgwEUuFF5
         2bASvjdoB0i5AcDDxet8G4FCM0am9OhQMStnisshoLHzCx30oaqMndb7nY9Y9VeWyhUW
         Xi1+iEm27uUaa1uRCkdK+Oq+dIupsKthTqI0nartwINAqDfNQR2viPmWMJt5mi0WRfnG
         n6BuiO6YZjA227hxdwGT4ePO+jemCs/TqFNWGhXnZ4FotpDrEm4oWWyUrQj/dyzq+epL
         6A1Q==
X-Gm-Message-State: AOJu0YzatTwjE4I8ZZ+LRRycUdDpVRZs2AP9q297seGHEeCrWx3AM4sm
	eVNVoz1RbMFD5pSjCITDbNDXMW+jE38EJJkIPF9IyixxgUc6WtvUVAT9OkHqf9NWeBiFmJBX0fr
	MQDSYnsdb4QI/ZVW5qv97MfA0HUs=
X-Google-Smtp-Source: AGHT+IHO2r9iV0Nf/KnfJsuujjZdu5xgf0GlYWTa/Z8VQoPXq9yH0ZDUJNDMTE3Cvh901LrugzbFcE7ixusomO+K8Yc=
X-Received: by 2002:a17:90a:a38c:b0:2ad:fed5:e639 with SMTP id
 98e67ed59e1d1-2b6cc4502b9mr22341481a91.9.1715888989916; Thu, 16 May 2024
 12:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
In-Reply-To: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 May 2024 15:49:38 -0400
Message-ID: <CADnq5_PGfjJMvER2o+z3niTPjdq8vMuHfzyr7OYC40LNyqkWmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1
To: Tim Van Patten <timvp@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, alexander.deucher@amd.com, 
	prathyushi.nangia@amd.com, Tim Van Patten <timvp@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, Le Ma <le.ma@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, "Shaoyun.liu" <Shaoyun.liu@amd.com>, 
	Shiwu Zhang <shiwu.zhang@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, May 16, 2024 at 3:46=E2=80=AFPM Tim Van Patten <timvp@chromium.org>=
 wrote:
>
> From: Tim Van Patten <timvp@google.com>
>
> The following commit updated gmc->noretry from 0 to 1 for GC HW IP
> 9.3.0:
>
>     commit 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=3D1")
>
> This causes the device to hang when a page fault occurs, until the
> device is rebooted. Instead, revert back to gmc->noretry=3D0 so the devic=
e
> is still responsive.
>
> Fixes: 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=3D1")
> Signed-off-by: Tim Van Patten <timvp@google.com>
> ---
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index be4629cdac049..bff54a20835f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -876,7 +876,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *ade=
v)
>         struct amdgpu_gmc *gmc =3D &adev->gmc;
>         uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
>         bool noretry_default =3D (gc_ver =3D=3D IP_VERSION(9, 0, 1) ||
> -                               gc_ver =3D=3D IP_VERSION(9, 3, 0) ||
>                                 gc_ver =3D=3D IP_VERSION(9, 4, 0) ||
>                                 gc_ver =3D=3D IP_VERSION(9, 4, 1) ||
>                                 gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

