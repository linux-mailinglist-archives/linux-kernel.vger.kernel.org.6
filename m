Return-Path: <linux-kernel+bounces-440185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382C79EB9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9440E16759F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6F021420F;
	Tue, 10 Dec 2024 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gROHcKLt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE42046BB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857704; cv=none; b=SMNeGiSUuv1DIm6ajX5le0EV1fJ/cT6OE43upKDoMoS0v+p5PVGu62Lc0sqg4KD0DziXVipULdP21DBC+UEAUp4NI1wIdLgEE4XVhoqVlAbWkAqWwavLhPW8hsMo6NZL77WvewFnruMa6kfXKCf8EBmXuo1FCAwC4D5I9nQvYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857704; c=relaxed/simple;
	bh=OBA/k63P+hJ6W89saEe6KfZEbbvLJjgEvcX8dOR2pRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k5WdKx2ZZjkl0OdCEkQYLFpyT6cS+roQdJjIPZAAhFRIpOtbRWSpR3yfXOaU4GzFcvexoLKnoNSS+DCaEKOzC6MS+Nxy5gvc1dIn4RVpAk95ieKjj26iQwK38eb5g4WtGME9WZskE5FbDCJt9kd2s4X03k6lU91bgWczjJNYqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gROHcKLt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434fa6bf6e4so1755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733857701; x=1734462501; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/gp+xvfN8/i+P7Cf0TPdTY3lpfNfhujcHdaaIoHcjE=;
        b=gROHcKLt7OyTrOHCrNdu6tF9l6gLPZX5njeBtPWKTBv/rx1QLHSll1qnKBtBRUGZE7
         +P0+JoNoTJIg0UyURAPbzg76m9Qh0XnqaYOg9sMsBVnkSBddlbWvTI9LMqsO2mxi3dpf
         NssWTW2+8f9lb9ndTybMEvJs2Or2d3k0WILQ+n3BSC7PX332NWTMonIOP+pb18yFpsRx
         uEoKpSusnobDdRm1ZrhvZa6Hus6+xcbEcq21eZFn0z/t16q1X2fUDcW980DEe5hAalFM
         FjqezESlNdPppNsmPMoHJNN3hgbeCfWmGzVtye379bA4V0hsSj6ZHpuHIyYgoP+95Jdi
         lbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857701; x=1734462501;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/gp+xvfN8/i+P7Cf0TPdTY3lpfNfhujcHdaaIoHcjE=;
        b=oHu+/BaBXC59yhlOFxTtg0HrGSSiosJr/sJo9LaD9z0/X2lzGjB/HTwbHa2UOuwKNp
         8WsGHk4i3DIfILAdQkoXpj04/mmCnzuNDUQwDtFS+8tc9K0LPY+KErQrRIpgAbtGdyG+
         TmR541w0jPHPBwBp1CDLMrX86c3KX7fOBP2W0HTjLYrjE+J+7dly4nzoy26dPeFqV47t
         xsISi9g0gEGJZmS5AkFtLpCQhs+Z326Y/lxqVe49f9RwI2CdBbUtB2FXkIMzL6C9pz59
         rdBppljrw+uwSvkjeqX0Utzdx+bv6ffr/sr7PzhOjCpPUbXH3jJiEG0AbBrYt/inCR/Z
         SiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoGD7vPxLoWUWC2BIyDeChjSyo8IdtqXSoBx5iSmMIjNrvTbB/3UYQHtiKRSppCN8vRc/6VP1uajR7YIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDIF95zVYwI7E+TW6597hjnO1q1UDTS+6SEUJUwMRps6w1Zmm
	cWjIqQyezeSRrvR799BPyMen9127TfOSPuLA1cHy0oqIDvYioHOZvW4St+2xtw==
X-Gm-Gg: ASbGncvMotXtmPr2l38Xoq6GJhh174kqqaMfVCtQiJ0w1SvgI/LtD+7bz9teWaFllAV
	6zSdhwfH081wHFD2DHt9kpIRz1TMf0X73hk9V9kYvq9i/7MnqSCggTNT9O5iK0A/UpfcM9zmjXg
	4ikZdxyx020PC1n/fvXt7uCHE1KdsGvZWRayU8/E8POu6KUwWCsMb4ulhtD6GGTHtBmFWgJJ9zK
	rtVt7MS6LG6Srynpnr/oStiMXgXEyE4xJeAVvig9hM=
X-Google-Smtp-Source: AGHT+IGY39e6R63xnH3CIhNKNy4+rqeH8Uhej0IfCmcAAyEqxQDCjQh6Z/p6Xb6Ck5IwZOyiJrgHDA==
X-Received: by 2002:a05:600c:54c3:b0:434:9d0b:bd7c with SMTP id 5b1f17b1804b1-4361c20ff37mr31185e9.3.1733857700456;
        Tue, 10 Dec 2024 11:08:20 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:deb9:87dc:18b2:3f1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a8758sm16408314f8f.27.2024.12.10.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:08:19 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Dec 2024 20:08:14 +0100
