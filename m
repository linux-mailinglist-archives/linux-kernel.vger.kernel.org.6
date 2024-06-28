Return-Path: <linux-kernel+bounces-233263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AC291B4EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3059283736
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835D2262B;
	Fri, 28 Jun 2024 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjNU8hNj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4B1DFFB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540623; cv=none; b=A4gZLf9E7IZNWagIECSTua+dhMgrBBdOdRj9ItEkVnJBTbwYh5mffxMfJbReO6Yq1OxcQYFQXjofElgc3zlWL7u3WlQZ0/SebImm+rV3GqsyDlkinKnHRsElsf6kMxcUW7RwpdhkL30ptRDKaabCoKCyHNDWMjpNgqmCUFB5j4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540623; c=relaxed/simple;
	bh=WENDZcP8N/LxqpPFeFbXSpD17nZKdUoSCPD3rZP7z/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KWRgKlVIvJcFNuTamaezFtswx8RoOZh7F04Q2K0HU8tx+HyZE2pBYmh5wIM3Ny55J4lSJv2Wp5XTpy1bcgDGJEBefOOyFgQoLCeNT9RLCHG6gTJcUMFlIvwwtUi1Llj/UV/aJSFes8rnRcundbie8gFXw7IRW4cmIRNsWyG3yR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjNU8hNj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso209172276.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719540621; x=1720145421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+q5Yudne0apm40w9a/NrughomiVS9st32ZmfN+LWk8=;
        b=vjNU8hNjRTIwBKueXomX94VOHx4bjgLlIvCCksTjU3bVDxvmSRQ8qQ7gzMorhv+RtP
         ZETTW1ShQbRmh+m1UY+qA5KPEaBn2Oqc+Nw3B4wVOF6wgs9U6P+LbQPOYIcsi3I8trui
         8v78Yvv957SN6F65+/UM0K6OELJAdK1pFOD/rbhGVOHVDhs3WU3iFTskNnn6/d+5R5oQ
         RmZWpXF5124ie9T6fUftfUkWBw+XNjc0lQqc3xzewXsPyf63uZI5vkj7HTYmAm5s+1H5
         HGH6E75feblxasGbq9JAwW4Ia64IplknPk+7Mlqjxb8RnISf4wz5Uf14lRU46gx16dtU
         HNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719540621; x=1720145421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+q5Yudne0apm40w9a/NrughomiVS9st32ZmfN+LWk8=;
        b=RCZzG4gRxha5nGDHbz+i54kKlRGBRCtn5LA6r0WkIN3MecWVg7yYi+Q24eoQkeopf3
         rbKhIQG0psHqzN/fLlPu7Tp2rLdsQMO7EZKTA41w+CLlxkLonf0k0TZsptlC2e0pWsyq
         cGjvHuUEG3nERd6mJswgXQT2I4Ek4ZHjzHiliJDrjzQAV/rEks0rLCID3wEpjp2aW3nB
         gvKkV2jxCUO4lkMxXMACrLViqaKS+2SZ21r0xQG1AsIUZ9Qz2dvuBHbGbqk5+YCm0qYB
         modHx3znCmsEYR3N7khmVnFkge63Yi8qe8rqNAxB9Wavb9xp2D3EDoi35lCdYVyvb/2j
         xXSg==
X-Gm-Message-State: AOJu0YyJCjwprqjEeV0s5kAUtqDzzddDZgrQvFBn7aXdJ6PGhQ8uDNcq
	2H7FKstR9j+LCg7cLQWExQlYaJjayB1ES4vEUIOa0SSckRlFtnkQYDn1VTrV3IM5yDB51nIPThr
	XUA==
X-Google-Smtp-Source: AGHT+IFeZp+OKnBr03iY/sVg8Bm8WE9n5a0TRPt0/ahgfiqmGEwYv7yfgX7jncSzfInGJlJsU77XXD1DtRI=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a05:6902:120d:b0:dfb:fb2:ebd with SMTP id
 3f1490d57ef6-e0303fdc528mr43728276.8.1719540621021; Thu, 27 Jun 2024 19:10:21
 -0700 (PDT)
Date: Fri, 28 Jun 2024 02:10:14 +0000
In-Reply-To: <20240628021014.231976-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628021014.231976-1-avagin@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628021014.231976-5-avagin@google.com>
Subject: [PATCH 4/4] selftests/seccomp: check that a zombie leader doesn't
 affect others
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that a dead thread leader doesn't prevent installing new filters
with SECCOMP_FILTER_FLAG_TSYNC from other threads.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 390781d7c951..e3f97f90d8db 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4809,6 +4809,83 @@ TEST(user_notification_wait_killable_fatal)
 	EXPECT_EQ(SIGTERM, WTERMSIG(status));
 }
 
+struct tsync_vs_thread_leader_args {
+	pthread_t leader;
+};
+
+static void *tsync_vs_dead_thread_leader_sibling(void *_args)
+{
+	struct sock_filter allow_filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog allow_prog = {
+		.len = (unsigned short)ARRAY_SIZE(allow_filter),
+		.filter = allow_filter,
+	};
+	struct tsync_vs_thread_leader_args *args = _args;
+	void *retval;
+	long ret;
+
+	ret = pthread_join(args->leader, &retval);
+	if (ret)
+		exit(1);
+	if (retval != _args)
+		exit(2);
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_TSYNC, &allow_prog);
+	if (ret)
+		exit(3);
+
+	exit(0);
+}
+
+/*
+ * Ensure that a dead thread leader doesn't prevent installing new filters with
+ * SECCOMP_FILTER_FLAG_TSYNC from other threads.
+ */
+TEST(tsync_vs_dead_thread_leader)
+{
+	int status;
+	pid_t pid;
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct sock_filter allow_filter[] = {
+			BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+		};
+		struct sock_fprog allow_prog = {
+			.len = (unsigned short)ARRAY_SIZE(allow_filter),
+			.filter = allow_filter,
+		};
+		struct  tsync_vs_thread_leader_args *args;
+		pthread_t sibling;
+
+		args = malloc(sizeof(*args));
+		ASSERT_NE(NULL, args);
+		args->leader = pthread_self();
+
+		ret = pthread_create(&sibling, NULL,
+				     tsync_vs_dead_thread_leader_sibling, args);
+		ASSERT_EQ(0, ret);
+
+		/* Install a new filter just to the leader thread. */
+		ret = seccomp(SECCOMP_SET_MODE_FILTER, 0, &allow_prog);
+		ASSERT_EQ(0, ret);
+		pthread_exit(args);
+		exit(1);
+	}
+
+	EXPECT_EQ(pid, waitpid(pid, &status, 0));
+	EXPECT_EQ(0, status);
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.45.2.803.g4e1b14247a-goog


