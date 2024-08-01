Return-Path: <linux-kernel+bounces-271337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1330944D02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F694286543
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97831A3BB6;
	Thu,  1 Aug 2024 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="iudRQRmE"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B61A38F9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518261; cv=none; b=UP4Iq1leN/CXsCOoAfc7nSlVPmxarn0a7QWaO1il+rQ721/lbXRGamgfsgRbJ7iCOzqYIOBhElU7zJ8C6wtEIAsFWlPyN8zAw7+511ZL9ZlmiT4Hck3k0cPGtX9Bd3eJb6wbRMHBcN0HGEpdsy9Noi2OMgIdoJsL4xPTqTZphDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518261; c=relaxed/simple;
	bh=c6kkNqWl5a1/yrT3FtxGBI/+mAy7QfEfmbre+U6aX+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcoVp5g6vyZsLGm5ppRJugfcz3v3LUglORoOhyaJdbwWxKck83ZqjI6Forj9tSTlphVDWHIHX+c4orPhTGgiyLGM7XFW+D/L8mOE9s+EgBGR28XJ87eRHsjLD9XYC27I1Z2vUv5c+xynAlGPaM+Eare6IzGspehG4VyjgungaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=iudRQRmE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso81078631fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722518257; x=1723123057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1ye/vhD7tygpEMWoHcsNfXJGIWN0S+1GdxnPc5ZtuE=;
        b=iudRQRmEh4DcImBxtbSjvX7o+2OJgprGekyOGUcLi2fz2F7z5sSbfs6xHkJZRhD89/
         eUChECCBl+olzCspYkIFLAURBrWCmiQJZStPAcIjjJUA6wEi3MOU72WfHiYRKjrgm+gL
         Of/2HHiD66OjfcCILncsRZF34tKlDFOMGjMVw9xqYVZbrkFIZbLX3qrPg5QqdohhsA4E
         WdSyAWXzN30M4y/TASH61suRzxTXRGYFS1wCyPXSsvQzEpifmnlQF7YSmtO7GxjdrMFr
         II6t7BI93sNpewktvnIMOtoLzJjTaWl5JPDOf8z/DHh1rSfZ8E3Ec3Atn0DElbZcG8QV
         WAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518257; x=1723123057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1ye/vhD7tygpEMWoHcsNfXJGIWN0S+1GdxnPc5ZtuE=;
        b=YFuX4CULmbg0sulh+cbcfWB3ixvs/3beu1vv6qLW/6v5S+eVPl0X9ZCUfcd1nG6uDi
         YdIxLah7iFrnkQidRz0eILvK9rsPKlZs0RvaCxrL+cpTC80oyEUos5jhfdQ9pgywVu9H
         s/dEpLug9HH4QeWqLzwuTKwxiyJLySBJjkG6QDOfDqemomOZpxAnqGXPbOizDkitZIsC
         DmRTJEUFAmTiLjnd4JxXgDBptEi6Buvcxb+xhHY8+yD8+FEh+YAHQKA05m+T8z5JxFCi
         ejn13cJn04u1dRQoJig1kCBNp3mlW3lMQTcpRTY5+9PSFVOFLHGpkRLZPwvr+bKNT/YR
         d9PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNkw5JS+/B9EqNu1Vx/9rNsH9Haw/kFIXXJGiWxGT1oHD3K3XI4R33XD/XoSJxL3UPJuY6148I4w00dhP4HnPwboU0+XQmwul/JpbW
X-Gm-Message-State: AOJu0YwvH1fTPXLTZNE6p9F/hO5w7Tt2/j5nFt3JaX0zgOhVaqx7D8A6
	JTL6V8EmpZDeBn13aoohZSxDD8cKhaYJ+0Tg/4t+O2zMGLJi3yY+wajE1Y2iwjE=
