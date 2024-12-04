Return-Path: <linux-kernel+bounces-431393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E879E3D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9DC8B2F5E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA02203704;
	Wed,  4 Dec 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8/IVmwW"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7819D886
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322613; cv=none; b=kHErmEFGhEZtlze/BYZokuBFKaU0JrnCqciX6NOd5ssXMmAGiqG7AmdFvrR7BESp4SShkBVqQFw+hQFDESS2dd7fITThKE2ybVyA60B/JZLkZOqOcG+xJg2LR0VcYtp9E6haOd4tSsmHep3CUzHUTq3bupuquHN+TPOEiCQOFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322613; c=relaxed/simple;
	bh=cB7fVxOQPIehFKip7mjs5gj6FEEO8SQpSSyrgPHGkKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNHBnWgt7Y+Bkvy3BGbQEz6S+JmAR5QQZgPQDlwK+eJvDL22Zn/F4Wc1P5a+O0gsx/DN0lPQHJwejgA2t878xqZGDeFSZ9wIKvqgw0Qbe7SsOXX/v66N7UL8Hrci/UE/LA8WiNZe1kkJiaI3aLsIqv3mNrJT5Sq/DjpoVBt8SeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8/IVmwW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46677ef6910so45472211cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322611; x=1733927411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4ORUpe0pVZmQmvkw1nu+aTOjOaP1O5zfh0k3pgSPzo=;
        b=e8/IVmwW8BWoItz4/rBatFAEqlF9xYae4souYNr0bqruN+jeT6jKXF4zmOvPdKRNHh
         T+IR0wdUdKC4l7dCHOEcpYgaAjgmRaIb6nrM46KpQLqt5FAzuKK9HcfXp89CEOTmKYoQ
         QATSnPvfdW7fqKOSVIiFeYnZDRtqqbeBKmqIryZwdDKvE8YFsH7ND9dwpKfaw5wjlsY1
         wT+CWOVHoQQ+aeLQlbAJ+/sWX3QLXB1ocRrEngyuwnEaqwZTIjOw8aBgQQJB8BHJBVf1
         mEmJheDRsN6b82qtl4dRa+Mtt2afDoat8ePZEp68Y+Ukk4gpy8OD2z/OzaNH1QRxteXR
         dJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322611; x=1733927411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4ORUpe0pVZmQmvkw1nu+aTOjOaP1O5zfh0k3pgSPzo=;
        b=gjU6CPzbJp50/7yOqB7K0gz48Khom+++dXiVWcG/Y8AzutHDlJlQawkSmQfO8mIX+1
         KMBS7rJqTFP2hrbmD+rDjkkFJ7+LuDR9+JvmbyHqM9zNQ3gsw8Mu2HOxP/imoWqibbeP
         +jS/5Xgkax5LKjrH+gz3nAJzf0T0/w2EfDVBGvGvdddnSZk8+S4jGLgfEZxax7nNDdLn
         OvpkSccJG4cW7aYW76Ju9DNDq6iL+fIujNv34DZnOZtFnkJlAxqIGsbHuxomZD9beuPY
         9hxTB5Fkxij7Rxulbyy1hp93jZq5y7Pk0R3wYPKsjcfB2WVn5OApCCNnJ0/FxikdnwpP
         Th+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUTtw04qmbRF2BjrmSiDVBsQcoEIJPp++c2zqpOV9eF14wYAEfmJM5PLLokPlRxIMnPZj7bWxBNP9W6Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3tJdee8XIVJ2Ew9YGfuyP76ymUazruD0DVRo9+UcEtQThrbe
	f53LnF83o7+8evJcB6W62AbuxD03bcTMqkkySIi5vpNJutbhCcc+lKzS6PvM3JWS5QUnGCf2mii
	82If/yRhi5IuNfSqLJHj5o6AgT5UECsplLZQ=
X-Gm-Gg: ASbGncvsT1GpFgbx2FAq1TErXvoINW54SX4bxgD+s/kwD1lfqz2TfXV45HfuyInS4Ds
	i7U3nn9dzcsMH995Graucl2FP5gbdSIg=
X-Google-Smtp-Source: AGHT+IFz9AqjuEgEtpGhSGQOZnrxRUdrncSun9IdkUiaSxXNrzlUhCJKBQf8IWnzX9RSbBxpI0ATkHRWJCCRT5JjEU8=
X-Received: by 2002:a05:622a:1801:b0:463:60a9:74c0 with SMTP id
 d75a77b69052e-4670c09df44mr91467951cf.14.1733322611045; Wed, 04 Dec 2024
 06:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202194107.105119-1-afd@ti.com> <20241202194107.105119-5-afd@ti.com>
In-Reply-To: <20241202194107.105119-5-afd@ti.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 4 Dec 2024 17:30:00 +0300
Message-ID: <CABjd4YxYjX2bHSBMmPxH-5muQL5TG_ATS8B0+vCdNKJARke6BQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] ARM: vt8500: Switch to new sys-off handler API
To: Andrew Davis <afd@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andre Przywara <andre.przywara@arm.com>, 
	Russell King <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Dec 2, 2024 at 10:41=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Kernel now supports chained power-off handlers. Use
> register_platform_power_off() that registers a platform level power-off
> handler. Legacy pm_power_off() will be removed once all drivers and archs
> are converted to the new sys-off API.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-vt8500/vt8500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.=
c
> index 0ab40087ae1cc..1d294255d7083 100644
> --- a/arch/arm/mach-vt8500/vt8500.c
> +++ b/arch/arm/mach-vt8500/vt8500.c
> @@ -141,7 +141,7 @@ static void __init vt8500_init(void)
>                         pr_err("%s:ioremap(power_off) failed\n", __func__=
);
>         }
>         if (pmc_base)
> -               pm_power_off =3D &vt8500_power_off;
> +               register_platform_power_off(vt8500_power_off);

This really calls for a separate tiny driver under drivers/power to
remove the legacy single-register remapping higher up in this
function... Pending that:

Acked-by: Alexey Charkov <alchark@gmail.com>

Best regards,
Alexey

