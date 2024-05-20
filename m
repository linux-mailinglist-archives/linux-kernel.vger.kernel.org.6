Return-Path: <linux-kernel+bounces-184061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D08CA1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37F51F222B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC871384AE;
	Mon, 20 May 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1P5SsLy"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F26137C48
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716229501; cv=none; b=GgEOMCOOJl4J9ipY2ZUc9A8pSiM4D+QKF251vvCqno7MOvXpMpVLSPiB8hzQTQTtBd0AQcbGU0/m5zqB2LumFK8qDzamBPvtLX5mDAQLHBq3D1YTZkevQjd3RPGVfO5QzPAhGT5IigvjbysLw3iFjQYcIzvJinxHZ856QCyxzVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716229501; c=relaxed/simple;
	bh=dDm79kFjTMDwIZyPH0s80xpUacie3sx5J6V+kXbGlEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmEuPBxrL+wG5Ez2nB5mhnTWc9H3L9RHXO36Uv80f5zZqyXsUJMiBmDPAXpqeavwqW5yQ+OdgtKPWQqOYiDEePbwEaQXYX5BQQHkkp8RKFKHzwj9kQf4VLBP0mZULor3gowSWEE0RXhK2TaEK6xON/mbTT5Fx7PNQYrIrLEPJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1P5SsLy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-351da5838fcso2696655f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716229498; x=1716834298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdzEvfu1PEpJBwHmOIv154V3jtL1pSQeI6RYwYyKYZk=;
        b=O1P5SsLymRYGLPFOcjsjAoXv1AyUYOanpGavuKQdgbB5XRlKjs2LOhw6sOBKDNUpRb
         QMObBMZUpOq6QV5adlV3ByK4g6y5bPzMW5Wp6KgOhgGy3vb/z21CjjCq7H2Na3FrpN6c
         06FLyVsMGjzMchlnY/wa/vfsMyqs9USGCJtyo7ygYImJenbLFDsdYDc11PoGAvErFIxy
         mF4MxRas+83zfZt3uJ1SDgq8GfTYVw5y6RqFzoTfrTAGSUaq5Cw49PHhFXycICb5xuqg
         VM46Xa5cagy6ZYrJlOGvL/9KpcQn3QxzuYsfngiXn2Cb+8VpGR5F0imwFXVaMUWSjxoi
         gGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716229498; x=1716834298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdzEvfu1PEpJBwHmOIv154V3jtL1pSQeI6RYwYyKYZk=;
        b=i++tcxeOzpJzrKOud7tprDa7IB8sxjuMrOpdSK+xrhc0v/CP0PWZr8iO9fT2mgGhmT
         UyI5dRhj4Qpu3nZ+C9Wy0WrKsM+ZehX+P22RJgYkcoNcBwBUH43oNLCEyjRUN4L1uJOG
         c68x6u76ccrFaquba3RaCUCqOvAsk/E0SjmeJ53JzDErOQBoUweuPn9krcPxLXqKQyZJ
         qJRetIZ9EY84c95GuUQd7XryAYQ3twHbwe7KabA0L1Qj5BPcxCu0s/0V0+xEBMxGXwjk
         rpsZn/kbKqRR8w5NODphglODHoV10RIdH+aJS/O7bGYHW8cidnpg0uxaKrsXo1DL+teE
         wVhw==
X-Forwarded-Encrypted: i=1; AJvYcCVUf+BB4/5FyThLJpeJOODaPtEfkGPwbJIolEGz7ktO1fb7Ec3M5tWH8XL2CvQ4Rvy9R7Qjo/z+XMavEQ3wxXHCag9XmhFH5jg96aS3
X-Gm-Message-State: AOJu0Yx/OW1U+psuj4OeOcIfAoxFmcpVQVzuflgX6+loE5DKO9DbM+F4
	UpFKRyIU1l8GC3ZRtGHfRthuEbqleRZ21ZVkW+Sz0S7UrjSzQ2fK//VPojRFdJyyiG2TtpiBTBN
	7wt5J9plNM+XSnjuxunquoq9IvQna/+oU+kRqWPkY6jZ0ijbia1Cs
X-Google-Smtp-Source: AGHT+IHip0D1CwulZkUqzgTRHd4h9KDYjqLHoifTqfHumIM8JPr9kA/cIoKnvUx1OIyjr1GSqMOBTklaXEOXcjT5FEw=
X-Received: by 2002:a05:6000:1a8d:b0:351:b882:4e2b with SMTP id
 ffacd0b85a97d-351b8824ef3mr21104096f8f.63.1716229497450; Mon, 20 May 2024
 11:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520090106.2898681-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240520090106.2898681-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 20 May 2024 11:24:44 -0700
