Return-Path: <linux-kernel+bounces-274075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6753694731F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14771F212C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55D13C9C0;
	Mon,  5 Aug 2024 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="1kjceRxd"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD514A85
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722822260; cv=none; b=Tgv5MC0m3xV8hI69Yb6h9ubC4MJpVN7Zp9H5pTtbBUhRq0mt5AhXydkKWTK7oGCqlBMm0GM3yHPYkt3FFo25IiJ6m0yiRApLK1CRg2Y18olAo9P+b23RNbf/otrAGv01cNlXgwGr9KrLC4dZcm0Vg1HsT7/JrmvVQy7+vvqVLDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722822260; c=relaxed/simple;
	bh=SIZ4uSjH/2cs5PqvMrpU1JuAtLSR3OwIm/8JsmNguz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/8jOH+zdcGRZQxcfCDrjtGRcxHOlAc7vLg9mVqu8pey4VcL/7GwH0g+wLDcc8XxGW2mSOKKHu02f2aPQZwm+N8Lorj1j+IzGI5+Ya6Sw/l08FdfV7/LnvauOsC9cZ3L/Uy2lvsJl5mFPWMrMgnHKFFl6ZcbYG4W1oKSTjSC75M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=1kjceRxd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3687fb526b9so5147670f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 18:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722822256; x=1723427056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wP8Ia0ZhlqMqbFfTZXcdZZbt5ICVPg5kYryrMWrCzjs=;
        b=1kjceRxdnSR68jjIURztzjBwQh6JVDfhAfzva80V0UVMf79YxYgNAPK4jw+7B7vUXw
         wHbWWI6XcFr/d3ZCQhJjTi/42NNBjpJcZGTi79ehGwixZc4ENMOp4R5asG2BTjvgcyGy
         xTpIPoGVnAzQblUfyP6uzkuKjzjLPzHsHD+NNDztxj9fEy1Oll/PJQRPYEu/5l8GPmcD
         iSTrXs3JjM81Wq1AMg1iFi+Mo3dXY7OPBc34h+iMyjtQhLSP2BhsF7bfelmdkkKObNQ0
         fuFpWGdsiAtQ4t10Iz5ZEhX6Zn6PzxzXIkxrF0yneWWRiIshOJ/OdFH1q2ti5kdTAj7U
         Or7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722822256; x=1723427056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP8Ia0ZhlqMqbFfTZXcdZZbt5ICVPg5kYryrMWrCzjs=;
        b=pmFMGExa2kB6DpNSNl5jTLUaD7P3MR1Y82jCbK62OtkYV10LQ7cd5zBG3lv/QI6Wlo
         1zOrW4FxZI0Z/RVIW+3iMDlO7Qco3SW5pzEtdfirIu9nbAYkyhjcGnzWCaYHvL0IWjq/
         mdeDnf1VOOf35Ol6HaoReIyieY4qSqSwcXvOmB5Kn3oOQTHlZeIOgkhBg2sBmw0jPSCB
         d4Jf14TcokwwEmftQpwEmjKEF39+JoB5DcYtZ/Irs7Lu2Yj7ldyTBGXUz8LSlmi2P9tl
         nRP01WzLmqXN8Q6YSHqwq7sgdMEvaiNcHb5ezbagHjzaer9kK3cLqrApNuF33AImVGAr
         QsvA==
X-Forwarded-Encrypted: i=1; AJvYcCV7CoMJ20nqACHli3a1LwcyrImmHNwKEgG+7Lcjura85yZrokle2tRKcVB5CWCbbSY8Me1uoxk8mwzxtPpQHx9NB6SwT+zkrgeTbm0t
X-Gm-Message-State: AOJu0Yw3WYHjGaxslgxQRq+/4sf/p1lF6Ad3MOIFeyYoS1MsOzwYp6Ni
	RLcfzd1PkV7zSqGHp1VIdtGvVFgHSgqL1CNK8Zcl6vMfZAPAOfISclQ8Ulx97f8=
X-Google-Smtp-Source: AGHT+IFVW/Ecvv5VylJtmpZ1ibVfYlDl6tOT+nPM5BXn40UFothhw4La7Ky8ZpPN1mBnCFaiAR6Uhw==
X-Received: by 2002:a5d:6a4a:0:b0:366:e991:b9ac with SMTP id ffacd0b85a97d-36bbc0e3a2dmr5264157f8f.14.1722822255957;
        Sun, 04 Aug 2024 18:44:15 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd059e44sm8290202f8f.70.2024.08.04.18.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 18:44:15 -0700 (PDT)
Date: Mon, 5 Aug 2024 02:44:14 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240805014414.6t3puvhudklwbhaw@airbuntu>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240725011907.3f5ropfai3xoy3l3@airbuntu>
 <ZqmRveI2HDK0BkDi@slm.duckdns.org>
 <20240801131735.rihobmnwszsqrdxw@airbuntu>
 <Zqu5fgU73-tDMk1d@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zqu5fgU73-tDMk1d@slm.duckdns.org>

