Return-Path: <linux-kernel+bounces-443244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 838239EE920
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A61D2885FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B129222069F;
	Thu, 12 Dec 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="uv+YETuj"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448D215777
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014345; cv=none; b=KL1vOIPcVKCJX4q87MjdVSLl1x3M20n9rPyVTjnQwyzmxb+K3MgjnWWva0zWk1mV437Gy7kf2BcSfLCOKxKs3kpKbAoN/z6xxxrPRgmaukC7pcJpUxZjgpLRJlZ4zsvKUoxkjyJe5NwjZw1beTwMr0Mry8I/22oH4zcndbnOXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014345; c=relaxed/simple;
	bh=599jzleU/Vks0Hc//LOaqBWitYZZWwnXhT6+DW7rGko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmuVb59FV+38rooLHtQeG+5Ouh2Norq/C/xlsDvejYS5O/9OR+MDMvcKeOi50x6Al7B/ncKE1VujHqvgsPpZADrYog0WuTepQa8k9UesgnljeySFVAWBcX42o1tOKLcuqYb3mIRTEjP17WkFccu6qjNl5bsahd8yw97rBjUoARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=uv+YETuj; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d932b5081eso5836186d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1734014340; x=1734619140; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gnNW27xV9OdBmnsbxp5/+ionKj2v7VRdl1Rz7Jx7aEU=;
        b=uv+YETujZFGhhkikaqWmpiVUrqeZF2KPsrsKoK4pSM6OFqVGAYm6P0U0I3SyD+vbB8
         OjpdZntBbVy6s6TFQdrMD5P0bX8b0AHV8onU4gW7QqwA5jjv6DgZUFHaUdaIPxZGq8TA
         Oc8gJsvFXT4OOdbr+0/t8AEK/uHcHR3POUB8QWS3a1b7myIYQLenaP/pROTy+6t5s+WF
         qPsYC8gYx7phndJRMyuFTzk+DWuJVIaqD+3PdUWYINe9UDWvOyg+iE7VIq/5bM3V+5Wt
         s92+tD9W4ZhMuaFbl9KPa95P5LYSLqyxoDKBn5xOezUVR3djE9YEYG/GrS1zcEaUrdPE
         ibGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014340; x=1734619140;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnNW27xV9OdBmnsbxp5/+ionKj2v7VRdl1Rz7Jx7aEU=;
        b=QYVh8/CA42MazjhylHflBJCpYz2F2/MmBZNSuQRn9N4ezgDaHcVTJwl8feOcULV/3d
         +TJjQ8hEgFPrCgcJzMbBlfYAOPsclt3j81XDN7hC+o/5QOGNAAT/E/7Kpdrzs+6kltAy
         s9QuIRPolEaeoAfgPx3mCoCXwwyJvbb3s2BRttBSVscJnXJPC6u6PI8yu/bKgY6zX/zk
         9hOtZO0yjBxYYVKW72Q5M96h5RQm37f8J+ftnHBmkO95jSM/TB0zNYUT9LjZ7ixBvln4
         YsnEGTL4DMhYy+U61AkAjVIma42kdrnYNeD15L8tZ5/O/90BxvMOPLERglbot5wskIzB
         OE+g==
X-Forwarded-Encrypted: i=1; AJvYcCV6SxUVE6eAfgoOaLb+T7QeWMmst96gIiRTr6aFgZVmlStx3kl526GCvIcx8AEs1rECKMZROnYsoDMlQ8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQkkvQXnTlHKtm9ipnxhfVpi8MbzCa/jgVRe1MvzBptp/3YwQ
	4uq12aPT2rnnRFDYExutXghp1wOj9xouhHiOKOHg1CFqhOckyEfjIkwvGou5eGg=
X-Gm-Gg: ASbGncvNKq/UekeWB+dXUZuvWcPB4T6Sbqpq2RalmBTSlnimEkCX4Ks1DPi9OzVDOuK
	12AoKjAkJ0J9EpBbeq3SHfMC5BwIVPjn0HMt3eHWQw5FIjhgwpNdT+uDo7TsLm7/T1xUtatnqFZ
	UjP1fW6Kgu6jbul4qZkQGAlHmY1Bph9NImPLNACjK2mK81v/ryp0BdDhUlC6A/RE+he1X1TMaKy
	4oyvh9/iElXtk4CHiyVmqr9wH1SpGZ/gsU6X3NlKXzqapGsXNY79bgj4g==
