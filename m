Return-Path: <linux-kernel+bounces-541759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1AA4C13F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2C6188F058
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01882116F0;
	Mon,  3 Mar 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDRHU65A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873220D4EA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007094; cv=none; b=QLlMoln3nehPn9qmZVXyB2rHeQbVn2PNJa4oSRZfMPJkQUnriG0DHI66mc3sNpBkPeOCDfjjuk23sh8R3Mcw9/06iFpdQXA031tEQ9kusZmRXq3B+XulMGjxPAxJBYMWdApMNPLYnCWjiE7K8/f5ajrRLo9nZHwYDH6NzfYLAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007094; c=relaxed/simple;
	bh=Kc67sUpClxemt8Xxy2aFwoflyMsGfUhh3kfftx68WzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7U9wGEQplT0RheslENRC4ip0Towe6tDsGrAFPfS/0Dzgi0kG7oiApfyI2ZMQAihLNcIABlpN7nMofH9nT6f9BOCWDQPzkA/A87BB7xH2ZIpQhwxph0dpF0hPgN8gg2xVPdPrjHG1TzW1g/x7j0WMRKPQD78a9/vlBjpK65Rja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDRHU65A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8D5C4CED6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007093;
	bh=Kc67sUpClxemt8Xxy2aFwoflyMsGfUhh3kfftx68WzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YDRHU65A1Zoh3hw1p3HsOJsSkqBvhXSHfah9Wlq5+a88AV942SLRoCzZy0pmV6NXf
	 Qu7+Iac3vuoEI7P/cuKNYGcVIEqg3Rp1KpCKtdDnkDqhwdisDWSRtAeIa468AbqBT2
	 48epWenhmUO9x3U1IjuiI1eJxV5x5CKAWo8hqcux0/VFCdgciN9DY6QMcsZEfsOGB9
	 Wx7NYPSdS/UDjgCcdsw4fwQPDfEbbBRCe7Nr5BZH0o2AbckyTQhxBeIJHSNVHgGFE0
	 k94UiVDiMOmX2TLm5hsXZnk4OsBX5zV21tYr6zL2Mlbx6AdB/GrQsAwMqj3FbxSUgm
	 0/MeS2k4ccSgQ==
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso7353159a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:04:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPAs9FJKy/RUqJJY3x42Xo/Ip3+GmuBD+snG3lpWVts9rncrZo0tkreHU7t9cKh86S8URELI+liFDcCb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMGVF3l1OKinvfZFNGFIr5bd0DynXnhIioQi5QceuTZV8wJTO
	7ENozX0bRFdwIN+ztXIHui9PUOU8MkVK1vvWNKH+HfuojBvzZSUGCmdnCPfHIPr5uY/aUunFkid
	sQAasmVd1gILs0Aab2qgaq8ULUg==
X-Google-Smtp-Source: AGHT+IH02/n0X6E1gCWCCjIwiDiMBCCog908/wSy8glvpxrUWG7zl9UbjAuOmobw7eTHtsiFGSu1wTms11iI4ft0D/Q=
X-Received: by 2002:a17:90a:d408:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-2fea12683b9mr27834691a91.2.1741007093217; Mon, 03 Mar 2025
 05:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116094249.1.I29b0b621abb613ddc70ab4996426a3909e1aa75f@changeid>
In-Reply-To: <20250116094249.1.I29b0b621abb613ddc70ab4996426a3909e1aa75f@changeid>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 3 Mar 2025 21:05:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY__Ka-RD1=XmaAuEjrhkQMQQ7Mg+rgXaNe8ka-VGeRZ4JQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoCI49gG24ADeeYR9aiQBSlqnUG9YwDaVyfJzTrVZzFPkF3TWLMSnf3T2w
Message-ID: <CAAOTY__Ka-RD1=XmaAuEjrhkQMQQ7Mg+rgXaNe8ka-VGeRZ4JQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dp: drm_err => dev_err in HPD path to avoid
 NULL ptr
To: Douglas Anderson <dianders@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Alexandre Mergnat <amergnat@baylibre.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	David Airlie <airlied@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Douglas:

Douglas Anderson <dianders@chromium.org> =E6=96=BC 2025=E5=B9=B41=E6=9C=881=
7=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> The function mtk_dp_wait_hpd_asserted() may be called before the
> `mtk_dp->drm_dev` pointer is assigned in mtk_dp_bridge_attach().
> Specifically it can be called via this callpath:
>  - mtk_edp_wait_hpd_asserted
>  - [panel probe]
>  - dp_aux_ep_probe
>
> Using "drm" level prints anywhere in this callpath causes a NULL
> pointer dereference. Change the error message directly in
> mtk_dp_wait_hpd_asserted() to dev_err() to avoid this. Also change the
> error messages in mtk_dp_parse_capabilities(), which is called by
> mtk_dp_wait_hpd_asserted().
>
> While touching these prints, also add the error code to them to make
> future debugging easier.

Applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: 7eacba9a083b ("drm/mediatek: dp: Add .wait_hpd_asserted() for AUX =
bus")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Unfortunately, I have only been able to compile-time test this code. I
> hit the NULL pointer dereference on a device that's nowhere near
> upstream and it was running (sigh) a heavily modified copy of this
> code where the eDP stuff has been forked out of DP. Specifically, you
> can see <https://crrev.com/c/6073744>. It's pretty easy to understand
> that the same problem affects both codebases though, so I'm posting
> this "blind" in the hopes to at least fix upstream.
>
> I'll also note that the fact that mtk_edp_wait_hpd_asserted() calls
> mtk_dp_parse_capabilities() feels weird/wrong to me based on other eDP
> code I've worked on, but I've only barely looked at the Mediatek
> driver and perhaps others have already debated this. In any case,
> that's not directly related to this patch.
>
>  drivers/gpu/drm/mediatek/mtk_dp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 0687672f0e52..ccd104d8851f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1763,7 +1763,7 @@ static int mtk_dp_parse_capabilities(struct mtk_dp =
*mtk_dp)
>
>         ret =3D drm_dp_dpcd_readb(&mtk_dp->aux, DP_MSTM_CAP, &val);
>         if (ret < 1) {
> -               drm_err(mtk_dp->drm_dev, "Read mstm cap failed\n");
> +               dev_err(mtk_dp->dev, "Read mstm cap failed: %zd\n", ret);
>                 return ret =3D=3D 0 ? -EIO : ret;
>         }
>
> @@ -1773,7 +1773,7 @@ static int mtk_dp_parse_capabilities(struct mtk_dp =
*mtk_dp)
>                                         DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0=
,
>                                         &val);
>                 if (ret < 1) {
> -                       drm_err(mtk_dp->drm_dev, "Read irq vector failed\=
n");
> +                       dev_err(mtk_dp->dev, "Read irq vector failed: %zd=
\n", ret);
>                         return ret =3D=3D 0 ? -EIO : ret;
>                 }
>
> @@ -2056,7 +2056,7 @@ static int mtk_dp_wait_hpd_asserted(struct drm_dp_a=
ux *mtk_aux, unsigned long wa
>
>         ret =3D mtk_dp_parse_capabilities(mtk_dp);
>         if (ret) {
> -               drm_err(mtk_dp->drm_dev, "Can't parse capabilities\n");
> +               dev_err(mtk_dp->dev, "Can't parse capabilities: %d\n", re=
t);
>                 return ret;
>         }
>
> --
> 2.48.0.rc2.279.g1de40edade-goog
>

