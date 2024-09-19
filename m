Return-Path: <linux-kernel+bounces-333240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CC97C5C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0651F24832
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F635194C69;
	Thu, 19 Sep 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuHyWDCI"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89822198A30
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734409; cv=none; b=hU/KNQotLDf3gAuOL4Iqmd/lnJp+s32MgJIm3HUbUd08I0idZ9Lx9JJWikuEbc1gtfi5gfL3p5CSIR+TErPXMmidaslY4TrDpjmdn8msQ+xIKotGiHF384gR1hzxPOqk+HlLyC++wYh5lqJc7ilfE3kNEhaW6FXlDcP9fwpXS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734409; c=relaxed/simple;
	bh=SNnSe4+X9+S1zKkLqSUN/kNM3VzSGxHcNmVz8Sr0O1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg5nnI0yjnkVfN4+CQielY9CbwYeJ5PwuJTAQAhLVubCVwODjs/XpeP762wTiD80Duj0X1BZXaDdIROmpteIDR8xWp0zH1DmjbP1f2TTXO8cR5xGbwq7a3jEh7RhIQXUNX1Uct5fNr2yEEGOoY1Q8v+nlokJeKoLUP+KOPsTB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuHyWDCI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1101176a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726734406; x=1727339206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wMnmLpa5yTs94EHMp6Tjgq0ksZyXxBury+om39vf0fg=;
        b=QuHyWDCIz2gsEhYKSIeFWVH86Kb3RV9Qprt9yN2ABWYOJ4rQY0LRGXL0GMH/X9RUxX
         npDHWeE/it8VLOjqqKgyLTeA6I08daNMfuO24Dx21vKU4uyHKFhKw/ViCx+mbclFbM2x
         F0Tj2hDqxTg8DWCkLja/e8xfQlyRbbN2Lb3lB9kRyOMIOtV7Z0BBk6cWTghaeVAvio3v
         V6h+6F4ABR3VkDmTShVprIyM6QCpnThebH4UiyQGHNF5h0SQ9DfrL+0FC7dcxYbC6NLz
         OPtEak1rQqrK19jUwEcpflqnDTXLByaPzcWrP3TFW7gYgENPHhwAwfw/LzNTdb6Z0Zlo
         pHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734406; x=1727339206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMnmLpa5yTs94EHMp6Tjgq0ksZyXxBury+om39vf0fg=;
        b=ZDuonQe3AY/HaK/rDpBtxxLyFRvCAPFVKpSV3XzLAsPW0eUTpKaqbBbeX5FZnWN8JA
         f/kboyBMXTphtBlsrTqf4sMlR5ar9gVx7IwHwH6l6knvm4M+oSWibJ/28LUvxd/JbSaS
         pmKGiYoeMnS5fPI4Md8516Of9+pZydZaWnQmdZxV2Gbgl5UZc5sD9Qab1+1hVVFzEnJm
         SGQxmYT+DVx48Qksu6COVBoEwONfcdEYWSIyeXV0KDN9d4EhWuUAjJwtgej9AFSzy6IE
         6w94eMEfFtqIdesNG9OwT6DJ0ZiG91Qv61eau0EcwURWNTHpJrKck5G5Ecs3SSoc6I4U
         S7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVoYWsthl/wn0L/wGhIvdUWE1hsr7O8GEo3+GrE25Z1/ecT+lhl+LSb5hOHdPRAevzGf9le+v4+tazQrt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3ojPnqGp74F0KxVzRvnJVA55T8lOKZpA8wtPVBmBW5aNVjeq
	LehcwJfQjkGhhzrEodX5NjA5QNECVgt48/uAIdRs563cSD0QcG/Xavj4kbjXieq5TbQxobKjaHt
	YBWbIkjwCOGLlxW6WrktfTwrb4j+Xm9SN8w4a3Q==
X-Google-Smtp-Source: AGHT+IEr9Qngg/re7gFblpHj6r38UjAORdeHgAt3MkjdRpw63qPyVRuVO1/VeRmL1KzoAhdtm+FssF4bjg2tVckZedM=
X-Received: by 2002:a05:6402:430b:b0:5c3:cc44:570a with SMTP id
 4fb4d7f45d1cf-5c459205a2emr2214529a12.2.1726734405755; Thu, 19 Sep 2024
 01:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916083131.2801755-1-s-vadapalli@ti.com> <CANLsYkwTYqfAi+OFg3khMs7VD_PnL=CH-k8HXE71QSdqpR1fvA@mail.gmail.com>
 <fda85c12-e73f-44b8-b66b-1241e417a9b7@ti.com> <CANLsYky1Oxu7Fc1-gz53cR+KpO67nDE5LQGj_NV+czOwY2_2CA@mail.gmail.com>
 <3ca4b2d1-5c47-4f85-969d-cd61c7ade2dc@ti.com>
In-Reply-To: <3ca4b2d1-5c47-4f85-969d-cd61c7ade2dc@ti.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 19 Sep 2024 02:26:34 -0600
Message-ID: <CANLsYkyDro+mDe1c-xB5-ABcoZOHa=iyMUZ9kjD+p4hpEZO=fw@mail.gmail.com>
Subject: Re: [RFC PATCH] remoteproc: k3-r5: Fix check performed in k3_r5_rproc_{mbox_callback/kick}
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>, 
	andersson@kernel.org, b-padhi@ti.com, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	srk@ti.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 03:13, Kumar, Udit <u-kumar1@ti.com> wrote:
