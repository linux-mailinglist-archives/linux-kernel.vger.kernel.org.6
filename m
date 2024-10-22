Return-Path: <linux-kernel+bounces-375771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DFB9A9A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2F11C223D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F43414D433;
	Tue, 22 Oct 2024 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k4yE85XR"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82071494AD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581074; cv=none; b=jsRrfrJ4mYhWSvourcsg+nZFolVMbcq9+4uCv3LegkjhBMplaHCiuvkN5nH7cc3dCFnYdzU+S8/egMura3GqXVZdjaB5CCIPlqwW0/rJeZv79l2J9hYIaOZmkZABZKQs+mCM5Xs4+oDWTQ2jEegkilSPwmpuDV9+Gypr6qBQaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581074; c=relaxed/simple;
	bh=9/H0GURHnCFEBdAl6G8M/xjUafjIGq7AtO5/Lg0KgpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W10eIDbk2YhkySYOxH5JnwJU5L7NCG3BDQqmpxi/mSKcB1ybejFUIAaU06A7ZxDew2AoSwZkmDquCiwS5gwo7TyUDHLzm30pT52tYIXhTH2rmz0jKdjrUlIx8AZh/xqjKrI3e1M5qFh2uuEpCTqKlSB8hHyuVogopo11gtRCU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k4yE85XR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c913aso6120499e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729581071; x=1730185871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuZG9TjFhS0J3cabCqnpd26zyrTahESHkPMMm0tbHo8=;
        b=k4yE85XReJyy7rWM4ZUpwxcXNqOoXnOth6s8w1+xj2q1ugsIsaUxiZpTu6hXBlYSyZ
         GsnmGXWNwwx/wLAiojOT6UqAOcoz3xJGxnb533ir9BL7EMXPtJBFy3XahPzF2qZ1E9JO
         WV2JNoL0t4fGKKVBxP0z2EvrvVhWC2gau9fII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729581071; x=1730185871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuZG9TjFhS0J3cabCqnpd26zyrTahESHkPMMm0tbHo8=;
        b=s/SciiFeqOWgRxHob+Sa5/72YTgEe27qSmeg0AR1AuEziaXSNdGO7LpCpDtLnrkUIJ
         8v/Hn+5w8at98jh63Cm7fICXrSLlK+2pCB9UApQ7DRme1B8Oxa9BUsof94x2MaBZozo7
         s7i1NfCDp4yHM3FyaehckD8UQcafWCkqb3XdSSfDdIF2H+fYo2OZ/J+5kv9fKBtDCAVC
         DM6Faq+KYIbnA0isMYtL7D8ZoT4flOY6fE5fPdQDq7/yhxcM/0qscyZBm2QtRhip5ZvJ
         LNgdz0awyAuF7013i1dKE1LzqG3fNgZ6EazxBPeN6ckvOPkAoDc4/fffMDB2k1aMvKSH
         qcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZsBhfxlod/aAMcU0rPUE2G7t4yXAj+MqpBdbHw9HLFoC0hcEuuZLlrbtUDsGiqYBuVmRAwtih8vJerU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uoc9pfn9DJBiAYYKL6jzT25/vFLZtjE/0G3ydpIMNoyfbGV6
	BR7IUbGExmRGVCaxSDraxk0GEamCeGUOEAhs8f9A/Y73CZXBzIBHyMTa1xWgxwVquASMyV9rFGt
	4Haun/F1WLIzZkvWA2N6nWtWIDQEnJI2SbUYU
X-Google-Smtp-Source: AGHT+IF+1EcCcjdprpZUxHQiyLOSW34mZjTqf2CtGDmKqLDG4nbcEgmNJg/VHulKiMJv5nQCszElvS5awGTY6T21MgA=
X-Received: by 2002:a05:6512:304f:b0:539:fb6f:cb8d with SMTP id
 2adb3069b0e04-53a15229db8mr7057177e87.27.1729581070757; Tue, 22 Oct 2024
 00:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016034927.8181-1-yunfei.dong@mediatek.com> <20241016034927.8181-5-yunfei.dong@mediatek.com>
In-Reply-To: <20241016034927.8181-5-yunfei.dong@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 22 Oct 2024 15:10:59 +0800
Message-ID: <CAGXv+5H4BfUcDL1Rp+-CVefxdPtxxf63Bj+Ay9daMdy6127F3A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] media: mediatek: vcodec: remove parse nal info in kernel
To: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Fritz Koenig <frkoenig@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, 
	Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:49=E2=80=AFAM Yunfei Dong <yunfei.dong@mediatek.=
