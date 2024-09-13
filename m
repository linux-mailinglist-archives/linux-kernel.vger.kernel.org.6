Return-Path: <linux-kernel+bounces-327513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B403F977705
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF182862D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B5A1B12D9;
	Fri, 13 Sep 2024 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="lhbJgIF7"
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7133F7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195734; cv=none; b=VaqcyL6h3vB7Al6cjU6U+PTdTkmayx6n+lTTv8mIzB9W8FdoqgdO5AlyoC2sNOuSA0/4Ugw4PIlmDUNQQBHJgkrRV1AqwaxnPnyJPjyxy5eEstzXKh29j7zcnlgDiJTqRadKCKKA2psEhB6pYYfUCiyYNqjswLKhNCq4zkRG3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195734; c=relaxed/simple;
	bh=JBHDXT753nfWQcy+/OirF9Arf1V9GXT48FaSFnO8+2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WjvyneazJ4tGuDmOzRMxpjdWCbH4oaVWe2fcmHoS8LNGPpzRaRWyQFrRMWgnfQlr1/pwRaDyHwFU20YTD231UfWNIhfD4pAQ5BGI4yfZhjHCRqbV91WvQc0cwRh9cSW797xu4m1GX1w8DfXcZD5i39WuV0T1c1fTgMDajV5Zy0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=lhbJgIF7; arc=none smtp.client-ip=140.205.0.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726195728; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sk78RPR/D1ucvqQzMBD4yW9ti1WrTuAHH9RwDLsSwP4=;
	b=lhbJgIF7oLFcn5YqEmFASJPBi+QFLapQjJ2EN/wQj3s3LrPT2cUh8zm1WpRIfI81D+bcNbDKD2kAhtdg7s0kqeK7UBTg4ZLFgF+so/5xZpxop1UXNNGIkpSHWukrXM/87kuDmr+LYUZInEmD8iDIcxMSVdn88KTCFPLgUGpBa28=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZHtFxUj_1726194790)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 10:33:15 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2] um: Fix the return value of elf_core_copy_task_fpregs
Date: Fri, 13 Sep 2024 10:33:02 +0800
Message-Id: <20240913023302.130300-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is expected to return a boolean value, which should be
true on success and false on failure.

Fixes: d1254b12c93e ("uml: fix x86_64 core dump crash")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
v2:
- Drop the unnecessary new variable (suggested by Richard Weinberger);

 arch/um/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index be2856af6d4c..9c6cf03ed02b 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -292,6 +292,6 @@ int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	int cpu = current_thread_info()->cpu;
 
-	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
+	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu) == 0;
 }
 
-- 
2.34.1


