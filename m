Return-Path: <linux-kernel+bounces-514772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37632A35B54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB76F18934BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D922D25A626;
	Fri, 14 Feb 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LWjv5omc"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925A420371F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528271; cv=none; b=qxLcbJoiz0X5UtyrISzopEvp0lpqoLS9gN1IthjG/essZMiVitMfGO6IbUfg+W9DPmpV/S3d+D2dY91h1rA7frZdjM1Z8V5fJoepunxbtcIrIILO863mS0e4eIZOxTEu+oumTVgJJKeWJfcD6bPFXMbLS51CMEENNX4RT1GSXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528271; c=relaxed/simple;
	bh=Gr6byYJ9M8CPC9sGIW1C7Afb2eDq+IKbUI4St6uD8kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fev8GjLF2BOR9vvrLgDCg4dVUm0g6/I7UjbbwzepyrCF4QpXbZsiKwu+InCwrfPPcDjwP8fSh/zNCDHvG1C67AFpGytb0dXqnnJcOJLFgmVAzkAkcK9Uaz6n8xTzmVUlbGtpr1SGGtyz+ivjWqKLJ0BAjv+HZ7y50lPkjkogE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LWjv5omc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471be82b59aso21936581cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739528267; x=1740133067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3yD68siaD/I9UgRfvv+/Zcj4LmxGh3rVL8Upyuh46WM=;
        b=LWjv5omcJkf1sCni0F1Rfq5cBxi2paiaTUICH8/NzY37BfSH3avu10LVYnu1kiMGx2
         y6iC3dHfwO3twhTokQBELhqlIXxv+Ttjd3DCjKMt20MMGQfQrE7yF4BRHMrMdTEDK3SU
         E/PL8FL+TaCwLJeARp2xFHGnjZhQ2SQXoCIRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528267; x=1740133067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yD68siaD/I9UgRfvv+/Zcj4LmxGh3rVL8Upyuh46WM=;
        b=cGmJgDP3ktAmdk0Jq+U7DsASgG48iyZ+pczzgfQFOByYi19aC9+ppxb6eCdt7y99Vf
         hEEXEFgfVonYr7K/kIth/8StfoqEq1aD3PSTyjxjt8lf19K1Uu2IKbFYbzxi+HuZujsA
         a3zMy1PKH2GNOjGpGepp0FQ4UocbaITKYCq4hUfdchHQcXgkNdxUJCPvSM+liUi6GrK/
         yXZUDrgNSOOo0GLJ23gV9t3X3udkfQeAQYJ0Q44hSYSjVFU2V52d/+tLYrRW+zuPnQdQ
         qg+L8J4whqUdh8GJQH3CgYot24NbcvEaEpBTRbawU7heivxVnwehQSNcU+9NwhugKIiT
         vvCg==
X-Forwarded-Encrypted: i=1; AJvYcCWsAZRYFi5rGhf20rTNr2wc7Ef4VMW2GT3yHxO2R5WMSZ3WHsYhYjttM3xVt3VTr1R7p0gGHjnDKeHgRnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8XIrTXWP9gvrBC7Sb3WNJxH8I7REu3+hi+z+CD1tiKeCFr+a
	a0TbJq505Mx6COiJ11EyYuy14sg11au5nyx8t3ZXp4QDoPPLJLB7pE4OuzHzBwvullsU0LYtGZU
	EvoC6qeW/MpSIT7BY/IZOvbfj1J+Kaaohjr/KpIUoBcK1S4Oq
X-Gm-Gg: ASbGncuIdcnhdrNQFQKGWKfsECVDLvuxWeB6ko5bgAyJg473QV/Yr9fZIftD1tdJA2D
	ia29IQQXyjpjKEpJpAx9Uv1ODob8tUGdrmYri9D6lZ0lYj7bHLG8H602I/kNJ7LdonNzy7Dc=
X-Google-Smtp-Source: AGHT+IG3mKwmLnvWbK44lR51bl7+ldcBa+nQug5GaveJDGSkAeqK8YsrvWrGfFD9Z44VTq+oRGlo0S30jmbiT6EXMdM=
X-Received: by 2002:ac8:5e4e:0:b0:471:ac69:eb8b with SMTP id
 d75a77b69052e-471bee89accmr96603261cf.51.1739528267456; Fri, 14 Feb 2025
 02:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-fuse-fixes-v1-1-c1e1bed8cdb7@kernel.org>
In-Reply-To: <20250204-fuse-fixes-v1-1-c1e1bed8cdb7@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Feb 2025 11:17:36 +0100
X-Gm-Features: AWEUYZkl5LMMKq4x27aNE4jBCskO4FurzwsUpNO4-oLw8724QP2Ofox5ftiFHmo
Message-ID: <CAJfpegsOOv7c3R5zQZWWvYEgZxyWGCJyf8z=A8swQQZsGyvuDQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: don't set file->private_data in fuse_conn_waiting_read
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 16:04, Jeff Layton <jlayton@kernel.org> wrote:
>
> I see no reason to set the private_data on the file to this value. Just
> grab the result of the atomic_read() and output it without setting
> private_data.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/fuse/control.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..17ef07cf0c38e44bd7eadb3450bd53a8acc5e885 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -49,18 +49,17 @@ static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
>  {
>         char tmp[32];
>         size_t size;
> +       int value;
>
>         if (!*ppos) {
> -               long value;
>                 struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
>                 if (!fc)
>                         return 0;
>
>                 value = atomic_read(&fc->num_waiting);
> -               file->private_data = (void *)value;
>                 fuse_conn_put(fc);
>         }

"value" is uninitialized if *ppos is non-zero.

I also wonder why this patch is an improvement (with the bug fixed)?

Thanks,
Mikos

