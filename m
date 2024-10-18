Return-Path: <linux-kernel+bounces-372430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F49A485E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4F11C22226
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13081210C0C;
	Fri, 18 Oct 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwMYJZfh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E220CCCF;
	Fri, 18 Oct 2024 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284190; cv=none; b=Shg3fM1CLI6cncwf9ZIr5esMr8B+I/zBqx9CZgbEpuhN20c4aJY2PAzvM94k6MNC5LCJKidM2+HOramI1iP/d+ps02d/OzWgrb2vT3Y9vxqnBypNIc9d93Da1r62bOFBF45OAy4apU8u02S8/U8aBiQD9Qdig2Rvg8vsZwjQ6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284190; c=relaxed/simple;
	bh=vWoH7hbVui+QQQvKzVGIAPGWJG2xt/YhgttiE1WizNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOOif1VS27bWn0w5jxQumpd4HS0Dt92yKoBKcZwzvAsCZLtyOw1gnP8hGh1RUjfS3OI1WVOsQwIpptmkq2QbW+cYkUfU+a8R75mPKdP6WWiJtU2F0aqonM6MDYaF3sVL/PbOtLjsUzWKlcgke5QLpay3SSymA1qz0SdQXjMbVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwMYJZfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8092AC4CEC3;
	Fri, 18 Oct 2024 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729284190;
	bh=vWoH7hbVui+QQQvKzVGIAPGWJG2xt/YhgttiE1WizNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OwMYJZfhC3ujrslVfOGOLK0XJ/5NJx7DbBQuD0emP34DfrUdxR9CryGnD7i9+rZe5
	 pdh+9RN9riOkSBseaTlDCmrnbOcSgRGoQJ9lN/VG7k7SDTk/kw88b0UB4mb5564NOU
	 g5+8VWIm1GvSgsrZ3OzssOJkrZzkYMH5yxCsLGHKNJvwajugM4r6fxXTXz3tcG4Nu/
	 vOoqiRP3vMO9Vl9ircH0fN5t1/+xoWfoBhgYMraRn/8KT2XqUimcz6ffw0UFg9cT9M
	 SiAym6L4DWQy2AJH/L+9CPtTZvNMQDlZzC6j4kn8IKviqKtZ9y3ds2qAtAJ77p9/QF
	 RWrsbuiAoyYnA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv8 bpf-next 09/13] selftests/bpf: Add uprobe session verifier test for return value
Date: Fri, 18 Oct 2024 22:41:05 +0200
Message-ID: <20241018204109.713820-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018204109.713820-1-jolsa@kernel.org>
References: <20241018204109.713820-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making sure uprobe.session program can return only [0,1] values.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        |  2 ++
 .../bpf/progs/uprobe_multi_verifier.c         | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 284cd7fce576..e693eeb1a5a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -11,6 +11,7 @@
 #include "uprobe_multi_session.skel.h"
 #include "uprobe_multi_session_cookie.skel.h"
 #include "uprobe_multi_session_recursive.skel.h"
+#include "uprobe_multi_verifier.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -1246,4 +1247,5 @@ void test_uprobe_multi_test(void)
 		test_session_cookie_skel_api();
 	if (test__start_subtest("session_cookie_recursive"))
 		test_session_recursive_skel_api();
+	RUN_TESTS(uprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c b/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
new file mode 100644
index 000000000000..fe49f2cb5360
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/usdt.bpf.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+
+SEC("uprobe.session")
+__success
+int uprobe_sesison_return_0(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("uprobe.session")
+__success
+int uprobe_sesison_return_1(struct pt_regs *ctx)
+{
+	return 1;
+}
+
+SEC("uprobe.session")
+__failure
+__msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int uprobe_sesison_return_2(struct pt_regs *ctx)
+{
+	return 2;
+}
-- 
2.46.2


