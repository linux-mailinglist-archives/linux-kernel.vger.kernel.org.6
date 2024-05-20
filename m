Return-Path: <linux-kernel+bounces-183625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BA8C9B96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917E828185E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CE751033;
	Mon, 20 May 2024 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwzE5puQ"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3752032B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202002; cv=none; b=hhFDgydNdSN86Pv/aeJuf3oX0GZILp8TCvnkzE+lGYVe63p0kv99FxR6g5U7xEALn+hhKCbOYZ+IkFT4GQc+eVaxWbmb+xVb3cwbP+ZQiBjKC0uqLeuaGxn+SXkQgEimyG9R0WITRBpPx2c7gr7rT/Zb6i8XV1chN203AZUFlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202002; c=relaxed/simple;
	bh=80rOhUtCjGJAkUN+JCKOj861Wv+945SJrqZxQcl5e4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvEPryoqY2JoFFVJ+vCaB5p9ZFfYiXThl9MmkDussEeO0vRS1U3A8M4PaATyPMrV42HTGiKzc+FLS0ykBAgNuLAf71TZwkXS7+AAk4BP5JkiEMfFK8Z5bq6cUO1KIbsFxB3/M5ljvu7jr7uR/tTtP3aHGr9DEUUjNElPTneuNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BwzE5puQ; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7f18331b308so830829241.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 03:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716201999; x=1716806799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=33VnrnZQnXRRdfZfVThbMcf3rBaLFM2cLbyWTGtXaGE=;
        b=BwzE5puQnT3a89SQTpWynWALWrpjoHeteQOa4kBQrXmGhEZAiTjYoAanO/lxaNwm5P
         D9UieL3h+D+gbeU2HPszGAACd7CJd/szrzLwwAUGbrYghHQFK2pEnlcGf18g6IfN/AWQ
         PV24YTtHxOZZPrQDEbz28BIPEc/6NvHrjGnskBugQj9X3ckCzpPE6XfuV7KNW7I5nKRj
         EnnPj0pkZ/5alJyHxlYlXbeMvwqh/Pl+dgu+m+NUhGpM6ull90sHwa7MKsQoQV774lTN
         ZzXFlgtu4SzXcVgGL0J5swyVXp92fmFW4OJ3RoTX4TYErmUsX1gadvpCNITluKcvqq6k
         g9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716201999; x=1716806799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33VnrnZQnXRRdfZfVThbMcf3rBaLFM2cLbyWTGtXaGE=;
        b=Cr69XIKROIBT6c9ayn2H3mCffG0Nh2qaOyOxoVoaePos30QomSYOoVYm8PfKGdxic/
         6MR3dSeWttJyeQKoP7gqj/CwiN+uoSZ8kdZruf6pOKo+WRsOMFeUvdZefOx7GKF5j5QZ
         yzTSn5413OIvoApuGe0wCMcEtqOW0IOtspUM0IrBV5L4RrxYIiVEYK51z18D4YqbN13D
         ZsJ3u4VT608BPug8816WHvXL/6UJyvD/u9H+F0vflD7QYe46dPISK4cOCcRZ89XWkaj2
         jv55iVmP1Z5ptDsxmurQZqcHv1fIJA6m3g9VJayzTR02lqNVzEnJti/4Feh6xLFqub7v
         +UMw==
X-Forwarded-Encrypted: i=1; AJvYcCVNRxbf40nwe+r6uTcWzlUBPWCJkKxPYRGksvVovT0JhHI3cxlt505J8PBgeYONauviZx+qEmLnJhMQStyG1dT42k+KPCDMqEoWewBm
X-Gm-Message-State: AOJu0Yx3Vua1eNJ5fZx6riboTtT/YU2SyGtJr/XqE9pUoXH4LGf1te7Y
	X5phWs3PPYNZeK4w53LpLJH1k6oSIfoKgpZye39gEk04pzNFm+PN6xu7ea4M1F0hrjI3GrKXrZD
	GKhmvhd9kqsbYN/Yks+m+FbPNoA5EOfwcfk8BTQ==
X-Google-Smtp-Source: AGHT+IGs3xAJDCVogm4isgBXwwArR/oG+a8UL/2JuAU4s5nJywQAM3yVXZncptK/GUfVpwY1Us0rOwSRkd1XTe+hwz0=
X-Received: by 2002:a05:6102:3707:b0:47c:24fa:b627 with SMTP id
 ada2fe7eead31-48077de52e5mr31442181137.13.1716201999159; Mon, 20 May 2024
 03:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507020037.14009-1-gavin.liu@mediatek.com>