com> wrote:
>
> Hardware can parse the slice syntax to get nal information in
> scp for extend architecture, needn't to parse it again in
> kernel.

Squash this in with the other "add extended architecture" patches.
You are removing code that you just added. So why add it in the
first place?

You can just mention in the commit message that the new architecture
can parse the slice syntax directly.

ChenYu

> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../decoder/vdec/vdec_h264_req_multi_if.c     | 24 +++----------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h26=
4_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec=
_h264_req_multi_if.c
> index 69ca775bb3f1..c99a64384edf 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_m=
ulti_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_m=
ulti_if.c
> @@ -802,11 +802,10 @@ static int vdec_h264_slice_lat_decode_ex(void *h_vd=
ec, struct mtk_vcodec_mem *bs
>         struct vdec_h264_slice_inst *inst =3D h_vdec;
>         struct vdec_vpu_inst *vpu =3D &inst->vpu;
>         struct mtk_video_dec_buf *src_buf_info;
> -       int nal_start_idx, err, timeout =3D 0;
> +       int err, timeout =3D 0;
>         unsigned int data[2];
>         struct vdec_lat_buf *lat_buf;
>         struct vdec_h264_slice_share_info *share_info;
> -       unsigned char *buf;
>
>         if (vdec_msg_queue_init(&inst->ctx->msg_queue, inst->ctx,
>                                 vdec_h264_slice_core_decode_ex,
> @@ -830,14 +829,6 @@ static int vdec_h264_slice_lat_decode_ex(void *h_vde=
c, struct mtk_vcodec_mem *bs
>         share_info =3D lat_buf->private_data;
>         src_buf_info =3D container_of(bs, struct mtk_video_dec_buf, bs_bu=
ffer);
>
> -       buf =3D (unsigned char *)bs->va;
> -       nal_start_idx =3D mtk_vdec_h264_find_start_code(buf, bs->size);
> -       if (nal_start_idx < 0) {
> -               err =3D -EINVAL;
> -               goto err_free_fb_out;
> -       }
> -
> -       inst->vsi->dec.nal_info =3D buf[nal_start_idx];
>         lat_buf->vb2_v4l2_src =3D &src_buf_info->m2m_buf.vb;
>         v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->t=
s_info, true);
>
> @@ -846,7 +837,7 @@ static int vdec_h264_slice_lat_decode_ex(void *h_vdec=
, struct mtk_vcodec_mem *bs
>         if (err)
>                 goto err_free_fb_out;
>
> -       vdec_h264_insert_startcode(inst->ctx->dev, buf, &bs->size,
> +       vdec_h264_insert_startcode(inst->ctx->dev, bs->va, &bs->size,
>                                    &share_info->h264_slice_params.pps);
>
>         *res_chg =3D inst->resolution_changed;
> @@ -1078,11 +1069,10 @@ static int vdec_h264_slice_single_decode_ex(void =
*h_vdec, struct mtk_vcodec_mem
>         struct vdec_vpu_inst *vpu =3D &inst->vpu;
>         struct mtk_video_dec_buf *src_buf_info, *dst_buf_info;
>         struct vdec_fb *fb;
> -       unsigned char *buf;
>         unsigned int data[2], i;
>         u64 y_fb_dma, c_fb_dma;
>         struct mtk_vcodec_mem *mem;
> -       int err, nal_start_idx;
> +       int err;
>
>         /* bs NULL means flush decoder */
>         if (!bs)
> @@ -1117,14 +1107,6 @@ static int vdec_h264_slice_single_decode_ex(void *=
h_vdec, struct mtk_vcodec_mem
>         memcpy(&inst->vsi_ctx_ex.h264_slice_params, &inst->h264_slice_par=
am,
>                sizeof(inst->vsi_ctx_ex.h264_slice_params));
>
> -       buf =3D (unsigned char *)bs->va;
> -       nal_start_idx =3D mtk_vdec_h264_find_start_code(buf, bs->size);
> -       if (nal_start_idx < 0) {
> -               err =3D -EINVAL;
> -               goto err_free_fb_out;
> -       }
> -       inst->vsi_ctx_ex.dec.nal_info =3D buf[nal_start_idx];
> -
>         *res_chg =3D inst->resolution_changed;
>         if (inst->resolution_changed) {
>                 mtk_vdec_debug(inst->ctx, "- resolution changed -");
> --
> 2.46.0
>

