Return-Path: <linux-kernel+bounces-434102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459489E61A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F84281DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF91FDD;
	Fri,  6 Dec 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YydW9UJQ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1781E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443537; cv=none; b=Jlf4Nnhf5MMvJMGfs2Yyk5Qf2ctS7bv/TPpver4r5erwHgilwrAayvBsIgjOcNU/no0mCzbkPEvY5HOZTA0aNkQZ06QuND53MHuV3MaxTppDAU8CCVda1NJV5zbBOgDS9dVVc3r3XUIoRwh1RouEHD4Mv5PJhNu6UaGF9aYdFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443537; c=relaxed/simple;
	bh=irTCkX6At0E1tiMfR3zLyBQHCK3QY/or93wCzKF8HFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKZrux+/3/lBA/u0o4hhzwtGo9ae5u2CWI7DBLWN4y2aAropVXPV1rbtewOszIw8vXa8pZzmMd9Iz4s7EmeXJlZyNSBC4LySXJeOQPpi3OVObjKInBDTT1WADPR3Bd7vXlR9l2cskT+bdaUrOEC5ITyBfFNwRmFD2XsUqRtJEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YydW9UJQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30020d33d05so12448681fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443533; x=1734048333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOo5o1IkcWYIYeHg+0oB2U3HqNWFzIG3pPjklrK0UCc=;
        b=YydW9UJQUok3OsZUG8TYn0P+98Oy/yqSCgKc6/P/6wMLek1XPmiCA3gscbHbG4Jb1h
         oDGuA4nY73W0sOUI6sghJWrx7eNXQIw6W7G/gC3slVx0T0Hdiu3NXq/tAd2BMqbs8CFW
         wGyGfR/dj7sWkQtZUIPhnlp7+myj4sxzdYA+RTh29mvtXGETt5ZGMBfJG+qGbOP4YAM/
         +dXl9TGopIRMEDcb0XiQBhaKSrjKIdGMdgP7FXxPlBcAAT5pClzgpLQS4d+JW60V4NPa
         cdrAVWjbYe3YWKgByaEGEwgEwKqA85qz6j+tfJQ3BqmYy4Q6N1O3QATvvLftH2OyY4K0
         pJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443533; x=1734048333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOo5o1IkcWYIYeHg+0oB2U3HqNWFzIG3pPjklrK0UCc=;
        b=tcHfkT4NbGGY1UIGnskUVFO51d7Oy4VIlJE599954EIuS0yEHs1VbF7F4KHxZsYGtb
         PpDLkbA0NkXZsS7OCIv6mbAh2GJWdFklS50vjMeCtEvJ4ixzcvlKHD5Anr1qSfPhIxL3
         PVQqE8WyhZx4y2Ab1GdfqRdWgz+nH7sgTUxGoKE3Xw6Rg7jZsSSVip6lcjS3qZ88TFVJ
         lBgELdKJV0BHq7fj8nzL2KVpsvT4VrHmV1RaUg3Y1+BFG7774BdyDWVr00u49o2wwCeQ
         bQiqhDDRCptnWCqqy7sP1YdEr6nWWy47fI/NO9TrSet80A+8JTEZI3gY9bOUKOvh+9o3
         3nQQ==
X-Gm-Message-State: AOJu0YysHE8uAfQ20tsYzLpcXAyN6vKEzCd3HsvQsmU6LUBEttT5cPwo
	bG/IU9YG7US5yuwgvzHDbWc9rZsS4mBNTqHVWCOAxwu8Dv+LU6XKgXr73YN2P5Cd3V63T1WQDT9
	Yd4k3QlfNNX29Oo8D5gduM5LLDzqDpHHif/l/
X-Gm-Gg: ASbGnct6uA96y44CCAMz0euN86o0Jk2bYWXpUBILm4J8ejAQml4BSHcMsaiQA/ucEhM
	5eK/e6+TDt18JZH33vMMzDOqdTIr4qA==
X-Google-Smtp-Source: AGHT+IGyZ/TZMqzTp8+it+xJqPWDkQKwRdqrGP6nkAD/oOmQhsRauaZCXRwfpEP8IRWA2Z0RTrR2gBDTeLWDpYubwUw=
X-Received: by 2002:a05:6512:1189:b0:53e:18ac:b1fe with SMTP id
 2adb3069b0e04-53e2b6ba9abmr349123e87.1.1733443532699; Thu, 05 Dec 2024
 16:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221859.2248634-1-sashal@kernel.org> <20241204221859.2248634-4-sashal@kernel.org>
In-Reply-To: <20241204221859.2248634-4-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:04:55 -0800
Message-ID: <CAGETcx-u9BuPLiJ+Hn_29xmR_W3d7jC=uPFsw70eC65CZ_9UtQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 4/8] drm: display: Set fwnode for aux bus devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, sumit.garg@linaro.org, ricardo@marliere.net, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:30=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Saravana Kannan <saravanak@google.com>
>
> [ Upstream commit fe2e59aa5d7077c5c564d55b7e2997e83710c314 ]
>
> fwnode needs to be set for a device for fw_devlink to be able to
> track/enforce its dependencies correctly. Without this, you'll see error
> messages like this when the supplier has probed and tries to make sure
> all its fwnode consumers are linked to it using device links:
>
> mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) wit=
h backlight-lcd0
>
> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@=
notapiano/
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Link: https://lore.kernel.org/r/20241024061347.1771063-2-saravanak@google=
.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

As mentioned in the original cover letter:

PSA: Do not pull any of these patches into stable kernels. fw_devlink
had a lot of changes that landed in the last year. It's hard to ensure
cherry-picks have picked up all the dependencies correctly. If any of
these really need to get cherry-picked into stable kernels, cc me and
wait for my explicit Ack.

Is there a pressing need for this in 4.19?

-Saravana

> ---
>  drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/d=
isplay/drm_dp_aux_bus.c
> index f5741b45ca077..951170e1d5d14 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -287,7 +287,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
>         aux_ep->dev.parent =3D aux->dev;
>         aux_ep->dev.bus =3D &dp_aux_bus_type;
>         aux_ep->dev.type =3D &dp_aux_device_type_type;
> -       aux_ep->dev.of_node =3D of_node_get(np);
> +       device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np)));
>         dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
>
>         ret =3D device_register(&aux_ep->dev);
> --
> 2.43.0
>

