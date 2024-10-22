Return-Path: <linux-kernel+bounces-375563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37259A9759
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470E12830B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CAD347C7;
	Tue, 22 Oct 2024 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JuP6I6RA"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54F256D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569522; cv=none; b=F0yMYKNA5J57GFt18rsksai5YrE/hU3JNTZ5EafQzNIi6saDSdTzkWmQ85M4XTPZD3SNvFE3JjliXqxPQEovNhkiV61OVJQQAh9heZ8i4WBOV1829389ZBPBXV5HE45z0igK39A9QG9gKZxuvzOanpBQ1dKca28drNzOy/TUthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569522; c=relaxed/simple;
	bh=TiMQ7lkL1xNr+uvD19954tJMEprwzK6hHSvWx8JjLCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfvo4S5XB3I3Ld9HvluJ5l5MQV/QnCOvR+bkrvOJTDPg25LGbbO7+aGTAXwD4LhKe8D4JoqN+SekGVtUgshmN9/Idn8rHXsreKse4HADOAyCymaCw9R10MLZz8LgirNqTXEXLWZzNqt7+aydijr+GTB1f24TyoqqorFqd6XI1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JuP6I6RA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so49317421fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729569518; x=1730174318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26QZsdFfjNaf2R0pL13dD/w4NeLPSwhQ9nw1ajQqK40=;
        b=JuP6I6RAWMzIyT/DT8//Od0BNDiiT1AblZFdPDbHPaykOgMZs+t1rq+aroMxQgkykJ
         z4tRL4oQ4ctsmzdRRNascoyU+ejebJgNppCJpMrSkQMwCDBhIb//sbmNtQenoIBDDYWs
         rNs5Or6UfostgTC46m+txRhMoaAJdZJkHb9C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729569518; x=1730174318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26QZsdFfjNaf2R0pL13dD/w4NeLPSwhQ9nw1ajQqK40=;
        b=LYS681RwMo+F0hDqkAbJAd1lHlCodUt2vBTGnKUhDRGHUYP9XRn24vuOPq7c8tbRWz
         Bg+Vh/pEfGN07+oD5lzARes1+O2vF3Np5Mg5nIGCBeuJRXEDuB8vSgEugeXk65ybQT02
         CC6lFGEZM9Wg2tMVcJLveyGCxlLRjuqMg0y0BBIT4MaAnk/xu+BYQGB7OHfIs2CdvifQ
         vgZlQg6GfdHuWNokWTwnewamIyZ4CXIH89CLP5dblmGSNH9eZOqD+dDzkKxCVKRxz90Q
         l3/K6+Ac+PSs5ZV3/XHLPVsVbM0581BzOH+aDGdyfEVlrepuAYa3ginHXidn4ZGgl25/
         RCoA==
X-Forwarded-Encrypted: i=1; AJvYcCWUR/LWhwstViI4ktPJjolYhy+FcF5CefQArDVOiHO6+u5jKjUHYjYPjOiZEhCLkp8dfEoIqEsHBC38t4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9KoYSFGwY3CgWaVN1YlQTtQOL8VEiH8mz5BYE5HSsp/oggBr
	8wiRHvRlDft+37tRsAM4yWuM1tDsUiTilvrWphPw7w5cQXdADuAQLFgewfBrmVc6AmCJyr8Rc0u
	BvVsnGqrMkMJzErAX91aR0ow4eCSpFH9sQwxv
X-Google-Smtp-Source: AGHT+IFqMhHSx8Ip59Ca3lTQjk0rTWzLpRf1LICtZkUGARVmXCcNDbvtoO7vAUrk/aZyUBhNLkQE7MFo/l8i4R5X7hA=
X-Received: by 2002:a2e:bc08:0:b0:2fb:51e0:91b with SMTP id
 38308e7fff4ca-2fb832285d4mr68651001fa.43.1729569517643; Mon, 21 Oct 2024
 20:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016034927.8181-1-yunfei.dong@mediatek.com> <20241016034927.8181-2-yunfei.dong@mediatek.com>
