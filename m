Return-Path: <linux-kernel+bounces-236658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DCE91E579
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB98B2365E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244E916DC18;
	Mon,  1 Jul 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scSbVxdW"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0777433A2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851755; cv=none; b=QzpmvWiEF/mZofbTIUqDmMm8pScT0tGG6BANraXeLQBpextI2KN6GBwkanETx/VKLa18/0yAKKQajOVQ76aXWijLvsif0nNRLiXSnrKvB2JlcLKpU+70U4WAaf9vAfhQ9cYKrCf1LzE9frIaSmAEwS9bkSvsctv/1JQff2NH6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851755; c=relaxed/simple;
	bh=lUSADUt/Ir3EgCWNXPgMAnCacD83vDExc++9yzPQcqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f50XI5vHR4rvYgKzZ+/vIPQCiBtJ4hEz9NDB3iDPmOu/f1XtoHANLurkfaa+xMIW11Q/u/8dbX0fqD3CuOpo4683YPD57K2OKjoJrmPvxaCaJTjdfXP8llsauzCJRhckIY+4WQUaYX+3MZa/Y1fA4PKo0VxzTnWPnc/AHmhQQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=scSbVxdW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7066c9741b7so1858522b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719851753; x=1720456553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewg0jnlMpxAXXQsg9PMYoHpQrGSXXX8+YPW5TToZQ/8=;
        b=scSbVxdWsWNUYQOLJwHXlO3EmJY+d7mUUPLbwTroIcWirKss+4GAaSNDAXwzEilPGB
         6iDWaB2/xH4AXr6ewW6euf4sY5x442EKoYZ19jwGdeqo1P1+Q7FQ5j/f+RB51SIKquti
         8SS7n1xz6zQRH2Ol1U9IhQhbWk5BLk0PcjEIZI8TigLRyFy8A7AHP1CfcO9R9qDHuta+
         X6MkxR1gUUMahpil3W9UhLtCIpus6qqD0S8tDAFfs1Y5G12gXecZc523pwcPzZMaH7nY
         pbzBCukogS8FsJjhocYzSv1E0yhy8CRWvAywvSLaVRVPqYMiyfGsTCH1bi2cotV/4ePy
         6wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851753; x=1720456553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewg0jnlMpxAXXQsg9PMYoHpQrGSXXX8+YPW5TToZQ/8=;
        b=SpHge49AZJi/EnG1x0kWw+zdU0tCnI/B15hl1XcNdhO4Fl8HA2Zo7mrZFy5I12I3q6
         W5Mu7kf3FMI+Tnya033M4Amux4DdbDxGxxt7Kt5Pn9hfz+zYep/ezR0/fNMfnh1+IoRj
         U3HQjTFc5k5djDOcAzwwNFAR7avwzwg8akBu/qHleGpUunjoQh+QMoYdDv4OpEKMXXpN
         SmzVy7l9hBNbLDPtqkHBsB8ZKaT/Wf6dGZCvX4WcvSMFOq0tY7OgRyEAiGV0r98pjCvO
         sxqz6Q5X1S9CIAYLJPXciCeAhDWYWnqDrQMOMDmf7muRI8RxpKV8qxFr8PQ3CCY9E94t
         tFnw==
X-Forwarded-Encrypted: i=1; AJvYcCV2txoV+U8OG9wLQjjMvtVS8ZbcB2PMfLhsU9ctgdA6jJQsYW+QzE2z82sFWXAsrmUM4147lyZzy1bE2zzjS+VetGu1Mh/nDeFaZvm9
X-Gm-Message-State: AOJu0Yz9FL23wAPp2GASxEaJqi970uRV4ohorIHi/KIl5W52dK44UBUZ
	VtY7lCzWcZ41n4rM8bQZCPjavIFEc/V4T3pup/o1SCKoDPaHm7HUy6zbUjfsRFQ=
X-Google-Smtp-Source: AGHT+IHxOKfz80Amfw9W3M0Qdji1lJ7WblnxkgAaRMcTWWiU+ouZtyz+KUF4rHbpdcS8LnUSABdjjQ==
X-Received: by 2002:a05:6a21:6d96:b0:1bd:1acb:6bad with SMTP id adf61e73a8af0-1bef622357emr5362485637.53.1719851752670;
        Mon, 01 Jul 2024 09:35:52 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:be24:7a34:86fc:1a51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm66796025ad.68.2024.07.01.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:35:52 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:35:49 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Suman Anna <s-anna@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Hari Nagalla <hnagalla@ti.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] remoteproc: k3-r5: k3_r5_rproc_stop: code reorder
Message-ID: <ZoLa5WklP5+T/qTO@p14s>
References: <20240621150058.319524-1-richard.genoud@bootlin.com>
 <20240621150058.319524-4-richard.genoud@bootlin.com>
 <Zn8orCbTx9VtA9Em@p14s>
 <99496000-a994-4641-861a-10cbb501910e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99496000-a994-4641-861a-10cbb501910e@bootlin.com>

