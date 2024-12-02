Return-Path: <linux-kernel+bounces-427114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 735EB9DFCDF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE5CB21378
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B37E1FA15D;
	Mon,  2 Dec 2024 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLVCsCZy"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948F1D6DB5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131087; cv=none; b=JlSCYgqIkVY52P1NF+uruofjG4233IoYOM7CcUW0uOYT/jX+1f2E+F/DE/SnI0GfVUtuFp0YaMm0IBUiUix/t11+3MH7R7J/aK+fxcJzaTXC9CiKJHTuczB3ADZ2NbAAo8Q2Fc5bCb+W03PfCgm95ZfQfXWdpenaItHSzzSGsEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131087; c=relaxed/simple;
	bh=S/nzLrLq8GsDZK1jqvO0PeYLnDGOtFpRQ8POvEjJxL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEPUNb+rdwc8n9x79EaI5XDMBkLeRdBKZC7zne4SnHrJxtnliijmnrhH3s3qVX8MJ7iFM11M68VSJV9MHrY7CGZ7R8piHQu6VJJXaH9r8/7AyQpA3pyfWfZbWqimLY+GVlnSQSyiBuSsI7Z3QNkwu138efswGezUsNXNR6XqWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLVCsCZy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2eeb64f3588so654132a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733131085; x=1733735885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ccSIPqCm+FoEQbw662vqcdHVO6YT4cgJWGVzikvkskk=;
        b=KLVCsCZy4n6SqUo86itGydA+S3q7Tw98OPqqdmBFeDBdv8z3cCz1fubEhcrNWneoEO
         Xn3dr0R0eKpxvvDwuHQalPpNEDlXTa8NkdYJAWlYfh9tdxbO2oNIEcHm7eThQqW3mGC2
         AL/KJIslMQsANlrgjrrHqGWZq0uytYDXSCupEWRFR0JPzwvWnWhX3Cgng0lopGVKLRPJ
         K+/5aPpR3SaeB65Xxd+wqgzVIDp5fx9o1kGJLw0G3vJYQCKiEGJijWcmrYKRWY6O+XBf
         iLa+cx1l5nJ5jCIf62PQ7tBKfdCLh7VKGZN/NLSfOyXgclTBaGGreMqLz7UFIg5S0Y3v
         TbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131085; x=1733735885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccSIPqCm+FoEQbw662vqcdHVO6YT4cgJWGVzikvkskk=;
        b=odp/sjyb9ljupZ5c5fjZZuOk1Oy/xAa8N6fCCsYS6S+t7CGJEj/p/DVSigdi4CZhRi
         BTS0ZcTRR2mC1aFUERSkgkAT4llSnotSdWwuORnVF+TvO7EwM56VxuU0h7x1n3pEkSQn
         OgT/vYn10m+HBa8YSnELgpHHMf3HHHUOaweygmQBPHyoy6k9UDqgtBBjFUhKVnd5xavZ
         546Z0rLNmRTNfckFR+e3G997CthZ+tgMCGzq2HB41gFisVQpPrGZz2V9HfKajzuZzAwZ
         pIfGjLgCIHNQ+NE6hQSctcGw2vIO0/gYs+5fjoHz9vLbyH6r0IXV5GzorJDYFcc0w+aT
         FCYA==
X-Forwarded-Encrypted: i=1; AJvYcCUg9c+hnsrIOWGeSvMoA6HMHzOU+6wpXcBzRMjDiPBaDSJiR8AqFe6gWAY/inuQM7isC3wEYTPAk8X2fS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVXfPO0HuOoFAwXvStsD3r7D1yA02T0b1SAyM4WWTr7aXIFgV
	qSXZGGrz/XqvK7KhztPXHy6Zyk0ditsm2rFgOMTlkJn66btCTyUCInFYT3WNywealT+Ylg8TStc
	kM4vuQ5S94xwtUapZ67s+gekYPFSwBDahSdADhA==
X-Gm-Gg: ASbGncv3b8pw3x7DF05hX/SRS4tF6bzh3ZyvkZAAjkbN/uwi8R6h7NIWTgpcuWvXKNw
	nqqTQ8SYGyRZAWnvJQicxHXZIEYCbx6coHq6R+DCyBoHlgf7NxCGKpf6puHvu
X-Google-Smtp-Source: AGHT+IGJEK1PPkajams4wbaAVGv4vMdkj0aENq1aK/vjQY+GnCQTfm/KAkOxJsACki2zF8flFWzVkJXCNdl09xVHlKs=
X-Received: by 2002:a17:90b:2883:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-2eec04a44e6mr5121422a91.5.1733131084587; Mon, 02 Dec 2024
 01:18:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129161756.3081386-1-vincent.guittot@linaro.org> <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de>
In-Reply-To: <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Dec 2024 10:17:53 +0100
Message-ID: <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
Subject: Re: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
To: Mike Galbraith <efault@gmx.de>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	kprateek.nayak@amd.com, pauld@redhat.com, luis.machado@arm.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Dec 2024 at 14:30, Mike Galbraith <efault@gmx.de> wrote:
>
> Greetings,
>
> On Fri, 2024-11-29 at 17:17 +0100, Vincent Guittot wrote:
> > Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
> > lag has elapsed. As a result, it stays also visible in the statistics that
> > are used to balance the system and in particular the field h_nr_running.
> >
> > This serie fixes those metrics by creating a new h_nr_queued that tracks
> > all queued tasks. It renames h_nr_running into h_nr_runnable and restores
> > the behavior of h_nr_running i.e. tracking the number of fair tasks that
> >  want to run.
> >
> > h_nr_runnable is used in several places to make decision on load balance:
> >   - PELT runnable_avg
> >   - deciding if a group is overloaded or has spare capacity
> >   - numa stats
> >   - reduced capacity management
> >   - load balance between groups
>
> I took the series for a spin in tip v6.12-10334-gb1b238fba309, but
> runnable seems to have an off-by-one issue, causing it to wander ever
> further south.
>
> patches 1-3 applied.
>   .h_nr_runnable                 : -3046
>   .runnable_avg                  : 450189777126

Yeah, I messed up something around finish_delayed_dequeue_entity().
I'm' going to prepare a v3

>
> full set applied.
>   .h_nr_runnable                 : -5707
>   .runnable_avg                  : 4391793519526
>
>         -Mike

