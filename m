Return-Path: <linux-kernel+bounces-317887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3183E96E513
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5791C22E8C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC151B3B32;
	Thu,  5 Sep 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hvUB8tyw"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659171AD24F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571664; cv=none; b=jQS2aKoYTqDZK+E6tZwetmheNZRJKJI4Mz2gjJ1PD7XhbRq2B2y06+FKsuGp7RTrKKiKeH6026Vh4MHBDIA8oFL88IYO8EUVegrB58flmAK8pKM+LARRJv98kAVNru/lHMeQtZUSko8pE1x2oYCm6GMBopkFcw+VTFbHJJKkPQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571664; c=relaxed/simple;
	bh=jpXjyvIm5t8ELEC3zgL4nSmaJ0sWFg/nsgYEMgISSQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WI5LDwd4IHYESm8L4o8LuZUdLuuwjDh+dZIrH2gnYNYYotjA8tsKOjL6N98fE8u1Pm2/MUBcLY+HxWLIE4n21YBEXEAE2p51LJZBlsjL1VURDYLiwK8C5ke/F4i03cl1vv0wGjlUjdH9whnOZAiiRHqDjMllyo9MAb2x+ex5zuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hvUB8tyw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id F1F3020B7429;
	Thu,  5 Sep 2024 14:27:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1F3020B7429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725571663;
	bh=G1rWobBZqoXWJlYDGMxauE6LJG33qmx2GqH3BPqZPPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvUB8tywayDtbW13QEkW9Y8xP7ELCKb+3ORwaJIg9+kLvpQYSpas2ye6Ae/2hEI1w
	 1jkkLeVDKLIn3RI6/iNTX6mGx4AS871fiUTn3eV9dN6riRX+nfmLHZl3O41sNcIyAb
	 4IlplgsO/Nnz+zlRTzZeIME3cRDqlpqC6fYiAsW4=
From: Roman Kisel <romank@linux.microsoft.com>
To: oleg@redhat.com,
	linux-kernel@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
Date: Thu,  5 Sep 2024 14:27:41 -0700
Message-Id: <20240905212741.143626-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905212741.143626-1-romank@linux.microsoft.com>
References: <20240905212741.143626-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging, it might be useful to run the debug trap
instruction to break into the debugger. To detect the debugger
presence, the kernel provides the `/proc/self/status` pseudo-file
that needs to be searched for the "TracerPid:" string.

Provide a prctl command that returns the PID of the tracer if any.
That allows for much simpler logic in the user land, and makes it
possible to detect tracer presence even if PROC_FS is not enabled.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 include/uapi/linux/ptrace.h |  1 +
 kernel/ptrace.c             | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 72c038fc71d0..5056f5d1df6b 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -21,6 +21,7 @@
 
 #define PTRACE_ATTACH		  16
 #define PTRACE_DETACH		  17
+#define PTRACE_TRACER		  18
 
 #define PTRACE_SYSCALL		  24
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d5f89f9ef29f..91275c5c4f57 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1258,7 +1258,7 @@ int ptrace_request(struct task_struct *child, long request,
 SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 		unsigned long, data)
 {
-	struct task_struct *child;
+	struct task_struct *child, *tracer;
 	long ret;
 
 	if (request == PTRACE_TRACEME) {
@@ -1277,6 +1277,15 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 		goto out_put_task_struct;
 	}
 
+	if (request == PTRACE_TRACER) {
+		rcu_read_lock();
+		tracer = ptrace_parent(current);
+		ret = tracer ? task_pid_nr_ns(tracer,
+					task_active_pid_ns(current->parent)) : -ESRCH;
+		rcu_read_unlock();
+		goto out;
+	}
+
 	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
 				  request == PTRACE_INTERRUPT);
 	if (ret < 0)
-- 
2.34.1


