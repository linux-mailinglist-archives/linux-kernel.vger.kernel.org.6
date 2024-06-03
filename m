Return-Path: <linux-kernel+bounces-198740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1A8D7CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E961F21B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437824EB23;
	Mon,  3 Jun 2024 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqyWSe/u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B253392
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401073; cv=none; b=Rh7me52R305dJt6252GvSoPd5PrHD5THZpfUf9D/otPPvb+iIujgQPO+e0dOYTcNOMwNp4KvTAX3Jvq0BGnnT3Ozv7+ahGrcB1pisKfnqrDVcL+Ht7BZ5i+OlXk1TalYPKzEv+W62ytmTnXLV/8fSV5MYpOvdq0WMPoOruWvhpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401073; c=relaxed/simple;
	bh=Z/bg+hsFpACb8uCk9soFpoUYhhPIJVbB/SYQqJ4d7gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFFp340YPkeu5UFBx0IT45nIFPg8kK4nhjVjl+kGOqlB5CB6wfzsID+TmqIpq6rSehsckXoY81W8t6iwe2uzMLSab6/C/A7xwH16Ufv62WipsvmKWgJpfN8e7X/SCAuVYEKkDOSMCE5AJwluPO0BtvZKUlVpBchpSIAsvk8PAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqyWSe/u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717401070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZM/qlijRGY09CL6SCWZrPLW5sIErx5xRvS0RDt3tq4s=;
	b=IqyWSe/uB3eVRwMTx1VilCvcj24unnaMgZwZHSXvptMeKJqxSHypTNSL2mU/YpMqDNPXrL
	fQd5PR9foRIpWv8U5xKz77mpKasJf2AauC4iEycvwNzUk+iSYEgneQ2WPcyarROMdAJbbi
	1/5mqsuhEFEXtdXEYvoa6jdVcLOmhvk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-emK9DCYCMFK5Vfr0pDqikw-1; Mon, 03 Jun 2024 03:51:08 -0400
X-MC-Unique: emK9DCYCMFK5Vfr0pDqikw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-579c4749f51so123789a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 00:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717401067; x=1718005867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM/qlijRGY09CL6SCWZrPLW5sIErx5xRvS0RDt3tq4s=;
        b=DuGIY7cYyjrQRtriPcrH0Qu5Yoa6Q+f63nLOBmRkejYsRfL7PoRSYjs3z9mj5Z4xo0
         aa2QWUwyXn4+sQMlW6SJjRUWyprTdZYhmHl8265wl2k6A03bjY1ZfCU1W/wvfIaIxojP
         BaNJxhSCyHzf8GNy/6NDClmueLV4nSBURvLg/6QqVUQwXfVcBZFyigeUFHVUBNHxrLdU
         zNy1y2gSW1LH+kj+gMm4q26PB5coIBtfZeEqOBJ5peP2XOA0taWdjA3zHH5nvi2+L14x
         cW7Gd7fj+2UU2mfMxeqecM5r1Ju632AHuQsvBGxYle+tsmwxgXJHdcH6XTx5HGqKQYmA
         +EWA==
X-Forwarded-Encrypted: i=1; AJvYcCWxmKc5ESxufm1CIyofmr3Hb+uvBFXCvTkC9BmsqzvPR6IzmfBcROn2MMffZYwfDNDZ85ZLmXPl8x2blLXT2ngxqrDj2TnQ5Gzk3xS3
X-Gm-Message-State: AOJu0Yy+9hn8J5Lzr6Zcx2zBcwZPYIf2jjtfqGDGFEDNvhn6ZP/1jrXT
	hsOqDoj4aczrJwCvGJ4FyWfhfrqawv8HyrHbQXIk9tHrn1lbxXPqQxmT/Rdnd9kLGFLkxkLqpQI
	BYIPkxRuOGAtlLuASORy+5hXG6agcWzstR3rlKVcfqYcCO7Typp8eytUiQhxbZfnQuTplvEFrYY
	HmdL2MS1xIi98AEXbbVPuh8QzQAFuviH+6EeOe
X-Received: by 2002:a50:8e59:0:b0:57a:22aa:51b1 with SMTP id 4fb4d7f45d1cf-57a3644a33dmr5150142a12.2.1717401067126;
        Mon, 03 Jun 2024 00:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZwivxrSkC/S9Da55sUj850dmd7xFFbsWspH20JfHFqw8jW0FbWF7DUPXO/ifDroooMLXoN/Rm9331EW5vTKk=
