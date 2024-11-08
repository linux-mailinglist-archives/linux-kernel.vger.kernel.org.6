Return-Path: <linux-kernel+bounces-401046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DA49C155D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B810528400A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2E1C7B8F;
	Fri,  8 Nov 2024 04:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l7jvja/9"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F817996
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039643; cv=none; b=av61xocLP5jZkvziqFnVIiaVT8zq+MCBUFrxqMJS81I2FuaxfjpfNx7LygU1C04ST8cNcupObUNA/5kjt/Rg4wLIPO2vuEUofvztgLTze64/Jr5D4xaAthe+HR+inrEiVfLV8bjcTboqbpkDqbKSPenkkJOwplAEFeqzUn9+m5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039643; c=relaxed/simple;
	bh=YodfxzMhXROdNig5kcqg4w3VAHmnkaIJsEpWcMyT8qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9w0ATd0haYaBfBB1oVkdDw2vcSRKdfGLd/4Jc37Aq4uvJuNxV7IqKVzbT1j5nUSQA1tsjbgvC0p27Ta74A0QmU78ratk9lx/jSdEJ3zT6y6Wom4ba0l6O5BJiAD0NshtXh8Toz+uL3VK+tVaMoE3398hikEdLr1RyVG6usjSqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l7jvja/9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1785269e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731039639; x=1731644439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEWziAM5vGxUZErinOfDkgBc9AdFxegHOYFNZYJiUGk=;
        b=l7jvja/9eRnrdw+ei+6Six2iE6R09VzzXR/56AzJbfRPbpjr4SSYhicgBsUK2XwYSO
         pI/9hSRybbVFTNKEVNz2A+cEU0Wb/bURmDnzubxGHi9FK4wi8fc02mj2HSmLKCVkS+Hf
         BohUWvCqkm1h88qPmU5NSJwqNQ6aRMxI/nPww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731039639; x=1731644439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEWziAM5vGxUZErinOfDkgBc9AdFxegHOYFNZYJiUGk=;
        b=sRoRRke5Czrmex6ogGFqySUKvH7bi8OCWvgKHPBlgTlDYnXHORcbk0O4pw1Y1dfYi1
         L/bd9QP4e87zALMrjPrHdFuOP6OOLRgJbWoDSBvzZUgVnlZvlWvDafcpTxcQEyMx/7Qd
         goPyDqy06HKMTPbGjRTd4rb70M8npVXUUo3IwwtzCa0vm1LMzUL6jZSPWD7+89H1/qfI
         f1MbCmVEize70lE7gptH9eTRrM9O32UrWm5y/qsQNVwHZaZ4qY++GeOVdLJ5ruAZTtLh
         TZNpyfG7IoYH+jssAEOjfsSd2R18rxyv4/yNQhmrDl5goEVO4OUZB/17BTWkomclwWsy
         T6bg==
X-Forwarded-Encrypted: i=1; AJvYcCUs1QZyzGgkhfkAUaUQQ0dGu/bcq1gPaw6//GqYgGRSCZXjZIpcWS0smi+I2ORkvow6TJiPkdey2VLdCsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFhtqG+M1sAfWe9DpOJ05+IXCBpUZ/3lg4H2QNv77JJm1ha3k
	kF7EUO+sSWPmXUuEJa7mCfuBK8lQYN+NLLC6B0ghNz4zA4N1iQnVWitxVqnxxmyuOjrnJq/LuLo
	1+77N1lAOtlk1bj3Fgg4sUggDyduhRlD+6Zy2
X-Google-Smtp-Source: AGHT+IE4XZ04YFjPUEEL0D8wcmr49KGT/Fc8Oa+piPRCpeewhZIE7Cc2kejtZ9Oe/D6WW+a2IwuOeZhBz5+WWTsy8s0=
X-Received: by 2002:ac2:4e13:0:b0:539:ea0f:cc43 with SMTP id
 2adb3069b0e04-53d862c6f1amr560775e87.19.1731039639002; Thu, 07 Nov 2024
 20:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108033219.19804-1-yunfei.dong@mediatek.com> <20241108033219.19804-4-yunfei.dong@mediatek.com>
