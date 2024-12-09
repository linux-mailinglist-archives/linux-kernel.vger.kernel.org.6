Return-Path: <linux-kernel+bounces-436829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA20B9E8B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F6E164653
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229C214A97;
	Mon,  9 Dec 2024 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jynot8yZ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C5214A89
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724965; cv=none; b=qbr7Fg9ieXCHYn9yf3j8xv48F2lw7UzGBrQ47ONweDFLuv7zeZlBCREdkCH+0FmR0VVyfvXSqPDAhpGqo8KeAKMmYTYZ6XMlNG80Ks7xEgdeg/szA9Ysyb86ghL1yKxdMfvklybrs/MXVNAesUc0WpQGe2M6jfnyKy4NDpXoU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724965; c=relaxed/simple;
	bh=3MTZN/eJy+347t6uxFM4RqQzva5iqdXS/ZcOt/1Xa4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9z3IeSOSpcc7OiOeeA2LN1BDbRZKl16VylQKAiU1d/9aFNIO5QiFrvVcheZq5gy+V7niOIQqYH9EROg7LzEHjjva+TuxxnCDk4YKcvbzwD98UbGa6j+7VUCWgCPxaGeJKvBtVQl2a+DIuJEUSspv6+cBp9uwjQtuXQtYFy8LLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jynot8yZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ee27e905so580044b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733724964; x=1734329764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogSxJ0qgSRVGfWLd2NgyVRKG8hMtwjWInerWH6gERr0=;
        b=Jynot8yZqm9O1/pxbaSTXZ9ga4KV3Bc4z1QJTLN/eKxn9dCUd/YRLqrNzq2gBst9XA
         BCzYRyDn6+N69/CnBM5ugKCViRThQH+W4UKVbv+y+PhX1PElk/WWBnFErwwfT7rHx+sh
         Tmyo57J4rxtX+fOF9un+wjL6P3ZFApUCIkPTwKXdX4I50+S2eWGKGQsqQpm7qtmO1DH0
         o8ZQJbMwBKo9iA83yHlbRE7hm5GSNyHPybRz78rMFyf/ECgLjrZyKRBIjWrhlcgEYdGf
         y8GVLZ6ELoKf0KZhTcDIO4cFumRXm/7Waek68WzcaVjKSjHHwS3N2SvjAyO+Lmh8Vtht
         NOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733724964; x=1734329764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogSxJ0qgSRVGfWLd2NgyVRKG8hMtwjWInerWH6gERr0=;
        b=uQzZdQgQN9nJXUF5VamW79Z6HuLnZk3kbu9bro0U5r05I31y4IkJamPul87l8QaHNR
         y4GnEK9dD1GQTOwnrGmhG4HLdLtSnjMczmr/kimOhywbqO0baoZwnnVkjoHvIT5itdgn
         5mXlaFzCGJeEHNlyC4q0e0ee5WGnE/a1hbBk+/3I3liT7r9HK3FCJGmdPqQxXj1engI8
         SRVC0ykeDqCiZBEdeiW4fvj+zKf2GEdncJ/te02fW64lujF7yb1wR6EuJn6Mr8lsQF2p
         l+kTlFipLkEJDiasEwmYmf1JduXYvABpCFnwpEC+7Z8gkcBMBtDn/tke+LmllX/yCkB/
         1DgA==
X-Forwarded-Encrypted: i=1; AJvYcCUHQvp+Jh2C0kdBb2ku7+5gRS1UKeKbXuxarsfKkByBvAhF2gzt5TdsZr3MdHTEU89Gj+ffR9e7HSIl6DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CWzQkW2lzqbTtdZ7SZoIlmvtMhvrf4jeqdzEyJd7y4aPtEze
	UdaCEkxSfzvebDRw0F8JaXtv1FBG1FXOHQSmd4u1k5+aE2pjjLfp
X-Gm-Gg: ASbGncscIic77g4A6mIslEyGME6An4vtquIO1CmYKTURdCnVhslufAHW56gpWD4bY/t
	pkWXK9bzOAoU/9zhRlDwuKdJogpGoe6vc1cDtVcohRghsatnLe1jrOpeuffFDxczjr3Z3RWR1VI
	JLCA9YYecIoeCuO3nTZV7ZSPgPWhpZZtUYDSV+nC5/17R+2urck4mOSW29UTljD/iJdnb09v6LT
	ZHnPUoOQLS80npYyjvyP1THPy2ZQrf7QWhE4WtTKQQAlo2MeNgsmJiIlN5swjNTb50odHsmG5Pa
	j25lmQ==
X-Google-Smtp-Source: AGHT+IGkMLw/XguT2MSh4yw8vFbRBFPdO4mqrCvX61feUs351mK8m1b8xd1vSJnSRFsU2WFoYHWmLw==
X-Received: by 2002:a05:6a00:4b50:b0:725:df1a:282 with SMTP id d2e1a72fcca58-725df1a17c6mr7207637b3a.10.1733724963584;
        Sun, 08 Dec 2024 22:16:03 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e6e024e4sm1824259b3a.153.2024.12.08.22.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:16:03 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] sched_ext: Add scx_bpf_now_ns() for BPF scheduler
Date: Mon,  9 Dec 2024 15:15:30 +0900
Message-ID: <20241209061531.257531-6-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209061531.257531-1-changwoo@igalia.com>
References: <20241209061531.257531-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_now_ns() is added to the header files so the BPF scheduler
can use it.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 1 +
 tools/sched_ext/include/scx/compat.bpf.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 625f5b046776..d8fd58d8c032 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -72,6 +72,7 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
+u64 scx_bpf_now_ns(void) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index d56520100a26..2f16f30ae741 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -125,6 +125,11 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	false;									\
 })
 
+#define scx_bpf_now_ns()							\
+	(bpf_ksym_exists(scx_bpf_now_ns) ?					\
+	 scx_bpf_now_ns() :							\
+	 bpf_ktime_get_ns())
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.47.1


