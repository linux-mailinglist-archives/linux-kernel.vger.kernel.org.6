Return-Path: <linux-kernel+bounces-305085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AC5962949
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD111F24EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBB176AAA;
	Wed, 28 Aug 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="eECe/2Q5"
Received: from out0-219.mail.aliyun.com (out0-219.mail.aliyun.com [140.205.0.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05821EB3D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853119; cv=none; b=ehiCyjena7r/37Im20bw6gGpZ4q12vmPx3OVnPYTG2zNuvEF98Lzi+pb4VYUDeVUlbWt5KD9amTrtY/01RAqyE2vJgSjFPj+MP0dGA8smqjjvl6zAFXendwFQJC/LpJ73u5WMfN6gT11eNKPBLgwibtK3LXZp9BbhqN9aS7yhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853119; c=relaxed/simple;
	bh=B4Cy+OatU8p90iXKkDcsVHvtzFnr5rbdY+gINjLuZzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pvhBmYTnTIeCijlhrCVJL12drnR2hvGccoIeSIo3RToumwut6aTCJgE2koN2jz0y6slE+MqdWeiqUq4GTFQSnRnrbbQEjI4MzEqD/5lcF5Mn9JP9HVeoW27CWIl1LZSLheC35YJ3Bw+sIxh5R2/VPnM84mkFDqpqgh0LZlxoP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=eECe/2Q5; arc=none smtp.client-ip=140.205.0.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724853106; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9u5p5kx6uh3e0Bb5YhuSL84dXaiVoWyd0IYSs5o/yK4=;
	b=eECe/2Q55poMjMk/iHx15sLcWts73AVp4ZJYmE/54eX33GPzvzo5QwXrXuoaguUoTlmvWUmiQe/VbkRHejux3ZF6XUl9JdEAkDew2SpgdXoEZ/yxtqEajtV1ZKMF1W05R/Rp518+Vie7lrJjmI3ldYk4ez+slt3myFRw0r35wZQ=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z4l3S4N_1724853101)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 21:51:45 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs
Date: Wed, 28 Aug 2024 21:51:40 +0800
Message-Id: <20240828135140.1015940-1-tiwei.btw@antgroup.com>
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
 arch/um/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index be2856af6d4c..3cc2b663aa78 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -291,7 +291,8 @@ unsigned long __get_wchan(struct task_struct *p)
 int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	int cpu = current_thread_info()->cpu;
+	int pid = userspace_pid[cpu];
 
-	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
+	return save_i387_registers(pid, (unsigned long *) fpu) == 0;
 }
 
-- 
2.34.1


