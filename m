Return-Path: <linux-kernel+bounces-540973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3267A4B717
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CDC16CC84
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5B1D516A;
	Mon,  3 Mar 2025 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZdPnqCj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7513C8E8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740974957; cv=none; b=X5Nvkb7SHbrlwEl2Vwc1ONctR4g6sfYYqg9N0bZM6oNlCiCiLx4HsexZ5h5hp5hb2CfEVCgdYUi3c63IqrhnQQUrpRiBPgkPj0+8nhcKzPYUMb23JRmEDVT5+w/dmiwQJb+gsFsu+1Gtm20phvhKt44LXCMT1iOAQ2/CwmXLXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740974957; c=relaxed/simple;
	bh=7hKX0fEuBcixcx19TWpXVaY240JMSAx6tsmyGIUdMEM=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=rl2eKnb9MHFPib0BLcE4BIrK9dj3GSFOROQqPrldukNxbgAAMAaEZDdjs6W2VkPAVrJiRC8r2BD3utXTwR8zGWAUMvdWUrSpDVWsXPH7ONfpfaCBODx9VkGzO14SN3HQqf4MabXw88M3Ut37ytNLmPD2/ow+8RY4w29dWHPWrec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZdPnqCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A778C4CED6;
	Mon,  3 Mar 2025 04:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740974955;
	bh=7hKX0fEuBcixcx19TWpXVaY240JMSAx6tsmyGIUdMEM=;
	h=Date:From:To:Cc:Subject:From;
	b=DZdPnqCjOyS++oQ0WhfMqIqdbk0NhQ67zliHkwy1R4i2tTVkaFuNmgncub0UKpO/G
	 EtG7pLrT0MCfZimfKZqPedIZ85UnStFbJ8Jl4GEPI9LPxIDubtVycnE7tNhtHzRwub
	 vbuIRwZZUpOpfVRjpNm8kvmx9xVpu/lRqRlkgJBuTdctJOk54t3OhLqNtLoMx2/VoT
	 3GF66wR8RjreM30BATrcS5OnBbIvYGogNi2U23jFB5e+D8LpSDu0ebbz0Wwx8OEX8F
	 WbDppHpYZ6c7mZ0FnfKdqYFJla2IiwqRl0b6hPQvBYhRBMSJHFHnrtBHJrkid507fC
	 m7Mzy7gW0HgyA==
Date: Mon, 3 Mar 2025 13:09:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.14-rc4
Message-Id: <20250303130912.f5c90441a656c84edbbe5ba2@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.14-rc4:

- probe-events: Some issues are fixed.
 . probe-events: Remove unused MAX_ARG_BUF_LEN macro.
   MAX_ARG_BUF_LEN is not used so remove it.
 . fprobe-events: Log error for exceeding the number of entry args.
   Since the max number of entry args is limited, it should be checked
   and rejected when the parser detects it.
 . tprobe-events: Reject invalid tracepoint name
   User can specify an invalid tracepoint name e.g. including '/', then
   the new event is not defined correctly in the eventfs.
 . tprobe-events: Fix a memory leak when tprobe defined with $retval
   There is a memory leak if tprobe is defined with $retval.


Please pull the latest probes-fixes-v6.14-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.14-rc4

Tag SHA1: 3af5dabeb0954e0d1f0321556d140b0475547c22
Head SHA1: fd5ba38390c59e1c147480ae49b6133c4ac24001


Masami Hiramatsu (Google) (4):
      tracing: tprobe-events: Fix a memory leak when tprobe with $retval
      tracing: tprobe-events: Reject invalid tracepoint name
      tracing: fprobe-events: Log error for exceeding the number of entry args
      tracing: probe-events: Remove unused MAX_ARG_BUF_LEN macro

----
 kernel/trace/trace_fprobe.c | 20 ++++++++++++++++++++
 kernel/trace/trace_probe.h  |  5 +++--
 2 files changed, 23 insertions(+), 2 deletions(-)
---------------------------
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index b8f3c4ba309b..e27305d31fc5 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1049,6 +1049,19 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 	if (*is_return)
 		return 0;
 
+	if (is_tracepoint) {
+		tmp = *symbol;
+		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
+			tmp++;
+		if (*tmp) {
+			/* find a wrong character. */
+			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
+			kfree(*symbol);
+			*symbol = NULL;
+			return -EINVAL;
+		}
+	}
+
 	/* If there is $retval, this should be a return fprobe. */
 	for (i = 2; i < argc; i++) {
 		tmp = strstr(argv[i], "$retval");
@@ -1056,6 +1069,8 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 			if (is_tracepoint) {
 				trace_probe_log_set_index(i);
 				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
+				kfree(*symbol);
+				*symbol = NULL;
 				return -EINVAL;
 			}
 			*is_return = true;
@@ -1215,6 +1230,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
 	if (is_return && tf->tp.entry_arg) {
 		tf->fp.entry_handler = trace_fprobe_entry_handler;
 		tf->fp.entry_data_size = traceprobe_get_entry_data_size(&tf->tp);
+		if (ALIGN(tf->fp.entry_data_size, sizeof(long)) > MAX_FPROBE_DATA_SIZE) {
+			trace_probe_log_set_index(2);
+			trace_probe_log_err(0, TOO_MANY_EARGS);
+			return -E2BIG;
+		}
 	}
 
 	ret = traceprobe_set_print_fmt(&tf->tp,
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 5803e6a41570..96792bc4b092 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -36,7 +36,6 @@
 #define MAX_BTF_ARGS_LEN	128
 #define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
-#define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -481,6 +480,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
 	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
+	C(BAD_TP_NAME,		"Invalid character in tracepoint name"),\
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\
@@ -544,7 +544,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NO_BTF_FIELD,		"This field is not found."),	\
 	C(BAD_BTF_TID,		"Failed to get BTF type info."),\
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
-	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),
+	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
+	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

