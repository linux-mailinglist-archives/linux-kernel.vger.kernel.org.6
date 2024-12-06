Return-Path: <linux-kernel+bounces-435144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B089E7119
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93180281EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B020011A;
	Fri,  6 Dec 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="P7D43zKc"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874B1547E7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496698; cv=none; b=a9QBhyuwiw/YwVYm+KAZIOMitYwOnVUIZ27ZNn7PQf3NzxqumQz+wsMuATBEvp6MYqVmyRIYhw8omPB1sMyI/1/VuuiALcFULLhZbx9GNIWvfvzPJQfGXIBi6utx461oDvt1x+KBy1NMKLAS6ACA63Qc9GYkqJrjMWb6FXAwLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496698; c=relaxed/simple;
	bh=/tuYPwJTtJ4Svob5I/ujRMdmikjrzcucjhMGBvhTg/A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pCZfmCe7xbxn9gC72kukMrOwT/vaqNi1BB/Ex8ZCxuw2VWNdnAiy2LArrJp5aHVPU7EadZKZAeKXmfMgj7BgIr3TBCH0l8c6KkjUxme/8VE4Vmk3J50nFxhUCwFzltQJLwGEoC9FhrAFqomQYJ8dXyvUyJBBlBCJSWFKqMweD60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=P7D43zKc; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so3245771a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 06:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1733496694; x=1734101494; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4sWRf4hJF+nJwKhKGaqJGBfySo0Ly+PnsMhNpbfdzo=;
        b=P7D43zKchPrhdx3fk4Ecjry55dvz3dYInI/0bHsdDgwvTvqIv+CjFOgtb5nq2NC581
         1KIUWBnoLGanbgqju8OX0gunuamecdC07hwa0oPs2YdmkGXa6LFzdEjLlbHk6oMh0tJK
         ZoiQu56CDMfc+VZNAY1g5dhrKdGxmDwdqzgjWFBcTeyHa8JEsJOiYJIIUof0UMQVvrM/
         S7kzXSEk2zK7PCLtHtcOvDw3cFi7KdmZb7pD5MNyvrr0lxtomrMVFfbeUqV55CmrWd2x
         ji+nqPLrFMeUWSS8caktjRI+X7f+P0nlUOQLwnYPg1NiBxZxUu/YxUlug9CdeJhvxmkP
         8TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733496694; x=1734101494;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u4sWRf4hJF+nJwKhKGaqJGBfySo0Ly+PnsMhNpbfdzo=;
        b=kc8D+7RThisVdpa/ZFvjZZqdUPAniIBLIQyNc2SH8UUmbsdtJ/10xm5s5Cnt9IBRbS
         k0Z8iVvQT+twtIjwb+XfUHxVIGvNH2Jp64GUOTVhSTBdyLy+hwqd4wAhae44esVXdYTo
         K7qnpnVciuOsqIjA1WVpG3lpWE1HQ5dcJqgMkb7fdphNdYFihnuI6NzwXTdDknnsbWY3
         wbZbqlnKhdvbzePSkoApvCL+0NdPk5SWIMOqSDcTtW4Ap1WHfxwYx9XLOzQiyCdRvmsg
         g/gqvAyX2/RRn1KkziN3ssg2FJVakuXmE5lA9R7XVQUK4feMcImCsHJHrFaoAPHWjXdg
         kngg==
X-Forwarded-Encrypted: i=1; AJvYcCXhBUn0iH36AAnBxRFaNixcY58g5hOWAeMOheiMmjpiESFm3yLAnLMXMxs1Z+9keakaeBVvDvxyghaCZQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+NEzSUn8DCW+m7mX8bOjZZ3+gpxT19Ik4NqgRcND5C3vkUSII
	wJeqMppR5bb1obTqqwHMcilHV+g+7YWbHA3wOwvQq/vRvd7EE1YNlpstNvNSvbw=
