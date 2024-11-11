Return-Path: <linux-kernel+bounces-403928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE369C3CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58D71F2137E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9151185E53;
	Mon, 11 Nov 2024 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7CJ96WJ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A812EBDB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323738; cv=none; b=JIr0YQUnWaRCxHeBDoVBPs+XpYRgqlAwk0FeJQvHURCJFNQ8aDTY9jiFBIVp5cw8WIBwoEFwXNkSWuK1NMVx54L3zSLbHs2R0G0NZJmUT5pfo05ZqmD7ir4KG/lH/RgLzgLHMFj3BUeC3Jmmzf1Br1uqvFI6gFkek6Sk98ENqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323738; c=relaxed/simple;
	bh=mZ/ARLqLov2Jgx+SQL1giQ6yKDvj3sVaHQWi1+NY48k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXIPpBRvh8Cuml3alvb/UY9JSP0gxdLYRC+zPxXdxBQlC2Z+A6BlEZYRomgTLc/SkAwQfh7TdmkIlm4jaDKTYQJ6FwHk2A8kS/N3y+rL9YPNkHDpZnD428yBoho/N1vFbKGj/xj7RcHC2Q4wQrwm6dusouKvsnoKCALhFGkDtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7CJ96WJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2869074a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731323736; x=1731928536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ/ARLqLov2Jgx+SQL1giQ6yKDvj3sVaHQWi1+NY48k=;
        b=J7CJ96WJwc01tDfci7GTNJYH5eAezqhNPw/cC1YGfR9toSIEXk3GWyfh2iXClZM8Qv
         ZTABrDXYpq0Swu5B5yRg8dZAXpZ543eW1F3tdpkKlzJLuFuKPjQz+P3qqMoRQ053+I1c
         9N+IyxsKFesQ2eXxUMGpC2e0XjCCd6BkcS97pffNHPwpQvZNPOrC1dgrMxnX9bcIQvT5
         ///ixqGYEeAZJDsWUJYmMvolEU0gHS7OWJXPXFqQ1BZiU7xu+V6QebD26HMGjx8KRBiy
         rym74DI3r16Epe+ZT7pbyQjdBTq7RrsIJa5BdQSWEaXAbUvDrijcU5rQX0qjU1mP8VPl
         m7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323736; x=1731928536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZ/ARLqLov2Jgx+SQL1giQ6yKDvj3sVaHQWi1+NY48k=;
        b=hUTovwxNUZqXn/wOfWd8oFZTEVtlicTdZzOH6CaSX6DPF2Vm85aqCvmL0ncwYJXQIG
         3YaK0CMviY13PnyLUpSqpIVh0ltuywbkFmq9dVDZPLGZbnMqEa6AtyDwrL1HJR1ntygN
         hq5qbP3AFM62kL+I0T24352pETbpcYwEoz1uIamReQVUxXzCG2OAMtfBd6ZFOykSq9w3
         dmN7D/aybMs1HIQq3IQkgtD/0otTrKQLJNLc4Fvmffzf1F+IOmJ7p4E7l5hI/fquhrWy
         A7j5nWCoP5lM5EhwzEmdh7z0+muhDIxNf5beKULjsr8CYc50vhFcUj2t/TxRex2ignuR
         9bJg==
X-Forwarded-Encrypted: i=1; AJvYcCW7qyl/LPbXy4f798V4gM2csH0llU3MwqWtNtiRK91T2w80etzsujbSocvRQSKNEIsomKDdSHIXavFTJm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3lPke0ZYSBbrTGq1prYOlREqvLpoO/fee5HiefUf2CZ6JHdJs
	lk3pXNeDZXLDXtGJlF+R7QooEvoh6nWauCyEjbpggnmCROTx/I7lIEDiGRZT2aqMsL2omy/vjmK
	WW0oX0aYbWUWx4Yt1/slDLhgShZFDkM7K+qIu6Q==
X-Google-Smtp-Source: AGHT+IErgNUsHwFEPcw1LDgnmP/37mQ9gLeIMsJqdNcIBi6T7tQt5CUK2zvQ5jLJG37H7WOe+k0BWZi9y5dco1D/m+U=
X-Received: by 2002:a17:90b:4b91:b0:2e1:d5c9:1bc4 with SMTP id
 98e67ed59e1d1-2e9b165595cmr16888328a91.7.1731323735734; Mon, 11 Nov 2024
 03:15:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net> <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com> <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
 <20241111104054.GE22801@noisy.programming.kicks-ass.net>
In-Reply-To: <20241111104054.GE22801@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 11 Nov 2024 12:15:24 +0100
Message-ID: <CAKfTPtBHRdHJaT_bjx1RF8bJ8Vc2s582VXMACPyjOno8zE_g=Q@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Saravana Kannan <saravanak@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>, Tobias Huschle <huschle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 11:41, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote:
>
> > I actually quickly hacked up the cpu_overutilized() function to return
> > true during suspend/resume and the threads are nicely spread out and
> > running in parallel. That actually reduces the total of the
> > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
>
> Right, so that kills EAS and makes it fall through to the regular
> select_idle_sibling() thing.
>
> > Peter,
> >
> > Would you be open to the scheduler being aware of
> > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > overutilized behavior during these phases? I know it's a very use case
> > specific behavior but how often do we NOT want to speed up
> > suspend/resume? We can make this a CONFIG or a kernel command line
> > option -- say, fast_suspend or something like that.
>
> Well, I don't mind if Vincent doesn't. It seems like a very
> specific/targeted thing and should not affect much else, so it is a
> relatively safe thing to do.

I would like to understand why all idle little cpus are not used in
saravana's example and tasks are packed on the same cpu instead.

>
> Perhaps a more direct hack in is_rd_overutilized() would be even less
> invasive, changing cpu_overutilized() relies on that getting propagated
> to rd->overutilized, might as well skip that step, no?