X-Google-Smtp-Source: AGHT+IGmO7vrV4lBSu51A4Jo3F1+xpPX/fE/NF4f3ogB/sqBTaZfQW/1UmMn9l0bRhcm39SXwiw4VA==
X-Received: by 2002:a05:6214:5086:b0:6d8:9610:a9ff with SMTP id 6a1803df08f44-6db0f709a84mr6522866d6.1.1734014340001;
        Thu, 12 Dec 2024 06:39:00 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:862e::7a9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fdecesm81997096d6.77.2024.12.12.06.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 06:38:59 -0800 (PST)
Message-ID: <03c38f0076a018672c303e159f65742550b6c4b1.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] media: verisilicon: Store reference frames pixels
 format
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Date: Thu, 12 Dec 2024 09:38:58 -0500
In-Reply-To: <01020192f83fdd04-16f415e6-64f6-44f2-8f79-7676d301d4ab-000000@eu-west-1.amazonses.com>
References: <20241104173623.1058335-1-benjamin.gaignard@collabora.com>
	 <01020192f83fdd04-16f415e6-64f6-44f2-8f79-7676d301d4ab-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 04 novembre 2024 =C3=A0 17:36 +0000, Benjamin Gaignard a =C3=A9cri=
t=C2=A0:
> Hantro decoder always produce tiled pixels formats but
> when the post-processor is used the destination pixels
> format is a non tiled pixels format. This led to compute
> wrong reference frame size and offsets.
> Getting and saving the correct tiled pixels format for 8
> and 10 bit stream solve the computation issues.
>=20
> Fluster VP9 score increase to 166/305 (vs 145/305).
> HEVC score is still 141/147.
>=20
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/verisilicon/hantro.h   |  2 ++
>  .../media/platform/verisilicon/hantro_g2.c    |  2 +-
>  .../platform/verisilicon/hantro_postproc.c    | 28 ++++++-------------
>  .../media/platform/verisilicon/hantro_v4l2.c  | 21 ++++++++++++++
>  4 files changed, 33 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/=
platform/verisilicon/hantro.h
> index 811260dc3c77..14fc6a3e2878 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -227,6 +227,7 @@ struct hantro_dev {
>   * @src_fmt:		V4L2 pixel format of active source format.
>   * @vpu_dst_fmt:	Descriptor of active destination format.
>   * @dst_fmt:		V4L2 pixel format of active destination format.
> + * @ref_fmt:		V4L2 pixel format of the reference frames format.
>   *
>   * @ctrl_handler:	Control handler used to register controls.
>   * @jpeg_quality:	User-specified JPEG compression quality.
> @@ -255,6 +256,7 @@ struct hantro_ctx {
>  	struct v4l2_pix_format_mplane src_fmt;
>  	const struct hantro_fmt *vpu_dst_fmt;
>  	struct v4l2_pix_format_mplane dst_fmt;
> +	struct v4l2_pix_format_mplane ref_fmt;
> =20
>  	struct v4l2_ctrl_handler ctrl_handler;
>  	int jpeg_quality;
> diff --git a/drivers/media/platform/verisilicon/hantro_g2.c b/drivers/med=
ia/platform/verisilicon/hantro_g2.c
> index b880a6849d58..5d33d745d346 100644
> --- a/drivers/media/platform/verisilicon/hantro_g2.c
> +++ b/drivers/media/platform/verisilicon/hantro_g2.c
> @@ -47,7 +47,7 @@ irqreturn_t hantro_g2_irq(int irq, void *dev_id)
> =20
>  size_t hantro_g2_chroma_offset(struct hantro_ctx *ctx)
>  {
> -	return ctx->dst_fmt.width * ctx->dst_fmt.height * ctx->bit_depth / 8;
> +	return ctx->ref_fmt.plane_fmt[0].bytesperline *	ctx->ref_fmt.height;
>  }
> =20
>  size_t hantro_g2_motion_vectors_offset(struct hantro_ctx *ctx)
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drive=
rs/media/platform/verisilicon/hantro_postproc.c
> index 41e93176300b..4ba29682dbd6 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -194,31 +194,21 @@ void hantro_postproc_free(struct hantro_ctx *ctx)
> =20
>  static unsigned int hantro_postproc_buffer_size(struct hantro_ctx *ctx)
>  {
> -	struct v4l2_pix_format_mplane pix_mp;
> -	const struct hantro_fmt *fmt;
>  	unsigned int buf_size;
> =20
> -	/* this should always pick native format */
> -	fmt =3D hantro_get_default_fmt(ctx, false, ctx->bit_depth, HANTRO_AUTO_=
POSTPROC);
> -	if (!fmt)
> -		return 0;
> -
> -	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
> -			    ctx->src_fmt.height);
> -
> -	buf_size =3D pix_mp.plane_fmt[0].sizeimage;
> +	buf_size =3D ctx->ref_fmt.plane_fmt[0].sizeimage;
>  	if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_H264_SLICE)
> -		buf_size +=3D hantro_h264_mv_size(pix_mp.width,
> -						pix_mp.height);
> +		buf_size +=3D hantro_h264_mv_size(ctx->ref_fmt.width,
> +						ctx->ref_fmt.height);
>  	else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_VP9_FRAME)
> -		buf_size +=3D hantro_vp9_mv_size(pix_mp.width,
> -					       pix_mp.height);
> +		buf_size +=3D hantro_vp9_mv_size(ctx->ref_fmt.width,
> +					       ctx->ref_fmt.height);
>  	else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_HEVC_SLICE)
> -		buf_size +=3D hantro_hevc_mv_size(pix_mp.width,
> -						pix_mp.height);
> +		buf_size +=3D hantro_hevc_mv_size(ctx->ref_fmt.width,
> +						ctx->ref_fmt.height);
>  	else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_AV1_FRAME)
> -		buf_size +=3D hantro_av1_mv_size(pix_mp.width,
> -					       pix_mp.height);
> +		buf_size +=3D hantro_av1_mv_size(ctx->ref_fmt.width,
> +					       ctx->ref_fmt.height);
> =20
>  	return buf_size;
>  }
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index df6f2536263b..a9a54f177405 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -126,6 +126,24 @@ hantro_find_format(const struct hantro_ctx *ctx, u32=
 fourcc)
