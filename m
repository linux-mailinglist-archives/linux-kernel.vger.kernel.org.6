Return-Path: <linux-kernel+bounces-558116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC6A5E1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408F6189406B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998B1D9A54;
	Wed, 12 Mar 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHuRRp/l"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11821D5176
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797328; cv=none; b=mU10hv9V9A+hWzCMb2TbY0dL4tNT7wsZmN520B+hd2nI3gEy3GASOjhQ4Dv3NowtD7yDMJ0QfNR7LAfas+CN+vwVQx0Ka/pk7ksb9sBYkR5yfNF+9ol/od3fSvxW7GY/nPnfwXOPhZTDV4tcjKl9jRCO+d1Io6/MET0PszcQ57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797328; c=relaxed/simple;
	bh=UYkpRTWnYTcy6VNSm8Hp5pmyHaMFPJlI/HeDB2DKHNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEvDyoGsWzd8XNef//BtUpIg60IP9znWsCL2NhimIIGGdxhHKP7D1RK3peTWRO1EXT0DXV4CUBqgc/8YH8rXKTdr8VJZ6pQuNm78/TtvSl5TURxOn87DtyLezjBE9Y8k/aCukAs/+9yS8CsfC5BQx48W3azgJ3L5aHpB6CTyr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHuRRp/l; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso11822766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741797325; x=1742402125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UYkpRTWnYTcy6VNSm8Hp5pmyHaMFPJlI/HeDB2DKHNg=;
        b=KHuRRp/lqYKv7bDeK9hEc4ioGf+0cYiDW9xO04IfhhSTUScFmH0XjVSpsbWxdi1uQK
         Ax+RSeg4EdjpgeYNiEDmSD7CgUMSfS5qVUDmND70gewCQW+7g483RTXcE33DgInm8EKF
         zNfrZL9FKhbyBqiA593tjM0XemDTTk0LGvoAKOHPgAtSwDoRIRzN3Z9YNdA0wg6k6QXJ
         nf54x4n56Flwk8yVUW5K+740n8Vpllah7ErqqCeUhzZYP08sCrX7OE+Ysv0P1Xd0ZdQl
         Za+vI7jbUhVmC5mIGkGKODN6Sjt1SQyUGH/YTpOvYrHbI+eGDTzo77DdARfZWoAeOC1t
         WggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741797325; x=1742402125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYkpRTWnYTcy6VNSm8Hp5pmyHaMFPJlI/HeDB2DKHNg=;
        b=E9pVIg3udLgGUa75YrBk0OxqIrGQmWf5sIz5Hd6KXzRIlwIEiEk8mDzD6Lvg66baED
         pGveByGbaaptK7KzExW5epUGdzHsdSUS5ggYXUeNXqY/UD1vu5PxnvOxQOVQ+YedyPK7
         cZSfqmPz/kbzqLZvTh9qDiTIG0FY/JbNF9YfZAUeYW7h3BGx/c6pnrfv/zkrQ4kN4ab2
         hG2SeN4Iacj/EqM970y2IL+hh0iDVFEUepEBi+BR0Iy4PsVdBGo62aYoYEN4aA2o934t
         XdKI00YLp/XfGez5cBpP3I/WnMMft1cj7KJjiFolLWg91pMNkDODSGxJrH3pX0/AeLMI
         jOvw==
X-Forwarded-Encrypted: i=1; AJvYcCXioTU6UNVGrVdrtSj5uoay/kkhRxser8pm7Y5GVnqj+cAuMnnicRQ9GWTDYIpLsyfFrNuEWEYywjE0FZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUDpJBFt5eyZmUSNZCojiSGgPVwQZHd5U259NOVeVlgyYXGKI
	l4nafK6sBD4gRfOxuuH5E+jCaXvU6OQ8jABuSSJkhHrvVbm/QIBEpc14pWxtgUdwx56XPKgLxGb
	dv2PU6b2NDwt2+MdohfEQwxgXwHAWEjWBBBTmFw==