In-Reply-To: <20241016034927.8181-2-yunfei.dong@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 22 Oct 2024 11:58:26 +0800
Message-ID: <CAGXv+5GMisONhxu5nnRdLvkav4ttwtrupft26-J01P8ACDx=9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] media: mediatek: vcodec: remove vsi operation in
 common interface
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
> Remove vsi related operation in common interface to make sure the
> interface can be called by different architecture at the same time.

Nit: it would be nice to provide more context here. You could mention
that a new extended interface with a different shared memory layout (vsi)
will be introduced in later patches.

> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../decoder/vdec/vdec_h264_req_multi_if.c     | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h26=
4_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec=
_h264_req_multi_if.c
> index 732d78f63e5a..57c85af5ffb4 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_m=
ulti_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_m=
ulti_if.c
> @@ -171,9 +171,9 @@ struct vdec_h264_slice_inst {
>  };
>
>  static int vdec_h264_slice_fill_decode_parameters(struct vdec_h264_slice=
_inst *inst,
> -                                                 struct vdec_h264_slice_=
share_info *share_info)
> +                                                 struct vdec_h264_slice_=
share_info *share_info,
> +                                                 struct vdec_h264_slice_=
lat_dec_param *slice_data)

Nit: you could just name this new parameter |slice_param| and avoid the
changes in the next bit.

>  {
> -       struct vdec_h264_slice_lat_dec_param *slice_param =3D &inst->vsi-=
>h264_slice_params;
>         const struct v4l2_ctrl_h264_decode_params *dec_params;
>         const struct v4l2_ctrl_h264_scaling_matrix *src_matrix;
>         const struct v4l2_ctrl_h264_sps *sps;
> @@ -203,9 +203,9 @@ static int vdec_h264_slice_fill_decode_parameters(str=
uct vdec_h264_slice_inst *i
>                 return -EINVAL;
>         }
>
> -       mtk_vdec_h264_copy_sps_params(&slice_param->sps, sps);
> -       mtk_vdec_h264_copy_pps_params(&slice_param->pps, pps);
> -       mtk_vdec_h264_copy_scaling_matrix(&slice_param->scaling_matrix, s=
rc_matrix);
> +       mtk_vdec_h264_copy_sps_params(&slice_data->sps, sps);
> +       mtk_vdec_h264_copy_pps_params(&slice_data->pps, pps);
> +       mtk_vdec_h264_copy_scaling_matrix(&slice_data->scaling_matrix, sr=
c_matrix);
>
>         memcpy(&share_info->sps, sps, sizeof(*sps));
>         memcpy(&share_info->dec_params, dec_params, sizeof(*dec_params));
> @@ -266,9 +266,6 @@ static int get_vdec_sig_decode_parameters(struct vdec=
_h264_slice_inst *inst)
>         mtk_vdec_h264_get_ref_list(b0_reflist, v4l2_b0_reflist, reflist_b=
uilder.num_valid);
>         mtk_vdec_h264_get_ref_list(b1_reflist, v4l2_b1_reflist, reflist_b=
uilder.num_valid);
>
> -       memcpy(&inst->vsi_ctx.h264_slice_params, slice_param,
> -              sizeof(inst->vsi_ctx.h264_slice_params));
> -
>         return 0;
>  }
>
> @@ -608,7 +605,8 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, s=
truct mtk_vcodec_mem *bs,
>         lat_buf->vb2_v4l2_src =3D &src_buf_info->m2m_buf.vb;
>         v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->t=
s_info, true);
>
> -       err =3D vdec_h264_slice_fill_decode_parameters(inst, share_info);
> +       err =3D vdec_h264_slice_fill_decode_parameters(inst, share_info,
> +                                                    &inst->vsi->h264_sli=
ce_params);
>         if (err)
>                 goto err_free_fb_out;
>
> @@ -749,6 +747,9 @@ static int vdec_h264_slice_single_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs
>         if (err)
>                 goto err_free_fb_out;
>
> +       memcpy(&inst->vsi_ctx.h264_slice_params, &inst->h264_slice_param,
> +              sizeof(inst->vsi_ctx.h264_slice_params));
> +
>         buf =3D (unsigned char *)bs->va;
>         nal_start_idx =3D mtk_vdec_h264_find_start_code(buf, bs->size);
>         if (nal_start_idx < 0) {

Code wise this patch seems fine.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

