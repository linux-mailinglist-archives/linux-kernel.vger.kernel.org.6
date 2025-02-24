Return-Path: <linux-kernel+bounces-530225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8642FA430CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062AB19C3004
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D07420F08C;
	Mon, 24 Feb 2025 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWjj7Kfo"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0C20C492
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439432; cv=none; b=JJXExDqw6Yy1jXTyyjSJ4eLY2a/dBQ85t7MRVJjxZOGWEj+ssocnKeS6VdxnGZDLB6x/COW98cwo53YNcKGKxuPw6G7hEefQHGtDXrOU4yhsGzYSaO062h8RApzhZFwmkmtED1zi4wdXUZ2eghYkT18PeB6u5vq/Gu2NIXA7oRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439432; c=relaxed/simple;
	bh=1dt7gR5+bMbLtRayJ1t5z1klUDF/UcIrQkdBGJtMEoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZhC81oEj9iRko/1Eowmr/t8QnraEqS0SYHq/Gc7Pf+V1wz4j9FSeZ3ywbzCt2aruHP4nOnh0dUCtchStaFq2hauA06Zrr0gdL1DODlmkIirBGmVn94D4M/AHEA9Ee/xu3/M/6tK9Mror8nAtrQsyApFD8TF5dqv3F2Hz+EIKyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWjj7Kfo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc17c3eeb5so10223577a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740439431; x=1741044231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KfX4uMbxYl4w1YFnMZlqCzNkTeWrW+JtwTtTumpGJQ=;
        b=NWjj7KfoAWfBCrGPVdFuyOxFuafQL4tf58gtSWC8HkfS18HvwRxa+NBKNH+SxhZ0OM
         VFOlKzHcqId/yNijxfyZqQqqhKH9sgzFqAc2KESgdAVfqqzP01xdBDMvHkVelfX1ADiu
         itt4gEObx11VDnDRd9jxUrPOE+vL7+JBkZCd2O6dEUxuDmd7c90paf1xEsZS8asAgr0R
         bUQ/pOMPFvJJ7oFnScbC9xKFU1JazpVQP6GB2dlvrSc5oGIVmM9NIGOSK+rypbq8xCHN
         X1UdbwLG/9anEDw+OEkxnf8bEJFAlODfxbxnsrKjAXXscz3Gnjy3oloulNQh93f/LdLm
         ucMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439431; x=1741044231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KfX4uMbxYl4w1YFnMZlqCzNkTeWrW+JtwTtTumpGJQ=;
        b=wTH26yNXNd/FeROQNMPLe/wxpeiUJnTJUKETk78HjbTgbNk+CLkxIi8F2U2Thonr0c
         S9EfRWygrdLyvpJZi+GVC4Sw0u4GpxR0zJNI2F63ZQHydTR3irBI/nTNKxEG1+b+pAOe
         6+9aO7hGtPAqr/7rj/G1CjSw5LSJfTp5f0o23JaGBZE75R6SOhWSPzCTkwSwKV4hKvZF
         GOeOaiRKeFdBL8joPiOzGnG9M5/pMUcmEBlLaEdL0UXaBUxAmhcc9xA1mg+OctyN9NsA
         0cz1Q3d1Vaj3jElttnXkE5UB+3Zj6SWkjgXvHWHlQVsSZOTXHAYC8UTXUn0Lf9cWQoDp
         Rszg==
X-Forwarded-Encrypted: i=1; AJvYcCX4xxGb/PjFy+bNvYH8Easw5pZOWAp4j8hgSEjQ5YEY6nPBJIqV7Vz9AlkmjmJ/0fqCsmggVkYhzG6wEzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUTJitLsOgYBPsW1AK4S0D0fifrmN3sbWKJsgikHncjidDXbR
	b5aOBHmTARSmSDYyUMegq9dXr7KMacfid/IJwdmfPODzLbOgZARYPYYQyvM5jVwjqrXNhniuTq/
	dtw==
X-Google-Smtp-Source: AGHT+IHgVMlWvtJtKdegL6+NfTsb74zcs3Z3RS2qJGlIyR3jnCLxjtqsqTuF7poQq8mevExigOWztRI5LXQ=
X-Received: from pjh15.prod.google.com ([2002:a17:90b:3f8f:b0:2fc:d276:ee01])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f81:b0:2ee:d433:7c50
 with SMTP id 98e67ed59e1d1-2fce873af2cmr20867656a91.23.1740439430740; Mon, 24
 Feb 2025 15:23:50 -0800 (PST)
Date: Mon, 24 Feb 2025 15:23:49 -0800
In-Reply-To: <Z7rxuqIB38Wv557A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210001915.123424-1-qyousef@layalina.io> <20250212145054.GA1965539@joelnvbox>
 <Z7rTNxHcXWizV3lq@gpd3> <Z7rxuqIB38Wv557A@gmail.com>
Message-ID: <Z7z_hQ8hE9xbnBGn@google.com>
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
From: Sean Christopherson <seanjc@google.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Stultz <jstultz@google.com>, Saravana Kannan <saravanak@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Frederic Weisbecker <frederic@kernel.org>, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 23, 2025, Ingo Molnar wrote:
> 
> * Andrea Righi <arighi@nvidia.com> wrote:
> 
> > On Wed, Feb 12, 2025 at 09:50:54AM -0500, Joel Fernandes wrote:
> > > On Mon, Feb 10, 2025 at 12:19:15AM +0000, Qais Yousef wrote:
> > ...
> > > > I believe HZ_250 was the default as a trade-off for battery power
> > > > devices that might not be happy with frequent TICKS potentially draining
> > > > the battery unnecessarily. But to my understanding the current state of
> > > 
> > > Actually, on x86, me and Steve did some debug on Chromebooks and we found
> > > that HZ_250 actually increased power versus higher HZ. This was because
> > > cpuidle governor changes C states on the tick, and by making it less
> > > frequent, the CPU could be in a shallow C state for longer.
> > 
> > FWIW, I found the same about power consumption when we decided to switch to
> > CONFIG_HZ=1000 in the Ubuntu kernel:
> > https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255
> 
> The "HZ=1000 reduces power consumption or keeps it the same" is 
> actually a pretty good argument to change the default to HZ=1000.
> 
> These experiments and numbers (if any) should be incorporated in the 
> changelog prominently - as actual data and the Kconfig decisions made 
> by major distros will, most of the time, be superior to meta analysis 
> that seems to be the changelog right now.

Speaking of which, has anyone done analysis when running as a VM?  I don't know
about other architectures, but on x86 at least, the tick (or more specifically,
(hr)timers) is the number one source of VM-Exits.  Off the cuff, I wouldn't any
meaningful difference in performance, but I also wouldn't be surprised if running
in a VM behaves differently than running on bare metal.

E.g. except for slice-of-hardware setups, MWAIT won't be exposed to the guest and
thus the cpuidle governor (in the guest) effectively has a binary decision (to
hlt, or not to hlt).

