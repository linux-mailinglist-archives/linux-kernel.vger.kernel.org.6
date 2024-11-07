Return-Path: <linux-kernel+bounces-399607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B130D9C0189
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A1E1F23BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B471F429E;
	Thu,  7 Nov 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="clJYYhss"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB81EC014
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973117; cv=none; b=asmhNFBG0iq1U47IkPLTwwHlVHFWi5pIserboF417ImFsGsZt5sIiVBz95WJyZMX1wjm9yXOsP9tk/sYgj/ijqFwu26ieZSlTh8l0uOmgG95baqGjpi9rUUzN8ETEy9ncf+tQ5voAdbejeHgXTjC7VGJq3/t0jxAY7wNua+RKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973117; c=relaxed/simple;
	bh=jPV78dINbSzeUtKgCIE0S+PYALb5LTriV8X07iC3y8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0Gb9vM9BdHcD24PHNRFodhsojgdIAbOmGRdWJWBJjRxSpnvCP42k51e4Ov76TAe4rLiNQSGOeQMQ4e9itILR8WDP4j9ygyt+wuiWCv44YlvgrXlcid47BYHe1mzGa1so68E8Uhc07lQ3RwFELHBKbT39xRojHY1rldtiULeTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=clJYYhss; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so1119834e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730973113; x=1731577913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNGDZFn6BFfHOXHdbqmi5GIr1NOgRIL8yzEY3j9R85k=;
        b=clJYYhssctvQPCrGxUa8H+CpQ7MywEceNAZBmStt0H+5K6+4IkEi3mQ64ujtkwPtNE
         Vl65kt2KicZdto8ii6C5xBOHHeKD2IxkqT4gg0UsQiHjoqt5ZvScgdR0VYU6ztjQXAyi
         SI9xdEg4USciXc3/L/hPOTxU2xtnmD3AFxYX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973113; x=1731577913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNGDZFn6BFfHOXHdbqmi5GIr1NOgRIL8yzEY3j9R85k=;
        b=WpbVAaIWyVlDGIY/4p9sDcsLS2IVsl8jlUW5clPJ2wSNMOVV2dHB7P3BPTEuT5n4vO
         fK/9XwEoL6pzfn2Be8hOVHTQngBW4l+F8nZssde9gXMA/YDlFZPw+TMK5QlBWIW7rvET
         KXVWRFuNp/jxTsTWPWRbIUqHuO9p4QtMNqiHSbuzGmxhgQgjd067vBXxrj6MPCUb7Z+Z
         J1x1oj5k1giIMIYGAExqAue+RR4JajZ4ySNQMjsSa5CnsLBQhMX4tQBtL/jP+mGoSdrB
         fr1yIKZ8WdsSkwO1JR7Qwxn1Lqa+QVCkqFuYYMweIdxFx/KRxSI/+/aSi5QpiCI+ou+v
         yrsg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2WC0CSVE0yUcUkVbUfdJIJRCBtpd7h+Mky2fqT2RbCsOg7MmBzbqlkFcZvaFdK1Yw+4muUis7OLY6jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQOzgLzFVRXmRak3hkuW+ZhRr4ChGqY1yynLtoFDHax7gc2ZV
	kPsSI39qlxWgUZM9QaWL7Dwpak1TnGcpvXOuU91D4wpYqNLvp6fly3hCO80baKI936CbPi+zaI/
	8KcOWeKZFhwH/waJtbWopim/V5ZlYi9AUAjiOUrH4r2beZidzzA==
X-Google-Smtp-Source: AGHT+IEnXPQWMP+Dvcvi+dUp8x3Ks93IzGCACftaRF0ayAabRXNIc0K3QoU6l6e3upA/E3kiCMYfJSgDzYjB+oi7sEs=
X-Received: by 2002:a05:6512:3ca9:b0:535:6aa9:9868 with SMTP id
 2adb3069b0e04-53d8408370amr240812e87.19.1730973113190; Thu, 07 Nov 2024
 01:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012064333.27269-1-yunfei.dong@mediatek.com> <20241012064333.27269-4-yunfei.dong@mediatek.com>
In-Reply-To: <20241012064333.27269-4-yunfei.dong@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 7 Nov 2024 17:51:42 +0800
Message-ID: <CAGXv+5Fc98b_VTYopo38t1O3M1G+pyAzAQzUeu917UFKSRLZaQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] media: mediatek: vcodec: Get SRC buffer from
 bitstream instead of M2M
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

