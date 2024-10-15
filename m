Return-Path: <linux-kernel+bounces-365290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EFF99E00C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E10B22580
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEB01BD01F;
	Tue, 15 Oct 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j1H5Iosx"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B21B85CC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979099; cv=none; b=rOltRmmfibWZkFCEo3/tJM+3TZyPs63syf2bdV5Wn1pqyOQm/HinPn2L2y5fuJOk8txq/PW/oONbsxU8Hu1TjLO3raocM8DXIpBvxmd89boyIEX0WIGmm984O9t4EvDZ1a/Cx4X9+AQ4AxqNdxCq3ZkD9I8mYGLzxRk+YQ82v/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979099; c=relaxed/simple;
	bh=xqbnlLiVNwKqNk4B6zxRxQlS9F/oHJRfBlpXtgY8Yeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+QAP0J1UxRIBAeEARnA7Ut6lOKG7xZTMxagCu/WhTMhhRKw7qwhA48SajTyU68Tc13CtPtqdTikhUhkGaKI/lvgFoyY1nVubWYMZz6ctPSencTTn7W7XjpHt9o2eTQVNJ+f+y8yRjMsIHlRLiWyjxHH4GKJSwXAkO4I2PpVTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j1H5Iosx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e4b7409fso2829852e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728979096; x=1729583896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC4BB+tDEl8JjaqDwzWgkstqnxwTVkHhasRVEYNy6PE=;
        b=j1H5IosxH8aclbmF/IGO8/trWO+AKt1YcExrJNOpKE6PMDwQkWYtnYvk+LM2yWq2dm
         ykvMMKuHL1quG6EOHKC/Ibg+ZZbQDaaHxckr38zqCoe7dCswdGVm29g3ck7cewNK4UB9
         xzIY3o25jnPK7br2vkwDUDIZqns3UnVBKfF2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979096; x=1729583896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC4BB+tDEl8JjaqDwzWgkstqnxwTVkHhasRVEYNy6PE=;
        b=q0j/xj81GGv9tojW1QOvir8Ayyy4gRNy3RLOCKZgblPh/EDJ4RY/+/y/Z2mQvV659E
         trQVG4OTcmdYCtJneuHwPlsG1njkc37+l/PY+YA+0x2/RT22r6oZNfEvK+I/gr+SLToB
         WzhDiLfE6vQV5eqQN1jG4Cg7aAaBHzLU1lw0Up0RRbBQPG6Qm1q8DxfMxyUC9tXjBIEw
         RhdWQgUTiqQxxDt1KpDBb5aME/CddnDKtfw5OtgjSNorxGtsfIjQNtKanJVaijhLagyS
         xmhtLZX6v98eBfUS7weY6cLu9LcqyP94PBZ5lM8RnhYwp4Sq/8SXROyKjZ0r7zzUn3fh
         AGFw==
X-Forwarded-Encrypted: i=1; AJvYcCXCeM6kCgeaSNSi2pmuJiBn/aU1noT+CiPYN/uCfhr+RJRothdlLt8UVwDTWn5GX0oODmEoiQeqJno29Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHMI22MdnGDdKHxrMJuTYPcWNn2p0dMVIWsCQQ3g0Oy4jYMIg
	J9RCZp8138C1XVpQ60Sxo2jTuV5Ii3Oiin8A+GuAuHF1UwybnblizsjjiShmktB0eeDHr2tfpPL
	TwaII9Ett9neRRz8pi+cuQcQIhBpVEob6+aT6
X-Google-Smtp-Source: AGHT+IGjJNGNwEUDC+KZo44b4hUQtyEA+RBC3R7OuIVRUtmEkMET/oSfQ/G/cmV6HDCYX8i5o2poiLBvda9ljao0a+8=
X-Received: by 2002:a05:6512:2254:b0:539:f775:c0bc with SMTP id
 2adb3069b0e04-539f775c343mr1766569e87.29.1728979096001; Tue, 15 Oct 2024
 00:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014073314.18409-1-yunfei.dong@mediatek.com> <20241014073314.18409-3-yunfei.dong@mediatek.com>
In-Reply-To: <20241014073314.18409-3-yunfei.dong@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Oct 2024 15:58:05 +0800
Message-ID: <CAGXv+5H4FsadBheokwO7hTxDxAtYakL15Ki+EcnhQ3Unbz3o9w@mail.gmail.com>
Subject: Re: [PATCH 2/6] media: mediatek: vcodec: remove parse nal info in kernel
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

On Mon, Oct 14, 2024 at 3:33=E2=80=AFPM Yunfei Dong <yunfei.dong@mediatek.c=
om> wrote:
>
> Hardware can parse the slice synatx to get nal information in
> scp, needn't to parse it in kernel again.

Does this apply to all existing shipped SCP firmware? If not, please
put this behind a vdec firmware flag.

ChenYu


> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../vcodec/decoder/vdec/vdec_h264_req_multi_if.c    | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h26=
4_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec=
_h264_req_multi_if.c
> index d3f8d62238c0..76b96924a2a7 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_m=
ulti_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_m=
ulti_if.c
> @@ -634,11 +634,10 @@ static int vdec_h264_slice_lat_decode(void *h_vdec,=
 struct mtk_vcodec_mem *bs,
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
>                                 vdec_h264_slice_core_decode,
> @@ -662,14 +661,6 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, =
struct mtk_vcodec_mem *bs,
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
> @@ -677,7 +668,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, s=
truct mtk_vcodec_mem *bs,
>         if (err)
>                 goto err_free_fb_out;
>
> -       vdec_h264_insert_startcode(inst->ctx->dev, buf, &bs->size,
> +       vdec_h264_insert_startcode(inst->ctx->dev, bs->va, &bs->size,
>                                    &share_info->h264_slice_params.pps);
>
>         *res_chg =3D inst->resolution_changed;
> --
> 2.46.0
>
>

