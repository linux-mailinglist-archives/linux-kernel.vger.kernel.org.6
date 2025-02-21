Return-Path: <linux-kernel+bounces-525968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C0A3F7EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBC1861218
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19C211261;
	Fri, 21 Feb 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh3W95e4"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88DC210F71
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149953; cv=none; b=HzuA66N1zQjAk/NKw64WU0rrEruXfeKkZ7SfG/SaQNLx0ucvZmPMRTJCFqx57lGzb/eozkY7H5u+BYXQtkPgLN+/SXxy23PLJ7ATXdbPsfRsDzuU7eIElL4l7G1PTrRnHYc03RybOzzKzCB8orvGIBMUMsXC9KkJZ/kRwxsMcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149953; c=relaxed/simple;
	bh=u5rlJjO5RH7f7H9i/838aMkMKnzlhrJIdsyIaaveGi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ia/+p/PRYdG/BW5sSCmG8ydLyCBHSadpONuLNeBWzieIj0MzEEdSqKOsPchtysSDj1pqRck9EZpHqtE7pNqte6PqhTNQIE/54z3Kf5IRv5J5SUL57KCFkKeyOe4o6MD5Vtd9QapJEFCiw3rzhyMj1dASco1uyIZTTkbKT1f/K9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh3W95e4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso532216a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149951; x=1740754751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGuEcGyCvXU1PZ8BK+/owth/b57IvpYwbhJHbR1V5MM=;
        b=lh3W95e4DaN2U8x35aW9m0V+ocah+URQLFbd97IDlT0O2PU/DTedZL4CsmohHBRivo
         K07X4j89hcTFuj7usCycZ5WGo7HkgGveJvyqOEgUlTP5z1VF33ppJhK1Lq3+akn2WZGQ
         yGyKX3Ejt0GR8TssioxSBzwu/v8O8skchkYNFsCVF19wfNXC0LwCCmKkVr+kKhrtLY8E
         ihtbrcPwtMl6Ej3GQ6qvYnDCmaaln3kPBDKLLnerijCOqwgrFK3qBLmK95xrb+rBffKS
         EpIpvSNXbaFEVOGDIrnwXAAs2qSL4mDgIHUMG4OnHLva1haKeSoCBVo8Du91qSm/Zfxh
         RK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149951; x=1740754751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGuEcGyCvXU1PZ8BK+/owth/b57IvpYwbhJHbR1V5MM=;
        b=wXOodC2siRUYBRmG49on02Wp9zU+u+SljLxS7LHXsde1CQlgTM51+cT1n0ICVfdjqj
         73CjyjXZccGdKlNEABF/00U6GjpHHWzTq+FnXb12kYRke3hQwjoAO1y9piYAcBk9tHDu
         NbCRu/FAYy3aTAwuWvRN+iEGWIojVY5RVctYY5LM6aeX1J2V5tFT4zeytr8bmeg7RBBU
         rdVsR6dHO2qaC6S5JxPbkkWw3WX0XgumZ5hUV8iRBOA1B3IlfHi4RkJJPxoujTz4NL34
         BdJn9HrW0+l9P2wCiRQTxsXp/qU87kclZyRD7rv49Yxl7mPORzE/h2TscMdnBr00LKSK
         WrYg==
X-Forwarded-Encrypted: i=1; AJvYcCUyKQaZVi+7Nw/C7PojLe0IhFN/rLB7krTBp92YnEKOfOajCZREVuDrj4hyqcRDsjNShp3stWw5qPpeFxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97V14FYOv50+T0+pUxr6hEmHm3zhO4BcBM3AnuqWhZJczgHo5
	2Ui0NY+cOtmqwzw0qDoHX4Xm85V3BtAzir5bnxepe3n+5CzA1zExyTeMNIpiE5BEWubvu2Z3e8b
	FYSEcTW6jjSHo3MJoX4UBH2vNnLE=
X-Gm-Gg: ASbGncsyTPsF3RZ9Uu8W6ozol4gLOpUDcfdjV3I2KhbDBVuOG3csGyvb7vEKilwgDBh
	hS/ImAoJdXu12OMuT1hHeBGDtGlno91gWyIPHJWkds8zqgNl8R88mnjRi5lBo05fwmWpHGYDUw7
	Q7v5FCxGM=
X-Google-Smtp-Source: AGHT+IEllMkZI2e2wCc2Ox1K7sQtQj2/KK+wR8W2901yorQqSGwxmp2E+h3TQJAdmzusA0aUyoy57pRZTVLxCkJYH5w=
X-Received: by 2002:a17:90b:4c04:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2fce76a2781mr2322720a91.1.1740149951042; Fri, 21 Feb 2025
 06:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220162750.343139-1-andrealmeid@igalia.com> <20250220162750.343139-2-andrealmeid@igalia.com>
In-Reply-To: <20250220162750.343139-2-andrealmeid@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 09:58:59 -0500
X-Gm-Features: AWEUYZkDQigRBbUEBbX-bkqBNmeQ0_LINBwN_MO09AozMdl7LIZ_Ar3wfltdwSY
Message-ID: <CADnq5_P_+QCeAnxZzf_N6+EgzLM9iUs-XxDaoNYkEzJAO26UGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Log the creation of a coredump file
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com, siqueira@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks!

Alex

On Thu, Feb 20, 2025 at 11:28=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> After a GPU reset happens, the driver creates a coredump file. However,
> the user might not be aware of it. Log the file creation the user can
> find more information about the device and add the file to bug reports.
> This is similar to what the xe driver does.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 824f9da5b6ce..7b50741dc097 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -364,5 +364,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>
>         dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
>                       amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> +
> +       drm_info(dev, "AMDGPU device coredump file has been created\n");
> +       drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredum=
p/data\n",
> +                dev->primary->index);
>  }
>  #endif
> --
> 2.48.1
>

