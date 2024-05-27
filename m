Return-Path: <linux-kernel+bounces-190120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09B8CF9BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2AC1C20DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614717727;
	Mon, 27 May 2024 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YlTMDtJe"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCD2030B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716793647; cv=none; b=V4gaKfbyyYH80TSUfrPOkHOZa/TUWI7nkQI4yrH5G1P+L+LkkTf2ObQDiiDl2AbMLyTYrYQMe8t8DPjEhbZ0K0Sdlis5VMJTwJ5cd9LEXWXaCW7QSxSIdjGQo0onSPx2eqQEs7U3hGCHsiWDVb49YbyfCJGzEWbRlLbGyoX5BlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716793647; c=relaxed/simple;
	bh=ImEUO9DtV4lgYdPlOis8gMBc3j3CTxVAQdmwTK5bO+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czmO/00BvB4OfPU2TMUbIH/xON5xBqOITw4ELq+LyUvEw9T81q50Ss9yz4FHnkfmj59p1ufHvMQzVMEYN4DLNO5YXYKgN8E9+Ch9E3121d8ep50yWxFyg4FZ7ZATSG05oc5wMdgPt21mSR6uHh+Nuh3PIBjDXzQVQYhQHqzb33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YlTMDtJe; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5296935252dso2705501e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716793643; x=1717398443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcSwrAOBgk0SabpBSOsxuNeS90Z/JnZDn0cwEFk4oc8=;
        b=YlTMDtJeLgLa1RWUdLcDYCTtYZOdK47S9CvfopEx7k9+SXG5Hbo0c7jYI91lI7JL6J
         aqQeeKKiJOWRKeSDHi+Er/CMfdDqlgbQRahNwbH5xairF3wcHlErsQMQq8b6+6I1VrQi
         kzC+4Jmxwe/LNAwNSY38auGVoHlsRTkAwbB5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716793643; x=1717398443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcSwrAOBgk0SabpBSOsxuNeS90Z/JnZDn0cwEFk4oc8=;
        b=YfNKf3LtyMNpj4SzvR81LcZ0CG5Tyd4AlQZ0YookJFaBgoI2tkROn3vcGjph0jFLii
         xyFPdHkjADdgFstTUj8v6Z6tT9vQApIsGZqdMFAlnlYp98CmxJDTQoyRvizlf8S7sciO
         Uyf3fdXQvzwgTdg6rs1jLzEw2/StPCw5RHbCR/0MSSHC8Pn58HhuWMO/UggwESVkAwO2
         8ArnlaxsIe2VTEyObiTFgWvSccT9zIakOh0EYfX2t+MndkEkv5ubv+pifIUx+uCBt+u7
         ptAzPhKmJAROpCncShcFbkw7U7GyKrz7mBy/FE9TORnk+0nbmfKTwEBMUVHXYKkdLmpH
         veAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKLbcKgwpkFQorBgHWM7Y0ZaSgLoTW1pwTaSWwu38yaB9K52HJ5ffRSBMAP3zRshe30SvTQvOrg7fXW8UjPkXGDPIiXGoX67UtingS
X-Gm-Message-State: AOJu0Ywjjc1zqRKJULig4AxtgctlSDvDFcCPkSRIeCUcvw++offXVu1K
	KTDPlHNze0uhZH9F1m3vblt28wxHlc1aU1sZQ/Gm/bGMG8hE31PajQVpBiKhZeDl2D9ZIB4pVRQ
	lXBcjX5lpLaTdz3/3u6kpTDv35SWZMxH8mri+
X-Google-Smtp-Source: AGHT+IH6hkPVE7ofiPKTM1LpKdq3IVMXIknOENA5KSdXkvMNG/QOho/QQ2nuWyvBQu7FsSYAuoYRgFJca6ReR+79/8Q=
X-Received: by 2002:a19:5f07:0:b0:51f:3cb3:48a4 with SMTP id
 2adb3069b0e04-529646e3b70mr4742266e87.1.1716793643444; Mon, 27 May 2024
 00:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516122102.16379-1-yunfei.dong@mediatek.com> <20240516122102.16379-15-yunfei.dong@mediatek.com>
In-Reply-To: <20240516122102.16379-15-yunfei.dong@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 27 May 2024 15:07:12 +0800
Message-ID: <CAGXv+5Fo2x1R1=rJgC6ymLPMJYOypQdu9wQNdgSrjREyiQWHPw@mail.gmail.com>
Subject: Re: [PATCH v6,14/24] media: mediatek: vcodec: Add capture format to
 support one plane memory