X-Gm-Gg: ASbGncuIYI4t6hVdY/5IuKUk5tcce61MvH+PDbR2ITP/XKNj4IhzZpeWwrYf49BGMGo
	ZOmGsnNCOiRPzDVT5Mpzc2HOR3kTDdysVxpbZeSCLNX9x8U7PneNwJIS/MlP3xN6nhquaY1sn5N
	5VO5xX9Wk0PpivlQSZfAcFdeVOwGX3AQoIZfkNjvTWW5WoCoayrC36+83ytWb4OOUoiiEtIeLwn
	UJXoK1QugRFAHxTt8udBaB8kR2utR+1iPJGQ5ilLawTSDyB5RJ1Cai/bX8BkTj4Z+5jHTG/psAG
	3e4QrmCs2Jm1pfDyRfodeEipKWsfpqSjFwhy6D9H+AGlIps1gn/LXFl5q54u/g==
X-Google-Smtp-Source: AGHT+IF3ycQKdVhs/GREAgOvRVra6yPFbB24y2IHadPhsDlfk3Y572eRHeBOD9F6SFeEhTxMX7fWeA==
X-Received: by 2002:a05:6402:358a:b0:5d2:7199:ae7 with SMTP id 4fb4d7f45d1cf-5d3be6d74b2mr3641833a12.11.1733496694443;
        Fri, 06 Dec 2024 06:51:34 -0800 (PST)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3bc829433sm1261863a12.38.2024.12.06.06.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 06:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Dec 2024 15:51:33 +0100
Message-Id: <D64PAIXELZ6A.37ZSFBIRPE6MT@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jordan Crouse" <jorcrous@amazon.com>, <linux-media@vger.kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Robert Foss" <rfoss@kernel.org>, "Todor Tomov"
 <todor.too@gmail.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] media: camss: Increase the maximum frame size
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240802152435.35796-1-jorcrous@amazon.com>
 <20240802152435.35796-2-jorcrous@amazon.com>
In-Reply-To: <20240802152435.35796-2-jorcrous@amazon.com>

On Fri Aug 2, 2024 at 5:24 PM CEST, Jordan Crouse wrote:
> Commit 35493d653a2d
> ("media: camss: add support for vidioc_enum_framesizes ioctl") added a
> maximum frame width and height but the values selected seemed to have
> been arbitrary. In reality the cam hardware doesn't seem to have a maximu=
m
> size restriction so double up the maximum reported width and height to
> allow for larger frames.
>
> Also increase the maximum size checks at each point in the pipeline so
> the increased sizes are allowed all the way down to the sensor.

Hi Jordan,

Looks like this hasn't landed yet, do you plan on resending this?

Just wanted to try a 8192x6144 format but csid limiting the size to 8191
is a bit in the way.

Regards
Luca

