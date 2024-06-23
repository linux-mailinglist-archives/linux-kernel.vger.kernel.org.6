Return-Path: <linux-kernel+bounces-225904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FEA913740
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 03:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965DF1F22625
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 01:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A3BE49;
	Sun, 23 Jun 2024 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NO8efSqs"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB87462
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719107466; cv=none; b=pMn2xwSpfjUGnEalHuLQAquR4f+cS4eAFlFu8okh+qakrOFeKqfR3ktuAnIPhFpvQ8KkD8HtQa79fLigImU5FuYxuVHP7xQaoYi1yMUQ8Cp8muhdSlnkwbgybg7XeizbAbIcI73TCfBSWdYoampEve1EKadQIxSh0tybVvg+zUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719107466; c=relaxed/simple;
	bh=wxPu6VP+4WYk3i/1FoM8ty3IuCZcz+GN8vW9vxwLxp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEZNMCFlY/vapjqZ0d3wZ4y7pzhIbqQqTFQA4kiQMP7Bgm95FDH5f/b9XodA3FtcaX5BD5tSInrj2YAqJXFRD7kigymN395hqJIb4+YTve0slvXSwtIBG7ClPP+KPrd4ArDdUjGU6Fz2AOybqYdkVji6NZb5BUkBn2MshPqwpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO8efSqs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70671ecd334so343002b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 18:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719107463; x=1719712263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMqB8oVdmYi58VvX91z4XCK8V+EzINVqYbw+PvZGpm8=;
        b=NO8efSqsYpOWASUnzrbH2cuWyXH7hr5GTDUnUG9Y+ShK3DiY7v9Wm3j7n3lO7/ml/q
         naLcMbp6G5R1KHcFpu8YVO28DzlVn3J0UpS+KqRO3JqUB3smeaCFEHzPzPy4NmZ6XXRF
         ib0Sl8ww/N6TeospZLDHa8gDgz+/zmM8mpyN4VsOre/id+6eh+KgzkHkpEV3DydcMM9E
         JeISrt0S/OBhQ2TF48PTah4EpuHdj+qYCF9AZZM7uX72dZMaBXTIR4SrSWiYuLvBoEDB
         rgTZx/UmZq3QODTqBLWMYYERea6g8hX8kM478BWI8egfMPT20TPsuOmhaZLlD4q6qgLj
         EsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719107463; x=1719712263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qMqB8oVdmYi58VvX91z4XCK8V+EzINVqYbw+PvZGpm8=;
        b=Y5hNPMpiice+9mPT8z4PhLq2dtjmPtchGJDXUnc5t2a/JtFjZzKHbuwD6fNFU+C+B/
         OXUH/7MKggFXH7FfPUCCbLhgiIwjsd2CtkZaglrLGhd8DNUNnm8wXWTiIE12O3mWxqeB
         28fNgaR9Hs4VpOfRsnOhgjkv+TeEL9ZOogwM0tjLRGEqY5/ITH5UPIzwCQIREa5RwJMf
         B9UQCl6RQGl/8cvArX1W2jjo8YNYTBAr3csM3Uy/i+/0SgXHdX504lXFfY2uGiiqAkFE
         uvUzjCmTEO/G8gdZwH3O6Ov17XUhGTiohFNi63Bzoij2zIqSNMUA62bTbK3+bLzmVJyg
         neOg==
X-Forwarded-Encrypted: i=1; AJvYcCXwIYhvSr8u/GDPA1JzqlJwJgbIrxrhBf3CRYpB38uTpCxdV3Pv3Ot7dY43khyZ8g1AWjjxo5q8XBp0NlB6pMmkJUbpIOhf59Z3a/C1
X-Gm-Message-State: AOJu0YySFY43DSKQB6GIlzuZaUojQogumRzZY4QLBV+AlRGaQ5xB8YEl
	r9vdYrzSO6fHsYEK59Mz61O37Xm1WuCTizX+9880iyunqClrxYKv
X-Google-Smtp-Source: AGHT+IFO/XZtXTzJIDuSjyXJhrioFhYPjSRhHzE7/3kPl4vgz/lK/Px3E5Jd9Qmu7lZVlIo64Tz0eQ==
X-Received: by 2002:a05:6a00:18a3:b0:704:3a0f:1d88 with SMTP id d2e1a72fcca58-70670ffc05dmr2381670b3a.21.1719107463268;
        Sat, 22 Jun 2024 18:51:03 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb22d45fsm3248226a12.86.2024.06.22.18.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 18:51:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org
Cc: void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Minor cleanups in kernel/sched/ext.h
Date: Sat, 22 Jun 2024 15:50:20 -1000
Message-ID: <20240623015057.3383223-2-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623015057.3383223-1-tj@kernel.org>
References: <20240623015057.3383223-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- scx_ops_cpu_preempt is only used in kernel/sched/ext.c and doesn't need to
  be global. Make it static.

- Relocate task_on_scx() so that the inline functions are located together.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c |  2 +-
 kernel/sched/ext.h | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 28f7a4266fde..d4c645f9e031 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -771,7 +771,7 @@ static bool scx_warned_zero_slice;
 
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
-DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
+static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 struct static_key_false scx_has_op[SCX_OPI_END] =
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 0a7b9a34b18f..229007693504 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -26,13 +26,6 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
 #define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
 
-DECLARE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
-
-static inline bool task_on_scx(const struct task_struct *p)
-{
-	return scx_enabled() && p->sched_class == &ext_sched_class;
-}
-
 void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
@@ -54,6 +47,11 @@ static inline u32 scx_cpuperf_target(s32 cpu)
 		return 0;
 }
 
+static inline bool task_on_scx(const struct task_struct *p)
+{
+	return scx_enabled() && p->sched_class == &ext_sched_class;
+}
+
 static inline const struct sched_class *next_active_class(const struct sched_class *class)
 {
 	class++;
-- 
2.45.2


