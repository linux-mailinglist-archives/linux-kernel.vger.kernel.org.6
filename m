Return-Path: <linux-kernel+bounces-257754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F04937E7A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6201F21873
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062E8489;
	Sat, 20 Jul 2024 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djRMetDi"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC70137E;
	Sat, 20 Jul 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721434934; cv=none; b=qNZLQsmdijHWoKyfuO6K6bKQUOFOs3hCX+5va73qh2djJdvLw6zEsqtLsYaw0SiVt4XqhK3PN3E1Q1SnJOPI18MGfOxMicTk8YQVxRvyI2NfHroeeugZW6zE+PbDmAJiLCAvgfXc/gZKVWvvu3bGjYTMaQwKx+/F1mEAAjsRBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721434934; c=relaxed/simple;
	bh=JFL0udktLQK4l0CczeoccXUmd0Orr7KhMBEwwukLO+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkyuJFGusqAcZFSk9n0zTGrCNbgVVOMNHVW3mfq6lXy62/x9CXHf+eoG6v6vhamKn8cmNi6yO18kCyA0LGEgVfRIaCIbUQBFC3H55OjOgtKewIIKQZn5Zl4L7wUZUdJacSW5Rwc3+FpFUlhGb9p0kgDYyaSLRDC1Kq6CW+CV06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djRMetDi; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9cc681ee7so1203427b6e.1;
        Fri, 19 Jul 2024 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721434932; x=1722039732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LIVBaWbXBpaA3WOF+zMQ9YS4C3lQyiOU8RT56n7o24=;
        b=djRMetDiGipeUlB3WTslxWPgdkmsCQ6L6lYpvuhxjUNlr5GJZXvxxuMaUyvyaiNBnj
         n1rpwiFeC57htUDJlEk/OMv4S6py3VrOleKbcWZugu+rnF9tE1SDaG3eiy0HP8ffDg7F
         AvohC5pQ4j0yEvZnpRhscyeC1yx76GQ7u1LMhbt/Hf7YeDZ3r1NXVGIEYBgZuK/NKY0i
         yeWk+141xEVUkc33s+c3TxYizhD1z6D1pMdWskNhyVtvaNoSMuhfYALK2rtURA63RxEz
         nEc0Xm1TDX8/B3g2Zj3r1eNWmcvKuaabklekiNktD7josPlx5fF6diIRo7JjI7XeOkm3
         9+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721434932; x=1722039732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LIVBaWbXBpaA3WOF+zMQ9YS4C3lQyiOU8RT56n7o24=;
        b=O0qmRB4XXHN1f/X0WjNEHGtkelqCZPC40DXdOH0SaAnFgfjQdmWmHMa12/pg++ELOz
         EGWWM28V/e7XwYatuuOc6bEjAkRD2z5P+ILS0paWXvydBQ8BLelDmfGrzOhNg13ipU0s
         gRIFUfdeMNVSoe55gp9uVSqw/JWeaxpC1dikHgPYUytRLfPN4OXeYWbcOyA2PA0et8se
         FkUxZNsmiZo+MYFw7XEg7taDQ8CJwluHiqznhcKk157XZjGYO1mpflTNGoDnvCZPHnVH
         Cn0zJQzwYgrC0yH5evydgDXDnRgd6MwlcJZtLoPTDldHNCa7iCritZ9E9FENw8QJnF+a
         LC7g==
X-Forwarded-Encrypted: i=1; AJvYcCVAEUTAhYD0dVp0sKtSyF8hYygP+3cCjFXZ1Iqoj1XuAa29qltcmITQq/m+GGUPyTxHLLTWWoO3vr5ZhtLaiHTDc4pzcxbCBt39awQJhvK0mphAjW5wwOAtp2Aq0b1s6e64oXTVSFvm
X-Gm-Message-State: AOJu0YyRBSmRC2hQSPrLC/DbwAEHBTkuL7YRq8O/6nprC2z50XbcYBEK
	+VWB9jZ2mQN9Q9Nllk1jMpAHC9DrDcwbTfVvXT8Re8nkzrzvJKJY
X-Google-Smtp-Source: AGHT+IEaA1lylIk06MduhRkRxy8azLMe2cGhO37X+00Op1ITJXJZSPs1FL7DAHfJGBW3s62mNd3YOw==
X-Received: by 2002:a05:6808:190f:b0:3da:a185:5a9c with SMTP id 5614622812f47-3dae64dfd10mr577573b6e.6.1721434931627;
        Fri, 19 Jul 2024 17:22:11 -0700 (PDT)
