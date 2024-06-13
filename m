Return-Path: <linux-kernel+bounces-214081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371AB907F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1AAB217BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D23314C591;
	Thu, 13 Jun 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l09V8A2O"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FC824A4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319754; cv=none; b=m9oLK+y4wcQqGBWJPbCLEuQtoEdWM4hyFDmfFmEPn94P89HJt4f/bj6IbbNl6ZMm5FntbOOt3w3BgvPQ9siF+WZcJysApV1DlZt9MhsO4w0F2Ju+evf3VaJ/NPwvqeOvhtWu5/IBGcRmtElT3+Qn7uU4lZlJFNfSbPL6SgPs700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319754; c=relaxed/simple;
	bh=oPp1EXkRA90C0HOtAQpgOA+kMVu6GdF9j2/tqPbSsXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8U5TVZFd1oZl22yWC8yFit4GrPPmXE22Ux1jeT1y7wwipDi7CuitrRB95XLWM8WxhEQBI93JuyrftcMIF2k2Z+0/QEmhdUl0r0vYJxcz58sfILc6PxKMsI13XCbOmHJt2U3x3mH0R6XaPHt24pQXn/KZXlqmAX2tzs+j8xeJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l09V8A2O; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f236a563cso1361364f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718319751; x=1718924551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXIJpyDlcvNNz9FeS2cMW/4txd/zHy0zvpYr5HA24Tc=;
        b=l09V8A2O+YCpAA/ZowjDsZPCHG8sSqw0cMBKzjanyptIyZvp6Y7UI65QQTRYaYIbli
         HR9SUw5iroaQqYmdCNotbj7ScTj4mPByXIp0FUJzioMpySTrL3/95KPXadApn+rqdeof
         Ual9533H1U02K5QJKBXxy+CdThdy1vKHUf7+yq6+BYfDXEfyzGUyMoHvNYVKTvNGYouC
         wwW5OsogM+bzFaJgcObkezM/vz8xMbmJx7jvSYPbfU5vyvJrCfFvA0enkEe7yeBf0gXV
         z9Lri3J+B9GSjLxP/GpuyifIaQFHXKlNtvYk0RSzrUZ7zPnrF7LmTW1Ur7VJEVkjdeVG
         2ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718319751; x=1718924551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXIJpyDlcvNNz9FeS2cMW/4txd/zHy0zvpYr5HA24Tc=;
        b=ssXsrbzO6m78PCRMTu2DpZkMY72W4Ts6fD8hyQjMoTRHngnzlV5fI5mU1JfPbg5fFU
         ktznKL2Khijmq2Xa8iewnPs1b9XZZAjF2RmvLa5SmZmygW4iEL+fagLqDjMsKxZDN75u
         EIa6QZmEFRu3E3Ibfce52DFH/WfLQoUHSZ9G0FPwrH5DNrCHrPOa2SxT0nnHpn9mth4v
         0Z6cFxan5sJS05hyxaiam6Q+XHYkRvVJioF7G4ebjDhonA0JMNn5LHj9W1u0hcxwU3GL
         CB9xsMRT73qAA+gt3/ufllwkzNoUmr3pWGBXZbCXMwnKdnzNKveOq+IJigQAq77Ef9X5
         HqrA==
X-Forwarded-Encrypted: i=1; AJvYcCX1D+8R4C0tll73zhX11r9gZaUdP2uZfammfNK6rINnmvTGWyYB45RT9BIOK/FbOv/zmRe9B8m6DFVkLSgqLRQAhX2gkhEraCng3XUa
X-Gm-Message-State: AOJu0YxGh3ivJ6a45tjpg8401AS/eAqQyqd4GrYS4XJvpYMaHMln+31z
	9aeUIXnenEkic2sUOECzksDcIvHMG0QTZcxpR0v4bd057bnbRWdmGj66azM7gYoZ/JvSjUaoJOy
	bENmCQDx1VZhzBL4V0pXFpZXBQ5c=
X-Google-Smtp-Source: AGHT+IEr/iCjl/fflAyISRZJ5URww5hZanP+tKvTM2VPXc4vMcIX6I8z5DSCa4Dq3aVfppOCP3vXDqjGWmIegbzu3Ow=
X-Received: by 2002:adf:e256:0:b0:360:81c3:689c with SMTP id
 ffacd0b85a97d-36081c36a40mr190889f8f.7.1718319751207; Thu, 13 Jun 2024
 16:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611133229.527822-1-nogikh@google.com>
In-Reply-To: <20240611133229.527822-1-nogikh@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 14 Jun 2024 01:02:20 +0200
Message-ID: <CA+fCnZdfB206Bjw=MAkZ9qbKUtf-KeGrrqJnOJ1ZrgH6fGXRhA@mail.gmail.com>
Subject: Re: [PATCH] kcov: don't lose track of remote references during softirqs
To: Aleksandr Nogikh <nogikh@google.com>
Cc: dvyukov@google.com, arnd@arndb.de, akpm@linux-foundation.org, 
	elver@google.com, glider@google.com, syzkaller@googlegroups.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 3:32=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
> In kcov_remote_start()/kcov_remote_stop(), we swap the previous KCOV
> metadata of the current task into a per-CPU variable. However, the
> kcov_mode_enabled(mode) check is not sufficient in the case of remote
> KCOV coverage: current->kcov_mode always remains KCOV_MODE_DISABLED
> for remote KCOV objects.
>
> If the original task that has invoked the KCOV_REMOTE_ENABLE ioctl
> happens to get interrupted and kcov_remote_start() is called, it
> ultimately leads to kcov_remote_stop() NOT restoring the original
> KCOV reference. So when the task exits, all registered remote KCOV
> handles remain active forever.
>
> Fix it by introducing a special kcov_mode that is assigned to the
> task that owns a KCOV remote object. It makes kcov_mode_enabled()
> return true and yet does not trigger coverage collection in
> __sanitizer_cov_trace_pc() and write_comp_data().
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")
> ---
>  include/linux/kcov.h | 2 ++
>  kernel/kcov.c        | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index b851ba415e03..3b479a3d235a 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -21,6 +21,8 @@ enum kcov_mode {
>         KCOV_MODE_TRACE_PC =3D 2,
>         /* Collecting comparison operands mode. */
>         KCOV_MODE_TRACE_CMP =3D 3,
> +       /* The process owns a KCOV remote reference. */
> +       KCOV_MODE_REMOTE =3D 4,
>  };
>
>  #define KCOV_IN_CTXSW  (1 << 30)
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index c3124f6d5536..5371d3f7b5c3 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -632,6 +632,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsig=
ned int cmd,
>                         return -EINVAL;
>                 kcov->mode =3D mode;
>                 t->kcov =3D kcov;
> +               WRITE_ONCE(t->kcov_mode, KCOV_MODE_REMOTE);

Looking at this again, I don't think we need this WRITE_ONCE here, as
we have interrupts disabled. But if we do, perhaps it makes sense to
add a comment explaining why.

>                 kcov->t =3D t;
>                 kcov->remote =3D true;
>                 kcov->remote_size =3D remote_arg->area_size;
> --
> 2.45.2.505.gda0bf45e8d-goog
>

