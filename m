Return-Path: <linux-kernel+bounces-444539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54209F0887
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289B9162FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65201B6CE0;
	Fri, 13 Dec 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aoEpoMFi"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2221AB52F;
	Fri, 13 Dec 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083555; cv=none; b=l8z7homUZ2eLCQwrNQghXVmNT3cJ04TqOfxGL3Ldd2tVqwLMN3My9O6TIsff/YY4P+sLnL4aKUSd7RLUV2EpBykHaHCKyr3XJcNjHIzG/DJxrbQaJaXkZ57m1bYfQ4DXAI/fIRE5ikyjTWbHTIlx+QlkqGzVmer4y7W0KVUOupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083555; c=relaxed/simple;
	bh=cd9NqLOijTRwdCaVc8DRWAeAFgI2q5TadgwL4zJRbok=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=O+ba/d2rMi3aWyUPqzq5VcV51XgG4VfMLGyxiRqBQjBRegUctOi9UbzSgyo01s9nnEDQSURX0n2uXornztynSqkkC/FPdt4YyOvoJ39tDZlaFVc3aFN7C4AJTkWb1WbvTdgJK10i2QcLErF7Glb0R7yRhMYPH0iYog0OJGpdUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aoEpoMFi; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734083540; bh=TVPhRNZsc0KVZKByo5SwHRZxFBB8+plO/AoY0SJ/5mc=;
	h=From:To:Cc:Subject:Date;
	b=aoEpoMFil/A7cCyY5gaQ2vF3TeDcfWhDGVAlwZYrMBe6WmwQz9w+Vqsmca5E/m3oi
	 STAlbOAAiq7nbkphAGfB1cCvuL+lkqCspldFIdCU4bZOl7dSDiBGp5T04FHc1Z1NMd
	 1FderU2h86YfoHDWfx1F6cWIrRIOjSS6drRys9Ic=
Received: from localhost.localdomain ([101.90.54.94])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id D1039039; Fri, 13 Dec 2024 17:52:16 +0800
X-QQ-mid: xmsmtpt1734083536tg2s9yevf
Message-ID: <tencent_50D7C8F43461B5F8CF055C15970A1A36C305@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Ju4eIjdW+r/kSs2qIIentIBpbxDXUiMizGA72YU7ZWgMMsOe6oUJ
	 fzdXFV4nRGzKbcXxJ2aIwuy+4PuZXwW8t7hMlXiBukPL+RuhvChkFfk05zhqsPtnKD8E1NaQ+mew
	 cYNINJHjetm9WMAAO3OhYTpM4LAMi/E/oik3mnRDe8es2GvSWjHDpB18Je6iPackWF7/+S3ewPwR
	 ZJMuV4y7eXIOTbsUMO4GRb0hx4sIP9sGLoOsV1Cg/qZecIr87Aisu6tjHOuAvfc9Bhl4iH7QxWHX
	 oM2NYp4xa3vMxdHS5S7YLaGlkcTrNvYyp0KCSGSRl3mIwkZrskxI1z52091pz1ksfJ6ygb8w9/mv
	 zhsLLiTus3pEP7YbQ4lOFg+Q6bPClFM/SOwrGUl2DH6rlE3E+Eym8XPieYBNBwcB8P/Q00Mueyfg
	 PuMl6s4+FxtwtyaQAwR/VFVjYEgmVJFoj0ze0NfrOCuM97LM2IrYJXYz80I07up1han5nPd4Cb91
	 LxPnkOropEH0ZmbA86/v5YZ2RSzxFdPQwclygS8M/LJCTJ4yIl33ZY1gg3VuGizB0L31SfQ4z1Xz
	 MWBr44dklXEt8CJqt108TJBu0TQkJvIOIAifIwTrCAiJzDXs99dG4BE7Cwz/NXxJ48DesSMOWEt4
	 qAdJ6CU4MRdxjalZR/qU0YX6LaO4fvR7jgUs+R1snmp8kaHqnYsdCGQ9zIr0tTEnPj8akAE9hVls
	 H188niamYBjz7tPTE2ZoH1+grOxSs+yXvTapdEc+vzKxxo4vk1mC5Cp/RCe2VS4qArS5i8dEasfp
	 XAKxMe8ZK3eSyQwPsu5EztPhGTJJcJjPn3rE8AYdkkM9kSeeTVdbBZ8eFzbHsjZ3hXnDvsgkKVqj
	 mlHWsRuswRKzInwZE8YHqjZeeBVm8WQaxwOYWS7GNRLtt/jjOJnfLLd9nohE6b0FoWQNPwpA/9n8
	 JY/phoY47RJD8pVaVfcgiKcMzSRD9i+m4w6310x5AFdXyUVc2DEdzJDm0KhRAlhHpIrbTQepP/gp
	 hl3T/Eh0Dz/8A0AuEPeREJXoeHSiHj3clMHV1wmw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Jianhui Zhou <jianhuizz@qq.com>
To: corbet@lwn.net,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	jonaszhou@zhaoxin.com
Cc: thuth@redhat.com,
	rostedt@goodmis.org,
	david@redhat.com,
	victor@mojatatu.com,
	andrii@kernel.org,
	xiongwei.song@windriver.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianhui Zhou <jianhuizz@qq.com>
Subject: [PATCH] Documentation: Remove the outdated prompt under cgroup_disable option in kernel-parameters.txt
Date: Fri, 13 Dec 2024 17:52:15 +0800
X-OQ-MSGID: <20241213095215.5091-1-jianhuizz@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disabling options other than memory is currently
supported according to the cgroup_disable function.
So it can be removed.

Signed-off-by: Jianhui Zhou <jianhuizz@qq.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3872bc6ec49d..3c562653016f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -609,9 +609,6 @@
 			- if foo is an optional feature then the feature is
 			  disabled and corresponding cgroup files are not
 			  created
-			{Currently only "memory" controller deal with this and
-			cut the overhead, others just disable the usage. So
-			only cgroup_disable=memory is actually worthy}
 			Specifying "pressure" disables per-cgroup pressure
 			stall information accounting feature
 
-- 
2.25.1


