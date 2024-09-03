Return-Path: <linux-kernel+bounces-312264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B3969435
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE641F24148
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE11D54DA;
	Tue,  3 Sep 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKDuynZ+"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354DF1D54D2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346467; cv=none; b=OZz9fnsZCzRhmvyGb4aqrDmKKgi7m1qrxv6KFYuygxzWcLAABHYnDkK7UR0IINTJcaGwlDWKr4FGGXfvtrzIsij4VZgXJJuXQ8nR7dZazypiitbjlw35wwLN5FE3ZSBUCPSFMEqbQrzL061TeEo+0PHgePeDpAhhtQJYQ6gmRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346467; c=relaxed/simple;
	bh=5sOUrIVahmmple1uIWjrF4wHQ8qBafYo39JTntoHm0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNGjogdvNYKEL7R5HHrfLpvFgWbcctZmyTjoqdQBWkbTO+xyE7vqwzIHTPhW8PZ0rSHhvpOvNnwjKRoM0OU9tZ1cOEeqwMJPGx+Ax6y37L2jOEOIEFYaaK6Z4fMMMs7m/FVDQYavV4EH6KW1kG+vkAOmV3fr65gxikpFoJNri1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKDuynZ+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so1522518a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725346465; x=1725951265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxmIyuKoW2pVhEttJGpDv883KCAqUB8WThdg5jNdn1E=;
        b=bKDuynZ+Qfg3nDbuARvIqipsUe8FQVqypeRly46JbdaGE6a+iEPLnj9AnCn4fjYf7G
         5rv4vo6qipa4cTxYNj2YJjqMtZKnmUvjw18tUe1gvUE5ih8bHfS2MRoO0LAfMuHoPGfQ
         cTz0k5Ef0GXkLfkXlET9ZiQizP0B2MTsVk8BEjKxpNoEJUpHmjpv9HMgYJtCPDQjz4GX
         UObVuVMPO60syhAWOtHhzx/F0l0uJuNFZOpjIGiUhzD7hf1zae/IaXeJisBl63TDngI9
         oLgUv4RO0YYfqCoYOIfUi7ykANWuiXKkFN9wvrWQXkaOERhJYlvZVEScE+z82vk5241N
         eapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725346465; x=1725951265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxmIyuKoW2pVhEttJGpDv883KCAqUB8WThdg5jNdn1E=;
        b=Ls437Er0bzA8PU9/VRvhIHyzZlT4uBvCyvVn54fwjJj5GPZ9v7AuOJvMk/RF4gN5eI
         geoNQgZRoRw+9jMsHR5ja+U6i+sL6WApDcvBgNz5w8XnZPGv6EWYLjf5ABtkpleNtBrd
         gs7uQHDSzW4lnUm18zVmjb4zmOrwISI3cw6elN99KdRJjv9IVC9eTwoXRnqeUG+0becB
         8kLoGy/L5w0Yiuo2WOpZZcmU6QHsKy5dgas6RjDKpDIP1+skt05sjOqQvSyB6kXEnzD8
         XVu9CjB97kzjiFvBEbphBLiN8ykkV4TMjZu103swKDSUwzClhtXyCX92MKROr9DbmGzc
         uV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjuzscSuwm2uWkoSJJyaEFfZDJWRiPXdmwqiV0VPgESIV9CbBCCR2XBJRvbODREdnmVk/rH+ZrMFnO1+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztCphDL1sRjNHaE9JUaA6CDaHInVaTPo6lRK9JfCaXOVOKU4NG
	Da+meiNJeuc6Z/ZVa5fb+YOPsMisNtYaE2yfHh3kT/0aixTYnQx4fYeYcyUt2W9dD1wiWj0WpM7
	8Q+My/wfKiP+oIpqIJCOdPp0TTP/FLj6o6+9JjQ==
X-Google-Smtp-Source: AGHT+IF4T/nByo/MxQzWDW1yMEKazLS17F5AeV+FpJArbbqMYDPHgdtn63zkls0Bkpjdz3jg3BvVB87wTIUiz4KmW4A=
X-Received: by 2002:a17:90a:cf13:b0:2cf:def1:d1eb with SMTP id
 98e67ed59e1d1-2d85617babfmr18242140a91.8.1725346465441; Mon, 02 Sep 2024
 23:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
 <20240901175149.46yfk335niccmfq4@airbuntu> <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
 <20240902125815.vu3s25ciib34eu3a@airbuntu> <CAKfTPtDr5nEHYJ0=_-3a6wVZ25TPoiohBNmhGBaZMCrYHydh8w@mail.gmail.com>
 <20240902204301.v55w7id3d2kw64qy@airbuntu>
In-Reply-To: <20240902204301.v55w7id3d2kw64qy@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 3 Sep 2024 08:54:14 +0200
Message-ID: <CAKfTPtA_L=8DtguZgTddSxSEaVLyvYWKYrrtwMmcuteP7ef9FA@mail.gmail.com>
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 22:43, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 09/02/24 15:36, Vincent Guittot wrote:
>
> > > If we have 1 CPU per PD, then relaxing affinity will allow it to run anywhere.
> > > I am just this will be safe on all platforms of course.
> > >
> > > But yeah, I don't think this is a solution anyway but the simplest thing to
> > > make it harder to hit.
> > >
> > > > The problem is that the 1st switch to task A will be preempted by
> > > > sugov so the 1st switch is useless. You should call cpufreq_update
> > > > before switching to A so that we skip the useless switch to task A and
> > > > directly switch to sugov 1st then task A
> > >
> > > Can we do this safely after we pick task A, but before we do the actual context
> > > switch? One of the reasons I put this too late is because there's a late call
> > > to balance_calbacks() that can impact the state of the rq and important to take
> > > into account based on my previous testing and analysis.
> >
> > I don't have all cases in mind and it would need more thinking but
> > this should be doable
> >
> > >
> > > Any reason we need to run the sugov worker as DL instead for example being
> > > a softirq?
> >
> > sugov can sleep
>
> Hmm. I thought the biggest worry is about this operation requires synchronous
> operation to talk to hw/fw to change the frequency which can be slow and we
> don't want this to happen from the scheduler fast path with all the critical
> locks held.
>
> If we sleep, then the sugov DL task will experience multiple context switches
> to perform its work. So it is very slow anyway.

A good reason to not add more

>
> IMO refactoring the code so we allow drivers that don't sleep to run from
> softirq context to speed things up and avoid any context switches is the
> sensible optimization to do.

AFAICT, only cpufreq fast_switch is known to be atomic,  others can
take a lock and as a result sleep so it's not possible.

Please use fast_switch in this case but not softirq which can end up
in a daemon anyway.

>
> Drivers that sleep will experience significant delays and I'm not seeing the
> point of optimizing an additional context switch. I don't see we need to get

No, They don't have spurious wakeups now, your patch is adding one
more. I don't see why they should accept spurious context switch

> out of our way to accommodate these slow platforms. But give them the option to
> move to something better if they manage to write their code to avoid sleeps.
>
> Would this be a suitable option to move forward?
>
> FWIW I did test this on pixel 6 which !fast_switch and benchmark scores are
> either the same or better (less frame drops in UI particularly).