In-Reply-To: <20240507020037.14009-1-gavin.liu@mediatek.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 20 May 2024 16:16:28 +0530
Message-ID: <CAFA6WYN79E8Hyxsaxu20hkyNebMqBWV7az5ByekTuii7Y7qjng@mail.gmail.com>
Subject: Re: [PATCH v3] optee: add timeout value to optee_notif_wait() to
 support timeout
To: "gavin.liu" <gavin.liu@mediatek.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 7 May 2024 at 07:31, gavin.liu <gavin.liu@mediatek.com> wrote:
>
> From: Gavin Liu <gavin.liu@mediatek.com>
>
> Add timeout value to support self waking when timeout to avoid waiting
> indefinitely.
>
> Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
> ---
> change in v3:
> 1. change the comment in optee_rpc_cmd.h
> 2. add macro for "TEE_ERROR_TIMEOUT"
> 3. change from "TEEC_ERROR_BUSY" to "TEE_ERROR_TIMEOUT"
> ---
>  drivers/tee/optee/notif.c         |  9 +++++++--
>  drivers/tee/optee/optee_private.h |  5 ++++-
>  drivers/tee/optee/optee_rpc_cmd.h |  1 +
>  drivers/tee/optee/rpc.c           | 10 ++++++++--
>  4 files changed, 20 insertions(+), 5 deletions(-)
>

Although the change looks reasonable to me, can you point me to
corresponding OP-TEE OS changes to be sure that ABI compatibility is
maintained?

-Sumit

> diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> index 0d7878e770cd..1970880c796f 100644
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
> +       if (timeout != 0) {
> +               if (!wait_for_completion_timeout(&entry->c, timeout))
> +                       rc = -ETIMEDOUT;
> +       } else {
> +               wait_for_completion(&entry->c);
> +       }
>         spin_lock_irqsave(&optee->notif.lock, flags);
>
>         list_del(&entry->link);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 429cc20be5cc..424898cdc4e9 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -26,6 +26,9 @@
>  #define TEEC_ERROR_BUSY                        0xFFFF000D
>  #define TEEC_ERROR_SHORT_BUFFER                0xFFFF0010
>
> +/* API Return Codes are from the GP TEE Internal Core API Specification */
> +#define TEE_ERROR_TIMEOUT              0xFFFF3001
> +
>  #define TEEC_ORIGIN_COMMS              0x00000002
>
>  /*
> @@ -252,7 +255,7 @@ struct optee_call_ctx {
>
>  int optee_notif_init(struct optee *optee, u_int max_key);
>  void optee_notif_uninit(struct optee *optee);
> -int optee_notif_wait(struct optee *optee, u_int key);
> +int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
>  int optee_notif_send(struct optee *optee, u_int key);
>
>  u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
> diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_cmd.h
> index f3f06e0994a7..4576751b490c 100644
> --- a/drivers/tee/optee/optee_rpc_cmd.h
> +++ b/drivers/tee/optee/optee_rpc_cmd.h
> @@ -41,6 +41,7 @@
>   * Waiting on notification
>   * [in]    value[0].a      OPTEE_RPC_NOTIFICATION_WAIT
>   * [in]    value[0].b      notification value
> + * [in]    value[0].c      timeout in milliseconds or 0 if no timeout
>   *
>   * Sending a synchronous notification
>   * [in]    value[0].a      OPTEE_RPC_NOTIFICATION_SEND
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index f086812f1179..5de4504665be 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -130,6 +130,8 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  static void handle_rpc_func_cmd_wq(struct optee *optee,
>                                    struct optee_msg_arg *arg)
>  {
> +       int rc = 0;
> +
>         if (arg->num_params != 1)
>                 goto bad;
>
> @@ -139,7 +141,8 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
>
>         switch (arg->params[0].u.value.a) {
>         case OPTEE_RPC_NOTIFICATION_WAIT:
> -               if (optee_notif_wait(optee, arg->params[0].u.value.b))
> +               rc = optee_notif_wait(optee, arg->params[0].u.value.b, arg->params[0].u.value.c);
> +               if (rc)
>                         goto bad;
>                 break;
>         case OPTEE_RPC_NOTIFICATION_SEND:
> @@ -153,7 +156,10 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
>         arg->ret = TEEC_SUCCESS;
>         return;
>  bad:
> -       arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +       if (rc == -ETIMEDOUT)
> +               arg->ret = TEE_ERROR_TIMEOUT;
> +       else
> +               arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>  }
>
>  static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
> --
> 2.18.0
>

