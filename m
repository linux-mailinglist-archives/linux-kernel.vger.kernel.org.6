Return-Path: <linux-kernel+bounces-393782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5446D9BA522
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 11:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013881F219E7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5514517A92F;
	Sun,  3 Nov 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P17cl3jP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ijbateEC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8C1714D7
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730629872; cv=none; b=KpQEVNYM4P/M/5moPZwvaVSipw5CnCIJ4ksDeeYlZJH9hifbExOX/xyizSjWuLvgwocT4OqtUYYuAR8FyIR9cQ1Sxl32wuTLcGM7heF9mYOaZqzVL7+JeuaT06BNj4TxRBmQTwkry2DPudmL/COtszz42rKPZvazal8GEPJ6o5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730629872; c=relaxed/simple;
	bh=CMyZpnSnef6n2+QgdntbK9/hIxetONpq0mK00Axzy/Y=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=Juzp7azutR+COcXnf/CL9jypHJq/iExHCn+nEc1RBTelDlNoBQ38yL8hWxW8EnVIWfg8yX0MYBlBmjQtdYv3DaqNjPpJeBJE4AuUzB3zBIybQcajCZgtz1FULux1H2m04T4fP5B//IO4aVIJr3qQS4TYPPINAsj7qLm1w2T4oaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P17cl3jP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ijbateEC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730629864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=g7ZUc+0j9vI4lUaTsaXqfv4uKS/T+c2w3JxqTo/UFEI=;
	b=P17cl3jPDuN2njXpeFhs/qfLkg/JHHiX5+IH2O0ntj7G0SBKbwNBjzlzcA3hgl3ZZB00gx
	+PImDl/w9fwI06fBNfLQcyo5RpDJhRfk1N6X2tX97vpZ5ARrRwM9+UibKNsIcsiWcJjqMe
	p72p+UD3V36LtZiuC59UtdtnUKxX4rfb7k2Qh9gOTRB61/qyoB94KDZ2N+9nBN1GxZ1WMk
	8f8ec3eZWM2F1TGaa7XQgrxoWhyv/rmJpDVvEyZaTj8GNjMqwajERA61MxXiDpcsHBTB0+
	4s53XxXWBg8z6RxirO4ColZ97KVdj0fPaGBTSvwPqMgvTp25Fb/cose3BfsI+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730629864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=g7ZUc+0j9vI4lUaTsaXqfv4uKS/T+c2w3JxqTo/UFEI=;
	b=ijbateECIKTK64HGvJ/MWpcqjJkyOZgiWIL8ZzCAk5WT7+pER58bC8tkjNDyb133216v2E
	HpdllVnqDnEqByAA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v6.12-rc6
References: <173062982864.1467946.2540622433845043721.tglx@xen13>
Message-ID: <173062983343.1467946.18003860565104861128.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  3 Nov 2024 11:31:03 +0100 (CET)

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
24-11-03

up to:  b5413156bad9: posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clo=
ne


A single fix for posix CPU timers

  When a thread is cloned, the posix CPU timers are not inherited.

  If the parent has a CPU timer armed the corresponding tick dependency in
  the tasks tick_dep_mask is set and copied to the new thread, which means
  the new thread and all decendants will prevent the system to go into full
  NOHZ operation.

  Clear the tick dependency mask in copy_process() to fix this.

Thanks,

	tglx

------------------>
Benjamin Segall (1):
      posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone


 include/linux/tick.h | 8 ++++++++
 kernel/fork.c        | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 72744638c5b0..99c9c5a7252a 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -251,12 +251,19 @@ static inline void tick_dep_set_task(struct task_struct=
 *tsk,
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_set_task(tsk, bit);
 }
+
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_clear_task(tsk, bit);
 }
+
+static inline void tick_dep_init_task(struct task_struct *tsk)
+{
+	atomic_set(&tsk->tick_dep_mask, 0);
+}
+
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
@@ -290,6 +297,7 @@ static inline void tick_dep_set_task(struct task_struct *=
tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
+static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..6fa9fe62e01e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <linux/rseq.h>
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
+#include <linux/tick.h>
=20
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2292,6 +2293,7 @@ __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
=20
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
=20
 	p->io_context =3D NULL;
 	audit_set_context(p, NULL);