X-Google-Smtp-Source: AGHT+IHvisgghxY7EJSGPrnyUs+4j5SHauvCxNyJ+FJFBwdAya1L4PYA++vIyGWKID6PhA6gQfAq5g==
X-Received: by 2002:a2e:9a81:0:b0:2f0:2e18:e7d0 with SMTP id 38308e7fff4ca-2f15aab0ad1mr1709691fa.28.1722518256886;
        Thu, 01 Aug 2024 06:17:36 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb226a5sm58254135e9.47.2024.08.01.06.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:17:36 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:17:35 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240801131735.rihobmnwszsqrdxw@airbuntu>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240725011907.3f5ropfai3xoy3l3@airbuntu>
 <ZqmRveI2HDK0BkDi@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqmRveI2HDK0BkDi@slm.duckdns.org>

On 07/30/24 15:22, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jul 25, 2024 at 02:19:07AM +0100, Qais Yousef wrote:
> > We really shouldn't change how schedutil works. The governor is supposed to
> > behave in a certain way, and we need to ensure consistency. I think you should
> > look on how you make your scheduler compatible with it. Adding hooks to say
> > apply this perf value that I want is a recipe for randomness.
> 
> You made the same point in another thread, so let's discuss it there but

Don't you think it's a bit rushed to include this part in the pull request?

> it's not changing the relationship between schedutil and sched class.
> schedutil collects utility signals from sched classes and then translates
> that to cpufreq operations. For SCX scheds, the only way to get such util
> signals is asking the BPF scheduler. Nobody else knows. It's loading a
> completely new scheduler after all.

But you're effectively making schedutil a userspace governor. If SCX wants to
define its own util signal, wouldn't it be more appropriate to pair it with
user space governor instead? It makes more sense to pair userspace scheduler
with userspace governor than alter schedutil behavior.

> 
> > Generally I do have big concerns about sched_ext being loaded causing spurious
> > bug report as it changes the behavior of the scheduler and the kernel is not
> > trusted when sched_ext scheduler is loaded. Like out-of-tree modules, it should
> > cause the kernel to be tainted. Something I asked for few years back when
> > Gushchin sent the first proposal
> >
> > How can we trust bug and regression report when out-of-tree code was loaded
> > that intrusively changes the way the kernel behaves? This must be marked as
> > a kernel TAINT otherwise we're doomed trying to fix out of tree code.
> 
> You raised in the other thread too but I don't think taint fits the bill
> here. Taints are useful when the impact is persistent so that we can know

That's not how I read it. It supposed to be for things that alter the kernel
spec/functionality and make it not trust worthy. We already have a taint flag
for overriding ACPI tables. Out of tree modules can have lots of power to alter
things in a way that makes the kernel generally not trust worthy. Given how
intrusively the scheduler behavior can be altered with no control, I think
a taint flag to show case it is important. Not only for us, but also for app
developers as you don't know what people will decide to do that can end up
causing apps to misbehave weirdly on some systems that load specific scheduler
extensions. I think both of us (kernel and app developers) want to know that
something in the kernel that can impact this misbehavior was loaded.

> that a later failure may have been caused by an earlier thing which might
> not be around anymore. A SCX scheduler is not supposed to leave any
> persistent impact on the system. If it's loaded, we can see it's loaded in
> oops dumps and other places. If it's not, it shouldn't really be factor.
> 
> > And there's another general problem of regression reports due to failure to
> > load code due to changes to how the scheduler evolves. We need to continue to
> > be able to change our code freely without worrying about breaking out-of-tree
> > code. What is the regression rule? We don't want to be limited to be able to
> > make in-kernel changes because out-of-tree code will fail now; either to load
> > or to run as intended. How is the current code designed to handle failsafe when
> > the external scheduler is no longer compatible with existing kernel and *they*
> > need to rewrite their code, pretty much the way it goes for out-of-tree modules
> > now?
> 
> It's the same as other BPF hooks. We don't want to break willy-nilly but we
> can definitely break backward compatibility if necessary. This has been
> discussed to death and I don't think we can add much by litigating the case
> again.

Was this discussion on the list? I haven't seen it. Assuming the details were
discussed with the maintainers and Linus and there's an agreement in place,
that's good to know. If not, then a clarity before-the-fact is better than
after-the-fact. I think the boundaries are very hazy and regressions are one of
the major reasons that holds up the speed of scheduler development. It is very
easy to break some configuration/workload/system unwittingly. Adding more
constraints that are actually harder to deal with to the mix will make our life
exponentially more difficult.


Thanks

--
Qais Yousef