On Sat, Oct 12, 2024 at 2:44=E2=80=AFPM Yunfei Dong <yunfei.dong@mediatek.c=
om> wrote:
>
> Getting the SRC buffer from M2M will pick a different than the one
> used for current decode operation when the SRC buffer is removed
> from ready list.
>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c     | 13 +++++++------
>  .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c     | 15 +++++++--------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1=
_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av=
1_req_lat_if.c
> index 90217cc8e242..a744740ba5f1 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_la=
t_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_la=
t_if.c
> @@ -1062,19 +1062,20 @@ static inline void vdec_av1_slice_vsi_to_remote(s=
truct vdec_av1_slice_vsi *vsi,
>
>  static int vdec_av1_slice_setup_lat_from_src_buf(struct vdec_av1_slice_i=
nstance *instance,
>                                                  struct vdec_av1_slice_vs=
i *vsi,
> +                                                struct mtk_vcodec_mem *b=
s,
>                                                  struct vdec_lat_buf *lat=
_buf)
>  {
> -       struct vb2_v4l2_buffer *src;
> +       struct mtk_video_dec_buf *src_buf_info;
>         struct vb2_v4l2_buffer *dst;
>
> -       src =3D v4l2_m2m_next_src_buf(instance->ctx->m2m_ctx);
> -       if (!src)
> +       src_buf_info =3D container_of(bs, struct mtk_video_dec_buf, bs_bu=
ffer);
> +       if (!src_buf_info)
>                 return -EINVAL;

This doesn't make sense.

First of all, you are getting the container of bs, and
mtk_video_dec_buf.bs_buffer is at a non-zero offset, so even if bs is NULL,
container_of(bs, struct mtk_video_dec_buf, bs_buffer) is not going to be
NULL.

Second, vdec_av1_slice_setup_lat_from_src_buf() is called from
vdec_av1_slice_setup_lat(), which itself is called from
vdec_av1_slice_lat_decode(). Earlier in that function, bs is already
checked. If bs is NULL, it's considered a request to flush the decoder.

The other changes look OK. It's just the check that seems meaningless.

>
> -       lat_buf->vb2_v4l2_src =3D src;
> +       lat_buf->vb2_v4l2_src =3D &src_buf_info->m2m_buf.vb;
>
>         dst =3D &lat_buf->ts_info;
> -       v4l2_m2m_buf_copy_metadata(src, dst, true);
> +       v4l2_m2m_buf_copy_metadata(lat_buf->vb2_v4l2_src, dst, true);
>         vsi->frame.cur_ts =3D dst->vb2_buf.timestamp;
>
>         return 0;
> @@ -1724,7 +1725,7 @@ static int vdec_av1_slice_setup_lat(struct vdec_av1=
_slice_instance *instance,
>         struct vdec_av1_slice_vsi *vsi =3D &pfc->vsi;
>         int ret;
>
> -       ret =3D vdec_av1_slice_setup_lat_from_src_buf(instance, vsi, lat_=
buf);
> +       ret =3D vdec_av1_slice_setup_lat_from_src_buf(instance, vsi, bs, =
lat_buf);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9=
_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp=
9_req_lat_if.c
> index 3dceb668ba1c..c50a454ab4f7 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> @@ -712,19 +712,18 @@ int vdec_vp9_slice_setup_single_from_src_to_dst(str=
uct vdec_vp9_slice_instance *
>  }
>
>  static int vdec_vp9_slice_setup_lat_from_src_buf(struct vdec_vp9_slice_i=
nstance *instance,
> +                                                struct mtk_vcodec_mem *b=
s,
>                                                  struct vdec_lat_buf *lat=
_buf)
>  {
> -       struct vb2_v4l2_buffer *src;
> -       struct vb2_v4l2_buffer *dst;
> +       struct mtk_video_dec_buf *src_buf_info;
>
> -       src =3D v4l2_m2m_next_src_buf(instance->ctx->m2m_ctx);
> -       if (!src)
> +       src_buf_info =3D container_of(bs, struct mtk_video_dec_buf, bs_bu=
ffer);
> +       if (!src_buf_info)
>                 return -EINVAL;

Same thing here.

> -       lat_buf->vb2_v4l2_src =3D src;
> +       lat_buf->vb2_v4l2_src =3D &src_buf_info->m2m_buf.vb;
>
> -       dst =3D &lat_buf->ts_info;
> -       v4l2_m2m_buf_copy_metadata(src, dst, true);
> +       v4l2_m2m_buf_copy_metadata(lat_buf->vb2_v4l2_src, &lat_buf->ts_in=
fo, true);
>         return 0;
>  }
>
> @@ -1154,7 +1153,7 @@ static int vdec_vp9_slice_setup_lat(struct vdec_vp9=
_slice_instance *instance,
>         struct vdec_vp9_slice_vsi *vsi =3D &pfc->vsi;
>         int ret;
>
> -       ret =3D vdec_vp9_slice_setup_lat_from_src_buf(instance, lat_buf);
> +       ret =3D vdec_vp9_slice_setup_lat_from_src_buf(instance, bs, lat_b=
uf);
>         if (ret)
>                 goto err;
>
> --
> 2.46.0
>
>

