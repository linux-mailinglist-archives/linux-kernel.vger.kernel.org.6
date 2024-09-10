Return-Path: <linux-kernel+bounces-323967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D9D974632
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F6328842A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332211AAE34;
	Tue, 10 Sep 2024 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCSntRBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46817B4FE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009264; cv=none; b=umH0KvjrVpvaQZMF9g/vbbJAPHlKa3EHtaArHTro8PL15kgdVFHx7b4KofMWgAMOFxQfM/g2JAitDxJ9GFM5+NMmn12kHQquRNJbvq/Rqd+0B7f4FZK2G7XzJiGx+RpTgPpdVzk6TpT4rLgSVwBLbGvXXcKGODUo8o1vfAoTLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009264; c=relaxed/simple;
	bh=qC5KTazQjcvshFpSR9Bzc4qHBHR8bkjSdpCkXbdaHdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Oe81izIcyGJIANMAI0t03SOF7/AHgj9MmQqfRcEh5UxDBBi89lTCa82A6D06GwuyRqoKT7bYja/4zXaITp4u89G0rCjOt0xplaqwTnBhyna0eS4Ltw84khjNvYgCEbqHE7Y2CrokhkUz5PaSKeDqkZchPxX8oIPQMXPi3dlNa9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCSntRBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546B8C4CEC3;
	Tue, 10 Sep 2024 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726009264;
	bh=qC5KTazQjcvshFpSR9Bzc4qHBHR8bkjSdpCkXbdaHdM=;
	h=From:Date:Subject:To:Cc:From;
	b=NCSntRBHf/6E+IFS67dpfQdSWaBBseiZae0h0cwMF+mx5DbF/1RX9sEUymADuSdBM
	 0CO2P1MbwLJRB6r4wkGFcjfL3iGMIHI99c1X56jPOjNvKs+tzn/lY7TBHvaLe/jU+f
	 IZ0fucJecVJR5Gm4I2J+CjjblS5z/c4s3L9k2Z6pRwc1wwJgtAXIyH2mZhWfX+ndbG
	 BolPNQ4r8EGQHO0+CaXS4wPwYsbu+0A3wv5+e1hrZgWBjlFW9kkyC6bJmsIyU8DGzH
	 RTEY6UjNc9W/5MkCbI6Zrl5BYWUdHbvOWGusjWxphoR9RIsGQg9kJlvh6st3V5ftLL
	 sctXyP4zQySxA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Sep 2024 23:56:53 +0100
Subject: [PATCH] x86/shstk: Free the thread shadow stack before
 disassociating from the mm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-x86-fix-shstk-leak-v1-1-43cef0c56b75@kernel.org>
X-B4-Tracking: v=1; b=H4sIALXO4GYC/x2MQQqAIBAAvyJ7bkFNpPpKdBDdaikq3Igg+nvSc
 WBmHhDKTAKdeiDTxcL7VsBUCuIctomQU2Gw2jrdGo1343HkG2WWc8GVwoIhJV/7aJImByU8MhX
 jn/bD+3403loFZAAAAA==
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Deepak Gupta <debug@rivosinc.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=4122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qC5KTazQjcvshFpSR9Bzc4qHBHR8bkjSdpCkXbdaHdM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm4M+sgm4BDnwKct9XaZABtimrGRdnuiaMoexCyLjI
 Xc3umYKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZuDPrAAKCRAk1otyXVSH0DnkB/
 oCH4mMSvPC8EkbLdPvoTMIbYKrzbEZv4Skd0WaodPPFGeQd+799VPfCVa0pfZsLS/GZjIvn7I8Dkrn
 sJGfHuTWFr/yvS/wn6le7/c3EbUy46dRwPddgRoKux7RZedCjz1RQm3+/T75SNBX/G6aqCOa1cB13N
 AVMAmnq0GMPxJzjHU9bOmCYFkHF6aXRaZhv+WK+xkkebBAAT3Ipv1cYg6QsH6n2X8L/JtBOfE8Jz2Z
 DAMe6nT3mLSg4f97KdRJ5sg9AUfFLY56PsmHugYAJDrOfH877xipMLUOYoSBJEJiX6S3qOtbbej4eN
 i+4LXre8qK8aIQN7+si0UE/tgWcVXl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When using shadow stacks the kernel will transparently allocate a shadow
stack for each thread. The intention is that this will be freed when the
thread exits but currently this doesn't actually happen. The deallocation
is done by shstk_free() which is called from exit_thread() and has a guard
to check for !tsk->mm due to the use of vm_unmap(). This doesn't actually
do anything since in do_exit() we call exit_mm() prior to thread_exit() and
exit_mm() disassociates the task from the mm and clears tsk->mm. The result
is that no shadow stacks will be freed until the process exits, leaking
memory for any process which creates and destroys threads.

Fix this by moving the shstk_free() to a new exit_thread_early() call which
runs immediately prior to exit_mm(). We don't do this right at the start of
do_exit() due to the handling for klling init. This could trigger some
incompatibility if there is code that looks at the shadow stack of a thread
which has exited but this seems much less likely than the leaking of shadow
stacks due to thread deletion.

Fixes: 18e66b695e78 ("x86/shstk: Add Kconfig option for shadow stack")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
It is entirely possible I am missing something here, I don't have a
system that allows me to test shadow stack support directly and have
only checked this by inspection and tested with my arm64 GCS series.
If this makes sense it'll need to become a dependency for GCS.
---
 arch/Kconfig               | 5 +++++
 arch/x86/Kconfig           | 1 +
 arch/x86/kernel/process.c  | 9 ++++++++-
 include/linux/sched/task.h | 7 +++++++
 kernel/exit.c              | 2 ++
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..2fa3aedc1d23 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1037,6 +1037,11 @@ config HAVE_EXIT_THREAD
 	help
 	  An architecture implements exit_thread.
 
+config HAVE_EXIT_THREAD_EARLY
+	bool
+	help
+	  An architecture implements exit_thread_early.
+
 config ARCH_MMAP_RND_BITS_MIN
 	int
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..916616026111 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -225,6 +225,7 @@ config X86
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
 	select HAVE_EXIT_THREAD
+	select HAVE_EXIT_THREAD_EARLY
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd00a91..af3cabe08185 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -110,6 +110,14 @@ void arch_release_task_struct(struct task_struct *tsk)
 }
 #endif
 
+/*
+ * Free thread data structures etc..
+ */
+void exit_thread_early(struct task_struct *tsk)
+{
+	shstk_free(tsk);
+}
+
 /*
  * Free thread data structures etc..
  */
@@ -123,7 +131,6 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
-	shstk_free(tsk);
 	fpu__drop(fpu);
 }
 
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d362aacf9f89..cbafc6ba4e3e 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -88,6 +88,13 @@ static inline void exit_thread(struct task_struct *tsk)
 {
 }
 #endif
+#ifdef CONFIG_HAVE_EXIT_THREAD_EARLY
+extern void exit_thread_early(struct task_struct *tsk);
+#else
+static inline void exit_thread_early(struct task_struct *tsk)
+{
+}
+#endif
 extern __noreturn void do_group_exit(int);
 
 extern void exit_files(struct task_struct *);
diff --git a/kernel/exit.c b/kernel/exit.c
index 7430852a8571..bc2c2a3da9fb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -866,6 +866,8 @@ void __noreturn do_exit(long code)
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
+	exit_thread_early(tsk);
+
 	exit_mm();
 
 	if (group_dead)

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240910-x86-fix-shstk-leak-add636c1d0e4

Best regards,
-- 
Mark Brown <broonie@kernel.org>


