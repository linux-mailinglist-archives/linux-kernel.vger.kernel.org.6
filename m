Return-Path: <linux-kernel+bounces-297448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12C95B863
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613871F259DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B81D1CBEA2;
	Thu, 22 Aug 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPnrX6dw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA71CB135
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337000; cv=none; b=fSWjm6Yjsl+sCTQnR4/wAvHOYXmecpqJwTcttMSmFXDryYOTqWWzGieaQKUBDUidJzdYRF0epSSK1qKjzkuzqiNrMudrOZIeRHKSGZr+wlmo19nbvkcykiKUIwxo4NquXGB7MHGWv0NyhPLKF7iukkOE0Qvb4RtubNXdspBBIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337000; c=relaxed/simple;
	bh=EIbyKKjLdJJZGFxhalx33/RF7GG9+9/lkUn6G18mVOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5yACPArDTvfIdRU22ROnUKA1PHlMAIrbbyRmUNtgU9L05PdFLWdvWG0KKUqAewh/v5fcYPi0t958qZH23q3++GMhyxC67rT40bA/QDpg0EL+kUH1++yk9G+zDJSCdKJxH1KlgJdpYY3dG2wxoOUvQChC1I4MaA0vq6HT5sPLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPnrX6dw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0D7C4AF0C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724337000;
	bh=EIbyKKjLdJJZGFxhalx33/RF7GG9+9/lkUn6G18mVOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TPnrX6dw3L+LDovQuv/hS4rw5M/MIjwr32NwoybJluXqQXmtVLUYk9f0nBMvk9zyE
	 rbw2c5+E1noh9ol3NxemjLQ8TZxVkF+TUat5RZJJ6ui3WNh8eMmX4lCkpAW2yx51Xw
	 gCtgsIuxHHVj+BpuhM1YUetZAvtz/M5Aw4cXXByE/1yKkIo1CuzxZXL0vcf0TZ7/+I
	 cLbdNlU2xRvZtv2s4vTv8LyzVB5Y5fdDRTv6QJ6BmuBjNh1vF4zn4YaA+rzjqrTBHW
	 kXCuhNo9D6wcPd3A4WNJiS7njYd74qHBWQZU9wfKeTI4/Dc5XbzexarjD3sp3obdce
	 fzOhLoi8l9YBw==
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd967d8234so575523a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:30:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdbijVms/nx53VT3ehh6nMRC18+mvnYb2acp7MdxpNIujKWjBYvQf54Tl48poua6m1A+3eEW87odba/XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzWG8GIlsvN9w1P5zzkHhZpDmnWNCIgbT1N+x7QlyhrXcK2qsb
	KXsVVEOS9kkkFvsB8ZBfSezIiCARO9RoSh/BlAPhzEHbOlNHCexVFPixFqHo9/OlQyOW5L2cNnu
	ekmSGI2xZtD5aI8DHd8wrQOXM2g==
X-Google-Smtp-Source: AGHT+IFNd1a5Jn4I/J6gdxNiBFWoik4UOxFcPN5z5dO1KYVQfJeBHZU2AH9pzjwMOeJbBICz51dLQG3eoiE91A8UOhs=
X-Received: by 2002:a17:90b:104b:b0:2d3:c976:dd80 with SMTP id
 98e67ed59e1d1-2d5ea2ca713mr6422970a91.39.1724336999689; Thu, 22 Aug 2024
 07:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731201407.1838385-1-robh@kernel.org>
In-Reply-To: <20240731201407.1838385-1-robh@kernel.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 22 Aug 2024 22:30:13 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-DT--eLNMzLd0ftoo6e74yV-cfta0C8nB+5k2hifd3dg@mail.gmail.com>
Message-ID: <CAAOTY_-DT--eLNMzLd0ftoo6e74yV-cfta0C8nB+5k2hifd3dg@mail.gmail.com>
Subject: Re: [PATCH] drm: mediatek: Drop unnecessary check for property presence
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Rob:

Rob Herring (Arm) <robh@kernel.org> =E6=96=BC 2024=E5=B9=B48=E6=9C=881=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> of_property_read_u32() returns -EINVAL if a property is not present, so
> the preceeding check for presence with of_find_property() can be
> dropped. Really, what the errno is shouldn't matter. Either the property
> can be read and used or it can't and is ignored.
>
> This is part of a larger effort to remove callers of of_find_property()
> and similar functions. of_find_property() leaks the DT struct property
> and data pointers which is a problem for dynamically allocated nodes
> which may be freed.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index 634bbba5d43f..07243f372260 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -341,14 +341,11 @@ static int mtk_disp_rdma_probe(struct platform_devi=
ce *pdev)
>                 dev_dbg(dev, "get mediatek,gce-client-reg fail!\n");
>  #endif
>
> -       if (of_find_property(dev->of_node, "mediatek,rdma-fifo-size", &re=
t)) {
> -               ret =3D of_property_read_u32(dev->of_node,
> -                                          "mediatek,rdma-fifo-size",
> -                                          &priv->fifo_size);
> -               if (ret)
> -                       return dev_err_probe(dev, ret,
> -                                            "Failed to get rdma fifo siz=
e\n");
> -       }
> +       ret =3D of_property_read_u32(dev->of_node,
> +                                  "mediatek,rdma-fifo-size",
> +                                  &priv->fifo_size);
> +       if (ret && (ret !=3D -EINVAL))
> +               return dev_err_probe(dev, ret, "Failed to get rdma fifo s=
ize\n");
>
>         /* Disable and clear pending interrupts */
>         writel(0x0, priv->regs + DISP_REG_RDMA_INT_ENABLE);
> --
> 2.43.0
>