X-Received: by 2002:a50:8e59:0:b0:57a:22aa:51b1 with SMTP id
 4fb4d7f45d1cf-57a3644a33dmr5150127a12.2.1717401066459; Mon, 03 Jun 2024
 00:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601212247.54786-1-egyszeregy@freemail.hu>
 <CACO55tvW7zDRt=ka0w5D8drbJiZFqMFmx=n=PttAjubZJ5zX2Q@mail.gmail.com> <bec5f516-211d-4c6e-9204-311d1e31532a@freemail.hu>
In-Reply-To: <bec5f516-211d-4c6e-9204-311d1e31532a@freemail.hu>
From: Karol Herbst <kherbst@redhat.com>
Date: Mon, 3 Jun 2024 09:50:29 +0200
Message-ID: <CACO55tuOQxQ=BuDj34SXGREE4numtRDFzJY4Qj_Fr0rrLj4ang@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/i2c: rename aux.c and aux.h to nvkm_i2c_aux.c
 and nvkm_i2c_aux.h
To: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
Cc: bskeggs@redhat.com, lyude@redhat.com, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 1:01=E2=80=AFAM Sz=C5=91ke Benjamin <egyszeregy@free=
mail.hu> wrote:
>
>         s=3D20181004; d=3Dfreemail.hu;
>         h=3DMessage-ID:Date:MIME-Version:Subject:To:Cc:References:From:In=
-Reply-To:Content-Type:Content-Transfer-Encoding;
>         l=3D8472; bh=3Diw0a2TUtlt0KIetu+spJR9WLW1F3MPSfBbxxiBBkhDM=3D;
>         b=3D1oSo+wfGjIoAfhgzfBaxNDoTN0TmXW/jadL52HL5ZAyzWMk15XqSBLjBkAd//=
Bh9
>         u1d+ypo+idz4sTys/CYP5oS8lb8fepRTYBFboPsOAnbHQg6tR0QizBnjyYGq1iMYD=
02
>         GmZWamFVQ/I9kT0XMOMhoKNp1jmr3tFr0iaoS+PqyGv5aNFi6tmiFSJT5fnNaf8/B=
ct
>         XgidaouR1QSqrB6vgHDUjd13+165V+RoCh/CflqZroE132r01M9mxZU5bk4M4uMO3=
8l
>         HwZjS8YTSOmTA49PcLYbh+hr+e+GVFHP+X1wgmd/93wqlySRgqM7N1fh84jucg03I=
MS
>         D/tvbePTzg=3D=3D
> Content-Transfer-Encoding: quoted-printable
>
> 2024. 06. 02. 0:12 keltez=3DC3=3DA9ssel, Karol Herbst =3DC3=3DADrta:
> > On Sat, Jun 1, 2024 at 11:33=3DE2=3D80=3DAFPM <egyszeregy@freemail.hu> =
wrote:
> >>
> >>          s=3D3D20181004; d=3D3Dfreemail.hu;
> >>          h=3D3DFrom:To:Cc:Subject:Date:Message-ID:MIME-Version:Content=
-T=3D
> ype:Content-Transfer-Encoding;
> >>          l=3D3D6462; bh=3D3DCnHSqkRX34kqCWN2/oPtvm9wm8HJCe8QhPwQypdpi3=
w=3D3D=3D
> ;
> >>          b=3D3DJDlDB9yOQDBY7EDnRMrt8qYnWfH8J/LKYKb90434FH1tuOL04za+3TX=
XS=3D
> bU0uvs0
> >>          hWYDYjpbob4XGgUcd1s+lCkerOgDwkpWJWKFW8N5j6WENAKdR/hWJgcma2JED=
=3D
> DotXZ0
> >>          cisYRrLsQBfjyKkBWw0qv/5PDe7vliytix5oP2piBPJC+uR3pN8OKck/+zLBG=
=3D
> lJY4za
> >>          qywwOiMNzHAdyOJT5kCg0yd+k186Oa1jX93iCpiRk5mxJQqJJcAxfW8rYbKRX=
=3D
> i5QQTl
> >>          SymDGdZ72wK5PkHxGgpZ9qXZtFV3eH4+95xNzpoPowMkXFkBy1uMClZzxv1oB=
=3D
> mRo8o6
> >>          CXPcfsWUsQ=3D3D=3D3D
> >> Content-Transfer-Encoding: quoted-printable
> >>
> >> From: Benjamin Sz=3D3DC5=3D3D91ke <egyszeregy@freemail.hu>
> >>
> >> The goal is to clean-up Linux repository from AUX file names, because
> >> the use of such file names is prohibited on other operating systems
> >> such as Windows, so the Linux repository cannot be cloned and
> >> edited on them.
> >>
> >=3D20
> > something went horribly wrong with encoding so the patch is pretty much=
=3D
>  invalid.
> >=3D20
> >> Signed-off-by: Benjamin Sz=3D3DC5=3D3D91ke <egyszeregy@freemail.hu>
> >> ---
> >>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild                  | 2 =
=3D
> +-
> >>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c               | 2 =
=3D
> +-
> >>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c                | 2 =
=3D
> +-
> >>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c              | 2 =
=3D
> +-
> >>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c              | 2 =
=3D
> +-
> >>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c                  | 2 =
=3D
> +-
> >>   .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c =3D3D3D> nvkm_i2c_aux.c} =
  =3D
