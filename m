Return-Path: <linux-kernel+bounces-198016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2608D726D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB41B21627
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9F20B34;
	Sat,  1 Jun 2024 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCdFoECG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B64AD2D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717279973; cv=none; b=iv49KzOmPH6xP+W2iIoPMS++RjVXq16fEG/u2ZJzTYH4yS/PDst9SXK5lVE+uKcXeyAgcuXNp1lF0xIdKQqo+GM6dSfKvK5zIWHuVynExacBJGrbcVAuUZrtHu+/fvYbvGTj6mGE/w6jyfk2hjFL+2gXW/NZcBajmCpzZG/zqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717279973; c=relaxed/simple;
	bh=1wR8RrRZlZEERo7udA+rIdlXKkbOruBcc3/i8oOD2tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0tQhGshjiEjEB6LYKSeiMb/j46RgOlPjVHbrfDvHXTsPzozvP+0uPk6zVWZcua88W0Z/KRuw2HbmOeAp7adLkcUgJYT/K1Vo9sQoIrqAE2+2w6DfVLGCGlx+Amc50nfOAKq4DLnLYLH2w7c0Qt1TkYWWMVPt3Smz14FgDwgCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCdFoECG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717279970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZawYK/bgvUDs2pKjbY825P/MW2zIRhJxGAwLGim8/Q=;
	b=BCdFoECGxOmnnb8FblP3T1ZSpfEM8oacTgW992/IulmmQMQkrw4DfnwMuLRGZTCI+cljZZ
	Z3/Y5hzvcaptdmiZpdd4byCXzifESDR9avRA6IdrNoZhgXztG0Z/wnJqVCZHqMugu9jk4u
	jD87d8cMp3cyfhghfViWBjpblkRmSwA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-9bhMK7NwP1W15D8qc-IgZg-1; Sat, 01 Jun 2024 18:12:49 -0400
X-MC-Unique: 9bhMK7NwP1W15D8qc-IgZg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ea940c4061so1637281fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 15:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717279967; x=1717884767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZawYK/bgvUDs2pKjbY825P/MW2zIRhJxGAwLGim8/Q=;
        b=pk8haszDfF7L1ER7+QfHNy9kSuqS6X6OdEsmxMZjGIufNf0Bn4XyB2FL/UItf8nNLg
         Qr3GbuvHE4eXd8mnvOoaIlSTQrJwYRews8of6JNG0obENoNfzxDupVr49tyDcEk97M3S
         pL38jxnlyzQN3RWkPWEoxhYRFB+dQ8EM80kHuq3mGkURcEYTFMb/QqHJsLDvv7518rEk
         +KZktBFaZ7Cbj03kDtz22mD0EpFpj/OU0JUXj39K1TRwuC7QH8//nDD2FZVzp+fLAMkH
         X73Z7AqvX6BMlB+ifCMGEQxpIBQSE3FwyxXlf+gXnzJkvJ9bo3/k1AsmSpzGhEqnTk0t
         jWuw==
X-Forwarded-Encrypted: i=1; AJvYcCVDI0LWkuNIUtW3ULLU2a9pzXKHafib3A0R4qaNFC+KOeMtr68MVxJKp7U5RLYXCiAtJjh/ea/nYAY60FoWYSNO/bpI51tCV4pN4EYf
X-Gm-Message-State: AOJu0YzMpr14OI5/MECPPE5QeIZn2xxkb0d4DkUEOVbVKxBLk2G15DpB
	rFJqjruhOcXe44Aa6EevpOZ2ps2mu7LGjznR9rdUnrtJDZFNPoPq9UuuVTiykWTS7ho2dzKy8pS
	mUPT9scWRBkJg6V+j80yq0TXgb1A8LZC52/eq3Ip9jdnOzyRyuSwQcqvLA8qQrlg/z8c/bGS3wB
	PFlGo9r3o0aNkWCehVjJ4fLthS8gok+dUejJKWJmfwpbwo
