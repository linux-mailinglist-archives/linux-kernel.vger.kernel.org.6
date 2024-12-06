Return-Path: <linux-kernel+bounces-435609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B69E7A16
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E409C1881995
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457EC1FFC7C;
	Fri,  6 Dec 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPQa01H8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945A1DA31D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517440; cv=none; b=pLm0g1HPiryOpiZqUA38qifMIaDqcMZPonIqo10uZcbJoV3JrLu572Se5ECUsx/y6zEEJJ/y9p4N5fJWUBPHFZb3JdVgGvuBbhlG3ebuuqZANCp8tnb3q1eWrTZ3cVmjU0/FfbNDB4TJqsiZyOUt4yttCpj4epwPRf462Acevqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517440; c=relaxed/simple;
	bh=I8QH9yYP8JFwTKjCJAr/bedB4BBTOAmbOlClo2ps5zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gz5xjD0XnbNNA9HSj0K3/UEFq2M2Lge7dX8aRzVqRrTQZQFnhnj+LwseWYFY3yC1GdLbJQkfIoEzUsjE6KWmUaRAVE42w4QktwSw/Y/PAkGtzmPx6XtUDNQ/dAcJOeSxb17OIjtjde/PrvesdfnhrVZzEBO/vt9g9k7qJKN1tlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FPQa01H8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434e5e71a08so9755e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733517436; x=1734122236; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEYwwDGCTP7P7yGnkaQ5Z1LyGhjk0N+7h2F/y5Qegaw=;
        b=FPQa01H8OHPwePNjHuEboEhEbv4ruc050ykX2v8YnmSvk5fW4ZDHN+ijBiwu530ZCf
         w9uyO9IlMZrLaWcUWoX4MeM+UxbXXMJqr4euu4tUzI9ioTGrO6UhtX4zm7ldfW/dtpzq
         6y50HtnAOIfzBPfqoEHFbXxb7g6PbETGo2jaZb+ybswKny5M0fIGwJ1L48BRGeYSPQ1l
         NvtIQGDqM2gkwUOFnxhTwM6h7VveqVaYsi7zK+OJjm4mTsslJyPLDJQ7u5fq0VkxH/M+
         w631IJEq35ISpz+QkHfR9hfOeVVjYx2JvPjLbdKWzvrFIz8isxU+oG9/PF84QmeHUKfv
         olKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517436; x=1734122236;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEYwwDGCTP7P7yGnkaQ5Z1LyGhjk0N+7h2F/y5Qegaw=;
        b=ekeXoOgV6IvCsj7hOFxFHLjhypDikj5Ev3VAYVFyEBPAz627tx+sKEY78139AtrHa6
         4oZY+OMg2JeddvE7IWDIY7Imy9HswIt6FkEBgpXMEn4N/fEry+4Uj3pMrpCXAFxNIW/h
         s/URS1+VikI+AK1iIOg9X+f6CFLo96YtlMz+A9FGVMIKMa1FJ7/AP8a7RZnIslgCCQq5
         2LDnBDgSf9NUtZdetJYGkaV6RiofO6uVEO8Ig3X5X16v0D0jAdfQMcoshATxA4Ywzce1
         5/PtBSi4zR3Tzgl99PUfvzddfj8XxrMfEZwG/TDtS2riFlKFE4SMeDUGufiRI43DEFZC
         iNww==
X-Forwarded-Encrypted: i=1; AJvYcCVp/jEiIkdnGlFYQL2sjlsj1Wx32Wea8JEi166htfCoEXEW+/B+jKQbsYBkSr2/Ux/oEAdzNUvlZXo5vMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZI6ADcn2Ms+ESMxH1SCHSecID1i83UHUSjsDxBj3wEgCAzZ1k
	MBe+/bUBB7t2GeZxdPTeFZd9iaP/VGzEwZZ6NkYAdsDrQXV6odOe9V8pcYwQdA==
X-Gm-Gg: ASbGncsIk2C3DMpBTaRMWa941MHCXV5E0tHmvJ5yD5SUeuTcoFkkJUAF9YVKxId7zY+
	yjruTfQYqUHbSYj32bvzwlZAJBUysoVx4kLw1ZuPG7qR3JUfPYSXQhCFrRHeXVa94FKjcR+QC2Q
	mzCNbnxZRSp5jpJ3d5Vvzc8HdNSkxFJLnYQ/iYnZCAAO8tOBuNUKaCB/fUiCAXJp6XH7/4vD8WX
	vZTlKle6x5dGH0RkjTw7SrC+v/7hJI78YiS/8o=
