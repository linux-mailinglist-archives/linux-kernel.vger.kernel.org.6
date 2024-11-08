Return-Path: <linux-kernel+bounces-401132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B0C9C1649
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375601C229D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B491CFEC9;
	Fri,  8 Nov 2024 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="drZOZ94C"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51418FDD0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731045742; cv=none; b=g4Lh6B5kDToKcW+8g9/ZXbXxyH2kRd79pF/2lXgVzsQ9mnyR53GQhId8eg97CxLPHyT+WI1kkskKgw9m2/+imxO4Dy1xa/tIxpmUNorBkEB3BuDhRztxHreYaGQSxvNrG0oLg1oKPhuFmAE9lpNG+lCcqx6NX5Iy6qrZD06GpNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731045742; c=relaxed/simple;
	bh=lTBf0TWRouF8XeWxn5vsDzkhjI0EGmccbF27ADrrizA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cr0F8YSSXqx0N7y3Ta5y7RP3yx4XU4D9NdS+pTZNepZchQVx+01RJ1UnmEk+5wELiE6E6gRddYWKVvI2+1Urcgr37dze4MBys2koy3CYB2lsovG4Ro3YWxtQrMNnCv0kmEHwpT5BkZA3uv2zOU2hDdGvuLvMMMAOHg+99f9RKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=drZOZ94C; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53c779ef19cso1969922e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 22:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731045738; x=1731650538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkvxW0TELGak9TGChpUjLN8WW2TtIQcHiwQEYFYHFLY=;
        b=drZOZ94C1Ur5PVKIXw66Cunqk8gjuvrVGl5RK3avwQvJgmh6C1qjdT+5Q/OWBI+Nh2
         cjZZDZtFT0VPY4hIMxkH/+/+zggQ4NTg5D1f6oSq6BWbw9HvU+FZdliMNDWyukiUuVHm
         T6ATD/tq0fp5U3i8WAYaGmZEGJkJUzMnOf17U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731045738; x=1731650538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkvxW0TELGak9TGChpUjLN8WW2TtIQcHiwQEYFYHFLY=;
        b=d7pZPMYYLlHjaBVypEio7oUfcS5ISA5S9qDGtAPwcARphfH4m9xCIhb3rP0k8TYu53
         H21BsbfeCVNLQGLp3Iv8htp+8k6EvzURcTMJRsFYt37UZucOTtdP2EwNtyGCjIfYI7iM
         +mxooGsZhZGAzRdtBw5DWDABCrQIZ/8MKH3+N9sUNpuzsDae4ASzMOr0QIWqpXT3n5Il
         QnOXEC8zVV2CIoATJ6UUf6qGLEVL32e9DVyWQ82pTGywbkP5MjuTZy58YG6zoJziJZTP
         y20V563xOwR9p14Ti7Xg+IG7MLR1P9i8dw55lSMuaN+cxr/HDO7Pxbn21YqDsSuAwrLl
         0qSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9uXxRnkK6PWbZ7eSGnXoWaFUzOG5tjF/4NIs2i8zzFUW1qeKg7TvWbLbLPmuq3KExtTNCSsepXQefHa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNUqFdAKPGpWmMIm7Ac7mfEB1KCAyP8/MpyDTqqH0n4X/F8HAD
	9GMQlHd17UHr3HDqTR3Ct1XXwAJbUKsl7VfFb/jWvaUAS3POmdzeWjGzDh4bJ/MLEOw2l+Mfxdc
	Z4QJJKb8VRho2ZBTrx7iy6gTHc/tGaT4cM8S6
X-Google-Smtp-Source: AGHT+IHrAma7a//3ZnIS1iS1Lm0CwM4nLy0ndtu8X8cJY5OZ/WS7iyuPy8axxsNkbLgivCMUhnj0GhMp35Zvr3+0+ik=
X-Received: by 2002:a05:6512:3b8d:b0:539:e8b5:f296 with SMTP id
 2adb3069b0e04-53d8629d2d5mr722983e87.33.1731045737701; Thu, 07 Nov 2024
 22:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108033219.19804-1-yunfei.dong@mediatek.com> <20241108033219.19804-6-yunfei.dong@mediatek.com>
