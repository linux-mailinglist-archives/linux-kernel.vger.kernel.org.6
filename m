Return-Path: <linux-kernel+bounces-251256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAD29302B9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 02:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBFE1C212B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4AD2FF;
	Sat, 13 Jul 2024 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG27cJsO"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18FCA64;
	Sat, 13 Jul 2024 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720830743; cv=none; b=QApf3zNOsJ8V43k07LSsvlUjWuy1niuVKH0xuYVJ64y5mqZaQG4Lnwo8Wl24/zf5mdryu0ASlurulQKI9gCOcnXllTGJ7G1/XvZGxDX1/i6LzhPl7LmC+ePagper9RDFr4XysJgNwcHl6OdJ7+7wZyw0vcLRUuwYHCeI4co29wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720830743; c=relaxed/simple;
	bh=dm8jkNSRFXWS0JFiWRJPdS8XabcKrrxII3qEXSiH65g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sodtt4dVa7GTwZPcTQxLXLblKYPHciygujsV+C6WYGflAYTQF9zm6BwrcBEzT0Hr+X7Fhn97CHzBPFGSuGs/xVI27O2X+ofqRiH9zxmBVkZyP7wC3rxQ/9RqrLvy43cn3FA4dO8Qhjy4HROOWnWUuwt7srPoe0Min/yjqWjbDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG27cJsO; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-704473c0698so1223625a34.3;
        Fri, 12 Jul 2024 17:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720830740; x=1721435540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQV84yWA75dv41YWL05WuZUsml+E7RRrg/6zyWqAS9U=;
        b=MG27cJsOK8PwO7nEcppV8UZx3kaJ1kyrKAEo41BPwDNyLpGIZeg73usrt/rwy/dxKT
         5xnw9xX5ZIY2twqSjF9ps9d7zpXpNs8ovLFcmd/FUP/XvYn4/9Z5RPfsMKjE22LTFJ+S
         ewTplZbqx0YUiIr+XXMXHT+sOhN4dgUnPgDIE2wtAlcZH/r5px+fGUJzdMWAJxz9XyHG
         m8odPymue8f/h851439/ceOX+5XSxshT4G3sAeIDMBOerCo8swYXQYwT/GnCuuV/PaCs
         q7vMb2tpdNOQjJXluWJd5ApQQJzqnK6T5lhhkq+nfqL5hjN/tB72b34RMqC+8YTYrg3q
         xntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720830740; x=1721435540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQV84yWA75dv41YWL05WuZUsml+E7RRrg/6zyWqAS9U=;
        b=u/1iLKqhukfm4XapwQocD4Cnk/E1vej8VHIqqmMWj6dh5YHTxP2w+z6eGtiGYZl/ER
         ke0b9Rf+fCyClEjXnHNDuGrMlc6IzBmYUX+JwJEm6p23IBdWmCg6ZBMh1bMXKljX9r/Q
         QqBbCGpLWxVNQTPsdRQebcLyLF/t2UciK/PnLonB6tqUKwkoH5uauEGF6yneoy6d+XYq
         eTpqC/5iSodVvJTXV7Pzo0MZUpJcBqstSdVae7lRQ6Gp9S/zPbBZuDTDuGNFGs6BdmRg
         J+Qs8bVTmT7llp/+LFQayMxbUcPOfQrK436QRkwSfus8QvxgRgJk9iBtVVfPocXxweBr
         ab/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEY8/bkPx4tUKoNdoriAswoRHHbgAopkPG1gx2yeKsPD6NtkRQXa4g/hMiR1km7T0G2kUO67Bc9TG+Ym03ElDWvppMhFdLYC+eW2SN5dzG3n8ZEAGSs4D1OPYeJni4CuR2Z0wpAca1
X-Gm-Message-State: AOJu0YxSLqsfTl9hxM0+fvpTe+OQmsJ01sFG63cFnN+yNLuo53pd0vY1
	9ovXqZOsR86roQ20rQRzzWNfrFSxGPJdiKPG/pPDsP0jdbDYk5CP
X-Google-Smtp-Source: AGHT+IEt8wmOCcx1dC/iEZHMgec83vYmnXVBUj8HjaBBRosI7pR9acGqfMTzMS7wFjnbbXT5GnvxrA==
X-Received: by 2002:a05:6830:314a:b0:703:7827:6a68 with SMTP id 46e09a7af769-70378276b05mr16337584a34.6.1720830740401;
        Fri, 12 Jul 2024 17:32:20 -0700 (PDT)
Received: from pipaware.localdomain ([69.219.169.121])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce776c4c31sm25978eaf.45.2024.07.12.17.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 17:32:19 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	sergio.collado@gmail.com,
	peterz@infradead.org
Cc: bilbao@vt.edu,
	jembid@ucm.es,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH 1/1] docs: scheduler: Start documenting the EEVDF scheduler
Date: Fri, 12 Jul 2024 19:32:12 -0500
Message-ID: <20240713003213.4008440-2-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240713003213.4008440-1-carlos.bilbao.osdev@gmail.com>
References: <20240713003213.4008440-1-carlos.bilbao.osdev@gmail.com>
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
 Documentation/scheduler/sched-eevdf.rst      | 44 ++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/scheduler/sched-eevdf.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 43bd8a145b7a..444a6fef1464 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -11,6 +11,7 @@ Scheduler
     sched-arch
     sched-bwc
     sched-deadline
+    sched-eevdf
     sched-design-CFS
     sched-domains
     sched-capacity
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
index 000000000000..31ad8f995360
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
+4. REFERENCES
+=============
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


