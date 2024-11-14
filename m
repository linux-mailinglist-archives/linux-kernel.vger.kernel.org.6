Return-Path: <linux-kernel+bounces-409148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E539C87FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7997E285250
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878991F8186;
	Thu, 14 Nov 2024 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQEPYpCi"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684541F80D2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581191; cv=none; b=HKEIbiSHwwwBBKvCUlCOauubl7Ms/iz6YPLEIiV1/83oI7OSwfCiQMoSilzpxxFhc4IbEdpFyU6SNrOwSnCD/FkIDwZ03zufnZRgqfxA+/bZ4nv7seoCiWlmQ2PO6/9yIdM1PCRTOzXsVrC0iC/p3ajXhoR3yPhuGDOod26OElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581191; c=relaxed/simple;
	bh=zZNiJnsNjjXZ+vhoAnB3iwLyA2+J+udSxtQd9V+v98c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C2GK4y/I0hxPuHzqMBO4b0MDyt8Qkb5RBAO+GNwpkE0MZU4zLQ//TxzFpfyLLHSpsaiBYEvALnDB0T/OnOvUG4hbL+WG09KZsHnY6nXzzCYQG3c6vvLWhGRKw8FshghwKMFzSw3jx1Z/CCLKLpt0Szd728O6ZJnbcT2DL44xnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQEPYpCi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e83a3so9892557b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731581189; x=1732185989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RS11QiE4vcJwMt7rNCiWJOnFt/WMQ+WIvcw2+q1yQTo=;
        b=cQEPYpCiwOBPaWJjifZfPhU7Y+cvybd0MMH+2ga+ffSkxrWUt9j91TvOZI/KsFKcIA
         t8PF3RVMmXN3iFUiEwEMzt291ucYIjnEuqynLGUOHqqevFl6uyCbsTSO2OJbyLEOIuIR
         bBUYcBOPC/KAO2GrIGaHy7VBC0nMn0jrbxrqRjzPGgd++Y2ExLq/iHApCXKEoqs+rcSU
         eJYISQroFDzlkN6ZUGxlsRqcShAdZjyty4yOKj9DoBKvYNrjdUgjgv8n+tjGPMGVE0zM
         gEZ6DWmSwhMGRSVqv0ySLZVOU7MqfM5bnNDkk6laT2KYH+JEmGCUFn0ElGqGuy4zoLcN
         TXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731581189; x=1732185989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RS11QiE4vcJwMt7rNCiWJOnFt/WMQ+WIvcw2+q1yQTo=;
        b=rvxQRIioLMd45kf3Byxd44WCqURSUyV1RpiXyfmi0OvE3mZhjUvzMbWu0Mmi6eTqyp
         4ivyTA/peiVOr+igggCQJbas6deZQuDkiYS/KG0WXqqCOKCBkjO59kxrWitnnyjHbeRy
         laREGeuyoJVgriLn5c0+BraDR5Nc5l9+gyfsL+xeK4kSq2qZ2vilZct5eHIFtMQX/B9R
         RVAeEa+MhjX+Kx5fGg0Ad/Dq7kDW7iaPPo91642oskbJ/f7Mr8/2CZIoh33Bt9ezlfB7
         yAYZCEY0ofMdCeHJKqAJWAQ5+EUEwnZytqr9Yq/3qCIo3pkxQs6muDPnTtfNj+B2hNrt
         KY/w==
X-Forwarded-Encrypted: i=1; AJvYcCVecHqTda7tFrXQ2O9O4oSLPEpnNBYoAiueAXBol+ry8pbecMcT3aMKAYBxLb+hZi7ArSHRyW0PbJr9nVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydzkZ+ugsKNzkdJPWWyr5cCqa7caYdRfUE+s794ct5+iIpGhq2
	BwdUlA6WkjJ1ds9wh0sGuj3r1uHOYQuQfuMnDpEjgWhMtWnxrZ8UySRYcIaHWNKCO/IqMvOIBqH
	LotvZj9GIg+FJdQ==
X-Google-Smtp-Source: AGHT+IEmcoj/O+qSj/aM6T/nRKx1v42AMEh+Ha8ltSgl9RWyAIS4he+xLedfXdfnPXVnzUKys68+SrSsTmDR16s=
X-Received: from ciprietti.c.googlers.com ([fda3:e722:ac3:cc00:ee:a3ee:ac1c:78f4])
 (user=ciprietti job=sendgmr) by 2002:a25:3616:0:b0:e29:6e61:3daf with SMTP id
 3f1490d57ef6-e35dc494141mr7520276.2.1731581189358; Thu, 14 Nov 2024 02:46:29
 -0800 (PST)
Date: Thu, 14 Nov 2024 10:46:25 +0000
In-Reply-To: <xhsmhy11nb8mg.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xhsmhy11nb8mg.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241114104625.1735182-1-ciprietti@google.com>
Subject: [PATCH v2] sched/smt: Call sched_core_cpu_deactivate() after error is handled
From: Andrea Ciprietti <ciprietti@google.com>
To: vschneid@redhat.com
Cc: bsegall@google.com, ciprietti@google.com, dietmar.eggemann@arm.com, 
	joshdon@google.com, juri.lelli@redhat.com, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"

In sched_cpu_deactivate(), the error path restores most of the initial
state before returning, but, if CONFIG_SCHED_SMT is defined, it does not
undo the previous call to sched_core_cpu_deactivate().

There is no easy way to invert such function since it overrides some shared
state of the leader CPU. Instead, simply move the call past the error
handling code. This is fine since:

	- sched_cpu_deactivate() is CPU hot-unplug, which doesn't happen until
	  after sched_init_smp() in kernel_init_freeable():

		kernel_init_freeable()
		`\
		  smp_init() <- boots all secondaries
		  sched_init_smp()
		  do_basic_setup()
		  `\
			do_initcalls()

	- cpuset_cpu_inactive() performs unrelated operations.

Note that there's no need for #ifdef since cpuset_core_* have empty
definitions when CONFIG_SCHED_SMT is not set (in which case this patch is a
no-op).

Fixes: 3c474b3239f1 ("sched: Fix Core-wide rq->lock for uninitialized CPUs")
Cc: stable@kernel.org
Suggested-by: Josh Don <joshdon@google.com>
Signed-off-by: Andrea Ciprietti <ciprietti@google.com>
---
Changelog v1->v2:
	- Added details to commit message.
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 719e0ed1e976..4d55bc243ae5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8187,10 +8187,6 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	sched_smt_present_dec(cpu);
 
-#ifdef CONFIG_SCHED_SMT
-	sched_core_cpu_deactivate(cpu);
-#endif
-
 	if (!sched_smp_initialized)
 		return 0;
 
@@ -8204,6 +8200,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 		sched_update_numa(cpu, true);
 		return ret;
 	}
+	sched_core_cpu_deactivate(cpu);
 	sched_domains_numa_masks_clear(cpu);
 	return 0;
 }
-- 
2.47.0.338.g60cca15819-goog