X-Received: by 2002:a2e:be0f:0:b0:2ea:806a:d701 with SMTP id 38308e7fff4ca-2ea95242b93mr33945671fa.3.1717279966691;
        Sat, 01 Jun 2024 15:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7KANX0x1+6xtQJgaisRd+fArXl1JaxG/bhUBu0TyGkGkZpTl+uXGgIOCXtlE/G7v9UTg0ukY7YvXfUzmjBYo=
X-Received: by 2002:a2e:be0f:0:b0:2ea:806a:d701 with SMTP id
 38308e7fff4ca-2ea95242b93mr33945481fa.3.1717279965930; Sat, 01 Jun 2024
 15:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601212247.54786-1-egyszeregy@freemail.hu>
In-Reply-To: <20240601212247.54786-1-egyszeregy@freemail.hu>
From: Karol Herbst <kherbst@redhat.com>
Date: Sun, 2 Jun 2024 00:12:09 +0200
Message-ID: <CACO55tvW7zDRt=ka0w5D8drbJiZFqMFmx=n=PttAjubZJ5zX2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/i2c: rename aux.c and aux.h to nvkm_i2c_aux.c
 and nvkm_i2c_aux.h
To: egyszeregy@freemail.hu
Cc: bskeggs@redhat.com, lyude@redhat.com, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 11:33=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
>         s=3D20181004; d=3Dfreemail.hu;
>         h=3DFrom:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:=
Content-Transfer-Encoding;
>         l=3D6462; bh=3DCnHSqkRX34kqCWN2/oPtvm9wm8HJCe8QhPwQypdpi3w=3D;
>         b=3DJDlDB9yOQDBY7EDnRMrt8qYnWfH8J/LKYKb90434FH1tuOL04za+3TXXSbU0u=
vs0
>         hWYDYjpbob4XGgUcd1s+lCkerOgDwkpWJWKFW8N5j6WENAKdR/hWJgcma2JEDDotX=
Z0
>         cisYRrLsQBfjyKkBWw0qv/5PDe7vliytix5oP2piBPJC+uR3pN8OKck/+zLBGlJY4=
za
>         qywwOiMNzHAdyOJT5kCg0yd+k186Oa1jX93iCpiRk5mxJQqJJcAxfW8rYbKRXi5QQ=
Tl
>         SymDGdZ72wK5PkHxGgpZ9qXZtFV3eH4+95xNzpoPowMkXFkBy1uMClZzxv1oBmRo8=
o6
>         CXPcfsWUsQ=3D=3D
> Content-Transfer-Encoding: quoted-printable
>
> From: Benjamin Sz=3DC5=3D91ke <egyszeregy@freemail.hu>
>
> The goal is to clean-up Linux repository from AUX file names, because
> the use of such file names is prohibited on other operating systems
> such as Windows, so the Linux repository cannot be cloned and
> edited on them.
>

something went horribly wrong with encoding so the patch is pretty much inv=
alid.

