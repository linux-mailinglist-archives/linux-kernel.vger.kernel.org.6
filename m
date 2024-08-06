Return-Path: <linux-kernel+bounces-276409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF35394934A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3098B25F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3A1200113;
	Tue,  6 Aug 2024 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="yp/A7IMs"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7511D54FB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955079; cv=none; b=WqsXzKKyBUfL/avXkb6+ytWkjYg7AHxiHohny9MbrwsqbacFikLBpYPnotgbgG4jrihT5IkS0QFCGSUjhZ37iuhAI3u+n43k6uVRuCrN59bZ/7BnxgO+sg0zHr1MJUaQK9TZPDs3Xu/zVwalP7JwQeTTsPw+ZcjX4sGQ/LY94Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955079; c=relaxed/simple;
	bh=8AxUhTyQhg5d6fIk/x8d9ynNwPaGpaK4vXeKfHRX+Vc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yuib94CXkHg0pICZmj9vKrUM7RqqTjt1VVb4IaKKvR6xU4ZhzPFKSqa6CzEJkYzyKy59Co9nSb3+bUKNx48CkIwupUS+RymIbVmzNDtZK7VIKPSkrpbmIWLL09JOh8Z38sx0aCw1aUO5cd3j/O9AvgCrPGN2lZ+1Ab3nYqzVYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=yp/A7IMs; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7b28442f9so6648746d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1722955076; x=1723559876; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O8w8s8Z0B9GrXJVmKic0qvUBQEuYjfne9EimcVxCr34=;
        b=yp/A7IMseeydQT6tEdAXbEVZvsuJhihtZEaPw/oDKFJc0FcNHdWADj4xef2C2I94R/
         fRGStVydaDvnUhoVX3pWRwz858ep0n69OQTW6G2wxXL8xDdbIMIdyGPkKupEsb5BTu54
         G548z4tdu6Tk62EPfRUg0CdXvPxUEC4BYgHsexnu+bxUCyKardXHdlzCnmAhnV3ywY3X
         B8SfB10hqrPJ2XqpvQLnkSAM+8au0jDbgxgM6dTxzTOJzT7QEMCaCBKMtdQQXO5+xBNH
         NK0FarbJGup2NbDhw14r6036d7y03tuINR9oS4nJStAnSI6gy+l36ehLGhfwjIeAg1Ps
         PZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955076; x=1723559876;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O8w8s8Z0B9GrXJVmKic0qvUBQEuYjfne9EimcVxCr34=;
        b=h84jhPWXdLbLpAPL5twfgSx7oHL2Qdx1SO+VY/TVgI50M9Ygy++h49+GuqmbIX1FG8
         Ky6YTtPLbtdAjqTJMXzStt1yJl5yAvwNXrj5iY4g05GX8yb6vfa1l1/5YQD7Oe+t8Qn3
         AoHjZ5DndmZHSsRA+e1waA1NZ8UBS1ME8T8MCDQhtChSNQnZNfrn9gJoY1xuHgCpXnSS
         6321kd3zWYoHwGrZ0iXJEI7svNmrJepEUZcmgwqbWGQBnP7YFZufAbP4bhzmmEdwXbYz
         afIBxpq2RfWVq6bpyX4BGneUk6C9O56HjW1G9TeyRioTD2R5t5wj0DbnGbMfhi8X+SmA
         uXGg==
X-Forwarded-Encrypted: i=1; AJvYcCUpBOKZEjRqRlCx+CUzVbXBUtOW9IavIP8JihKWS+1ZV6oW2wbSbJGMBc17KqY63+RCcWdoBpwJc1NNtsLmGyWADXOSGHkpCo8Kywh6
X-Gm-Message-State: AOJu0YyTTxR3OQHz1HhhO1InRfciV4vWhcN0vIuBklFb77i6+qY7KLJg
	zt5cV5b5k/TPf1aYkaX4/eToJC88sjDkhtrRR1+tmGFMBPMH+LO3SVtXYBaDilo=
X-Google-Smtp-Source: AGHT+IHpUcAI0zlnc5UagDYOX3enzaUmDiTyLdmwhEKRsENtGUCdx/UiKZ4BgGBYZTV23qMtuDV7yA==
X-Received: by 2002:a05:6214:4881:b0:6b2:dd54:b634 with SMTP id 6a1803df08f44-6bb9843f24cmr204285666d6.39.1722955076181;
        Tue, 06 Aug 2024 07:37:56 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:15:820c::580])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c83970dsm47045726d6.77.2024.08.06.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:37:55 -0700 (PDT)