Message-ID: <CAB=BE-Qr5mukXPPqqduH2Rr3cBrkP_WUiJ1udhtfmmrHFmObcQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: avoid allocating DEFLATE streams before mounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 2:06=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Currently, each DEFLATE stream takes one 32 KiB permanent internal
> window buffer even if there is no running instance which uses DEFLATE
> algorithm.
>
> It's unexpected and wasteful on embedded devices with limited resources
> and servers with hundreds of CPU cores if DEFLATE is enabled but unused.
>
> Fixes: ffa09b3bd024 ("erofs: DEFLATE compression support")
> Cc: <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

> ---
>  fs/erofs/decompressor_deflate.c | 55 +++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_defl=
ate.c
> index 81e65c453ef0..3a3461561a3c 100644
> --- a/fs/erofs/decompressor_deflate.c
> +++ b/fs/erofs/decompressor_deflate.c
> @@ -46,39 +46,15 @@ int __init z_erofs_deflate_init(void)
>         /* by default, use # of possible CPUs instead */
>         if (!z_erofs_deflate_nstrms)
>                 z_erofs_deflate_nstrms =3D num_possible_cpus();
> -
> -       for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
> -            ++z_erofs_deflate_avail_strms) {
> -               struct z_erofs_deflate *strm;
> -
> -               strm =3D kzalloc(sizeof(*strm), GFP_KERNEL);
> -               if (!strm)
> -                       goto out_failed;
> -
> -               /* XXX: in-kernel zlib cannot shrink windowbits currently=
 */
> -               strm->z.workspace =3D vmalloc(zlib_inflate_workspacesize(=
));
> -               if (!strm->z.workspace) {
> -                       kfree(strm);
> -                       goto out_failed;
> -               }
> -
> -               spin_lock(&z_erofs_deflate_lock);
> -               strm->next =3D z_erofs_deflate_head;
> -               z_erofs_deflate_head =3D strm;
> -               spin_unlock(&z_erofs_deflate_lock);
> -       }
>         return 0;
> -
> -out_failed:
> -       erofs_err(NULL, "failed to allocate zlib workspace");
> -       z_erofs_deflate_exit();
> -       return -ENOMEM;
>  }
>
>  int z_erofs_load_deflate_config(struct super_block *sb,
>                         struct erofs_super_block *dsb, void *data, int si=
ze)
>  {
>         struct z_erofs_deflate_cfgs *dfl =3D data;
> +       static DEFINE_MUTEX(deflate_resize_mutex);
> +       static bool inited;
>
>         if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
>                 erofs_err(sb, "invalid deflate cfgs, size=3D%u", size);
> @@ -89,9 +65,36 @@ int z_erofs_load_deflate_config(struct super_block *sb=
,
>                 erofs_err(sb, "unsupported windowbits %u", dfl->windowbit=
s);
>                 return -EOPNOTSUPP;
>         }
> +       mutex_lock(&deflate_resize_mutex);
> +       if (!inited) {
> +               for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstr=
ms;
> +                    ++z_erofs_deflate_avail_strms) {
> +                       struct z_erofs_deflate *strm;
> +
> +                       strm =3D kzalloc(sizeof(*strm), GFP_KERNEL);
> +                       if (!strm)
> +                               goto failed;
> +                       /* XXX: in-kernel zlib cannot customize windowbit=
s */
> +                       strm->z.workspace =3D vmalloc(zlib_inflate_worksp=
acesize());
> +                       if (!strm->z.workspace) {
> +                               kfree(strm);
> +                               goto failed;
> +                       }
>
> +                       spin_lock(&z_erofs_deflate_lock);
> +                       strm->next =3D z_erofs_deflate_head;
> +                       z_erofs_deflate_head =3D strm;
> +                       spin_unlock(&z_erofs_deflate_lock);
> +               }
> +               inited =3D true;
> +       }
> +       mutex_unlock(&deflate_resize_mutex);
>         erofs_info(sb, "EXPERIMENTAL DEFLATE feature in use. Use at your =
own risk!");
>         return 0;
> +failed:
> +       mutex_unlock(&deflate_resize_mutex);
> +       z_erofs_deflate_exit();
> +       return -ENOMEM;
>  }
>
>  int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
> --
> 2.39.3
>

