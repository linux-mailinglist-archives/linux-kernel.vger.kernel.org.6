Return-Path: <linux-kernel+bounces-189724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD528CF415
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 13:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCAE1F216DC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD0C157;
	Sun, 26 May 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCpMMGsf"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A979DF;
	Sun, 26 May 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716722990; cv=none; b=UKg2HDPIh8Vq+PvTHXGZP19p0l21h9og4649+SNgF8+eIr7clpe8A1I5OAdHxVG74iYeUqd+ujbS8f9xI5uY+POts9NhoOR3i6F3eBZ2fXP7OYRUaq+Hk2/pfqmln4sFZyNsl7NopZYn3S+ptLGprZ4feCmgzFatNR7cYs7bEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716722990; c=relaxed/simple;
	bh=m7WE6uRCBwWdaM+TANh0R3QQ5W14DekpE2GAH0HVaoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpN9Pyd8Z6jPFmmT9BvNdlwVKMVq2yfVGvLGJoa4ZfPEyK4Ceauatk9xRBWD7hcRuvb35UWIBxKpn8lFdPWaRzu2LZY6lcfdTpOhCEKlsNNAE99Rm9o+/oQvnhjS1jfThEGPwT/Q/4zp1OhiGAHnBjgeIO+trmqWYuxEdstgJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCpMMGsf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f47f0d8ec9so4173365ad.3;
        Sun, 26 May 2024 04:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716722988; x=1717327788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAQfWvd3nmcnR5EidU0DiImMMPxXcL5PouM/aKZ2j7s=;
        b=KCpMMGsfd1+6uWQ2jenZ6pHrZZX0D7izW8O91vFQCZwWYsSEXqUrk3W+1xSqLDg1Mi
         Dw92GSAKLNl71vUH+xLRoAf/3t/5xfYLhjzh8CD3ySWqTxIqtc5GgVsFOC3t0SEiXIfs
         I0vEmX9A9dnwT2I/nSirAsaQferXZFKc7/LEXFwqi4KFILnWqO0Yqf1gIVE96+tsUukW
         /FulpPoGMYX4E7/uZZcTn3/x0y27PuSwUeuKtO3YnLGdxXpAmlaSCjZTjoVJDu/75g4I
         wMNcYaKZ7hwb5X/eHdZgNWI3TMCspvQ4fhPevozLh7byRGLWQEDCNdsFBzeveNZdGEtB
         kfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716722988; x=1717327788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAQfWvd3nmcnR5EidU0DiImMMPxXcL5PouM/aKZ2j7s=;
        b=awkPcy+tWF9sBMjZxoxDqTviSwoO1YO8knayRE+vDUldqxqi0EpFWLNRa0NNlT59ge
         7vBw4uZ5m1n2+g0bKOO4dKTmqZK5uUTqTe76/Iin/FDa4Kp0sT0v9sxfpJXWMKYTWULL
         q2K06koydNJps7a114CqepL4fflSLD1kd/+iicuXvaV+sL2nSDFwmz4bMVWqCsjVqHaM
         19P3g2K9sktPq7pjPYr60PhP983yQ6o1Fpk3Q/qxD0RWgWrtdCS1HmHsr21XOFT2W2Gp
         1N9IkCTJe1fE81B5eNawVfQlnHzaYWWt8BMsjyFMR4vARAVqbO5H0C2/iWkOrAsk11p8
         ao2g==
X-Forwarded-Encrypted: i=1; AJvYcCUasnocNRFzj2UR6m1K4g6UX8YwwvzlGeZmfzEXzrqFeMz9w2fQCjqy4DStY1BuRtnxHBKH6iSDEvN7zvx5TnbIAQGwLbuWtRmuRasemhYeYdHn
X-Gm-Message-State: AOJu0YyErNdKyrHc4D4G0dvIsIXa0j8anHEe/SrYdEbozebOzCcCOuEr
	PQg84uMGpNS9gLBpQ92lqhqJYEjU2SNDrNjHGGWShXGcjhMogDO7
X-Google-Smtp-Source: AGHT+IF5GEmFSc5JVcFPUonDzMobbhUaU5CfYK6h+nU5wmyW5PlDDsumsIuq3cdyo7xJhB2E/nYahw==
X-Received: by 2002:a17:903:41ce:b0:1f4:5477:4bfe with SMTP id d9443c01a7336-1f454774e3cmr60787325ad.69.1716722988355;
        Sun, 26 May 2024 04:29:48 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:f3a2:fbda:2824:ae0e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c970ca0sm43429925ad.142.2024.05.26.04.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 04:29:48 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tatsuya S <tatsuya.s2862@gmail.com>
Subject: [PATCH] ftrace: Fix stack trace entry generated by ftrace_pid_func()
Date: Sun, 26 May 2024 20:25:11 +0900
Message-ID: <20240526112658.46740-1-tatsuya.s2862@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On setting set_ftrace_pid, a extra entry generated by ftrace_pid_func()
is shown on stack trace(CONFIG_UNWINDER_FRAME_POINTER=y).

        [004] .....    68.459382: <stack trace>
 => 0xffffffffa00090af
 => ksys_read
 => __x64_sys_read
 => x64_sys_call
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

To resolve this issue, increment skip count
in function_stack_trace_call() if pids are set.

Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
---
 include/linux/ftrace.h         | 1 +
 kernel/trace/ftrace.c          | 2 +-
 kernel/trace/trace_functions.c | 7 ++++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 800995c425e0..d14447c0d0e9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -666,6 +666,7 @@ unsigned long ftrace_location(unsigned long ip);
 unsigned long ftrace_location_range(unsigned long start, unsigned long end);
 unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec);
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec);
+bool ftrace_pids_enabled(struct ftrace_ops *ops);
 
 extern ftrace_func_t ftrace_trace_function;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 65208d3b5ed9..e8ddd56d1e55 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -99,7 +99,7 @@ struct ftrace_ops *function_trace_op __read_mostly = &ftrace_list_end;
 /* What to set function_trace_op to */
 static struct ftrace_ops *set_function_trace_op;
 
-static bool ftrace_pids_enabled(struct ftrace_ops *ops)
+bool ftrace_pids_enabled(struct ftrace_ops *ops)
 {
 	struct trace_array *tr;
 
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 9f1bfbe105e8..455c9a880199 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -223,6 +223,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	long disabled;
 	int cpu;
 	unsigned int trace_ctx;
+	int skip = STACK_SKIP;
 
 	if (unlikely(!tr->function_enabled))
 		return;
@@ -239,7 +240,11 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (likely(disabled == 1)) {
 		trace_ctx = tracing_gen_ctx_flags(flags);
 		trace_function(tr, ip, parent_ip, trace_ctx);
-		__trace_stack(tr, trace_ctx, STACK_SKIP);
+#ifdef CONFIG_UNWINDER_FRAME_POINTER
+		if (ftrace_pids_enabled(op))
+			skip++;
+#endif
+		__trace_stack(tr, trace_ctx, skip);
 	}
 
 	atomic_dec(&data->disabled);
-- 
2.45.1


