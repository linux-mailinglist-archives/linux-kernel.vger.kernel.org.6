Return-Path: <linux-kernel+bounces-422383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA459D98EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E5C165EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247B1D54D8;
	Tue, 26 Nov 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNvB5qGx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3A1D47BB;
	Tue, 26 Nov 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629386; cv=none; b=a2spxdRWSmtygSicKqc3CU3yeviSZXMEitrIWjTEK26P/fSENCoX2eN7lr7oj5LSGiDyB5gJ2QLHf5oFa4SZLYASibiavTuVw/rFyFVsV/Na7ScOYCX7vpET5wgr4yAOp2YJF+5TGoCdwErARpQysDUWhdk9CBjK8ea+reX96oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629386; c=relaxed/simple;
	bh=OUbH2yDyiXtr4xG2OF1k8+O5wk66wGWYCe1qQImrZI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czJuIJAxxw0ghDF6MAeIRe2OQTBn+mPPkJfr0G5iktx+CPK2ag0/P3STJ+ouU2k3mMbRwAsY2ZreyvumXaGt3E3mpib/hmMFrTIdtPfmUqTDJVMYmHcBMcol9IuQ7240jemWQ01pVCUPLTzLSujOZiel3Ggd+WlVdD6Q/2l4UWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNvB5qGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F39C4CECF;
	Tue, 26 Nov 2024 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732629385;
	bh=OUbH2yDyiXtr4xG2OF1k8+O5wk66wGWYCe1qQImrZI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNvB5qGxkMNMPpgENn88EzW6wKqBuxVfktpw+UlSL1DN8fj01aEQ+omj2wgmzAMcA
	 FrbmVYaxHyrODODktD1rPV/Loyg5qGu4lCeLYVx4Gj91zDdZhEi/k/g+lx/fLnZogy
	 RsdwsOK4iR8tEoBMmqrVDWrZ15q3EFA1CSMokXo/Wmj5MWqVY8Zhb2KHZGBKo4dLt0
	 fNRyApydx7+C3Bp6/4HQFrfvm1nrQMb7Q5bFni7mGgUTc4zSBf3ArP0NtZb38GlXDs
	 URiNfliX/vc+4tZ2NxaV4lIWnxYhCZw+rgtnwfcjVWoxQn4NTdzkQAWnxu6ESyNp8w
	 fdMySC9BXeHLA==
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
Subject: [PATCH 1/6] tracing/eprobe: Fix to release eprobe when failed to add dyn_event
Date: Tue, 26 Nov 2024 22:56:20 +0900
Message-ID: <173262938070.8323.5243664675318084969.stgit@devnote2>
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

Fix eprobe event to unregister event call and release eprobe when it fails
to add dynamic event correctly.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index ebda68ee9abf..be8be0c1aaf0 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -963,6 +963,11 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		goto error;
 	}
 	ret = dyn_event_add(&ep->devent, &ep->tp.event->call);
+	if (ret < 0) {
+		trace_probe_unregister_event_call(&ep->tp);
+		mutex_unlock(&event_mutex);
+		goto error;
+	}
 	mutex_unlock(&event_mutex);
 	return ret;
 parse_error:


