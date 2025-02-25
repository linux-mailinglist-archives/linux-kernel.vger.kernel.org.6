Return-Path: <linux-kernel+bounces-530924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1DA43A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA353BC6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43383266EFF;
	Tue, 25 Feb 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOThd8BC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7A2641CA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476750; cv=none; b=p2tVu6cQ3+9sPmoMGNG/TxWIKAvblK7xHbheZz5EsSEKn1yvCury9acQojLAqA2bt62e1YdohdOlZjMieNIrtAk54Ngzc0kWS2GmPIpcAs/xdy/+eouLCr8cgWoTjyd2UnQiO1GPS12cP54sdKXcbc2QbxCAXbaECtnniheFCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476750; c=relaxed/simple;
	bh=bsdbdybJum/9TKHMpxJaYeBEjyIt+O6OA8vVk7UB/0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BezWktMzgNWiS4OvqZ9ctZMqDwLFqzWiiwJLaAQ9Ac6EZzL+j4/KrRJMQXmgjd5F7IyVxvR/99jW0tIgAP3Mru6bqaxS3Mz5DzHsCo0xKQMvei1GkS3zF8Gz8leYRApVZMkwl4s+tVW82YLYk0FWBhTIlaqepD6kCPTWgr/P568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOThd8BC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e0939c6456so8569736a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740476747; x=1741081547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHVXaGLoHnHcEuRO0aCTBF6tz3V90gTR/4gwvCrCe3c=;
        b=sOThd8BC+JmOj2/1xyzeDc6U5CnD6IbMzhi/cxRLG4I83SduVn6AIBGBH5oPP1BXV/
         8+2nwDtwhREeBKrOoNTMQQCabqWT2qmHbrU4YptRhyUOgeEgc6M1lmqn9pMX4P+bEX9v
         9F9ewlFLRDrn257Aj2oNEUThtg0PxpX1kzeNmOue1J9bbYQ6QwqwxmocKjQHC5OhJ5r7
         g+Phnq6XMeGKTrK53UchInOiClyMTQIPXpJvikwOnIUgC7jBhhBwdU3wBoduPf3waZ0H
         bIDLmSgqF0XZ4SPaQLHgGul6uC/3SJWCFIoI6laM6HGeAo2AD5jcgtb08HW3kKXsnbvn
         FdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476747; x=1741081547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHVXaGLoHnHcEuRO0aCTBF6tz3V90gTR/4gwvCrCe3c=;
        b=pUdaez7tql0KTRE8khSf1s241eA6VSEcZPlHp/ThdBgF6s+hgmP2HccK/uw5DzpM16
         WhoGS6p8UxdnMtFs/trLnbAuwsFZakKR0UukK/N3Cdu/ywcAnEFsbrELptDEucKMArug
         Ft6oDU4Sk77/4S3EB7BRI6Sdu5H+909fIU+iVxMAjhtWn91PprhuLrGlzi6B8aomoA2/
         xuQ+66N4Mm2NMzkI7b9yRyzXVpT4afdY1w7qk9RhTzUpCL3gTvhlfBiIuU36lK/GRTyi
         Lmwbf6+8zfNT6b6Xf7R0OwX63ixw2b80xJTnCgWR0xiGD/iA/rhplmPiKHdeI/8H9dyJ
         NWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU55hAjIjZ5RDupy9uwwQyK0WPEOnHRJEzCUW4JJrxBnjXlyJ+AMvyg3hktpJCOTw8AZ7/51EnH6r53h7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLG3/lja6TovNWXD9b8wQ28x8y8fUDd33279DtCZ9TPEubPrBz
	YxlBenMU1LN6fO9v6vtVgeSlMw/zvD43jqUxOsIYZgctMlLJYBhc0IXqy75nBMBrxAKvTyQcL6Y
	7ERI4d1C/M7+jnXTqdSHpMNWR1RrvwDJ7N51dWA==
