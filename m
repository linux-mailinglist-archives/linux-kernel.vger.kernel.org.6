Return-Path: <linux-kernel+bounces-525674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC374A3F2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D467AA92E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305132AE89;
	Fri, 21 Feb 2025 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EuyorT6u"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF587202F95
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137731; cv=none; b=I/EC5vrFEfo33q0OHwy6HBhWrrT6TMgSdoBpZevnkaR7VpyooFMSUU3o27+IBCbk2hvg9SZHwslZNkB34g+hTz/47qIH3Gk7A7SW55Mjt4kH8/UphV6/oqaPhVQKfVbF6SlN02OQXH0wlLuk7Qds9c+nTHXcVSz9U5xCnk8onAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137731; c=relaxed/simple;
	bh=j7taGfQN/sH9rIsx0EB13VNeWU7c6tB38NP3YTw3zwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1Cg8ISbsfp+q2Z6vYaGWcQS9lk4doiJ10N6nUNOdpSLKa0L3xZDXTtCX2T5e7NztFuie6aK2KJRvIIViKH3Hsm6iDHuDIlpMndx9x5UUh+eUfzR1bpzgY3HK5cck+LAJcBYQkYv6XWk3N1wJ9T+JVAg/ACJALfBpaSwU7lc3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EuyorT6u; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-52098b01902so1203020e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740137728; x=1740742528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwohrPAvCZ/qg3MA5g5m35rC3ir1Vy9aIxHkgumCgKo=;
        b=EuyorT6uuQz2uURxqOIkxmRkf9Bx/CKDc4cJ7TcUJG5FoKS2d8yI4ooWeqj70PIRXA
         T4nN+LwYZIzjUJ4luZDN8heiS3t/U0Jy6hAG3ucSYbQd7QAJapMjJVQxd1a6mL+OSipc
         TuBJU5hKgQlBR4Ssh7+1FRIHmBZANRg+liGAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740137728; x=1740742528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwohrPAvCZ/qg3MA5g5m35rC3ir1Vy9aIxHkgumCgKo=;
        b=qHKQWSRTjtusZZmmQT8xkQ8Pq3DYTPDJvWgCc+64bQ7AWeRTNbuPNmSdEoJUWmGoet
         nrJpouoAEw745FmG71o6eNk460wmDOcKItLOrWGLEB28IisDwUqfnMkY91ZPjdzIEuql
         KCLuWKvpBtiG3KjlA3j26Ulg88pBjn4H9Yerq03f2y3uvWBFFUzgG3WBJHgU31EXPrZ+
         jD3thhtpN9WlnhpJoGN4q684qojRQCSHZM85g1Hn1/DjO7AAiZc1ow+B7x6qf2S3p9NO
         /iY9irSO9gpyeQGuYKAYfDxU1llUZXNbsfj1mu5KwHWFMv3DyfgK5lDnwUhlTQvjjbgS
         xrkA==
X-Forwarded-Encrypted: i=1; AJvYcCUHi3rNKocP3KUnUNH3IFghGoAm0NJaIZYW2+XcrKnJdw7bInSNHmkXGrpBjx/8IGzvUf2XkzDtgee4HYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYzK1ehgORt8J03tdPBqlocO+YancSgnG06M1lvsbw4oZJtUUA
	iZra75ozAKYeLX0d0+/PvveZLLj3c7LX5/17pW0345KuFJKgvWFXlyG6TDGRwby8p8uY19+9LbA
	=
X-Gm-Gg: ASbGnctweDlnB1aWaP/GLPNltYAov0NSdX+Wtaex0O2jCREZ7QIXDBryZ734cpMGx1f
	FosTOE5GIWeUrK68IWKdt0f/j2TgdA6d7fOp3NL+bLtJ2rwbBVKrxXdcoRF9b6clZbT0XD8ppvH
	praVczKGlI/WtDMjCq1eHFFOcFpRGCMWpb7nqe0AemOM6OpIHPrgh7P1zzB+4f0wjxIHdKdgsoT
	aGVGTjZ5Oz8u7iGpttxVBxsu3xQPhQ05LKAkHH1qWt9Xis/I7JK+Fqq6GbZIa4VFKx6rPFD9Ojs
	V/SB3KnaOMZMMAnVzQZhhpF5N1MDUXDMj7ngRSatw9ek7iglFkAptvfi3HnChg==
