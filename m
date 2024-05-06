Return-Path: <linux-kernel+bounces-169499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBFB8BC990
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549F1B21CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7546CDAC;
	Mon,  6 May 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHZwLGq/"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBB13BB27
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984221; cv=none; b=oRaTbAvH9EZInto6lciv8bMcqtA7ma+RbkSC2bYjYpT+kzgjUHDaSBPlM5gUL7lRVWfl/2DO6vjkbidwYHuGAQE7A/+kEj+fwX++9nm2OeFRoW+b5zU4eXOHXM243DSLYipYEl1QzMfh3UEV7WVcrjfDYJ+dutVXQDtvwyfdu+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984221; c=relaxed/simple;
	bh=xoSxoJDMM1Ior0CMOP9baMuko8lLGpFTmRexuB3L00o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOMM7Lg8feAqqRW2++tmnX7rLh4qj5uW+VLT4RDn9knm7sQ178eN/z2LWLzStf9xqTyz6lstMclApDDe6E/ZLExzt5UM8qobeJ58QCJElYLSOyH1IqddmpTvsvhFohkOHW4aFTw9JX40ZTQ6WnpflcMBN82j+FL4vpf9+OotAmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zHZwLGq/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5af03aa8814so1364872eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714984219; x=1715589019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyWYdlp3gwORdcMp3ea1vox51Jn/y1NJTimMt8/PF3g=;
        b=zHZwLGq/WNZc3UkUGa7YsMDqO4na7rvnaxBXYTjP9ExWIRKn6hWlEULz8DT+92ym5X
         Y3dw4vebELr6GOxLwafhSFWe3IxHhZXauo5d0PDhU8IaXoiu7AwpUOpXsJAjocrdFOtR
         VtSjg6xDVWYt6uBxtm9Lh0Co33DoIIICO617TjVsu0FuWfi1EG/WTncC1lTJNJq5Ex9D
         9I++D5QkIXL0oMcNKrZ0u9xpaXd8i+yLhf96OAr2/0xYZuUyYBJlIRa6BDUEu4TZZAuu
         o6ptBZunHTV91kR98VXPmSAtVSE3bYtuVVgQmSDJkLcUN4opQmzbnTJpqeZwPSQxPgIv
         Nh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714984219; x=1715589019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyWYdlp3gwORdcMp3ea1vox51Jn/y1NJTimMt8/PF3g=;
        b=tcWNLXwGEekEKlH4i8tXUa9QvSTiOty8oLDO3CQHVWQyRUakJDR3g5X3d9x+O06LbQ
         S3eWfGsQha8LOF7oyUJmAUXMToq0wzgYRWSWbRIIQ5t4I9xbttgxt4DOOchlW6gaFl0d
         vN/f8YXJ8dcllO6JeabD+3qAqA32L+k7ExgSTA64KgTZW3gTENivdAoldsHlvuRQSXbA
         7SX3QdOpVWz4vuLoHTwrYziDVwho/nyjP6bQn32ZeLXKt+nG11GL6GyxZgzShDimwR+3
         vJ1XiD+LSJdcymwO5wOQES9mew44iQXhZPAxnGrZ5CQwyR6gT3JkecuL3dqbTmntB3TR
         g6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1oSwciXLsPEaH2FueJNVqrLBDrtSL55MnrrQS/QnzTDplaPjf3hZdoNjBW9zqOt5r2/p9vR+AL5aITMpM/ZSwPbPWgCRyheseOvcx
X-Gm-Message-State: AOJu0YwK96ppJr5P9IbFSWV9JS0UTd3BQDMWc8t4twPlUB9mSNH0tm0/
	+RgB6/zub7HPTfSUE/lqaDZPpltoJf0zP68dt14j6eBA7iG4x2WRGx4TRYEJcuT+kVxw2b0DKt4
	QKgeUMUjFZ8O0oBBghqMB/dSFLB2uYPqhosPOxQ==
