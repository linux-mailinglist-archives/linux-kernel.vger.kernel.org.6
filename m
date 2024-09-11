Return-Path: <linux-kernel+bounces-324314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB1974B09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06FE286A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCF13AD26;
	Wed, 11 Sep 2024 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCPpLy42"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3BE33086
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038828; cv=none; b=L1087MH4/R12iaJQPOx3vRmCuCcfZzXDdfycqigfAW2mnhPKVCUKLcvRSLQd8wEcdLjhcxcQocWfFj/B2mtqr4pJd/dkm6NxVXUBzTVw5tZGjyfpiIqe/wmNj1r75eFFlVvnBwvAIVm9JgtSk9kV7/gkajzCQOU1xyO0qkqWFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038828; c=relaxed/simple;
	bh=FG0vhDdE2kEDHdjeLrKC9WT3SCrt0nbsjC9nvDFei6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+GyZ6CV+93HF2SoIXCjhrB6d315r26iPxPfxXeysBdyfqUp3H2t/GH2ftMXY6cLvAMzO33UzZJ1UyFFzKMAZApZHIiiozSjfTUZBqC6n/HIIf19fWVHZ5s5mafH5yKSvdW4izOR8WMj0RuJOZlgSv1/F2PSFEYVM0NKk7MNWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCPpLy42; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso1011810a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726038825; x=1726643625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpbnUhyXk9rzBjZhyi8AWJAiR6Z6aDTpJ4wMNR8NhZo=;
        b=fCPpLy42siCKfeTCD+ZibAeVuE2QUEvglChAWO2mDYo2F2YreJlvHH/jsG9+bqD499
         GthxcmhOiTFevg61xzkLDHKoVF5qTBlAyiUp6WQyJ7a8vpVn4VzDsscw1WCswFgSfGxe
         AxVFJxjS3e4KBpc78xTetvBvz6rNQy/5PRXMwH+A/n+vb5DszXB6kUrNxN6EySJLFoS5
         hNbzvT2S+YkTZ6ioqwYancNLutWAdws5SbNbLegZj2JbD8SygagZAhOSzLA7HTG82101
         mPJxvxmh85DxXgRTjmKsi9sgItt82DplI/XlJhJD62f5y4lw3nxTT2R2zUOicUiVubO6
         EZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726038825; x=1726643625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpbnUhyXk9rzBjZhyi8AWJAiR6Z6aDTpJ4wMNR8NhZo=;
        b=YPMSiYnnNcObYvPkAuj8VpT4dcNNP6YsnDt7WPyC2zplQduoKmq5/xRBcZV3EZZrWB
         vFnWUJLJXwaBVJmLVecpgcHHwpw6a6hekVFWOtMX+N9wBdo4PB8onIqoLcGl9lPeKGgC
         4jz0/WUzGmoKzCmbdLiQ3fqUafDElJvj6JGNKBTB9xOc2xtSfvxOibqoWocmbYPlcSRb
         /ohBO1MpXRuHNwa4HhXe2TzwW8x+nxiZD0Tph14cYy3vwoxxTKvS9Jn1NoRSRc0DGWKp
         u0fD1jQe/3Mo4Uh8zODoXV6QoOXXUiiSv0E1YEaBqngbkv8WYpVxt8gLB7NfGHrke0JL
         yZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNmmPbG/JP+Eq/f5P/ICuGRv2GGrNYsynAj+yLnOBOKZt/bbLihAzVb+6qEN4LCP2LCuatNlxfPKmJE18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00qVDhxBFX38U/F2k/qMr74eTTSmYdtOD/MP4KDrrBkN/M8dd
	NfbIbQyQ8inzvPy+YNujuFDdHaVTw1U4fsl7ouSeJwSG8OaMMxeIKQ7YWuPohNgrC653kSXqA4y
	695JySRg8nQ1BWHIeqf9G0/M8Rcjjo8BGIYsw
X-Google-Smtp-Source: AGHT+IFaH0rWRZUpy30EVnoaZRDUOXbJjy+yfijB+mhWpPSiqLVupU9Qc1p4YigSs7+YJ25x4UOQw78w92QwgHVkODQ=
X-Received: by 2002:a05:6402:2347:b0:5c2:751c:64ef with SMTP id
 4fb4d7f45d1cf-5c4015eefb3mr6489026a12.13.1726038824199; Wed, 11 Sep 2024
 00:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911050435.53156-1-qianqiang.liu@163.com>
In-Reply-To: <20240911050435.53156-1-qianqiang.liu@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 09:13:31 +0200
Message-ID: <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: xiyou.wangcong@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 7:06=E2=80=AFAM Qianqiang Liu <qianqiang.liu@163.co=
m> wrote:
>
> We must check the return value of the copy_from_sockptr. Otherwise, it
> may cause some weird issues.

What issues precisely ?

I do not think it matters, because the copy is performed later, with
all the needed checks.

eg :

if (copy_from_sockptr(&len, optlen, sizeof(int)))
    return -EFAULT;
...
len =3D min_t(unsigned int, sizeof(int), len);
if (copy_to_sockptr(optlen, &len, sizeof(int)))
    return -EFAULT;
if (copy_to_sockptr(optval, &val, len))
    return -EFAULT;
return 0;


>
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  net/socket.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index 0a2bd22ec105..6b9a414d01d5 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2370,8 +2370,11 @@ int do_sock_getsockopt(struct socket *sock, bool c=
ompat, int level,
>         if (err)
>                 return err;
>
> -       if (!compat)
> -               copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> +       if (!compat) {
> +               err =3D copy_from_sockptr(&max_optlen, optlen, sizeof(int=
));
> +               if (err)
> +                       return -EFAULT;
> +       }
>
>         ops =3D READ_ONCE(sock->ops);
>         if (level =3D=3D SOL_SOCKET) {
> --
> 2.39.2
>

