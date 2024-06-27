Return-Path: <linux-kernel+bounces-231847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27911919F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585541C21CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803822F11;
	Thu, 27 Jun 2024 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPS1+OOX"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC322EF0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719469212; cv=none; b=W7+9q1shTAFnJTanHtuZa9REQMXBDmBl5+SQjwfITP8NAMwI5Ab8Ib2zjkIwU3+/jwuz1K37koc4TnTE9s8uWdWndN42Ou3oRlpmejqIHOQ7szLnFf+k4PzoRIG1dm9YsGxUB7RmI4JuxEd11pfJhDNsDvq3GQ2NZ+kx3kDuW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719469212; c=relaxed/simple;
	bh=PcmwTmOKwpCX6ndYGJv5JChTSWKlJN3YcYQDh7Q5H0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pARsK6ISpGvKcGHEe3V3gl/SzfbXg0jwrsrgxDEWJaGglrurh7K0ZQZ9f4nwpJVCTIGFGXepi6Vf+/LwTRs9yHtf3812hC7r1kLxmuHUZnyCU0nfqZU5gCIPLwDSXPzgdZcDRIhrd9aRWkihycoZg2ROwFVFwDIE+2NxOgZmoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hPS1+OOX; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c2201ffb1bso815338eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719469210; x=1720074010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WrO/44CBqAi2HP/7O1C/WMYbI858ZG7/zXzzdOIbHc=;
        b=hPS1+OOXKzZTl2NpVCjtfEbbWHyq31UIll0so0exlnEIu3wkwIVG/ILIJCGo1LoxrN
         nzXs/jLcDPyglucfi36K28HstXuwFC1lC4xXkGIp4sFhQSzA4oqlf1rLg4avnyEBse5Q
         Xjl8jpIhvxhDjPKOULIP/o4AdjqwqLCgkf6rHQXl+Im8xvQjWlfWexUK3DqVwBeM64We
         R91qUyF9Z8+RpmC5x/PtDbZpvHs2pymxPHnEtD5dVlcNgynjFm9DbHef95bxrvl3Sxcb
         JMaN3faW1ljEaFT7tRLH8YTmOH0B4te2I5TaaZoI0a8C6EbC+qLj8iV4E5bopJZz/9VG
         /VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719469210; x=1720074010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WrO/44CBqAi2HP/7O1C/WMYbI858ZG7/zXzzdOIbHc=;
        b=lO8E+G1cUhWGTMTbI937GKgeFVa6cAQm2TJUbvSCoCHoJ6Wj/2dcWPo3ln/0UdZWk5
         hpdH9HAFvLiKbeIwMcAgMeWcSpjhV4jQWJuswlhu0Sd7v/f8EyEAd777ZneN/49+TveO
         deRQDc1weFiKIzPkvmSjk5Yld8Xo4xkr52NefxFbL2VPYPDi+qUjrPC3K0kBHinZ/Fsq
         2phdnEppKzvFifPWvXi4ElcD/vKGO8gT0/bLdSVwO0PHbtwp277PRMc7GbAEdjHOOH+m
         QnpRAH7VESXtqC1qJSES5ttW9qCaOtpWTkbnycKRjaipHYCsrqyx2YZth7ktrFx172ji
         Rzwg==
X-Forwarded-Encrypted: i=1; AJvYcCVtnHSseVOAXvjfDd6GlAC8EZl+r3ZAlgxmltZLM0wMnzN9ibC+k04yPYcjjXltNepBrjSg/YCDhVBBFZWATLC9BuYHLteKJBeEZuxK
X-Gm-Message-State: AOJu0YzVv/Yd31xmVY8eAumG5ubSA9sIL4DctlZUaoFJkxKKHiBwgUBr
	uPQx6cpY6DeA4VlDDDnsH7J3UScb/PYV0jQJm7GgTPOT5nrOJ1qs4vMAjRwL1YklDwB/hByhmMe
	UFZltB4qEydoMTSGdIQQmiBUI8Z8j2aRQHw1CYA==
X-Google-Smtp-Source: AGHT+IHHmk74IE8scGgjW1MA4yxBJ9PwOjAQ6rxjvysJIcxEsIiPlTJBDKRwr/WfkqfnKAcJVpym/JYECv9QYftiqow=
X-Received: by 2002:a4a:1541:0:b0:5c4:8b9:2c7c with SMTP id
 006d021491bc7-5c408b92d79mr790641eaf.5.1719469208123; Wed, 26 Jun 2024
 23:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627051125.24084-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20240627051125.24084-1-mark-pk.tsai@mediatek.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 27 Jun 2024 08:19:56 +0200
Message-ID: <CAHUa44G0FRwMX5BYtiBvY4XFME=8uYbNoLRnAQCO34z0LgkJSQ@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: ffa: Fix missing-field-initializers warning
To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, yj.chiang@mediatek.com, 
	"ming-jen . chang" <ming-jen.chang@mediatek.com>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 27, 2024 at 7:11=E2=80=AFAM Mark-PK Tsai <mark-pk.tsai@mediatek=
.com> wrote:
>
> The 'missing-field-initializers' warning was reported
> when building with W=3D2.
> This patch ensures that the remaining fields of
> 'ffa_send_direct_data' are zero-initialized.
>
> Signed-off-by: ming-jen.chang <ming-jen.chang@mediatek.com>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 3235e1c719e8..1aa995752682 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -660,7 +660,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_de=
vice *ffa_dev,
>                                         const struct ffa_ops *ops)
>  {
>         const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;
> -       struct ffa_send_direct_data data =3D { OPTEE_FFA_GET_API_VERSION =
};
> +       struct ffa_send_direct_data data =3D { OPTEE_FFA_GET_API_VERSION,=
 0, 0, 0, 0 };

Please use designated initializers to avoid listing all the zeroes, so
this would become:
        struct ffa_send_direct_data data =3D {
                .data0 =3D OPTEE_FFA_GET_API_VERSION,
        };

The same for the other changes further down in this patch. There is an
example in for instance enable_async_notif().

>         int rc;
>
>         msg_ops->mode_32bit_set(ffa_dev);
> @@ -677,7 +677,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_de=
vice *ffa_dev,
>                 return false;
>         }
>
> -       data =3D (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION =
};
> +       data =3D (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION,=
 0, 0, 0, 0 };
>         rc =3D msg_ops->sync_send_receive(ffa_dev, &data);
>         if (rc) {
>                 pr_err("Unexpected error %d\n", rc);
> @@ -698,7 +698,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device=
 *ffa_dev,
>                                     unsigned int *rpc_param_count,
>                                     unsigned int *max_notif_value)
>  {
> -       struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABIL=
ITIES };
> +       struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABIL=
ITIES, 0, 0, 0, 0 };
>         int rc;
>
>         rc =3D ops->msg_ops->sync_send_receive(ffa_dev, &data);
> --
> 2.18.0
>

Thanks,
Jens

