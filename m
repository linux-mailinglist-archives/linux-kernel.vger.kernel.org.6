Return-Path: <linux-kernel+bounces-416331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8E49D435B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3481F218E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FE81BD516;
	Wed, 20 Nov 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyBGaf7q"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24935199238
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136571; cv=none; b=KqcPbsQXxaTObEmaf5Dm/E9XdW0u8WVizQarsvu1Hb2RbJ/bwI7kQFHQxOoJNRl7NBoCf2F0XM3XAJ3/lAJYDHpRlRACD6f1GY3jGANSVGKelWPKOkySuY7EEqTx/XUP2Th4FT9jJU6Alh4CycuffTMveSkjUyguZYame05BWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136571; c=relaxed/simple;
	bh=lJUnRJZI7WwjItLIkoqkLS/Y/5o3RNRZX2wrVx/qbRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imvjCugZvecrVuwMa/TAOgEz/O2SysU7TE7Tsu2KNEeZ/goTP3gahK9bZcKxd8SlBoZiRVYoZwomQAzO+0fVTK7QOz3rjujq8eOgCedKhecaeyU+pPNf7ABzGRHBKhX5evlGj+Om5TquK9mpgYbHUBsf1CXAtmx4c9RY2Ak+U7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZyBGaf7q; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539d9fffea1so143798e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732136568; x=1732741368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJUnRJZI7WwjItLIkoqkLS/Y/5o3RNRZX2wrVx/qbRY=;
        b=ZyBGaf7q+KXrTh0h7rdKieqcjhBjnFCvZanYSeWwyMAmRlh02N/6UU4iGfRTT8R0gB
         UC9S565RmglxC1PH0i8GG3CA6ZWDq+LbY8gUefiUIgCtYYxzApOjJqXqLzOEE2iiH0z3
         i3TpFr0xeNBomCtXWEV5x67pwJW79cgRmy6VO/k3rCAO1LUKXTZo/kJTEV84uKikd/xE
         u77mu79y/2M/70c+QQgHtz/7VLlm20YzT/yykLtzqWZ+DqCkoecJIrbS2vDGOTRtqUD0
         QHcdx2T7DEoV2Sj98dltL0gcqhAfay29jS2cxPoV3TPAIxY4PSWkug1XzJsXkgd/piGX
         IRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732136568; x=1732741368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJUnRJZI7WwjItLIkoqkLS/Y/5o3RNRZX2wrVx/qbRY=;
        b=grIxAnNoAcxJAAdmAo2HwYUEzKyK2pgXWKmVm5UlrPuVS+nOUmaflvlCjN8cObcc8h
         W6hOPhml/fk+BreuRyOwdTv/J8NJdofVtVj9O9+0bD5D1nls6jGW7xbRAnXRRANq3eV6
         ujftxx65jOk9uvoNAUcD1UkeZQokTV4bv0jWr67PRC7ealzSeobT21UaXmQdDcDSaFVu
         +Ayi+qQZVbC4B2vu1SZxhrcFwTk8BcOqHGAVWTWsgLq9H0XHmLiZMSJk4zPQ1Gpiq+WO
         Jbtm4oUPFChYwBaoBI6w4qPVEDx71hGseLLPN4Bp7n32kwiQdDqQI3h0q5YQqjMhKowZ
         8xiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/n8cW4QPVe2cHmx45BxCI6USbh/IeeMl2RS8O/ySaVvKano1VpS5f23VriHCDHGSQNc5JDTrqaDpFb5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1MkDxpgDGszMLangjE9urQa+JEKw0PZ2W8hyqieE1oXfD5sM
	rQAlcIyrZ3tFuahLhr/gU5VrCqmSP8c1CqU2tHQA8t3KKCO7A0hu/cvBUNh85nxMQ2BMnsKL/uf
	3qNeqtFpUCJfhUH76pw2lPYWweCJTitJM/YmCgQEg33YM+EUlCxkK
X-Gm-Gg: ASbGncth2hxCbCj7PjqA8FsYyfkpsRfC+m5ExT19j7rl3TgSXtDPCZIr/C9v5gffKip
	cltxcNKn9MiEtmtWzmp/3yj4SoeklmvhTvFPyTd5DwrG9c0cZTj1QLNJ94w==
X-Google-Smtp-Source: AGHT+IEVtwvvfrRLs27lH5uzyC7A/OLqTCvhRway1U+/vkm/cNI3SUT6Tc/If1D0LpBCF36tu6+X7WOJS4hqlro+sac=
X-Received: by 2002:ac2:5a0a:0:b0:539:eb2f:a026 with SMTP id
 2adb3069b0e04-53dc1349fbcmr1749787e87.33.1732136567895; Wed, 20 Nov 2024
 13:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119020519.832013-1-saravanak@google.com> <20241119092829.GF11903@noisy.programming.kicks-ass.net>
 <CAGETcx_vABsh8HgMi1rYRWmB5RhYwqGT6kKJ+9LX0HrcP8i7yA@mail.gmail.com> <20241120084240.GA19989@noisy.programming.kicks-ass.net>
