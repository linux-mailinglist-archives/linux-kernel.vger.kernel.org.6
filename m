Return-Path: <linux-kernel+bounces-363804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12399C749
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9FF282EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC04176AD0;
	Mon, 14 Oct 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfH23soD"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEC156C69
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902339; cv=none; b=inoc5kCuuPz7p+VOS7Rhtg1GChLISasd6LoMNbqcY23rFfIWU9SoFs7qIvE4TPHZkFIJWH5Oha7fDmRQNhABsHnA7oHx25PtHMBPW+xjE1VwSHFMWaoTXMRTnarHi0LyP21q//Ze9BHWGRhYTTJgbqfxdqeJy17ZLwH9pQTvysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902339; c=relaxed/simple;
	bh=FU0Do7UJmeA/jYmiITl348LdiZkVn1yygV3LnrY4fWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWSccUiDSGChoKF5NAh//Ahfe++8AdxW5wdsVL44im6xVl9FplX2Scz6TGs8xq8QopsJ9+/WeU/1Py95nR21yUQ5/Fx7lH+WexI6tD6SHGFSaOL/nhDVM2hRZKqoNXjfz8lWyM8VLwGv50MO4MmqZ6Zq/Lnhd378jBG0NJZ3SDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfH23soD; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27ce4f37afeso1614967fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728902337; x=1729507137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeVaZ8esBQhrSfyG6kHPEmxIglfj+ISJFZ4DMJuVbMQ=;
        b=LfH23soDTV+gSOcqY4Ca6oM7ZVxL32V46OBhaB+Xwt0dHOvC4LPp9lzf5KGcYSRHKs
         KOkoNe/OhkAksR7IXrwyFF598+3VIFMjROKZAyrnvHIqhBVDyube5auKYazvtikhtFA2
         YmtStbLpA1RczEAQa44HeftAQmaYpyHdOdDDOU8Eqzy00VbD6s9ThF0OcWUhWwbjivSs
         sVcB8pK/ugM/9YQVa/vpv6YOpbhF7fcuLrQU+jQb+jDc2n3qQ2pmeL4jGTV6CMykEwU1
         a+6HlszkmUpK96Cu3VZbE1OY8TrgKOjGD3gmmbM0wVMIu+C24lsPkG/jG7ka3xrs7rD9
         B+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728902337; x=1729507137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeVaZ8esBQhrSfyG6kHPEmxIglfj+ISJFZ4DMJuVbMQ=;
        b=GuYb72zZ0KXW2F5gy9U7Pmrr8emidtPmi3TWUbJ427bD0Z99pJKZ65vFi+qOTVhQsj
         wZ2L8ucfFsPGpTdxVxGYqSmjuaaXmacIoNhh9lMyCG5t5cwquHoSzOW6mcpzR5a4ECbv
         kXN4cwkSM5gCcpGtIekn4EsdOejKbbqE1+bphsgAckhAauHg5TQHNzk4uPdVEVKceW3R
         cjiJgpk8oim4U4LAdWhpQ6NskHv6//U5rD07fKqNCSP+EA6NpOOj/Pd4blN0FKnueBMp
         ZLCPbaxbYwqyFMJ6iFUUK9nwN1RoZBesOL/f+I7i+VMo/BdwOvPRPxBrr6vZBzH+zngq
         vsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZMko+GAdQD9kjsBqukcitqqAGDCAh6P8ZfRvrPR4xxJVT38sfX4bAvK3ddpOtHSKagfT2scV9+4WOmi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8sjmSjJfn9eKvm9T/u8lYO8q0cjZy9SyS4i3Nvy8Hl75Q02c
	HfgZ+vNi/8T3PeIq3W+Zrzb0ipcqAoDI4ivb3kVmRODlrlHY2wg5YBc1tpQOPNY6xJnPEw+1SXo
	u6Wz4sO2OdSdPdWhSobtiNQKN0Q9G6QBBW3+zf5umnqBwaVtsTdo=
X-Google-Smtp-Source: AGHT+IHZNrqfdyioUZTjh8s6CK+TKTqUzsrBVI+6ovSzA5Pgf7K3SXa3zKJQJyQstral1yLaWPnUqAlKvYI9s7o+C5A=
X-Received: by 2002:a05:6871:706:b0:288:47f8:925c with SMTP id
 586e51a60fabf-288872c9d95mr4095779fac.1.1728902337054; Mon, 14 Oct 2024
 03:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df8bfbe2a603c596566a4f967e37d10d208bbc3f.1728507153.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <df8bfbe2a603c596566a4f967e37d10d208bbc3f.1728507153.git.christophe.jaillet@wanadoo.fr>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 14 Oct 2024 12:38:45 +0200
Message-ID: <CAHUa44GU=SR9MgBaXJi1yEbvg5Bb73FV4n8erGhN4s_qioKNCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rpmb: Remove usage of the deprecated ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:53=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
>
> This is less verbose.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The ida_simple_get()/ida_simple_remove() API was close to be removed (see
> [1]). A usage has been re-introduced with this new driver :(
>
> [1]: https://lore.kernel.org/all/cover.1722853349.git.christophe.jaillet@=
wanadoo.fr/

I'm picking up this for v6.13. I guess your patch set now depends on
this patch. I can ack the patch instead and let you include it in your
patch set if it's more convenient. Please let me know what you prefer
to avoid potential conflicts.

Thanks,
Jens

> ---
>  drivers/misc/rpmb-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> index bc68cde1a8bf..ad1b5c1a37fa 100644
> --- a/drivers/misc/rpmb-core.c
> +++ b/drivers/misc/rpmb-core.c
> @@ -64,7 +64,7 @@ static void rpmb_dev_release(struct device *dev)
>         struct rpmb_dev *rdev =3D to_rpmb_dev(dev);
>
>         mutex_lock(&rpmb_mutex);
> -       ida_simple_remove(&rpmb_ida, rdev->id);
> +       ida_free(&rpmb_ida, rdev->id);
>         mutex_unlock(&rpmb_mutex);
>         kfree(rdev->descr.dev_id);
>         kfree(rdev);
> @@ -176,7 +176,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev=
,
>         }
>
>         mutex_lock(&rpmb_mutex);
> -       ret =3D ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
> +       ret =3D ida_alloc(&rpmb_ida, GFP_KERNEL);
>         mutex_unlock(&rpmb_mutex);
>         if (ret < 0)
>                 goto err_free_dev_id;
> --
> 2.46.2
>

