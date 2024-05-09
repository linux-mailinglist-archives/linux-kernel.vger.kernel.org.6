Return-Path: <linux-kernel+bounces-174941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96D8C17BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12341C21B52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AC7F7F5;
	Thu,  9 May 2024 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfdHfDz5"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21C7FBBE
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287384; cv=none; b=LtGLYduy6XOLijIOYgIsdrrGbULXyImi2tfnuhGOUbWlddjtDwGrAScD5I+h4+WujB6w3cflJmETDwJrNOT5xo9zV21cdavQnsXC0BjQ/DwTdZgpHLxSdBCo/7R0KaoFEq38oPJySui29TCaUz8/Ohcy5xBuLb17coBiUNOz35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287384; c=relaxed/simple;
	bh=Xuyf5D/JeLOVpt2488i7mkV8ldkhM6ZKdnpJaxNMLQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCW3Vp4H7pVqXOJxF/yqcS+F6Uorkrgqv8h8hFeqntVejSG/tcnik+XGbPZHp9pSrLa5qpvkl4y3prGCCGVi2Hcc1FYa7foqmFyWKqfiApfzQcSkcC5XJyIq82wooFfaehgf3JjOZVCEdOFaBwvCMI7G9FfckO7TbdRuYBoe9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wfdHfDz5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso1175386276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715287380; x=1715892180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyO7lOaBJGIXBBRmSEVUT3jjg2maQrneBPVuSy70JpQ=;
        b=wfdHfDz5BFi0szady3flK7d7MdwJdlWlzsjMwbtyiSFNSXC8pubTPPQg+WcMc67RRx
         mXPGmU+Et7MtJcttJ5crfbopZHIlsJvf/snAGpKo6rNzYmttsSo4YzY801CX2f5c0C6Z
         hKDegbw+vCj/POQaAu4ZAbkLMP+D0+mIB7FP6fkw7qVRc6cFb5bsy4ust9RGnzrKK6zu
         YA0DuZWV/UEfppPOfOmLHdllSn5EjE5W8udCF0pmegkp0y5Ynn8BshINJLS83VGSfvha
         5Wu6U8ucX358SVTI4hmiTdnv3smW4PQcBd96B3jI11Ffp13zz0vWLXRiSNyh5/Zaca0t
         TLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287380; x=1715892180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyO7lOaBJGIXBBRmSEVUT3jjg2maQrneBPVuSy70JpQ=;
        b=RsF1DPZmr9guqbevhVrkZhmw4nGAJ5+4qlHQO0ED0OKxcw1eO1kPh2J5vrmwRQJ2zD
         ULzf/eJJWbxhgBpmTdvmCedz8LVXbYq7PLB68MVifqXShP6HzBY9j9IWAQjqq+wYkeh7
         jbdtXLQM/VBIPOOR+PZDixBbi92sOSE7/8huUACAC3xKMTgJu62fbs/grvLwGXobNDpV
         K2q02EaiyMxhk/+4e6ZnQ40RyRHXSP8zDVAiNkPI57tay5bIQrgyNveieEtbFA9YH7D1
         2hPey0EAqh1p3TgFTG72B6NjxcesOzk3T2Q4p6TUnihLYWNMIk46TSK6e+vPgnJZtuiX
         FYow==
X-Forwarded-Encrypted: i=1; AJvYcCXb+y1s57nf3HKR2pBQXyTrK7mUJPGFNBcVgsr6cisaEPAqQj2py9fYYkqfagx1g0dJYN6NcPeKdxiu2WR3pe0ddzeajQGqjd6meSRl
X-Gm-Message-State: AOJu0Yy+xS0WQeJpD2Gld2JkwWax3Z0+FsDISIGIBK9bhJrFl4vJm0bK
	1U9ITKSJqtqt8i0sSbrtm9XcYilSj9LdVQfHgkPYDAd4iW7/Fa5fz54bDsYXqx0fNhRGAL2w6jW
	xXy2AkX7CdKxEa18xVx2KSjTA8cfxQlV/wVSYMjS2sQ7Cc1c/NYQ=
X-Google-Smtp-Source: AGHT+IG+qfOYPvC5Bh3mUYNkbKmgsIu9m523SnqmodnTG2ySW8CcwXrwuEZ/k1V57bmNDi9Db8o7UONgcoAYL1Cwt9w=
X-Received: by 2002:a25:102:0:b0:dc2:3a05:489 with SMTP id 3f1490d57ef6-dee4e4a7b67mr807131276.14.1715287380304;
 Thu, 09 May 2024 13:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-irq_wait-v2-1-b8b687b22cc4@gmail.com>
In-Reply-To: <20240509-irq_wait-v2-1-b8b687b22cc4@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 9 May 2024 23:42:49 +0300
Message-ID: <CAA8EJpqQWN4zE7vn=dG+CNPnU=94z_of5o7NSdom6x3d7nObHA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: fix encoder irq wait skip
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 9 May 2024 at 22:40, Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail=
com> wrote:
>
> The irq_idx is unsigned so it cannot be lower than zero, better
> to change the condition to check if it is equal with zero.
> It could not cause any issue because a valid irq index starts from one.
>
> Fixes: 5a9d50150c2c ("drm/msm/dpu: shift IRQ indices by 1")
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>

In the previous revision you have got the Reviewed-by tag, which you
didn't include here for some reason.


This revision is:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Note, there is no need to send a next iteration just for these tags.
They usually get picked up by the patch management software (including
the Fixes tag).


> ---
> Changes in v2:
> - Add Fixes in commit message.
> - Link to v1: https://lore.kernel.org/r/20240509-irq_wait-v1-1-41d653e378=
4e@gmail.com
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 119f3ea50a7c..cf7d769ab3b9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -428,7 +428,7 @@ int dpu_encoder_helper_wait_for_irq(struct dpu_encode=
r_phys *phys_enc,
>                 return -EWOULDBLOCK;
>         }
>
> -       if (irq_idx < 0) {
> +       if (irq_idx =3D=3D 0) {
>                 DRM_DEBUG_KMS("skip irq wait id=3D%u, callback=3D%ps\n",
>                               DRMID(phys_enc->parent), func);
>                 return 0;
>
> ---
> base-commit: 704ba27ac55579704ba1289392448b0c66b56258
> change-id: 20240509-irq_wait-49444cea77e2
>
> Best regards,
> --
> Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
>


--
With best wishes
Dmitry

