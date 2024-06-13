Return-Path: <linux-kernel+bounces-212543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0449062E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B484928460C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C7135A69;
	Thu, 13 Jun 2024 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbksL730"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC813247D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718250896; cv=none; b=nhMJju739IgdynXz2GHZlHlg6Y8JdMCTNvnNgMCVKIMPa8P87U9+PUJw/1sMuDXNuU7A6K9ZDCVLGlBmrltUwVSJgyz3feSF1o1xjlPQfIDgmT7BBWTGTT0H7EVkW227NbgoDAQjfWBFIixA5QN3A/8IQ1jZyoOE9DHAXXxd4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718250896; c=relaxed/simple;
	bh=PLH9ExywsbMaRXtZqH8rLCI99Jt6XOxOPuzh1SAfMSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hl7s6Ytrlgg36vHLJzzFHDHFZbWXLMQG+wumjnwVEXjzaXyfJj4yoPlvAdGdIro8ZqM8TAt52GXCfJ7CN1eo4Lud2hGSFCDbgRiP6bBWkeCTZTG3uQwVN27qWAYLncqMNPG0KXY2ZJg8tKlMikfa48e0Y09TEdehPN2iocuLz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbksL730; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-422954bbe29so25935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718250893; x=1718855693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLH9ExywsbMaRXtZqH8rLCI99Jt6XOxOPuzh1SAfMSI=;
        b=bbksL730T0ZuSFI8e2u4XVXXmzZjVwHPWdJAIP6GmUf5GlEbND6cn6rUKc1uCx4FE6
         CdE8g6dipKnyIheYcB825J+M2HNO+l0EPcIUakuccbAU+RHd2HZDYAhE/G8WpXsWCJVn
         JDU8PhgOqrS6j9dgHozFbUeqlNIoSCiPzn66r60s8avfz3AldWxn0QXXs7W0U2k1qHTY
         b31aI7pfkasiZPOlb/QC7s9Lf10SN7j66wNeIG0v36MhQaFj8lmjGkAYbpPccmDBw4LT
         9D2dys+jvbFbDGZezmeI6nmqJl60GZ1w4KE1Cn1IPsLLx3adklA2OtCsLHaAZlxNzlwc
         VmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718250893; x=1718855693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLH9ExywsbMaRXtZqH8rLCI99Jt6XOxOPuzh1SAfMSI=;
        b=bzKG9eHUCmtqiU2TEFvb+agiIu8aiAyKLDD0sSq7S3oIHs2KeSBxK9T7L5EjKhu0JM
         j6TAs8UgzVOCTbsmGoTuuFmIZ834Is147XkeYN5V3DesMyj/wz67/ZvtDflDhMNGcjML
         4QkUTkE7438BTWNIfJ8K+PQWcJ9Xb/yJ7Ey8XPTSbqmh/5+Xo+RPpI8NJC8nzEVeJ3tl
         x8ZU8sGuoxDBqoy7ACFM2gw74cwVY3wraxe3hpKOv/lDLDKdvQWEB8Fo2wqxpt18rfrs
         zYc995lGBmxYKpFZb9P+zJHytmaRyUs9EEExcGtTdV5L7OY8xHiCknnN10J1OjzIaDF2
         JBHw==
X-Gm-Message-State: AOJu0YwgBlsSdTFvhmjnxuUaCXtI2u6fuuaJOvxY0IYoHWt4VWek/GPA
	za/K3iVrdsfFg/FNNdKlByTek6NuBa7WpL9J0QMD959b4tziGruoAnMPI7EuOOyaqaPjmw1ODS+
	UpXNo8J4jhkV7czOSuBChLXIsozFfOZaLXGwB4EhHBWZBgXCr6Xg=
X-Google-Smtp-Source: AGHT+IFdhNi5sFKVwJb7whnHNxXazfHK1zqmDpyWZSxzjdihj6cYa0RDzJKVmy6YgqWoHq4cFmMUOfNEezhL2v6zJU0=
X-Received: by 2002:a05:600c:c1a:b0:421:75af:e66f with SMTP id
 5b1f17b1804b1-422d474b264mr1078235e9.2.1718250885471; Wed, 12 Jun 2024
 20:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613015837.4132703-1-jstultz@google.com>
In-Reply-To: <20240613015837.4132703-1-jstultz@google.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 12 Jun 2024 20:54:32 -0700
Message-ID: <CANDhNCqDruHDp4aZy8pe96tHGTF6TyvGfG8DXRCUCssRhBueCg@mail.gmail.com>
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling update_rq_clock
To: LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Qais Yousef <qyousef@layalina.io>, Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 6:58=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> I recently got a bug report that
> clock_gettime(CLOCK_THREAD_CPUTIME_ID,...) had regressed between
> 5.10 and 6.1. Its not a huge regression in absolute time
> (~30-40ns), but is >10% change.
>
> I narrowed the cause down to the addition of
> psi_account_irqtime() in update_rq_clock_task(), in commit
> 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
> pressure")
>
> So that explains the behavior change, but it also seems odd that
> we're doing psi irq accounting from a syscall that is just
> trying to read the thread's cputime.
>
> Thinking about it more, it seems the re-use of update_rq_clock()
> to handle accounting for any in-progress time for the current
> task has the potential for side effects and unnecessary work.
>
> So instead rework the logic so we calculate the current cpu
> runtime in a read-only fashion.
>
> This has the side benefit of improving
> clock_gettime(CLOCK_THREAD_CPUTIME_ID,...) performance by ~12%
> over the behavior in 5.10, and ~21% over the 6.1 behavior.
>
> NOTE: I'm not 100% sure this is correct yet. There may be some
> edge cases I've overlooked, so I'd greatly appreciate any
> review or feedback.

Actually, I've definitely overlooked something as I'm seeing
inconsistencies in CLOCK_THREAD_CPUTIME_ID with testing.
I'll have to stare at this some more and resend once I've sorted it out.

Even so, I'd appreciate thoughts on the general approach of avoiding
update_rq_clock() in the clock_gettime() path.

thanks
-john

