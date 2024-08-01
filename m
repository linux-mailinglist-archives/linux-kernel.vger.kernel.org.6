Return-Path: <linux-kernel+bounces-271537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C8944FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3D71F250CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD81B32A6;
	Thu,  1 Aug 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Zjh0MMYf"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D61B1500
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527562; cv=none; b=Rv0H/B+3+6US8IUNavh2qjz4gWCV4ozoX3dXE8zQ+gtRcdk4UEokrQJLAhXF4sC4b8EaGOnIXWcsd6K0rWu4eyh3bSte5m8t/tDWdeYvNNjgHb2dxtXlaTzLYOrRKWSnN9IhI69YEzW/tyNalgls7bv4msKEPZBsq+iH0p59BoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527562; c=relaxed/simple;
	bh=sofqxhi559s5n6V3DMQXHvvMMtEGrQSJ5F63T8NxtN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdZNKQyAK2rRjqyw0/+h8ku8DcYIxknRgdlPhy/VzJK97nP/AzlkizgdqA0Ls4UEnQLCrdTYLoEx0F8+UXGSWdARMJa+iTY3LQMO4Hsy5atUMmGwUF5ILOCSuA4+Sql8EdHK37TUeTcV8YzztkkGIxW92oHQN9EcCk0JeHknmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Zjh0MMYf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f15790b472so9058961fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722527558; x=1723132358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmIuUG8e7lN+2vYsK6kMEMCvxwq75KDIiYYBBf+G48I=;
        b=Zjh0MMYfaIxdm3Cjqlevty3gn5j/xN0nLIYUAkm7oJOwEci4Ab84tLKtyxlaCp5XyP
         wJfIBYArbbpEbkGTJUXgadqPI80oG2XLhFM45Urccggra1kbHI4wz7rrJ06uoy9rAtHH
         Uj0ydq2VYphyw9+WZrpOHzWN+ZKPwFSsfAxrt/5brnjBwHBKWWyMON7MTFBlHBZCNzkf
         JdIs8A8d7MuP1mzQSXTc24kdH3+AWIR6wmu70mmxnJYHHI4y7KDDgs7KH4ZLw43Q7xTB
         +e73s500xOBfVNVm3ZpOfH8NGgwoptSIw+Yr1nUKVxcA8A3lOOg57vKPua15Xw3oYEhI
         ZMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527558; x=1723132358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmIuUG8e7lN+2vYsK6kMEMCvxwq75KDIiYYBBf+G48I=;
        b=BIme1MUsn6Z8LLd29b7M/2y2Q4Ks2OYeFYjw4mLixv6Yw2+pK4XtAVmR/gLEa/JXtU
         6P8JFsGsOo4KvyaqJKtqP7sGOo+oxqmWVIMjKywcfbA+vTE+ls+bkpiw3sGSFWAG2K4+
         yk41NIJd0fA2lIXi6zf/T2a/13e2hFQaOnG5+A5rI/ZlfbS8K6Bj4Q+3hjgISxcuOMJC
         uNn9z97mj9pD4583ypfp6zxyWv29pzoVEnn/pkRt7UPzNwUrhmQ9BYUh58PhjYA3DZk7
         cJ/FCIbSIl8bGPqK9LaYVgl13Zf/70mEStsQIyju2uYEbIEp78nbXtyERv4ZIJ4EZaIQ
         NpkA==
X-Forwarded-Encrypted: i=1; AJvYcCXDEhSPb3tkkRB2pHcqF1dP4vg0OTxXSvkoNMJkxUPz3fdQ730hgjAdwJc/gozeyKpHRxVQ+oBv6vUK55gCQPPmZaA+5F9ZHoth3G77
X-Gm-Message-State: AOJu0YzCVSUNcfqbuh2D2aC7qoT6EdscpKYYcH0ujW+vaYauxAvZaOEu
	BfuFK3f0ww5LC4zTBo8FG2TFhRv/ihRbAVOZIlL6UaFcPWo/9ujTOhRtvxz4n1c=
X-Google-Smtp-Source: AGHT+IETUjR6M8t/srh+0Dv8JJ7QjNDssSOK7du1cWqETe9BIcsvTpqycdwgj/eDnDG9+Pst+I+qWA==
X-Received: by 2002:a05:651c:20a:b0:2ef:24e0:633b with SMTP id 38308e7fff4ca-2f15aaacbedmr5986621fa.19.1722527557686;
        Thu, 01 Aug 2024 08:52:37 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282babaab3sm62203805e9.28.2024.08.01.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:52:37 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:52:33 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Russell Haley <yumpusamongus@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tj@kernel.org, torvalds@linux-foundation.org,
	vincent.guittot@linaro.org, void@manifault.com
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240801155233.navvwritakzabylg@airbuntu>
References: <20240725011907.3f5ropfai3xoy3l3@airbuntu>
 <97e39177-f9f3-4fb4-b598-ba10fc6a8125@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97e39177-f9f3-4fb4-b598-ba10fc6a8125@gmail.com>

