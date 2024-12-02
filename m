Return-Path: <linux-kernel+bounces-426912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 777769DF9FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E087DB21F68
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48341F8EE0;
	Mon,  2 Dec 2024 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ8rRxLR"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301D1F8F04
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114360; cv=none; b=NOKamCCo+qkvLSUw449nYRZiWLPrbPFmZosUz1Z0njp2a4edBcKQyRS7l9KqIcQuhScnxltzf8mxEffsYm+jdt9J6t31oTZFO70wNWrpbD9YNCoobLKNd4v8Mhs4lbocjLvoPqalYxdETboUs1ZuQxXIdmsZiHlsZxpeIJTXehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114360; c=relaxed/simple;
	bh=CiA7urzExORBNfNnKVkDnfqRTn3t7XF1Gk8zmHVsPIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI8UvXsSCm/acrSFGULTxatKNkeLiCzse8XJG5A/UvKghwbkeFxkLO8f69aEYzGixhsfpUZyqO5ypYzHyBX62YBDcm1UAvixJNQwMDCqpVYc40nGdk0ex2QSI93r1yRUSH2bdJGaRU8V9ZmxWgIcC6MQPE26kmcWs3822+hmK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ8rRxLR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso3127506b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733114358; x=1733719158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5z6e0Wwzok4/c8JJ14VvrKpt6wQ9E07/XNoPDXalY0=;
        b=GQ8rRxLRk8qBZPpjkVsmTkQmf01Gh/C1PrblbalQwXX1kMR0Adlu2lhnWU/pRRZ4Md
         7Bprfu4NsPWprR3K0bABmYazFT3oRcVxs1Cy/sZ99MnbB03oe+XjqpP3aZAjg5jLSRZW
         5lL2AYtgTOB2EjxLdVyHXLfkL17LbLaX6EudpMc06dVL4xGp3JnIo4a2OfnERg4emVse
         v+LgZGF3S5kKzVNEs/etc42y7ltTFwJ4XrdP0TmJxi/NRxsiorhKfKfbpOKYlp+SyrOc
         VOq5UGYVkhcPf93XVYU6wxpz4wgR/SkQc0uRGq05kiWeX7vjw/JPVq5kvlTpAPVUXnOX
         /KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733114358; x=1733719158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5z6e0Wwzok4/c8JJ14VvrKpt6wQ9E07/XNoPDXalY0=;
        b=AtW9oXU7mpdz9MXElGt1tHHQkhyCzqf5w6sVv6GajkxA9OHstWdQjs4xIiPjZmPWlp
         3zap+ySyla6Q0/J7ePwxjc/Lo9PDl0R0kPEVrtKV35Duk+Sjavvir3QOgp/vLJOxBKEV
         TLyBJeFs1/ZKOTP4tbntioR47x2QngxJ4d802yLETyYDQm/YFkRCMGt57BHVlAjYVvz+
         IovW/eyrM98upqxH3Mk3uyjwJ9GdB9f6Kpg7uCirD+pRSshiffPyXKBTosq3pDSZVrAQ
         MfHI8yhi3DvKyP9ZMWp8JLTxolVjCoIVskR1JKp73gtM8bw1zC5u5zQ6kyvMp1+/018j
         Uz3w==
X-Forwarded-Encrypted: i=1; AJvYcCUmnZjt9ILK0uNPgS+niobOBeHrQMbT9ij3DNXwXVCLbgWMhtMkzl8ULW5/aBjo4rZKrXP4MYfga2NXpo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIR0mNBD3nkrdEBarRQIx1uQU0LAz58QH8vgugR/dFqvAwHTeZ
	tb3VzGQxue0AtHfZouGLqg5DfUfUdfSOfSQGRnzKCWBq8ZO2emDn
X-Gm-Gg: ASbGncsEzK93XF10olOB8Wc05mo8V5Cy/mGcpf+xipz24i+0SeJoUi22mJKFyE+xriy
	H4r0DnkJfbjBvK0c2akOk5ZQKLwD3Ed9NCLqXkIA9Y9RC0loNsi9HGn36DO0JY1D3RW8xyZn9uL
	2jXmHy6hl7YnSvpdbOogw7P0iEsinQHmTH89Fjk4GDGHeewk+n45/g3YV8ECEKh0EmdhF4zYE0K
	BzYYtdcXrqEGlgaHhUy5kZr+l5YC5D2fHZCexnl65lXNjD0QWj7GSZc7Mzdeu3xA3S/h+HPWL4o
	SE2jyA==
X-Google-Smtp-Source: AGHT+IEaeNOvfUjlbtqHoKY56jCg6XhQk9IXFLBbMoRE/nbhRVXjUd0aG05P6S7NXiyEmpShabj2yQ==
X-Received: by 2002:a05:6a00:2387:b0:71e:b1dc:f255 with SMTP id d2e1a72fcca58-7253004c844mr27338111b3a.9.1733114357948;
        Sun, 01 Dec 2024 20:39:17 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f77dsm7443163b3a.53.2024.12.01.20.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:39:17 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] sched_ext: Add scx_bpf_clock_get_ns() for BPF scheduler
Date: Mon,  2 Dec 2024 13:38:48 +0900
Message-ID: <20241202043849.1465664-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202043849.1465664-1-changwoo@igalia.com>
References: <20241202043849.1465664-1-changwoo@igalia.com>
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
2.47.1


