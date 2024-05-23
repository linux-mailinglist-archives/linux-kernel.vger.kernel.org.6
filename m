Return-Path: <linux-kernel+bounces-187340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804CA8CD06D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC292848CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9826D1411F5;
	Thu, 23 May 2024 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CyGWIRvG"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D613D51A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460579; cv=none; b=hSt51Tl3CiYxYwRFkVv04Z+KHgv3hfeZI4TWoSzzn0yPcTi4d8WgKMTf52+7/g9BPpyi94XnRKt5gnQxO1XL2PyPzb0CXwufnWa9GQGJl7wU4sTe7Ksw+RKo7JPscpz82Vs3BMDpPgvP0qSPVZOvHKAUU0pRvOX+0mW15E/0qC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460579; c=relaxed/simple;
	bh=Vi/TWy4pXHET7ZsS0+/vQED8r602FF0RXGhdO2mz9og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phoWcp6GiH9qJtXvZXb/Kw+ebMscep3K7akw0MU3HAhkgX1BrrOr6SAkCWXc0U+znyRttbZfofbhzoXIlj5OriqjrKGjI4nM1qUuB056KcxCBt3kb+nvclPtomoxI5gcWZSLO+ix6z0swW2euY63aPr7ZeFYTPywFYmCFk+gbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CyGWIRvG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f99f9e0faso9076713e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716460576; x=1717065376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK/A89Z/zNw46yDzJQlKHlc10yICfqRNuD9iOVPjR0A=;
        b=CyGWIRvGQ5dzT95Wq0FmWVRPR3qBNZhuxQ8XG0mMKze5jD4oghx9eMIt6ivKuanImO
         lxn+Vw+gJ99WSGebwquOV3lKmQGzgWjceIjh0dHz8g5fyLIZGxs+OAB0XUPWkQoXh+RE
         WS46RRic9ACZ56uu5EI6bKPzDQHiRLNALjr0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460576; x=1717065376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK/A89Z/zNw46yDzJQlKHlc10yICfqRNuD9iOVPjR0A=;
        b=Jvehse0bme/sO+St8pPl1CiIauLq7W0Qo/nR8/LDf1RLlM7tNFL6zEONuFuqzfqpBp
         hjjxaoJVwV0D7YUVkbitLew9W9Orrsi+8wDVU5z0QmIJhzCxq20/D5J2qMdOEvJp09or
         sW1qaPK0i23Zbkk0NA6XBuRYJJPR8dnaLtr7a+Aettf81OOyllrWDlqToH6a5FsIyxNi
         x7ln0ZsyhbF/9cPjRbGiGIMH0BkQkaByhQ6hycNunuQ+tma219Tq+OIabVtQvJSq/i4Q
         YqUm2A7MUP2m3EsIsxHa0ChKDJ/hE6+E1+8Cc62qVtD1/mYSV9llPLiJC0rNX22KFBz9
         58tg==
X-Forwarded-Encrypted: i=1; AJvYcCXYqnRK3XH1WOQTYDIi/fb1V7EPaGiLB8vnV0BZgQiuUNZ057v2HzHZuuy7QLZ+pDZKfYbYfYlxRrFBor6AaunsnDg1OKJltpZqJoLb
X-Gm-Message-State: AOJu0Yw/yqFjOqq4xl9PoOODMF/7bgH9I1ODt3BE4T1QjCLm9aUX45bB
	R2Q8sZhMWVbDVdxndOs9gymDshMF0jQSnkbsc6iKhl6WdvB4/Vq0meA2iTMh9RjL0p4ZV7mGs7P
	jBrA8ICkwV4Ic1oBllTlLj/p4OSIomxamKyCK