X-Gm-Gg: ASbGncu6rwRFoJJa2fgLfNpTTJhF9my7vbK0fOMkgNUJD+jB9JvkdUvg+clZpnBLdA8
	GZt4NrJ25GhLuqSGSiNygNBhI0AOK6Su3ViLPdJoULZatOh37Lcm1hHbm0Anx7QrVZu53WTXtHQ
	3WMVBkzN0uWbDWoqWuQh1rBIci3IrpL6imqZbe
X-Google-Smtp-Source: AGHT+IHy5CXUnGuuk5vTmSwlwqnhNPOn45I7gdCsEA2weqy4YQrc6Fq6PBRDF776Svd8jFTrDK4CUkwKi2Vp+4Fmcsc=
X-Received: by 2002:a17:907:970c:b0:abc:b96:7bd2 with SMTP id
 a640c23a62f3a-abc0d97d421mr1576384066b.11.1740476746998; Tue, 25 Feb 2025
 01:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202502251026.bb927780-lkp@intel.com> <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>
In-Reply-To: <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Feb 2025 10:45:35 +0100
X-Gm-Features: AWEUYZmvkDsNth2SEizMKQjlIz2X8mlnwK3RzzO7EOkh1PJdhu483jlPhyWEu-w
Message-ID: <CAKfTPtBWDFSj8E53i=qSK7kR1qsT68xLvVp4+HGr5FXrna-xRg@mail.gmail.com>
Subject: Re: [tip:sched/core] [sched] 2ae891b826: hackbench.throughput 6.2% regression
To: Chen Yu <yu.chen.surf@foxmail.com>
Cc: zihan zhou <15645113830zzh@gmail.com>, oe-lkp@lists.linux.dev, 
	kernel test robot <oliver.sang@intel.com>, lkp@intel.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com, 
	yu.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Feb 2025 at 10:31, Chen Yu <yu.chen.surf@foxmail.com> wrote:
>
> On 2025-02-25 at 10:32:13 +0800, kernel test robot wrote:
> >
> >
> > Hello,
> >
> > kernel test robot noticed a 6.2% regression of hackbench.throughput on:
> >
> >
> > commit: 2ae891b826958b60919ea21c727f77bcd6ffcc2c ("sched: Reduce the de=
fault slice to avoid tasks getting an extra tick")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> >
> > [test failed on linux-next/master d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8=
afa]
> >
> > testcase: hackbench
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.=
00GHz (Ice Lake) with 256G memory
> > parameters:
> >
> >       nr_threads: 100%
> >       iterations: 4
> >       mode: process
> >       ipc: socket
> >       cpufreq_governor: performance
> >
> >
> >   39754543 =C4=85  3%     +56.8%   62349308        hackbench.time.invol=
untary_context_switches
> >
>
> This patch shrinks the base_slice so the deadline is reached earlier to t=
rigger the
> tick preemption IIUC. For the hackbench case, my assumption is that hackb=
ench seems to

For systems with more than 8 CPUs, the base slice was
0.75*(1+ilog2(8)) =3D 3ms which is exactly 3 tick periods at 1000hz but
because the tick period is almost never fully accounted to the task,
the task was running 4 tick periods instead of 3. The normalized
base_slice has been reduced from 0.75 to 0.70ms so the base slice
becomes 2.8ms for 8 CPUs and more and the main result is that tasks
will run 3 tick periods instead of 4.

> encounter more wakeup preemption and hurts throughtput. If more frequent =
tick preemption
> is needed, but more frequent wakeup preemption is not, are we able to do =
this base_slice
> shrink for tick preemption only rather than the wakeup preemption? A wild=
 guess, can we
> add smaller base_slice 0.7 in update_deadline() for tick preemption, but =
remains the old
> value 0.75 in update_deadline() for wakeup preemption during enqueue.
>
> But consider that the 6% regression is not that high, and the user might =
customize
> base_slice via debugfs on-demand, we can keep an eye on this and revist i=
t in the
> future(we have encountered some SPECjbb regression due to over-preemption=
).
>
> thanks,
> Chenyu
>