On 08/01/24 06:36, Tejun Heo wrote:
> Hello,
> 
> On Thu, Aug 01, 2024 at 02:17:35PM +0100, Qais Yousef wrote:
> > > You made the same point in another thread, so let's discuss it there but
> > 
> > Don't you think it's a bit rushed to include this part in the pull request?
> 
> Not really. It seems pretty straightforward to me.
> 
> > > it's not changing the relationship between schedutil and sched class.
> > > schedutil collects utility signals from sched classes and then translates
> > > that to cpufreq operations. For SCX scheds, the only way to get such util
> > > signals is asking the BPF scheduler. Nobody else knows. It's loading a
> > > completely new scheduler after all.
> > 
> > But you're effectively making schedutil a userspace governor. If SCX wants to
> > define its own util signal, wouldn't it be more appropriate to pair it with
> > user space governor instead? It makes more sense to pair userspace scheduler
> > with userspace governor than alter schedutil behavior.
> 
> The *scheduler* itself is defined from userspace. I have a hard time
> following why utilization signal coming from that scheduler is all that
> surprising. If user or the scheduler implementation want to pair it up with
> userspace governor, they can do that. I don't want to make that decision for
> developers who are implementing their own schedulers.

But schedutil is based on PELT signal. Capacity values, RT pressure, irq
pressure, and DL bandwidth are all based on that. And adding them together is
based on the fact they're all the same signal. I don't see it compatible to mix
and match.

And we have uclamp for user space to influence the decisions based on PELT
already. I don't see the need for another way to influence the decision.

Is it not desired to reuse util signal as-is? Or there's a problem that
prevents you from reusing it?

> 
> ...
> > That's not how I read it. It supposed to be for things that alter the kernel
> > spec/functionality and make it not trust worthy. We already have a taint flag
> > for overriding ACPI tables. Out of tree modules can have lots of power to alter
> > things in a way that makes the kernel generally not trust worthy. Given how
> > intrusively the scheduler behavior can be altered with no control, I think
> > a taint flag to show case it is important. Not only for us, but also for app
> > developers as you don't know what people will decide to do that can end up
> > causing apps to misbehave weirdly on some systems that load specific scheduler
> > extensions. I think both of us (kernel and app developers) want to know that
> > something in the kernel that can impact this misbehavior was loaded.
> 
> We of course want to make sure that developers and users can tell what
> they're running on. However, this doesn't really align with why taint flags
> were added and how they are usually used, and it's unclear how the use of a
> taint flag would improve the situation on top of the existing visibility
> mechanisms (in the sysfs and oops messasges). Does this mean loading any BPF
> program should taint the kernel? How about changing sysctls?

The difference here is that you're overriding decision, not just hooking. It's
like live patching the kernel and using fault injection. There's a very visible
side effect.

A BPF program can qualify to taint when it leads to changing the control flow.
The particular case here is not a passive observer case, but it is an active
overrider. And of a critical functionality. That's why I think it should be
treated like an external module.

sysctls don't change the control flow in a way that is decided outside of the
kernel.

The schedutil problem is an example of how there's a visible side effect. What
if the loaded scheduler decided to ignore uclamp hints for task placement or
potentially any new/existing hint/sched_attr added/present? Or if the system is
HMP and there's a loaded Energy Model but the loaded scheduler doesn't have
Energy Aware Scheduling support?

IIUC one of the goals of the sched_ext is not to have to keep everything happy
in favour to optimize for a specific system and workloads without being dragged
down with all the other things that can come in the way.  So the inherent
breakage, AFAIU, is by design.

And once this is in we will lose all control over what people will do with it.

> 
> > > It's the same as other BPF hooks. We don't want to break willy-nilly but we
> > > can definitely break backward compatibility if necessary. This has been
> > > discussed to death and I don't think we can add much by litigating the case
> > > again.
> > 
> > Was this discussion on the list? I haven't seen it. Assuming the details were
> > discussed with the maintainers and Linus and there's an agreement in place,
> > that's good to know. If not, then a clarity before-the-fact is better than
> > after-the-fact. I think the boundaries are very hazy and regressions are one of
> > the major reasons that holds up the speed of scheduler development. It is very
> > easy to break some configuration/workload/system unwittingly. Adding more
> > constraints that are actually harder to deal with to the mix will make our life
> > exponentially more difficult.
> 
> I wasn't a first party in the discussions and don't have good pointers.
> However, I know that the subject has been discussed to the moon and back a
> few times and the conclusion is pretty clear at this point - after all, the
> multiple ecosystems around BPF have been operating this way for quite a
> while now. Maybe BPF folks have better pointers?

Fair enough. I think I just want to highlight that the fragility extends to
failure to load as well as things suddenly stopping to behave as intended after
a kernel upgrade. If we all agree that wouldn't constitute a regression that
can impact in-kernel development and Linus is onboard with that then it's all
good.


Thanks!

--
Qais Yousef

