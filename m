Return-Path: <linux-kernel+bounces-378143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A5F9ACBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C340F1C21340
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D31BD017;
	Wed, 23 Oct 2024 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+br8yx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFB53368;
	Wed, 23 Oct 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692770; cv=none; b=kJYIOPtrTsxMKYfNc8aJgQevPII4lLITz9kgjm1vP8y+G1TxvhaDGFrb7b0zwthhrbAbD98qJJ7ad8Xpe+NUzsi3mFhYu3b6hlXWPhQ6qL9G0kuGBXX3MHdjT5fzKAWv8YEGDhCvF9ceasGjTynggcMlju/NPGHhIFpB1kkoX8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692770; c=relaxed/simple;
	bh=lT+2VpBy0BT7oY5bPbktSNUFx97M8RvIUrfH+KcF/Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyojYOqKwgc5Ez4LukffuneH6GQy2OYLdRE6BLRnpIz8ZePVmIfKV+Q9dHsM4NWAatxl6lG54gsH3XRkXQ0xAKvZQzzQRZql/JHY1NoDXteXY1Y3DXyxyHLWJTFWmm6Kcqlh2ewmkuUuMxexnnAGgLniAw7IHvBXxQxBnQW2xhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+br8yx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF51C4CEE9;
	Wed, 23 Oct 2024 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729692770;
	bh=lT+2VpBy0BT7oY5bPbktSNUFx97M8RvIUrfH+KcF/Dc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W+br8yx0K06VIfrfvTTPp6H8RvGMv96AxJZySLP4dlcJFUhpirDAHaTFpIcPpoz/A
	 N6QCXxzTD4M+AcJ6ap7fC3t/tpBJY9/E8+TUs6f/aQ8mO3vyHnxuTnyRZBeSEqLC7v
	 C4Oa5C156i+HZJokRBkMJJt24mfC3vO3F05rKjaRqv9MUjPFz1MPgH3M2T16szp2XJ
	 GhibYZl4h9CkJ46uip0M/M5DD1w9HsHBWwm8TnGy9BHdQMRTJx5OmlfCvnKkdo8UET
	 jHEf+ItWv3xYMXwUYmIgW34LPDtXlrCeKIY8d6+WpoV8SvGQqyFeDBZybAhztAPfPV
	 uL0NgWplSc4bg==
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ed67cfc1fcso1077399a12.1;
        Wed, 23 Oct 2024 07:12:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjN+jLc03Uk8MHljoz+equ/nLHbytRoBZLz2yJ8tt78w+K2iN7MgUERe2ycUf8ayjXg29QOIc24B1I8dYY1gc=@vger.kernel.org, AJvYcCV3CGqTyl3h837wQgRqytYBgqP6lOReSGjCGTqroAfiIbHfibmDRuafXutjNs/Y22Nr6D67WXHE9+8YZ2FW@vger.kernel.org
X-Gm-Message-State: AOJu0YyM689f8W+TwNAHRjnPxZGaCGVzgLnbCvsg3gqKpogtck0x0F2G
	AHTBKOQceCg7oFaO6yQ/x7oYryQlkWdyvgokdFFjpU/bZZuMq1NyIdKL2fs4WA0uJkUWAQrsC4a
	8OtxITEhiBJvCOSvAkKHpNZRVjw==
X-Google-Smtp-Source: AGHT+IFlsad2/fwPdFPf6XhOvIClD0wIrRQ18NzI0oBgziJzaXBbTh6qI7+JGmlilOHZTPE+QeviZQ7b6sPyVX5hBBk=
X-Received: by 2002:a05:6a21:3a41:b0:1d8:a247:945d with SMTP id
 adf61e73a8af0-1d978bef8bdmr2663185637.50.1729692769613; Wed, 23 Oct 2024
 07:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc537bd6-837f-4c85-a37b-1a007e268310@stanley.mountain>
In-Reply-To: <cc537bd6-837f-4c85-a37b-1a007e268310@stanley.mountain>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Wed, 23 Oct 2024 22:13:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8kG67ns8OokhzujmH7UNM-O+4Aa=GruO_spLOALMeARA@mail.gmail.com>
Message-ID: <CAAOTY_8kG67ns8OokhzujmH7UNM-O+4Aa=GruO_spLOALMeARA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Fix potential NULL dereference in mtk_crtc_destroy()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, 
	=?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Dan:

Dan Carpenter <dan.carpenter@linaro.org> =E6=96=BC 2024=E5=B9=B49=E6=9C=881=
2=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:45=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> In mtk_crtc_create(), if the call to mbox_request_channel() fails then we
> set the "mtk_crtc->cmdq_client.chan" pointer to NULL.  In that situation,
> we do not call cmdq_pkt_create().
>
> During the cleanup, we need to check if the "mtk_crtc->cmdq_client.chan"
> is NULL first before calling cmdq_pkt_destroy().  Calling
> cmdq_pkt_destroy() is unnecessary if we didn't call cmdq_pkt_create() and
> it will result in a NULL pointer dereference.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 7627122fd1c0 ("drm/mediatek: Add cmdq_handle in mtk_crtc")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_crtc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 175b00e5a253..c15013792583 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -127,9 +127,8 @@ static void mtk_crtc_destroy(struct drm_crtc *crtc)
>
>         mtk_mutex_put(mtk_crtc->mutex);
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> -       cmdq_pkt_destroy(&mtk_crtc->cmdq_client, &mtk_crtc->cmdq_handle);
> -
>         if (mtk_crtc->cmdq_client.chan) {
> +               cmdq_pkt_destroy(&mtk_crtc->cmdq_client, &mtk_crtc->cmdq_=
handle);
>                 mbox_free_channel(mtk_crtc->cmdq_client.chan);
>                 mtk_crtc->cmdq_client.chan =3D NULL;
>         }
> --
> 2.45.2
>

