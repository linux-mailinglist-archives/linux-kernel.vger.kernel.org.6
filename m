Return-Path: <linux-kernel+bounces-297488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772D95B927
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA728518B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C738A1CC8A0;
	Thu, 22 Aug 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIGjM6yM"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB841CC891
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338695; cv=none; b=WYQ9/ehJydyZ4rdOAb5A/GbbvJaUNUxvF/QGsEGAQl5/ry2wqI7Yyj7B4d9/yNuylXEJRe7wdQfbh/+ay3lOMGKdoFdCoVFHTpKUbKvBKRjH/ah6+QGlmc8t8JK4DYnr3QsY4KdMcUYGJ/dutIX0rXRVmKJlEBVOUuDEn0QhPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338695; c=relaxed/simple;
	bh=pcwH8aGPMs5tBc6ZGRP//bIqRFQZ1ST6Zm6/q7fmsSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TISbJfoOR+IUcd8+Ft40FtlRuGPyJyn+aQjeBqxpTDso5GZMnzYgf+nfTDKjmNLhwq4AB08o4m74bOT7FkzVIPlaZCasHiowH+lELHVxPAnzijfFGWFPeXjkdxDDiOQibL0RR4ADvTY1rmMEsrGmWqYJrMD6tVdFXEEmB9BKqrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIGjM6yM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c99033d6so719983a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724338693; x=1724943493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pcwH8aGPMs5tBc6ZGRP//bIqRFQZ1ST6Zm6/q7fmsSQ=;
        b=UIGjM6yMqJux8b3Z+EsvjUB6fxovH4fhNYuvQgul15tHlbAaWCdgnY0LTQ2G5qgPan
         dZI7KgRvXZec0BNuO9jCehw/qBF75dhFV57YN7JW5GkOCGYwnGwRbKfNsVrUxNPtb5I+
         DZ5ld60lZUOxyC3aEdcwYNZnD5dqGP28LCgyoMCAkwe0Y2coouj1PD26zNPamZ/4ynY1
         kgjeJ4Im1SY/8oQoSnm6VnaInkfuuKW3mZYetToyZVUaOsjgz58BGkSVTH6N14ryunDW
         EFyWJWv0+ur1L94x0qZTmyacdJOa5NreP/I0cLfQ3nwPx22/R/tU3grPBHGLTY5CHBuh
         9G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724338693; x=1724943493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcwH8aGPMs5tBc6ZGRP//bIqRFQZ1ST6Zm6/q7fmsSQ=;
        b=vabP+eL+TGB/s9kzf3nMFmLBHQG/WDM6ihRpVX6i3CFOc/gCZ57muZXY8PdD6jcVkz
         eZTDiMNREvV2la3vffT0J1zcXxUHjcOfBnYWLyZXbgBFPfPgzEJo9g/6yBYsVqzLU/Lr
         8SFgKGmSlgW9OOF3yutUaeLOKkBId6N52wU6OslxA3rqusjOD/ie5hi4tc2ZcDlM8THP
         UkjQKqIqSe7SeKUvNKqZSXWvyRBtY06uyD/7DMInKwH6bhKao2pySxnEMtf7c8ah2OkR
         ULgPSTcczrMBnf4vXvxK0jm6PnCDAQjE+eGuwd5dqWbDwyMX17ebraUeYq+zy695dPZj
         SLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz9ez9kufLXVUgl2rIry60GMyJXXvvFbDjg5sq0ylQ7zZgl15nWaZf11V0YFcR78c23OzUmJp6lJbnyQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvgJEU06djeh4TA6OSkt118LeYg8Kq8fu9q6VDbfazn+nIoIZW
	uMo5EfVpMydYzp0xH3BX4UJrBsfiqCw6uaNHeC8y8sIZSOEn1hRiwuzrvlL/btfnLrXIo+LqogX
	idh96YXtOjGho0iPUibwXppp31VZYtwyIkQYQSQ==
X-Google-Smtp-Source: AGHT+IFBzA7sUk7HKZaKD1z7zupkeCJ7fKQC1YOkxg0hMk+U9wAWDGq8TT9eJZylSTxao0ffA4E2UYLi1VIrl+zq68E=
X-Received: by 2002:a17:90b:1643:b0:2cf:28c1:4cc2 with SMTP id
 98e67ed59e1d1-2d5e99c5a30mr8037115a91.3.1724338692703; Thu, 22 Aug 2024
 07:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com> <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com> <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com> <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 22 Aug 2024 16:58:01 +0200
Message-ID: <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Luis Machado <luis.machado@arm.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 14:10, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 22 Aug 2024 at 14:08, Luis Machado <luis.machado@arm.com> wrote:
> >
> > Vincent,
> >
> > On 8/22/24 11:28, Luis Machado wrote:
> > > On 8/22/24 10:53, Vincent Guittot wrote:
> > >> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com> wrote:
> > >>>
> > >>> On 8/22/24 09:19, Vincent Guittot wrote:
> > >>>> Hi,
> > >>>>
> > >>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com> wrote:
> > >>>>>
> > >>>>> Hi Peter,
> > >>>>>
> > >>>>> Sorry for bombarding this thread in the last couple of days. I'm seeing
> > >>>>> several issues in the latest tip/sched/core after these patches landed.
> > >>>>>
> > >>>>> What I'm now seeing seems to be an unbalanced call of util_est. First, I applied
> > >>>>
> > >>>> I also see a remaining util_est for idle rq because of an unbalance
> > >>>> call of util_est_enqueue|dequeue
> > >>>>
> > >>>
> > >>> I can confirm issues with the utilization values and frequencies being driven
> > >>> seemingly incorrectly, in particular for little cores.
> > >>>
> > >>> What I'm seeing with the stock series is high utilization values for some tasks
> > >>> and little cores having their frequencies maxed out for extended periods of
> > >>> time. Sometimes for 5+ or 10+ seconds, which is excessive as the cores are mostly
> > >>> idle. But whenever certain tasks get scheduled there, they have a very high util
> > >>> level and so the frequency is kept at max.
> > >>>
> > >>> As a consequence this drives up power usage.
> > >>>
> > >>> I gave Hongyan's draft fix a try and observed a much more reasonable behavior for
> > >>> the util numbers and frequencies being used for the little cores. With his fix,
> > >>> I can also see lower energy use for my specific benchmark.
> > >>
> > >> The main problem is that the util_est of a delayed dequeued task
> > >> remains on the rq and keeps the rq utilization high and as a result
> > >> the frequency higher than needed.
> > >>
> > >> The below seems to works for me and keep sync the enqueue/dequeue of
> > >> uti_test with the enqueue/dequeue of the task as if de dequeue was not
> > >> delayed
> > >>
> > >> Another interest is that we will not try to migrate a delayed dequeue
> > >> sleeping task that doesn't actually impact the current load of the cpu
> > >> and as a result will not help in the load balance. I haven't yet fully
> > >> checked what would happen with hotplug
> > >
> > > Thanks. Those are good points. Let me go and try your patch.
> >
> > I gave your fix a try, but it seems to make things worse. It is comparable
> > to the behavior we had before Peter added the uclamp imbalance fix, so I
> > believe there is something incorrect there.
>
> we need to filter case where task are enqueued/dequeued several
> consecutive times. That's what I'm look now

I just realize before that It's not only util_est but the h_nr_running
that keeps delayed tasks as well so all stats of the rq are biased:
h_nr_running, util_est, runnable avg and load_avg.

