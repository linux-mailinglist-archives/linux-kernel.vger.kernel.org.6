Return-Path: <linux-kernel+bounces-422386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A169D98F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75328165B14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE791D517E;
	Tue, 26 Nov 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brdlPCxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935C1D54EF;
	Tue, 26 Nov 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629406; cv=none; b=qGUFCvf4VcvD3g0Vn53R2dWAP9YVb/bamV6ve20EoeyqN+GRhuiGK42tx6lhORA7O0/gH/t+7iySGslis5D0Fo8/OdTA1aAy/LINBt6qNSufMQhC+av+wTfIGGRQn4s4mvAL+C+UTP3sitHPB/MHDrnMF+/wchJbmLnXc6k01dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629406; c=relaxed/simple;
	bh=lKW+UN1gtrpdcRVL8HfEsiSm3Hrt7GReKZv5w97QAsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZ41fYEJdWfi9fs7avWAK23E0t2o/FaG5ZYwlNEAjLQMwmViktXOQJbWtR7DtgIC53LbaJo2AAFpX3hXzdw6w88lUZwIRNLgfqqHa7GX8ttfLUqRJyW5bA4LKA9o8hzChuezptpof+Dk7rXdLD2mvuNwD9BnJKuRz2Yihsggw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brdlPCxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF4AC4CECF;
	Tue, 26 Nov 2024 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732629406;
	bh=lKW+UN1gtrpdcRVL8HfEsiSm3Hrt7GReKZv5w97QAsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brdlPCxqZClxKqLpr+6X3GeviYtOz3NRDR+hUK43YKAJX9DHRh8kUWnQFAYskXfmW
	 9vdJkr4xkFIsLbQSBPOwJeADnYeIVbzYL0VJ5jnnDLsWW4OO4WVM/BYp5IbZy0RX/Q
	 lURPWEx/fL/jD/4rdIh9dPoA54+avQlA6esGvH+Pd/4nIBcxV6vrgViY/F9mIYzTIp
	 0L3Ey51MV0i/hKWdhIgkIgFAsvzcNg7eMOcjSMoi3P66jtgByCps2bqTEkOXlCnB8m
	 f4ya55ZrtZhXTMaZtgBXDFgSv+2UxJmxXIR6XllBXDZ1NuGL+ejHlHmQr9ykm3t4eq
	 U4Yxkb1pTFQTw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/6] tracing/kprobe: Adopt guard() and scoped_guard()
Date: Tue, 26 Nov 2024 22:56:41 +0900
Message-ID: <173262940168.8323.11089236109729479315.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173262937038.8323.5774362855789721936.stgit@devnote2>
References: <173262937038.8323.5774362855789721936.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use guard() or scoped_guard() in kprobe events for critical sections
rather than discrete lock/unlock pairs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 263fac44d3ca..bae26eb14449 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -634,7 +634,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	struct trace_kprobe *old_tk;
 	int ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	old_tk = find_trace_kprobe(trace_probe_name(&tk->tp),
 				   trace_probe_group_name(&tk->tp));
@@ -642,11 +642,9 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 		if (trace_kprobe_is_return(tk) != trace_kprobe_is_return(old_tk)) {
 			trace_probe_log_set_index(0);
 			trace_probe_log_err(0, DIFF_PROBE_TYPE);
-			ret = -EEXIST;
-		} else {
-			ret = append_trace_kprobe(tk, old_tk);
+			return -EEXIST;
 		}
-		goto end;
+		return append_trace_kprobe(tk, old_tk);
 	}
 
 	/* Register new event */
@@ -657,7 +655,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 			trace_probe_log_err(0, EVENT_EXIST);
 		} else
 			pr_warn("Failed to register probe event(%d)\n", ret);
-		goto end;
+		return ret;
 	}
 
 	/* Register k*probe */
@@ -672,8 +670,6 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	else
 		dyn_event_add(&tk->devent, trace_probe_event_call(&tk->tp));
 
-end:
-	mutex_unlock(&event_mutex);
 	return ret;
 }
 
@@ -706,7 +702,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	/* Update probes on coming module */
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 	for_each_trace_kprobe(tk, pos) {
 		if (trace_kprobe_within_module(tk, mod)) {
 			/* Don't need to check busy - this should have gone. */
@@ -718,7 +714,6 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 					module_name(mod), ret);
 		}
 	}
-	mutex_unlock(&event_mutex);
 
 	return NOTIFY_DONE;
 }
@@ -1968,13 +1963,12 @@ static __init void enable_boot_kprobe_events(void)
 	struct trace_kprobe *tk;
 	struct dyn_event *pos;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 	for_each_trace_kprobe(tk, pos) {
 		list_for_each_entry(file, &tr->events, list)
 			if (file->event_call == trace_probe_event_call(&tk->tp))
 				trace_event_enable_disable(file, 1, 0);
 	}
-	mutex_unlock(&event_mutex);
 }
 
 static __init void setup_boot_kprobe_events(void)


