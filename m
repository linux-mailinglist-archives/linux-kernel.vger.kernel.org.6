Return-Path: <linux-kernel+bounces-373642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6789A59B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBA9B22456
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEED194AF3;
	Mon, 21 Oct 2024 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NQcwvuwf"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573472209B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489144; cv=none; b=ErnRGH2Aza2G6ElzjtsLAUSgkZ4XTwP4KrUD9j++qUl0qHpHkaUj2THr/ivZ2xsqERS1w83UPEGwjwvQRTQDtSkqSB0f810fNMx2veW8WvWpdmLK2FaGqZ59pddTAabuqpGeYYLY+eVISegDtANnh/YXTm5WFBo2EoiALeQSgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489144; c=relaxed/simple;
	bh=f5+ggXlq6yLXkoBxQqpQzfX/xnlrafFn3SMvSsi5wwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7Psp45q9vNSZJldUuLQ0cFZM1CXzC//Ydv+1Jcp71K4vNc7a0FGyB8RitZ8THhQlk4UKqJex5qQymOFS8S0yySvxHOlwmxJn8quHa1TZ4cMrlIdZidkCb1iS1Cb0uOJ6T0HI7tzxxLysAcYz6heG2yy0Z1/dFYGy852vNBHtuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NQcwvuwf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f84907caso4425327e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 22:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729489139; x=1730093939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9zNYRiu9uknolFzwLlq15Mi6j/Tjr3sPHN/TktoqH0=;
        b=NQcwvuwfZAz0osgFFVutGJLESXbVvm0N2apy3n2Nk8aqs3OeWsDpVJX4XhI40glqn2
         GC+S0YTTo2zu0/Q92utFU8W26AaCcVEOIwGu5z0i3klVBUm0aTlWNUNoFz2a3Yax+cBw
         xR18pMs+K0BH2K7scTSJKgAzn1hYns4tXbfOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729489139; x=1730093939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9zNYRiu9uknolFzwLlq15Mi6j/Tjr3sPHN/TktoqH0=;
        b=ak43cyTxGT3yqEGRU/BUVasEmaZ52f62ndLvCYBktM21w81pZKst4jiAcDYtw0RlvN
         ztLPqxsol3eUsmNVAl4xRaP7B3Dc1HjKTtI0KK3ENpB6EQuxiMKdGcg9FPTNSWFnSB6W
         etL3L4LT8shYW2NncKuyfK7gh1L8iyu/56iazkIk0o5kqGwaw6OCk0l8zy1N8mF6VuR0
         df2pDduTAFWRVSpzM8qv/FlCp3fQT0rolEOWZzkXktxMBLc93Pw+PSfDK0rwKYPu2ewB
         38aF5DvjXwhUyKYwILABbURpKRE24990dsqTqThbuGnABME39FKnT8tIxr37CSs5uxv+
         cIgA==
X-Forwarded-Encrypted: i=1; AJvYcCXeIvUplMRR40tWkesC2JeWRZogI4qPuRWHn8AeYvxikzTmNOI9VCDlB/irxda0APsreeIsyEolvgp6GtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKRUWfuMiVJd+Nht6x765w5vkfWkFqPO/+QnVHYRwKMio7Tj+
	ASRe14WYC+JIDw+6Wk3IrFLd1V5iDwFSszp4smOaqJ8noEle8fONYl3XZfRvLO1l1A57R14XKQ8
	=
X-Google-Smtp-Source: AGHT+IEz7YSEA/UNTuDO8sU90iVaudoEMOvuXaGAy04Fc+Gpiu2TolFn2hKL46WRGRBvyB9igyFOrQ==
X-Received: by 2002:a05:6512:3b07:b0:539:e4b5:10e5 with SMTP id 2adb3069b0e04-53a1520bd47mr4318798e87.9.1729489139511;
        Sun, 20 Oct 2024 22:38:59 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e5850sm389244e87.37.2024.10.20.22.38.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 22:38:57 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so5360737e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 22:38:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8I/7Rpx1kN9Oo+uCSFJZJ7NSO8bY+UGHjwRCfm/HdIzqrm1yF9BmM7vV4ekL7wa+fSNuNmERx+umMIRc=@vger.kernel.org
X-Received: by 2002:a05:6512:1315:b0:52e:76d5:9504 with SMTP id
 2adb3069b0e04-53a1520bd38mr5443903e87.3.1729489135981; Sun, 20 Oct 2024
 22:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018152127.3958436-1-arnd@kernel.org>
In-Reply-To: <20241018152127.3958436-1-arnd@kernel.org>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Mon, 21 Oct 2024 14:38:42 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXgv1sHy+F1psxiN0wu0ryg5shX_u7orzgLz9+-hU59jA@mail.gmail.com>
Message-ID: <CAPBb6MXgv1sHy+F1psxiN0wu0ryg5shX_u7orzgLz9+-hU59jA@mail.gmail.com>
Subject: Re: [PATCH] media: mtk-vcodec: venc: avoid -Wenum-compare-conditional warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Nathan Chancellor <nathan@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Arnd Bergmann <arnd@arndb.de>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Fei Shao <fshao@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 12:21=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is one of three clang warnings about incompatible enum types
> in a conditional expression:
>
> drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c:597:29=
: error: conditional expression between different enumeration types ('enum =
scp_ipi_id' and 'enum ipi_id') [-Werror,-Wenum-compare-conditional]
>   597 |         inst->vpu_inst.id =3D is_ext ? SCP_IPI_VENC_H264 : IPI_VE=
NC_H264;
>       |                                    ^ ~~~~~~~~~~~~~~~~~   ~~~~~~~~=
~~~~~
>
> The code is correct, so just rework it to avoid the warning.
>
> Fixes: 0dc4b3286125 ("media: mtk-vcodec: venc: support SCP firmware")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Alexandre Courbot <acourbot@google.com>

> ---
>  .../platform/mediatek/vcodec/encoder/venc/venc_h264_if.c    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h26=
4_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> index f8145998fcaf..8522f71fc901 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> @@ -594,7 +594,11 @@ static int h264_enc_init(struct mtk_vcodec_enc_ctx *=
ctx)
>
>         inst->ctx =3D ctx;
>         inst->vpu_inst.ctx =3D ctx;
> -       inst->vpu_inst.id =3D is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
> +       if (is_ext)
> +               inst->vpu_inst.id =3D SCP_IPI_VENC_H264;
> +       else
> +               inst->vpu_inst.id =3D IPI_VENC_H264;
> +
>         inst->hw_base =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_bas=
e, VENC_SYS);
>
>         ret =3D vpu_enc_init(&inst->vpu_inst);
> --
> 2.39.5
>

