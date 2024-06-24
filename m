Return-Path: <linux-kernel+bounces-228090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B4E915AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4BE1C20DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B24C1A2576;
	Mon, 24 Jun 2024 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDPd9ZoF"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8E19E7F4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719273249; cv=none; b=k3NgAWF89vJK2R95vBn6Tjazy8WirTZf3KKj8+lSb/P7aqbGgiLS0JQ2oG+CgAUjhNJrjmXq5ELJ7+p9W46ySzkcEKXvFGzJz33U/jw05YxLk/YI9C/IfLn3uN7AfYkRyXzDW/7ZUpSKBL/H/5caEN+l5JTs6E3Pljib9EKPF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719273249; c=relaxed/simple;
	bh=lf8GBmpN9Fi52I+no9v5KlAaHqPvvdgyGpEaUSuch2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exgJcofyhnmiYxNpKajsJ6uWZiLGJm9wT0qqfRfyQi1IXUGWrzXN8+I4ATs+WQj7hr8MYWAIH2Zcfg9EZ8w+N135Qmy80njKxBd7ORUAApaK/A9LNn2RriCH/zhq4NBYskX+J4Jz/zc57EnN4hN2Bx3Ih2vsVw4iHYx66vDxjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDPd9ZoF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44056f72257so73821cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719273247; x=1719878047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qt5O4KW6ke7E63qBvpf4NhH0h9nbbvs0wCI1j441McE=;
        b=HDPd9ZoF2Hms0Tx02h3QnetypOplE3c2XDJ487Ep346/7LOVIO58NhFAFTEYWUL3uR
         FmsP4qtoB3KKsczBiIqmJP7XjP9xo0BijWYNA8J71UgbUQUkIIlLPxRKngDioN81ClEO
         0OnnQpKKpSeyimAxd5EWbw0zVfrRoCu4Eq5ogH8ncaYRcma3eMmEHnH8EcV8NVZh6g0q
         BKS8Q5YTsXdDNLRC/zWSJNKjYfraPk3/jVb9xZ63C4UVgAmTmEnh/+fs7mz9oudYlA8p
         7MIJVlamsp4qzRcx/pB6pWwE7DvJBu8QyaPaLzpS4TdGs3frSjO2fANOELPUS+sxICYl
         wj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719273247; x=1719878047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qt5O4KW6ke7E63qBvpf4NhH0h9nbbvs0wCI1j441McE=;
        b=LZuzyO39asiNLmbsVA0Amn0ZjartqC+SUZcEhAuFuGhfhp0CoNNAALhoK0PgZIVeoA
         NR4LGqu1Js9IIl4sLFbrU5NCRAGG/2Y4Ep6qQCZWgAb0mspZ7uKPzJE1GmnZi3BHPyfN
         VIlEq2Jp/o9bPDIfDs0hmfVNa/C/v4NTOO8oO6visyRBkKI2nCKMzwjr4gyiPFX3U3gA
         qYK057bo+DgxZQ1w1HsjWJhJaF0DXocjyUSm38c7bk4RGNV7NULEWzwuBUmxT66C20w2
         o4RfG8sLyyNj8j0J82ryX1EcOZ6SWF+Gl0ksVgVWD7OkUNihYA3gC+ouwoT7OTXbSZRC
         q9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe7EtSpKohyjoEfleIdsnQNG2nELDj/M7mcHPYX/5vkwLY080Ij/mRpHygVPO16TPhRpVLcTaevH3NuHyz3lX68nevKDPueIyfJ6nD
X-Gm-Message-State: AOJu0YwnVWd+5bbnieOf8vI4REKO4CgB5zD3ockf+wGTnD7BlRtdjSFe
	0WUQgQV+595U1aQKTZm8HBZFziPEFdtmX2rT4PZd33SzopE06MXQG4f79en8RYnV3iKWr/79BQy
	e6dcnFMLD1IxEp8IKqAMQnjSMlgYt6T7aPg+0
X-Google-Smtp-Source: AGHT+IFiibHzRmY3cQEEeeNFwdz+dLDG0mMvpfkHJIlVYAtoOs4AP/gx96CBnpuPNeFwRm/KMvk1gI7MDfLTZ8TFwC8=
X-Received: by 2002:a05:622a:207:b0:444:ccfc:fd with SMTP id
 d75a77b69052e-444f362de1emr668561cf.3.1719273246750; Mon, 24 Jun 2024
 16:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
In-Reply-To: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 24 Jun 2024 16:53:30 -0700
Message-ID: <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers for
> SYNC_STATE_ONLY device links") introduced an early return in
> device_link_add() to prevent useless links from being created. However
> the calling function fw_devlink_create_devlink() unconditionally prints
> an error if device_link_add() didn't create a link, even in this case
> where it is intentionally skipping the link creation.
>
> Add a check to detect if the link wasn't created intentionally and in
> that case don't log an error.

Your point is somewhat valid, and I might Ack this. But this really
shouldn't be happening a lot. Can you give more context on how you are
hitting this?

There might be a better way to filter things out.

-Saravana

>
> Fixes: ac66c5bbb437 ("driver core: Allow only unprobed consumers for SYNC=
_STATE_ONLY device links")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/base/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2b4c0624b704..5eaafe3a280c 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2187,8 +2187,13 @@ static int fw_devlink_create_devlink(struct device=
 *con,
>                 }
>
>                 if (con !=3D sup_dev && !device_link_add(con, sup_dev, fl=
ags)) {
> -                       dev_err(con, "Failed to create device link (0x%x)=
 with %s\n",
> -                               flags, dev_name(sup_dev));
> +                       if (flags & DL_FLAG_SYNC_STATE_ONLY &&
> +                           con->links.status !=3D DL_DEV_NO_DRIVER &&
> +                           con->links.status !=3D DL_DEV_PROBING)
> +                               dev_dbg(con, "Skipping device link creati=
on for probed device\n");
> +                       else
> +                               dev_err(con, "Failed to create device lin=
k (0x%x) with %s\n",
> +                                       flags, dev_name(sup_dev));
>                         ret =3D -EINVAL;
>                 }
>
>
> ---
> base-commit: b992b79ca8bc336fa8e2c80990b5af80ed8f36fd
> change-id: 20240624-fwdevlink-probed-no-err-45d21feb05fd
>
> Best regards,
> --
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>