Received: from pipaware.austin.rr.com ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a582fsm532142a34.12.2024.07.19.17.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 17:22:11 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	sergio.collado@gmail.com,
	peterz@infradead.org,
	rdunlap@infradead.org
Cc: bilbao@vt.edu,
	jembid@ucm.es,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH v3 1/1] docs: scheduler: Start documenting the EEVDF scheduler
Date: Fri, 19 Jul 2024 19:22:06 -0500
Message-ID: <20240720002207.444286-2-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720002207.444286-1-carlos.bilbao.osdev@gmail.com>
References: <20240720002207.444286-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some documentation regarding the newly introduced scheduler EEVDF.

Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 Documentation/scheduler/index.rst            |  1 +
 Documentation/scheduler/sched-design-CFS.rst | 10 +++--
 Documentation/scheduler/sched-eevdf.rst      | 43 ++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/scheduler/sched-eevdf.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 43bd8a145b7a..1f2942c4d14b 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -12,6 +12,7 @@ Scheduler
     sched-bwc
     sched-deadline
     sched-design-CFS
+    sched-eevdf
     sched-domains
     sched-capacity
     sched-energy
diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
index bc1e507269c6..8786f219fc73 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -8,10 +8,12 @@ CFS Scheduler
 1.  OVERVIEW
 ============
 
-CFS stands for "Completely Fair Scheduler," and is the new "desktop" process
-scheduler implemented by Ingo Molnar and merged in Linux 2.6.23.  It is the
-replacement for the previous vanilla scheduler's SCHED_OTHER interactivity
-code.
+CFS stands for "Completely Fair Scheduler," and is the "desktop" process
+scheduler implemented by Ingo Molnar and merged in Linux 2.6.23. When
+originally merged, it was the replacement for the previous vanilla
+scheduler's SCHED_OTHER interactivity code. Nowadays, CFS is making room
+for EEVDF, for which documentation can be found in
+Documentation/scheduler/sched-eevdf.rst.
 
 80% of CFS's design can be summed up in a single sentence: CFS basically models
 an "ideal, precise multi-tasking CPU" on real hardware.
diff --git a/Documentation/scheduler/sched-eevdf.rst b/Documentation/scheduler/sched-eevdf.rst
new file mode 100644
index 000000000000..83efe7c0a30d
--- /dev/null
+++ b/Documentation/scheduler/sched-eevdf.rst
@@ -0,0 +1,43 @@
+===============
+EEVDF Scheduler
+===============
+
+The "Earliest Eligible Virtual Deadline First" (EEVDF) was first introduced
+in a scientific publication in 1995 [1]. The Linux kernel began
+transitioning to EEVDF in version 6.6 (as a new option in 2024), moving
+away from the earlier Completely Fair Scheduler (CFS) in favor of a version
+of EEVDF proposed by Peter Zijlstra in 2023 [2-4]. More information
+regarding CFS can be found in
+Documentation/scheduler/sched-design-CFS.rst.
+
+Similarly to CFS, EEVDF aims to distribute CPU time equally among all
+runnable tasks with the same priority. To do so, it assigns a virtual run
+time to each task, creating a "lag" value that can be used to determine
+whether a task has received its fair share of CPU time. In this way, a task
+with a positive lag is owed CPU time, while a negative lag means the task
+has exceeded its portion. EEVDF picks tasks with lag greater or equal to
+zero and calculates a virtual deadline (VD) for each, selecting the task
+with the earliest VD to execute next. It's important to note that this
+allows latency-sensitive tasks with shorter time slices to be prioritized,
+which helps with their responsiveness.
+
+There are ongoing discussions on how to manage lag, especially for sleeping
+tasks; but at the time of writing EEVDF uses a "decaying" mechanism based
+on virtual run time (VRT). This prevents tasks from exploiting the system
+by sleeping briefly to reset their negative lag: when a task sleeps, it
+remains on the run queue but marked for "deferred dequeue," allowing its
+lag to decay over VRT. Hence, long-sleeping tasks eventually have their lag
+reset. Finally, tasks can preempt others if their VD is earlier, and tasks
+can request specific time slices using the new sched_setattr() system call,
+which further facilitates the job of latency-sensitive applications.
+
+REFERENCES
+==========
+
+[1] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564
+
+[2] https://lore.kernel.org/lkml/a79014e6-ea83-b316-1e12-2ae056bda6fa@linux.vnet.ibm.com/
+
+[3] https://lwn.net/Articles/969062/
+
+[4] https://lwn.net/Articles/925371/
-- 
2.43.0


