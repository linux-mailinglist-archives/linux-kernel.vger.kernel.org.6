Return-Path: <linux-kernel+bounces-191680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751308D1284
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E501C21745
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7CB168BE;
	Tue, 28 May 2024 03:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcvooZCE"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3912B71;
	Tue, 28 May 2024 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716866817; cv=none; b=W8/NTwRsM2Z3WY28AWRgtv9y6pT+ywwJpz4Waxry5IeT8MQ9D10H+vUXopdQBE2WI0BtMgj51mSWdofkFDO9rm3PU3zxtIDbA6MDMX2EDMz5qY6XVn6ZCgdgFDAk/x/BtLbe8TiPrZ6qiffmmwUHKPa7M71jvcPYoP8sPOhcVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716866817; c=relaxed/simple;
	bh=J/qKoDmaAa//Qut0ZZNW3VbpzctSkHcRK6oEwoKnVHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QN4/OWxThh/teBF+1d4BRfY1m+tMIDzxjbLt0deLu5/IsJhi+p0FtY1jaKyYfs/3tiyIlHWZZH8859K1jjYe0njtmtC1rx9oMfsVA073RHnXj5I1qcndYlgl1m6o+WRI0jRZEok9a4CM8f7jzxdpt9rZ6MsV291tToBLRwW+7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcvooZCE; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d1c077b9baso192039b6e.0;
        Mon, 27 May 2024 20:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716866815; x=1717471615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKt9SLq0O6RxnCnYHWJF9LaFqa/mAFeBbqSyy/6tTjA=;
        b=gcvooZCElap5ysZ91zBwlcpWRiMcPZN3h+mAW+6zKczKONZUaqBtIVOFpNI1nH3AdR
         OkClrrHNES/+vjgBidgKU338kSOn0XpmBZkO9mOWnC+xuGDnMARtbm1902TVZunXkPQ8
         ACgX0IA7UWBoZKl9+7HVNB5rRWO7zqJ6TShmW5oqgKBWsUbtHPcmnWKpyrCeGeZTia1n
         dYfsg1Rg5NNsWTRogRq1jKt4FGfHxoBW/nChTGBy+mINQytRjQDiZxd2ASDZz9J/CTCl
         T/uf/TgYIek4Kj8FwY4+X08k3U6e14CAS/QTfdT3oD94KGLkV3QlIXE1W8AuJePFpwYM
         OzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716866815; x=1717471615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKt9SLq0O6RxnCnYHWJF9LaFqa/mAFeBbqSyy/6tTjA=;
        b=hRjfLjxri9GKY6yebRib7LKx1zoELnOsSWryoY8R24zbhaHcMkoRo+foyaWmpjHUCV
         WDTVenxLBw8rcvcMPbzSbT2AbhgZSwX/ZoNad8s6G5nddkCVT2df2ctjbN02bBCtsTTw
         TVt8QUir6DsUiADvNSwf+o3RmX7FaeZVwXNXs+KuNhtEtBvUgFCNhyQRMN0caqLqBcSA
         04AIRJPIcFjxxHWKqgNRQ/gvvenj/UxM4d/k8tcpQMP40tlQXLiYbSqdgOH4SKEBMllw
         Yi7enMwi4Q+KYpGnLQK2s7h9gY66zwL7PGdeR3LgAaLp/lx/JADQzTXh5FtpX7Ao0LcX
         B7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVirVXWja3kIA11lxBacPd6FguvZoTJgTarw7o24rdoWzkOW3DdK3uUEzcDfAlcZQLskLWfu72MBx7l8/pGQwVe+lpj8vAcEOy/WJlPNIWIgfas
X-Gm-Message-State: AOJu0YyCP2V84ypZTOpzgH8gwQq4WnsinZFgaKp2HOsmkSJKPIJeRwKi
	5TO/DMIkE9dz4gAW7SCLzHtNvek5uJTML0RTnDKkvbyDPx4W+4InhVpU/1RR
X-Google-Smtp-Source: AGHT+IHkRfW+TTxGZti83B+civMUqbRtTFG8mBf3ZzbQG1KC6AQ2DXnXRbMaQT/4XEdIAMjNpMMMng==
X-Received: by 2002:a05:6808:634c:b0:3c7:48ba:2190 with SMTP id 5614622812f47-3d1a9191926mr9387554b6e.57.1716866814587;
        Mon, 27 May 2024 20:26:54 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:f3a2:fbda:2824:ae0e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ef4asm5198832b3a.28.2024.05.27.20.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 20:26:54 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tatsuya S <tatsuya.s2862@gmail.com>
Subject: [PATCH v3] ftrace: Hide one more entry in stack trace when ftrace_pid is enabled
Date: Tue, 28 May 2024 12:24:14 +0900
Message-ID: <20240528032604.6813-3-tatsuya.s2862@gmail.com>
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
Changes in v3:
    - New subject line
    - Link to v2: https://lore.kernel.org/linux-trace-kernel/20240527100916.5737-2-tatsuya.s2862@gmail.com
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


