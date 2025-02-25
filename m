Return-Path: <linux-kernel+bounces-531019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE5A43B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C316E1886AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22BE265CB1;
	Tue, 25 Feb 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tN/8iZaR"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92225486D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478409; cv=none; b=Srx1BY2ErBLC5r9ZmRLYibn3bpshFK949VYfXMGbOTVLuBWqa0hJErYxH5AjrvhX/IJqGuRuecaLeFFFsTqABEqknWionhTIyODgk7RGYQEKzRtMCMiV+Rw5LXDhi78SokQYAroqul7qrapSx8Slj5TlSBvuS7BbgYIyBKrWYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478409; c=relaxed/simple;
	bh=GmPZTrUL5VmBJD+i4cq0Kpx3DIpVJnr1M/2XQaV5Vgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWN0HNVYQ8FgCNXTvqlpB9Ww2sY8bx3R85Av5Un8jxRVu99SxPlE4J1bQ0a51h4y+p+W/0XHsXLjRY749MhWZEPVfX1y7iHPodHEdH1CX9Rlu+SswtpLTPBiKFtXxV7EknjINjd4HfjjUv1vPkG1l6incNfUJHmvH0yU9QfyWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tN/8iZaR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so9672135a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740478405; x=1741083205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GmPZTrUL5VmBJD+i4cq0Kpx3DIpVJnr1M/2XQaV5Vgw=;
        b=tN/8iZaRJBptsCbYlIe9njuwvXjQzgU5BQCsxVWEApQjzH2QYMk4q1da+xEqBlMMPq
         Ffo9d0d/nsu7AXMKMpPlVJRh5X3lKRzbZljmGlqnlsKQCZeG4cPPB+391Nr66QCkjoZp
         zls42s8eHlI5YUHon0b7ureop1FbMMzExoBPKFZK64mA8X2Rd+0zHivFwJKEAHSscB/0
         CSkENoaIgPcP7AErrYxMoUgfWkm2RM0Sr9dFLanYWbUWJX4Q/EDBRI+/4EYktwyn7o9S
         JvDbYoyERVNQ8KpId31QJ9d60U9kdrCdbHgGpzelaJe3Z/vINDg/+2agBdtVowZsvAzX
         oSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478405; x=1741083205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmPZTrUL5VmBJD+i4cq0Kpx3DIpVJnr1M/2XQaV5Vgw=;
        b=bfoQlkx8usmxldA2QOslDfvbdGn9AiPgiOIYMgzzmD37nDSWiSq2r/4k2eOQPVmlVx
         m7L8ojJMePRhCNI1drYrCtDbYs3QTPqc+/GACe0aXMK8VmPWCpFdatOsLpqGWthdaO70
         uIT99a+SkLLmTGgpFm09CLMeQda0qYeBeyxCJgHmF28Z2AB5DiPRKf4TGiJZIpN55j7N
         JtoHPtcnmzheFd8OBblxLpqfqm4QI8kcMBz6YNcAFSnj/gyajNyQ1ubrg6HffijyBfbZ
         Sp4ylPyBBhqPRYpmtanJPBRlMTaizFDsVykpOkzaYuHxTgmtLlvp2ThODTIEmf7iON/O
         5RkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Oa7vubQQFubc+h9YzxtiryeN0RVecFt4eOEZl2KRWMqV1okQV5b10P81sJQgUtcDRWSYtB0zEb1OFnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWIj8i5N4inxj4lDxIsUUizwu3MhVFr/vOCLBjjQwz8Lk9V/nm
	voiVTBWT39UPoqYxD0x4alXxVeHIN4uBCep1oPjQkcpr67T48WlCy4GL6Rr1l4My3AdHn1JJ3FN
	bwgs51nadPG6vDOfqApxHkZRAvokwUsrz2EhUWg==
X-Gm-Gg: ASbGncuzy9QprZXPwGrUr+MKLEgl6QfooHSvk9yyMv0TGHKccUz9B5SMwfjRt8Vefmn
	kP6hMMg/awGQEMpSm9PzujR4tOw080XtnVZkRV4MvzFcHLAvy5HR+a5zU9dglrNFQao2y4rC6e7
	qyOZKefhGbr2huw/uM5TEa86mNEwPp0tSlohPI
