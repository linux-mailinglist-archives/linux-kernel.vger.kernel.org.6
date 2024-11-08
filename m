Return-Path: <linux-kernel+bounces-401556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7927E9C1C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324641F23CAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45E1E47C4;
	Fri,  8 Nov 2024 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcpF/lF/"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAD1E47BE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065710; cv=none; b=Z4AZoshi7PqWjIEm2mZl1mcd6VxfHWT2DrLzc9WKq+DmsGKPSMd5Zz4BnF4VwcZd7xTKQrtO2MY57wJ+pwPhhBMVe6YE/s1+3wlR50YE0NvlWulRAg9hytgAkTR0Jj54QhUhuRccGZPmWRIyjy6GdEk0Xa0KuJCvyfKHz2ooywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065710; c=relaxed/simple;
	bh=hEHya/EWTyjGrJkb2WFQ/xz8flII2H8gY8bYE4SYXJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trr8rw0jISIOznGbRSkUzDL4NA0Lo2JpCDfm+hS/t5qiIJBfiM1jUTro+YedZTp5tyRvWypLfkeO/VGKcCltXw6yPvmnYlTI/qXUwTHhEUzeoItRUgZXQf//T+7klp0dy4vD4A8QvzIAEXomXnpNbjC55JDbC+xmMMalCDB1rpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcpF/lF/; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a9a2ccb77ceso171679066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731065707; x=1731670507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmVAOqvZ/Tu1S1PwD7c/mNbANvvbo6/nc3HYAPUr/Js=;
        b=fcpF/lF/VD2YmfRPWkre+ZbqYng2N6TmHsRh79VKcKAvNoBX4bhXTFjiZRjEeMa/HV
         eRjE7dMJTT8mG3hWHX4OnDjKTl4rFOqob5nV1NLKO2SJFgXNw9XzbW+afASmMDpnZx+5
         XVNYp74WsG57RcYJWjEPkINX80BBTZdmkRRWquibZ7xM3NSA6/qouLGHW4yiSACFMF1y
         WYdXPDI7dpTqrppTOjrwPfVJF7qOD0A4wOqNL6sCxf71fpLgV7i1b/AMRMk+17gttAs7
         GHavfKCsyq/c6k1UqjyuWYFLHiTB46W3JhjSdLXZTDQnIuKO4oAHcOqfh9Pbo+VUcezL
         PvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065707; x=1731670507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmVAOqvZ/Tu1S1PwD7c/mNbANvvbo6/nc3HYAPUr/Js=;
        b=FCa84r7w7MwLTwt50sA2R3di7xO6kKKcguLO9HT3nr1Mf2z1R1scvP3Xczqy4uD9Fk
         uH65x6bNTU/rY7fllysYDOhXCHct0rsJiQGPML4Ci9bldo+V3ZlyH3VRuFbIEvBYMGX9
         l8qHiwaRFfh1sI+0gLaUY87suLj0W8oKaEjXis5KT6NPwl+nS4o6LhS/vNqgLYBDBJDH
         +FhV4agJ59uPJy7cK9GFixaYbiHiXjVhaSa8o/xQ6fOITn6QK9h7iiM53S8e98KCDnra
         1Ul6J1OnGfdM+MKGbux7p8gkjjFuZeRwBVCjabSaHbt1m347n5+qw9hs5pOdtkDP7ibg
         Xemg==
X-Forwarded-Encrypted: i=1; AJvYcCVWJ46UDNsJgY16CvVlY8pyVx9+wDicoRovMaw0b05PWOVdLeHRpA401XJngolXVqPZvBTyObwpmAa8tU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjK1XZlDK7vPYD3HIqrtXoyLnouiovm3pgz0y3xYRbOd56qI5
	eHDpQsL5UCmPMmRV5KqMCcltlMX40w4HQBgREjiI3FuxL3yhHaEZfk0HMP1oaZeU74iadmRDHg=
	=
X-Google-Smtp-Source: AGHT+IG2mwQUKoRUSpKj9hUWjVgwtRnTOzorVQZkyuHXLrzTO0C2kG5XBaRDL6I4WJyy3fUtsdzTNRaa+A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:1d41:9aa5:8c04:911])
 (user=elver job=sendgmr) by 2002:a17:906:2557:b0:a9a:1769:f4db with SMTP id
 a640c23a62f3a-a9eeff38838mr49766b.5.1731065707141; Fri, 08 Nov 2024 03:35:07
 -0800 (PST)
Date: Fri,  8 Nov 2024 12:34:25 +0100
In-Reply-To: <20241108113455.2924361-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108113455.2924361-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108113455.2924361-2-elver@google.com>
Subject: [PATCH v3 2/2] tracing: Remove pid in task_rename tracing output
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
index 209d315852fb..af535b053033 100644
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
2.47.0.277.g8800431eea-goog