>
> Hi Mathieu,
>
> On 9/17/2024 2:07 PM, Mathieu Poirier wrote:
> > On Mon, 16 Sept 2024 at 23:20, Kumar, Udit <u-kumar1@ti.com> wrote:
> >> On 9/16/2024 8:50 PM, Mathieu Poirier wrote:
> >>> On Mon, 16 Sept 2024 at 02:31, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> >>>> Commit f3f11cfe8907 ("remoteproc: k3-r5: Acquire mailbox handle during
> >>>> probe routine") introduced a check in the "k3_r5_rproc_mbox_callback()" and
> >>>> "k3_r5_rproc_kick()" callbacks, causing them to exit if the remote core's
> >>>> state is "RPROC_DETACHED". However, the "__rproc_attach()" function that is
> >>>> responsible for attaching to a remote core, updates the state of the remote
> >>>> core to "RPROC_ATTACHED" only after invoking "rproc_start_subdevices()".
> >>>>
> >>>> The "rproc_start_subdevices()" function triggers the probe of the Virtio
> >>>> RPMsg devices associated with the remote core, which require that the
> >>>> "k3_r5_rproc_kick()" and "k3_r5_rproc_mbox_callback()" callbacks are
> >>>> functional. Hence, drop the check in the callbacks.
> >>> Honestly, I am very tempted to just revert f3f11cfe8907 and ea1d6fb5b571.
> >>
> >> Please don't :) , it will break rproc in general for k3 devices.
> >>
> > Why not - it is already broken anyway.  Reverting the patches will
> > force TI to actually think about the feature in terms of design,
> > completeness and testing.  The merge window opened on Sunday - I'm not
> > going to merge whack-a-mole patches and hope the right fix comes
> > along.
>
> Now, I am not advocating here to revert or not.
>
> But where we stand currently
>
> 1-  Without this patch, IPC is broken in general.
>
> 2-  With this patch, IPC is conditionally broken.
>
> In either case, we need to fix it.
>
> your call to revert or keep it.
>

I will keep f3f11cfe8907 and ea1d6fb5b571 but will not take this one
because 1) we are in the merge window and 2) I have no assurance that
this is the right (and complete) fix.

>
> >
> >> Couple of solutions for this race around condition (in mine preference
> >> order)
> >>
> > This is for the TI team to discuss _and_ test thoroughly.  From hereon
> > and until I see things improve, all patches from TI will need to be
> > tagged with R-B and T-B tags (collected on the mailing lists) from two
> > different individuals before I look at them.
>
> Sure we will take care of above
>
> and fair ask on R-B and T-B tags
>
> >
> >> 1) In
> >> https://elixir.bootlin.com/linux/v6.11/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L190
> >> have a check , if probe in is progress or not
> >>
> >> 2)
> >> https://elixir.bootlin.com/linux/v6.11/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L1205
> >> -- correct the state to ON or something else
> >>
> >> 3) Move condition
> >> https://elixir.bootlin.com/linux/v6.11/source/drivers/remoteproc/remoteproc_core.c#L1360
> >> before rproc_start_subdevices
> >> <https://elixir.bootlin.com/linux/v6.11/C/ident/rproc_start_subdevices>
> >> calling
> >>
> >>
> >>
> >>>> Fixes: f3f11cfe8907 ("remoteproc: k3-r5: Acquire mailbox handle during probe routine")
> >>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >>>> ---
> >>>>
> >>>> Hello,
> >>>>
> >>>> Since the commit being fixed is not yet a part of Mainline Linux, this
> >>>> patch is based on linux-next tagged next-20240913.
> >>>>
> >>>> An alternative to this patch will be a change to the "__rproc_attach()"
> >>>> function in the "remoteproc_core.c" driver with
> >>>> rproc->state = RPROC_ATTACHED;
> >>>> being set after "rproc_attach_device()" is invoked, but __before__
> >>>> invoking "rproc_start_subdevices()". Since this change will be performed
> >>>> in the common Remoteproc Core, it appeared to me that fixing it in the
> >>>> TI remoteproc driver is the correct approach.
> >>>>
> >>>> The equivalent of this patch for ti_k3_dsp_remoteproc.c might also be
> >>>> required, which I shall post if the current patch is acceptable.
> >>>>
> >>>> Kindly review and share your feedback on this patch.
> >>>>
> >>>> Regards,
> >>>> Siddharth.
> >>>>
> >>>>    drivers/remoteproc/ti_k3_r5_remoteproc.c | 8 --------
> >>>>    1 file changed, 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >>>> index 747ee467da88..4894461aa65f 100644
> >>>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >>>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >>>> @@ -194,10 +194,6 @@ static void k3_r5_rproc_mbox_callback(struct mbox_client *client, void *data)
> >>>>           const char *name = kproc->rproc->name;
> >>>>           u32 msg = omap_mbox_message(data);
> >>>>
> >>>> -       /* Do not forward message from a detached core */
> >>>> -       if (kproc->rproc->state == RPROC_DETACHED)
> >>>> -               return;
> >>>> -
> >>>>           dev_dbg(dev, "mbox msg: 0x%x\n", msg);
> >>>>
> >>>>           switch (msg) {
> >>>> @@ -233,10 +229,6 @@ static void k3_r5_rproc_kick(struct rproc *rproc, int vqid)
> >>>>           mbox_msg_t msg = (mbox_msg_t)vqid;
> >>>>           int ret;
> >>>>
> >>>> -       /* Do not forward message to a detached core */
> >>>> -       if (kproc->rproc->state == RPROC_DETACHED)
> >>>> -               return;
> >>>> -
> >>>>           /* send the index of the triggered virtqueue in the mailbox payload */
> >>>>           ret = mbox_send_message(kproc->mbox, (void *)msg);
> >>>>           if (ret < 0)
> >>>> --
> >>>> 2.40.1
> >>>>

