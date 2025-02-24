Return-Path: <linux-kernel+bounces-528439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD8A417B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD4A1890A92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5D21D3C9;
	Mon, 24 Feb 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtP9LqDu"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020E21D018
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386740; cv=none; b=AKant4ltg3DZ5q8ZRhCRSxDWKO8zdPzWNl/5XlCzXP0oeWVNJgfob7HX3fhDKkX7GPf4BmiHlAG1LL6K/C34N3TZ0F+S2pK5Jpow3QkVOgMdNC0UKOW0z+9iCtV8NUDd9y1yN7Ax6eSU9+7x4YQsZvPBDtdDzajK9TuE8OlVKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386740; c=relaxed/simple;
	bh=6GQcXVe2SCy/A7R9Dn8Z5XgQUnXLIPESvvaPTN/8lhk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SndITBd89UM9aTZmZX+OWjf+c6TA/c5G8GK9/b5rq9wVo6wDGzQ1HxMqLRP81Q5c6Q355AUAyAkOlXvL/YVb6oLxjuVehFpXdoPNsrhHkWeDHuWL/5Ik6GX7cx4Gy886iRTD5EPOOyYlTp25gCuC0vOX0zXlgOZ0lfO/AXZU1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VtP9LqDu; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abb4d3ef1a7so349856866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740386737; x=1740991537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mGUzlKU/88ScEoKu5QKXimL46RVCUcRx5GeW41a5LQ=;
        b=VtP9LqDuxePPrPapWBhU6u3Nh6Z3UATUNNoTwPkxNYnF0BdL1biSDxtAg2NtMSBaSL
         4lgYhD+NarS8hqnonZvKqfPHAhBjn6Q8iIuO1zq6WMLgJsa74gX3OMXMrJ+e85pA5kDb
         +DqshtgMHO4y3iy6YFa7gs88T5IAZRECmJisyzJOi73mWo4H2v2w6nXtGWGIDnKf6Twi
         nJEIrf6qWZN5bWvvmrrjmscI/Vrx8D31csMmNwqN+SI2YprHkBkClInpZzy2cIOpkFVw
         r2gLWXGJ3SGBbz+UyTdO/MgDmHob37MC5zkMI4gfWTM/It8GdRLoXi7fTPiPu3VYAjKL
         QmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386737; x=1740991537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mGUzlKU/88ScEoKu5QKXimL46RVCUcRx5GeW41a5LQ=;
        b=BRgy4KWas+8TGjYprg8+UhPj81Oz8ux3DHqGorKuBfMh2XRvFSbr4FCbUUntPGFOXz
         W8q0aF4AUnv1LzLNyh5oKYZSP/lGDOlB03kn7L4x6YyeaN5jaj6o29Gohjt3AYy6Ddu5
         EAIHg4O0LL8D1s6+7OT+KacRHwiG0GSp/PS7aVdu3iFfSFtQ6kI/7LBdo+ZHdGZGWa2y
         zDVjJNL6/kFuQ9kzd3b/p4Uf1Cxv9w8fw0azpFjzHS1b8CM65J3IW5pPQXd3hwo99/nG
         bJxW586eIYP8eQ07SjAPkuqV6aitmscNiXSEnkbs0M9my5P2+NRhuco/ApJCO2BuhOHT
         aOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJMBM2DeIWkiIhYMECE9TBmDMbRtc0O9kz5EknFj7eXHSrqKrdnfmnBdcbMAQbWtazdXN6mNtIiV0FFPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9S7QVOtr6rSiGL8VGTpPTJzwdCbgsxpJp27nXAl54WD/XcebS
	TFYQq/qYFnv+5PUQT2DArFR6kkOabMLHk8x4Kv0CpkcX6MPKyORj1bfDriERHeZE9FSYP1rnxwU
	GQ8fZig==
X-Google-Smtp-Source: AGHT+IFukiwuqJxcfOF08YHnGZAmuqGLDYsPVBtSaYDroQXCGE5fxa9Wcxt1IHW+nQHGDLsYZPveaU//aLN+
X-Received: from ejcrt7.prod.google.com ([2002:a17:907:8947:b0:abb:910b:456d])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:c456:b0:abc:269d:d534
 with SMTP id a640c23a62f3a-abc269dd58dmr789993966b.40.1740386736737; Mon, 24
 Feb 2025 00:45:36 -0800 (PST)
Date: Mon, 24 Feb 2025 09:45:25 +0100
In-Reply-To: <cover.1740386567.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740386567.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <de940218d0a59fd930ec244d87f2375b16a7815a.1740386567.git.dvyukov@google.com>
Subject: [PATCH v2 1/3] syscall_user_dispatch: Allow allowed range wrap-around
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