>
> Signed-off-by: Jordan Crouse <jorcrous@amazon.com>
> ---
>
>  drivers/media/platform/qcom/camss/camss-csid.c   | 8 ++++----
>  drivers/media/platform/qcom/camss/camss-csiphy.c | 4 ++--
>  drivers/media/platform/qcom/camss/camss-ispif.c  | 4 ++--
>  drivers/media/platform/qcom/camss/camss-vfe.c    | 4 ++--
>  drivers/media/platform/qcom/camss/camss-video.c  | 6 +++---
>  5 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/med=
ia/platform/qcom/camss/camss-csid.c
> index 858db5d4ca75..886c42c82612 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -752,8 +752,8 @@ static void csid_try_format(struct csid_device *csid,
>  		if (i >=3D csid->res->formats->nformats)
>  			fmt->code =3D MEDIA_BUS_FMT_UYVY8_1X16;
> =20
> -		fmt->width =3D clamp_t(u32, fmt->width, 1, 8191);
> -		fmt->height =3D clamp_t(u32, fmt->height, 1, 8191);
> +		fmt->width =3D clamp_t(u32, fmt->width, 1, 16383);
> +		fmt->height =3D clamp_t(u32, fmt->height, 1, 16383);
> =20
>  		fmt->field =3D V4L2_FIELD_NONE;
>  		fmt->colorspace =3D V4L2_COLORSPACE_SRGB;
> @@ -781,8 +781,8 @@ static void csid_try_format(struct csid_device *csid,
>  			if (i >=3D csid->res->formats->nformats)
>  				fmt->code =3D MEDIA_BUS_FMT_UYVY8_1X16;
> =20
> -			fmt->width =3D clamp_t(u32, fmt->width, 1, 8191);
> -			fmt->height =3D clamp_t(u32, fmt->height, 1, 8191);
> +			fmt->width =3D clamp_t(u32, fmt->width, 1, 16383);
> +			fmt->height =3D clamp_t(u32, fmt->height, 1, 16383);
> =20
>  			fmt->field =3D V4L2_FIELD_NONE;
>  		}
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/m=
edia/platform/qcom/camss/camss-csiphy.c
> index 2f7361dfd461..43c35ad6ac84 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -368,8 +368,8 @@ static void csiphy_try_format(struct csiphy_device *c=
siphy,
>  		if (i >=3D csiphy->res->formats->nformats)
>  			fmt->code =3D MEDIA_BUS_FMT_UYVY8_1X16;
> =20
> -		fmt->width =3D clamp_t(u32, fmt->width, 1, 8191);
> -		fmt->height =3D clamp_t(u32, fmt->height, 1, 8191);
> +		fmt->width =3D clamp_t(u32, fmt->width, 1, 16383);
> +		fmt->height =3D clamp_t(u32, fmt->height, 1, 16383);
> =20
>  		fmt->field =3D V4L2_FIELD_NONE;
>  		fmt->colorspace =3D V4L2_COLORSPACE_SRGB;
> diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/me=
dia/platform/qcom/camss/camss-ispif.c
> index a12dcc7ff438..01e2ded8da0b 100644
> --- a/drivers/media/platform/qcom/camss/camss-ispif.c
> +++ b/drivers/media/platform/qcom/camss/camss-ispif.c
> @@ -912,8 +912,8 @@ static void ispif_try_format(struct ispif_line *line,
>  		if (i >=3D line->nformats)
>  			fmt->code =3D MEDIA_BUS_FMT_UYVY8_1X16;
> =20
> -		fmt->width =3D clamp_t(u32, fmt->width, 1, 8191);
> -		fmt->height =3D clamp_t(u32, fmt->height, 1, 8191);
> +		fmt->width =3D clamp_t(u32, fmt->width, 1, 16383);
> +		fmt->height =3D clamp_t(u32, fmt->height, 1, 16383);
> =20
>  		fmt->field =3D V4L2_FIELD_NONE;
>  		fmt->colorspace =3D V4L2_COLORSPACE_SRGB;
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/medi=
a/platform/qcom/camss/camss-vfe.c
> index 83c5a36d071f..826c0fb31785 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -1049,8 +1049,8 @@ static void vfe_try_format(struct vfe_line *line,
>  		if (i >=3D line->nformats)
>  			fmt->code =3D MEDIA_BUS_FMT_UYVY8_1X16;
> =20
> -		fmt->width =3D clamp_t(u32, fmt->width, 1, 8191);
> -		fmt->height =3D clamp_t(u32, fmt->height, 1, 8191);
> +		fmt->width =3D clamp_t(u32, fmt->width, 1, 16383);
> +		fmt->height =3D clamp_t(u32, fmt->height, 1, 16383);
> =20
>  		fmt->field =3D V4L2_FIELD_NONE;
>  		fmt->colorspace =3D V4L2_COLORSPACE_SRGB;
> diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/me=
dia/platform/qcom/camss/camss-video.c
> index cd72feca618c..5fee3733da8e 100644
> --- a/drivers/media/platform/qcom/camss/camss-video.c
> +++ b/drivers/media/platform/qcom/camss/camss-video.c
> @@ -19,10 +19,10 @@
>  #include "camss.h"
> =20
>  #define CAMSS_FRAME_MIN_WIDTH		1
> -#define CAMSS_FRAME_MAX_WIDTH		8191
> +#define CAMSS_FRAME_MAX_WIDTH		16833
>  #define CAMSS_FRAME_MIN_HEIGHT		1
> -#define CAMSS_FRAME_MAX_HEIGHT_RDI	8191
> -#define CAMSS_FRAME_MAX_HEIGHT_PIX	4096
> +#define CAMSS_FRAME_MAX_HEIGHT_RDI	16833
> +#define CAMSS_FRAME_MAX_HEIGHT_PIX	8192
> =20
>  /* ---------------------------------------------------------------------=
--------
>   * Helper functions


