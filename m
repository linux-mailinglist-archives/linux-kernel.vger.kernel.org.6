Return-Path: <linux-kernel+bounces-531409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63847A44023
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691C51888720
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B513F268C67;
	Tue, 25 Feb 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Uq9bBd88"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BA2686AF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488797; cv=none; b=ggoOq0QD9UyjyZgb1GUSw6l+Pb0OBgH8D5REMW+MPQOY6fjX0ZBwXz8LPFnJWm+L9lFnFM+Tt4XdTUR5bVFSj1R41NQ8IljjeyNg+E2LhBFie6HvcZG45xq6FCEHLPFIXGwPxSFMoM+++UTghp2Z6OqwdcnGG7Gp5/yWyxJkF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488797; c=relaxed/simple;
	bh=dEDYnB/ZGue7AXnCtN0db3onXsruxL5yCDkNfsvKVpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXBweSptIbms8iwIW1QrFIsBw7NJs3rxA6R4DfLtOt/Nc5HkyMvLdnKIz8hGMxiTFBs76W9R0NbDcZu+ohpB7BuecOnZCYiPvfAbfhgW3nM8JsnzJnW7Jzeyj1WRWjsrFl9p99OiqliK9eh6xmWLwkEQlXoOdyX7hyCGDCQXgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Uq9bBd88; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso2860977f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1740488794; x=1741093594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3r2abtexQ5so+Aq2Ix0QxPeBhuLrVnX7e6NAOqOuWow=;
        b=Uq9bBd88brYbrYbByfLzML4MrfYpNerfNUdXD8F1ECacfbmIh4/Qrh2sFrS/g2AOKa
         TLW5dyVQDmpdbRLCfBT9eu+BPtCB1e9A5LsSGPsu7Q9HVvZA6cRnOt1Ad8vQurkkLjDp
         ZXzsyxUMRnM7fJ+xUD/iDJBY8/7sZKMlsZqqXNDJFkhnvkofyvPUsfMPMro3b5Y9YpIS
         GVqcvuL1CfQfDTDdD7cHdGBLf+S4VADp0VxLfR82Ln0wQ2IBM+HGEf+5dSCXTuW/rMEE
         55wYf1SIV93xVXPuzsA1cuVwvahiqR8Ehtb6amltrC1VJYDb0qR2f0cnImMPjCoymKa2
         8r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740488794; x=1741093594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3r2abtexQ5so+Aq2Ix0QxPeBhuLrVnX7e6NAOqOuWow=;
        b=do/2ZZDAT1EKa0iWtcrdlPlutS+vTC6uxD4MyF8eRabH17IV/VP9ijx6GHmtXskAtr
         ihRjQoQFAWeNQ8qKS5/mfauzfo+yyAuBLmLb2hbTEXPRANwVNwsQPWFFAg9U082v39Zg
         ToBK1XliGBxk27/LhiQxYygNJY+vAoEVK69CNR1gfHkElZzLDK+lI2KGNQY1N1FAxH7u
         tpqiijnLoA4UQBKp3n2YXeogB9TAv9Edw+IejFIo8hCFjDtMkVcT+omcm9WCbAI5Glw8
         iHzP8cP6IejclaJhKOs3EIAc7DjbF1fAfCbGi5ES79U/NhE18Mh1CBpyXolht1WTWFpJ
         tHIg==
X-Forwarded-Encrypted: i=1; AJvYcCVCR6rDu4F/Ku+TLyD5iB66jYDxZAS1MhuEcpCpXX+r2vhAL+brxphrCcfchcERcsija3DLhtrMnDObwes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWv6TwJeOA+shonXnUhs8yfz8xxT26UAk+zJl10jhXM7pznOUn
	n290XwwWNzjG8jwa7kNgi/JYlGO0PGFSoJIG1hYX8Q+sHxM47NDMj2O6ZbrjE5E=
X-Gm-Gg: ASbGncs6rIMXPN5xbjWjQeX8j8hZGI/6EnjzlhQONwQTCwdye3XVSTdkArXM9PH/ai2
	XKSkq3jwkLDXZAI3Yj/xQrdu5X3B1kxOYk/RgQxtHt/jVttyTmVNzDnmVI68xl1xFNmdq2/W8Sh
	qUivmy/wSsYpewZ7t6WSPJ0Eh5wlUb2KOqLLVlkLP1oPg7rKyV4SmkltBtgg1SDG+S48ZMsF593
	MkA9hvWQxeYVOfVvnmLISexiMJPb0TOmXe9qqKpPTI6AoVSku8t//Gd5vWKr1KaNy6E0BdxYT6j
	wzLDgdVXLOoxbr9y3aQo
X-Google-Smtp-Source: AGHT+IFPGaLaQqolYTV6Jqk9DfglHXkMkXYqQkS5537ij0pmGpVMAzM91KDMjwvm+BMnPBjAwDjFGA==
X-Received: by 2002:a05:6000:1447:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390cc5f20e0mr2880469f8f.3.1740488793228;
        Tue, 25 Feb 2025 05:06:33 -0800 (PST)
