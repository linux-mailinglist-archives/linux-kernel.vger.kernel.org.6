Return-Path: <linux-kernel+bounces-331440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC597ACFE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065EAB2C533
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4476315AAD6;
	Tue, 17 Sep 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/+jwhXH"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA0158A13
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562248; cv=none; b=iQC7bWc0r3qdiY98ZsECaO1r9RAIO4xSaRaMn+OmmAyiPMn9wJKeoI5KISBQi1qnSIATvte2q6F9nJ38BsG0fnAsSRLW2gzXLI9um8KztBkEL4wCO+tItSVg/dvKG7hXUVx1ErobP3UjeWmtdqrMGu7CDUq34fMkqLQnwf7U2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562248; c=relaxed/simple;
	bh=vkTfWEv1p87r8ENqhmzFzFp3lqpgHtlSvjpfe4VSQWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBbXYb9LHA8E928/Om4Yyb6TBUXPbHhpWiyzPhlRo/iE91HSdlYgdzWF1LZE/U3/R6jhhHX410fzKGQqiBuUGziaxeKZGE3qPoMoNFjDwJdGL6YXhSal0cNXJtI64YB+MluoHK26wRShzXF9W+Tc61JGuovAkcFqC1J9LXwMFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/+jwhXH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c423d496abso2812665a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726562238; x=1727167038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7wFLbxZR/AUMoD3yFvr7pHF33BoVAx7GBIvilNEGlHw=;
        b=c/+jwhXHeSXaqnAWugsWtcDgnWLYZUhozH31aBPIiBmaI/gh+YkzV0QIYOQ2AJ/qGG
         x6DPE29QFFXBSOq+iwS8AJrz9UZotqdUQSZQel1XoQ1XfG752nmSrm69sH0vLIh/Lebk
         IwK96YgNOS9XqZ52axZ6h/BLauAaxdsZfQenqksQhj0Fv607tHx4ebE8M7yYNT+DBBFW
         Vn5UwEvI8mG4+LUA+FhS9HZX5sB5579/1qTZdFgLhL+zFKF8QU1PV6NoXUdxNtW9brs8
         BlTURs06g1IechTNO35vsK5qD7HkW5h9Rg4DyJFYdUnkpsEM8H4ZaaE7PD3bNV6btqJw
         /fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726562238; x=1727167038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wFLbxZR/AUMoD3yFvr7pHF33BoVAx7GBIvilNEGlHw=;
        b=uzduzF6vOB3eFVRs6MWQZ1RocF2FANpv4OFhkdtOH6cZfnlJU/Qf3LqKIjBFmANCCZ
         9WIbj+Yz/j9r0FxjyBVxkKbyhhWLj+dkvDStp3rgp5YvbY1ccV0LLH5WptBVg8hYBM9L
         IsJurKTrR25FoWWJJ7UyG+b9CZgEmONW8qhDaFuvI/dEZvaJxnI7t+X4s+PJg7Xf5J4U
         5mqwHPVzHbInvg6teWgDdivGOjcMhMoiGVLNJZf0rblbX5Sp/GAwlxrb40wnDncLaqDG
         r5zQ+NUXfwfELpQ5rqrDoixBySNgYvfP7UhqOe0UxFzbWlN0rCUVplfQRwyFzA/Ht64q
         C/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVnqbA5ovMju68eeBlgK/1tWF1BYcyjiW/gDdQOD5ZJ4Zy2Uu88rLo8q0C1V4J/ySOxmx48hI41xxVqSRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxxQ46p2f2/jMsoQPzKA/GEHkrFrD1f4vAWz8KZtPqemsPodH4
	tM8kVhAkFcf67U1WEOng8qr/xJnFYlQpj+x1s0X5xPK6XFLwsrkLNobCWSHUZIFF8MvqQITPdT3
	SZ385P9uTvTmEE25mTJTDOJ4M46HT2JFe2me2CA==
X-Google-Smtp-Source: AGHT+IFCcpyArmdqkZssE8o3eOmTVnWNAEAOEwL0jL2Mf21ARGUdRzigqaQPpatmalmg/h/zqJ+wN3fg+HwHHUgJbfY=
X-Received: by 2002:a05:6402:5108:b0:5c2:6311:c9d1 with SMTP id
 4fb4d7f45d1cf-5c41e1b5325mr20977024a12.22.1726562237988; Tue, 17 Sep 2024
 01:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916083131.2801755-1-s-vadapalli@ti.com> <CANLsYkwTYqfAi+OFg3khMs7VD_PnL=CH-k8HXE71QSdqpR1fvA@mail.gmail.com>
 <fda85c12-e73f-44b8-b66b-1241e417a9b7@ti.com>