On Mon, Jul 01, 2024 at 10:03:22AM +0200, Richard GENOUD wrote:
> Le 28/06/2024 à 23:18, Mathieu Poirier a écrit :
> > On Fri, Jun 21, 2024 at 05:00:57PM +0200, Richard Genoud wrote:
> > > In the next commit, a RP_MBOX_SHUTDOWN message will be sent in
> > > k3_r5_rproc_stop() to the remote proc (in lockstep on not)
> > > Thus, the sanity check "do not allow core 0 to stop before core 1"
> > > should be moved at the beginning of the function so that the generic case
> > > can be dealt with.
> > > 
> > > In order to have an easier patch to review, those actions are broke in
> > > two patches:
> > > - this patch: moving the sanity check at the beginning (No functional
> > >    change).
> > > - next patch: doing the real job (sending shutdown messages to remote
> > >    procs before halting them).
> > > 
> > > Basically, we had:
> > > - cluster_mode actions
> > > - !cluster_mode sanity check
> > > - !cluster_mode actions
> > > And now:
> > > - !cluster_mode sanity check
> > > - cluster_mode actions
> > > - !cluster_mode actions
> > > 
> > > Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> > > ---
> > >   drivers/remoteproc/ti_k3_r5_remoteproc.c | 24 ++++++++++++++----------
> > >   1 file changed, 14 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > > index 1f18b08618c8..a2ead87952c7 100644
> > > --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > > +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > > @@ -636,16 +636,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
> > >   	struct k3_r5_core *core1, *core = kproc->core;
> > >   	int ret;
> > > -	/* halt all applicable cores */
> > > -	if (cluster->mode == CLUSTER_MODE_LOCKSTEP) {
> > > -		list_for_each_entry(core, &cluster->cores, elem) {
> > > -			ret = k3_r5_core_halt(core);
> > > -			if (ret) {
> > > -				core = list_prev_entry(core, elem);
> > > -				goto unroll_core_halt;
> > > -			}
> > > -		}
> > > -	} else {
> > > +
> > > +	if (cluster->mode != CLUSTER_MODE_LOCKSTEP) {
> > >   		/* do not allow core 0 to stop before core 1 */
> > >   		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
> > >   					elem);
> > > @@ -656,6 +648,18 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
> > >   			ret = -EPERM;
> > >   			goto out;
> > >   		}
> > > +	}
> > > +
> > > +	/* halt all applicable cores */
> > > +	if (cluster->mode == CLUSTER_MODE_LOCKSTEP) {
> > > +		list_for_each_entry(core, &cluster->cores, elem) {
> > > +			ret = k3_r5_core_halt(core);
> > > +			if (ret) {
> > > +				core = list_prev_entry(core, elem);
> > > +				goto unroll_core_halt;
> > > +			}
> > > +		}
> > > +	} else {
> > >   		ret = k3_r5_core_halt(core);
> > >   		if (ret)
> > 
> > With this patch, the "else" in this "if" condition is coupled with the "if" from
> > the lockstep mode, making the code extremaly hard to read.  The original code
> > has a k3_r5_core_halt() in both "if" conditions, making the condition
> > independent from one another.
> > 
> I'm not sure I understand what you mean.

With your patch applied I get the following: https://pastebin.com/yTZ0pKcS

Let's say the R5 is in split mode and k3_r5_rproc_stop() called on core1.  The
if() that deal with that condition is on line 10, while the function that halts
the remote processor is online 34, part of the else clause that handles lockstep
mode.  The two if() clauses are entangled and nothing good can come out of that.

> Anyway, I'm not happy with this diff, it doesn't reflect what was intended.
> (which is moving the check "core 0 should not be stop before core 1" at the beginning)
> 
> Tweaking around with the diff algorithms, I came with something way easier to read I think:
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 1f18b08618c8..a2ead87952c7 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -636,6 +636,20 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>         struct k3_r5_core *core1, *core = kproc->core;
>         int ret;
> +
> +       if (cluster->mode != CLUSTER_MODE_LOCKSTEP) {
> +               /* do not allow core 0 to stop before core 1 */
> +               core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
> +                                       elem);
> +               if (core != core1 && core1->rproc->state != RPROC_OFFLINE &&
> +                   core1->rproc->state != RPROC_SUSPENDED) {
> +                       dev_err(dev, "%s: can not stop core 0 before core 1\n",
> +                               __func__);
> +                       ret = -EPERM;
> +                       goto out;
> +               }
> +       }
> +
>         /* halt all applicable cores */
>         if (cluster->mode == CLUSTER_MODE_LOCKSTEP) {
>                 list_for_each_entry(core, &cluster->cores, elem) {
> @@ -646,16 +660,6 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
>                         }
>                 }
>         } else {
> -               /* do not allow core 0 to stop before core 1 */
> -               core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
> -                                       elem);
> -               if (core != core1 && core1->rproc->state != RPROC_OFFLINE &&
> -                   core1->rproc->state != RPROC_SUSPENDED) {
> -                       dev_err(dev, "%s: can not stop core 0 before core 1\n",
> -                               __func__);
> -                       ret = -EPERM;
> -                       goto out;
> -               }
>                 ret = k3_r5_core_halt(core);
>                 if (ret)
> 
> 