Received: from airbuntu ([46.186.201.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca0asm2284946f8f.32.2025.02.25.05.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:06:32 -0800 (PST)
Date: Tue, 25 Feb 2025 13:06:28 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	zihan zhou <15645113830zzh@gmail.com>, bsegall@google.com,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	rostedt@goodmis.org, vschneid@redhat.com
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks
 getting an extra tick
Message-ID: <20250225130628.ydoijpev7qwmz5kw@airbuntu>
References: <20250208074821.11832-1-15645113830zzh@gmail.com>
 <20250208075322.13139-1-15645113830zzh@gmail.com>
 <20250210012931.ym337oexdcjmwwzv@airbuntu>
 <20250210091352.GC10324@noisy.programming.kicks-ass.net>
 <CAKfTPtCLg_kuRtknPsiLwRdKpvb4CYHqv+BRh5yJV8Z+o4oQcw@mail.gmail.com>
 <20250225002521.t5w2deyyw6uqxo3r@airbuntu>
 <CAKfTPtDLRWVWhZ3QNEL_fQMwwh_LMZPPFcAEQ=shhRyVdmGQPg@mail.gmail.com>
 <CAKfTPtDjEHZkJR6C0vv2OLq2vZgvFKu6NMRCLsU6MK+6R7iLCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDjEHZkJR6C0vv2OLq2vZgvFKu6NMRCLsU6MK+6R7iLCA@mail.gmail.com>

On 02/25/25 11:13, Vincent Guittot wrote:
> On Tue, 25 Feb 2025 at 02:29, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Tue, 25 Feb 2025 at 01:25, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 02/24/25 15:15, Vincent Guittot wrote:
> > > > On Mon, 10 Feb 2025 at 10:13, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > On Mon, Feb 10, 2025 at 01:29:31AM +0000, Qais Yousef wrote:
> > > > >
> > > > > > I brought the topic up of these magic values with Peter and Vincent in LPC as
> > > > > > I think this logic is confusing. I have nothing against your patch, but if the
> > > > > > maintainers agree I am in favour of removing it completely in favour of setting
> > > > > > it to a single value that is the same across all systems.
> > > > >
> > > > > You're talking about the scaling, right?
> > > > >
> > > > > Yeah, it is of limited use. The cap at 8, combined with the fact that
> > > > > its really hard to find a machine with less than 8 CPUs on, makes the
> > > > > whole thing mostly useless.
> > > > >
> > > > > Back when we did this, we still had dual-core laptops. Now phones have
> > > > > 8 or more CPUs on.
> > > > >
> > > > > So I don't think I mind ripping it out.
> > > >
> > > > Beside the question of ripping it out or not. We still have a number
> > > > of devices with less than 8 cores but they are not targeting phones,
> > > > laptops or servers ...
> > >
> > > I'm not sure if this is in favour or against the rip out, or highlighting a new
> > > problem. But in case it is against the rip-out, hopefully my answer in [1]
> >
> > My comment was only about the fact that assuming that systems now have
> > 8 cpus or more so scaling doesn't make any real diff at the end is not
> > really true.
> >
> > > highlights why the relationship to CPU number is actually weak and not really
> > > helping much - I think it is making implicit assumptions about the workloads and
> > > I don't think this holds anymore. Ignore me otherwise :-)
> >
> > Then regarding the scaling factor, I don't have a strong opinion but I
> > would not be so definitive about its uselessness as there are few
> > things to take into account:
> > - From a scheduling PoV, the scheduling delay is impacted by largeer
> > slices on devices with small number of CPUs even for light loaded
> > cases
> > - 1000 HZ with 1ms slice will generate 3 times more context switch
> > than 2.8ms in a steady loaded case and if some people were concerned
> > but using 1000hz by default, we will not feel better with 1ms slice

Oh I was thinking of keeping the 3ms base_slice for all systems instead.
While I think 3ms is a bit too high, but this is more contentious topic and
needs more thinking/experimenting.

> 
> Figures showing that there is no major regression to use a base slice
> < 1ms everywhere would be a good starting point.

I haven't tried less than 1ms. Worth experimenting with. Given our fastest tick
is 1ms, then without HRTICK this will not be helpful. Except for helping wakeup
preemption. I do strongly believe a shorter base slice (than 3ms) and HRTICK
are the right defaults. But this needs more data and evaluation. And fixing x86
(and similar archs) expensive HRTIMERs.

> Some slight performance regression has just been reported for this
> patch which moves base slice from 3ms down to 2.8ms [1].
> 
> [1] https://lore.kernel.org/lkml/202502251026.bb927780-lkp@intel.com/

Oh I didn't realize this patch was already picked up. Let me send a patch
myself then, assuming we agree ripping the scaling logic out and keeping
base_slice a constant 3ms for all systems is fine. This will undo this patch
though.. I do want to encourage people to think more about their workloads and
their requirements. The kernel won't ever have a default that is optimum across
the board. They shouldn't be shy to tweak it via the task runtime or debugfs
instead. But the default should be representative for modern systems/workloads
still as the world moves on. It would be great if we get feedback outside of
these synthetic benchmarks though. I really don't think they represent reality
that much (not saying they are completely useless).

> 
> 
> > - 1ms is not a good value. In fact anything which is a multiple of the
> > tick is not a good number as the actual time accounted to the task is
> > usually less than the tick
> > - And you can always set the scaling to none with tunable_scaling to
> > get a fixed 0.7ms default slice whatever the number of CPUs
> >
> > >
> > > FWIW a raspberry PI can be used as a server, a personal computer, a multimedia
> > > entertainment system, a dumb sensor recorder/relayer or anything else. I think
> > > most systems expect to run a variety of workloads and IMHO the fact the system
> > > is overloaded and we need a reasonable default base_slice to ensure timely
> > > progress of all running tasks has little relation to NR_CPUs nowadays.
> > >
> > > [1] https://lore.kernel.org/all/20250210230500.53mybtyvzhdagot5@airbuntu/

