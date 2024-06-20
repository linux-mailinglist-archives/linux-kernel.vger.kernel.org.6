Return-Path: <linux-kernel+bounces-222771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449C5910732
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42582856C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17871AED21;
	Thu, 20 Jun 2024 13:58:13 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06230358
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891893; cv=none; b=DP9Atv+ThmfaW3rkNWHF/Mc7TY78ODSR8Gs3n9tEeQpZP+LFgc3zDjqjYel2T/uLTvV+wYLorc2A2Dmdo+IdnJsy1f+53PoS+I50N/8iLiMblrcZz08A8ZKQWfUsw3qj76EKlsU6flILT+PRSZKtTWwJtJFrPKpdwdPKI4FzaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891893; c=relaxed/simple;
	bh=vSar+Z7TnbapZ0Ek8C9awGlUmi6eTI1UlprhvZF7kQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QDU7eDt/In5sUmqTJrrRKrHl3AERTUUdh/doI3jVTkJLJmCj5lgRirs8KEuhySDNvvdz8EiDtXjF1gWTqkKqcxB00wEn5+nK5paMthg3va+qiEHH0Il7sHd5EIWN7TN0cirjXYGIwZJgV9XyxwO1siX2+jry+nvVpMGZBq4X2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W4hmF25Dxz1N7vY;
	Thu, 20 Jun 2024 21:53:49 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id A2D1C140123;
	Thu, 20 Jun 2024 21:58:05 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemd200010.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 20 Jun
 2024 21:58:04 +0800
From: Zheng Zengkai <zhengzengkai@huawei.com>
To: <jason.wessel@windriver.com>, <daniel.thompson@linaro.org>,
	<dianders@chromium.org>
CC: <pmladek@suse.com>, <christophe.jaillet@wanadoo.fr>,
	<thorsten.blum@toblux.com>, <yuran.pereira@hotmail.com>,
	<kgdb-bugreport@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<zhengzengkai@huawei.com>
Subject: [PATCH RESEND] kdb: Get rid of redundant kdb_curr_task()
Date: Thu, 20 Jun 2024 22:21:32 +0800
Message-ID: <20240620142132.157518-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200010.china.huawei.com (7.221.188.124)

Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
removed the only definition of macro _TIF_MCA_INIT, so kdb_curr_task()
is actually the same as curr_task() now and becomes redundant.

Let's remove the definition of kdb_curr_task() and replace remaining
calls with curr_task().

Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 kernel/debug/kdb/kdb_bt.c      |  2 +-
 kernel/debug/kdb/kdb_main.c    | 18 ++++--------------
 kernel/debug/kdb/kdb_private.h |  2 --
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 10b454554ab0..137ba73f56fc 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -144,7 +144,7 @@ kdb_bt(int argc, const char **argv)
 			kdb_ps_suppressed();
 		/* Run the active tasks first */
 		for_each_online_cpu(cpu) {
-			p = kdb_curr_task(cpu);
+			p = curr_task(cpu);
 			if (kdb_bt1(p, mask, btaprompt))
 				return 0;
 		}
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 664bae55f2c9..f5f7d7fb5936 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -155,16 +155,6 @@ static char *__env[31] = {
 
 static const int __nenv = ARRAY_SIZE(__env);
 
-struct task_struct *kdb_curr_task(int cpu)
-{
-	struct task_struct *p = curr_task(cpu);
-#ifdef	_TIF_MCA_INIT
-	if ((task_thread_info(p)->flags & _TIF_MCA_INIT) && KDB_TSK(cpu))
-		p = krp->p;
-#endif
-	return p;
-}
-
 /*
  * Update the permissions flags (kdb_cmd_enabled) to match the
  * current lockdown state.
@@ -1228,7 +1218,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 	char *cmdbuf;
 	int diag;
 	struct task_struct *kdb_current =
-		kdb_curr_task(raw_smp_processor_id());
+		curr_task(raw_smp_processor_id());
 
 	KDB_DEBUG_STATE("kdb_local 1", reason);
 
@@ -2278,7 +2268,7 @@ void kdb_ps_suppressed(void)
 	unsigned long cpu;
 	const struct task_struct *p, *g;
 	for_each_online_cpu(cpu) {
-		p = kdb_curr_task(cpu);
+		p = curr_task(cpu);
 		if (kdb_task_state(p, "-"))
 			++idle;
 	}
@@ -2314,7 +2304,7 @@ void kdb_ps1(const struct task_struct *p)
 		   kdb_task_has_cpu(p), kdb_process_cpu(p),
 		   kdb_task_state_char(p),
 		   (void *)(&p->thread),
-		   p == kdb_curr_task(raw_smp_processor_id()) ? '*' : ' ',
+		   p == curr_task(raw_smp_processor_id()) ? '*' : ' ',
 		   p->comm);
 	if (kdb_task_has_cpu(p)) {
 		if (!KDB_TSK(cpu)) {
@@ -2350,7 +2340,7 @@ static int kdb_ps(int argc, const char **argv)
 	for_each_online_cpu(cpu) {
 		if (KDB_FLAG(CMD_INTERRUPT))
 			return 0;
-		p = kdb_curr_task(cpu);
+		p = curr_task(cpu);
 		if (kdb_task_state(p, mask))
 			kdb_ps1(p);
 	}
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 548fd4059bf9..d2520d72b1f5 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -210,8 +210,6 @@ extern void kdb_gdb_state_pass(char *buf);
 #define KDB_TSK(cpu) kgdb_info[cpu].task
 #define KDB_TSKREGS(cpu) kgdb_info[cpu].debuggerinfo
 
-extern struct task_struct *kdb_curr_task(int);
-
 #define kdb_task_has_cpu(p) (task_curr(p))
 
 #define GFP_KDB (in_dbg_master() ? GFP_ATOMIC : GFP_KERNEL)
-- 
2.20.1


