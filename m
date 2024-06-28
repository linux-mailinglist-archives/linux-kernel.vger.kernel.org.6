Return-Path: <linux-kernel+bounces-234462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D191C701
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AFD28543F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C4D770FA;
	Fri, 28 Jun 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBpeSIG0"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F977757ED
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604727; cv=none; b=TEEf0aN/BKpd26cWFPVoQD7Wj05C518ZhWvmohk8ys9mqnhfdsN6DJoXJi04EZ3NkEPekf0bHfEhbqsbMzqZhvZyQKu1lLA8ZDna8vUA+pqZKRBZH1A3c1WAG7lIlHMaPeHCbyKkdscT7B+rSjFa1o6dKC0b/YZ0LGH0R3CN1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604727; c=relaxed/simple;
	bh=tig7ceqFdxBStj7vF/ErqSzaVKTwAk9LWMCuITi8m1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrQYzgyGhGj9xwGaqGXTd9P0C5A/eXbD+9qhbNdIqILwvjNTtY2h2S00ZJ46GbpzwwXlhhA974NyBiQZHsbcUSqTJrhWeLCVUWlrNKf15rYiKL3NVl9Ax5S9AhwVK+yweOsizpGLaMcp89Jv2y3YNnKMqPjw9onGyNiNPNliJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hBpeSIG0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6fe61793e2so53991666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719604723; x=1720209523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yR+nNrAmhDJ7adsdI3ixcneSN3684HiMb5JcRx0XnME=;
        b=hBpeSIG0flypVIIoXaCiCfZkNkGNAyXbmt/ay71ewW0+sCreVm1YW0b+RIQVBrm8sa
         UtY3raY8DQIuILnwNMQqCo2y4U31yY+wDjnuk6VFOqoa1HYvvGkHzMX+/bplNkF/fBSD
         ALoVxIL2gaybxVRHIcFyZV68TrkO3366mJ7PnTjKSs/MXFN1zA4PNKOZWEFpkZKo+phw
         UC5dS4HI6R2YyxE8ZuoHz45HtqOGPwId1AEW3Fd3XCRl+ai9Fs7Ptn8Yoy6RNDZQO3mU
         kTg5XDRqEQFwUlmh+2J79q583ffw9X+9R1gx7nRITLYV/NyOc5YU4fALx4xVzmNc2DpF
         N+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719604723; x=1720209523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yR+nNrAmhDJ7adsdI3ixcneSN3684HiMb5JcRx0XnME=;
        b=taWP1c8X/Pf6tJ5aT3vk6X7vbKslV1xeHBaJ1rvbiknzq8ke/grIJFzp1fr6nBUeVe
         vT/k35kGhqFmw62qpI1yBTERiCJPrG6eDiBa8xNd/GpSPnfBJhnnhz6/mq7i5jM98Jpx
         UwGeSQk1TA8BLXFhMyfDS/wBBwi4hyBvQABwDITWnp9xMmFh5dVl0djUD0GmWx5OQR63
         NUCN1eRdF3JxzTB8okP8tvfgp36hiBqnd3nn/dyoO6DdtONyYOAkPz3MNCfBEM6B3sdE
         n7S90imN9DNps3lW19h9Z2Gc1umDufKs2V4mcmHqfiJr4jS1I3JxtPFl1epcoyAdYNEH
         lurg==
X-Forwarded-Encrypted: i=1; AJvYcCXzNWulID1ob2rkFbnDbuiIJbku9w65XxYswi6xmCfBDesOP8uEBfZHWZV3tPt3LZrUPsX66quqjeOPZcTPsOv2XZfUiO9eUkUfG6uO
X-Gm-Message-State: AOJu0Yyiim+kx2QcEVsaNVm0uar1+lWbIcWo+dPKdzOkSq/AXrV6NBAl
	Q0xDecgHozf+FDoYCfY0URSQN+1lS0oItN8MNmoOa501gsipNs350PcMovVMgcTkx7PsTI4tBA9
	J7X+iJhXCsICl91OSIb27WEPbkwt1UOpPGBmNeQ==
