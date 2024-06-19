Return-Path: <linux-kernel+bounces-220586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9643690E40A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F701C24355
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310B74C1B;
	Wed, 19 Jun 2024 07:09:41 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E895C745E4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780981; cv=none; b=MLEuXZEv7+9cM13493Bn328sy0vatwB24cFYQmyAEmBsYffwCEy5iY82RMbk6UCib4l7Wk53jQzhm93Mg5yIREsQKWyFlHnYx9Ffi4uu9KN9YKsCD4Qy5sitPnJDnduv/V2Dg62my0FW3J5cz76T1QkrS58zMFbeDMQlo16pDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780981; c=relaxed/simple;
	bh=rFJdqYszRYReFAsTQw9Y1DHKIAJKdXnVrova/6d3nWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYkLAdmvsRHjBj0u+AYTbda8fdte72b/2Wg87HonMgMoBJWKiR8PfQcSyD7CPqzp/vptG3BStOf1v88tFE4jam/KIXBzVtRT7JUamoQojRCI74uzoNQDsTykzOb9RwSqSSDpmhqYau2K4X9LG/16bvimXmdfCTYS1rZMhtwk9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso6948972276.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718780977; x=1719385777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rOhArqBAHo+GTM+mMAn9uukwJ20fEVD7yV9+CYBKLY=;
        b=erZToTSDm+t1S4IuOFIZR6hjm7QAn+CEMZcJruWMv3itoY0OngXPjUw8TChq1gmFXD
         wUkZLqd/EtTYROn75qOGPwXRvM55RCUbK9C3ztsvahsjlmhbF/+E7d/5Y2CrreZvZPiX
         GEZNlsPzOG3pYFiTXtlt3vQhRC1W/b9mPqhAATS2rb4hjq8nHXaKpZxrgewo41Hbv/LS
         /UECHTtRi/Z6oALoyVclK+xjImIym7Q4UL2DPqR1b5/ZLmEFi51OixmiqJJUuQ45Qw3X
         nkmA3ov8PghgbDSoqlo2yWhrf+HRVlSDCxTbR0Fu111j5vpuERfxiNrdhoJfRg3zgVDs
         qe/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+H/3nm3FpFiXFKCToLDcwFmxzW5Hi4UHBsgFdNyLX9GZO381gTulyU9Sxv5VZXwGYz4u6UoymD7Kpd0K59TaAV7yfc4ZHxmuwQryt
X-Gm-Message-State: AOJu0Yzh2VRPK8fyFdKTPS/14+JqkU3IF9gj1+yseNzp1Hx19bKjL3Ji
	gF97mBQ+bhQTJQdTK+PdvTGcsZDB8PZjkpXMPOwaCcj7IOMSeWRyoPw+E3HN
X-Google-Smtp-Source: AGHT+IH7PawmUHXux5ZkYdbTinJiFOFjqNkDAHKzmqTUchrhcxWLHHZT9t9G6rY3cRxfOlI8F6bPtQ==
X-Received: by 2002:a25:ad06:0:b0:dff:2ef1:e3d5 with SMTP id 3f1490d57ef6-e02be227615mr1827715276.63.1718780976723;
        Wed, 19 Jun 2024 00:09:36 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dff0475ded0sm2581955276.1.2024.06.19.00.09.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 00:09:36 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-63152a07830so52893157b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrzuy9lqvGWyHJmriAg/CiqyqR8jbD/5YZ5lvuqlTF8C5bZ7jzYcjT0FeMCRIhsDxqe6m7boKWPoRGBmE+phuHIYwZiD8RtqnpZXsk
X-Received: by 2002:a81:8845:0:b0:61b:3348:34c0 with SMTP id
 00721157ae682-63a8faf12fcmr17482047b3.50.1718780976284; Wed, 19 Jun 2024
 00:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618073205.65303-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240618073205.65303-1-jiapeng.chong@linux.alibaba.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Jun 2024 09:09:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4+hhav7U3ORdUuNj3+Hgwh754dU41SWOTeALXd_vEjQ@mail.gmail.com>
Message-ID: <CAMuHMdX4+hhav7U3ORdUuNj3+Hgwh754dU41SWOTeALXd_vEjQ@mail.gmail.com>
Subject: Re: [PATCH] zorro: Use str_plural() in amiga_zorro_probe()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiapeng,

On Tue, Jun 18, 2024 at 9:32=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
> Use existing str_plural() function rather than duplicating its
> implementation.
>
> ./drivers/zorro/zorro.c:155:22-39: opportunity for str_plural(zorro_num_a=
utocon).
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9350
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks for your patch!

> --- a/drivers/zorro/zorro.c
> +++ b/drivers/zorro/zorro.c
> @@ -152,7 +152,7 @@ static int __init amiga_zorro_probe(struct platform_d=
evice *pdev)
>         platform_set_drvdata(pdev, bus);
>
>         pr_info("Zorro: Probing AutoConfig expansion devices: %u device%s=
\n",
> -                zorro_num_autocon, zorro_num_autocon =3D=3D 1 ? "" : "s"=
);
> +                zorro_num_autocon, str_plural(zorro_num_autocon));

Missing #include <linux/string_choices.h>

I will fix that up while applying.

Please try to at least compile-test your patches.
Thanks!

>
>         /* First identify all devices ... */
>         for (i =3D 0; i < zorro_num_autocon; i++) {

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

