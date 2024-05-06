Return-Path: <linux-kernel+bounces-169430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630C8BC88C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA53280FDE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCC13FD9E;
	Mon,  6 May 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9dpnCT/"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D942ABE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981695; cv=none; b=ZxTtmtEltjVxaBqn6QXsoXKI4w2zv2MOZBii4KSQyyopLbrjAflfXdu5AVdTP3vb2SiNoqVUVJjtRINdUdRW8Dk6UIt3B+EkEe9DKYFy3DZIhs/YObvpSE8BKkvegXREybp2B9suElvuZ3rv2uR/84SiRIq3pWeW2cuZI4q/nqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981695; c=relaxed/simple;
	bh=apURgdu9US9Q6NqpFuYJVO0syEU3Ulxfqt+JjajzVls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giX+sEk1JER6HbRQ4TNywfb7ijI7RpYRQff5Pjx50ijoWSCYY6akHFC8GoRGFp/XnfOl6zYKZWaK04u6qa9E9Dx+aL89/y/fsfaGgt9n+TJGO0aDkyrXdWroyNInA7bBES8JYig6qXWbpAXsCy1ix7a82ZbInaeFbkd2xtqIfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x9dpnCT/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f02e1fef90so845081a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714981692; x=1715586492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P6DJY4fN1oYQ+fD1hdKIRR5ynxkJi89nJoIba5ERBM=;
        b=x9dpnCT/Gf7+ANG8Ty7XnNR/w9Tf4zPoZM0fIFuhJaq4JdcApUFfAzlPdIrLp0mFeW
         Jo+LtR/esO8W6l9QSI3ZjTOsaj3st5KSEVhdapPsmNjMzxkY1++bWAK7Tx3SVvM3uUcZ
         liNXYw/BwywOyoanIsicV9lC8FpLSqNvd1bGUOPXRf8HC7Bm98rz17dd3iZ87cGU1aj9
         Wevvmi2tUGCcUURzWHKjrmsA/lOgM9fwEJMp+1dgld2Vjq8YfIEDjz9tImC4YylVYjtc
         pYAriUocQbnB0r7U1tC6qcBh//zTWSgh6UTQoZBAVWDw9V7L48ZekItwVEx0P7NOq87A
         xVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714981692; x=1715586492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P6DJY4fN1oYQ+fD1hdKIRR5ynxkJi89nJoIba5ERBM=;
        b=a88R+pFKTNAofFyDnU/VDLtAdyd9i1THt+qnHAEYomaInwKLeCMS63zjKsjMUTxw43
         Ey7WME2VU6tiIm+CMsz96wju8ABWrWPcEO3TTq+bPvt6IZ9g5XQboVgltmtSIuOLrXz1
         7DId+jRfj4DpDlInqueXDqUWsnf0rwBqH3MLzLxD7wf8oLwP/TXlWvvDLE9QpkS6v9HN
         +dyIGXjVWcvuLLflUkm9FRJ8opfI514S1uyQO6HZZU86aX5GVyo+hHaobqVk2maRHPlA
         VlncPeEfOVQDSHom+IAvRZzQea2WdPv//PB6yCDuXPqlLQKa5fs+MUgGKARyGhJYZFo+
         pb9w==
X-Forwarded-Encrypted: i=1; AJvYcCXxCBlH9d8hO/kyqoPNbJU2YVd3evpwYjVlJ+cP1jVutBHjzJF9qhYYkIpXoHHZ02ZHnfqSxFOx3dwcWp7z+jTaTjiURHyQIZQEfN6H
X-Gm-Message-State: AOJu0YyioZS/GQBoCPSA/xN5XcPDZolLp7QTYwClCw8SYroAcCKsbiU8
	zFP2mmUZLOTU8BUbOeg59dUyHxnypSKgn6OnfTjZ+xhUnuJ0r5Q/XQ+65i+XMjIo4Tzzft9Fpte
	kmH5QUEInBxaJNYck3WPYNy5467H+vAAavAX/DQ==
X-Google-Smtp-Source: AGHT+IFRjrDF2z1YHBQ36qKpgseIsHm+fGagHI2wj3a0Y3r/oMNEUJ+ZfENTe8UOBiA8G/22/t3PRwFoWT5+QH7FZWc=
X-Received: by 2002:a05:6830:3149:b0:6ee:5560:4031 with SMTP id
 c9-20020a056830314900b006ee55604031mr12325242ots.38.1714981692603; Mon, 06
 May 2024 00:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502085636.4049-1-gavin.liu@mediatek.com>
In-Reply-To: <20240502085636.4049-1-gavin.liu@mediatek.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 6 May 2024 09:48:01 +0200
Message-ID: <CAHUa44GGzMQjrkFm4JRQ463wqOpZfzoo91TchK=PdH1Rt565pQ@mail.gmail.com>
Subject: Re: [PATCH v2] optee: add timeout value to optee_notif_wait() to
 support timeout
