Return-Path: <linux-kernel+bounces-519804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A8BA3A219
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320E53B0CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324526E15C;
	Tue, 18 Feb 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4uJRO8/S"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E51459F7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894702; cv=none; b=CRs2zWL2W7Ky+qqV0gDkfThomODoInK/EoEppwEbDp8Tm5Aium7TLYACxqyh27Z9hAQt41Yqqq1u1MEfLl9ktyGNoIc7U2/CZM96Nd1TnHveer3p9FHNOeo0xXUABRusrWj3WrXraSXFba5wecvi8mOd/WTG/rR9Tfsa1ZehzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894702; c=relaxed/simple;
	bh=6GQcXVe2SCy/A7R9Dn8Z5XgQUnXLIPESvvaPTN/8lhk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fMQucdokWCTC6SfSnIY2ub+xGy2HefQYMIzTVcekNUSzW8Ge8HoPFjJlEpdS41/4N2haVxyg6i/XkoebkJ4SJ+PCD893x5TW5NrwpK3ljxM0ztzDc/T1mopXWMDxK5ed52JXajIgpcKA6YL0iY1Wa/3cfbV28/13fbd6ukqML68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4uJRO8/S; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e02d16fea5so3431409a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739894698; x=1740499498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mGUzlKU/88ScEoKu5QKXimL46RVCUcRx5GeW41a5LQ=;
        b=4uJRO8/SXCLVJp0O6To9PPQvxbyvDzEhsi8bPL2z7pw2dZoFqNfp5ft95z5pOAQgD5
         cIXIxDTax3LsfHxH+89wjJ7zoXgmkKk/sm9RS26ikewIYN+O328mmDeXLbDLOxHtGLpa
         ee5KHmd/zR8KFONGwTG2JoZ0PVKy/8F4eiEypFXPUtNwV1McGXdq9unwJR38MWW2UZ8u
         Kr2dOGKcyz0A/oNIFhifQdk1KFnCIstTUu/HLE+U0hHZcDc8lw1pOFjlVJYUHik6kw3W
         22tlajuJovbTjSYI9ekS9Hg+Vd2MoAKQMjIa65Wfz0MmJZfaD7dZlgo7xq4kXyhCNTW2
         gdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894698; x=1740499498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mGUzlKU/88ScEoKu5QKXimL46RVCUcRx5GeW41a5LQ=;
        b=c/Ygrd9dt79PtRw8FXg8EdnnsrGlE/eXttF0P9oPX9zRv0w3QcihqJITaul257Ote1
         ijJt9bojm5zDc8ti3eq5Tj41IpEr8sj1s/Aj1eb7do7FUoJ7o+nayC/xlKKuNla4A6Us
         B8N43NdJq85vRTECJUsu40b6HZEZZCqXU4Mj7EtwN7vDFvbm8UANc2p2Nu/8ze3RqPoH
         z88QmqyH8fRP5v/CAKf+lVw9uxse3sEdOxZT5ZSZ8IEpuUm1WSbFTHJ2AG56xT2dbhb7
         FaX82O7s0K5zZOtUUZDsBt442EIGaZAzWqmsQc3rIyUOZoJyze70gtMMcVw7PjkCghxx
         aq3w==
X-Forwarded-Encrypted: i=1; AJvYcCXw5Fzsnej/mOVTUuAgaflsnV2+GwS3FiOXZY7M24/PWb0Phet/RDWfz2YAgIcENt+wfBKI3bNsej9UPF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpkS8qwKwviI2CCdZEyMa2t6Te1wuwvVMRrH6EwgTW94Uu6MD
	KOYW3Q4sONRXiGg0CsScpOOzuJpD0XsHnvtByBo+dueL621xsBQ4UgwuWcXM4qNYxRTW2V13E4B
	vz2bcaQ==
X-Google-Smtp-Source: AGHT+IEzN4ivVUZ3LY7+XiCKy5mivM7Nb+eR98IsG7RQ9smwOyun2hnDKfIaolvXDa3dRawUVRow8Uo6syzP
X-Received: from edpj9.prod.google.com ([2002:aa7:c0c9:0:b0:5de:d475:6836])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:458c:b0:5de:cbed:c955
 with SMTP id 4fb4d7f45d1cf-5e036065407mr15457393a12.17.1739894698603; Tue, 18
 Feb 2025 08:04:58 -0800 (PST)
Date: Tue, 18 Feb 2025 17:04:34 +0100
In-Reply-To: <cover.1739894594.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739894594.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <607562bf50ddc81ebd404e8dc1710e5221f80342.1739894594.git.dvyukov@google.com>
Subject: [PATCH 1/3] syscall_user_dispatch: Allow allowed range wrap-around
From: Dmitry Vyukov <dvyukov@google.com>
To: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org, 
	peterz@infradead.org, keescook@chromium.org, gregory.price@memverge.com
Cc: Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There are two possible scenarios for syscall filtering:
 - having a trusted/allowed range of PCs, and intercepting everything else
 - or the opposite: a single untrusted/intercepted range and allowing
   everything else
The current implementation only allows the former use case due to
allowed range wrap-around check. Allow the latter use case as well
by removing the wrap-around check.
The latter use case is relevant for any kind of sandboxing scenario,
or monitoring behavior of a single library. If a program wants to
intercept syscalls for PC range [START, END) then it needs to call:
prctl(..., END, -(END-START), ...);
which sets a wrap-around range that excludes everything
besides [START, END).

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Gregory Price <gregory.price@memverge.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/entry/syscall_user_dispatch.c | 9 +++------
 kernel/sys.c                         | 6 ++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 5340c5aa89e7d..a0659f0515404 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -37,6 +37,7 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
 	char state;
 
+	/* Note: this check form allows for range wrap-around. */
 	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
 		return false;
 
@@ -80,13 +81,9 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
 		break;
 	case PR_SYS_DISPATCH_ON:
 		/*
-		 * Validate the direct dispatcher region just for basic
-		 * sanity against overflow and a 0-sized dispatcher
-		 * region.  If the user is able to submit a syscall from
-		 * an address, that address is obviously valid.
+		 * Note: we don't check and allow arbitrary values for
+		 * offset/len in particular to allow range wrap-around.
 		 */
-		if (offset && offset + len <= offset)
-			return -EINVAL;
 
 		/*
 		 * access_ok() will clear memory tags for tagged addresses
diff --git a/kernel/sys.c b/kernel/sys.c
index cb366ff8703af..666322026ad72 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2735,6 +2735,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
 	case PR_SET_SYSCALL_USER_DISPATCH:
+		/*
+		 * Sign-extend len for 32-bit processes to allow region
+		 * wrap-around.
+		 */
+		if (in_compat_syscall())
+			arg4 = (long)(s32)arg4;
 		error = set_syscall_user_dispatch(arg2, arg3, arg4,
 						  (char __user *) arg5);
 		break;
-- 
2.48.1.601.g30ceb7b040-goog


