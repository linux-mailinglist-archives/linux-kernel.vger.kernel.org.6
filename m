Return-Path: <linux-kernel+bounces-187097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383C88CCD14
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1F8B209D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0113C9D2;
	Thu, 23 May 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2BQCtOQ"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58E3B29D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449709; cv=none; b=olItq0MFhhJ7w23rxdntjT4l+TlTm9iZz4ni3Brv279bN5a//7gKlXkAuvKQyArTHoOgJVmM1iFwUyg3LrIhXhV2HHMXil3pDZV88EyOjVYU5Bsv28blOI1DUXb8qkNn3V+csrqFWXsjXQioxDplec5P8TBObs39rAdgPCuKKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449709; c=relaxed/simple;
	bh=mfkJjjvi4JkPLQq6sLIpan5jpujSxOE1mQ/MIuk2o/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTKCFZZWpwwy3PZlcs+VA6MIOq1kmbZcDMjctvsHEo73wLL1H2uD0aSxpdyei8ot158uFJx1xXX2w4zpuCd708/zU3gvc/3ZXZ5VY+fod/c6CO37M5klwR/uZiFtL6RztIkI1q2Nzlq9Sy1dakGMJZYVxMAizF/vUdjIuG6+MQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2BQCtOQ; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47f008106d0so1875862137.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716449706; x=1717054506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YGZE1m+x9SPS6iVgqx8jcKt9Av6k4v6WXfZY3xI6v0=;
        b=c2BQCtOQazZCKldSYq39l11jRr4BfejH6APGTFj4RrmaLyKuSzk+uxR5+RD+iw8bnw
         pl5xL9ZAy6wFrhoG5YMlqzaPWIVHizcNtID6hG+QFtxmNdpUEQSzkyw+q982MpkDi8fr
         uK9Ybm5t4HTM0X9rdccr5aDkKljmawggtxOyLxuiK1A3x3bUAuJE6Npm26aaFDdCPmeW
         3PXUuHynTSg7ca3vC+ZfsnTDGCrwGkcCOqQyQvEVf5X+RcJ7xkyA9R6A42xAort4EfzB
         GIg6nRmku8QA1TrwrNTvJnwQNAc/082OADQ7s+st8Xj7G/18IH0gTY8n4PhJ92LFIhh2
         W1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716449706; x=1717054506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YGZE1m+x9SPS6iVgqx8jcKt9Av6k4v6WXfZY3xI6v0=;
        b=F5KKffc/FtEWiD3dMkw7QG1UtQ/whq9A8QghhqgY5xOxSULI5/kthwP5rMtG/lHNx7
         q/+DVyTC0kPjDwOCU9Xw2j7MYmf1PLKHEZ6ftGthrr8kFc82tCKWFHMbtWQZYKp/2YH9
         fCeTdTivXUjudhDfIed9dSeFxUcnCPrXN6wAhI2f0HTVTIL2JaTm7+c8xgHQx4AUGmVq
         MVXIM9hTHmt36WcfLtVrLoLHvdRFSy7EkqrhwONCP0wqvdo1pElRFiCkDxGqTkJk9ANM
         0QKwHtrxrGx0l39m+W+wtNviaXbTTaA/q1FZssqXScluPanijZPIN1iowGQZ5cmZHJlI
         Kggw==
X-Forwarded-Encrypted: i=1; AJvYcCXVGAhUqbBvl4fZn7/6MEDgK5UWu+u3RJdzwC4FtYsMOx1/L8qpAj97Fda2AFvVooZ1KrEBtj4su4psPmKrfgfoqIBRqZB7V3lP6GC3
X-Gm-Message-State: AOJu0YzLw4LQfpqARGHRRBu/BlIhEEkkBsYOPs7zUgMg7OTCmowA0v83
	ihKARvWiRoLpB1iGlq4Wz7C8jrI/rOtaxbjQ0Wphou7ba+gpLsUzL6mz05WNVn8EAEQ2LwNPCVc
	wRhXsKzrlu/2ncA4eWTHgSGKcNzwrJkHfpZ/8LZmSHc3D61xvrqQ=
