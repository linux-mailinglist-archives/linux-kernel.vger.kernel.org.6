Return-Path: <linux-kernel+bounces-174728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FF8C13FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A926281D21
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305710A3C;
	Thu,  9 May 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4IDdgAB"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62040111A2
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275459; cv=none; b=sAVDm7ADoJFKAW/SCpCU5gzNRUqtbsE9yiruP82zs+am2e55ebfb+vTYkzeQaaB7WQqTg2sRVvcsQP5T4Jc7kyK2+JXRwDL5G5Z4YAJKEuTBQAWY+H/qnpM71ANh7Q0FndGMxR9ah25sfZjxSTVdXabQwOi/ExEffodrSBBhboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275459; c=relaxed/simple;
	bh=wYTJaF8JxZfB6p9pfrZ9UzFnXVfNFMMSBvDLM2/Agrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9LX9dtDPNdKQ0cIo0wEDGBj4GjMD6dB5AOsQmMQqQ7LzHY9cvkr1BGK0C1Tv8E6PAPrVEO+RDfRfXoAcwLufKfa+QKkZRiD/0Cs7S/mISQenZrWU9AGS/dLYGZZyUdMtpt05LsMrhbDm4Okmf5itlH6FnbBbDA1qxuBfVZcepg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4IDdgAB; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48071b76e48so291561137.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715275455; x=1715880255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJd+PuqR17Eq0A33REJzZo/D4RiASDpPnK9j9wlnmj0=;
        b=H4IDdgABBN0yQ8EnKqAciIg5/9mM7CYvQTVg5E7K93Ijk4CA8wl7RT+ZjOP2Y0fxJr
         nk3TBLYmJoeK2etE5cTBZKvgG68jX4Eb3MbbTozJA+ooPX3l9dcFLjgaZ7567gFzyr89
         T9NnrD7k2qEYxjYOcBrxKq5Ufxeeo6tD4dnSe8TlaVCf23d6WVPxKojJOR9ElKlVrVu3
         b5ukslgdKKn+i73a/a5Qh18TDVEqXjH0ioe9E5dmrkVfEYp5pbcesZLG2EoucLfn10Tt
         VvHlp5gXt1rgnpUfZMXoOsgEQqYORpxaLGzWtnNqvrMBmUlVdPPsn9yA1o50RetK04zP
         +N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715275455; x=1715880255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJd+PuqR17Eq0A33REJzZo/D4RiASDpPnK9j9wlnmj0=;
        b=YYmo6Za7gKGI2rVfB2Yb4qbvWDrxbVCNjr2jDdO6eB+l1Y+iaXTNsi2Ci0G8pqMy6F
         thYZp8/6LuZermiKqP+SN3cisaVrCDxCo9ynUKIBPLVS9c4oJQ7k1iiZr8R3PICF0sZk
         PTHjMMJpejG6irAwiqYyGxxt7stnBgJOQGju9C1PbYyPe6qeKSfBByQzH7vhnSDceSCq
         L/7hXvN90ZaG9b4s9SpyB2l5/BBWTVOKbW7/tYHi6LFXZP0nlhxa8Xu+FJcLKwQCqnjL
         RJzI7sns7LTOkvzl1R9plu89zNFZDqHhmwAduI1VKXYIUnCtc/AgZqnTzUjZoQeeUCNP
         wLfw==
X-Forwarded-Encrypted: i=1; AJvYcCV0ZIQ47pVRqSsxZMzs4Iy7wLbbGaGyh3OB6+HSm1RBzyq7vX/MSNBImNa/Imp9/ZVHJmP18mEtfBjEjXh/HiXZkCupCB+3D6FMAX4i
X-Gm-Message-State: AOJu0YzUlwsgS+7LFjknc+MXREB3gGNbvrGuSsfhjgR+yubJ1XQdFckw
	GXcCnng+QHPFiZoEGnrxE6OZnHroqaxs2WmVVL8RLTiktekH+Xu7l7RPNWKl6mLpBi+GBY9YBBg
	L/6dar28iNv5oXRdtuVAOi4kfi+Q=
X-Google-Smtp-Source: AGHT+IFIfCPVf9kp5qmitEYk8xDqLze2HZWBff7JeN7fK57HlQlsrtYhoPHxCRxQqqzqofCsWzPXPyIKBQYvrDLRxn4=
X-Received: by 2002:a05:6102:162a:b0:47b:9844:8f8 with SMTP id
 ada2fe7eead31-48077b68500mr680273137.6.1715275455196; Thu, 09 May 2024
 10:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509085758.123046-1-oushixiong@kylinos.cn>
In-Reply-To: <20240509085758.123046-1-oushixiong@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 May 2024 13:24:03 -0400
Message-ID: <CADnq5_PB_6Cz0UuYh+jEZeuE0Ld4f_ehf_H4N_rO=-ZqdfSQdw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Delay Connector detecting when HPD singals is unstable
To: oushixiong <oushixiong@kylinos.cn>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Xinhui.Pan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 4:58=E2=80=AFAM oushixiong <oushixiong@kylinos.cn> w=
rote:
>
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> In some causes, HPD signals will jitter when plugging in
> or unplugging HDMI.
>
> Rescheduling the hotplug work for a second when EDID may still be
> readable but HDP is disconnected, and fixes this issue.
>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index b84b58926106..cf0114ca59a4 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -1267,6 +1267,16 @@ radeon_dvi_detect(struct drm_connector *connector,=
 bool force)
>                         goto exit;
>                 }
>         }
> +
> +       if (dret && radeon_connector->hpd.hpd !=3D RADEON_HPD_NONE &&
> +           !radeon_hpd_sense(rdev, radeon_connector->hpd.hpd) &&
> +           connector->connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
> +               DRM_DEBUG_KMS("EDID is readable when HPD disconnected\n")=
;
> +               schedule_delayed_work(&rdev->hotplug_work, msecs_to_jiffi=
es(1000));
> +               ret =3D connector_status_disconnected;
> +               goto exit;
> +       }
> +
>         if (dret) {
>                 radeon_connector->detected_by_load =3D false;
>                 radeon_connector_free_edid(connector);
> --
> 2.17.1
>

