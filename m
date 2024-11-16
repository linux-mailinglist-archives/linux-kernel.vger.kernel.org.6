Return-Path: <linux-kernel+bounces-411799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216F79CFFBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5C11F23C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B16197521;
	Sat, 16 Nov 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er/M/OWY"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944C193091
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772932; cv=none; b=enSio9E+w0BQFqdG+8IYgJugcJeCMQ9awFQZ1JcrmN0ZUmYMLHQr5YMjQWfhBqwv4r68r/6GevQLrK6n2L69hXyvZLETTvq36cOz0AfhAQTLX30kvtBjwdGANVyVNDB/40Eh+X1R3/R07Hya68ZuwYKxoP6UGCf7vqhCWwp/XD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772932; c=relaxed/simple;
	bh=o0YDEjtcd9S385MR9NmR2UtjFN+yk2/00o7+024uHmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoN/a960HJgOYzIflQvdFzxgeTxCIJiVYI33mwL168et6i1aKxWBeDCQPRtEOEPyAHlJlX80A0jYQyndEypCL5MD88wy1mvBjgjXRjpj3BEeP1+bH/iZRQQmpxXGFXzcJoEbXaX6A+RFpGADJPYl5yv1TF4sJbG0JSjmhLMVGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er/M/OWY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72487ebd2f5so429049b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731772930; x=1732377730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7JCDTTn3vTxFGmkfNj8ZEUqCT3sK0X8BFkqLAI6rAs=;
        b=er/M/OWY7f4sTZMZClRH5p7RUR4cUHLG7NNPckI9x+pjU5npKRciRV4ywH8Wdd9hrQ
         Zeri3tnQBG5rZgneNzUl4qw6lU7LKrgN4tJ+SS2ZZX8dsbyGKHaKF1e2tRXKTlQCV7f1
         IuCsw90egnDvlZ3gj06mmNBtHiJHiCG6LN10RSFL0vzpSd1m9YT9mcWbVRFRorBA2VWq
         Ws43wGRquQeercRGB2/490Y0G0s/GznqaT8iOLHGY9DKCpPgReMQVbIxiymYOHKVYGLK
         9mwlqmLhrWQeBUJooUHVNSAOXZ4nvmm6Y4N3380GpntiFte6UutIAr/BrfQMTfvohPAT
         1rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731772930; x=1732377730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7JCDTTn3vTxFGmkfNj8ZEUqCT3sK0X8BFkqLAI6rAs=;
        b=U3yRLFYh1zhLHfWik3gNOZ5UXQKVhuXOGHvs980h8L41aa9Msq+DkLqMCqWHfApLVb
         F9q2z+6lOc+zL1Nbc7gjLWB+UwtztcmizU9/XNrcv25ai4pckDVlcKdRwZ9ZA6qyiJ6W
         HTngrsi+OS/e4Qt94nxiZxYUgAiyCURAQaHiWFlH6py+l8TksAyX91p4AYD3RoVRajjR
         97imsLyIsBib8b9XOngQAJu3ise/GcbwijWx9p98yfobNJLWk1z39q299ztotupBFASS
         pyur0m8HfSxcYcNE2mcIp5nggiGim5PcBgtCh9yONYfPkEuhMpWB69iAd3T1nIKlude7
         OKlg==
X-Forwarded-Encrypted: i=1; AJvYcCWSLFxS7RQwNK/bgj5iBJaAx2iWvm6lz8Vd2Xj5sYObRS6+rm2fZ+7qhmC6rQjLcpP7l8eFR6FgJUktJv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCNhT16dYpah1NgMDJ6RRVzs0d9LS/g9T2AI5C/8AOn1+PYUN
	E8srUTdq5GNAG7lgspWtMSI+LXcW9XdFNuJ485ei7T/bsyN24Gly
X-Google-Smtp-Source: AGHT+IEW3D+oOgg5ZmZqLrrYpAwHIzZ8WlZUJzEYdgoDk0OpEirTug6cOUYYnD5X4SsV8VqrXGnRhA==
X-Received: by 2002:a05:6a00:10ce:b0:71e:3b8f:92e with SMTP id d2e1a72fcca58-72476b72b2bmr9148583b3a.3.1731772930052;
        Sat, 16 Nov 2024 08:02:10 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711de6fsm3291344b3a.61.2024.11.16.08.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 08:02:09 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] sched_ext: Add scx_bpf_clock_get_ns() for BPF scheduler
Date: Sun, 17 Nov 2024 01:01:25 +0900
Message-ID: <20241116160126.29454-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116160126.29454-1-changwoo@igalia.com>
References: <20241116160126.29454-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_clock_get_ns() is added to the header files so the BPF
scheduler can use it.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 1 +
 tools/sched_ext/include/scx/compat.bpf.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 2f36b7b6418d..230c7f2e8ad6 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -72,6 +72,7 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
+u64 scx_bpf_clock_get_ns(void) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index d56520100a26..d295c59e3f05 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -125,6 +125,11 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	false;									\
 })
 
+#define scx_bpf_clock_get_ns()							\
+	(bpf_ksym_exists(scx_bpf_clock_get_ns) ?				\
+	 scx_bpf_clock_get_ns() :						\
+	 bpf_ktime_get_ns())
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.47.0


