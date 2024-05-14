Return-Path: <linux-kernel+bounces-178923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B98C597D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F7E1F25044
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611817F393;
	Tue, 14 May 2024 16:14:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2017F36E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703297; cv=none; b=VoCMvpel+FxKkNLdWFCq96g69J8L9Vf2a/eWz2dvs9EAqmhJRpFKqBJn5AWA19k8y8TDBXB5Fd+v0e2jqOqX2QT5CoqyqFxwcayorlHWyODh2mPwb6a5DO42AOvzZ1Drkq6RnmGqGXxuFuOdFDASjg/Txj9O8+RcFH8Dp5lL79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703297; c=relaxed/simple;
	bh=M6MsMV5J5GzTPhVhLI1xj0aFtUUxHtQr9dMoTAAiMWY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ajI6tarfZFRK71v+3jM2mVYNWUnfOka9vnIjxBNFfSCSsRiASDem2T4RMJXqdO57nuIWNaTxdTSn8J+Sd0VN4FRMqEaqzDO/t4RRTeG/9WTgvAPLNmMaA+Qz83swjc9JaSNOflsjRUeXt04kkZfD61phCzpCpsDdnvxM/Dk3UGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C03C32786;
	Tue, 14 May 2024 16:14:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uoE-00000003t30-0ZYR;
	Tue, 14 May 2024 12:15:22 -0400
Message-ID: <20240514161521.998066230@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:14:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yuran Pereira <yuran.pereira@hotmail.com>
Subject: [for-next][PATCH 1/7] ftrace: Replaces simple_strtoul in ftrace
References: <20240514161438.134250861@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Yuran Pereira <yuran.pereira@hotmail.com>

The function simple_strtoul performs no error checking in scenarios
where the input value overflows the intended output variable.
This results in this function successfully returning, even when the
output does not match the input string (aka the function returns
successfully even when the result is wrong).

Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
simple_strtoul(), and simple_strtoull() functions explicitly ignore
overflows, which may lead to unexpected results in callers."
Hence, the use of those functions is discouraged.

This patch replaces all uses of the simple_strtoul with the safer
alternatives kstrtoul and kstruint.

Callers affected:
- add_rec_by_index
- set_graph_max_depth_function

Side effects of this patch:
- Since `fgraph_max_depth` is an `unsigned int`, this patch uses
  kstrtouint instead of kstrtoul to avoid any compiler warnings
  that could originate from calling the latter.
- This patch ensures that the callers of kstrtou* return accordingly
  when kstrtoul and kstruint fail for some reason.
  In this case, both callers this patch is addressing return 0 on error.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Link: https://lore.kernel.org/linux-trace-kernel/GV1PR10MB656333529A8D7B8AFB28D238E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..3951c0d0ec63 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4202,12 +4202,12 @@ static int
 add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
 		 int clear_filter)
 {
-	long index = simple_strtoul(func_g->search, NULL, 0);
+	long index;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 
 	/* The index starts at 1 */
-	if (--index < 0)
+	if (kstrtoul(func_g->search, 0, &index) || --index < 0)
 		return 0;
 
 	do_for_each_ftrace_rec(pg, rec) {
@@ -5817,9 +5817,8 @@ __setup("ftrace_graph_notrace=", set_graph_notrace_function);
 
 static int __init set_graph_max_depth_function(char *str)
 {
-	if (!str)
+	if (!str || kstrtouint(str, 0, &fgraph_max_depth))
 		return 0;
-	fgraph_max_depth = simple_strtoul(str, NULL, 0);
 	return 1;
 }
 __setup("ftrace_graph_max_depth=", set_graph_max_depth_function);
-- 
2.43.0