>  	return NULL;
>  }
> =20
> +static int
> +hantro_set_reference_frames_format(struct hantro_ctx *ctx)
> +{
> +	const struct hantro_fmt *fmt;
> +	int dst_bit_depth =3D hantro_get_format_depth(ctx->vpu_dst_fmt->fourcc)=
;
> +
> +	fmt =3D hantro_get_default_fmt(ctx, false, dst_bit_depth, HANTRO_AUTO_P=
OSTPROC);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	ctx->ref_fmt.width =3D ctx->src_fmt.width;
> +	ctx->ref_fmt.height =3D ctx->src_fmt.height;
> +
> +	v4l2_apply_frmsize_constraints(&ctx->ref_fmt.width, &ctx->ref_fmt.heigh=
t, &fmt->frmsize);
> +	return v4l2_fill_pixfmt_mp(&ctx->ref_fmt, fmt->fourcc,
> +				   ctx->ref_fmt.width, ctx->ref_fmt.height);
> +}
> +
>  const struct hantro_fmt *
>  hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream,
>  		       int bit_depth, bool need_postproc)
> @@ -591,6 +609,9 @@ static int hantro_set_fmt_cap(struct hantro_ctx *ctx,
> =20
>  	ctx->vpu_dst_fmt =3D hantro_find_format(ctx, pix_mp->pixelformat);
>  	ctx->dst_fmt =3D *pix_mp;
> +	ret =3D hantro_set_reference_frames_format(ctx);
> +	if (ret)
> +		return ret;
> =20
>  	/*
>  	 * Current raw format might have become invalid with newly


