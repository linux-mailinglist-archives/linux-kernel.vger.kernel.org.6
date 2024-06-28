Return-Path: <linux-kernel+bounces-234303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6A791C4F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A691F21524
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158751CCCB6;
	Fri, 28 Jun 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GWkXsvii"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5B4CB37
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595980; cv=none; b=SNeaODvcWnTAE93R52C3eX/Oj3FHSPMQssB1JcRC3csXso2GTpj0FuV3+aP5IM3PdV1EK2VeLEXRQ/TWUEwnuY3yp0MPQ3dfh2v2AGDKj+6scTc/Z7w9lpgE4yO8P6XGOAF38wbimHr8fPGQpm6G/C25rtHFpdm2OW9i3/ltNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595980; c=relaxed/simple;
	bh=BIrB4fK9301sI6Aq8wDLNsbZpmrpFpWY3QIPSv2FJBM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mdv2iTPgHdYoH8DZfNKqyrQPMRp/2W1XLU0ZY0C3vG61JuyoQu6AuNqmIWyE9VbRt2IKOlS15bdSgF8DRaKixvTMoO8f49mcggTqV9C8Yh/Xeco7TPAV/sViaPSLVpTk01sKxKuwrbidsjSnAD9HeegLcLUQK4hAcVVAwo4u5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GWkXsvii; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62d032a07a9so13476597b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719595978; x=1720200778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wIYiwzVQ2MGNzQexNoTOeXlDfhxqH6305pepeHUbiXE=;
        b=GWkXsviiiXcyTI5deLG6sO/Z2p4l2funD5Kd5ZirCsT4j22Xa8M+mleudiHxALQSWX
         RhluksXLzC2BOdejvlOSJaQp/ITrvbnEmbmbP2G0/9+Footx6PIVOwIx46L4WxqFbK6v
         wC43IUy2DEUdlIkpAt8rbLCIxqUp9HoJB+qiV57fkZ1wPqf56U2kBunA+dZtGpDG3lze
         lCWTDUCYrRgrvoyzouhG/C5aXCPhKejRI658vONVsvDFOaN+A2/MPoo91kuxTDyJ62EK
         VjLQ8SGUgojda4d2flxqtSOs7xQoEkD+HrPheF9gQpQZIg2dCIGT2xILJMVZBDKfMM8+
         nScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719595978; x=1720200778;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIYiwzVQ2MGNzQexNoTOeXlDfhxqH6305pepeHUbiXE=;
        b=m2SYFm9AY+WH+llsG/2YylB1X/s8ETNkGuVLV+587SfWgFsYdf568Cs8PM7t9xYbEA
         WFlTQJ5BfwN/G06ZMoFbtB+wijGNVp5fIlBlRHNKS2S6FwLrSONkxrdGmUISK9jNlIRK
         xadoi/XZfAcmAtD2AqWbhSdkU19GZ5iJLxA1X71I8QQSLxV/xYi5pGaBwbGYJpP+B/SI
         NWIa5i4QaYJWCrpMvMTK34sG/rlCSeiTZjFQ902ssEWqLc5UNVtRNYFE+thY3lrTaWX/
         7SOzXgtBrQ8vrddN1vV9pI34662PHSZUa8kxiGyoAPtcQGIb3dBQF2q+OLZJslqzfLKv
         Dxlg==
X-Forwarded-Encrypted: i=1; AJvYcCVdpjeZeBze274NgyepURKoaMRKKgeSoepsPlQVpnGP+Li/WNvpk39U8HMbDnOOccClzj/xYTkozpfnZqJzWl67HCLEkSlVdJZnh1dN
X-Gm-Message-State: AOJu0YyjWFkXNN3hSY4j1qTjpFhlBIpsVPpxXaLRNfAV6QJaeae+6Td2
	ycdT0MjmXyacQFMYncJzNt/ZbVIirDqVHXnU8rIa/t0jj1ApClCPjx9/PbDPvzJA8G+JnytmpDl
	dBA==
X-Google-Smtp-Source: AGHT+IFf+aPnAdJDjhVSSSXaFCZJ7EnOHriEKCrQPp8uEWIg28LanR8e8knsUxMiAFvorLCWWizLwUOcIgM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5b61:bd29:8f38:b8dd])
 (user=surenb job=sendgmr) by 2002:a0d:ebc8:0:b0:64a:e220:bfb5 with SMTP id
 00721157ae682-64ae220c130mr104637b3.1.1719595977696; Fri, 28 Jun 2024
 10:32:57 -0700 (PDT)
Date: Fri, 28 Jun 2024 10:32:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628173247.3507846-1-surenb@google.com>
Subject: [PATCH 1/1] signal: on exit skip waiting for an ack from the tracer
 if it is frozen
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: oleg@redhat.com, mhocko@suse.com, brauner@kernel.org, 
	tandersen@netflix.com, bigeasy@linutronix.de, vincent.whitchurch@axis.com, 
	ardb@kernel.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Martin Liu <liumartin@google.com>, 
	Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

When a process is being killed or exiting and it has a tracer, it will
notify the tracer and wait for an ack from the tracer to proceed. However
if the tracer is frozen, this ack will not arrive until the tracer gets
thawed. This poses a problem especially during memory pressure because
resources of the process are not released.
Things become even more interesting if OOM killer picks such tracee
and adds it into oom_victims. oom_victims counter will get incremented
and stay that way until tracee exits. In the meantime, if the system
tries to go into suspend, it will call oom_killer_disable() after
freezing all processes. That call will fail due to positive oom_victims,
but not until freeze_timeout_msecs passes. For the whole duration of the
freeze_timeout_msecs (20sec by default) the system will appear
unresponsive.
To fix this problem, skip the ack waiting step in the tracee when it's
exiting and the tracer is frozen. Per ptrace(2) manual, the tracer
cannot assume that the ptrace-stopped tracee exists. Therefore this
change does not break any valid assumptions.

Debugged-by: Martin Liu <liumartin@google.com>
Debugged-by: Minchan Kim <minchan@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/signal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 1f9dd41c04be..dd9c18fdaaa5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2320,6 +2320,19 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	if (gstop_done && (!current->ptrace || ptrace_reparented(current)))
 		do_notify_parent_cldstop(current, false, why);
 
+	/*
+	 * If tracer is frozen, it won't ack until it gets unfrozen and if the
+	 * tracee is exiting this means its resources do not get freed until
+	 * the tracer is thawed. Skip waiting for the tracer. Per ptrace(2)
+	 * manual, the tracer cannot assume that the ptrace-stopped tracee
+	 * exists, so exiting now should not be an issue.
+	 */
+	if (current->ptrace && (exit_code >> 8) == PTRACE_EVENT_EXIT &&
+	    cgroup_task_frozen(current->parent)) {
+		read_unlock(&tasklist_lock);
+		goto skip_wait;
+	}
+
 	/*
 	 * The previous do_notify_parent_cldstop() invocation woke ptracer.
 	 * One a PREEMPTION kernel this can result in preemption requirement
@@ -2356,6 +2369,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	schedule();
 	cgroup_leave_frozen(true);
 
+skip_wait:
 	/*
 	 * We are back.  Now reacquire the siglock before touching
 	 * last_siginfo, so that we are sure to have synchronized with

base-commit: 6c0483dbfe7223f2b8390e3d5fe942629d3317b7
-- 
2.45.2.803.g4e1b14247a-goog