X-Google-Smtp-Source: AGHT+IE/tNMqPJkuWsI7kRbzS3inCKfMimXYqWAlhxtl6IagZbemaW1rRbr5JwOt9oaayXBnts5foA==
X-Received: by 2002:a05:6122:3637:b0:521:bb4e:c68d with SMTP id 71dfb90a1353d-521dcab1650mr3796520e0c.0.1740137728503;
        Fri, 21 Feb 2025 03:35:28 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-521f3aa31basm121864e0c.27.2025.02.21.03.35.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 03:35:28 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4bda3ea7076so1320030137.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:35:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbhEAgEAy8Ns3OZQ4iKHatBcZwMMAWe9Rv3WTCvpfRxH9qqDCeZ++gictLm/eqJu82PMnxxMMvndDA+tM=@vger.kernel.org
X-Received: by 2002:a05:6102:2921:b0:4bd:22d9:b117 with SMTP id
 ada2fe7eead31-4bfc0fdf40bmr1459685137.10.1740137727505; Fri, 21 Feb 2025
 03:35:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-mtk-socinfo-fix-print-v1-1-20500f30ef66@collabora.com>
In-Reply-To: <20250221-mtk-socinfo-fix-print-v1-1-20500f30ef66@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 21 Feb 2025 19:34:51 +0800
X-Gmail-Original-Message-ID: <CAC=S1njHBs27TtTZXgED4wdLw=FrSDCazbb6ZssZywvSWV2h3A@mail.gmail.com>
X-Gm-Features: AWEUYZmV51gkv5en-4xAlrGPHtRp_UB_-TGQXQmxc_me0FZsV0tfUBhu-ic9sd8
Message-ID: <CAC=S1njHBs27TtTZXgED4wdLw=FrSDCazbb6ZssZywvSWV2h3A@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Avoid using machine attribute
 in SoC detection log
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:04=E2=80=AFPM Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:
>
> The recently introduced SoC attribute info rework avoided modifying the
> machine attribut but still used it in the log message on successful SoC
> matching. It leads to print a confusing log about a board-related info
> (read from devicetree) and not about the matched SoC:
> ```
> mtk-socinfo mtk-socinfo.0.auto: MediaTek MediaTek Genio-510 EVK SoC
>   detected
> ```
>
> So, fix the dev_info format to display SoC family and name attribute
> instead.
> ```
> mtk-socinfo mtk-socinfo.0.auto: MediaTek Genio 510 (MT8370) SoC detected.
> ```
>
> Fixes: da77c2d3d06c ("soc: mediatek: mtk-socinfo: Restructure SoC attribu=
te information")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Ah... my bad, I forgot to update the log. Thanks for the follow-up fix.

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-socinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mt=
k-socinfo.c
> index a15d8f854cefa90883377b47bbc16a7072ee21cd..ac7bb0cbff2df5e1c4033646c=
d3b644e67ee7f69 100644
> --- a/drivers/soc/mediatek/mtk-socinfo.c
> +++ b/drivers/soc/mediatek/mtk-socinfo.c
> @@ -87,7 +87,7 @@ static int mtk_socinfo_create_socinfo_node(struct mtk_s=
ocinfo *mtk_socinfop)
>         if (IS_ERR(mtk_socinfop->soc_dev))
>                 return PTR_ERR(mtk_socinfop->soc_dev);
>
> -       dev_info(mtk_socinfop->dev, "%s %s SoC detected.\n", soc_manufact=
urer, attrs->machine);
> +       dev_info(mtk_socinfop->dev, "%s (%s) SoC detected.\n", attrs->fam=
ily, attrs->soc_id);
>         return 0;
>  }
>
>
> ---
> base-commit: 964b0ceed00032fa0fa841fd61e5f315880a2d36
> change-id: 20250220-mtk-socinfo-fix-print-e83f3b3e50bb
>
> Best regards,
> --
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>

