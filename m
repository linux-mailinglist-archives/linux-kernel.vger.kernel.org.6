Return-Path: <linux-kernel+bounces-429653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6829E1F23
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80487164BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DE61F666A;
	Tue,  3 Dec 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFpju4tE"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE481F6662
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236125; cv=none; b=JN7z0HQ8q/hSc9K1WusDU3+xy9sqKJDTB6UE/o4iqNUgsFF84vQ/4fSZVrrMtf+hdW2NoUB8IYwcFtAhg9sA7hlvpme8pxLwC5dO64rd9NhcqZ1TBQxjWSzpaG2BckRn6eaxIz8PmRqY+iHmsgHp5kEMgLQRG9RgLV/2F1AmBgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236125; c=relaxed/simple;
	bh=Kzd/PUC5ctt74z6B6vUj4jyvkEy3XwQUHulW25s5gBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhrNIwIS5zrgR/3d/EihzKzIaz6mGKV8i+S/5djUCdwZgI6ayd86V4u8gvJmFcv907ajieon7QdqLufV11EPxWBGIOMrpYRNfEeIjFa5lLdc+Y91OowBoSwMvYDaxEjSfqSRZ2FGKx2KF2VY9NT0/mZZpkj3Tq03SGeWHb77ARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFpju4tE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215513ea198so28166245ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236123; x=1733840923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hrorv/GUnF7EJucVAVWvFSb+WFE0AwzJOhO/e5bho0Y=;
        b=kFpju4tE1u3azH/d6FTZbV8QxLr4W6X4aeKF2+DKZSURZFewcck+E+t700PDgMbpuJ
         Xgd6o9pONk6ISYpz6c/DNIhJtUPoB5S/cd8AK/k1IuexhJK7u5q52dieEgvAhz4Z2tWm
         CECyZmuA3WOVKZ2Ud2RsaQGac6ge5ab5kPv1A+LfyHoCPDJj58IQmMYXkl8Fv16kYnkk
         YZEKmeUwOKrqslZ0eMo3oCxyMr0KMWfg3H4VNOctVVuZ+v9yZdJTYK4FW9bQYHPx1V0S
         hmnEJypa6jYL417CxKJBAo1HdPyV3/S1iXixrYmx6wUtdJ7gyqbktSYFVAb/NyxJ2ljx
         Xaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236123; x=1733840923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hrorv/GUnF7EJucVAVWvFSb+WFE0AwzJOhO/e5bho0Y=;
        b=sZ+3LkjYmTcfC4eWGaEs2gJwe5ckBBx90mN4HfLPGO7Azux6nHVhS3Px+bsntyYf0w
         ai8SAjS3kf9XM8ELTNd7ql9asDfPmiUbUycCbpnM6MjYYcQ9V4/NFdnalQTxDeoZplpw
         gaRWtzN3SAXAyqva4Q6FVWSJGWh7aZZYJWsWEKSnwm1blDL69SxKoWyrXapuUumh3Sqr
         7iXmwZV7R0XcmNmfAJNXAoSpRrdF/gVWLMSACDMwDAfWqOWV1IKy2wA6v82/SX7HG4Qg
         HgNE8tc9WJH1k8MtkDxqhVpSv2Ej+YyRTOJSFGOLmDSUCTIhWDGddGR6ra0twmQ7U+02
         /JIA==
X-Forwarded-Encrypted: i=1; AJvYcCVnkmjNpTVyAQkaVIG8W7GvXir+rqml4mSIECZUGJV+XmrzRaoF+Spg6T6fIRnB4QN0OBNBNS0mujsJGgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE7GhMEPqb7DuTuvmoJN4xAlc+3plWYXvgKUcB/cw5VlxDE2uo
	4voUUfWLicP31TIsfp6NozDmseHeb0LPGjeyUnmTym8xWLLhCFLW
X-Gm-Gg: ASbGncss0NYAo3j2MJLUUdaGe9sVC94jIllJtWFyfYWb4JxyRGtrBOdX+bDRRbPahX6
	0LjprjW3Y3lhv0QByNwPkunOFV0zNZOMWlnt6hysKS0uVSnBF+xAsOLeFGjmSOoi7W6aIuBdA15
	p3+lIloiRR8ttG4iKIXaZ6JL4K4kKe/l+zEeK4vC33/p+0GBm/HnmN/72ZKEjOkFqIg+XrDnbne
	nuw37Ujkq0012b/8iGRVZVdtF3gCE5yHsB57/7+Umofw7xdM9wjreij6yYnR1uA5rj2C1b4DEry
	lEwTvg==
X-Google-Smtp-Source: AGHT+IG2K5uZo4GqKpI5DVD7Drbl8U8kF581y/rMKG+4tvjTUKEugmTN1ITRDZlE5gV/OAxdW/NFhw==
X-Received: by 2002:a17:902:db10:b0:215:65c2:f3f2 with SMTP id d9443c01a7336-21565c2f650mr218546115ad.6.1733236122922;
        Tue, 03 Dec 2024 06:28:42 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215964b6b76sm35501205ad.191.2024.12.03.06.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:28:42 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] sched_ext: Replace bpf_ktime_get_ns() to scx_bpf_clock_get_ns()
Date: Tue,  3 Dec 2024 23:28:02 +0900
Message-ID: <20241203142802.36305-6-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203142802.36305-1-changwoo@igalia.com>
References: <20241203142802.36305-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the BPF schedulers that use bpf_ktime_get_ns() -- scx_central and
scx_flatcg, replace bpf_ktime_get_ns() calls to scx_bpf_clock_get_ns().

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/scx_central.bpf.c | 4 ++--
 tools/sched_ext/scx_flatcg.bpf.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index e6fad6211f6c..cb7428b6a198 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -245,7 +245,7 @@ void BPF_STRUCT_OPS(central_running, struct task_struct *p)
 	s32 cpu = scx_bpf_task_cpu(p);
 	u64 *started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
 	if (started_at)
-		*started_at = bpf_ktime_get_ns() ?: 1;	/* 0 indicates idle */
+		*started_at = scx_bpf_clock_get_ns() ?: 1;	/* 0 indicates idle */
 }
 
 void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
@@ -258,7 +258,7 @@ void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
 
 static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
-	u64 now = bpf_ktime_get_ns();
+	u64 now = scx_bpf_clock_get_ns();
 	u64 nr_to_kick = nr_queued;
 	s32 i, curr_cpu;
 
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 4e3afcd260bf..15351bf2f053 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -734,7 +734,7 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 	struct fcg_cpu_ctx *cpuc;
 	struct fcg_cgrp_ctx *cgc;
 	struct cgroup *cgrp;
-	u64 now = bpf_ktime_get_ns();
+	u64 now = scx_bpf_clock_get_ns();
 	bool picked_next = false;
 
 	cpuc = find_cpu_ctx();
-- 
2.47.1


