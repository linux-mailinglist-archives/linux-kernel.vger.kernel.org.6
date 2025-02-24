Return-Path: <linux-kernel+bounces-529156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE50A42079
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4513518997B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C1248862;
	Mon, 24 Feb 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0EHLTtK"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56021930E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403374; cv=none; b=n2IdioRdXvbw4z+BuTYfjxKKJn/WsY82xdhpbYDWyMfSdn/6YZQuxbX4AG548JatWCxcY+YX7F1Hyye5QOgZzeyBnDXJwHlFL2pMebQYSYoJHWzZOyYMR0d29Od8fC30R73rxMfhVbMrgTa1JHPDbljDOYtSR4Gd2JQM5S3GLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403374; c=relaxed/simple;
	bh=Md18jYHbMU1uicW49rGmxLiRLnLz3edIGuipGhkKr4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fsb5KHSLjoWyfpjCGggj16h6CYN+DaYF25+3wnAKmwhrxbFsuMO1GNzlUilnxKpe+oDUj4phzX6iAV5RG+YoKMzrGTtHxkWC+RlT3AaigzyY91mgRCmYQUQm11uTeLy87dNNovTPvJqQu/H47V64ODXnF5g5XV/SCtjSV7HD+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v0EHLTtK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so7386492a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740403370; x=1741008170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1M0wMuuaoOnZdxqIm96dYAaieAQWbi+rly1G4/VORZM=;
        b=v0EHLTtKn31bLf3J1swX22gpYBzcfKqy3tr186q5byzrpT/ponICPKhJrCIe3+lvJp
         ulsa3bsFFWcIsQFCFUpsgvD0WZ038DXYd3fbxEpXXjEJfIFoPH8PVrYgvpHnxwB1rVl9
         d5O9jWjIXmi7pKgVce+L/19LPBPMEpRNkGMkbMBKn9ASoUzeAXrU/bTNpE2zgCiBB2Hf
         YnK9uzOsYRAUAjZl65c7Lb+wPsJ9l60bHGbQoPQyHNjafYs0lyhhCJyBRJtWd4E6J+XG
         GK5pdU7u+jKC3On0rQ3oDlsjqBwLak3kWfxPuKA7LN0h8UgpY+Dd8Mly4TZMCgI+FJ3T
         zIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403370; x=1741008170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M0wMuuaoOnZdxqIm96dYAaieAQWbi+rly1G4/VORZM=;
        b=CPUgHj9lnvo84pz7FhkMNrm4S7K6Szl/InzIw/1Jx6oRxaJpOWxFeGPrV4BItlutni
         vEllBk6CUTqDCQMBjQWp25zxomvQbP8w4lgE7Cf0i7BUz0/O8NZlo3A7nQ+5Yj6Rjg8+
         A/y3XYLT0lpsqXA7acAwUk69Jdc6BRKy/8/wjCGcTh8Rgnzdanp7DaGpxEZVPQ5jr3Lf
         sUncVnuEov2/aQ4QHnpjJzfVzH3w4v+wzOq+Sy4VAMVGTn+rLUYRqtQnEAF8D5M45LfE
         pgH5Z0iu/wSyaPUQS2SA3z0I+bHLfqZDnAW72qCnUg7sG6m96tI0yWD6Deu1Wlvh7l3c
         O+3w==
X-Forwarded-Encrypted: i=1; AJvYcCVO7kc5DPm0ywexXLBrtH5NSCID7NUUSv4V18wtmB1aXuNFIgMNE8fpXScGQN1L7TARSGLGkyaToxYTJ9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMO3cxYYg8nUcu78DskZ/dzsYT+VsRuMEBsiPBCtYvV8Hl4fl
	S+agnYTGkIvqDArTc3+QDk6nqCfhBmylXSDyWu052UQEKbA82slQPxRVZn4w1vv6QLfRM6sFYgR
	qRAoqSYiBLmFKuHUO6d8VrcV5D4P/V53L47HQ9w==
X-Gm-Gg: ASbGncs7AiEyoLirCV6k5JPJOHO765d/xVNJIVTAjTriEYB61KY1sN9qiJI1ez8jRPO
	ta/EDbnJ8U+6GTflUCjZGhFW78wy1VEWLd7XmdlYHvp4S3pqaz3SMpJ8zF7B2fxeBBZB22/83IA
	GO0wKGxDwhThdggFSNn4ZXTNzRQZ8kUn9FrSKi
X-Google-Smtp-Source: AGHT+IGIusjTFVE4UB3pjGSbVHDFPG2dk2AEGDQnb56yON5uLxLH15GfHnKs0Ehq1eb4C7Yf6XIlip9BgRyd0qDW1Xo=
X-Received: by 2002:a05:6402:5246:b0:5e0:4c2d:b81c with SMTP id
 4fb4d7f45d1cf-5e0b7243e21mr11079744a12.31.1740403370191; Mon, 24 Feb 2025
 05:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com> <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com> <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
 <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
In-Reply-To: <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 24 Feb 2025 14:22:38 +0100
X-Gm-Features: AWEUYZmWijbqLp01XJH1zue23-1LtDAUGizFBEdTaGr6wqpsv7PEvt1Byokeeuk
Message-ID: <CAKfTPtD3YHEoGNB2_41_eeHHgrMBca8FHVhRmMuyrSCXqfthUg@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 09:45, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> Hi Madadi,
>
> On 2/23/25 2:16 AM, Madadi Vineeth Reddy Wrote:
> > On 21/02/25 21:27, Abel Wu wrote:
> >> On 2/21/25 7:49 PM, Vincent Guittot Wrote:
> >>> On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
> >>>>
> >>>> Idle tasks are by definition preempted by non-idle tasks whether feat
> >>>> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
> >>>
> >>> I don't think it's true, only "sched_idle never preempts others" is
> >>> always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
> >>> debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
> >>> others at wakeup, idle, batch or normal
> >>
> >> Hi Vincent, thanks for your comment!
> >>
> >> The SCHED_IDLE "definition" of being preempted by non-idle tasks comes
> >> from commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
> >> which said:
> >>
> >>      - no SCHED_IDLE buddies
> >>      - never let SCHED_IDLE preempt on wakeup
> >>      - always preempt SCHED_IDLE on wakeup
> >>      - limit SLEEPER fairness for SCHED_IDLE
> >>
> >> and that commit let it be preempted before checking WAKEUP_PREEMPTION.
> >> The rules were introduced in 2009, and to the best of my knowledge there
> >> seemed no behavior change ever since. Please correct me if I missed
> >> anything.
> >
> > As Vincent mentioned, WAKEUP_PREEMPTION is primarily for debugging. Maybe
> > it would help to document that SCHED_IDLE tasks are not preempted by non-idle
> > tasks when WAKEUP_PREEMPTION is disabled. Otherwise, the intent of having no
> > preemptions for debugging would be lost.
> >
> > Thoughts?
>
> I am not sure I really understand the purpose of this debug feature.

I'm not sure that it has been even be used or useful for the last
couple of years. Should we just remove it ?

> If it wants to provide a way to check whether a performance degrade of
> certain workload is due to overscheduling or not, then do we really
> care about performance of SCHED_IDLE workloads and why?
>
> IMHO preempting SCHED_IDLE before WAKEUP_PREEMPTION is to preserve the
> IDLE semantics trying to behave like real idle task. It is somehow
> weird to me that we treat sched-idle cpus as idle while don't let the
> non-idle tasks run immediately on sched-idle cpus on debug case.
>
> Thanks,
>         Abel
>

