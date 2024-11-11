Return-Path: <linux-kernel+bounces-404600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3298B9C45B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF7FB294BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657101B654C;
	Mon, 11 Nov 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGV4x7AH"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280581B6541
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351661; cv=none; b=cv3jL0Xr8N+q18P6REvoivf93YR2N7yCWRA0df+Ggm9uYEdQ9kRyoRGYepJ1FGfd4BFqNQVeHhkuIVH9UiEiwJtWoyMsO0wvpYOhvpjJjJYPCqM1XbtLr4abz4nLfDyt5gErGz2qUKOD5qADfuxG5WiCcgxm9omrJLh5XvNq1ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351661; c=relaxed/simple;
	bh=2pDpviTPcDcUwyjjidyPIVbYpMJaTM72lZ7bBM0bluE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnKWh/o8jbbIT3dRZHzhsKCc/ZGFW+AP7lyQTXrhzyTcXV5yMwx/YFhVItmAf1EHrSS3aXlfh+bKifYOk0cZQV5EG/eAJ4jTRhNngbStErO/d2gulP3NLGvylsRGjTjDnT7z+r5r+mlLVB9rhHQ4DC5VGT6bvgLjRB9LWd7FC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGV4x7AH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so3630033a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731351659; x=1731956459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pDpviTPcDcUwyjjidyPIVbYpMJaTM72lZ7bBM0bluE=;
        b=iGV4x7AH1odMVqLETFu80/iNRjVQt4pxTOCg9PiQMFUhIVII0666f3XFK30yGr7S80
         tofq5gXKNHUUl6SUHkqFM+qbA3j4lmD74KWteptXTrapwg6esCwNqQ2s3JhbehKS8e7o
         af2isH4bH7wssiEI+EFdLaf5kBp/r43xSiMcBha4dmDU6ZoH3/ecYCsdoT3Ki7ZdqBSu
         su/O1Ocszcm7HMOV3F72g0ZHTvuXww1Y3WCVubJLUKtWPUkS6g+BjbbViBFxOyR26cnm
         iUe7O46paFaGTWaukOgLg3vkKjspIHdsGYg3W7hUcMIYSNils/r8efcl5XojrEP3HOSR
         y7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731351659; x=1731956459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pDpviTPcDcUwyjjidyPIVbYpMJaTM72lZ7bBM0bluE=;
        b=eK+KnMl0s9Wo/aTzg+42ppZbUbCQ3eeuTyZPQVVNPv04Io3mwW30tumSJN+Saf4JPC
         z2CjgXrHcSbLWjvDxiIiTE6FKCCedLUZf/fesQPFws4Fiww2TPNYMOt0d+nzr1r7eAC0
         hYm/X/1itBeraDAMPArhJ12JxFoUp/1zZ+GCdc7HtXpdyySIKn2eDksdo0PRHEd/yMws
         ulbbHfBIpLrICz4HL35g80TGpJRS/0YgcLuHKCKdfCjtar1yM26b8H6eD0HmHVtbXkHg
         qUWR+hoT2Md3rfkFi2GOyAXjkMTLZCvkguuePYU8U7lsBHL3Cd0CBG/zPPdWHwnerMdz
         0Mfg==
X-Forwarded-Encrypted: i=1; AJvYcCVUgIlDQzghlfSQRzZDmIrP88GP2JOYdqjFqvZapkgUtV56nf/8qm8X3ilgFy9ISaacRwdRiNZkCB2/wA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDk2IIet+msBKuF1dafc41OAG5I2w3YAAfvRCAQGNmrCww5eC
	nXr1XpO51ZI84p10Hsli8Zy/kuu5wFdUAuHy1ymf050Nf5gnQJrmm0DCit0U/hJii80H+7VkJat
	TktIf8rzVLOtJyQViVLAnWVHp50UW2wmA5WhTwQ==
X-Google-Smtp-Source: AGHT+IF2jLVx9obVTZnhgf77+8GsrSfbzXMFZdzhdPn8n+7CxPCJNvWaVAnxCZRrAOUNBAqC64Ad6y6XMwxwGnavFf4=
X-Received: by 2002:a17:90b:2743:b0:2e2:d87f:3cc with SMTP id
 98e67ed59e1d1-2e9b1777659mr16173672a91.23.1731351659370; Mon, 11 Nov 2024
 11:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net> <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com> <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
 <20241111104054.GE22801@noisy.programming.kicks-ass.net> <CAKfTPtBHRdHJaT_bjx1RF8bJ8Vc2s582VXMACPyjOno8zE_g=Q@mail.gmail.com>
 <CAGETcx9i4t_5Yt48Nfg=nSpZcPXZnPtSJtotUU7gt37wKpF6Vg@mail.gmail.com>
In-Reply-To: <CAGETcx9i4t_5Yt48Nfg=nSpZcPXZnPtSJtotUU7gt37wKpF6Vg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 11 Nov 2024 20:00:48 +0100
Message-ID: <CAKfTPtANwjo+2hJrLRYc3byDGDpes1nHcNd0PsavEiGG+CF9Tg@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Saravana Kannan <saravanak@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>, Tobias Huschle <huschle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 at 19:17, Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Nov 11, 2024 at 3:15=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Mon, 11 Nov 2024 at 11:41, Peter Zijlstra <peterz@infradead.org> wro=
te:
> > >
> > > On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote:
> > >
> > > > I actually quickly hacked up the cpu_overutilized() function to ret=
urn
> > > > true during suspend/resume and the threads are nicely spread out an=
d
> > > > running in parallel. That actually reduces the total of the
> > > > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> > >
> > > Right, so that kills EAS and makes it fall through to the regular
> > > select_idle_sibling() thing.
> > >
> > > > Peter,
> > > >
> > > > Would you be open to the scheduler being aware of
> > > > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > > > overutilized behavior during these phases? I know it's a very use c=
ase
> > > > specific behavior but how often do we NOT want to speed up
> > > > suspend/resume? We can make this a CONFIG or a kernel command line
> > > > option -- say, fast_suspend or something like that.
> > >
> > > Well, I don't mind if Vincent doesn't. It seems like a very
> > > specific/targeted thing and should not affect much else, so it is a
> > > relatively safe thing to do.
> >
> > I would like to understand why all idle little cpus are not used in
> > saravana's example and tasks are packed on the same cpu instead.
>
> If you want to try this on your end and debug it further, it should be
> pretty easy to reproduce on a Pixel 6 even without my suspend/resume
> changes.

You are using the v6.12-rc5 on Pixel6 ?

>
> Just run this on the device to mark all devices as async
> suspend/resume. This assumes you have CONFIG_PM_DEBUG enabled.
>
> find /sys/devices/ -name async | while read -r filename; do echo
> enabled > "$filename"; done
>
> And look at the dpm_resume_noirq() phase. You should see some kworkers
> that are runnable but not running for a while while a little CPU is
> idle. It should happen within a few tries. You need to unplug the USB
> cable to let the device suspend and wait at least 10 seconds after the
> screen goes off.
>
> But even if you fix EAS to pick little CPUs, I think we also want to
> use the mid and big CPUs. That's not going to happen right?

Who knows ?
Right now the trace that you shared clearly show a wrong behavior

>
> -Saravana
>
> > >
> > > Perhaps a more direct hack in is_rd_overutilized() would be even less
> > > invasive, changing cpu_overutilized() relies on that getting propagat=
ed
> > > to rd->overutilized, might as well skip that step, no?

