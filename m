Return-Path: <linux-kernel+bounces-359896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3C6999224
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CDD284BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE57C1CDA31;
	Thu, 10 Oct 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="lNO8vrqn"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED821B6525
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588243; cv=none; b=rvMZ93Uaj0JgsQMxFKBvDEa01ifjEcKyXnyo8Pgj5GRIvDqx0FHrpoG+XDmpimCY0FejYdl2UK0QHoiWdf5Y9IftDGdy+34ROeyUXTn+JvQwkRiS6joMxY7cMxXrPbaT0BrMs7b67BSn2/56XACo4jBXoEgiKQkzS3Ah3yPRK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588243; c=relaxed/simple;
	bh=66KBTKQ6NcMAQQUcCpPGAjzFBWkzOGqbuV6tYQl+gI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMVA2a4Pn6dSbLjKWy5bEJwSsQRMDNhUpALSKzptQDg3x2fC9tFxqSgclAOBYsErmqo54rr6bQxD6z4A5+ulMGCGnUCQO6vXAPXX/sDQAekeqDGXQRje8020taz0tnneFpdfCaKhO4/Dpjz1BKWni6b/0CKzMPPiIwRn0lH18xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=lNO8vrqn; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbc7976a6dso7553056d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1728588239; x=1729193039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrQEWn5/w+Y6IS85vKSKnwu6LL413ydIBaXoz3HnS8E=;
        b=lNO8vrqnKii17nEwyjDtV26qHmSW+V3eR6KDBJ5wLtc0Sb1k/Nbtnr0euypQgDKm6Q
         Ozrn0V6nAyHHQ7F3e97E1Q2UoEx7shZz+pMNUgAtogwRkg6WitCm/BqHmX1qGK7HF+h8
         dE7OaV1mG4pQUVhaLYDI5l8pFA0hGO+j94wY7IvRjq0oUsEnSCKtMDDiCgmOY8CykVEH
         Eah23zXIWdhJdciDHfS83lAhFyCCr/Iu+44b8bjZ/nzZVK8PcX+PnfBPnpwkhISzkIDP
         62h6N3vBgBSYqdsms3Zaady/CsTWRlVMQoXE6sivbJVF7Jo0nKG0p+tb13Ox780+2Jwy
         KspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588239; x=1729193039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrQEWn5/w+Y6IS85vKSKnwu6LL413ydIBaXoz3HnS8E=;
        b=lpbgqBA4pm+f11GhJHJOZ48RWKNgZIKfRZWSxYmM326MAN4xQyYvK1gRx+BY55YYSE
         Qvl7VSo3QEh/pLMFRUXHyQ+w7IXERsxnYsBllYeR2vjv3ByFp3ufS5EmxChVvzaAK0XQ
         lYcNPF0OyTloKOlkft/7RsWAAp7PKhqrRSUzt+TwA+SrT/YMGtxGHl/ZuCrvi1ol1Abw
         6pAWH13U+W8zjy2d/nYiB9qrxBGI1WmqWkg+o2kOVdqQQD9EyVVTR4oIChmROsDHTsCe
         jqIxFacI1H+7ZVicYmW1H5swFULixc3AjphwwghUElxagM/1PdAGOFOrFpOK+hzqA46R
         5gwg==
X-Forwarded-Encrypted: i=1; AJvYcCW0E0Tq8qDT1NEpjdq28vpVsENVRXLf8CJDr5B4HLPmqPCoTaWw+9SpHL3ErtGUCDdmwukbfz6DGnIHj9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRSfdHmk5GVFbdv6Suz1O7NF+vYpMxClyhekcoZNj4OWtzwj0
	MiSf7y/1lrxOna7aTRLz8KpEm40BoadSooIv74PP4CqZarhHDcfWllDuY8Cd4vo=
X-Google-Smtp-Source: AGHT+IEStr6X+z6bYcPqki2wni4vVBvRUMWaf8Uozji0MAOTu9qBmNfU3369uwtWQ7P+wnKjZ8trgg==
X-Received: by 2002:a05:6214:5b06:b0:6cb:e4d3:91c5 with SMTP id 6a1803df08f44-6cbf0098734mr1878596d6.36.1728588239347;
        Thu, 10 Oct 2024 12:23:59 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608d68sm8152416d6.94.2024.10.10.12.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:23:58 -0700 (PDT)
Date: Thu, 10 Oct 2024 15:23:53 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Ziljstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Klaus Kudielka <klaus.kudielka@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bert Karwatzki <spasswolf@web.de>, regressions@lists.linux.dev
Subject: Re: [PATCH 1/3] sched/core: Dequeue PSI signals for blocked tasks
 that are delayed
Message-ID: <20241010192353.GB181795@cmpxchg.org>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010082838.2474-2-kprateek.nayak@amd.com>

On Thu, Oct 10, 2024 at 08:28:36AM +0000, K Prateek Nayak wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> psi_dequeue() in for blocked task expects psi_sched_switch() to clear
> the TSK_.*RUNNING PSI flags and set the TSK_IOWAIT flags however
> psi_sched_switch() uses "!task_on_rq_queued(prev)" to detect if the task
> is blocked or still runnable which is no longer true with DELAY_DEQUEUE
> since a blocking task can be left queued on the runqueue.
> 
> This can lead to PSI splats similar to:
> 
>     psi: inconsistent task state! task=... cpu=... psi_flags=4 clear=0 set=4
> 
> when the task is requeued since the TSK_RUNNING flag was not cleared
> when the task was blocked.
> 
> Explicitly communicate that the task was blocked to psi_sched_switch()
> even if it was delayed and is still on the runqueue.
> 
>   [ prateek: Broke off the relevant part from [1], commit message ]
> 
> Link: https://lore.kernel.org/lkml/20241004123506.GR18071@noisy.programming.kicks-ass.net/ [1]
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Closes: https://lore.kernel.org/lkml/20240830123458.3557-1-spasswolf@web.de/
> Closes: https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
> Tested-by: Johannes Weiner <hannes@cmpxchg.org>
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

