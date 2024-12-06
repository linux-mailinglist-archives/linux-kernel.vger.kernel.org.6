Return-Path: <linux-kernel+bounces-434104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6B9E61AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42654284E21
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B26310E0;
	Fri,  6 Dec 2024 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3c+eLsS"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7515D1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443576; cv=none; b=nbgqkuTrn06RwPaqXUp1l0T+ChhhoznYDnanOtx1FK1z7iXuCywYJ80sskhyySZ9GtBdMG9l8ahssUJPj75+MGZzbSk3QC5u+2F7XdbMTynYfNCLL7dJBuLBgEoPECTP6D9ZnU2xQKwz6pI5x8whZYFf1+h7l1o8rkvMqX5d6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443576; c=relaxed/simple;
	bh=+zZb25sMPo1UW2p0NvN0+h1r64JQsSf3ZFc+L3R3AC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiMaEKFPs1B5+OHKG0WctiPfGItbLSeSVc17h9ZZixF8WfpZs7KJjHeRd+Ph1kuigW3ip1YHiGFhORBjZXO10F4rVxeL6PQj9MGpPNNzJk5zslCeyQ8Xs0HFBcf+WfNsP/WxhMBOQ+2WZwsGHUJOHwj7WWlDsfZdZeHIbTvi1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3c+eLsS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so1427007e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443573; x=1734048373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3TPBP6t+GJK9sLABw7iuDGZ/6x8FUIQxd10a+gfRfo=;
        b=L3c+eLsSY1u+Kl7uqpIoECXQaxp9MP07TBJ0zS9a/R1Z2oAz4NPlQEv7GSkTHYH0FD
         VehO/QDdf1bpPaBM6qTtJbPCK0T0HlLVcW4IMge829LN3Xen7YYkrCZBQxi6EwiPm0oE
         FliNukaTj+YJ5JXknqMjE0g8R4iEUMXHcKn+W9J+KOyao6Vix/804uuYvbxOD8jPOy/8
         MnzWxe6aCg2h7HnmUsh/OXtX9d0WAeomS8X9QyxYGdbjGn2geZ6pKCcOezeKfC2AHm4U
         aKju48/lR6VcBHNOfOiJxJ9l5lpiN+t4tm+kuRxFzv4bydvh06t3mPkB9fOhVaA0kzrf
         ISmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443573; x=1734048373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3TPBP6t+GJK9sLABw7iuDGZ/6x8FUIQxd10a+gfRfo=;
        b=k/585sm/5D+ds7cAflLVqhbr+crGX8C8Dwfgz9cj47BxLzCEnBdftj32sLji0w8NC+
         3+v3OfsXgfayQs+WG7HRscBBHC7nmS+KAbaEjFR1FTos0kVHvcMh0PZD/XD8hQtNMrE4
         u5mwDtf0lIbNMENl8rvHcUeVwAyQfxqn7SXAVwDQRhM06r9bLjlHS1sJbPZQzm5AQBd+
         u2h7zfINQE25EjRxtgrE/6NeWHYStNeTC3i5ZKBXvX5t+IkHFEhA9kGxZ2E0c8yXfzgO
         73uscUqPKh+Dj+zahGRMrm4diLVzEHjm8bsZVOK7w9S5LuTEKzmcCJ/WOj5Z5G2hmFAt
         Jviw==
X-Gm-Message-State: AOJu0YyjYoptVB7dQwAFEgiUQtEqGuJ/VViyYdvOdgYur+TpuHvLUtfe
	4SxgVhyFBedo8a3fn4tpVcUIVq4p2YFq2ztuiIlDhf7KmmMswUTCr0e5jYPRh3HsQTEy+zZ+K8H
	76/s+y2tWf5Io+QsGArQ57q0nerIlkmN5WkM9
X-Gm-Gg: ASbGncslNKPQM6d/DXH20wFvY+efTBUD5S42dhCHMg7vyap5szDmXrMKrM5rb/bGV7S
	gdND3Ey3c4pw65sB2z52zrrpfl0giqQ==
X-Google-Smtp-Source: AGHT+IENUCJT3jmuSq+uuBSoJsgvgSBDBHg4ob0uMlJQb0PpgFG3hX9cyDh1XGO4hDnpY6OiQOw6us+nrtPgXeARTyM=
X-Received: by 2002:a05:6512:104e:b0:53e:2116:fd2f with SMTP id
 2adb3069b0e04-53e2c2ba477mr238894e87.24.1733443573131; Thu, 05 Dec 2024
 16:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221820.2248367-1-sashal@kernel.org> <20241204221820.2248367-4-sashal@kernel.org>
In-Reply-To: <20241204221820.2248367-4-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:05:35 -0800
Message-ID: <CAGETcx9RpUz0hR-X+rO6yKRxOmrMLveU7EMSACF49kMTMqdaRg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 04/10] drm: display: Set fwnode for aux bus devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, elder@kernel.org, sumit.garg@linaro.org, 
	ricardo@marliere.net, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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
> index 8a165be1a8214..d15c0f184983b 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
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

