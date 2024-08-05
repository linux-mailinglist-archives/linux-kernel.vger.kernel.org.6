Return-Path: <linux-kernel+bounces-275282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218189482B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60098B211B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C7116BE1D;
	Mon,  5 Aug 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ7xGcto"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE9143C69
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887800; cv=none; b=QiDWRvl3nHP6nRVIka8DAR9FFSv953XBxS7S1/0+5yD/yL69/bjb9Tt2PyIlKFKzjt5AVxJb8RH9SaARvuR2/k1QUkn0OQJAq1jCGfynrZlMwm+b3Kxb9loT+yAHj1MC4PlM0DNXaCjBR8Cq2xSpUQBJSVsTbJ4hftYBOLmXHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887800; c=relaxed/simple;
	bh=/ZrYH5OwtaoqrwpB6E205r8MAW1oQTGdjA5NF1jT7s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sldSwQku/RAMrnomceU+x90dY54hsc8PzOnzPVONA3iU9zWWmP6WwBaWWEhqo9LkYYz1qx16+Ys1qniHZH7Orc/FKiwzkt0JVM+KhH7xzs7XOuRZRAJFY3U/0CYf38hlOZBDgZSN7bA2y+xJXLtmh1iU2CvXX40EiuJ5fPiPc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ7xGcto; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so6980521a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722887798; x=1723492598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNcOQYN/qSiGTFD6/GPizmaarPQsywctbGl3IsVIKsA=;
        b=SQ7xGctowjvPcjIIkFLOfKPCvFOiigV9jijEwALPW3658AeU5uD57541ao7hk7NtUg
         er9q1GkdxOTSjhwTVY0KuK3KZexOSdAKWYH5dg3VgeaGhJowedFlZsdDLiQsntzNKLD5
         rQjInRUHkbjqrDGnvQtMABFpW+PnMHaO2qEeFdFjmLsTc+C0IlCCVXAYDtvL9/xqKu5x
         cUg3kyFn5KSe6FRK2XD3cpJibJTnxvdzg70iYzHXAzOLYCibYps/guoBz+Lv9hKgcAIZ
         PNJS5UT5gohL7fJD5TBoGjiDxQ9Q41pYnCG/VG2+N+yBaAoDwKdPU6nIJRlWCXldpEVn
         fikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887798; x=1723492598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNcOQYN/qSiGTFD6/GPizmaarPQsywctbGl3IsVIKsA=;
        b=BjNZopWFpboRPyazP+NJwqIjyO39D/W2QQZi25NNM5bDp2yVoTPBQPtKLbeSOxRlVF
         gqBroXruJwRhnyBukJSh+Yvlcxf0Dcqj8wj2SN0BO86OQri/zvKo5d+BkMm6AffipGfB
         rqLXVSlUSMzpyhmAXgy5uYAgFxM471pbcx8nXyAvMnDMbrYyHkozXUeFfj7BYS2xl3he
         ypKlNYq8S2bB1BoXwRcO8JJORbdnHSWUbVKtbNUE3junlHj1uz/A3CDvDSGnMBYT1/3k
         4Op44ZvDeHtpFQhjzRt2To6E26V2FxlfQ6/J+Czyi3csacxOW6UzNHd6Ln0FZHd+WaTV
         MT9g==
X-Forwarded-Encrypted: i=1; AJvYcCUEcoTy/p8h50PXl8v9SwHP9PuLqzcA4DIhAvHHWtAEmvBfM6N7GVcBvyzSLiovOh+hh3TqKBjBichXIYoCtvqv3WANsoOqWKM3YW/q
X-Gm-Message-State: AOJu0Yzm6/SXnjKVQoDkia11DNXygazXnqzMNcl/PtyK5LOP2ciiuY4u
	QpO2/XbYdJRVd3TISSOL6P1h8m0f1Q0qijQZjRBKNYwhvUmilpCYFQEd+gkK/r3ykioa3I/eFyM
	M2gOCEw/fDx4z5JbRv+M+uu/P3Xg=
X-Google-Smtp-Source: AGHT+IFIDXUzuaYtUVe9G/vyHgglOXHWrm+LPeM+thU3L+PG1J1Qc3F0nt0E/Bj+1GmCud756KHGJwrkq+K3mv6bPqQ=
X-Received: by 2002:a17:90a:ac8:b0:2cb:4c32:a7e4 with SMTP id
 98e67ed59e1d1-2cff943c2fbmr10837771a91.15.1722887798611; Mon, 05 Aug 2024
 12:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731055451.15467-1-rbrasga@uci.edu>
In-Reply-To: <20240731055451.15467-1-rbrasga@uci.edu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Aug 2024 15:56:27 -0400
Message-ID: <CADnq5_PxBDtk5m7c6pJX_b1fQw_ry1qGALprAZ6f5xR=9g34kQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/uvd4: fix mask and shift definitions
To: Remington Brasga <rbrasga@uci.edu>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Jul 31, 2024 at 3:20=E2=80=AFAM Remington Brasga <rbrasga@uci.edu> =
wrote:
>
> A few define's are listed twice with different, incorrect values.
> This fix sets them appropriately.
>
> Signed-off-by: Remington Brasga <rbrasga@uci.edu>
> ---
> The second UVD_LMI_CTRL__RFU_MASK is incorrect, so it was removed. It sho=
uld be
> `0xf800 0000`.
> The first UVD_LMI_CTRL__RFU__SHIFT is incorrect, so it was removed.
> It should bei `0x1a`.
>
> This change aligns the uvd definitions, please refer to:
> drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_sh_mask.h
> drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_2_sh_mask.h
> drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_5_0_sh_mask.h
> drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_6_0_sh_mask.h
>
>  drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h b=
/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
> index 8ee3149df5b7..2ef1273e65ab 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
> @@ -340,8 +340,6 @@
>  #define UVD_LMI_CTRL__REQ_MODE_MASK 0x00000200L
>  #define UVD_LMI_CTRL__REQ_MODE__SHIFT 0x00000009
>  #define UVD_LMI_CTRL__RFU_MASK 0xf8000000L
> -#define UVD_LMI_CTRL__RFU_MASK 0xfc000000L
> -#define UVD_LMI_CTRL__RFU__SHIFT 0x0000001a
>  #define UVD_LMI_CTRL__RFU__SHIFT 0x0000001b
>  #define UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK 0x00200000L
>  #define UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN__SHIFT 0x00000015
> --
> 2.34.1
>

