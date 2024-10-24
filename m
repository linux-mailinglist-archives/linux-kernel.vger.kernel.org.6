Return-Path: <linux-kernel+bounces-380096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5989AE8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F0E1F22D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F3E1E7C0E;
	Thu, 24 Oct 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="UjA1BCx0"
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E81E412E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780125; cv=none; b=qyaiJHVC+zwWk+2RJ4V3z9/vqWfbRxi3hcWx8x+xERgxWe0rIJC7sTBOCmVUHaB2W/54Jvnbvs/YaAkVByngv9xD3PH5Smd9vxxleIdZhfGMsVDPa1bniA18dmO3mapknCXyBWt+O9aTfJgmb3013Syr7sa2er602l8jFIwqgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780125; c=relaxed/simple;
	bh=KLD7jDp1bxtN/NU7xRa/QUaFd2d5eTWVnfaMQMq4sx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kV6cIupfpKUwg2uelGXPFRpFW0XXCFy2Lvi7Go980UpQRgbIrQzzn7M01axE3yVd9J2YmDyXsf2j7+HcAII6vaQGMqsOm4M7/3ce8a9slu0aRj7pk1p4VGt987pmmTcnqa8EnBr3yDz5DXauib7Ca2+kLt133uVQZEARH8k45pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=UjA1BCx0; arc=none smtp.client-ip=140.205.0.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780117; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Vju3PSxIcD7VxO0E+oMlNC+TNtVp16e3ZGllvv3Wkog=;
	b=UjA1BCx04keL7rQy4UTiTpaEpNvku8cKP+u4uIOppUEdyN8z2HISBaMI7vFqF5LISjop5Cu8J4T4g5sPUkv5FG6HipYL6IxPY1OGpPLN8DQxO5+FRy4gYpE74qikQcYcO3ibClGG8DzoafJoNIQNSN2rOgkVn2/CZXaoVMrtpEE=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBszp_1729780114 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:36 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/4] um: Add os_set_pdeathsig helper function
Date: Thu, 24 Oct 2024 22:28:25 +0800
Message-Id: <20241024142828.2612828-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
References: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper can be used to set the parent-death signal of the calling
process to SIGKILL to ensure that the process will be killed if the
UML kernel dies unexpectedly without proper cleanup. This helper will
be used in the follow-up patches.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/os.h | 2 ++
 arch/um/os-Linux/process.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 09f8201de5db..d709a24dc6fc 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -216,6 +216,8 @@ extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 extern int os_mincore(void *addr, unsigned long len);
 
+void os_set_pdeathsig(void);
+
 /* execvp.c */
 extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
 /* helper.c */
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index f20602e793d9..9f086f939420 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -12,6 +12,7 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
+#include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
 #include <init.h>
@@ -203,3 +204,8 @@ void init_new_thread_signals(void)
 	set_handler(SIGIO);
 	signal(SIGWINCH, SIG_IGN);
 }
+
+void os_set_pdeathsig(void)
+{
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+}
-- 
2.34.1


