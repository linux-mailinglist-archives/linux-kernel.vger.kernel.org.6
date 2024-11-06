Return-Path: <linux-kernel+bounces-397556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D089BDD5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51A61C21FD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8C1917DB;
	Wed,  6 Nov 2024 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2iIpNxc"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC7190676
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861832; cv=none; b=PuJgf0XA9CP03YYLG7OB16WxlXIssqbgKB6R4AnWdYNHDyC+VOX3LqNhsKQ9t3X62ZwJCEgd14px8icd9OQbN9Og4dMZLw3y7HZq7GCUyNNRpUsh/Skgd6BzisT3cvUK0qPf5ALXp/5ZuQmEPyiGy5biJr25kGmIoZSABuTNUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861832; c=relaxed/simple;
	bh=zu4AqCl3xwWVEQVzRYde3/jWSmMCwe3WXBKhHvYFIHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d9A5flPlVZd7iajD7afp/9yOQ1QEXOA2JIY89lFVnM/Sh7jekHFNh7ispTKPpBFJn7gewpM2qEVfo7QvGh2GTH2vEaV7iroUpxHErQL16VxKb0apMsp27N5pOWfwcftEZjPtkHsP2TOeUA4kgYZnrHbfHAjLfUsodZKqtSGX7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2iIpNxc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea0069a8b0so5504043a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730861830; x=1731466630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1zz6/fs34S9LrjXAat21RL6lCkZJ4k/xrDwVmaAbQU=;
        b=H2iIpNxcL0NeuAI/Xr0mkT9OZYjZWpyNyeODLjXdZ/A2JQcWYk+POsYbjlVwZJZDnP
         h9a/MlA8ZPssCB8jLsupPuNq1N8GcQKWioxDuWEmKHV+8qUoPT9GpLpl3AjOtLlFvU1v
         dzUWrlMGfSlbhuB7wUSCTNHXjAA2eF8g9DEHhOxJF4SAu+h0fBlU5eXpgFlFUiQCZviD
         P3xaGmhPz+FjM6OUdQteRbZK++hIWl+Uo314u/PaKPgFZSjr8LH+wTwsan04VBtR/6Tb
         2opkvUAmJPNHxE18qA9lKGB+uQoNOeHe74r436ZvkW+PQ+a2Z/t0T6LFYs2zhvEVwgm6
         OWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861830; x=1731466630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1zz6/fs34S9LrjXAat21RL6lCkZJ4k/xrDwVmaAbQU=;
        b=fO1h4P9GM9To3NadPQxbJuusSJfnNfwI2sk8EutwkzGsBqAyUWeujGhTH0AhcX/ImD
         KHew3Qj43DzZQMzFi/PjDdjz0I8zLSQL3PxSFOp/Tq1AAW7ZlUEKTCkMBN57aoLWwiVY
         NR3KgCDEaRfZwO2Y05YZO8BbTIX5H8O6OdcL6B9Z/XJE8RY8OV7yAnaTTPtv0QoGakSb
         VcMFKQfgWPCfKRtR55yEY466U1iW0zBJkgwDyQ/VHSknOTEiSqf96AGIe4Ne3vtVDJ5J
         6DdBkQXkPeiTP+tDflcLvhXm4cqbeHtvFkUv00peGiilgwO8aiwnoByHLZvpl0nMeEMD
         Xkow==
X-Gm-Message-State: AOJu0YyGebEtz7iOK7XgXipIrMC8IgwbBs72kWN7Y44lupyjmh3vC5wm
	7Ise3UlaOyQ8SW6LFe7bsiXd8eY4nXDcrFqtQAnNQYwDSBKSNtqG5Qv7thjdp+a0AMogWW2PwG9
	+/+uwXBS8745YW0XA8I538NRS3yaISfbH4KCWNoM6OST3sYrjusAqo9zXbd5Iq+0CdAf8e+UTT6
	n7pFeTXWBt8mCmCpew+HpbG6ZNUZrjzG8VMxQpC7GhWcLI
X-Google-Smtp-Source: AGHT+IEbGWzmNhrFjaMP/l/a+jzpcorzEtuz05hFTRxW82Zbvw8A6P7XW5+JgiYGXQhr7wUw+A8vs1aC67ah
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a65:628f:0:b0:7e9:fb45:5451 with SMTP id
 41be03b00d2f7-7ee29144834mr34695a12.9.1730861828741; Tue, 05 Nov 2024
 18:57:08 -0800 (PST)
Date: Tue,  5 Nov 2024 18:56:44 -0800
In-Reply-To: <20241106025656.2326794-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106025656.2326794-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106025656.2326794-5-jstultz@google.com>
Subject: [RFC][PATCH v13 4/7] sched: Fix psi_dequeue for Proxy Execution
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Currently, if the sleep flag is set, psi_dequeue() doesn't
change any of the psi_flags.

This is because psi_switch_task() will clear TSK_ONCPU as well
as other potential flags (TSK_RUNNING), and the assumption is
that a voluntary sleep always consists of a task being dequeued
followed shortly there after with a psi_sched_switch() call.

Proxy Execution changes this expectation, as mutex-blocked tasks
that would normally sleep stay on the runqueue. In the case where
the mutex owning task goes to sleep, we will then deactivate the
blocked task as well.

However, in that case, the mutex-blocked task will have had
its TSK_ONCPU cleared when it was switched off the cpu, but it
will stay TSK_RUNNING. Then when we later dequeue it becaues of
a sleeping-owner, as it is sleeping psi_dequeue() won't change
any state (leaving it TSK_RUNNING), as it incorrectly expects a
psi_task_switch() call to immediately follow.

Later on when it get re enqueued, and psi_flags are set for
TSK_RUNNING, we hit an error as the task is already TSK_RUNNING:
  psi: inconsistent task state!

To resolve this, extend the logic in psi_dequeue() so that
if the sleep flag is set, we also check if psi_flags have
TSK_ONCPU set (meaning the psi_task_switch is imminient) before
we do the shortcut return.

If TSK_ONCPU is not set, that means we've already swtiched away,
and this psi_dequeue call needs to clear the flags.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
v13:
* Reworked for collision
---
 kernel/sched/stats.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 8ee0add5a48a..c313fe76a772 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -176,8 +176,12 @@ static inline void psi_dequeue(struct task_struct *p, int flags)
 	 * avoid walking all ancestors twice, psi_task_switch() handles
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
+	 * In the SCHED_PROXY_EXECUTION case we may do sleeping
+	 * dequeues that are not followed by a task switch, so check
+	 * TSK_ONCPU is set to ensure the task switch is imminent.
+	 * Otherwise clear the flags as usual.
 	 */
-	if (flags & DEQUEUE_SLEEP)
+	if ((flags & DEQUEUE_SLEEP) && (p->psi_flags & TSK_ONCPU))
 		return;
 
 	/*
-- 
2.47.0.199.ga7371fff76-goog