X-Google-Smtp-Source: AGHT+IF1qtqxIdOUuK18yoAkY3al5Dw2mSuMWQ9cFuoHZpQD9cry6r8COqpzTqWYrH9aBrtDFTCbGric5gRQDW1zyIw=
X-Received: by 2002:a05:6512:ac2:b0:51e:f68b:d2a2 with SMTP id
 2adb3069b0e04-526bf546146mr3472177e87.65.1716460575866; Thu, 23 May 2024
 03:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516122102.16379-1-yunfei.dong@mediatek.com>
 <20240516122102.16379-15-yunfei.dong@mediatek.com> <1d4618ac-4316-495d-afdb-5849e4b1e805@collabora.com>
 <537a0969-afdf-4e48-a640-2d8fc665c964@collabora.com>
In-Reply-To: <537a0969-afdf-4e48-a640-2d8fc665c964@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 23 May 2024 18:36:04 +0800
Message-ID: <CAGXv+5Hg-61qQEiPScqEfO6irHnaJHHqcr=MYX=89RzUBRK7oA@mail.gmail.com>
Subject: Re: [PATCH v6,14/24] media: mediatek: vcodec: Add capture format to
 support one plane memory
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>, Jeffrey Kardatzke <jkardatzke@google.com>, 
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

On Thu, May 23, 2024 at 6:14=E2=80=AFPM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> Hi,
>
> I'm having second thoughts, please see inline,
>
> W dniu 22.05.2024 o 14:26, Andrzej Pietrasiewicz pisze:
> > Hi Yunfei,
> >
> > W dniu 16.05.2024 o 14:20, Yunfei Dong pisze:
> >> Define one uncompressed capture format V4L2_PIX_FMT_MS21 in order to
> >> support one plane memory. The buffer size is luma + chroma, luma is
> >> stored at the start and chrome is stored at the end.
> >>
> >> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> >> ---
> >>   Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 8 ++++++=
++
> >>   drivers/media/v4l2-core/v4l2-common.c                     | 2 ++
> >>   drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
> >>   include/uapi/linux/videodev2.h                            | 1 +
> >>   4 files changed, 12 insertions(+)
> >>
> >> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst=
 b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> >> index 886ba7b08d6b..6ec899649d50 100644
> >> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> >> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> >> @@ -295,6 +295,14 @@ please make a proposal on the linux-media mailing=
 list.