Subject: [PATCH bpf v4] bpf: Fix theoretical prog_array UAF in
 __uprobe_perf_func()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-bpf-fix-uprobe-uaf-v4-1-5fc8959b2b74@google.com>
X-B4-Tracking: v=1; b=H4sIAJ2RWGcC/4XNTQ7CIBAF4Ks0rMXAFPrjynsYF5QOLYmWBizRN
 L27hJVGo8s38+ablQT0FgM5FCvxGG2wbkpB7AqiRzUNSG2fMgEGggOraDcbauydLrN3HdJFGSr
 LvoWmU13ZM5IOZ4+pkdETSX1yTsPRhpvzj/wo8rz6ZUZOOa2aqtWN4jXI5jg4N1xwr901exH+G
 5AMoWuppTAoQHwY5YvB2VejTIZGyRSCAsPMm7Ft2xNZsqXIQgEAAA==
X-Change-ID: 20241206-bpf-fix-uprobe-uaf-53d928bab3d0
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Delyan Kratunov <delyank@fb.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733857696; l=4279;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=OBA/k63P+hJ6W89saEe6KfZEbbvLJjgEvcX8dOR2pRU=;
 b=Q+Rj+xb9hhm9UPtrCHya/n/DSTl/jnSmvwg1DUMqXf3lQTCFi5XQhU9SY5PYylws/wOKSMrjS
 traFLvqdtvZBa+6lPyP8rw//H+YAZhNvAbl6YgV+9aUqwCMJcns62L+
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Currently, the pointer stored in call->prog_array is loaded in
__uprobe_perf_func(), with no RCU annotation and no immediately visible
RCU protection, so it looks as if the loaded pointer can immediately be
dangling.
Later, bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical
section, but this is too late. It then uses rcu_dereference_check(), but
this use of rcu_dereference_check() does not actually dereference anything.

Fix it by aligning the semantics to bpf_prog_run_array(): Let the caller
provide rcu_read_lock_trace() protection and then load call->prog_array
with rcu_dereference_check().

This issue seems to be theoretical: I don't know of any way to reach this
code without having handle_swbp() further up the stack, which is already
holding a rcu_read_lock_trace() lock, so where we take
rcu_read_lock_trace() in __uprobe_perf_func()/bpf_prog_run_array_uprobe()
doesn't actually have any effect.

Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v4:
- re-add !array check that I wrongly removed (Andrii)
- style: remove one empty line I added that doesn't exist in bpf_prog_run_array
- Link to v3: https://lore.kernel.org/r/20241210-bpf-fix-uprobe-uaf-v3-1-ce50ae2a2f0f@google.com

Changes in v3:
- align semantics with bpf_prog_run_array()
- correct commit message: the issue is theoretical
- remove stable CC
- Link to v2: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com

Changes in v2:
- remove diff chunk in patch notes that confuses git
- Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v1-1-6869c8a17258@google.com
---
 include/linux/bpf.h         | 13 +++++--------
 kernel/trace/trace_uprobe.c |  6 +++++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eaee2a819f4c150a34a7b1075584711609682e4c..cfc415632cad7401d1ab66410f095c28f9293c93 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
  * rcu-protected dynamically sized maps.
  */
 static __always_inline u32
-bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
+bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 			  const void *ctx, bpf_prog_run_fn run_prog)
 {
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
-	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 	u32 ret = 1;
 
 	might_fault();
+	RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
+
+	if (unlikely(!array))
+		return ret;
 
-	rcu_read_lock_trace();
 	migrate_disable();
 
 	run_ctx.is_uprobe = true;
 
-	array = rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
-	if (unlikely(!array))
-		goto out;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
@@ -2227,9 +2226,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
 			rcu_read_unlock();
 	}
 	bpf_reset_run_ctx(old_run_ctx);
-out:
 	migrate_enable();
-	rcu_read_unlock_trace();
 	return ret;
 }
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fed382b7881b82ee3c334ea77860cce77581a74d..4875e7f5de3db249af34c539c079fbedd38f4107 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1402,9 +1402,13 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 #ifdef CONFIG_BPF_EVENTS
 	if (bpf_prog_array_valid(call)) {
+		const struct bpf_prog_array *array;
 		u32 ret;
 
-		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
+		rcu_read_lock_trace();
+		array = rcu_dereference_check(call->prog_array, rcu_read_lock_trace_held());
+		ret = bpf_prog_run_array_uprobe(array, regs, bpf_prog_run);
+		rcu_read_unlock_trace();
 		if (!ret)
 			return;
 	}

---
base-commit: 509df676c2d79c985ec2eaa3e3a3bbe557645861
change-id: 20241206-bpf-fix-uprobe-uaf-53d928bab3d0

-- 
Jann Horn <jannh@google.com>