X-Google-Smtp-Source: AGHT+IEPdDbz2RpNIDQapOr77GmPCUwgewRiEIOnWL4JOrFM48Nj2pjYKRAXN5SGcpoWTtx7DIUFb9vS/B+2IR3BhMg=
X-Received: by 2002:a05:6402:268c:b0:584:b098:1d05 with SMTP id
 4fb4d7f45d1cf-584b0981d82mr6171944a12.41.1719604722770; Fri, 28 Jun 2024
 12:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621150058.319524-1-richard.genoud@bootlin.com>
 <20240621150058.319524-2-richard.genoud@bootlin.com> <Zn8UumUllbGS4/p9@p14s>
In-Reply-To: <Zn8UumUllbGS4/p9@p14s>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 28 Jun 2024 13:58:31 -0600
Message-ID: <CANLsYkxFvci0o0ET4vOGTYp0P2xEdwU2q4V1SmNh=W83uj87rA@mail.gmail.com>
Subject: Re: [PATCH 1/4] remoteproc: k3-r5: Fix IPC-only mode detection
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
	"Andrew F. Davis" <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Suman Anna <s-anna@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Udit Kumar <u-kumar1@ti.com>, 
	Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	=?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Nishanth, Vignesh, Hari and Andrew - please have a look at this patch.

Thanks,
Mathieu

On Fri, 28 Jun 2024 at 13:53, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Good day,
>
> On Fri, Jun 21, 2024 at 05:00:55PM +0200, Richard Genoud wrote:
> > ret variable was used to test reset status, get from
> > reset_control_status() call. But this variable was overwritten by
> > ti_sci_proc_get_status() a few lines bellow.
> > And as ti_sci_proc_get_status() returns 0 or a negative value (in this
> > latter case, followed by a return), the expression !ret was always true,
> >
> > Clearly, this was not what was intended:
> > In the comment above it's said that "requires both local and module
> > resets to be deasserted"; if reset_control_status() returns 0 it means
> > that the reset line is deasserted.
> > So, it's pretty clear that the return value of reset_control_status()
> > was intended to be used instead of ti_sci_proc_get_status() return
> > value.
> >
> > This could lead in an incorrect IPC-only mode detection if reset line is
> > asserted (so reset_control_status() return > 0) and c_state != 0 and
> > halted == 0.
> > In this case, the old code would have detected an IPC-only mode instead
> > of a mismatched mode.
> >
>
> Your assessment seems to be correct.  That said I'd like to have an RB or a TB
> from someone in the TI delegation - guys please have a look.
>
> Thanks,
> Mathieu
>
> > Fixes: 1168af40b1ad ("remoteproc: k3-r5: Add support for IPC-only mode for all R5Fs")
> > Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> > ---
> >  drivers/remoteproc/ti_k3_r5_remoteproc.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > index 50e486bcfa10..39a47540c590 100644
> > --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > @@ -1144,6 +1144,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
> >       u32 atcm_enable, btcm_enable, loczrama;
> >       struct k3_r5_core *core0;
> >       enum cluster_mode mode = cluster->mode;
> > +     int reset_ctrl_status;
> >       int ret;
> >
> >       core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
> > @@ -1160,11 +1161,11 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
> >                        r_state, c_state);
> >       }
> >
> > -     ret = reset_control_status(core->reset);
> > -     if (ret < 0) {
> > +     reset_ctrl_status = reset_control_status(core->reset);
> > +     if (reset_ctrl_status < 0) {
> >               dev_err(cdev, "failed to get initial local reset status, ret = %d\n",
> > -                     ret);
> > -             return ret;
> > +                     reset_ctrl_status);
> > +             return reset_ctrl_status;
> >       }
> >
> >       /*
> > @@ -1199,7 +1200,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
> >        * irrelevant if module reset is asserted (POR value has local reset
> >        * deasserted), and is deemed as remoteproc mode
> >        */
> > -     if (c_state && !ret && !halted) {
> > +     if (c_state && !reset_ctrl_status && !halted) {
> >               dev_info(cdev, "configured R5F for IPC-only mode\n");
> >               kproc->rproc->state = RPROC_DETACHED;
> >               ret = 1;
> > @@ -1217,7 +1218,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
> >               ret = 0;
> >       } else {
> >               dev_err(cdev, "mismatched mode: local_reset = %s, module_reset = %s, core_state = %s\n",
> > -                     !ret ? "deasserted" : "asserted",
> > +                     !reset_ctrl_status ? "deasserted" : "asserted",
> >                       c_state ? "deasserted" : "asserted",
> >                       halted ? "halted" : "unhalted");
> >               ret = -EINVAL;

