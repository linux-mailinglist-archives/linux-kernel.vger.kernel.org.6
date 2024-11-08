Return-Path: <linux-kernel+bounces-401311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3DA9C18A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32963282D38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E611DEFC2;
	Fri,  8 Nov 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxFDh7BB"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D331C8FB7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056537; cv=none; b=pqK4UnKACFAvNU+daCtJYDjVYHUg0ouufMsTrdnFZIGjG7FhboAPhIlUwHvrqN2NLmdFyc/ficet9aOQyWT2OTaJoXBMCxVApTfACS8tuBDL6L4bEqZxEraiZmV4TR5ipyrNF62KR2Q2e9QRXQE7cEKRh+aM1fZKTYOiF1QZvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056537; c=relaxed/simple;
	bh=e0ar2akuQ4yPNjTVzD+8tFLeqFSlNrAnmEJZk19FFzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOcwhvVfXk++TToiB4VERRmwtiPvv3rPi6MkMW91YJKexlXBKJPZ/zKShhAvyvquS/JZoYigx9E4Ykwuy3GBaeZlZ+9X1gnVzjZSlOMjJrYnUysjSTnTjF7iWAfcc5YdJdtOvGj+QZRRF+0WySz+1NUTxcHwig0f5pzIL7UWxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cxFDh7BB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1374097a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731056536; x=1731661336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e0ar2akuQ4yPNjTVzD+8tFLeqFSlNrAnmEJZk19FFzQ=;
        b=cxFDh7BB3oQgDgwDxCoi96SlnyHumJdH2QJJ/vjp5S6s5YOl2UfxjwbRCzqruUfQ+a
         /pEM3zYaGm9xsP7YsNEBLoGEuEvs/0JJLeAkMmA+1Ggh2YLV22+/tuVa1KjmowUVTepz
         UmsNo5YSkgRCzrpnwY29nqeu8sl78l4tjuNdFdqIDWHbOOoJfvok0fhiZh4jJzIMIiMC
         KtDm9MxGlHC55QaqsEwZuPiK5cAz9ymmPNVb2XZ36F3BMnD7WrpQbON4F3Yd7ijAsaBS
         niBQSGE1IOh0j4ANrDQ1Ox65v/DocDcb4pkyDlUJbZ1kuIKPZ4QbE+LTcV951s3iB1ZX
         lPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056536; x=1731661336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0ar2akuQ4yPNjTVzD+8tFLeqFSlNrAnmEJZk19FFzQ=;
        b=MSQAZQmYZbK24cWjUON6hP6WS6I4w/WcSesDYB/fHnsKUT2DAkWyiOlIciTC290K3M
         UAWACJUIA7RNkBmng/DvZOZ2dOA4eXmnfsJdlj9y0hK+gNjWcJGSuVF9x1PVCvDX9BJf
         ud6YwlmtRa0raWMtiJHtpFnUl1EfWHJ4t9YWWyXrfLlaIeTrkQS55w7zY/sQYUWwzck3
         dLHCuexdWT/xu0aq3JIXS81vmlG1EF8AZaL/7WfMHYp3MPnmxp5mq+PRblGpHfqEm2mc
         AA+ePmbwAKUwBEaFg88LIJSqDVb8gs9emOApERsb0bCMZK5MyVvi3KN4GrHt8I0IuBOL
         KXDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhGoYKlloGdwI3aRkPjxrNoGt3sF7Yrh9h6wOBEi04mVqu7Oq8xe4ouZ/hZ/JljZ+sb/hiE7+66kg4IvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OfLAOg+5M3dURDi3abfKAKIEEpcLxlEdV9z/4gLSLywYhac8
	wcPxZ0AL8XJ2mXl6xttIl08s23ZtU5nBvlwqxhZCbjcBE63qnJETiAb94UGtehtyZTyjFlmrJgK
	7kt0ffULHlYjI7pUtNSCOpYDnprSRY6tmScYWaw==
X-Google-Smtp-Source: AGHT+IHRq7ANL0Hjah2V5pTxTI52J+vUI+VdXTu5rCWnJtNvrFwWWtg771qERrkf7ajgWilpO0BT4cXZNmAOd34oAAQ=
X-Received: by 2002:a17:90b:3941:b0:2e2:d239:84be with SMTP id
 98e67ed59e1d1-2e9b166bc4dmr2928882a91.5.1731056535814; Fri, 08 Nov 2024
 01:02:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
In-Reply-To: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Nov 2024 10:02:04 +0100
Message-ID: <CAKfTPtCjax48zq3dzuupfrz52Q5TVF=kYSm0t35kT=E4QJGQ7w@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Saravana Kannan <saravanak@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, 
	K Prateek Nayak <kprateek.nayak@amd.com>, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 08:28, Saravana Kannan <saravanak@google.com> wrote:
>
> Hi scheduler folks,
>
> I'm running into some weird scheduling issues when testing non-sched
> changes on a Pixel 6 that's running close to 6.12-rc5. I'm not sure if
> this is an issue in earlier kernel versions or not.
>
> The async suspend/resume code calls async_schedule_dev_nocall() to
> queue up a bunch of work. These queued up work seem to be running in
> kworker threads.
>
> However, there have been many times where I see scheduling latency
> (runnable, but not running) of 4.5 ms or higher for a kworker thread
> when there are plenty of idle CPUs.

You are using EAS, aren't you ?
so the energy impact drive the cpu selection not cpu idleness

There is a proposal to change feec to also take into account such case
in addition to the energy impact
https://lore.kernel.org/lkml/64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com/T/

I still have to finalize v2

>
> Does async_schedule_dev_nocall() have some weird limitations on where
> they can be run? I know it has some NUMA related stuff, but the Pixel
> 6 doesn't have NUMA. This oddity unnecessarily increases
> suspend/resume latency as it adds up across kworker threads. So, I'd
> appreciate any insights on what might be happening?
>
> If you know how to use perfetto (it's really pretty simple, all you
> need to know is WASD and clicking), here's an example:
> https://ui.perfetto.dev/#!/?s=e20045736e7dfa1e897db6489710061d2495be92
>
> Thanks,
> Saravana

