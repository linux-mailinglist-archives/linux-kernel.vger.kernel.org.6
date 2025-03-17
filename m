Return-Path: <linux-kernel+bounces-563932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A9AA64A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931D01888C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325C22579B;
	Mon, 17 Mar 2025 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhQKLpNv"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE1233702
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208191; cv=none; b=FSMRwmxERCgi38gr64AgBFCA3eW3SXUgwA1Oc/JCxHoanBqJJBE6T0PN1jI1XsfHnW3RvSIFmmMVxocxNVhUsxjsrICtS3+zKrNoTt+0SFI6OwxfTl7EiMPbOT+ADmb6jRxr6JUbYa8dY7dF5V6fmtgij5ePkwqNZkPRJRZNoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208191; c=relaxed/simple;
	bh=U18xujko9n0Y1GrO7buoeWVMF9gyXjkaaWpDVLWDWSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn0wjIZySjcLe/r6Dy+WI4EUtJcxEONRCYPxKkQRz/f+PQZDApShZD/xC4lQiREq6Y0cdcUirI/RZhuPsGx+IYbUWuwTdtSrOcHZIxrn/JKpC7Q3sZsk30Ca6W/y61koDrWLqTWuT0UyA7ak2UgOD12S+83zkp3+cfk7Mddlg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhQKLpNv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-391342fc148so2666140f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742208188; x=1742812988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx8FHwbN1ZlNJR2eQrRFHTsZzsgNNMNKpgOHR6Q6NVE=;
        b=NhQKLpNvj/ad/X4P944MmHiUH+c0sROxAaL/1h/JE2I73zDjuV/45wdaSKzl3XbA3E
         E/nNwrqNcBvt69Ug764tl1DGmdB1dBt+G27g9woKb2Csi4dqZyUtq3u8H2Kdy7Nwyxqr
         ZtQGxbt8mXTC71nAk5L8zc6twA/lkm8ozx5FUo+CjyKY595yA+gmqehCCNjGib3hs17L
         5q4Cq35gWC3l2V0xR/ZxRFz+fx+oiStNzw4+Gs1Jv8ZMnjFIGWRCnfz4/bTBl/AKKHg2
         26wCHj2Mw2u9s/QikdcL90Rd5la2ZqSuL8R/cIqjHR9eJ2HqWil7Vr1ah8EAN7B+awNB
         IiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208188; x=1742812988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sx8FHwbN1ZlNJR2eQrRFHTsZzsgNNMNKpgOHR6Q6NVE=;
        b=ITD7HRrKwAg+qIaAJhiAOPFS8DyQyL/FRn/MWCjWhOCSOZG7mWT8QkUtQpy97c0W+0
         D8qFjag8JGQgspba4m4uBepRvmDhWRiOgMH4cx1IxeGPemh2NyAEEX9gIZZMMIqNOLGV
         FyaRO8MuIe6p9FlcM21AgwP5dAHsmWEwlIxpBqhVgmArsnQ7LUTAA4Iid+GfuzYGb9lb
         RlgVM2xtSqKo8DZY4zupMZAuXQ1d45DYutuZk38gbZObvj6ZtW2YYiKxW3vXAulcmi6p
         cUJPfF8/RE3qdcho1/4dn5WBGBajzEExPs+2hdzRfX8EI97HpGVT4O7dqJHDLURfEFYR
         vdwA==
X-Gm-Message-State: AOJu0YxZ43U4xwTvwgfQX4xFL23s8zobW9lw/suF36nVaXPAoQifS9aa
	eeoR0hWnnLUDNl7EZm3SWKLmd+jFRW+yqM9H/i5FS4tZZgbQv3p7tG8z+VMf
X-Gm-Gg: ASbGncv15OxqH4W2xtcEY+TUJ+zu9vDl5dGWwjNvvLHvhaHmEcx3UGnI8KoUmVy3wF2
	0kPaGf0sMybTJMRUCzrJQ6vltPMLak7apXrINOgsyZXfJoXI06V5Vc+glrZ/dJtZ7rY6s4DFhh/
	N0azQYJ0ZsFRK75rJ3SH8VdDb2H53qW3P5YRF/j+RFfgEAaDPujreXrJx3inS7IVqz7YnEOybqe
	8LddNZVz/GO/Ls9faxOV0tED+t3/al8wJo0VAQW8+HwcAPDDayF8m2f0BirzpOXQ79GnBaqwebb
	u/WwduDbKF+Dlkm6dlOPoQeQFNXPwBllINmPLedJ8wDjxPfT6JNaXm4Khw0wtNvrRQ==