In-Reply-To: <20241108033219.19804-4-yunfei.dong@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 8 Nov 2024 12:20:28 +0800
Message-ID: <CAGXv+5GgoSxGM9whwaL3jEUCEoxhTr6UsUdRH8BpBG3UUqDP1A@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] media: mediatek: vcodec: Get SRC buffer from
 bitstream instead of M2M
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
> Getting the SRC buffer from M2M will pick a different than the one
> used for current decode operation when the SRC buffer is removed
> from ready list.
>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c | 25 +++++++------------
>  .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 24 ++++++------------
>  2 files changed, 17 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1=
_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av=
1_req_lat_if.c
> index 90217cc8e242..0e1469effeb5 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_la=
t_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_la=
t_if.c
> @@ -1060,24 +1060,20 @@ static inline void vdec_av1_slice_vsi_to_remote(s=
truct vdec_av1_slice_vsi *vsi,
>         memcpy(remote_vsi, vsi, sizeof(*vsi));
>  }
>
> -static int vdec_av1_slice_setup_lat_from_src_buf(struct vdec_av1_slice_i=
nstance *instance,
> -                                                struct vdec_av1_slice_vs=
i *vsi,
> -                                                struct vdec_lat_buf *lat=
_buf)
> +static void vdec_av1_slice_setup_lat_from_src_buf(struct vdec_av1_slice_=
instance *instance,
> +                                                 struct vdec_av1_slice_v=
si *vsi,
> +                                                 struct mtk_vcodec_mem *=
bs,
> +                                                 struct vdec_lat_buf *la=
t_buf)
>  {
> -       struct vb2_v4l2_buffer *src;
> +       struct mtk_video_dec_buf *src_buf_info;
>         struct vb2_v4l2_buffer *dst;
>
> -       src =3D v4l2_m2m_next_src_buf(instance->ctx->m2m_ctx);
> -       if (!src)
> -               return -EINVAL;
> -
> -       lat_buf->vb2_v4l2_src =3D src;
> +       src_buf_info =3D container_of(bs, struct mtk_video_dec_buf, bs_bu=
ffer);
> +       lat_buf->vb2_v4l2_src =3D &src_buf_info->m2m_buf.vb;
>
>         dst =3D &lat_buf->ts_info;
> -       v4l2_m2m_buf_copy_metadata(src, dst, true);
> +       v4l2_m2m_buf_copy_metadata(lat_buf->vb2_v4l2_src, dst, true);
>         vsi->frame.cur_ts =3D dst->vb2_buf.timestamp;
> -
> -       return 0;
>  }
>
>  static short vdec_av1_slice_resolve_divisor_32(u32 D, short *shift)
> @@ -1724,10 +1720,7 @@ static int vdec_av1_slice_setup_lat(struct vdec_av=
1_slice_instance *instance,
>         struct vdec_av1_slice_vsi *vsi =3D &pfc->vsi;
>         int ret;
>
> -       ret =3D vdec_av1_slice_setup_lat_from_src_buf(instance, vsi, lat_=
buf);
> -       if (ret)
> -               return ret;
> -
> +       vdec_av1_slice_setup_lat_from_src_buf(instance, vsi, bs, lat_buf)=
;
>         ret =3D vdec_av1_slice_setup_pfc(instance, pfc);
>         if (ret)
>                 return ret;
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9=
_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp=
9_req_lat_if.c
> index 3dceb668ba1c..a56f6bb879a6 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> @@ -711,21 +711,16 @@ int vdec_vp9_slice_setup_single_from_src_to_dst(str=
uct vdec_vp9_slice_instance *
>         return 0;
>  }
>
> -static int vdec_vp9_slice_setup_lat_from_src_buf(struct vdec_vp9_slice_i=
nstance *instance,
> -                                                struct vdec_lat_buf *lat=
_buf)
> +static void vdec_vp9_slice_setup_lat_from_src_buf(struct vdec_vp9_slice_=
instance *instance,
> +                                                 struct mtk_vcodec_mem *=
bs,
> +                                                 struct vdec_lat_buf *la=
t_buf)
>  {
> -       struct vb2_v4l2_buffer *src;
> -       struct vb2_v4l2_buffer *dst;
> -
> -       src =3D v4l2_m2m_next_src_buf(instance->ctx->m2m_ctx);
> -       if (!src)
> -               return -EINVAL;
> +       struct mtk_video_dec_buf *src_buf_info;
>
> -       lat_buf->vb2_v4l2_src =3D src;
> +       src_buf_info =3D container_of(bs, struct mtk_video_dec_buf, bs_bu=
ffer);
> +       lat_buf->vb2_v4l2_src =3D &src_buf_info->m2m_buf.vb;
>
> -       dst =3D &lat_buf->ts_info;
> -       v4l2_m2m_buf_copy_metadata(src, dst, true);
> -       return 0;
> +       v4l2_m2m_buf_copy_metadata(lat_buf->vb2_v4l2_src, &lat_buf->ts_in=
fo, true);
>  }
>
>  static void vdec_vp9_slice_setup_hdr(struct vdec_vp9_slice_instance *ins=
tance,
> @@ -1154,10 +1149,7 @@ static int vdec_vp9_slice_setup_lat(struct vdec_vp=
9_slice_instance *instance,
>         struct vdec_vp9_slice_vsi *vsi =3D &pfc->vsi;
>         int ret;
>
> -       ret =3D vdec_vp9_slice_setup_lat_from_src_buf(instance, lat_buf);
> -       if (ret)
> -               goto err;
> -
> +       vdec_vp9_slice_setup_lat_from_src_buf(instance, bs, lat_buf);
>         ret =3D vdec_vp9_slice_setup_pfc(instance, pfc);
>         if (ret)
>                 goto err;
> --
> 2.46.0
>