To: "gavin.liu" <gavin.liu@mediatek.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 10:56=E2=80=AFAM gavin.liu <gavin.liu@mediatek.com> =
wrote:
>
> From: Gavin Liu <gavin.liu@mediatek.com>
>
> Add timeout value to support self waking when timeout to avoid waiting
> indefinitely.
>
> Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
> ---
> Change in v2:
> Change commit message.
> Add description for value[0].c in optee_rpc_cmd.h.
> ---
> ---
>  drivers/tee/optee/notif.c         |  9 +++++++--
>  drivers/tee/optee/optee_private.h |  2 +-
>  drivers/tee/optee/optee_rpc_cmd.h |  1 +
>  drivers/tee/optee/rpc.c           | 10 ++++++++--
>  4 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> index 05212842b0a5..d5e5c0645609 100644
> --- a/drivers/tee/optee/notif.c
> +++ b/drivers/tee/optee/notif.c
> @@ -29,7 +29,7 @@ static bool have_key(struct optee *optee, u_int key)
>         return false;
>  }
>
> -int optee_notif_wait(struct optee *optee, u_int key)
> +int optee_notif_wait(struct optee *optee, u_int key, u32 timeout)
>  {
>         unsigned long flags;
>         struct notif_entry *entry;
> @@ -70,7 +70,12 @@ int optee_notif_wait(struct optee *optee, u_int key)
>          * Unlock temporarily and wait for completion.
>          */
>         spin_unlock_irqrestore(&optee->notif.lock, flags);
> -       wait_for_completion(&entry->c);
> +       if (timeout !=3D 0) {
> +               if (!wait_for_completion_timeout(&entry->c, timeout))
> +                       rc =3D -ETIMEDOUT;
> +       } else {
> +               wait_for_completion(&entry->c);
> +       }
>         spin_lock_irqsave(&optee->notif.lock, flags);
>
>         list_del(&entry->link);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index 7a5243c78b55..da990c4016ec 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -252,7 +252,7 @@ struct optee_call_ctx {
>
>  int optee_notif_init(struct optee *optee, u_int max_key);
>  void optee_notif_uninit(struct optee *optee);
> -int optee_notif_wait(struct optee *optee, u_int key);
> +int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
>  int optee_notif_send(struct optee *optee, u_int key);
>
>  u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_pa=
rams,
> diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_=
rpc_cmd.h
> index f3f06e0994a7..99342aa66263 100644
> --- a/drivers/tee/optee/optee_rpc_cmd.h
> +++ b/drivers/tee/optee/optee_rpc_cmd.h
> @@ -41,6 +41,7 @@
>   * Waiting on notification
>   * [in]    value[0].a      OPTEE_RPC_NOTIFICATION_WAIT
>   * [in]    value[0].b      notification value
> + * [in]    value[0].c      timeout in millisecond or 0 if no timeout

milliseconds

>   *
>   * Sending a synchronous notification
>   * [in]    value[0].a      OPTEE_RPC_NOTIFICATION_SEND
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index e69bc6380683..14e6246aaf05 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -130,6 +130,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct t=
ee_context *ctx,
>  static void handle_rpc_func_cmd_wq(struct optee *optee,
>                                    struct optee_msg_arg *arg)
>  {
> +       int rc =3D 0;
> +
>         if (arg->num_params !=3D 1)
>                 goto bad;
>
> @@ -139,7 +141,8 @@ static void handle_rpc_func_cmd_wq(struct optee *opte=
e,
>
>         switch (arg->params[0].u.value.a) {
>         case OPTEE_RPC_NOTIFICATION_WAIT:
> -               if (optee_notif_wait(optee, arg->params[0].u.value.b))
> +               rc =3D optee_notif_wait(optee, arg->params[0].u.value.b, =
arg->params[0].u.value.c);
> +               if (rc)
>                         goto bad;
>                 break;
>         case OPTEE_RPC_NOTIFICATION_SEND:
> @@ -153,7 +156,10 @@ static void handle_rpc_func_cmd_wq(struct optee *opt=
ee,
>         arg->ret =3D TEEC_SUCCESS;
>         return;
>  bad:
> -       arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> +       if (rc =3D=3D -ETIMEDOUT)
> +               arg->ret =3D TEEC_ERROR_BUSY;

TEEC_ERROR_BUSY is confusing. How about TEE_ERROR_TIMEOUT? We normally
only use TEEC_XXX error codes, but GP doesn't define a
TEEC_ERROR_TIMEOUT so it's better to use the GP-defined
TEE_ERROR_TIMEOUT.

Cheers,
Jens

> +       else
> +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
>  }
>
>  static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
> --
> 2.18.0
>