> | 2 +-
> >>   .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h =3D3D3D> nvkm_i2c_aux.h} =
  =3D
> | 0
> >>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c                | 2 =
=3D
> +-
> >>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c              | 2 =
=3D
> +-
> >>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c              | 2 =
=3D
> +-
> >>   11 files changed, 10 insertions(+), 10 deletions(-)
> >>   rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c =3D3D3D> nvkm_=
i2=3D
> c_aux.=3D3D
> >> c} (99%)
> >>   rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h =3D3D3D> nvkm_=
i2=3D
> c_aux.=3D3D
> >> h} (100%)
> >>
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild b/drivers/=
=3D
> gpu=3D3D
> >> /drm/nouveau/nvkm/subdev/i2c/Kbuild
> >> index 819703913a00..c488dfce4392 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
> >> @@ -25,7 +25,7 @@ nvkm-y +=3D3D3D nvkm/subdev/i2c/busnv50.o
> >>   nvkm-y +=3D3D3D nvkm/subdev/i2c/busgf119.o
> >>   nvkm-y +=3D3D3D nvkm/subdev/i2c/bit.o
> >> =3D3D20
> >> -nvkm-y +=3D3D3D nvkm/subdev/i2c/aux.o
> >> +nvkm-y +=3D3D3D nvkm/subdev/i2c/nvkm_i2c_aux.o
> >>   nvkm-y +=3D3D3D nvkm/subdev/i2c/auxg94.o
> >>   nvkm-y +=3D3D3D nvkm/subdev/i2c/auxgf119.o
> >>   nvkm-y +=3D3D3D nvkm/subdev/i2c/auxgm200.o
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c b/drive=
=3D
> rs/=3D3D
> >> gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
> >> index dd391809fef7..30bf84e77db9 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
> >> @@ -24,7 +24,7 @@
> >>   #define anx9805_pad(p) container_of((p), struct anx9805_pad, base)
> >>   #define anx9805_bus(p) container_of((p), struct anx9805_bus, base)
> >>   #define anx9805_aux(p) container_of((p), struct anx9805_aux, base)
> >> -#include "aux.h"
> >> +#include "nvkm_i2c_aux.h"
> >>   #include "bus.h"
> >> =3D3D20
> >>   struct anx9805_pad {
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c b/driver=
=3D
> s/g=3D3D
> >> pu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
> >> index 47068f6f9c55..9e07ba444ca8 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
> >> @@ -22,7 +22,7 @@
> >>    * Authors: Ben Skeggs <bskeggs@redhat.com>
> >>    */
> >>   #define g94_i2c_aux(p) container_of((p), struct g94_i2c_aux, base)
> >> -#include "aux.h"
> >> +#include "nvkm_i2c_aux.h"
> >> =3D3D20
> >>   struct g94_i2c_aux {
> >>          struct nvkm_i2c_aux base;
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c b/driv=
=3D
> ers=3D3D
> >> /gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
> >> index dab40cd8fe3a..8709b728c38b 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
> >> @@ -19,7 +19,7 @@
> >>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE US=
=3D
> E OR
> >>    * OTHER DEALINGS IN THE SOFTWARE.
> >>    */
> >> -#include "aux.h"
> >> +#include "nvkm_i2c_aux.h"
> >> =3D3D20
> >>   static const struct nvkm_i2c_aux_func
> >>   gf119_i2c_aux =3D3D3D {
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c b/driv=
=3D
> ers=3D3D
> >> /gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
> >> index 8bd1d442e465..f40c5709d217 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
> >> @@ -22,7 +22,7 @@
> >>    * Authors: Ben Skeggs <bskeggs@redhat.com>
> >>    */
> >>   #define gm200_i2c_aux(p) container_of((p), struct gm200_i2c_aux, bas=
=3D
> e)
> >> -#include "aux.h"
> >> +#include "nvkm_i2c_aux.h"
> >> =3D3D20
> >>   struct gm200_i2c_aux {
> >>          struct nvkm_i2c_aux base;
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c b/drivers/=
=3D
> gpu=3D3D
> >> /drm/nouveau/nvkm/subdev/i2c/base.c
> >> index 976539de4220..736275f0c774 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> >> @@ -22,7 +22,7 @@
> >>    * Authors: Ben Skeggs
> >>    */
> >>   #include "priv.h"
> >> -#include "aux.h"
> >> +#include "nvkm_i2c_aux.h"
> >>   #include "bus.h"
> >>   #include "pad.h"
> >> =3D3D20
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c b/drivers/g=
=3D
> pu/=3D3D
> >> drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
> >> similarity index 99%
> >> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> >> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
> >> index d063d0dc13c5..6b76df02c63a 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
> >> @@ -24,7 +24,7 @@
> >> =3D3D20
> >>   #include <linux/string_helpers.h>
> >> =3D3D20
> >> -#include "aux.h"
> >> +#include "nvkm_i2c_aux.h"
> >>   #include "pad.h"
> >> =3D3D20
> >>   static int
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h b/drivers/g=
=3D
> pu/=3D3D
> >> drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
> >> similarity index 100%
> >> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h
> >> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c b/driver=
=3D
> s/g=3D3D
> >> pu/drm/nouveau/nvkm/subdev/i2c/padg94.c
> >> index 5904bc5f2d2a..e9c55a57c878 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
> >> @@ -22,7 +22,7 @@
> >>    * Authors: Ben Skeggs
> >>    */
> >>   #include "pad.h"
> >> -#include "aux.h"
> >> +#include "nvkm_i2c_aux.h"
> >>   #include "bus.h"
> >> =3D3D20
> >>   void
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c b/driv=
=3D
> ers=3D3D
> >> /gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
> >> index 3bc4d0310076..1af64e25d838 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
> >> @@ -22,7 +22,7 @@
> >>    * Authors: Ben Skeggs
> >>    */
> >>   #include "pad.h"
> >> -#include "aux.h"
> >> +#include "nvkm_i2c_aux.h"
> >>   #include "bus.h"
> >> =3D3D20
> >>   static const struct nvkm_i2c_pad_func
> >> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c b/driv=
=3D
> ers=3D3D
> >> /gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
> >> index 7d417f6a816e..997a5a2146c4 100644
> >> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
> >> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
> >> @@ -22,7 +22,7 @@
> >>    * Authors: Ben Skeggs
> >>    */
> >>   #include "pad.h"
> >> -#include "aux.h"
> >> +#include "nvkm_i2c_aux.h"
> >>   #include "bus.h"
> >> =3D3D20
> >>   static void
> >> --=3D3D20
> >> 2.43.0
> >>
> >=3D20
>
> Hi,
>
> This patched is totally fine and visible in "linux-kernel@vger.kernel.org=
=3D
> " list=3D20
> page, so it should not be invalid. Please check your e-mail client SW and=
=3D
>  fix=3D20
> your settings.
>
> https://lore.kernel.org/lkml/20240601212247.54786-1-egyszeregy@freemail.h=
=3D
> u/
> https://lore.kernel.org/lkml/20240601212247.54786-1-egyszeregy@freemail.h=
=3D
> u/raw
>
> kernel test robot used it for a build test successfully, so it has to be =
=3D
> a valid=3D20
> patch.
> https://github.com/intel-lab-lkp/linux/commits/egyszeregy-freemail-hu/drm=
=3D
> -nouveau-i2c-rename-aux-c-and-aux-h-to-nvkm_i2c_aux-c-and-nvkm_i2c_aux-h/=
=3D
> 20240602-053530
>

oh indeed. Looks like a client problem then. Sorry for the noise.


