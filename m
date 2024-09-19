Return-Path: <linux-kernel+bounces-333254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A334C97C5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D261F23EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AD21990B7;
	Thu, 19 Sep 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXr0krqp"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC774206D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734814; cv=none; b=mdpjrKvO61lZaMC0QKr3jiU45UiQmfN1Czb1b4JJ/iCNKVk74JMT2efUCsQWvHKriKZ146wjuXcRpCfBFCFsLZb5H1IAEazWx80WqpT4dnj4/Gmcn7nUhkJivj61Hl80QZx1PYv6ICs6++Tt1VYOGvjxDrD+ajbW+/FDk8eOD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734814; c=relaxed/simple;
	bh=5TqAiRX5QxSZiIA9tmSZyMJHtKKQS2wLgVd84sNypOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQYvax8wbrJN4pfARGEj06bgCpichB8CXE2fvzL3TrwgdYKlnYqfqa1cIovz34J5q99u23twnitsAo5XpBiTnAepflU1pNjC0+HiINWUahrX77oBgIu3eOLU0N8+5TKMQN9nhVEs2K+Vi1U8muTjWzidIRAj1WcDORiKewFRb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RXr0krqp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so698233a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726734811; x=1727339611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2tnZCK7YM8bSrHkiRrBzFB1W1hJ1nGVSf+dbrHUhPoQ=;
        b=RXr0krqpoT4BbZDENZsVfKtz3JqFMI81f0jJohYB9NRxc4wB9IQWGR+OXhJ8rOCCG0
         s057s+t2VtpeavrJ7elC1NJ8e5goCWrOFfJvT0AcSe6Ee9XlHIFZMgoFVy/T8f5csAE9
         LjpZwWQZZ8lfIOPfuqxSNf39xdqCXprg3l9TMtTt57kOh6+SswGmk+YmyklwsSWOYqqq
         uRhP0NJhjqeNgsgN+VJskCtIBQj7C7YsVRPRcULqeIxx2/KHpd8AbmKiZVLggzyo9BNy
         IQBH+FsojKUbiIaKXRgNcp/oyPkgxBfYasU7qX2WIrSEUqFxnw/8BCZu0zc7tQKupV7Q
         JnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734811; x=1727339611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tnZCK7YM8bSrHkiRrBzFB1W1hJ1nGVSf+dbrHUhPoQ=;
        b=dS46kaZ/mtyYcmydvCiXuTLb7ot78gaOwhQ6RNTRWvwScHHAjo1QQYClMS8EysTmug
         yLcgg0Qus8khteSUg15gvzf134+MXwZ06L6SDt0XUyzX5OtER8jRk8wazb4y/nsdZQsk
         IF3YKmmgjO76n3X/LHppW4az+/Hp8TggStxVCdaVMj0y2ryyVRBoDgOAsPgS/VfFVoNU
         T2F9gozMQLGYrIb0w1MTbMaceSNaPebh0NMJ7gILmww1Ni5nvl3jE+Zp8iKXekNphIHR
         9fQtIsQM1Jj94i2KfgeJ+rjrcm+urqAItcrALhlGL/D0YEVzGpm1SHm470Xp7O5b796V
         UrtA==
X-Forwarded-Encrypted: i=1; AJvYcCVfST4LQAnAdPpItW6WyKuHDgUH281BJo7R5a/374cjbvU9V8fwsBP7SfUsQVPXXhN7aRkLB/Eqw54heh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6Bv6ypoCUwioHDJ+7HVv26rI+hp1XlfDFO5tI5oVDN2bh1Ke
	ox66fUGW4APTJYIGnMJfrp3XCKGIkQTKcd5lj3E8nmh8uTJKHNxEDzpOmnV1xlQ6i+P8tbByNeP
	iifoEY5j3ZapnR7phS+pEHRf45pJPqaeiGo5wxY8CJC4TDqTbtTRfQw==
X-Google-Smtp-Source: AGHT+IFT0rDzXEzYcZMfSktK8K50rLXkJ7iGrTRgEHDzHf2hLBqkw5JFkKoBBhObwWWTnsUDsb5ymz0P+DOO7ViY1n4=
X-Received: by 2002:a05:6402:4406:b0:5c3:d8fd:9a49 with SMTP id
 4fb4d7f45d1cf-5c413e12224mr19755057a12.10.1726734810467; Thu, 19 Sep 2024
 01:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916083131.2801755-1-s-vadapalli@ti.com> <CANLsYkwTYqfAi+OFg3khMs7VD_PnL=CH-k8HXE71QSdqpR1fvA@mail.gmail.com>
 <fda85c12-e73f-44b8-b66b-1241e417a9b7@ti.com> <CANLsYky1Oxu7Fc1-gz53cR+KpO67nDE5LQGj_NV+czOwY2_2CA@mail.gmail.com>
 <c8b2e851-a247-4a90-acb5-a774d131b561@ti.com>
In-Reply-To: <c8b2e851-a247-4a90-acb5-a774d131b561@ti.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 19 Sep 2024 02:33:19 -0600
Message-ID: <CANLsYkwwoS-Gd+TcgEYj7ZgK8eepxChXfF4u5MU1tYdq0VyCVQ@mail.gmail.com>
Subject: Re: [RFC PATCH] remoteproc: k3-r5: Fix check performed in k3_r5_rproc_{mbox_callback/kick}
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
	Andrew Davis <afd@ti.com>, andersson@kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	srk@ti.com
Content-Type: text/plain; charset="UTF-8"

s

On Tue, 17 Sept 2024 at 03:40, Beleswar Prasad Padhi <b-padhi@ti.com> wrote:
>
> Hi Mathieu,
>
> On 17/09/24 14:07, Mathieu Poirier wrote:
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
>
> Apologies for causing this trouble, Mathieu. I have accumulated various
> use-cases of the driver, including this, and hereon will keep in mind
> while posting further patches.
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
>
> Understood, that is a fair ask. Hereon, I will also attach my test logs
> for all the usecases I've tested a patch with, to give more visibility
> on the testing done.
>

I am not in a position (nor have the time) to look at test logs and as
such, there is no point in doing that.  That time should be better
spent building a CI that goes through all the scenarios and making
sure that all patches pass the tests before being sent to the mailing
list.

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

