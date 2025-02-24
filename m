Return-Path: <linux-kernel+bounces-529627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C36A42901
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F77917FB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FAA266B58;
	Mon, 24 Feb 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VRQ7d5UD"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A81266B55
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416413; cv=none; b=LSObtbaO1ImCFHEesG2dJhQRe3A64h2YnMmQrhFkXcycHPd+L7gw+mHQVDdSaYKbml833yhgsIMfo7eJO5SwoCl/JILh8zvv+yHzBBCpidEJ8NIHpWk62WaWorD2tlICEYj4o0YpGXVK3VNP5KytqliujmDNyZZ8rIr0KZr5uDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416413; c=relaxed/simple;
	bh=jm9V/uGdHxg5OBS/aN+olvdgGrxxL3p39+/oZgyyRrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oD5KLDNqnZhrln8epXifyOa8ZHfkioBgJ0Uokll5hfK74H3J4JOVbuAzfiVYIVIVG4VIZdNoOV0kcT5FPcc4kNTk5r0Jcn269t6uGaa2Azrbl9h+blmQgOzNuhIfiROxf4oLU78n5v3+22KyhU9emLqlgCqtQDK/Z+31DhC7toM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VRQ7d5UD; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740416399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXImHF+AatB2zWehHEZzkP3DgCbk67G0CTnxuxdEVxE=;
	b=VRQ7d5UDZQ1lPbaD4QY3raHMG/CkJGI/nZfTYxApXF6OrKHQmK48OXXrKmvPgzvdYXI1p4
	Y8+Q7CoALwE6/jjdTZzmW+QWELQVwm0QjdIJlgFTjRqaXIxo9c5EmE2ubWNA1pl/HGOmpR
	KcwJSvVpL3KJkZJ+HVK9i5AvoqMmKDg=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com,
	Tao Chen <chen.dylane@linux.dev>,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v8 1/5] libbpf: Extract prog load type check from libbpf_probe_bpf_helper
Date: Tue, 25 Feb 2025 00:59:08 +0800
Message-Id: <20250224165912.599068-2-chen.dylane@linux.dev>
In-Reply-To: <20250224165912.599068-1-chen.dylane@linux.dev>
References: <20250224165912.599068-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extract prog load type check part from libbpf_probe_bpf_helper
suggested by Andrii, which will be used in both
libbpf_probe_bpf_{helper, kfunc}.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/lib/bpf/libbpf_probes.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..a48a557314f6 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -413,6 +413,23 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	return libbpf_err(ret);
 }
 
+static bool can_probe_prog_type(enum bpf_prog_type prog_type)
+{
+	/* we can't successfully load all prog types to check for BPF helper
+	 * and kfunc support.
+	 */
+	switch (prog_type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return false;
+	default:
+		break;
+	}
+	return true;
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
@@ -427,18 +444,8 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	/* we can't successfully load all prog types to check for BPF helper
-	 * support, so bail out with -EOPNOTSUPP error
-	 */
-	switch (prog_type) {
-	case BPF_PROG_TYPE_TRACING:
-	case BPF_PROG_TYPE_EXT:
-	case BPF_PROG_TYPE_LSM:
-	case BPF_PROG_TYPE_STRUCT_OPS:
-		return -EOPNOTSUPP;
-	default:
-		break;
-	}
+	if (!can_probe_prog_type(prog_type))
+		return libbpf_err(-EOPNOTSUPP);
 
 	buf[0] = '\0';
 	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
-- 
2.43.0


