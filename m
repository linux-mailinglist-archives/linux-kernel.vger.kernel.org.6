Return-Path: <linux-kernel+bounces-374645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92679A6E00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A611C2099A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6FE12FB0A;
	Mon, 21 Oct 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="WrFeqS+Y"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E509126F2A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524108; cv=none; b=YG9DWJrhaEP87x1gtJaHimySBOPM2oIXC7OK62s1sMeo9ltAjyf0fLw1VgMU4L+46ebP3C95//1mb1/tsL2HAEG+mYyjqbcT0OypDNqfhN9E2O45y0abBD8CFzcJT36P0BcZrkGRR6NtQ+yt7B0R+HISiZFVKvdVZoKd/oyHptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524108; c=relaxed/simple;
	bh=PWJXLI/zc9+YfPp0JQp12zzhzEBvi/Lb9IqoZrMgbPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8nS230ZNgwBhywXp54V0tzDF2Qwlmo7L+QWHberqGUBr0BD64l+RVRGwWRjkx9npOFbcvGQwf3Un9Sjcs5qLBiVzDSz7sO/QiCGukul4lLsFcL4cZWoMMyTXukRPW4Sp3olahHule9HmpoBqYzWHmE7G8/Mb/Z8QMq9pXeRSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=WrFeqS+Y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e3f35268so2800612e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1729524104; x=1730128904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LJXhrYQrk3gwAFgilc+sphvRBz6z5yynh7/PAYChQI=;
        b=WrFeqS+Ysiuhw7Eo/UpXWMqXdXbx/SsjTo0ysaERqcoXnajWcqZGzKA3Z/hH8Fswfe
         5vje7pCj4mj8Mv++qf9y499PRavdJwrXDVP5V5GeWNMykN6c2jYViMIvKH9IfWd9nccL
         eNhmmoGDxHfQqwMcRBHlyWZCKRjyUFuNSQKKzNtXpqnj3RKDNIwWVfdfQbIy8Tg9ebgl
         bymHK1HfcGKPBrpzgqyYkQ5+BXZQNQ1kAWAYOMEWBGUc0IRYcgtdJ0qh40SRZ8Z3EBmi
         EvBeULylkA7d5baT2RGQvFQqXzAOe2OxC8tIVNdH4eQI9ueDTLmh+FE6X1YSnjFIEaSy
         UpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524104; x=1730128904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LJXhrYQrk3gwAFgilc+sphvRBz6z5yynh7/PAYChQI=;
        b=GpHV9jy3a3ttEW8Kp8+p63pnwhOKaIUgyRhHUQKXhUMGtCbbJXPQjmjMedUFHZ6B0a
         tpnIexr+7hgyRRx9lWcyofXpMn6PLiNvImhvtE2xkE/8+bqOvTlxansoJOXkj5YJaZaV
         c7ygvuTbE1ekwu4/keIqCvGgwsVsXt24oawJr92udqjO28aBv5vQdrk+JYpoeAUfJCai
         mZLZVE/rFeRkheh3K/X2WbmispIUHDGTD6twtp3Sb5lDFand+vBnCNZLjUiaBOBikwg2
         4wR6Dg74P+1nMONgtRguWrpGCuMQOq8o6WvHK0qnJv6KCnNWUuRsFp2fc3/hMgUDTKU2
         ecZg==
X-Forwarded-Encrypted: i=1; AJvYcCUkC9kjUpOOst9TdazoqJz6i7ObQ4ywZF8Qws0Jh27VoMVxfzMlgGV18BJphsQrPRfBVS7G2HEhWkeJJTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3vZZ2Sg1VkJunsT2o9jTbnXpn/CIfoQJif3mcNVTd0yTjyYS
	Ad5u4gTjuQdYAnjGpQgqc7kDJd4TegqLUPH8eUuuKUAyQw6sX2GRRMlcYNu3ckefieObh1wLAnN
	OAoqkXbbNoeWOlytrDwpXiZj/BdE6NB6ujJ5X
