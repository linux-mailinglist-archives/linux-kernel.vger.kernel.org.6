Return-Path: <linux-kernel+bounces-311738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C987F968CF2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786B11F22EC9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931511AB6F7;
	Mon,  2 Sep 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoG3a4uQ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2538396
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299223; cv=none; b=CduY/vs1A5CG5CJAW3eQYIh/U3KInAO9aEgsrjSzXt/DSH4w4FRrm+luEJeiDAV0hN2TPVkjtNBdUz5/6iEpTdGPEhiPyfTvUk9aujyKkBWdyz6mcJxmDq8wxujJxKnw7OV1MPu3GMwOpShtHnOZMEoRCtcey9ON+vb5rWypXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299223; c=relaxed/simple;
	bh=4Xg6DlGnTEaNPPJxfeqZ9IRzoJyN+atRjSPf7XlXA+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hw8Lav/v36BFowniMQEFVt7wE7tkkK7stSb0dY+DFaZh1xnL57TBaXCpM3/uHy9PCYxqC394k2CGlII+GtWDRFs4vaKleEgy4EreSVNV/MvcuC8rx4uWe8U+TY7u3/z6DwZMTPOe/qTITupcezCKDbebZZgzLhECQ8EavI1KQLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoG3a4uQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2055548469aso2706655ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725299221; x=1725904021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5dsshy/c+kaWBmpWBBqZVmXiicMNvJuoJNc+L9CI4k=;
        b=LoG3a4uQyDBpMSwkepvlhtoqD8m7bIEJAwdJ5ksz9qodzMWLiuHs5iimJPOvILUbvY
         JsdIIFG9zCe7nDednxddoFJxr97A2wxVg+zTdSrC/nltWKqrN3Hb87WwQ3SYvk67bSd+
         QuHc9lNw9pqstuILNsm9G+1dWSho2NgIirocyzvOPgVOiOyaCaJcj1dDX+pAIowId7IX
         g6x7FzV6vVB7D2dw9VmDWwP2zsnE6B6rvrfSdnDfSb4As3l6aXeVPpRuYjPWeQxXor00
         3vpUIORULIuA1Vc6RKl+8ZMVeHZeo89BJG6ziS8xcbt54lkt6ikxxKjQ5XaO73p5wXOZ
         7yOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299221; x=1725904021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5dsshy/c+kaWBmpWBBqZVmXiicMNvJuoJNc+L9CI4k=;
        b=RzHeqSyIppUACCjjVrXmunNRze+BdU+soffGWlgcIP76wxKOwPFL+cli92ORmdtnAS
         Ip3HlvVTFUvthHarw2FRZCaWDAHVXp+Uwfgwp0jLbenCvpyv/JUMy2+z6IKLD4YBvNzW
         C3cCnQcy4bsGDQIhd9zrPqFnxMk/PtCQm5E97Dfdriy9WmbjvARg1CE4X27GaqkoJFtq
         QC30Wy0c2LbXdHgebICbnuq4lfK6vzzTc/tdYgtexVJwcHpTTqgwnL1AduLc0tUevV0B
         pR8Cv9ahcSyC2DJ34g50ZcCjE6nGgiS0vE3y+kITcOHSvVQxjrXcknC9uS2Qisq9CYlo
         tYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtSxA8hgFXsH2N/MAof0Z1sdGWZm3V5GsHUdyfX9FFKxHLTj6YeRAd2SuN7O87iyYKBKHZltqQzt8h7pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZaVNDzsJ4euHzPPqpxwhG+72XbZ5R1IsqeFDaBJCKr4SDFibW
	X6WvEMOPnnjkG91xBygsY8xQ3ju2/gZ/uhcT8Vq1BWQMvmcz89aIZnia5wn4uuexkQR/kzCub0i
	uBXLCwjcSuH22pUP5hmrmEO+U5LU=
X-Google-Smtp-Source: AGHT+IHLPLQSiXJyGvUinhSNLnatd1UsY5FyvVDChDU2kqJ0Yp0NfNjYZj4NYw97xpqV/8VKDLtnj4VfPHj0wFRji9A=
X-Received: by 2002:a17:902:ce8b:b0:205:76f3:fc22 with SMTP id
 d9443c01a7336-20576f3fe16mr25817525ad.3.1725299220657; Mon, 02 Sep 2024
 10:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830072708.128502-1-yaolu@kylinos.cn>
In-Reply-To: <20240830072708.128502-1-yaolu@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Sep 2024 13:46:49 -0400
Message-ID: <CADnq5_MmsZQynuYPz64UL0jCE3E80MU86RNR4+rM9yGtDqOWgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable gfxoff quirk on HP 705G4
To: Lu Yao <yaolu@kylinos.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	sunil.khatri@amd.com, Prike.Liang@amd.com, Felix.Kuehling@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, liupeng01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Fri, Aug 30, 2024 at 3:27=E2=80=AFAM Lu Yao <yaolu@kylinos.cn> wrote:
>
> From: Peng Liu <liupeng01@kylinos.cn>
>
> Enabling gfxoff quirk results in perfectly usable
> graphical user interface on HP 705G4 DM with R5 2400G.
>
> Without the quirk, X server is completely unusable as
> every few seconds there is gpu reset due to ring gfx timeout.
>
> Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 2929c8972ea7..bd17e32b432d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1301,6 +1301,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxo=
ff_quirk_list[] =3D {
>         { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
>         /* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
>         { 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
> +       /* HP 705G4 DM with R5 2400G */
> +       { 0x1002, 0x15dd, 0x103c, 0x8464, 0xd6},
>         { 0, 0, 0, 0, 0 },
>  };
>
> --
> 2.25.1
>