X-Gm-Gg: ASbGncv3kCWL3sn3TDqV4+BzFpoaTSmT59aqeBCt0/bTlU5jKwSnV7HuFlYWN+agjlW
	kCvJWr/1pmQrUX6oAQW7Lv1XVcFRkmRzEzP/TyXiqOcdpF5lZLWl7u7rt6ka5heGSKeytIg0cXa
	vj2k0vJtgPZHBvyNoc3AAui2VrP/O1mfxsRJ/yHzOu+6fFkVarO24X7/M=
X-Google-Smtp-Source: AGHT+IG31q9EagidG38iCV5xE/9KlSfHAUGx0j88kEP1K2EprTJ8xzrAo9Bn2TVlCVJMa/0tUMClXxH9FaExojBZFHM=
X-Received: by 2002:a17:907:7251:b0:abf:7a26:c478 with SMTP id
 a640c23a62f3a-ac2b9ee6effmr1145478266b.47.1741797324839; Wed, 12 Mar 2025
 09:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
 <CAKfTPtCfd_=gm7rsT_qBL8pw5uybEvYH4N2tvxpKndxxi4L7oA@mail.gmail.com>
 <8ddd7bb2-3a18-48b5-85c6-23263134308a@arm.com> <CAKfTPtD9DwWquFN6G8BXAii7HH5zJeEXiUjE8ma-eHdEqeHzdw@mail.gmail.com>
 <51d24e59-247d-4b66-9ddb-4b9f0f53497b@arm.com>
In-Reply-To: <51d24e59-247d-4b66-9ddb-4b9f0f53497b@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 12 Mar 2025 17:35:13 +0100
X-Gm-Features: AQ5f1JqB3jJOpflRFkU4HAS3doZaJ3Qhx-Y-3G4C-F5mNRpr-_-J6BIP63XxBwI
Message-ID: <CAKfTPtCpZ8yOA_=SQwB4PGEKpUVaLbVOQd+AoMMpOPCV_o2niQ@mail.gmail.com>
Subject: Re: [PATCH] /sched/core: Fix Unixbench spawn test regression
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hagar Hemdan <hagarhem@amazon.com>, linux-kernel@vger.kernel.org, 
	wuchi.zero@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Mar 2025 at 15:41, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/03/2025 17:35, Vincent Guittot wrote:
> > On Mon, 10 Mar 2025 at 16:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 10/03/2025 14:59, Vincent Guittot wrote:
> >>> On Thu, 6 Mar 2025 at 17:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> Hagar reported a 30% drop in UnixBench spawn test with commit
> >>>> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
> >>>> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
> >>>> (aarch64) (single level MC sched domain) [1].
> >>>>
> >>>> There is an early bail from sched_move_task() if p->sched_task_group is
> >>>> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
> >>>> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
> >>>> (Ubuntu '22.04.5 LTS').
> >>>
> >>> Isn't this same use case that has been used by commit eff6c8ce8d4d to
> >>> show the benefit of adding the test if ((group ==
> >>> tsk->sched_task_group) ?
> >>> Adding Wuchi who added the condition
> >>
> >> IMHO, UnixBench spawn reports a performance number according to how many
> >> tasks could be spawned whereas, IIUC, commit eff6c8ce8d4d was reporting
> >> the time spend in sched_move_task().
> >
> > But does not your patch revert the benefits shown in the figures of
> > commit eff6c8ce8d4d ? It skipped sched_move task in do_exit autogroup
> > and you adds it back
>
> Yeah, we do need the PELT update in sched_change_group()
> (task_change_group_fair()) in the do_exit() path to get the 30% score
> back in 'UnixBench spawn'. Even that means we need more time due to this
> in sched_move_task().
>
> I retested this and it turns out that 'group == tsk->sched_task_group'
> is only true when sched_move_task() is called from exit.
>
> So to get the score back for 'UnixBench spawn' we should rather revert
> commit eff6c8ce8d4d.
>
> The analysis in my patch still holds though.
>
> If you guys agree I can send the revert with my analysis in the
> patch-header.

This seems to be the best option for me

