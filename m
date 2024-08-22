Return-Path: <linux-kernel+bounces-297232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84A795B4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDE5B24419
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF221C9437;
	Thu, 22 Aug 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xt9iDE3c"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66819E7D8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328623; cv=none; b=cbO+pOAus1ixr92SeudyWsVjE1PQ9kL1YzRvwn2iNnygqeC/lLVw+hAisZRoneCocucUAaSKJ92HVa4mZ+h7LxGhcMra22jLHHZ1JVc4hDkgjo6+56ETPaURJwv/SEDmen2O38Hm6frgTaFJGvkBtuVihknmYfAlfO0OiiE2AuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328623; c=relaxed/simple;
	bh=cZbi6E3zYpkmuMMRAwriSk90MqE4ycdc/iftnXTk0ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4BX6nPGGu7QkioRrhzN1uuexmOI/9ehqBjFoEQbZQ98Z+SL9+fKeVebZ13z8oDC60NK43VaOluJM2pScN3OB72r10YA3WiLkkQ2aYqsBaI4lMnBTOXQhK/OQ0jazvfGO73RDxMTIo1PAfnJ6GyZJTywOoP9ClRUy6SVXdLNfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xt9iDE3c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3c05dc63eso575130a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724328621; x=1724933421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZbi6E3zYpkmuMMRAwriSk90MqE4ycdc/iftnXTk0ks=;
        b=xt9iDE3cSpdQBEwYZOnFterzfHFtU83SyGrqtnqm7PL2G4zkpEnai1Ft23CeGZpVUa
         w/U4Z+54v7T6XKdLvQhnjoByqLgNA/TDd2By+tHqKLsGpb6n6sQGczenUUWUTBF7TN2H
         NfVpR4beaIOjQCbI37Grcf8JjAGsZ1U2kwP+s2eMXCqhTLfb7FIPlm/+ml170YKepfBC
         MR7/DyoEoVUgU+xlx7PS3DvNaRQ0wJ4XVfhJRirMMrdXHJtUfLQkZUMxsXVuEfGKa04C
         m6AgF0DBjRFu00FzI92ECWIwBnFWO33LMe7snI8JKaI2ouNn60aTwLpvFIeXMS2z6tfp
         4Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328621; x=1724933421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZbi6E3zYpkmuMMRAwriSk90MqE4ycdc/iftnXTk0ks=;
        b=Q6ALsKWzi6JoPfXqCEusPBjmaCGcAJZNyiXa0uH161zG+dltJoPd2YZ34t2I1V3z5y
         JTs85PrANpIG7eGL/spaSEOcZ2WdLAwJB/6VPAhSsnXxjJJ/hydCdN6drYV85o8cfWf6
         yGCsabFTLOOhvqU/FxslmYlKKkQ+1UdaNw9XiFAYQF7wTsG5cGAY081jMhSjtdjIlGqB
         +V0VeOfz5uV2123z7gGPtZSp4VLDm/FzWz5rBqqcHImC1bNGsuqMGktKowUroCruansf
         OEtSK7qoGiKUk61g7FtM6R8C4KBmYdET0fZTTwj6l/DSWh9CdwzVFP6BgFieyDZOlidc
         uGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJI+1oOkWyshzLZMidXQFW4aAVig7eRwgqdjJBbR20NkrZIy5KIu3LYO5onJAHjZBN0f/Sm4f6EcNq2RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNx0rZMvkUjD6wQNVPGTUOS252i/wOphnPf4V1m8G6JEy6x+yK
	0vH0G+fSjTMugheQnBc+eFkTpeCSQsr9OCZTj0jglMsLHwkabVGmcZoyf2witRKB34evoF5AXFf
	lV7GOvgafawZ8AU4cxyayyvOLDZR+c5w3jztMZQ==
X-Google-Smtp-Source: AGHT+IHMm8a011bLaobecPO4NMAjtVWZ0tiU3xv/5npurU3SJxwOX0nYa6ZkNdKLEn19zwOPmFy8bOhBvq+5+26sWe8=
X-Received: by 2002:a17:90b:33cb:b0:2cd:55be:785a with SMTP id
 98e67ed59e1d1-2d5e99f9c60mr6267336a91.1.1724328621003; Thu, 22 Aug 2024
 05:10:21 -0700 (PDT)
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
In-Reply-To: <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 22 Aug 2024 14:10:09 +0200
Message-ID: <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Luis Machado <luis.machado@arm.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 14:08, Luis Machado <luis.machado@arm.com> wrote:
>
> Vincent,
>
> On 8/22/24 11:28, Luis Machado wrote:
> > On 8/22/24 10:53, Vincent Guittot wrote:
> >> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com> wrote:
> >>>
> >>> On 8/22/24 09:19, Vincent Guittot wrote:
> >>>> Hi,
> >>>>
> >>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com> wrote:
> >>>>>
> >>>>> Hi Peter,
> >>>>>
> >>>>> Sorry for bombarding this thread in the last couple of days. I'm seeing
> >>>>> several issues in the latest tip/sched/core after these patches landed.
> >>>>>
> >>>>> What I'm now seeing seems to be an unbalanced call of util_est. First, I applied
> >>>>
> >>>> I also see a remaining util_est for idle rq because of an unbalance
> >>>> call of util_est_enqueue|dequeue
> >>>>
> >>>
> >>> I can confirm issues with the utilization values and frequencies being driven
> >>> seemingly incorrectly, in particular for little cores.
> >>>
> >>> What I'm seeing with the stock series is high utilization values for some tasks
> >>> and little cores having their frequencies maxed out for extended periods of
> >>> time. Sometimes for 5+ or 10+ seconds, which is excessive as the cores are mostly
> >>> idle. But whenever certain tasks get scheduled there, they have a very high util
> >>> level and so the frequency is kept at max.
> >>>
> >>> As a consequence this drives up power usage.
> >>>
> >>> I gave Hongyan's draft fix a try and observed a much more reasonable behavior for
> >>> the util numbers and frequencies being used for the little cores. With his fix,
> >>> I can also see lower energy use for my specific benchmark.
> >>
> >> The main problem is that the util_est of a delayed dequeued task
> >> remains on the rq and keeps the rq utilization high and as a result
> >> the frequency higher than needed.
> >>
> >> The below seems to works for me and keep sync the enqueue/dequeue of
> >> uti_test with the enqueue/dequeue of the task as if de dequeue was not
> >> delayed
> >>
> >> Another interest is that we will not try to migrate a delayed dequeue
> >> sleeping task that doesn't actually impact the current load of the cpu
> >> and as a result will not help in the load balance. I haven't yet fully
> >> checked what would happen with hotplug
> >
> > Thanks. Those are good points. Let me go and try your patch.
>
> I gave your fix a try, but it seems to make things worse. It is comparable
> to the behavior we had before Peter added the uclamp imbalance fix, so I
> believe there is something incorrect there.

we need to filter case where task are enqueued/dequeued several
consecutive times. That's what I'm look now

