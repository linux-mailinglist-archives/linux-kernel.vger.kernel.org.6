Return-Path: <linux-kernel+bounces-307154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93913964949
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A68DB25561
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6531B151B;
	Thu, 29 Aug 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXCxsIij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E31B1514
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943459; cv=none; b=c0p8tpzNe1P0EI0crXBsT3G89AVG1rvlcpkeEFBdwfpF8Hq2nXJsURc/BcHxErcG8Ijcibw57BJa9dTOOb0RYToQjnRGa0hhSCfVvIVrclLyZepkO8FfnseLFJG4OAj5PdOBKXaj3zyxK7BbeVFBpNMr/oZ+tV2U4/yEbZvI6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943459; c=relaxed/simple;
	bh=77GZ3QzaWVWSIhtGl6NhqkeP6FIDiOftlrdOL+sQSfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDOZyBixGUSrbhmkAocUNIODzU4TZb98FGkiEOIyoZntFm7HD6cAqVjwxGQ9qENyhBroXvUw5V1lvaTvQ+b4O1MdG/StMQQnCXqtuBiQH/HdLc+Tr0l7pU+kCytE8pPk+YEzHW7/V6I85zVAifVjYiYUl84+VZFxL9sZ3UWcCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXCxsIij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6639FC4CEC5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724943459;
	bh=77GZ3QzaWVWSIhtGl6NhqkeP6FIDiOftlrdOL+sQSfw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IXCxsIijxUX/8BlxE4wUwVpkDDZPGZE9b2TUSGTOSni2Hu78alR/djQiMtZnQVhB0
	 8wFS0l6/gylyIqYoqPTJCyjybjCq0aq72vjtu1XRHAkF+oK4wbI4CAdN2yaz2HPSbI
	 5AF4xUklzO5vLWZRZuVQ5qb5HwJNH4i/1tUWQr+xVNdIR14gZ3HJ15e2+39VF1hKI6
	 lyZG5fdUN6TftBMjrh+wrKOFRy6Lp8XJdduhr5D2EArIoi9AUUyolhhzJB/5Ip5vfJ
	 5dalhgT/FghRSBJgQZKaDBMd48gki3+17ofaGHTkMk+GoPRejpGiGYMtyhRJfuWBN9
	 roZkJFd3nU04Q==
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd835872ceso495847a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:57:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6PbPNV+YANSIEOAGhnoSn6N3kvBb/+PJQiJsJNeUTC6AhxripYXQoTi9Mc2te2yFgg27ZUYO3Lg6kVeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWdwVKYbs9BVte6lauIhavnhPPb5fKywSxElGH5GhRgVhyqV1
	U1Io/az15/6JHoq0gR8wRDDVPK5xTYcI5ilKzfKc40utphnF9o9A/kQ61rrdr7/FlltVW57iTfM
	8GaZXTnmFcGoFWfqV70rlWCtx8w==
X-Google-Smtp-Source: AGHT+IHbbf11aBEzm+xsp/uTtv2EomAhCmlwdvkMwIl7kiohHuf6+VCO/ZMXf47TFVKkRpa1ddvlFhJUARNVpXA5tY0=
X-Received: by 2002:a05:6a20:c89c:b0:1c0:ef24:4125 with SMTP id
 adf61e73a8af0-1cce101e0a0mr3244740637.26.1724943459001; Thu, 29 Aug 2024
 07:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828101511.3269822-1-fshao@chromium.org>
In-Reply-To: <20240828101511.3269822-1-fshao@chromium.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 29 Aug 2024 22:57:52 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9K5wb_d-DbFnDKDUPdSkt9Tt8ObbVc6eErehpO1SNbvw@mail.gmail.com>
Message-ID: <CAAOTY_9K5wb_d-DbFnDKDUPdSkt9Tt8ObbVc6eErehpO1SNbvw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Use spin_lock_irqsave() for CRTC event lock
To: Fei Shao <fshao@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Fei:

Fei Shao <fshao@chromium.org> =E6=96=BC 2024=E5=B9=B48=E6=9C=8828=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Use the state-aware spin_lock_irqsave() and spin_unlock_irqrestore()
> to avoid unconditionally re-enabling the local interrupts.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 411f5c1eacfe ("drm/mediatek: handle events when enabling/disabling=
 crtc")
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
>
>  drivers/gpu/drm/mediatek/mtk_crtc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 6f34f573e127..42f47086f414 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -449,6 +449,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_crtc *mtk=
_crtc)
>  {
>         struct drm_device *drm =3D mtk_crtc->base.dev;
>         struct drm_crtc *crtc =3D &mtk_crtc->base;
> +       unsigned long flags;
>         int i;
>
>         for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++) {
> @@ -480,10 +481,10 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_crtc *m=
tk_crtc)
>         pm_runtime_put(drm->dev);
>
>         if (crtc->state->event && !crtc->state->active) {
> -               spin_lock_irq(&crtc->dev->event_lock);
> +               spin_lock_irqsave(&crtc->dev->event_lock, flags);
>                 drm_crtc_send_vblank_event(crtc, crtc->state->event);
>                 crtc->state->event =3D NULL;
> -               spin_unlock_irq(&crtc->dev->event_lock);
> +               spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
>         }
>  }
>
> --
> 2.46.0.295.g3b9ea8a38a-goog
>

