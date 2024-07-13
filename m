Return-Path: <linux-kernel+bounces-251525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C089305D6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540DB1C20E7D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7A13A3EC;
	Sat, 13 Jul 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PylUqc/E"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4E139D03;
	Sat, 13 Jul 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720879504; cv=none; b=i4y/RktaXNMUXnCAXhqGp8QSAXc0PxqP67f6IyLOKoeSOQ7n5EHdAFeStCC+xphNzT5WaCX4YaGRCWHL4IdZsWT3hEUdRQE+JEts35Cnj/qV3Wt2HvAIEO+uHP24rQOOsAks86J/OLUx7GZOHe1//fAivpfzB7eL8qB0yCzS2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720879504; c=relaxed/simple;
	bh=y41djlon1EmNvQH91Ujpbr7aLP7M7ZtQL61t9SVct0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLl2iFDBiKFr0Pe0IcGb4G0FEX9OLL+HY2JEhk18Rs6IbJZPEeBhDZ/vFa14W0r5f23ewbf/b9NP0Qdri+gI3WA3Z6FoFMfwtpqvfzNvKNURCThdyLfY023dD4NYnswGBWUXB4+ION4AhR3EeXAb3WrfAg5d+K4O8nJr/ZtWPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PylUqc/E; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d92e1bc90dso1193934b6e.0;
        Sat, 13 Jul 2024 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720879502; x=1721484302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sONMrKPDZz2mEbEfSbH61B6WFm8GtUA3sPQYMN+0HGk=;
        b=PylUqc/EDrZgL/t3q60xRXgY/6flwau/0m2ZVxKq31lw2j6bsitBrF1HQpy5O7grht
         w9mXlFujf/2xhRj2wU2HWSMcJaG916hUyyjqalQTRR4NGq6I9uuHNMMJwUODpB3AYIh+
         LFSqGDMc2IOI858ajdeLaFMV5yGiKHszat/DdNUyFRjk+AqpWpeyDHuXcbox2SIiAPu1
         CHE/D85f/ZSWC18i6fXtjLPJ5kphFPARX8s0kDAXbI1pNQR1AnHK3jmJhywWu3e4YPiE
         1JI5G4OZhSid9BwrbOumSOAv5S/DE8sq7AuNCesNoWDw2f0oZ4e7j83wDKllsLGLVBG/
         lX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720879502; x=1721484302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sONMrKPDZz2mEbEfSbH61B6WFm8GtUA3sPQYMN+0HGk=;
        b=O3FIB6aHcMABKlmxmocCFKmUCPC0biv1P4jW6BZueGUAJJGFTliRBXQj7CW9nJOMQT
         GwjEbBOFjKV2s1wiclXsCpISYB50Y2PJQYAK1Zs0DDrhYvSSSnbDHV3qlNFVWm5oDENI
         oZQTT+mfMflfztlq3KtvXVF1sSRso2eQYzSjDmcElu+gFDq23DbOzlqyC9F6fb4UqJhT
         YDIkIqN9GEcBQ74RiPO7xR1Fr3lQDVtw5duEgP7/UcplxUZDAaWAyvwa+y5pACtXWkBt
         zI9T6CLzMCCpo0iLqtECaK3RxiLZ5qjFdDn/29t7ZP5jVwNFT4YxPDegkIWVIkRyTtJf
         kM0g==
X-Forwarded-Encrypted: i=1; AJvYcCW6gL/xBLpAikh5Fy6nG7wJbQcWDj97K8RmT0VCO/Jz/zWyEsZmLOFDpXXMRmBFz3p7XqaB3GSbPlL73Hh/GQ1nclFWwmrR7+QMq+h0aCHrAzx70REgbeEuF6lTPGLutY4Dmu8F4KWW
X-Gm-Message-State: AOJu0YwzEsR1DlqVxNJqkJ763OR2rXPgp453ZmQ0ysFSWAU6UnoOI6V1
	FfnyxNKW+uqAf99AjASSu/b1t+Jak3IV/+51s80tVeO9kuOii+wK
X-Google-Smtp-Source: AGHT+IHYBWGNOI9fPuNOlDLGz7csbHHSfHK06rtnSXzSEyXB6t0BVaB8ojX3o07cuRD7k3901SdzNg==
X-Received: by 2002:a54:4004:0:b0:3d9:33e9:e2b9 with SMTP id 5614622812f47-3daa98be8b2mr2021023b6e.24.1720879501691;
        Sat, 13 Jul 2024 07:05:01 -0700 (PDT)
Received: from pipaware.austin.rr.com ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dab3e0fa9dsm192463b6e.39.2024.07.13.07.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 07:05:01 -0700 (PDT)
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
Subject: [PATCH v2 1/1] docs: scheduler: Start documenting the EEVDF scheduler
Date: Sat, 13 Jul 2024 09:04:54 -0500
Message-ID: <20240713140455.4072847-2-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240713140455.4072847-1-carlos.bilbao.osdev@gmail.com>
References: <20240713140455.4072847-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some documentation regarding the newly introduced scheduler EEVDF.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 Documentation/scheduler/index.rst            |  1 +
 Documentation/scheduler/sched-design-CFS.rst | 10 +++--
 Documentation/scheduler/sched-eevdf.rst      | 44 ++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)
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
index bc1e507269c6..b703c6dcb3cd 100644
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
+:ref:`sched_design_EEVDF`.
 
 80% of CFS's design can be summed up in a single sentence: CFS basically models
 an "ideal, precise multi-tasking CPU" on real hardware.
diff --git a/Documentation/scheduler/sched-eevdf.rst b/Documentation/scheduler/sched-eevdf.rst
new file mode 100644
index 000000000000..019327da333a
--- /dev/null
+++ b/Documentation/scheduler/sched-eevdf.rst
@@ -0,0 +1,44 @@
+.. _sched_design_EEVDF:
+
+===============
+EEVDF Scheduler
+===============
+
+The "Earliest Eligible Virtual Deadline First" (EEVDF) was first introduced
+in a scientific publication in 1995 [1]. The Linux kernel began
+transitioning to EEVDF in version 6.6 (as a new option in 2024), moving
+away from the earlier Completely Fair Scheduler (CFS) in favor of a version
+of EEVDF proposed by Peter Zijlstra in 2023 [2-4]. More information
+regarding CFS can be found in :ref:`sched_design_CFS`.
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


