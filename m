Return-Path: <linux-kernel+bounces-198023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F28D7285
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779CDB20BEC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2A2E3EE;
	Sat,  1 Jun 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="MYhmkv99"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E71D555
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717281083; cv=none; b=I/vDF++Xf86yb/k7MxObGeTOzUIjZ7zynFssFvWxVZMJIKLcPC2eA8OWdos0Am0HBsb7SO0onraY0CzdrIltyNhHTuX00e6ZQu0v6oRXladCaCXuA3tTECMHTkOmbQk9PxA023m/KylBa31576HTLmFapeoSJkcv5LauUQwdP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717281083; c=relaxed/simple;
	bh=rFMuik6wkuNtXHKGkspgDvdX4YfRw4xUp9eXj1XXAhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/ca38V6517+FUPaiJOzuBSfou7OEeSVgpnmTBN5lkJwhEMYcKYvKHo+FB+yIEb63FP4ZBbGC+YRpg0uz9bRh+u3ZHoP21OcjmV/LckfDoyK8LljYrTd4HLhbrD4fdcqq4fgA0STCSJ/uULGlG8PQkj1lQIlWDyPQllL09V9PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=MYhmkv99; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so29114225e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717281080; x=1717885880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZbo561XfWIHgBvmySekggiN2gQefSMXY05ZVlA1bQk=;
        b=MYhmkv99Py0Rw7R3dokFE2DHOdLz+jBfVd7JHnSMN+gBAigWSfisLJ7lp7OSRK+648
         M9cGT8Hzcw9YtOs+2IAEsJzvrg/dr5l5M4BwRvSEG5Mg8Dykjg3SYW61uT+l+9xH+u8g
         igwcLlZDXO6eQJwC3cIaWq4zL50Kvgb/WsHE7tnoAyfuo5groLcyA+5D4QDY4YNo6VAq
         khRAuIzfkB189pmVoejSQTLJSvCQ8b8On3yIBYXUZX/o6CEAiIK2vklR3RsYyUu0s9/E
         NnPXJDRT5TtRMnGDg9Cm4PR0Al98cLn+uiQ7HaZoVWYb6viOVJ4IttKdCht1zGX8WMSi
         Xexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717281080; x=1717885880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZbo561XfWIHgBvmySekggiN2gQefSMXY05ZVlA1bQk=;
        b=gL7XR2l8lkzwjalxG8PK3KUx8VeQM01Bs1+8mq6iCsMAadUwAwD0lGrTviN5BMDrlq
         k01J2RsDdyJl+zduYbvwAmauQkCjngPLowywCvPzxzhs3g2FILuDD8uUdxU+ocn3lL2m
         TLtpPf8eEWliV1+aukMxrWcCPNK97NWNnwsSkeMV/CIg4RNdMAvn8nmAynNetDQa5kqc
         P5wwMTmjJdf/UXp+Rz3e18EqWAypkXRjWysIcN2AMDjgkB3UoyUxRwbsWyJWhAxPRZTq
         8vAVWQifF0/6HFhmcNM5YdL2y/Ni+P35PKpz2uenuOqYc5gbW3jPaWzOqIK7Dhk0gN69
         JnzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDj3qJ4APJ18NDI22tB5RWztRB1xWYm+a0X/OINC+7AObsniRhdNv/1+XBcf7YYx2t2uI6R6OY10iUoOviRgSYe207SIs3rZpT2kTM
X-Gm-Message-State: AOJu0Yy3oPkJF1SA+y4wZpNsukcP82d39ibCCcruDRu72V3fEy1p7PRL
	gsHZ2sjuvF5gBHIjee+9lgiVVdAJ2xdCZulVSfOf43iI3OCQKi9BECgsFwLMEcY=
X-Google-Smtp-Source: AGHT+IHfbQ16/ESCbDfdhRvNrgQE37C2AAjcr2HQe1Exqfame6Csvm3T9BWb8bjJaVLiJ2lhT2dYFQ==
X-Received: by 2002:a05:600c:a4b:b0:421:1165:f240 with SMTP id 5b1f17b1804b1-4212e0bfd91mr46367175e9.36.1717281080159;
        Sat, 01 Jun 2024 15:31:20 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212f05157esm53941435e9.20.2024.06.01.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 15:31:19 -0700 (PDT)
Date: Sat, 1 Jun 2024 23:31:18 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240601223118.zjhp7pgk3wb32abv@airbuntu>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240521110035.KRIwllGe@linutronix.de>
 <20240527172650.kieptfl3zhyljkzx@airbuntu>
 <20240529082912.gPDpgVy3@linutronix.de>
 <20240529103409.3iiemroaavv5lh2p@airbuntu>
 <20240529105528.9QBTCqCr@linutronix.de>
 <20240530111044.d4jegeiueizvdjrg@airbuntu>
 <20240531063016.OCMg21Uq@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531063016.OCMg21Uq@linutronix.de>

On 05/31/24 08:30, Sebastian Andrzej Siewior wrote:
> On 2024-05-30 12:10:44 [+0100], Qais Yousef wrote:
> > > This is not consistent because IMHO the clock setup & slack should be
> > > handled equally. So I am asking the sched folks for a policy and I am
> > > leaning towards looking at task-policy in this case instead of prio
> > > because you shouldn't do anything that can delay.
> > 
> > Can't we do that based on is_soft/is_hard flag in hrtimer struct when we apply
> > the slack in hrtimer_set_expires_range_ns() instead?
> 
> We need to decide on a policy first.
> You don't want to add overhead on each invocation plus some in-kernel
> ask for delta. ->is_soft is not a good criteria.

The suggestion was not to check policy or priority but dictate the behavior
based on hrtimer properties set at init. Which agrees with your thinking.

I think the check for policy at init to enforce a behavior is borderline hack
by the way and better to get an explicit request from a task and let the
HRTIMER comply adequately without checking for policies anywhere. Whether this
property should be inherited or not is a good question and I think is the
policy you're after here. Proxy Execution would probably handle all this
inheritance problems transparently, so we need not think much about it if we
agree proxy execution is the way to deal with all those inheritance problems.
There are always exceptions though.. So worth a think.

I'll drop this patch as this discussion has diverged to something else now.
I'll leave this here until others get a chance to comment with their views too.


Cheers

--
Qais Yousef

