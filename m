Return-Path: <linux-kernel+bounces-447153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB439F2E03
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EA1188466A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039BF202F67;
	Mon, 16 Dec 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHCdnlIh"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE12010EF;
	Mon, 16 Dec 2024 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344190; cv=none; b=FhajHiftImOZ7inOh3c4gKuIT/2NZ5nxT9HEnPaMBfFWZcs4lKncwnFTWTN4wUObypt8RNyaZwWRJOS8AB94zC5Kfb69NjQNpPbP92zjQKLjgLmxKS8xd68ZMDBTn3ETPn7TFlNDjedx+JXsFpAm+Vm9wUtCKWwP4cWHMn+SGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344190; c=relaxed/simple;
	bh=SDC8DYgq0QRPUI5/JSLftKj09uGEhrmO9h9wY+FQds0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4apq04oZqGpLAfc81E+RhhZZTUnoAhLwJN2QSqg4KmdTHPJUu5nnT/KeyNsEnlg8zxy0ZM7BG3FTRx0aiEt0hThWcws4oVh7y7IfhgXVjfvtGWdNWzXe/zUmNqtkdwwQxYkkTl6w/Btsb9vwpHaUNlEua1amwq34RBgJ22eVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHCdnlIh; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844ce6d0716so306400739f.1;
        Mon, 16 Dec 2024 02:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344188; x=1734948988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arlzLbfF5Z1aZwt8xNa4teVCaw1AO6mjelD0VLM9WsY=;
        b=cHCdnlIhztIt/6hh8wVOqb0KNJz0wOwjC+rkaTjVIkzXhfm/b5PsZukEdRclvW2SaO
         4nCV9d5sxMaH4fLeKoRqnNtjLmIAgt4L6OqXTDAKYh7/kj/ryCK4G89rQNgbXv4Ty7Jp
         UaiBqrt2tTn/T4p57qX/1Hosc2dPy22/WxEFcFlKFIf24w/lDqfG8FZlcXgAJfHJYAup
         r50rHmY6Dj9qE/1zVxO7I4jzjECG7Uctdc8ONIsHOuDUXk+IuJLYRUaJ2P8/S3YiGNRB
         JUVYUawavJr7zchcFFr9pg8oDs5QacQqQYiQ7yx8xGrff5GghCksA0o0pVDSyBc5ppvV
         E+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344188; x=1734948988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arlzLbfF5Z1aZwt8xNa4teVCaw1AO6mjelD0VLM9WsY=;
        b=vi463hF80D5q0jvXt1g0JDJuWfdiBLehvt/ZYY+TPBS6NxCU+zGZCdD2WmPZyEQndY
         /2GY3mn2pJcyv7wEkA6/L5tEzGbQz0wzmMWuo6xDV8oYuWDEzM9wTbfWsJLMoU64ZYeq
         KnazjPDrZH490eSrCPad8x2Ji+VIYs/LxD8BQ9nin3BI3YGmzmJPafXILpJE6qTGlnfx
         TiR93gYTxc/a3BObYIsfWfy1lMHYSAM3hEOJouUkyEc8ky2OE3L24aNTuiLxm3TJGQM6
         EEz6iqlaFENfQgOizjHHtgx2CeSpljcSU3lH3YJzCOuEWrfMJhKMnTG39LP+mXQ0pqQU
         kjwA==
X-Forwarded-Encrypted: i=1; AJvYcCV/dgsBc2I+1eXRf83cWCZw+lmyU6beN/dNKgToKLgBkw/lW/i5t4KvqrKjDyq6XKITL19waL2CZ+2b3jE=@vger.kernel.org, AJvYcCXzxxgDPpmOo0mL7Rr3FlwmqUbNu1VioRaCD8CkoAC4K/kWvYwyY6a1u3HQWnZin9mAVcXfWQjf32v9LGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Y8777L41peTtnmEUmaj08begcL7dGEAZKNOGPkYxD+kLtRDE
	7BIGr1Lx0SV6zQ5cxZ4hiRaAQd+8TXbIuXhSs3s0bLvMdSZzyx5olHo5SupYZoSGG2Ni9UFzHYQ
	krEgntMzZWWwrPwRaMhnoZfRq4NI=
X-Gm-Gg: ASbGncs0TLnpherOZRxy/MQIpCbDs2OQpeuniADeCQ2i26woBKFF8jE6xLuBLsQo/Pd
	Z3WOrdH7luVkNWRV4yJPbg0LsrW1Hjkv7GTYdzg==
X-Google-Smtp-Source: AGHT+IFvlcI3QH1Xvp1AI5KoCszLVW+PP0PTZAEx0Ng5Fuo074FICWOlvUIc4gWZf4SF1oGbhPxxmkXeQyJu107AnVE=
X-Received: by 2002:a05:6e02:20ea:b0:3a7:e8e1:cbc9 with SMTP id
 e9e14a558f8ab-3aff8aa41a0mr107368285ab.22.1734344188094; Mon, 16 Dec 2024
 02:16:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216093410.377112-1-arnd@kernel.org> <20241216093410.377112-2-arnd@kernel.org>
In-Reply-To: <20241216093410.377112-2-arnd@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 16 Dec 2024 18:16:14 +0800
Message-ID: <CAA+D8APw7XeTKm59EiG1teY5SFhRcM8WotQPuxnjL5AVNTHVyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ALSA: compress_offload: avoid 64-bit get_user()
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	=?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Yu Jiaoliang <yujiaoliang@vivo.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 5:34=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> On some architectures, get_user() cannot read a 64-bit user variable:
>
> arm-linux-gnueabi-ld: sound/core/compress_offload.o: in function `snd_com=
pr_ioctl':
> compress_offload.c:(.text.snd_compr_ioctl+0x538): undefined reference to =
`__get_user_bad'
>
> Use an equivalent copy_from_user() instead.
>
> Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation m=
ode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang

> ---
>  sound/core/compress_offload.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.=
c
> index ec2485c00e49..1d6769a66810 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -1180,9 +1180,9 @@ static int snd_compr_task_seq(struct snd_compr_stre=
am *stream, unsigned long arg
>
>         if (stream->runtime->state !=3D SNDRV_PCM_STATE_SETUP)
>                 return -EPERM;
> -       retval =3D get_user(seqno, (__u64 __user *)arg);
> -       if (retval < 0)
> -               return retval;
> +       retval =3D copy_from_user(&seqno, (__u64 __user *)arg, sizeof(seq=
no));
> +       if (retval)
> +               return -EFAULT;
>         retval =3D 0;
>         if (seqno =3D=3D 0) {
>                 list_for_each_entry_reverse(task, &stream->runtime->tasks=
, list)
> --
> 2.39.5
>
>