X-Google-Smtp-Source: AGHT+IF/CSc5xjoYFx79kNTBwY+/NdcvlEoBwd2+PDUny1z5QczOFReKI/K8sM3AzJP71Jl/QyWKbKTbbAGYaPdTa1g=
X-Received: by 2002:a05:6102:3050:b0:47b:dcda:79df with SMTP id
 ada2fe7eead31-489077ce87amr4966258137.19.1716449706032; Thu, 23 May 2024
 00:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507020037.14009-1-gavin.liu@mediatek.com>
 <CAFA6WYN79E8Hyxsaxu20hkyNebMqBWV7az5ByekTuii7Y7qjng@mail.gmail.com> <929512b561536d4ddfaeda518f2ce306b899f3a9.camel@mediatek.com>
In-Reply-To: <929512b561536d4ddfaeda518f2ce306b899f3a9.camel@mediatek.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 23 May 2024 13:04:55 +0530
Message-ID: <CAFA6WYNRVa_oem2TdyjoaUOTmW+vED-7LOC4wFjqG+puptg8tQ@mail.gmail.com>
Subject: Re: [PATCH v3] optee: add timeout value to optee_notif_wait() to
 support timeout
To: =?UTF-8?B?R2F2aW4gTGl1ICjlionlk7Llu7cp?= <Gavin.Liu@mediatek.com>
Cc: "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 May 2024 at 14:16, Gavin Liu (=E5=8A=89=E5=93=B2=E5=BB=B7) <Gavi=
n.Liu@mediatek.com> wrote:
>
> Hi, Sumit,
>
> The corresponding OPTEE-OS pull request and change is here.
>
> https://github.com/OP-TEE/optee_os/pull/6641

As this is an ABI change where I see backwards compatibility is
maintained. However, the forwards compatibility requires this change
to be backported to stable releases. So for the next version please CC
stable ML.

>
> On Mon, 2024-05-20 at 16:16 +0530, Sumit Garg wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Hi,
> >
> > On Tue, 7 May 2024 at 07:31, gavin.liu <gavin.liu@mediatek.com>
> > wrote:
> > >
> > > From: Gavin Liu <gavin.liu@mediatek.com>
> > >
> > > Add timeout value to support self waking when timeout to avoid
> > waiting
> > > indefinitely.
> > >
> > > Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
> > > ---
> > > change in v3:
> > > 1. change the comment in optee_rpc_cmd.h
> > > 2. add macro for "TEE_ERROR_TIMEOUT"
> > > 3. change from "TEEC_ERROR_BUSY" to "TEE_ERROR_TIMEOUT"
> > > ---
> > >  drivers/tee/optee/notif.c         |  9 +++++++--
> > >  drivers/tee/optee/optee_private.h |  5 ++++-
> > >  drivers/tee/optee/optee_rpc_cmd.h |  1 +
> > >  drivers/tee/optee/rpc.c           | 10 ++++++++--
> > >  4 files changed, 20 insertions(+), 5 deletions(-)
> > >

FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> >
> > > diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> > > index 0d7878e770cd..1970880c796f 100644
> > > --- a/drivers/tee/optee/notif.c
> > > +++ b/drivers/tee/optee/notif.c
> > > @@ -29,7 +29,7 @@ static bool have_key(struct optee *optee, u_int
> > key)
> > >         return false;
> > >  }
> > >
> > > -int optee_notif_wait(struct optee *optee, u_int key)
> > > +int optee_notif_wait(struct optee *optee, u_int key, u32 timeout)
> > >  {
> > >         unsigned long flags;
> > >         struct notif_entry *entry;
> > > @@ -70,7 +70,12 @@ int optee_notif_wait(struct optee *optee, u_int
> > key)
> > >          * Unlock temporarily and wait for completion.
> > >          */
> > >         spin_unlock_irqrestore(&optee->notif.lock, flags);
> > > -       wait_for_completion(&entry->c);
> > > +       if (timeout !=3D 0) {
> > > +               if (!wait_for_completion_timeout(&entry->c,
> > timeout))
> > > +                       rc =3D -ETIMEDOUT;
> > > +       } else {
> > > +               wait_for_completion(&entry->c);
> > > +       }
> > >         spin_lock_irqsave(&optee->notif.lock, flags);
> > >
> > >         list_del(&entry->link);
> > > diff --git a/drivers/tee/optee/optee_private.h
> > b/drivers/tee/optee/optee_private.h
> > > index 429cc20be5cc..424898cdc4e9 100644
> > > --- a/drivers/tee/optee/optee_private.h
> > > +++ b/drivers/tee/optee/optee_private.h
> > > @@ -26,6 +26,9 @@
> > >  #define TEEC_ERROR_BUSY                        0xFFFF000D
> > >  #define TEEC_ERROR_SHORT_BUFFER                0xFFFF0010
> > >
> > > +/* API Return Codes are from the GP TEE Internal Core API
> > Specification */
> > > +#define TEE_ERROR_TIMEOUT              0xFFFF3001
> > > +
> > >  #define TEEC_ORIGIN_COMMS              0x00000002
> > >
> > >  /*
> > > @@ -252,7 +255,7 @@ struct optee_call_ctx {
> > >
> > >  int optee_notif_init(struct optee *optee, u_int max_key);
> > >  void optee_notif_uninit(struct optee *optee);
> > > -int optee_notif_wait(struct optee *optee, u_int key);
> > > +int optee_notif_wait(struct optee *optee, u_int key, u32 timeout);
> > >  int optee_notif_send(struct optee *optee, u_int key);
> > >
> > >  u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t
> > num_params,
> > > diff --git a/drivers/tee/optee/optee_rpc_cmd.h
> > b/drivers/tee/optee/optee_rpc_cmd.h
> > > index f3f06e0994a7..4576751b490c 100644
> > > --- a/drivers/tee/optee/optee_rpc_cmd.h
> > > +++ b/drivers/tee/optee/optee_rpc_cmd.h
> > > @@ -41,6 +41,7 @@
> > >   * Waiting on notification
> > >   * [in]    value[0].a      OPTEE_RPC_NOTIFICATION_WAIT
> > >   * [in]    value[0].b      notification value
> > > + * [in]    value[0].c      timeout in milliseconds or 0 if no
> > timeout
> > >   *
> > >   * Sending a synchronous notification
> > >   * [in]    value[0].a      OPTEE_RPC_NOTIFICATION_SEND
> > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > index f086812f1179..5de4504665be 100644
> > > --- a/drivers/tee/optee/rpc.c
> > > +++ b/drivers/tee/optee/rpc.c
> > > @@ -130,6 +130,8 @@ static void
> > handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > >  static void handle_rpc_func_cmd_wq(struct optee *optee,
> > >                                    struct optee_msg_arg *arg)
> > >  {
> > > +       int rc =3D 0;
> > > +
> > >         if (arg->num_params !=3D 1)
> > >                 goto bad;
> > >
> > > @@ -139,7 +141,8 @@ static void handle_rpc_func_cmd_wq(struct optee
> > *optee,
> > >
> > >         switch (arg->params[0].u.value.a) {
> > >         case OPTEE_RPC_NOTIFICATION_WAIT:
> > > -               if (optee_notif_wait(optee, arg-
> > >params[0].u.value.b))
> > > +               rc =3D optee_notif_wait(optee, arg-
> > >params[0].u.value.b, arg->params[0].u.value.c);
> > > +               if (rc)
> > >                         goto bad;
> > >                 break;
> > >         case OPTEE_RPC_NOTIFICATION_SEND:
> > > @@ -153,7 +156,10 @@ static void handle_rpc_func_cmd_wq(struct
> > optee *optee,
> > >         arg->ret =3D TEEC_SUCCESS;
> > >         return;
> > >  bad:
> > > -       arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > > +       if (rc =3D=3D -ETIMEDOUT)
> > > +               arg->ret =3D TEE_ERROR_TIMEOUT;
> > > +       else
> > > +               arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > >  }
> > >
> > >  static void handle_rpc_func_cmd_wait(struct optee_msg_arg *arg)
> > > --
> > > 2.18.0
>
> Regards,
> Gavin Liu
> > >
>
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including it=
s
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or beli=
eve
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

This text is not meant for public mailing lists. So please work with
your IT team to allow you to post to public mailing lists without this
text.

-Sumit

