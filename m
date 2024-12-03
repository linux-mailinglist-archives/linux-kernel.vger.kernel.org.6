Return-Path: <linux-kernel+bounces-429555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D193C9E1DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DCD165D06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876031EF0BD;
	Tue,  3 Dec 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HrlWxcGJ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D66192D98
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233090; cv=none; b=ENhEwa2qVBZkG9IQBxPt6hxeSjiOxZJiy7T9pkHgWTDTck4bsQY0ZddBMEKoCJ8TyGbKB5waYTgRu/z+SQIC08FkRH0ahwttPZkcrbdPIMUQqI57Dw8RAeSwhfRAnqu4ownwJQ+zBlt1FuL38gxBpDRaDGcjnFKZMPt9IJpQJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233090; c=relaxed/simple;
	bh=BK9EMFFUmQt94ueQdBCeFAsYzxzFvEnB3LfHxs+vGA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/cb1tCMcqDD2eynSppO242LTpukYrmJyFyBt7sUTQ0NBkWyxdEemAgewBJA05fklbgJH4rVudYLA+RrOLpiaWPBGG2CN9K0YcoYyeqTKWOj/Ky10nuqwUNQ6DH02JOyo0KntGETRYK0AE6KXpgiqD/XPbpFvxPD05znZjlu7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HrlWxcGJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee69fc0507so3215079a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733233089; x=1733837889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NwlaosO1U0DCRirLa5PaPUUowYNT1D4iNIy8ORrAD8Q=;
        b=HrlWxcGJ+FERklLSa3J2IKmPQ0mlrA23fjrEsCOhJnX0uSpFhi2qtGkOlrVZX3jtjJ
         yVqw9FD9VDC5EFHj5C9h/AnOWZFAXv7A7TLIuhDLWAkdTXfR8Xcnii/0zzGGSJmUMxsE
         h0BnSSGTROXeGgpY3bKwAWwi6wwhpWpT5tGOqBDXg8DHO1adyCiEIIUnXxgX7n94zejz
         t37G+2vGSSRjwLMfOK6ga/aK1xEA00dEN5dyWWewRDYmSoQ7/CWrVvz5YOKrY7w/Bf56
         NxbqkrtSW0oUlM3UH2urNSV2y86p4ZLLvSxUc/au6ucw0Na3MVnmshVDSZQz9IhLkmmy
         fxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233089; x=1733837889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwlaosO1U0DCRirLa5PaPUUowYNT1D4iNIy8ORrAD8Q=;
        b=NwXlkSe1YAigrexOhFd38P1Y+XbHgpgyFrLfC81CYd2etwhE2QLbMxGRnQlkFcj5eg
         Mo44vIY5XM7zNLeH9R+6ADRdguPya9lSC7o1ByEH/8i8PcTcIlPGTP0yXh5tGM/xYvBw
         xvBQp8HM57wqK2uRMEoslaGNG5VP4FHC2nAC+2Bx5gBTkrajqlUP0C5uumo68BBdik/f
         1sn8JEUc5RkT5OL+ojy3Xin/xT1G2tqi/2+nAMNDCmJrKjxNJ0feFoEyx98/wFv2PJ0D
         PW5moxOieGMxGBcwwTHid5q1Hb7T84eKaVl5FPEBJdSvk4bVT9bpVS8ahrkz5UnmKCTo
         IxcA==
X-Forwarded-Encrypted: i=1; AJvYcCWtJ5mbZ675L3z9X1bgbJmbwiUOomVEzy8IiQfWaxs6j24nfQ6sy8LOjCJibO/9b6rGDe5BZiB57qPBMGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgtc/mYrdvRBSZg9bWi0ALn0qBHuE/su1p+n07RceFVDJJpb2U
	u8dN3WSz9PO/DNUMRCJaRb9B8DaEJVb6Y221Uf/GOreUshRQqqKJMugEHkfHGEJOKJzTP+5keAl
	HIt2CEzb3TlLOrBKw0knT1ujoPHdaoS9+qxTM4Q==
X-Gm-Gg: ASbGnctzaJJWFFa30fmqiwoTs6Bt9CIXX0U4FQoho0gQB2qxnMFNCw2eAXVwqooV7rB
	+WmKGsxk5cGZZwQzOOrztG6iEK/jGrNGWrZPDffpK3n7QfAaRSGt7rfz/jj07
X-Google-Smtp-Source: AGHT+IGPNE5Glw1txeLFREPKRSaxJ2MSc7QUep+tAbsfq7Llvfy8h138D8ZNPjQfBGi3kG7MoQBCB+hCBXzdWJP/zfA=
X-Received: by 2002:a17:90b:1b06:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2ef00f15e0amr3694727a91.0.1733233088643; Tue, 03 Dec 2024
 05:38:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202174606.4074512-1-vincent.guittot@linaro.org>
 <95b655c2-dd60-488e-ab07-c7b958da1457@arm.com> <20241203111819.GB21636@noisy.programming.kicks-ass.net>
In-Reply-To: <20241203111819.GB21636@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 3 Dec 2024 14:37:57 +0100
Message-ID: <CAKfTPtDsR=Jha0atajjcYAvPSQ5y8gDX8orGUWuZ6MO7OOt4xA@mail.gmail.com>
Subject: Re: [PATCH 0/11 v3] sched/fair: Fix statistics with delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, pauld@redhat.com, 
	efault@gmx.de, luis.machado@arm.com, tj@kernel.org, void@manifault.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 12:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 03, 2024 at 11:41:47AM +0100, Dietmar Eggemann wrote:
>
> > with the following nits:
> >
> > (1) 01/11
> >
> >     Proposed 'Fixes:' missing:
> >     https://lkml.kernel.org/r/c82ed217-cfe4-41a4-b39a-e7356231835f@amd.com

Yeah i  forgot to add the fix tag
Fixes: 11cc374f4643b ("sched_ext: Simplify scx_can_stop_tick()
invocation in sched_can_stop_tick()")

> >
> > (2) 08/11
> >
> >     Would be helpful to point out that we lost the only use case for
> >     'cfs_rq->idle_nr_running' with the advent of EEVDF with:
> >
> >     5e963f2bd465 - sched/fair: Commit to EEVDF
>
> Done.
>
> > (3) Using nr_running on rq/rt_rq/dl_rq and nr_queued
> >     for cfs_rq might look strange to the untrained eye.
>
> Yes, but keeping nr_running with new semantics would not be less
> confusing and potentially more dangerous.
>
> > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> Thanks!

