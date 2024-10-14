Return-Path: <linux-kernel+bounces-364557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A2D99D617
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDB01F2545A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6346F1C7B7E;
	Mon, 14 Oct 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsliI3Ta"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027A13C3D5;
	Mon, 14 Oct 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929060; cv=none; b=dpz27abRrLqlArhsRS+0oRmAfeAZapQAVE36VHGgJRl4y03nRJ/ZFhxmYtom60UwIXpCKpe/eGQuMbGtIMrBoVP5nVBxym17VZq5CnhOk1BpFJ/SnhP88XsnJPnj9Z9hVAmtV4VbsTC9EKzddta51KlYBERk/Bqr0kx9np6Ld1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929060; c=relaxed/simple;
	bh=pgIvhX6DWi2lVx8GQBAGHBczkT4Q44P+FeEZFYw/8XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvl7myjtZP9MThuLDSAOfnZx5BXqPFVmfTpmyjN5j6Pu7p8aoNMlP/VTmyCQ2WggiNTHrSVy+doXLka95TN9Fq3rxP5ONoUPybRLhO6UaxgPMSTlNNYKl9s4FJ7n3Ykxb9Kx30CydrrTvNxl3hp4LJqFjQnwzXAY4efLN5d1sL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsliI3Ta; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea3e367ae6so448686a12.1;
        Mon, 14 Oct 2024 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728929059; x=1729533859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bvhwh3gLG6gcnOHuIbpfqhWVaibVg9c2c2Ldevdyqjw=;
        b=XsliI3TaFgV1kvK3Rs/2Og8CJr3NLT0Y4jOhO9kAKHa3fJH8Lb+Cxi2epo+7NmFzOA
         WVf/gkVoblPUGsB/5AHI4BojsuKZthMe34yKYkN+y71lAj59RNxvO7hJldC40egYZrEU
         FYkSBJB6ukRJxzndMINA4WQS0KKOsPSWA/8WEs/5/v/zAtZHCJJzmdtnpOPiBcbZ5tka
         G6GracXY07vF8LvCt0jzbR1W37DL8U04JwJSVeA6wMv80HtK5DAj/IeehUkjAss6USNE
         r6b822BYQSIBWEc3nST6yQvG8dS5njf2y/PTOvlcWivtuvXUZ9eCnUEklbq26ql1QFH3
         /tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929059; x=1729533859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bvhwh3gLG6gcnOHuIbpfqhWVaibVg9c2c2Ldevdyqjw=;
        b=orii51HglYovEHZoah9TmEavz1Vwk6r9oLwAVfyLDzJSZfbNsEqNQ/huo8KQjq+88l
         zTn+USHDzF94hrS5TUYIpegiwbNVFlxLAx3n9nezTxcNTFp9cmPqebW3LUvViHftkimO
         f8FUq7dHOa5zLPzxQs4Vdpd8+efpSeGG0fL8kAQrpwwt56wgsTT6IgtH9wdqDUd9sjlL
         JR5cB/l6DBVCuzLQql27T2kvWeUgQ8xD226NMmdR9yas5hH98vpGRnQessQtRfqJdOfF
         H/UEx5RcdcoKxPmaDma/Ifh4NaYpl14hl7ZqiPyqoL3jLEdjFHVt2R6Si5VuPtnl4M/X
         EDfg==
X-Forwarded-Encrypted: i=1; AJvYcCUEQhcukePVPfPGSshsaBKW/G7bErOTTjxfvspmW6cQAah6Z1rKQsmAkISSZJmi6kPF/ejZxhxj1QEmjhQSaDw=@vger.kernel.org, AJvYcCXNn1dtPsj5CW1pa810ajdqNEe/Aa054Vn6AAmn6Nyt92DfR7nz87EhbdtOr2/tAU29/yaOnct62VhTfMLv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83RX+QBb3M7FpLTAnZjEsRIeNTe3C+jv8iSGIov76mVHuf33z
	QfvJJYXJ/P74cSj7sJWegdRG88QrJZbGhxd8aJKCDOb1OYQZP0hD4Hj10kPXymGPheIfjdj+Ote
	RAqPKlcd1bZmomedYflJC8IVP0P0=
X-Google-Smtp-Source: AGHT+IGQSiVAhq5p2Nni7Nqi5xdR7AQXxhYJRI8o2X32oWs0TAqQmtICSbeIENaqYKnuwO6PNosi2vKWXoxwvpo5zSg=
X-Received: by 2002:a17:90b:318:b0:2e2:a70a:f107 with SMTP id
 98e67ed59e1d1-2e2f0a11479mr6745183a91.1.1728929058628; Mon, 14 Oct 2024
 11:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3cf409f-2b04-444f-88f0-9b4cfe290667@stanley.mountain> <a1acb975-c29e-4c90-b7a9-5f50478ab946@amd.com>
In-Reply-To: <a1acb975-c29e-4c90-b7a9-5f50478ab946@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Oct 2024 14:04:06 -0400
Message-ID: <CADnq5_M-Ccu8cN-aSx=Xu3+mSCx7HV1H8JftJk277u7qvCLXvw@mail.gmail.com>
Subject: Re: [PATCH next] drm/amdgpu: Fix off by one in current_memory_partition_show()
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Oct 10, 2024 at 11:18=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 10/11/2024 12:05 AM, Dan Carpenter wrote:
> > The >=3D ARRAY_SIZE() should be > ARRAY_SIZE() to prevent an out of
> > bounds read.
> >
> > Fixes: 012be6f22c01 ("drm/amdgpu: Add sysfs interfaces for NPS mode")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.c
> > index ddf716d27f3a..75c9291ac3eb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -1199,7 +1199,7 @@ static ssize_t current_memory_partition_show(
> >       enum amdgpu_memory_partition mode;
> >
> >       mode =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
> > -     if ((mode > ARRAY_SIZE(nps_desc)) ||
> > +     if ((mode >=3D ARRAY_SIZE(nps_desc)) ||
> >           (BIT(mode) & AMDGPU_ALL_NPS_MASK) !=3D BIT(mode))
> >               return sysfs_emit(buf, "UNKNOWN\n");
> >