X-Google-Smtp-Source: AGHT+IHzkqMFP5e3a0iaSgEjqPer/VK4YhIMwkFQiCFnM4t/fOCXfPY1x7sJTqjv1CbilWJcLM9ryQ==
X-Received: by 2002:a05:6000:1448:b0:391:13ef:1b1b with SMTP id ffacd0b85a97d-3971e0bdc02mr10350417f8f.30.1742208188054;
        Mon, 17 Mar 2025 03:43:08 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3189absm14807262f8f.71.2025.03.17.03.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:43:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/5] sched/debug, Documentation: Remove (most) CONFIG_SCHED_DEBUG references from documentation
Date: Mon, 17 Mar 2025 11:42:55 +0100
Message-ID: <20250317104257.3496611-5-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317104257.3496611-1-mingo@kernel.org>
References: <20250317104257.3496611-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since it's enabled unconditionally now, remove all references to it.

(Left out languages I cannot read.)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/scheduler/sched-debug.rst                         | 2 +-
 Documentation/scheduler/sched-design-CFS.rst                    | 2 +-
 Documentation/scheduler/sched-domains.rst                       | 5 ++---
 Documentation/scheduler/sched-ext.rst                           | 3 +--
 Documentation/scheduler/sched-stats.rst                         | 2 +-
 Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst | 2 +-
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/scheduler/sched-debug.rst b/Documentation/scheduler/sched-debug.rst
index 4d3d24f2a439..b5a92a39eccd 100644
--- a/Documentation/scheduler/sched-debug.rst
+++ b/Documentation/scheduler/sched-debug.rst
@@ -2,7 +2,7 @@
 Scheduler debugfs
 =================
 
-Booting a kernel with CONFIG_SCHED_DEBUG=y will give access to
+Booting a kernel with debugfs enabled will give access to
 scheduler specific debug files under /sys/kernel/debug/sched. Some of
 those files are described below.
 
diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
index 8786f219fc73..b574a2644c77 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -96,7 +96,7 @@ picked and the current task is preempted.
 CFS uses nanosecond granularity accounting and does not rely on any jiffies or
 other HZ detail.  Thus the CFS scheduler has no notion of "timeslices" in the
 way the previous scheduler had, and has no heuristics whatsoever.  There is
-only one central tunable (you have to switch on CONFIG_SCHED_DEBUG):
+only one central tunable:
 
    /sys/kernel/debug/sched/base_slice_ns
 
diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 5e996fe973b1..15e3a4cb304a 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -73,9 +73,8 @@ Architectures may override the generic domain builder and the default SD flags
 for a given topology level by creating a sched_domain_topology_level array and
 calling set_sched_topology() with this array as the parameter.
 
-The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG and adding 'sched_verbose' to your cmdline. If you
-forgot to tweak your cmdline, you can also flip the
+The sched-domains debugging infrastructure can be enabled by 'sched_verbose'
+to your cmdline. If you forgot to tweak your cmdline, you can also flip the
 /sys/kernel/debug/sched/verbose knob. This enables an error checking parse of
 the sched domains which should catch most possible errors (described above). It
 also prints out the domain structure in a visual format.
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index c4672d7df2f7..5788a3319630 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -107,8 +107,7 @@ detailed information:
     nr_rejected   : 0
     enable_seq    : 1
 
-If ``CONFIG_SCHED_DEBUG`` is set, whether a given task is on sched_ext can
-be determined as follows:
+Whether a given task is on sched_ext can be determined as follows:
 
 .. code-block:: none
 
diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index caea83d91c67..08b6bc9a315c 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -88,7 +88,7 @@ One of these is produced per domain for each cpu described. (Note that if
 CONFIG_SMP is not defined, *no* domains are utilized and these lines
 will not appear in the output. <name> is an extension to the domain field
 that prints the name of the corresponding sched domain. It can appear in
-schedstat version 17 and above, and requires CONFIG_SCHED_DEBUG.)
+schedstat version 17 and above.
 
 domain<N> <name> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
 
diff --git a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
index dc728c739e28..b35d24464be9 100644
--- a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
+++ b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
@@ -112,7 +112,7 @@ CFS usa una granularidad de nanosegundos y no depende de ningún
 jiffy o detalles como HZ. De este modo, el gestor de tareas CFS no tiene
 noción de "ventanas de tiempo" de la forma en que tenía el gestor de
 tareas previo, y tampoco tiene heurísticos. Únicamente hay un parámetro
-central ajustable (se ha de cambiar en CONFIG_SCHED_DEBUG):
+central ajustable:
 
    /sys/kernel/debug/sched/base_slice_ns
 
-- 
2.45.2


