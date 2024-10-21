Return-Path: <linux-kernel+bounces-374640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C565E9A6DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717B71F225B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B22BAFC;
	Mon, 21 Oct 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="pSqL/hRg"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3D22619
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523709; cv=none; b=nGUr9kUh2h8qJdYVHjR1AiobtUqzDSyJPzMarghO4MyQDOZApDJUo7leX4ZCV3wwr1bpTZWEz3chuAudso6YXGg5hSXo8ItpUvrQ2s4NLlqwgPnHmAqmiqwlDk9G9NGHFrEMWIT/mm16aodwwwwLffY1fY9o4T8IH8wkvizrnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523709; c=relaxed/simple;
	bh=MbTjSVzv8f+NjyPLuVwedfGWGnFwOToxQBmyznK/2Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HobWziq/cr2/Bwb2aKITsWw/7VrLWFNRGEpOt79wkMO+7zxC3YHwMBJbSrN5kB36Q+R2+zUJK3jf2xXFJKJqyvGVnQSZGPVBIe1wJYHzY2+lvRNc9i96Fr1WHeMysBdi3M+NLzDmQESjXr9zLx6Qp4QQPlaasSkrxpZJuiHZCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=pSqL/hRg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f1292a9bso5527172e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1729523705; x=1730128505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvLvAGoaEs4cLCLummjUn/fSa2RxeVRTPvPMgQ05vWA=;
        b=pSqL/hRg9oKL7fZJw751VNEEq5iN9rV5NyK2crFIQbG2kPa0N9rU/C6LfReu/SMMP1
         GKOr654+LAPpmiI/QXO2Jb7h6g72OV8rbCOPSBodoxgYbtQ9hoiE6/5ai0MFim3IFeX9
         uwiC9Z2YCzwLXCtO1LzLGPG0faqXWoxMeacIcM8/gvu4bvZSMSa7t/CtuUItaDD9Dsiu
         hJI7/ZWbvEYRpt1ITLV/2IShWU7xQZrw2M5XrWxoeOXP5c4A5P7LAoC3G/WjAzgjM6St
         M00mbZ0GOsIW7jHvrxLQ3E4B22zRbEOj3UpAMqfi+XiB/xX5FtFux0qCvgUa/0k7wyx3
         tIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729523705; x=1730128505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvLvAGoaEs4cLCLummjUn/fSa2RxeVRTPvPMgQ05vWA=;
        b=nLFmJd5ysaM7piskOD4kMknKb8sckGnKI0cO89GZa1wPOWfCgNkoTgXDhehceiEMNd
         8QTZekiClGyLn3pmrpDHcU4VhfCC+SOQ+5BgTCaWDQdUm0J2nOT0iHI7TqzRN0lTTMd5
         2U3fQsS+Bw5rUIccWz1MKKkgtSLL6Av9KgK0wW/YJ/u6wmi7eiXeAzoppWZ1+CuxnlE9
         sMfb8x/ANgJgUYrPhsLuc5w+O17Ggje2JdgzACiTMvxp3IIsNqI5imkE1ruRiQZgZUn4
         Ok9N2u9uiEw0aG3P2In5GA4Qzv5EaJSYMsDTiW/k+fbIBL+prJHmJmi4XUTsMXTk4KYj
         RipA==
X-Forwarded-Encrypted: i=1; AJvYcCV57ZcvUkLzGC8QaZd98+w21dkSeLVTtYgc8pcmA88GtK5fS9OBCR69ElqeNkZv2ta3T6GKXMAdpeH0KnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8jhwFZtzD78bzRtN1QaZAsOWbcIOzJscZqVuJjeYJT5ma37h
	eU7BuEdb8o2vwFlNov3CSTg0+WbFj0VuEnOK5YV9O1yZ1k4F3VJCGy1/IPNNMDS5BVAZtRUt45k
	Yt2mSBjMZ8e040QfkuquIrdpoNriZSBTl7h0H
X-Google-Smtp-Source: AGHT+IH5PS65InXxWy7zQvIKXC5DV3lRT7k9uy1hS9BXMEO9QulVaI6d3S3/tVIqUPBmpDRG0ReoxzC3NqxZUA7H7xY=
X-Received: by 2002:a05:6512:2813:b0:533:44e7:1b2a with SMTP id
 2adb3069b0e04-53a154b2d95mr5431587e87.40.1729523704965; Mon, 21 Oct 2024
 08:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com> <20241021-tidss-irq-fix-v1-6-82ddaec94e4a@ideasonboard.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-6-82ddaec94e4a@ideasonboard.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Mon, 21 Oct 2024 11:14:53 -0400
Message-ID: <CADL8D3Ykxbz7W=Av774sk9HaEnvneLNZcxmGsGaL2XDEFgpzAw@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/tidss: Fix race condition while handling
 interrupt registers
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:08=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> From: Devarsh Thakkar <devarsht@ti.com>
>
> The driver has a spinlock for protecting the irq_masks field and irq
> enable registers. However, the driver misses protecting the irq status
> registers which can lead to races.
>
> Take the spinlock when accessing irqstatus too.
>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Disp=
lay SubSystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> [Tomi: updated the desc]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 4 ++++
>  drivers/gpu/drm/tidss/tidss_irq.c   | 2 ++
>  2 files changed, 6 insertions(+)

Reviewed-by: Jonathan Cormier <jcormier@criticallink.com>
Tested an equivalent patch for several weeks.
Tested-by: Jonathan Cormier <jcormier@criticallink.com>

>
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 515f82e8a0a5..07f5c26cfa26 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2767,8 +2767,12 @@ static void dispc_init_errata(struct dispc_device =
*dispc)
>   */
>  static void dispc_softreset_k2g(struct dispc_device *dispc)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&dispc->tidss->wait_lock, flags);
>         dispc_set_irqenable(dispc, 0);
>         dispc_read_and_clear_irqstatus(dispc);
> +       spin_unlock_irqrestore(&dispc->tidss->wait_lock, flags);
>
>         for (unsigned int vp_idx =3D 0; vp_idx < dispc->feat->num_vps; ++=
vp_idx)
>                 VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0, 0, 0);
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/ti=
dss_irq.c
> index 3cc4024ec7ff..8af4682ba56b 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.c
> +++ b/drivers/gpu/drm/tidss/tidss_irq.c
> @@ -60,7 +60,9 @@ static irqreturn_t tidss_irq_handler(int irq, void *arg=
)
>         unsigned int id;
>         dispc_irq_t irqstatus;
>
> +       spin_lock(&tidss->wait_lock);
>         irqstatus =3D dispc_read_and_clear_irqstatus(tidss->dispc);
> +       spin_unlock(&tidss->wait_lock);
>
>         for (id =3D 0; id < tidss->num_crtcs; id++) {
>                 struct drm_crtc *crtc =3D tidss->crtcs[id];
>
> --
> 2.43.0
>