> Signed-off-by: Benjamin Sz=3DC5=3D91ke <egyszeregy@freemail.hu>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild                  | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c               | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c                | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c              | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c              | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c                  | 2 +-
>  .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c =3D3D> nvkm_i2c_aux.c}   | 2 =
+-
>  .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h =3D3D> nvkm_i2c_aux.h}   | 0
>  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c                | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c              | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c              | 2 +-
>  11 files changed, 10 insertions(+), 10 deletions(-)
>  rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c =3D3D> nvkm_i2c_au=
x.=3D
> c} (99%)
>  rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h =3D3D> nvkm_i2c_au=
x.=3D
> h} (100%)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild b/drivers/gpu=
=3D
> /drm/nouveau/nvkm/subdev/i2c/Kbuild
> index 819703913a00..c488dfce4392 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
> @@ -25,7 +25,7 @@ nvkm-y +=3D3D nvkm/subdev/i2c/busnv50.o
>  nvkm-y +=3D3D nvkm/subdev/i2c/busgf119.o
>  nvkm-y +=3D3D nvkm/subdev/i2c/bit.o
> =3D20
> -nvkm-y +=3D3D nvkm/subdev/i2c/aux.o
> +nvkm-y +=3D3D nvkm/subdev/i2c/nvkm_i2c_aux.o
>  nvkm-y +=3D3D nvkm/subdev/i2c/auxg94.o
>  nvkm-y +=3D3D nvkm/subdev/i2c/auxgf119.o
>  nvkm-y +=3D3D nvkm/subdev/i2c/auxgm200.o
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c b/drivers/=
=3D
> gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
> index dd391809fef7..30bf84e77db9 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
> @@ -24,7 +24,7 @@
>  #define anx9805_pad(p) container_of((p), struct anx9805_pad, base)
>  #define anx9805_bus(p) container_of((p), struct anx9805_bus, base)
>  #define anx9805_aux(p) container_of((p), struct anx9805_aux, base)
> -#include "aux.h"
> +#include "nvkm_i2c_aux.h"
>  #include "bus.h"
> =3D20
>  struct anx9805_pad {
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c b/drivers/g=
=3D
> pu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
> index 47068f6f9c55..9e07ba444ca8 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
> @@ -22,7 +22,7 @@
>   * Authors: Ben Skeggs <bskeggs@redhat.com>
>   */
>  #define g94_i2c_aux(p) container_of((p), struct g94_i2c_aux, base)
> -#include "aux.h"
> +#include "nvkm_i2c_aux.h"
> =3D20
>  struct g94_i2c_aux {
>         struct nvkm_i2c_aux base;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c b/drivers=
=3D
> /gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
> index dab40cd8fe3a..8709b728c38b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
> @@ -19,7 +19,7 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -#include "aux.h"
> +#include "nvkm_i2c_aux.h"
> =3D20
>  static const struct nvkm_i2c_aux_func
>  gf119_i2c_aux =3D3D {
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c b/drivers=
=3D
> /gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
> index 8bd1d442e465..f40c5709d217 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
> @@ -22,7 +22,7 @@
>   * Authors: Ben Skeggs <bskeggs@redhat.com>
>   */
>  #define gm200_i2c_aux(p) container_of((p), struct gm200_i2c_aux, base)
> -#include "aux.h"
> +#include "nvkm_i2c_aux.h"
> =3D20
>  struct gm200_i2c_aux {
>         struct nvkm_i2c_aux base;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c b/drivers/gpu=
=3D
> /drm/nouveau/nvkm/subdev/i2c/base.c
> index 976539de4220..736275f0c774 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> @@ -22,7 +22,7 @@
>   * Authors: Ben Skeggs
>   */
>  #include "priv.h"
> -#include "aux.h"
> +#include "nvkm_i2c_aux.h"
>  #include "bus.h"
>  #include "pad.h"
> =3D20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c b/drivers/gpu/=
=3D
> drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
> similarity index 99%
> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
> index d063d0dc13c5..6b76df02c63a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
> @@ -24,7 +24,7 @@
> =3D20
>  #include <linux/string_helpers.h>
> =3D20
> -#include "aux.h"
> +#include "nvkm_i2c_aux.h"
>  #include "pad.h"
> =3D20
>  static int
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h b/drivers/gpu/=
=3D
> drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
> similarity index 100%
> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h
> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c b/drivers/g=
=3D
> pu/drm/nouveau/nvkm/subdev/i2c/padg94.c
> index 5904bc5f2d2a..e9c55a57c878 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
> @@ -22,7 +22,7 @@
>   * Authors: Ben Skeggs
>   */
>  #include "pad.h"
> -#include "aux.h"
> +#include "nvkm_i2c_aux.h"
>  #include "bus.h"
> =3D20
>  void
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c b/drivers=
=3D
> /gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
> index 3bc4d0310076..1af64e25d838 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
> @@ -22,7 +22,7 @@
>   * Authors: Ben Skeggs
>   */
>  #include "pad.h"
> -#include "aux.h"
> +#include "nvkm_i2c_aux.h"
>  #include "bus.h"
> =3D20
>  static const struct nvkm_i2c_pad_func
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c b/drivers=
=3D
> /gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
> index 7d417f6a816e..997a5a2146c4 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
> @@ -22,7 +22,7 @@
>   * Authors: Ben Skeggs
>   */
>  #include "pad.h"
> -#include "aux.h"
> +#include "nvkm_i2c_aux.h"
>  #include "bus.h"
> =3D20
>  static void
> --=3D20
> 2.43.0
>