In-Reply-To: <20241108033219.19804-6-yunfei.dong@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 8 Nov 2024 14:02:06 +0800
Message-ID: <CAGXv+5EfZUXEh6r0GaMKwTgWo8gQHsXFSF2bQzFuw=J4Gj0OGw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] media: mediatek: vcodec: remove media request checking
To: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:32=E2=80=AFAM Yunfei Dong <yunfei.dong@mediatek.c=
om> wrote:
>
> Setting the buffer status to error if the media request of
> each source buffer is NULL, then schedule the work to process
> again in case of access NULL pointer.
>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c      | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_de=
c_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_d=
ec_stateless.c
> index 3f94654ebc73..251111678fd8 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state=
less.c
> @@ -363,10 +363,14 @@ static void mtk_vdec_worker(struct work_struct *wor=
k)
>                           ctx->id, bs_src->va, &bs_src->dma_addr, bs_src-=
>size, vb2_src);
>         /* Apply request controls. */
>         src_buf_req =3D vb2_src->req_obj.req;
> -       if (src_buf_req)
> +       if (src_buf_req) {
>                 v4l2_ctrl_request_setup(src_buf_req, &ctx->ctrl_hdl);
> -       else
> +       } else {
>                 mtk_v4l2_vdec_err(ctx, "vb2 buffer media request is NULL"=
);
> +               v4l2_m2m_buf_done(vb2_v4l2_src, VB2_BUF_STATE_ERROR);
> +               v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
> +               return;

Is this something that actually happens? I would assume that having
the `requires_requests` flag set on the queue would block any QBUF
call that doesn't have a request attached.

> +       }
>
>         ret =3D vdec_if_decode(ctx, bs_src, NULL, &res_chg);
>         if (ret && ret !=3D -EAGAIN) {
> @@ -384,8 +388,7 @@ static void mtk_vdec_worker(struct work_struct *work)
>         state =3D ret ? VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE;
>         if (!IS_VDEC_LAT_ARCH(dev->vdec_pdata->hw_arch) ||
>             ctx->current_codec =3D=3D V4L2_PIX_FMT_VP8_FRAME) {
> -               if (src_buf_req)
> -                       v4l2_ctrl_request_complete(src_buf_req, &ctx->ctr=
l_hdl);
> +               v4l2_ctrl_request_complete(src_buf_req, &ctx->ctrl_hdl);

Unrelated change. Please do the cleanup in a separate patch.

v4l2_ctrl_request_setup() and v4l2_ctrl_request_complete() are both
no-ops if either argument is NULL, so you can do one patch going over
the whole driver to clean it up.

>                 vb2_v4l2_dst =3D v4l2_m2m_dst_buf_remove(ctx->m2m_ctx);
>                 v4l2_m2m_buf_done(vb2_v4l2_dst, state);
>                 v4l2_m2m_buf_done(vb2_v4l2_src, state);
> @@ -403,8 +406,7 @@ static void mtk_vdec_worker(struct work_struct *work)
>          */
>         ctx->cur_src_buffer =3D (ret !=3D -EAGAIN) ? NULL : vb2_v4l2_src;
>         if (ret && ret !=3D -EAGAIN) {
> -               if (src_buf_req)
> -                       v4l2_ctrl_request_complete(src_buf_req, &ctx->ctr=
l_hdl);
> +               v4l2_ctrl_request_complete(src_buf_req, &ctx->ctrl_hdl);

Unrelated change. Same as above.


ChenYu

>                 v4l2_m2m_buf_done(vb2_v4l2_src, state);
>         }
>
> --
> 2.46.0
>