> >>         - Compressed format used by Nuvoton NPCM video driver. This fo=
rmat is
> >>           defined in Remote Framebuffer Protocol (RFC 6143, chapter 7.=
7.4 Hextile
> >>           Encoding).
> >> +    * .. _V4L2-PIX-FMT-MS21:
> >> +
> >> +      - ``V4L2_PIX_FMT_MS21``
> >> +      - 'MS21'
> >> +      - This format has one plane, luma and chroma are stored in a co=
ntiguous
> >
> > Maybe s/one/single ?
> >
> >> +        memory. Luma pixel in 16x32 tiles at the start, chroma pixel =
in 16x16
> >
> > maybe the word "pixel" is reduntant here? What else than pixels could t=
ile sizes mean?
> > Any padding between luma and chroma?
> >
> >> +        tiles at the end. The image height must be aligned with 32 an=
d the image
> >> +        width must be aligned with 16.
> >
> > Maybe aligned to?
> >
> >>   .. raw:: latex
> >>       \normalsize
> >> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l=
2-core/v4l2-common.c
> >> index 4165c815faef..5ae54cf48dc7 100644
> >> --- a/drivers/media/v4l2-core/v4l2-common.c
> >> +++ b/drivers/media/v4l2-core/v4l2-common.c
> >> @@ -271,6 +271,8 @@ const struct v4l2_format_info *v4l2_format_info(u3=
2 format)
> >>             .block_w =3D { 16, 8, 0, 0 }, .block_h =3D { 32, 16, 0, 0 =
}},
> >>           { .format =3D V4L2_PIX_FMT_MT2110R, .pixel_enc =3D V4L2_PIXE=
L_ENC_YUV, .mem_planes =3D 2, .comp_planes =3D 2, .bpp =3D { 5, 10, 0, 0 },=
 .bpp_div =3D { 4, 4, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2,
> >>             .block_w =3D { 16, 8, 0, 0 }, .block_h =3D { 32, 16, 0, 0 =
}},
> >> +        { .format =3D V4L2_PIX_FMT_MS21, pixel_enc =3D V4L2_PIXEL_ENC=
_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_=
div =3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2,
> >> +          .block_w =3D { 16, 8, 0, 0 }, .block_h =3D { 32, 16, 0, 0 }=
},
> >>           /* YUV planar formats */
> >>           { .format =3D V4L2_PIX_FMT_NV12,    .pixel_enc =3D V4L2_PIXE=
L_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, =
bpp_div =3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
> >> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2=
-core/v4l2-ioctl.c
> >> index 4c76d17b4629..3a68f2b9e7a4 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >> @@ -1529,6 +1529,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc=
 *fmt)
> >>           case V4L2_PIX_FMT_MT2110T:    descr =3D "Mediatek 10bit Tile=
 Mode"; break;
> >>           case V4L2_PIX_FMT_MT2110R:    descr =3D "Mediatek 10bit Rast=
er Mode"; break;
> >>           case V4L2_PIX_FMT_HEXTILE:    descr =3D "Hextile Compressed =
Format"; break;
> >> +        case V4L2_PIX_FMT_MS21:        descr =3D "MediaTek One Plane =
Format"; break;
> >
> > s/One/Single ?
> >
>
> On the other hand "single" would be [in this case incorrectly] associated=
 with
> single-planar API, which would be totally confusing.
>
> Still, the reality you are trying to model is complex: you use
> MPLANE, yet there's a single plane in case of secure playback.

I don't think that's a problem though. The NV12 format (seen above in
the diff context) has the same attributes: 1 contiguous memory plane
containing two component planes.

And it's perfectly fine for MPLANE drivers to support these formats,
Hantro being one of them that decodes to NV12. If a decoder can decode
into discontiguous buffers, it surely can decode into contiguous ones;
just set the second/third buffer address to the correct offset into
the first buffer based on the format layout.

In retrospect we probably should have named "MM21" as "MM21M" to denote
that it is multi-memory-plane, and this "MS21" would have been "MM21",
having a single contiguous memory plane.

And the MPLANE driver supporting "single memory plane" oddity gets
resolved if the API rework ever gets finished.


Regards,
ChenYu

> Regards,
>
> Andrzej
>
>
> > Regards,
> >
> > Andrzej
> >
> >>           default:
> >>               if (fmt->description[0])
> >>                   return;
> >> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/video=
dev2.h
> >> index 89eb1a3c6555..7aff2f2c8f9c 100644
> >> --- a/include/uapi/linux/videodev2.h
> >> +++ b/include/uapi/linux/videodev2.h
> >> @@ -800,6 +800,7 @@ struct v4l2_pix_format {
> >>   #define V4L2_PIX_FMT_MM21     v4l2_fourcc('M', 'M', '2', '1') /* Med=
iatek 8-bit block mode, two non-contiguous planes */
> >>   #define V4L2_PIX_FMT_MT2110T  v4l2_fourcc('M', 'T', '2', 'T') /* Med=
iatek 10-bit block tile mode */
> >>   #define V4L2_PIX_FMT_MT2110R  v4l2_fourcc('M', 'T', '2', 'R') /* Med=
iatek 10-bit block raster mode */
> >> +#define V4L2_PIX_FMT_MS21     v4l2_fourcc('M', 'S', '2', '1') /* Medi=
aTek 8-bit block mode with one plane */
> >>   #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Int=
el Planar Greyscale 10-bit and Depth 16-bit */
> >>   #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Int=
el 4-bit packed depth confidence information */
> >>   #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTT=
V 8-bit dithered RGB */
> >
>

