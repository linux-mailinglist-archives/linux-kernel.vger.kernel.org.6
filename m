Return-Path: <linux-kernel+bounces-286937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76995209A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CB41F26B45
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44A1B14F9;
	Wed, 14 Aug 2024 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOkeU9s3"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC441D52D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654812; cv=none; b=oJpYEo7p/2O2XAeL2ekkP1gvBIw4lKPLKFHntJ8thL2IwRzbXtc0xIY5QdT/L4wQq137ryIKPbCBRY0N3vmVhzIrGhPw01Q5AvzXXhVNLViiMjmOp9bGqUKH0u+rlUC0W9NhRVhqlcgCyPwxVPCgi8/d2KR7zswbGIXg+WTdzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654812; c=relaxed/simple;
	bh=/TjYJMJf/jLpWkYHkKktIgHfZFU6PBeezpMYOdjt12g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoASvWpQZYAxq70pQBOb3ReJbZjFiEb10YGcJXgpu6+qSMKoTThTMmYS3To//lPE4u89IJSWvot3eTBWbe8dG+zcKQIJBbURfjqu4AUQcyFFcqqDRWCXjXVrC/j0CqjLW++iyDinZeW71Itoibq2Z/foz1KKXuD2QGpafJH/q9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOkeU9s3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3b4238c58so501006a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723654809; x=1724259609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Txx7KE0RKDM1EV/p8gyEyET/F9IFHxWyxz2v4Ykmze4=;
        b=kOkeU9s3sTJnLGok4vUSNS06c3qMCZjBSxHe/Z+LyM3G7Egfc+wvWLXemE4vhMDg5T
         XJ0UFMHWBRzsifVysBdJlkw7FBZfGJuSz+zUwuhZTWflQVdrhvCro3uZNIQijuV/zLus
         HhQJuyXSUSMSSuWQB/8pftdPxw3HTEi9zIUgxI7zz9pOlZC+6eAbi56Af/wod6owiqtN
         udbFc73/hxy07FPXs9NOEXyMS+5PnEtJCtMiC3sRdWqrILy0MI9MUHmOdKBpe8GuAmXa
         eHNCf9R/oRJD1cV8IwVphEN6ZOGi+uXuUhK8TcRS+LAGn2hXmCqIuObJvZA+HvWqzxBE
         E4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654809; x=1724259609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Txx7KE0RKDM1EV/p8gyEyET/F9IFHxWyxz2v4Ykmze4=;
        b=dl1c6MCZuisN2Sg0iUcGJC+qQwOoo+Zm3n6HfnU5k7QQnIn+XNqUgnAMGKoo04/yCx
         oEIjwduIXLOMUC8iLHF0VWS+Bwcq8+1w/dnICggDPDQHux/jYoTYGe7iIKT+BJvNF0/r
         Wol63wYQ0PIwJbSokrkDCpfpAlGujIL/Ozi0oEznC0KYeF8dpveuArF7T1wZXa5FOkdS
         FyfIMIhnvlhKBs3f5bb/h4nrClu9kuwjHPsXwzPYo4Z+/siDQe6TpV/Nr0Xf8NmGx0MH
         ijjt6hn1OVBlRjJaMA3789hdvEPPU/iVMsKUdKu21RQ6lsLMOJNg5XyLgYN1a2AdbAXA
         DzRA==
X-Forwarded-Encrypted: i=1; AJvYcCVCqt+VBupamuEIK/4V99vN6pi112E2c79clDiRWlBo3eaaE/CZbzd9oAwUsqlENYFT2u+4Js1roUoTVJYwDINuPts3mEzpEXFzAY27
X-Gm-Message-State: AOJu0YyoD3dGyesttSJsukzMBtYwSx671wlmC0mPCytw5bhSUT7v0+GQ
	wBiFVp4tugOjuSll+amkHK5K9WGtveqlHnWzyqFbwHhnw1I0rljXNGqEigUgK8FD656r695vpKn
	/5rW9XJynxSfq5AWFM3kJ5MZSvOhjQaTcuS1sxA==
X-Google-Smtp-Source: AGHT+IGmj6T74vm3R6nuiWrtd2wGOpjpCBu6skMB2burDcyS70GbePfGkZdUU8+WxjbjSguvBshVZ84UD7mjia50WDw=
X-Received: by 2002:a17:90a:eb0c:b0:2c2:f6a2:a5f7 with SMTP id
 98e67ed59e1d1-2d3aaa99137mr4335653a91.13.1723654808630; Wed, 14 Aug 2024
 10:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <CAKfTPtALe942tjoyq1RqSYyM40PG+tfEY8skRDxRM1daWLSKUg@mail.gmail.com>
 <1572d0f2646312767a3ef8b72f740c9033163bf3.camel@gmx.de>
In-Reply-To: <1572d0f2646312767a3ef8b72f740c9033163bf3.camel@gmx.de>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Aug 2024 18:59:57 +0200
Message-ID: <CAKfTPtAjXejbsGS+Wd0maiiUyCgSb2xPVZGUXUPCSw_kNLJRDA@mail.gmail.com>
Subject: Re: [PATCH 00/24] Complete EEVDF
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 18:46, Mike Galbraith <efault@gmx.de> wrote:
>
> On Wed, 2024-08-14 at 16:34 +0200, Vincent Guittot wrote:
> >
> > While trying to test what would be the impact of delayed dequeue on
> > load_avg, I noticed something strange with the running slice. I have a
> > simple test with 2 always running threads on 1 CPU and the each thread
> > runs around 100ms continuously before switching to the other one
> > whereas I was expecting 3ms (the sysctl_sched_base_slice on my system)
> > between 2 context swicthes
> >
> > I'm using your sched/core branch. Is it the correct one ?
>
> Hm, building that branch, I see the expected tick granularity (4ms).

On my side tip/sched/core switches every 4ms but Peter's sched/core,
which is delayed queued on top of tip/sched/core if I don't get it
wrong, switches every 100ms.

>
>         -Mike
>