X-Google-Smtp-Source: AGHT+IEyLEFRclI3pX1kv8//WWxlldusvhF+y5ETQFdRD1G0Bahr4xzoR/JRq0Rin2Hu5ZO57k//6w==
X-Received: by 2002:a05:600c:584b:b0:434:c967:e4b5 with SMTP id 5b1f17b1804b1-434e83df45cmr159425e9.1.1733517435663;
        Fri, 06 Dec 2024 12:37:15 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:a1dd:6aeb:389c:7fd7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm68044935e9.29.2024.12.06.12.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:37:15 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Fri, 06 Dec 2024 21:37:03 +0100
Subject: [PATCH bpf] bpf: Fix prog_array UAF in __uprobe_perf_func()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-bpf-fix-uprobe-uaf-v1-1-6869c8a17258@google.com>
X-B4-Tracking: v=1; b=H4sIAG5gU2cC/x2MywqAIBAAfyX23ILZg+pXooPmWnsxUYpA+veWj
 gMzUyBTYsowVwUS3Zz5DAJNXcF2mLATshMGrXTXaDWgjR49P3jFdFrCy3jsWzfp0RrbOgUSxkR
 i/NMFxIf1fT/C+iYdaQAAAA==
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
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733517431; l=4088;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=I8QH9yYP8JFwTKjCJAr/bedB4BBTOAmbOlClo2ps5zc=;
 b=ZuTXS1DTUtz9mwoP4jNWFIU2COR0aiA3HNcppch70BVqp7JPyDymwr8qZ82Qsf93jBM00n2VV
 xYabNIwirl+Bjfjh+gZiz1qDfsWSixzTsMnVf/p0fpHYxxcAVSaIGJi
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Currently, the pointer stored in call->prog_array is loaded in
__uprobe_perf_func(), with no RCU annotation and no RCU protection, so the
loaded pointer can immediately be dangling. Later,
bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical section,
but this is too late. It then uses rcu_dereference_check(), but this use of
rcu_dereference_check() does not actually dereference anything.

It looks like the intention was to pass a pointer to the member
call->prog_array into bpf_prog_run_array_uprobe() and actually dereference
the pointer in there. Fix the issue by actually doing that.

Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
To reproduce, patch include/linux/bpf.h like this:
```
@@ -30,6 +30,7 @@
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
+#include <linux/delay.h>

 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -2203,6 +2204,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
        struct bpf_trace_run_ctx run_ctx;
        u32 ret = 1;

+       mdelay(10000);
        might_fault();

        rcu_read_lock_trace();
```

Build this userspace program:

```
$ cat dummy.c
#include <stdio.h>
int main(void) {
  printf("hello world\n");
}
$ gcc -o dummy dummy.c
```

Then build this BPF program and load it (change the path to point to
the "dummy" binary you built):

```
$ cat bpf-uprobe-kern.c
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
char _license[] SEC("license") = "GPL";

SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
int BPF_UPROBE(main_uprobe) {
  bpf_printk("main uprobe triggered\n");
  return 0;
}
$ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe-kern.c
$ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test autoattach
```

Then run ./dummy in one terminal, and after launching it, run
`sudo umount uprobe-test` in another terminal. Once the 10-second
mdelay() is over, a use-after-free should occur, which may or may
not crash your kernel at the `prog->sleepable` check in
bpf_prog_run_array_uprobe() depending on your luck.
---
 include/linux/bpf.h         | 4 ++--
 kernel/trace/trace_uprobe.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eaee2a819f4c150a34a7b1075584711609682e4c..00b3c5b197df75a0386233b9885b480b2ce72f5f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2193,7 +2193,7 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
  * rcu-protected dynamically sized maps.
  */
 static __always_inline u32
-bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
+bpf_prog_run_array_uprobe(struct bpf_prog_array __rcu **array_rcu,
 			  const void *ctx, bpf_prog_run_fn run_prog)
 {
 	const struct bpf_prog_array_item *item;
@@ -2210,7 +2210,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
 
 	run_ctx.is_uprobe = true;
 
-	array = rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
+	array = rcu_dereference_check(*array_rcu, rcu_read_lock_trace_held());
 	if (unlikely(!array))
 		goto out;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fed382b7881b82ee3c334ea77860cce77581a74d..c4eef1eb5ddb3c65205aa9d64af1c72d62fab87f 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1404,7 +1404,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 	if (bpf_prog_array_valid(call)) {
 		u32 ret;
 
-		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
+		ret = bpf_prog_run_array_uprobe(&call->prog_array, regs, bpf_prog_run);
 		if (!ret)
 			return;
 	}

---
base-commit: 509df676c2d79c985ec2eaa3e3a3bbe557645861
change-id: 20241206-bpf-fix-uprobe-uaf-53d928bab3d0

-- 
Jann Horn <jannh@google.com>