X-Google-Smtp-Source: AGHT+IHRStcu9HegPXd2HjXOYrNAxroYBpglNd/obIxLjZ6LqADm2z000PieLRyQ+GzPVyjZk8kBb0aXPwWxrx/BJpM=
X-Received: by 2002:a17:906:308f:b0:ab7:e73a:f2c8 with SMTP id
 a640c23a62f3a-abed0d3eb46mr221769566b.26.1740478405372; Tue, 25 Feb 2025
 02:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208074821.11832-1-15645113830zzh@gmail.com>
 <20250208075322.13139-1-15645113830zzh@gmail.com> <20250210012931.ym337oexdcjmwwzv@airbuntu>
 <20250210091352.GC10324@noisy.programming.kicks-ass.net> <CAKfTPtCLg_kuRtknPsiLwRdKpvb4CYHqv+BRh5yJV8Z+o4oQcw@mail.gmail.com>
 <20250225002521.t5w2deyyw6uqxo3r@airbuntu> <CAKfTPtDLRWVWhZ3QNEL_fQMwwh_LMZPPFcAEQ=shhRyVdmGQPg@mail.gmail.com>
In-Reply-To: <CAKfTPtDLRWVWhZ3QNEL_fQMwwh_LMZPPFcAEQ=shhRyVdmGQPg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Feb 2025 11:13:13 +0100
X-Gm-Features: AWEUYZkKaAFQNk4lRK3ptlA3d2BKCSsdlpNHog2a1Ku1EfADdnG9UxxHcpIW7S0
Message-ID: <CAKfTPtDjEHZkJR6C0vv2OLq2vZgvFKu6NMRCLsU6MK+6R7iLCA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks
 getting an extra tick
To: Qais Yousef <qyousef@layalina.io>
Cc: Peter Zijlstra <peterz@infradead.org>, zihan zhou <15645113830zzh@gmail.com>, bsegall@google.com, 
	dietmar.eggemann@arm.com, juri.lelli@redhat.com, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 02:29, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 25 Feb 2025 at 01:25, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 02/24/25 15:15, Vincent Guittot wrote:
> > > On Mon, 10 Feb 2025 at 10:13, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Mon, Feb 10, 2025 at 01:29:31AM +0000, Qais Yousef wrote:
> > > >
> > > > > I brought the topic up of these magic values with Peter and Vincent in LPC as
> > > > > I think this logic is confusing. I have nothing against your patch, but if the
> > > > > maintainers agree I am in favour of removing it completely in favour of setting
> > > > > it to a single value that is the same across all systems.
> > > >
> > > > You're talking about the scaling, right?
> > > >
> > > > Yeah, it is of limited use. The cap at 8, combined with the fact that
> > > > its really hard to find a machine with less than 8 CPUs on, makes the
> > > > whole thing mostly useless.
> > > >
> > > > Back when we did this, we still had dual-core laptops. Now phones have
> > > > 8 or more CPUs on.
> > > >
> > > > So I don't think I mind ripping it out.
> > >
> > > Beside the question of ripping it out or not. We still have a number
> > > of devices with less than 8 cores but they are not targeting phones,
> > > laptops or servers ...
> >
> > I'm not sure if this is in favour or against the rip out, or highlighting a new
> > problem. But in case it is against the rip-out, hopefully my answer in [1]
>
> My comment was only about the fact that assuming that systems now have
> 8 cpus or more so scaling doesn't make any real diff at the end is not
> really true.
>
> > highlights why the relationship to CPU number is actually weak and not really
> > helping much - I think it is making implicit assumptions about the workloads and
> > I don't think this holds anymore. Ignore me otherwise :-)
>
> Then regarding the scaling factor, I don't have a strong opinion but I
> would not be so definitive about its uselessness as there are few
> things to take into account:
> - From a scheduling PoV, the scheduling delay is impacted by largeer
> slices on devices with small number of CPUs even for light loaded
> cases
> - 1000 HZ with 1ms slice will generate 3 times more context switch
> than 2.8ms in a steady loaded case and if some people were concerned
> but using 1000hz by default, we will not feel better with 1ms slice

Figures showing that there is no major regression to use a base slice
< 1ms everywhere would be a good starting point.
Some slight performance regression has just been reported for this
patch which moves base slice from 3ms down to 2.8ms [1].

[1] https://lore.kernel.org/lkml/202502251026.bb927780-lkp@intel.com/


> - 1ms is not a good value. In fact anything which is a multiple of the
> tick is not a good number as the actual time accounted to the task is
> usually less than the tick
> - And you can always set the scaling to none with tunable_scaling to
> get a fixed 0.7ms default slice whatever the number of CPUs
>
> >
> > FWIW a raspberry PI can be used as a server, a personal computer, a multimedia
> > entertainment system, a dumb sensor recorder/relayer or anything else. I think
> > most systems expect to run a variety of workloads and IMHO the fact the system
> > is overloaded and we need a reasonable default base_slice to ensure timely
> > progress of all running tasks has little relation to NR_CPUs nowadays.
> >
> > [1] https://lore.kernel.org/all/20250210230500.53mybtyvzhdagot5@airbuntu/