On 07/31/24 21:50, Russell Haley wrote:
> > We really shouldn't change how schedutil works. The governor is supposed to
> > behave in a certain way, and we need to ensure consistency. I think you should
> > look on how you make your scheduler compatible with it. Adding hooks to say
> > apply this perf value that I want is a recipe for randomness.
> 
> If schedutil's behavior is perfect as-is, then why does cpu.uclamp.max
> not work with values between 81-100%, which is the part of the CPU
> frequency range where one pays the least in performance per Joule saved?

I think you're referring to this problem

	https://lore.kernel.org/lkml/20230820210640.585311-1-qyousef@layalina.io/

which lead to Vincent schedutil rework to how estimation and constraints are
applied

	9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")

Do you see the problem with this applied?

> Why does cpu.uclamp.min have to be set all the way up and down the
> cgroup hierarchy, from root to leaf, to actually affect frequency

I'm not aware of this problem.

This has nothing to do with schedutil. It's probably a bug in uclamp
aggregation.

Which kernel version are you on? Is this reproducible on mainline?

> selection? Why is sugov notorious for harming video encoding
> performance[1], which is a CPU-saturating workload? Why do intel_pstate

Without analysing the workload on that particular system, it's hard to know.

But I am aware of issues with rate_limit_us being high. I already proposed
enhancement and pursuing further improvement [1]. rate_limit_us defaulted to
10ms on many systems, which has slow reaction time for workloads that cause
utilization signal to go up and down.

If the workload is cpu-saturated with no idle time at all then we should run at
max frequency except for some initial rampup delay. If that's not the case it'd
be good to know. But we have no info to tell. My suspicion is that it's bursty
and goes up and down.

I will give a talk at LPC about issues with how util signal ramps up. And had
some patches to discuss overall response time issues in general [2]. I am also
trying to consolidate how cpufreq updates are driven by the scheduler to better
reflect the state of the CPU [3] and hopefully pave the way for better handling
perf constraints like uclamp and iowait boost (if we ever move to a per-task
iowait boost) [4].

There are a lot of teething issues to consider though.. So yeah, not perfect
and needs lots of improvements. And there's effort to improve it. I'm
interesting to learn about your problems so please feel to start a separate
thread on the problems you have. We can work to address them at least.

[1] https://lore.kernel.org/lkml/20240728192659.58115-1-qyousef@layalina.io/
[2] https://lore.kernel.org/lkml/20231208002342.367117-1-qyousef@layalina.io/
[3] https://lore.kernel.org/lkml/20240728184551.42133-1-qyousef@layalina.io/
[4] https://lore.kernel.org/lkml/20231208015242.385103-1-qyousef@layalina.io/

> and amd-pstate both bypass it on modern hardware?

I did try to raise it in the past but no one has carried out the work.
Volunteers are welcome. It's on my todo, but way down the list.

> 
> It appears that without Android's very deeply integrated userspace
> uclamp controls telling sugov what to do, it's native behavior is less

Nothing is deeply integrated about a syscall to change uclamp. But there are
more folks interested in creating libraries in that world and push to make it
work. I sadly don't see similar interest for Desktop and servers. Except for
Asahi Linux in one of their blog posts. But not sure if they plan something
more sophisticated than what they did.

Generally we don't create these userspace libraries, and there have been
several suggestions for us to start a library to help kick off that effort. But
none of us have the time. If there are folks interested to start this work, I'd
be happy to provide guidance.

> than awe-inspring. Futhermore, uclamp doesn't work especially well on
> systems that violate the big.LITTLE assumption that only clamping << max

I'm not sure what you mean here, but the power curve is different for every
system.

I'd expect users to try to set uclamp_max as low as possible without impacting
their perf. But there's a known problem with uclamp_max due to aggregation that
affects it's effectiveness that has been a topic of discussion in OSPM and LPC
several times. My proposal in [4] should address it, but I have to fix more
concerns/problems first. There are proposals for different approaches floating
around too.

> saves meaningful energy[2]. Non-Android users widely scorn sugov when
> they become aware of it. Web forums are full of suggestions to switch to
> perfgov, or to switch to "conservative" or disable turbo for those who
> want efficiency.

It'd be great if people come forward with their problems and help with
analysing them instead.

> 
> That said, given how long the the PELT time constant is, a bpf scheduler
> that wanted to override sugov could probably cooperate with a userspace
> daemon to set min and max uclamps to the same value to control frequency
> selection without too much overhead, as long as it doesn't mind the
> 81-100% hole.

Yes. They could do that. I'm surprised no one has done a generic uclamp daemon
to auto tune certain apps to improve their perf and efficiency. I started some
effort in the past, but sadly dropped it as I didn't have the time.

I generally think the approach of adding more QoS in the kernel then use BPF to
create app or system specific tuner to set these QoS is a more viable option in
the long run. I think BPF can hook into user app to get cues about bits they
could struggle with and they need help to auto tune somehow? ie: a certain
operation that requires boosting or causes unnecessary freq spike.

> 
> [1] https://www.phoronix.com/review/schedutil-quirky-2023
> 
> [2] Does that still hold on high-end Android devices with one or two
> hot-rodded prime cores?
> 
> Thanks,
> 
> --
> Russell Haley

