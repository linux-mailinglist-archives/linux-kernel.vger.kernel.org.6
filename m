Return-Path: <linux-kernel+bounces-327510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1499776FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7889328664C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353F01B12C2;
	Fri, 13 Sep 2024 02:43:14 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818914C96
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195393; cv=none; b=OGJgC/JSN/64tptf68tVUO7QSv/nYL1RAE0Jjon+xf3s6PLHHs2b/SE3UTwBhKFqEndbfBYzM8oT8ftcwX/aDjzTbq5YZwp/HfB5KhxOdpeUGR+3MDax3/kMGu27adMj/eVdl8mBPHn6dT2WAYqt+lq1du+tH5GXsMuZxV6zr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195393; c=relaxed/simple;
	bh=oW27Er2VYykDwi2Wa3wMNkFR78s1xCb19EHjL3ZrObQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kJYBwwjPmX0kNpLOhoWif5Xx6TbSzXT+xQXz7KtOkEoqteqLkaEmU1mPi9r3OxE1YVyPiNjOII6/GdlmmqydpwaMoUro6b3FePqxJMJju6s/6p1M3kY8K1mzq/uW9/xsg+le/TkeDargHvy21EsaTkUg6m/3va44mFnc9KIDCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X4drg5c4vz4f3jHf
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:42:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 217021A183C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:43:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP1 (Coremail) with SMTP id cCh0CgDnES6vpuNmja6LBA--.33377S2;
	Fri, 13 Sep 2024 10:42:59 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	brgerst@gmail.com,
	samitolvanen@google.com,
	kees@kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhengyejian@huaweicloud.com
Subject: [PATCH] x86/unwind/orc: Fix unwind for newly forked tasks
Date: Fri, 13 Sep 2024 10:45:01 +0800
Message-Id: <20240913024501.1337327-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnES6vpuNmja6LBA--.33377S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xJw4fGFWUKFyUKFyfZwb_yoW8Ww17pr
	Z8Gr9IgFZag3sYvr9rJ34I9rykCrn7tw1UKrW7G343C3W7W34xtryYvayDJFn0qFykJrn0
	krZ5W34Ygws8CFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

When arch_stack_walk_reliable() is called to unwind for newly forked
tasks, the return value is negative which means the call stack is
unreliable. This obviously does not meet expectations.

The root cause is that after commit 3aec4ecb3d1f ("x86: Rewrite
 ret_from_fork() in C"), the 'ret_addr' of newly forked task is changed
to 'ret_from_fork_asm' (see copy_thread()), then at the start of the
unwind, it is incorrectly interprets not as a "signal" one because
'ret_from_fork' is still used to determine the initial "signal" (see
__unwind_start()). Then the address gets incorrectly decremented in the
call to orc_find() (see unwind_next_frame()) and resulting in the
incorrect ORC data.

To fix it, check 'ret_from_fork_asm' rather than 'ret_from_fork' in
__unwind_start().

Fixes: 3aec4ecb3d1f ("x86: Rewrite ret_from_fork() in C")
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index d00c28aaa5be..d4705a348a80 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -723,7 +723,7 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		state->sp = task->thread.sp + sizeof(*frame);
 		state->bp = READ_ONCE_NOCHECK(frame->bp);
 		state->ip = READ_ONCE_NOCHECK(frame->ret_addr);
-		state->signal = (void *)state->ip == ret_from_fork;
+		state->signal = (void *)state->ip == ret_from_fork_asm;
 	}
 
 	if (get_stack_info((unsigned long *)state->sp, state->task,
-- 
2.25.1


