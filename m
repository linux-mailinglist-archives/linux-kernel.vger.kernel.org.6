Return-Path: <linux-kernel+bounces-363806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD5299C74E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDA11C2272D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55CA176AD0;
	Mon, 14 Oct 2024 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAb857CP"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD218594A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902392; cv=none; b=alYTr3vdP4z1kFQpCa9p1yu/lrE/fjRMzDCZY2tn4BptkUoI4XDx8UFhcIQeUTK4yGF6f9QbG1tulqOQaglP9K5pgLqor/PcSZdr6DVvqrAC8ncmxkxkKzTXCT5EFYKwP6i5djJcyX18/ol//dOWpBwFyFKulmLzATgGOUwQ4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902392; c=relaxed/simple;
	bh=kOEK7GQryMcWJgr6KKlh0hQWqGxmHZGR92xPiRivYtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeVNjLGBomK3XJLIDfFEQky5xLu//UhLbaMChl9kuPrh/Cu/mE7F5X9GBM0kBnrnbpCNBxshRAncWZGZlJaAJ6kABnak4Azl+wdb1Y88dRqfHXYrUhmjNC443dLnX+QsZ+84lkImhUOUVsnVMncgZpooU/wBfL7BG7H4OsWFvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kAb857CP; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-28854674160so1760824fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728902390; x=1729507190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z+l7GWnWgpLcuVpHdjQ85yIjogCt0g0I4c7eMWz2MU=;
        b=kAb857CPHO5e44obsF1avCDIgGx55Mwv1Z67rKJew1c+QUickygUZvckfGOH9EvawP
         o6sfJytMUILZXHEPpZl8Vw7lED8ZB3mQMl5ttH09Vu0JW8bBS4aMcv51EyBeaMW6sK2k
         FI8CG7sOwhVPD51GuOqCA9X8p3/7r373E1i/0tS6ZhRDK0lTobcpz3vAPz7saM/5G/V4
         Xx7j6hHNs47PARn0mw4620VHbv1/zsb7TCF3jcEUfw3EnQyJazVqV461zGvKSUlF9jyW
         lkPwFYdiVCWFatdzXlmae9K3KalhSEVUEYYBQ0od8kLlR+aL2GaVb4SjHqUllXFl51Ik
         g2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728902390; x=1729507190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z+l7GWnWgpLcuVpHdjQ85yIjogCt0g0I4c7eMWz2MU=;
        b=jWlwUqOpcymNEfRhJYGQKlIB53eAZqOIRV4xBL0YU4vlAUnRtnhe3i5AqOu9Ni6eUT
         OGbB2VBbnI0/JDk0B+yFgkjCyBcsuVw5vrTx6D5CigYWoOddAp8RWBgmXQM93HllKUZ4
         mWDZ1C56XOlNyaYRKdzm268nHx3nIT9dpNr37HxjotU4g+SL0oJ6jW9wr44NB/ghuspQ
         THKsex8EeXZcTV2juGlBytH9xa+9/zbmiTVX3MqMPVrxzSMsJWWihtQf49/U0DbqL+8c
         20h2tyQFjq93PtE7WT8nvG57MGzrW+IDoaD2++DTHgMeimb4qph23zVx1Z+bx6MGyYEc
         lThg==
X-Forwarded-Encrypted: i=1; AJvYcCW8xp05hHqwhPrFUOSeu+A7EjE546l8BE5QE0jqiEgcGbjDTvRhQbEXjMAlUSUeV2rQrwxLzqbBIMWNGjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmg9iFrIoXkR3DNaslSjK3zMGgKyLjtsCXBXPyJA5Rdee34Y2
	4tdsiL94rdoR0Jz6NaECLQmpJgO6wYhTGjMSTBeetceH6cjSMlL5q9OfGND/UDmPaJR1quk+HyT
	RNE3rfsF8v/1uNoP73Wx5HPZTYLyX9KYrpxeXFQ==
X-Google-Smtp-Source: AGHT+IFCJaXrhYsjhqQq4FmYbtchaxdNXrreSj8YP3bKkJn5mLvijFOtXxM8CqkX+HeGxe5WBIPMNbN67XYWcHBzWGI=
X-Received: by 2002:a05:6870:7d1a:b0:287:4e4a:a2bd with SMTP id
 586e51a60fabf-2886e0192c2mr7383998fac.29.1728902389793; Mon, 14 Oct 2024
 03:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df8bfbe2a603c596566a4f967e37d10d208bbc3f.1728507153.git.christophe.jaillet@wanadoo.fr>
 <b1fcc6707ec2b6309d50060fa52ccc2c892afde2.1728507153.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b1fcc6707ec2b6309d50060fa52ccc2c892afde2.1728507153.git.christophe.jaillet@wanadoo.fr>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 14 Oct 2024 12:39:38 +0200
Message-ID: <CAHUa44FFSx+F=ym+cTXCRpiF7it-OXkXVbf_GYW9AYd2_xOe=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] rpmb: Remove some useless locking
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:53=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> There is no need for explicit locking when using the ida API, as stated i=
n
> the doc related to ida_alloc_range() / ida_free().
>
> So remove rpmb_mutex.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> See:
> https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L375
> https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L484
> ---
>  drivers/misc/rpmb-core.c | 5 -----
>  1 file changed, 5 deletions(-)

I'm picking up this for v6.13.

Thanks,
Jens

>
> diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
> index ad1b5c1a37fa..2d653926cdbb 100644
> --- a/drivers/misc/rpmb-core.c
> +++ b/drivers/misc/rpmb-core.c
> @@ -13,7 +13,6 @@
>  #include <linux/slab.h>
>
>  static DEFINE_IDA(rpmb_ida);
> -static DEFINE_MUTEX(rpmb_mutex);
>
>  /**
>   * rpmb_dev_get() - increase rpmb device ref counter
> @@ -63,9 +62,7 @@ static void rpmb_dev_release(struct device *dev)
>  {
>         struct rpmb_dev *rdev =3D to_rpmb_dev(dev);
>
> -       mutex_lock(&rpmb_mutex);
>         ida_free(&rpmb_ida, rdev->id);
> -       mutex_unlock(&rpmb_mutex);
>         kfree(rdev->descr.dev_id);
>         kfree(rdev);
>  }
> @@ -175,9 +172,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev=
,
>                 goto err_free_rdev;
>         }
>
> -       mutex_lock(&rpmb_mutex);
>         ret =3D ida_alloc(&rpmb_ida, GFP_KERNEL);
> -       mutex_unlock(&rpmb_mutex);
>         if (ret < 0)
>                 goto err_free_dev_id;
>         rdev->id =3D ret;
> --
> 2.46.2
>

