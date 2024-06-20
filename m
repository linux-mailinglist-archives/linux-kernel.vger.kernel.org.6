Return-Path: <linux-kernel+bounces-223678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A279116B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6FA1F22757
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4B813210D;
	Thu, 20 Jun 2024 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Bx1Mbtt4"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6443ABC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718925879; cv=none; b=RQ1fZXZd+lamU8prODIiwHu7HuhOBjBgvKBibyf8p2ZcPNBqh+kpxFraKT301BCP8smbyh0denQE0fboyv+PoB+qJA9UAY+pjTTQHkRvRC3SDipPLR6/gIA/eqBcCpJOkCpY1BBHTxuivRNW0JNGDyRC0RguoGx7aLonpODvgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718925879; c=relaxed/simple;
	bh=F6IOoEjqXoNheubNsL8u5CVcW7mfpEXnPEJgY7ElUKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b12qaTU3kcAFS4GlKeQHdByAXnVWheULCRvr4V23c9Jcl9caJqRI9FBuOCmS+r+EtQWb9BqUgaWdNbV3q7x5mDDDj/RTrS/AnAVX48sZT+IuM17B8PC62qSAs6oOsoe44HCSQpI04/ux+S1Uy4KezVzrf4SxbgufkpyXfUkUFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Bx1Mbtt4; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b05c9db85fso6364386d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1718925875; x=1719530675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SoqCyL49xgDFVsyj3w8nErtzuuUWEcvfz1IKjM7oD8=;
        b=Bx1Mbtt4WjG2c4pG2fgUC4f1RPCFSl2iO79S9gpKkjJOFgs71l6XEae8tSRBa73Vcx
         R+QDy68rCnnxynLh7O5WK6kW4Nq3ES6HEx77V8eg7j9wNDlhiAoYHoj6E7nFXu+joNhV
         LNGC7pGCwvdQAUL1j73w2YgCHcmrATVrJKePod1vLcyrYCKI6HRjLhJX/1cw99HKdv5w
         XfJEDDVU/TGROX657o81M73oU/pVlvdYhiP8apGd/K3XmJpqn+Vpjh9xRBACT834dieT
         CzgbChp1PHRO76pbZGqGAbE+Fn56fgjUG33am6+r73+YZKweJPCC05TSM+fxr4J40QMM
         lZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718925875; x=1719530675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SoqCyL49xgDFVsyj3w8nErtzuuUWEcvfz1IKjM7oD8=;
        b=MoY+ob6c4nOo1y1jK/FxJJeUzkzSsrYM8fNpaSGjd8mImj5/dgvGraOMlSDa6hsDeA
         mZrl54c9NKo9QRoz7bLXQo4SwtQQ/UC+gYXxrMeyl2mQ/eM7WlcqHwifXpgbinjXlnkR
         0FmAqtXCqPm6gc19qdX1up4lqUKXSX1AhR3iPIMZPW6vehshBYhPnLlfYwVDT8XM/ray
         VWsgXnj1u8Hiu3JyZ4C/4ppSjVrztzKdZiQG+6pbqwg2mwyDAjH+SQk45OB/H6fjehLD
         xESXyk2PirgxuxIJEhAzj4WprpeStk5MFdakB6n1ursqjzOXjcXmPPlYqJEsB08CYKjQ
         rC5g==
X-Gm-Message-State: AOJu0Yzrq9nenfLqUwMcTjhs6MY8J7TaLfqL2uEIzKEIo4W4bo+hoiUi
	ELlpXKEjzqurFWSwaAj3e7mQNbW1nlMI4toRwke1xkfVn+FTAvG+rDUmDlYRIp8=
X-Google-Smtp-Source: AGHT+IFJwE1CcucrL9hvHjURf4MsSKJ2N7HdgTsqauBYSvHzPDbJifnHa/Q/UKpAxhkXfZUNO87KOA==
X-Received: by 2002:a0c:ab1b:0:b0:6b5:1f3f:90da with SMTP id 6a1803df08f44-6b51f3f9210mr2776506d6.44.1718925875091;
        Thu, 20 Jun 2024 16:24:35 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef30e6fsm1421216d6.84.2024.06.20.16.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 16:24:34 -0700 (PDT)
Date: Thu, 20 Jun 2024 19:24:30 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jimmy Shiu <jimmyshiu@google.com>
Subject: Re: [PATCH v2] sched: Move psi_account_irqtime() out of
 update_rq_clock_task() hotpath
Message-ID: <20240620232430.GB439156@cmpxchg.org>
References: <20240620173301.1761679-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620173301.1761679-1-jstultz@google.com>

On Thu, Jun 20, 2024 at 10:32:57AM -0700, John Stultz wrote:
> It was reported that in moving to 6.1, a larger then 10%
> regression was seen in the performance of
> clock_gettime(CLOCK_THREAD_CPUTIME_ID,...).
> 
> Using a simple reproducer, I found:
> 5.10:
> 100000000 calls in 24345994193 ns => 243.460 ns per call
> 100000000 calls in 24288172050 ns => 242.882 ns per call
> 100000000 calls in 24289135225 ns => 242.891 ns per call
> 
> 6.1:
> 100000000 calls in 28248646742 ns => 282.486 ns per call
> 100000000 calls in 28227055067 ns => 282.271 ns per call
> 100000000 calls in 28177471287 ns => 281.775 ns per call
> 
> The cause of this was finally narrowed down to the addition of
> psi_account_irqtime() in update_rq_clock_task(), in commit
> 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
> pressure").
> 
> In my initial attempt to resolve this, I leaned towards moving
> all accounting work out of the clock_gettime() call path, but it
> wasn't very pretty, so it will have to wait for a later deeper
> rework. Instead, Peter shared this approach:
> 
> Rework psi_account_irqtime() to use its own psi_irq_time base
> for accounting, and move it out of the hotpath, calling it
> instead from sched_tick() and __schedule().
> 
> In testing this, we found the importance of ensuring
> psi_account_irqtime() is run under the rq_lock, which Johannes
> Weiner helpfully explained, so also add some lockdep annotations
> to make that requirement clear.
> 
> With this change the performance is back in-line with 5.10:
> 6.1+fix:
> 100000000 calls in 24297324597 ns => 242.973 ns per call
> 100000000 calls in 24318869234 ns => 243.189 ns per call
> 100000000 calls in 24291564588 ns => 242.916 ns per call
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: kernel-team@android.com
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> Fixes: 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure")
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Jimmy Shiu <jimmyshiu@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>

Excellent.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