Message-ID: <3765b1674e276afdc302def55327396a0a29cc63.camel@ndufresne.ca>
Subject: Re: [PATCH] media: s5p-mfc: Corrected NV12M/NV21M plane-sizes
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Aakarsh Jain <aakarsh.jain@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: m.szyprowski@samsung.com, andrzej.hajda@intel.com, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, krzysztof.kozlowski+dt@linaro.org, 
	linux-samsung-soc@vger.kernel.org, gost.dev@samsung.com, 
	aswani.reddy@samsung.com, pankaj.dubey@samsung.com
Date: Tue, 06 Aug 2024 10:37:54 -0400
In-Reply-To: <20240806115714.29828-1-aakarsh.jain@samsung.com>
References: 
	<CGME20240806120911epcas5p1b0defc027a7f03ee9bf5f21036d3ae5e@epcas5p1.samsung.com>
	 <20240806115714.29828-1-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jain,

I haven't dig much, but I have a quick question below.

Le mardi 06 ao=C3=BBt 2024 =C3=A0 17:27 +0530, Aakarsh Jain a =C3=A9crit=C2=
=A0:
> There is a possibility of getting page fault if the overall
> buffer size is not aligned to 256bytes. Since MFC does read
> operation only and it won't corrupt the data values even if
> it reads the extra bytes.
> Corrected luma and chroma plane sizes for V4L2_PIX_FMT_NV12M
> and V4L2_PIX_FMT_NV21M pixel format.

Have you re-run v4l2 compliance ? (better be safe then sorry).

>=20
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c    | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/dr=
ivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index 73f7af674c01..03c957221fc4 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -498,8 +498,8 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_m=
fc_ctx *ctx)
>  	case V4L2_PIX_FMT_NV21M:
>  		ctx->stride[0] =3D ALIGN(ctx->img_width, S5P_FIMV_NV12MT_HALIGN_V6);
>  		ctx->stride[1] =3D ALIGN(ctx->img_width, S5P_FIMV_NV12MT_HALIGN_V6);
> -		ctx->luma_size =3D calc_plane(ctx->stride[0], ctx->img_height);
> -		ctx->chroma_size =3D calc_plane(ctx->stride[1], (ctx->img_height / 2))=
;
> +		ctx->luma_size =3D calc_plane(ctx->img_width, ctx->img_height);
> +		ctx->chroma_size =3D calc_plane(ctx->img_width, (ctx->img_height >> 1)=
);

These size needs to match the sizes reported through TRY_FMT (and S_FMT)
sizeimage for each planes. Is this code being call withing try_fmt ? Will t=
hese
value match or will this change cause the value to miss-match ?

The reason is that correct value is needed for allocating this memory from =
the
outside (like using a DMAbuf Heap). Perhaps its all right, let me know.

Nicolas

>  		break;
>  	case V4L2_PIX_FMT_YUV420M:
>  	case V4L2_PIX_FMT_YVU420M:
> @@ -539,9 +539,11 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_=
mfc_ctx *ctx)
>  static void s5p_mfc_enc_calc_src_size_v6(struct s5p_mfc_ctx *ctx)
>  {
>  	unsigned int mb_width, mb_height;
> +	unsigned int default_size;
> =20
>  	mb_width =3D MB_WIDTH(ctx->img_width);
>  	mb_height =3D MB_HEIGHT(ctx->img_height);
> +	default_size =3D (mb_width * mb_height) * 256;
> =20
>  	if (IS_MFCV12(ctx->dev)) {
>  		switch (ctx->src_fmt->fourcc) {
> @@ -549,8 +551,8 @@ static void s5p_mfc_enc_calc_src_size_v6(struct s5p_m=
fc_ctx *ctx)
>  		case V4L2_PIX_FMT_NV21M:
>  			ctx->stride[0] =3D ALIGN(ctx->img_width, S5P_FIMV_NV12M_HALIGN_V6);
>  			ctx->stride[1] =3D ALIGN(ctx->img_width, S5P_FIMV_NV12M_HALIGN_V6);
> -			ctx->luma_size =3D ctx->stride[0] * ALIGN(ctx->img_height, 16);
> -			ctx->chroma_size =3D  ctx->stride[0] * ALIGN(ctx->img_height / 2, 16)=
;
> +			ctx->luma_size =3D ALIGN(default_size, 256);
> +			ctx->chroma_size =3D ALIGN(default_size / 2, 256);
>  			break;
>  		case V4L2_PIX_FMT_YUV420M:
>  		case V4L2_PIX_FMT_YVU420M:


