Return-Path: <linux-kernel+bounces-551853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B59A57221
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70837A6402
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86212561A3;
	Fri,  7 Mar 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a9wA8ZU2"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923F24FC03
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376301; cv=none; b=Q1X3MMPYF0vfK1pspwKemrIJdAYfEoVunn3cruELnU/BMzRJ5VN8Ir61D5tk6IcUm76ACAtnjDKB8/x7O07oTaXHYND7UuPcre/rBeI1Fnka2airfygNILiBbJocOvF7AyYehu8vT8yXT0/H4k/TIQ53nJ9vO32+81urOJt0csU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376301; c=relaxed/simple;
	bh=PT0MFRFyLD4Nrt+AWvY1iqPo5Fb8gsgbfH3i68RevHU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dPcU6eo6E1FIXNFQqVHQT04Vso9nns/P/z4ivTtp/wOlnE+sN8RZgERd1OxTVVuwbYM6XPO/s2dbkp2/rsRoBFPYF1QDwWM6EM+KCWnUP++yNhV6GqMY+mEEjz1SWuiiPULU9I/GtzEj0XusQ59fADxzocrlSpnW/D0VUbejXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a9wA8ZU2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=e+B1evRM8nlK/KgEVRn/y53WuRUX9fT+vNoNZwtwPyU=; b=a9wA8ZU2VGoCYhyHcc/wTRC6/K
	PCVBAB5n07aO+SeVX3m4T4NNJggw0ZcbM1N4otu8QWf2gmqEUWaVO5Qg3yBUl/SlBCcusBjxSnGa6
	wj2lGStspaZkjUH+zSIKxM/v8fbBMnqrcsrezTLe9yhMdUVniRU3EhBh7FbT2FVjFAg6EK5GVFvF0
	XtZnPGlPMA7a9hL/sABpafuac77reWKqAuE90Ex2r5evd2nuZ8t0vnDbk6zbgE2Al0z8ULPAZCS//
	oa8KdEOjCVs+T8I0xBcXW+g4MsGs6dINnAFSXgUgnjh8t+UEIDyWzbvpiETB0AEhA4QrZd1CylKei
	yjE96wSg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tqdWP-00000001PmJ-2myb;
	Fri, 07 Mar 2025 19:38:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 099BF3006C0; Fri,  7 Mar 2025 20:38:13 +0100 (CET)
Message-ID: <20250307193722.827444714@infradead.org>
User-Agent: quilt/0.66
Date: Fri, 07 Mar 2025 20:33:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 ravi.bangoria@amd.com,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH v3 1/7] perf: Ensure bpf_perf_link path is properly serialized
References: <20250307193305.486326750@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Ravi reported that the bpf_perf_link_attach() usage of
perf_event_set_bpf_prog() is not serialized by ctx->mutex, unlike the
PERF_EVENT_IOC_SET_BPF case.

Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6087,6 +6087,9 @@ static int perf_event_set_output(struct
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
+static int __perf_event_set_bpf_prog(struct perf_event *event,
+				     struct bpf_prog *prog,
+				     u64 bpf_cookie);
 
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
@@ -6149,7 +6152,7 @@ static long _perf_ioctl(struct perf_even
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 
-		err = perf_event_set_bpf_prog(event, prog, 0);
+		err = __perf_event_set_bpf_prog(event, prog, 0);
 		if (err) {
 			bpf_prog_put(prog);
 			return err;
@@ -10875,8 +10878,9 @@ static inline bool perf_event_is_tracing
 	return false;
 }
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
-			    u64 bpf_cookie)
+static int __perf_event_set_bpf_prog(struct perf_event *event,
+				     struct bpf_prog *prog,
+				     u64 bpf_cookie)
 {
 	bool is_kprobe, is_uprobe, is_tracepoint, is_syscall_tp;
 
@@ -10914,6 +10918,20 @@ int perf_event_set_bpf_prog(struct perf_
 	return perf_event_attach_bpf_prog(event, prog, bpf_cookie);
 }
 
+int perf_event_set_bpf_prog(struct perf_event *event,
+			    struct bpf_prog *prog,
+			    u64 bpf_cookie)
+{
+	struct perf_event_context *ctx;
+	int ret;
+
+	ctx = perf_event_ctx_lock(event);
+	ret = __perf_event_set_bpf_prog(event, prog, bpf_cookie);
+	perf_event_ctx_unlock(event, ctx);
+
+	return ret;
+}
+
 void perf_event_free_bpf_prog(struct perf_event *event)
 {
 	if (!event->prog)
@@ -10936,7 +10954,15 @@ static void perf_event_free_filter(struc
 {
 }
 
-int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
+static int __perf_event_set_bpf_prog(struct perf_event *event,
+				     struct bpf_prog *prog,
+				     u64 bpf_cookie)
+{
+	return -ENOENT;
+}
+
+int perf_event_set_bpf_prog(struct perf_event *event,
+			    struct bpf_prog *prog,
 			    u64 bpf_cookie)
 {
 	return -ENOENT;



