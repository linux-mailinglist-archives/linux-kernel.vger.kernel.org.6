Return-Path: <linux-kernel+bounces-427192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFEC9DFDE7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FADB23018
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F31FBCB1;
	Mon,  2 Dec 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ib9WVpMC"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19001FBCB8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133493; cv=none; b=oZK44pd8x1IRPz2YmzYzBeccWyw8mtfSV3RKMhv3+gDW9t79YeXxCtcnxC5wP9Gtq47V4oAaAMnfjp2BRrHM1za2lj29xhyLYSZFfJ/NHXfyMQSWjoWNKso5jj3tSH4F93v/Y+BayfhbTJXskjNUzFRYYiPibvVPxccZNmuHit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133493; c=relaxed/simple;
	bh=Zcz9TbZMiUU6L8rA+zm71CkiQ3k+DUbus7jcc8A/7cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrOdRaTRVJsgLPxGtLch+g9hB/WO7oJoC/+qiC18eR7iFzKRmPCoUgOlem2rMJQD1hkbn3D5nY5N8x4R/ne3ZqkWXmJcgvZRnjFMwjfJfV6evU0kY1+Ic2mjAbHlg7KvHe+ASIoyUY6qUsz10T2hXupu6ErK8QOMjGZ5snq02q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ib9WVpMC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc1f1748a3so2424270a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733133491; x=1733738291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcz9TbZMiUU6L8rA+zm71CkiQ3k+DUbus7jcc8A/7cg=;
        b=Ib9WVpMC0XXo9vxQB2YlYjvB5dUHR3mzbSTdl+hVarM4h/nSyFF8+A+XmiEHGVrS+r
         18Jmw3Vl9OdoFEGM+91/3lLB6vzyPN5wYfMY6uOyJXD7ZWMBdBTpvNcsWjUxR/dnLqwW
         yHEjNrZPAQqByH0OMjrA/A+g/rLo+V481InzT+BlUjvWdwnXaMVJYfqAzSU6xfP9SYzd
         m2x1C/AkZZcoCGI7pHgFWCbZnImVezHGEqrTuLC/hMfX86lUTGyvAVwxI3grhhayYvx5
         MtPUgtEleQwT7K/xlRKsi2D3jYLdZuVvVR4TJNO3bdmI66D9lUEB3LFOpZePOakpEvzQ
         HCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133491; x=1733738291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zcz9TbZMiUU6L8rA+zm71CkiQ3k+DUbus7jcc8A/7cg=;
        b=QYntqY122qgtgVrTWhYCgnVXet1fFOaNdJQhhlMbgElq4P/wzIbUIs+yU8lIUeXdeX
         NzX3wQn417IqY8f3ap+Rd285rIkI8qtMWDCOLVIovczgjomrLoSgJo+rgM3yrlXU56ue
         YDRerFd4Ak4YmRPJIEJ0OmljnGuDms7sRAmXxtpoBVY39dLrLOL7p4lk+ka50T0OcwMT
         Y5vO0MHcxuKO+2cZy9an1OqMDIr+p6zNyW5N8nCD3lP3tv/3Md8r/Hn0gSp/u3c9tpU/
         5BVsV2rPpz9WVSddjiTZpfEZuHnonho2jQjYjMbUx7eq9rszHfUnm9tANxm1014aWfFv
         GJQA==
X-Forwarded-Encrypted: i=1; AJvYcCWP69ThvX3M7FiWZeasuc7KJduQVOehTN7GN/tXh7d+PbIYjck2CgHbS9L23dR5gUEvT1wu/90985wjY0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyASgZuO57l4H5hC0vaIXwbZqg3q9+xwg/fze1WzEeiBZlhFb0e
	pBqHOtZ9WpS+0ayCOhayFKfy1YhDGegQDOUiXGUqB9JiMODwFqvECcO1dEbbV1QNcIoGpGYhtHa
	bmdn1HGKGSN3y4fH+qt+F31R4AaQzHHesaXUI5w==
X-Gm-Gg: ASbGncv4udK/RTQ5aK67LXSiLrhY9zglKVRakJTcWfuKtMb2DZSptatFMkLq+7PMznw
	Aa8uL7Rxi6OG5DXz99YN+NXRnT5mBFcAvgFycuRg4aht2FPTowVw9WKHEiQ0c
X-Google-Smtp-Source: AGHT+IHx7L2GmxsW2EdKD+pTX8rNGLwtK/UOT72P7gPMn1qDLN+vLM1EKzVgDxRKQPtvlJX2fXtXRHkAQE32+/t8woc=
X-Received: by 2002:a05:6a20:728f:b0:1db:f823:109f with SMTP id
 adf61e73a8af0-1e0e0b51404mr37874497637.31.1733133490876; Mon, 02 Dec 2024
 01:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <20241129161756.3081386-4-vincent.guittot@linaro.org> <20241202095401.GJ24400@noisy.programming.kicks-ass.net>
In-Reply-To: <20241202095401.GJ24400@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Dec 2024 10:57:59 +0100
Message-ID: <CAKfTPtAJh=e0dci7sKNOBuyEoYY5v0TqFoa4YeJ1X7VTzTeT4Q@mail.gmail.com>
Subject: Re: [PATCH 03/10 v2] sched/fair: Add new cfs_rq.h_nr_runnable
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, pauld@redhat.com, 
	efault@gmx.de, luis.machado@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 10:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 29, 2024 at 05:17:49PM +0100, Vincent Guittot wrote:
> > With delayed dequeued feature, a sleeping sched_entity remains queued in
> > the rq until its lag has elapsed. As a result, it stays also visible
> > in the statistics that are used to balance the system and in particular
> > the field cfs.h_nr_queued when the sched_entity is associated to a task.
> >
> > Create a new h_nr_runnable that tracks all queued and runnable tasks and
> > use it when balancing the load on the system.
> >
> > h_nr_runnable will be used in several places to make decision on load
> > balance:
> > - PELT runnable_avg
> > - deciding if a group is overloaded or has spare capacity
> > - numa stats
> > - reduced capacity management
> > - load balance
> > - nohz kick
> >
> > It should be noticed that the rq->nr_running still counts the delayed
> > dequeued tasks as delayed dequeue is a fair feature that is meaningless
> > at core level.
>
> Since you're doing a v3, could you please split this into 2 patches, one
> adding the accounting, and then a separate patch making use of it?

ok