X-Google-Smtp-Source: AGHT+IFgsl0ENznxWP6Gtdy7tlgh4rQRQQiUH+qwCU8fG9nnDy5PFbqVHodTCkuxicxfqPjIcgLlVkVVSN4CsVK/fIA=
X-Received: by 2002:a4a:4b82:0:b0:5a4:9977:446b with SMTP id
 q124-20020a4a4b82000000b005a49977446bmr8922876ooa.6.1714984218929; Mon, 06
 May 2024 01:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502085636.4049-1-gavin.liu@mediatek.com> <CAHUa44GGzMQjrkFm4JRQ463wqOpZfzoo91TchK=PdH1Rt565pQ@mail.gmail.com>
 <a14c567b4528840ab77c9f3faf19afc6c40f62cc.camel@mediatek.com>
In-Reply-To: <a14c567b4528840ab77c9f3faf19afc6c40f62cc.camel@mediatek.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 6 May 2024 10:30:06 +0200
Message-ID: <CAHUa44G86Hg3BeRRvGvBOyOu4w0FryvDC4bMacW65J7uQuMG5g@mail.gmail.com>
Subject: Re: [PATCH v2] optee: add timeout value to optee_notif_wait() to
 support timeout
To: =?UTF-8?B?R2F2aW4gTGl1ICjlionlk7Llu7cp?= <Gavin.Liu@mediatek.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"sumit.garg@linaro.org" <sumit.garg@linaro.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 10:19=E2=80=AFAM Gavin Liu (=E5=8A=89=E5=93=B2=E5=BB=
=B7) <Gavin.Liu@mediatek.com> wrote:
>
> Hi Jens,
>
> Thanks for the reviews.
>
> On Mon, 2024-05-06 at 09:48 +0200, Jens Wiklander wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Thu, May 2, 2024 at 10:56=E2=80=AFAM gavin.liu <gavin.liu@mediatek.=
com>
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
> > > Change in v2:
> > > Change commit message.
> > > Add description for value[0].c in optee_rpc_cmd.h.
> > > ---
> > > ---
> > >  drivers/tee/optee/notif.c         |  9 +++++++--
> > >  drivers/tee/optee/optee_private.h |  2 +-
> > >  drivers/tee/optee/optee_rpc_cmd.h |  1 +
> > >  drivers/tee/optee/rpc.c           | 10 ++++++++--
> > >  4 files changed, 17 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> > > index 05212842b0a5..d5e5c0645609 100644
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
> > > index 7a5243c78b55..da990c4016ec 100644
> > > --- a/drivers/tee/optee/optee_private.h
> > > +++ b/drivers/tee/optee/optee_private.h
> > > @@ -252,7 +252,7 @@ struct optee_call_ctx {
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
> > > index f3f06e0994a7..99342aa66263 100644
> > > --- a/drivers/tee/optee/optee_rpc_cmd.h
> > > +++ b/drivers/tee/optee/optee_rpc_cmd.h
> > > @@ -41,6 +41,7 @@
> > >   * Waiting on notification
> > >   * [in]    value[0].a      OPTEE_RPC_NOTIFICATION_WAIT
> > >   * [in]    value[0].b      notification value
> > > + * [in]    value[0].c      timeout in millisecond or 0 if no
> > timeout
> >
> > milliseconds
>
> Ok, I'll change it.
>
> >
> > >   *
> > >   * Sending a synchronous notification
> > >   * [in]    value[0].a      OPTEE_RPC_NOTIFICATION_SEND
> > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > index e69bc6380683..14e6246aaf05 100644
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
> > > +               arg->ret =3D TEEC_ERROR_BUSY;
> >
> > TEEC_ERROR_BUSY is confusing. How about TEE_ERROR_TIMEOUT? We
> > normally
> > only use TEEC_XXX error codes, but GP doesn't define a
> > TEEC_ERROR_TIMEOUT so it's better to use the GP-defined
> > TEE_ERROR_TIMEOUT.
> >
> > Cheers,
> > Jens
> >
>
> Agreed, we also use TEE_ERROR_TIMEOUT in the corresponding patch for
> optee-os. But, the "TEE_ERROR_TIMEOUT" is currently undefined in Linux
> Kernel. Do you have a suggestion for which header would be better to
> place it in?

Please put it in drivers/tee/optee/optee_private.h below
TEEC_ERROR_SHORT_BUFFER with a comment that it's from the GP TEE
Internal Core API Specification.

Cheers,
Jens