In-Reply-To: <20241120084240.GA19989@noisy.programming.kicks-ass.net>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 20 Nov 2024 13:02:11 -0800
Message-ID: <CAGETcx_wv_sC+FhChr8OaV6wjkHxTf9W66AoBQihV=m70G=_iQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] cpu/suspend: Do a partial hotplug during suspend
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 12:42=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Nov 19, 2024 at 06:28:00PM -0800, Saravana Kannan wrote:
> > On Tue, Nov 19, 2024 at 1:28=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
>
> > > Well, if we push this one step further, why do we need hotplug at all=
?
> > > Can't we just keep them up and idle?
> > >
> > > That is, if we look at suspend_enter(), you'll note that
> > > PM_SUSPEND_TO_IDLE happens before the whole disable_secondary_cpus()
> > > thing.
> > >
> > > So million-dollar question, can this pixel thing do suspend to idle?
> >
> > Unfortunately not. You saw my rant about firmware and s2idle bugs at
> > LPC. But yes, I'm going my part towards pushing for s2idle over s2ram.
>
> Right, so with Google doing their own chips, I think you stand a fair
> chance of making it work 'soon', right? :-)

I can neither confirm or deny :)

>
> > And even if this Pixel could do it, there are a lot of devices in use
> > today that will never get a firmware update to enable s2idle. So, why
> > have all of them waste time and energy doing useless steps during
> > suspend?
>
> Right, so if we really want to go do this, we should add place-holder
> state for suspend, something like CPUHP_SUSPEND and document the
> requirements and audit all existing states now skipped to meet
> requirements.

Yup! This is exactly what I had in mind. But didn't want to go full
out on the patch before I got some sanity check here.

>
> I think it should go somewhere right between CPUHP_BP_PREPARE_DYN_END
> and CPUHP_BRINGUP_CPU.

I was thinking before CPUHP_BP_PREPARE_DYN because I saw some drivers
doing whatever the heck they do in CPUHP_BP_PREPARE_DYN. It'll be much
easier to do audits of non-dynamic stuff and keep it within
requirements.

> WORKQUEUE_PREP seems awefully random, and the
> typical purpose of the _PREPARE stages is to allocate memory/resources
> such that STARTING can do its thing, similarly _DEAD is about freeing
> resources that got unused during _DYING.

Yeah, I understood all this. I wanted to pick CPUHP_TMIGR_PREPARE
(mentioned in my first email) because it was right before
CPUHP_BP_PREPARE_DYN (and if you skip over CPUHP_MIPS_SOC_PREPARE
which sounds like a hardware step). But hrtimers seem to have a bug --
if the sequence fails anywhere in between CPUHP_AP_HRTIMERS_DYING and
CPUHP_HRTIMERS_PREPARE things fail badly.

So, for now I'd say we get in something like CPUHP_SUSPEND wherever it
works right now (after WORKQUEUE_PREP) and slowly move it up till we
get it right before CPUHP_BP_PREPARE_DYN.

> So the most logical setup would be to skip the entire _DEAD/_PREPARE
> cycle.

Makes sense to me.

On a separate note, I'm kinda confused by state machine stages where
only one of the startup/teardown callbacks are set up. For example,
I'd think the workqueue_prepare_cpu() would be combined with
workqueue_online_cpu()/workqueue_offline_cpu(). Why is online() not
sufficient to undo whatever offline() did?

>
> > > Traditionally hybernate is the whole save-to-disk and power machine o=
ff
> > > thing, and then there was suspend (to RAM) which was some dodgy as he=
ck
> > > BIOS thing (on x86) which required all non-boot CPUs to be 'dead'.
> >
> > My change would also help with the time it takes to power off the CPUs
> > during hibernate :) If it'll work (otherwise, we can make sure this
> > applies only to suspend).
>
> So I'm not sure you can actually skip this during hibernate. The thing
> is, we load the image from the boot CPU in a state where the secondary
> CPUs have never yet been loaded up. It might be possible to skip the
> DEAD/PREPARE cycle, but it would also mean the image must contain the
> full PREPARE resources. So if it all works, then the result is a larger
> image, for a slightly faster cycle, but since hibernate is already super
> slow, I don't think this trade-off is worth it.

Ok, makes sense. We'll have to make some changes so that this doesn't
run for hibernate (it will as this patch is written).

-Saravana

