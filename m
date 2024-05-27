Return-Path: <linux-kernel+bounces-190413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58158CFDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68551C217BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E713AD1E;
	Mon, 27 May 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC0aMroZ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F0E572;
	Mon, 27 May 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805078; cv=none; b=Na/kUToV7hSegacxeKrHyYBHX2NEoI5KOgDhHBjHrEiv8by2PTceQeAd2sFFBDgTLoXcJI1Qrew+LG83ZPVXyibIo6EshkdUdIAQDIWSt5yR0JLv8DsMiqgotDcjdkhbArtJ/MQ4JyDabldVkVJBk9uYC33l/IszvRRwy2vRzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805078; c=relaxed/simple;
	bh=cyr6EFzXGJf5ZwPIzTR1hgMASRZcnsU93XrAAYJbXcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccsEf66zRyg3OajcTotcESMOlGuvOLgt9ofYC5jpfoN7+qAOTO8DTE/DeWkk3kmp337wDUTiviPvE0qTMcL0cOtzhVrHD5ROS7G1FkOORUPG69eDc8xJ97XB7ILDj+ItTKBcfEn+pwggmVdB0aR9Ii/pkt2YaSoHDQPAN7rUJoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC0aMroZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8ea3e9543so2368878b3a.2;
        Mon, 27 May 2024 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716805076; x=1717409876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jq72rLrn+A+D7G+wX9IPCEHaClv8ndLPPxQk8oIeS9c=;
        b=AC0aMroZkMP96jmDORv0yNXel1Lb700sD+TB/gzo2yUhH1TNbSxVwQxKBL1IAYyCGq
         ++ktwiU0ug05+CKAbteFX+vAh3rnvO4Etnm715to+wjZuQc1io48tPTuMu/CVfEWzgkM
         k1UprVfJumq05W9+iyTVJn6bNPj2pgEHvsDfRVWbLrrtvcjW7bcycryL98J2iuaipxpE
         3vuRoEDisSvqI9ik6BYXS+oUWT5U1j7DPOKzndhoCAfvj0g2o9UyXlCjAnNiJ9D+zIP0
         zy6gqEV1upBd68bjL0qIUS+CZm1M7Ob2QuYLj3jHmVrvxkWo/3eO8zEw3/Lr2ND8mvKF
         bCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716805076; x=1717409876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jq72rLrn+A+D7G+wX9IPCEHaClv8ndLPPxQk8oIeS9c=;
        b=L3u5td8uY0IjM9eCWKhRjoes2IVK5ybiz5cNo96pIsWLuhON6NQ0qTaoKB5PxAU87b
         SZ+UEFRkSCSsa6/PuhAjKU08I6uOPRPRTv5Xwu0UCAvtw3lJgxRQB7VF0w2Fr3kVp6sa
         5FOFJ+4Xqbi1T8INMyshEKb6s3iGrmShNRXB8Q/j8Kh6B1wKABXnIPVOkYsocF+gZ4hZ
         lnFl/fXPqm3lqRRFf7cf4d3ikp4BtRSQ5wnDxwyEysUq2sj7wb3arPkkfU3IooSQvnhG
         Qp13jXzK8mfgbvNZClsNZ4q6q73mUFxvsh6QkpVWoRK3PPR+X1Cg5FyrBA2f291GMGKf
         k2CA==
X-Forwarded-Encrypted: i=1; AJvYcCUySbIrnveXsjvYvQBTnoMxS5xX+7+lYP5R9or2sluXvqLIYh6HWtm4yhhXf9arwwFczuSiYg+Any7Lo/1E4xhl0jdzNR1Xv6OpUOiAA1EpYiyG
X-Gm-Message-State: AOJu0YwsXNrJoEPSrz+GhQ9yWpZ2U3L1+dRx9n0tTTmYpNv+Re9S07oL
	J8G5AsqhPIa9TyLTVLAiCQy7YRCE0Ds/NmzwvowNH/ODJROVaaEo
X-Google-Smtp-Source: AGHT+IF/G3fuC0rANnb+pLiF++4Ae182gfa6BvzyOPoaWKyoEVDn4Bx0Cb9Pq1cvu1yZBtgs8vvz8w==
X-Received: by 2002:a05:6a20:324b:b0:1b0:14ee:3b1c with SMTP id adf61e73a8af0-1b212d2852bmr8178711637.22.1716805076222;
        Mon, 27 May 2024 03:17:56 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:f3a2:fbda:2824:ae0e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc059912sm4594570b3a.54.2024.05.27.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:17:55 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tatsuya S <tatsuya.s2862@gmail.com>
Subject: [PATCH v2] ftrace: Fix stack trace entry generated by ftrace_pid_func()
Date: Mon, 27 May 2024 18:44:56 +0900
Message-ID: <20240527100916.5737-2-tatsuya.s2862@gmail.com>
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
Changes in v2:
    - Fix build warnings reported by kernel test robot
    - Link to v1: https://lore.kernel.org/linux-trace-kernel/20240526112658.46740-1-tatsuya.s2862@gmail.com/

 include/linux/ftrace.h         | 2 ++
 kernel/trace/ftrace.c          | 2 +-
 kernel/trace/trace_functions.c | 7 ++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 800995c425e0..0855dfe768eb 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -913,6 +913,8 @@ static inline bool is_ftrace_trampoline(unsigned long addr)
 /* totally disable ftrace - can not re-enable after this */
 void ftrace_kill(void);
 
+bool ftrace_pids_enabled(struct ftrace_ops *ops);
+
 static inline void tracer_disable(void)
 {
 #ifdef CONFIG_FUNCTION_TRACER
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