X-Google-Smtp-Source: AGHT+IFXYdf/1S8sUivCEKQLffjqH0HbVL7pn9283MDgZzq8osSfS/mtwn0YAPg2ee14WNWmqyFbTcTg/tuCM+FRyAI=
X-Received: by 2002:a05:6512:31c1:b0:535:6cde:5c4d with SMTP id
 2adb3069b0e04-53a1520bfaemr7096304e87.3.1729524103994; Mon, 21 Oct 2024
 08:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com> <20241021-tidss-irq-fix-v1-1-82ddaec94e4a@ideasonboard.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-1-82ddaec94e4a@ideasonboard.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Mon, 21 Oct 2024 11:21:32 -0400
Message-ID: <CADL8D3ZcvynQCGLCcbK=U9-2WB758abLcKaNkTtXN8Y7s=dyqQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/tidss: Fix issue in irq handling causing
 irq-flood issue
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Bin Liu <b-liu@ti.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:08=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> It has been observed that sometimes DSS will trigger an interrupt and
> the top level interrupt (DISPC_IRQSTATUS) is not zero, but the VP and
> VID level interrupt-statuses are zero.
>
> As the top level irqstatus is supposed to tell whether we have VP/VID
> interrupts, the thinking of the driver authors was that this particular
> case could never happen. Thus the driver only clears the DISPC_IRQSTATUS
> bits which has corresponding interrupts in VP/VID status. So when this
> issue happens, the driver will not clear DISPC_IRQSTATUS, and we get an
> interrupt flood.
>
> It is unclear why the issue happens. It could be a race issue in the
> driver, but no such race has been found. It could also be an issue with
> the HW. However a similar case can be easily triggered by manually
> writing to DISPC_IRQSTATUS_RAW. This will forcibly set a bit in the
> DISPC_IRQSTATUS and trigger an interrupt, and as the driver never clears
> the bit, we get an interrupt flood.
>
> To fix the issue, always clear DISPC_IRQSTATUS. The concern with this
> solution is that if the top level irqstatus is the one that triggers the
> interrupt, always clearing DISPC_IRQSTATUS might leave some interrupts
> unhandled if VP/VID interrupt statuses have bits set. However, testing
> shows that if any of the irqstatuses is set (i.e. even if
> DISPC_IRQSTATUS =3D=3D 0, but a VID irqstatus has a bit set), we will get=
 an
> interrupt.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Co-developed-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Co-developed-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Disp=
lay SubSystem")
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

I assume a reviewed by doesn't make sense since I co-developed this
patch but adding my tested by, hopefully, that makes sense.

Tested an equivalent patch for several weeks.
Tested-by: Jonathan Cormier <jcormier@criticallink.com>
>
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 1ad711f8d2a8..f81111067578 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -780,24 +780,20 @@ static
>  void dispc_k3_clear_irqstatus(struct dispc_device *dispc, dispc_irq_t cl=
earmask)
>  {
>         unsigned int i;
> -       u32 top_clear =3D 0;
>
>         for (i =3D 0; i < dispc->feat->num_vps; ++i) {
> -               if (clearmask & DSS_IRQ_VP_MASK(i)) {
> +               if (clearmask & DSS_IRQ_VP_MASK(i))
>                         dispc_k3_vp_write_irqstatus(dispc, i, clearmask);
> -                       top_clear |=3D BIT(i);
> -               }
>         }
>         for (i =3D 0; i < dispc->feat->num_planes; ++i) {
> -               if (clearmask & DSS_IRQ_PLANE_MASK(i)) {
> +               if (clearmask & DSS_IRQ_PLANE_MASK(i))
>                         dispc_k3_vid_write_irqstatus(dispc, i, clearmask)=
;
> -                       top_clear |=3D BIT(4 + i);
> -               }
>         }
>         if (dispc->feat->subrev =3D=3D DISPC_K2G)
>                 return;
>
> -       dispc_write(dispc, DISPC_IRQSTATUS, top_clear);
> +       /* always clear the top level irqstatus */
> +       dispc_write(dispc, DISPC_IRQSTATUS, dispc_read(dispc, DISPC_IRQST=
ATUS));
>
>         /* Flush posted writes */
>         dispc_read(dispc, DISPC_IRQSTATUS);
>
> --
> 2.43.0
>