To: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: Jeffrey Kardatzke <jkardatzke@google.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Nathan Hebert <nhebert@chromium.org>, Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, Tomasz Figa <tfiga@chromium.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Yong Wu <yong.wu@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Fritz Koenig <frkoenig@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, 
	Steve Cho <stevecho@chromium.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T . J . Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 8:21=E2=80=AFPM Yunfei Dong <yunfei.dong@mediatek.c=
om> wrote:
>
> Define one uncompressed capture format V4L2_PIX_FMT_MS21 in order to
> support one plane memory. The buffer size is luma + chroma, luma is
> stored at the start and chrome is stored at the end.
>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 8 ++++++++
>  drivers/media/v4l2-core/v4l2-common.c                     | 2 ++
>  drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
>  include/uapi/linux/videodev2.h                            | 1 +
>  4 files changed, 12 insertions(+)
>
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/=
Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index 886ba7b08d6b..6ec899649d50 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -295,6 +295,14 @@ please make a proposal on the linux-media mailing li=
st.
>        - Compressed format used by Nuvoton NPCM video driver. This format=
 is
>          defined in Remote Framebuffer Protocol (RFC 6143, chapter 7.7.4 =
Hextile
>          Encoding).
> +    * .. _V4L2-PIX-FMT-MS21:
> +
> +      - ``V4L2_PIX_FMT_MS21``
> +      - 'MS21'
> +      - This format has one plane, luma and chroma are stored in a conti=
guous
> +        memory. Luma pixel in 16x32 tiles at the start, chroma pixel in =
16x16
> +        tiles at the end. The image height must be aligned with 32 and t=
he image
> +        width must be aligned with 16.
>  .. raw:: latex
>
>      \normalsize
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 4165c815faef..5ae54cf48dc7 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -271,6 +271,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
>                   .block_w =3D { 16, 8, 0, 0 }, .block_h =3D { 32, 16, 0,=
 0 }},
>                 { .format =3D V4L2_PIX_FMT_MT2110R, .pixel_enc =3D V4L2_P=
IXEL_ENC_YUV, .mem_planes =3D 2, .comp_planes =3D 2, .bpp =3D { 5, 10, 0, 0=
 }, .bpp_div =3D { 4, 4, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2,
>                   .block_w =3D { 16, 8, 0, 0 }, .block_h =3D { 32, 16, 0,=
 0 }},
> +               { .format =3D V4L2_PIX_FMT_MS21, pixel_enc =3D V4L2_PIXEL=
_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .=
bpp_div =3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2,

                                                 ^
This is missing a '.' before 'pixel_enc', which breaks the build.

ChenYu

> +                 .block_w =3D { 16, 8, 0, 0 }, .block_h =3D { 32, 16, 0,=
 0 }},
>
>                 /* YUV planar formats */
>                 { .format =3D V4L2_PIX_FMT_NV12,    .pixel_enc =3D V4L2_P=
IXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 =
}, .bpp_div =3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 4c76d17b4629..3a68f2b9e7a4 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1529,6 +1529,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>                 case V4L2_PIX_FMT_MT2110T:      descr =3D "Mediatek 10bit=
 Tile Mode"; break;
>                 case V4L2_PIX_FMT_MT2110R:      descr =3D "Mediatek 10bit=
 Raster Mode"; break;
>                 case V4L2_PIX_FMT_HEXTILE:      descr =3D "Hextile Compre=
ssed Format"; break;
> +               case V4L2_PIX_FMT_MS21:         descr =3D "MediaTek One P=
lane Format"; break;
>                 default:
>                         if (fmt->description[0])
>                                 return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 89eb1a3c6555..7aff2f2c8f9c 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -800,6 +800,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_MM21     v4l2_fourcc('M', 'M', '2', '1') /* Mediate=
k 8-bit block mode, two non-contiguous planes */
>  #define V4L2_PIX_FMT_MT2110T  v4l2_fourcc('M', 'T', '2', 'T') /* Mediate=
k 10-bit block tile mode */
>  #define V4L2_PIX_FMT_MT2110R  v4l2_fourcc('M', 'T', '2', 'R') /* Mediate=
k 10-bit block raster mode */
> +#define V4L2_PIX_FMT_MS21     v4l2_fourcc('M', 'S', '2', '1') /* MediaTe=
k 8-bit block mode with one plane */
>  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel P=
lanar Greyscale 10-bit and Depth 16-bit */
>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4=
-bit packed depth confidence information */
>  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-=
bit dithered RGB */
> --
> 2.25.1
>

