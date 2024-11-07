Return-Path: <linux-kernel+bounces-399878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60259C05C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793AE1F23E04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8E020EA2B;
	Thu,  7 Nov 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJ0G+TQ9"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98920FA81
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982420; cv=none; b=grXYEIkNobxOdEmgAnrWSjuh22opDt26AqbBHwv5YjTY44cD7uPRRFfKfjin3xeJ38BanKcngc80B7BFUF9hB3LlzTQAn9QGW5YMUUb2uc26xEBNL8ruYP/RaWmEqHXS5zTeaPGKelmLoCTtgCjQAu6fAzB0IUaXNMLY5R57kF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982420; c=relaxed/simple;
	bh=fz8dEln5hGrZlPDA3uJ4PthK2vgrx3tU9QXgcl4xOeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A8wqAo0XroknACuAUYcIS+9tz2uREylw7LDNa9Xb5BaZDxOBnjjbCw+XwdeHBs5eO0fCF6VgEZj9bg5vCdrF2I3Kn8bb2k9DmIPPN534z0KIjanmZzd3CixAjTuo4B+dzhJUZHoia+0rzGPlFGN2eivx+OvtgU86z6t08ou7EGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJ0G+TQ9; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a99ea3e1448so76963566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730982416; x=1731587216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sHGNL7Z8k+ba9HHh8eNNDPID0xL9oZVgVqMixfCZM0=;
        b=oJ0G+TQ9K4x7brHqsIraiP35+bTCcwymfTTmuSIP5VDQ51wVVUNeThWK4O9xG71ZDT
         PnQm8Vvo/x4n/X1kXnFwX1F4HOTWCC28RLhMgNcdUDfZzUL1GgR6dHRbbi32JVNo+yi9
         FKcZywqaeG8KujSzx5mKc97n6O20nzUY8lz5sBrSZogaR9HeCS25VgjJTFbdPqqn9mul
         K39DgOlbK7qytS2FzodxCcS+ySuFcjkMnALRk1vmell0o5ejo9sDuFq0E30D7PyQqtO6
         Qqf1hmcy4UxKLFZFDxj9T9pk6Oz3GBGWho1BqzjXITf4FISsQcIo9NeWyVehvwJnPTUk
         vdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982416; x=1731587216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sHGNL7Z8k+ba9HHh8eNNDPID0xL9oZVgVqMixfCZM0=;
        b=a0C1946ykAX58BWq/GcpNNK3Bj/1IFX9CElnKEtreVfCxvp5gna87RfarbHgf2H3Pg
         QiH16bmvOkybl9MLjCK1ZXBlN6ugNlx+kqrKcQftMoOBmQ/yy8D1t+wWnoMnJGyxDbbt
         4vgR3DVLx/Wn1QfZ4ZgVQxTpyyKyMpoOFkMu8lnYAcVWUAt0na0HMK81m1Ux+Q9mhRXS
         nZO+UzoHIjY0Ty4aiuCP+n2XHe5o0hLpYqzCBQ0fAZR1tW3IY9+sOHtf/PGbKKnOOQZt
         IQFQ6rMarwBF6aLfKydR7RlA+hUNbn9Aw0xWXXcLCKObkiVsU1gfVT47N9d0I0SvHjh1
         0jdg==
X-Forwarded-Encrypted: i=1; AJvYcCXBkL5G82yKzkEjw5kNNF5fi16SVVlIcQrmTcG6bg7MrXnCYjE0rDF2RE5xcq3Xdktysp2GrpmksHNEG+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynd72YVyC3hEjelS6U6SbBIC6dBaY6/Epfo4BDVO0CU3DuVgmx
	JuBdkpHcDO3QuaYCwBdG/e2jDPDscl5ni1qgFjF+L/BcZOwlGGC9eqntEq4j/7P3VMkffBY1cw=
	=
X-Google-Smtp-Source: AGHT+IF8rH2dVdPY8X0OhEakGQROrqaJ/kgTLUoX5KRP32vaRlqnDo/+DlfBy71KkMigf9oHS00q79hezg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:8fd5:be93:a8c0:7566])
 (user=elver job=sendgmr) by 2002:a17:906:d108:b0:a9a:1209:c4d with SMTP id
 a640c23a62f3a-a9de6007a5emr1152566b.9.1730982416079; Thu, 07 Nov 2024
 04:26:56 -0800 (PST)
Date: Thu,  7 Nov 2024 13:25:48 +0100
In-Reply-To: <20241107122648.2504368-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107122648.2504368-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107122648.2504368-2-elver@google.com>
Subject: [PATCH v2 2/2] tracing: Remove pid in task_rename tracing output
From: Marco Elver <elver@google.com>
To: elver@google.com, Steven Rostedt <rostedt@goodmis.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Remove pid in task_rename tracepoint output, since that tracepoint only
deals with the current task, and is printed by default. This also saves
some space in the entry and avoids wasted padding.

Link: https://lkml.kernel.org/r/20241105120247.596a0dc9@gandalf.local.home
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch
---
 include/trace/events/task.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 9202cb2524c4..ee202aafa9fd 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -38,22 +38,19 @@ TRACE_EVENT(task_rename,
 	TP_ARGS(task, comm),
 
 	TP_STRUCT__entry(
-		__field(	pid_t,	pid)
 		__array(	char, oldcomm,  TASK_COMM_LEN)
 		__array(	char, newcomm,  TASK_COMM_LEN)
 		__field(	short,	oom_score_adj)
 	),
 
 	TP_fast_assign(
-		__entry->pid = task->pid;
 		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
 		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
-	TP_printk("pid=%d oldcomm=%s newcomm=%s oom_score_adj=%hd",
-		__entry->pid, __entry->oldcomm,
-		__entry->newcomm, __entry->oom_score_adj)
+	TP_printk("oldcomm=%s newcomm=%s oom_score_adj=%hd",
+		  __entry->oldcomm, __entry->newcomm, __entry->oom_score_adj)
 );
 
 /**
-- 
2.47.0.199.ga7371fff76-goog