In-Reply-To: <fda85c12-e73f-44b8-b66b-1241e417a9b7@ti.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 17 Sep 2024 02:37:05 -0600
Message-ID: <CANLsYky1Oxu7Fc1-gz53cR+KpO67nDE5LQGj_NV+czOwY2_2CA@mail.gmail.com>
Subject: Re: [RFC PATCH] remoteproc: k3-r5: Fix check performed in k3_r5_rproc_{mbox_callback/kick}
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>, 
	andersson@kernel.org, b-padhi@ti.com, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	srk@ti.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 23:20, Kumar, Udit <u-kumar1@ti.com> wrote:
>
> On 9/16/2024 8:50 PM, Mathieu Poirier wrote:
> > On Mon, 16 Sept 2024 at 02:31, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> >> Commit f3f11cfe8907 ("remoteproc: k3-r5: Acquire mailbox handle during
> >> probe routine") introduced a check in the "k3_r5_rproc_mbox_callback()" and
> >> "k3_r5_rproc_kick()" callbacks, causing them to exit if the remote core's
> >> state is "RPROC_DETACHED". However, the "__rproc_attach()" function that is
> >> responsible for attaching to a remote core, updates the state of the remote
> >> core to "RPROC_ATTACHED" only after invoking "rproc_start_subdevices()".
> >>
> >> The "rproc_start_subdevices()" function triggers the probe of the Virtio
> >> RPMsg devices associated with the remote core, which require that the
> >> "k3_r5_rproc_kick()" and "k3_r5_rproc_mbox_callback()" callbacks are
> >> functional. Hence, drop the check in the callbacks.
> > Honestly, I am very tempted to just revert f3f11cfe8907 and ea1d6fb5b571.
>
>
> Please don't :) , it will break rproc in general for k3 devices.
>

Why not - it is already broken anyway.  Reverting the patches will
force TI to actually think about the feature in terms of design,
completeness and testing.  The merge window opened on Sunday - I'm not
going to merge whack-a-mole patches and hope the right fix comes
along.

> Couple of solutions for this race around condition (in mine preference
> order)
>

This is for the TI team to discuss _and_ test thoroughly.  From hereon
and until I see things improve, all patches from TI will need to be
tagged with R-B and T-B tags (collected on the mailing lists) from two
different individuals before I look at them.

> 1) In
> https://elixir.bootlin.com/linux/v6.11/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L190
> have a check , if probe in is progress or not
>
> 2)
> https://elixir.bootlin.com/linux/v6.11/source/drivers/remoteproc/ti_k3_r5_remoteproc.c#L1205
> -- correct the state to ON or something else
>
> 3) Move condition
> https://elixir.bootlin.com/linux/v6.11/source/drivers/remoteproc/remoteproc_core.c#L1360
> before rproc_start_subdevices
> <https://elixir.bootlin.com/linux/v6.11/C/ident/rproc_start_subdevices>
> calling
>
>
>
> >
> >> Fixes: f3f11cfe8907 ("remoteproc: k3-r5: Acquire mailbox handle during probe routine")
> >> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >> ---
> >>
> >> Hello,
> >>
> >> Since the commit being fixed is not yet a part of Mainline Linux, this
> >> patch is based on linux-next tagged next-20240913.
> >>
> >> An alternative to this patch will be a change to the "__rproc_attach()"
> >> function in the "remoteproc_core.c" driver with
> >> rproc->state = RPROC_ATTACHED;
> >> being set after "rproc_attach_device()" is invoked, but __before__
> >> invoking "rproc_start_subdevices()". Since this change will be performed
> >> in the common Remoteproc Core, it appeared to me that fixing it in the
> >> TI remoteproc driver is the correct approach.
> >>
> >> The equivalent of this patch for ti_k3_dsp_remoteproc.c might also be
> >> required, which I shall post if the current patch is acceptable.
> >>
> >> Kindly review and share your feedback on this patch.
> >>
> >> Regards,
> >> Siddharth.
> >>
> >>   drivers/remoteproc/ti_k3_r5_remoteproc.c | 8 --------
> >>   1 file changed, 8 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >> index 747ee467da88..4894461aa65f 100644
> >> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> >> @@ -194,10 +194,6 @@ static void k3_r5_rproc_mbox_callback(struct mbox_client *client, void *data)
> >>          const char *name = kproc->rproc->name;
> >>          u32 msg = omap_mbox_message(data);
> >>
> >> -       /* Do not forward message from a detached core */
> >> -       if (kproc->rproc->state == RPROC_DETACHED)
> >> -               return;
> >> -
> >>          dev_dbg(dev, "mbox msg: 0x%x\n", msg);
> >>
> >>          switch (msg) {
> >> @@ -233,10 +229,6 @@ static void k3_r5_rproc_kick(struct rproc *rproc, int vqid)
> >>          mbox_msg_t msg = (mbox_msg_t)vqid;
> >>          int ret;
> >>
> >> -       /* Do not forward message to a detached core */
> >> -       if (kproc->rproc->state == RPROC_DETACHED)
> >> -               return;
> >> -
> >>          /* send the index of the triggered virtqueue in the mailbox payload */
> >>          ret = mbox_send_message(kproc->mbox, (void *)msg);
> >>          if (ret < 0)
> >> --
> >> 2.40.1
> >>

