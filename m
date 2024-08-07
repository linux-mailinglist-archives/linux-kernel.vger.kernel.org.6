Return-Path: <linux-kernel+bounces-277239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D5A949E48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11A1B23A11
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B172116D33A;
	Wed,  7 Aug 2024 03:31:03 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5092A1CF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723001463; cv=none; b=dr4h2hy/X47u2q5okbkMf2vlD9eI2cxeWOpfmhfxJdWm35ZEtIIRohEqK/LZpVDlSPDGq8QeGr2/SHELSeyjxZhcxw94VV020WO831wgU8UwfUFfHbVzlOUE/1uPHfrguaQewMO2Gw9et3vlYBoC0Osp72ow4tl7XveL+B+bU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723001463; c=relaxed/simple;
	bh=4rXWRUAjfP9qmxJTCRSAlmpJwsky84QeRRGkZpPqtVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GXJsuHPM+MlvjD76f7EiyMifZlk3Hu+XxLWDy4t7NopQgnUyBXNtE3T2QUZDYBjyzZ5vxHq1Q57gjQfUFrBGKnzs7+0x9uUdDahG5lT/qN/tA/aYHj2g0zKdorCJ17Lzutk16E6uOtgoN21k0wxULasvDIuK8u6NRE7cm7HZKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sbXJM-000000005S1-41om;
	Tue, 06 Aug 2024 23:26:04 -0400
Date: Tue, 6 Aug 2024 23:26:04 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86,panic,nmi: use trylock when taking the nmi_desc lock
 from NMI context
Message-ID: <20240806232604.36e963fd@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

When nmi_panic runs on a system with kdump enabled, the kernel ends up
trying to take a spinlock from NMI context. This should normally succeed,
since NMI handler registration is rare, and panic has its own locking
mechanism to make sure only one drives the kernel panic.

However, this spinlock will still make lockdep unhappy, and may result
in the lockdep splat hiding the actual source of the underlying panic.

[ 39675.176729] WARNING: inconsistent lock state
[ 39675.176734] inconsistent {INITIAL USE} -> {IN-NMI} usage.
...
[ 39675.176817]        CPU0
[ 39675.176818]        ----
[ 39675.176818]   lock(&nmi_desc[0].lock);
[ 39675.176821]   <Interrupt>
[ 39675.176822]     lock(&nmi_desc[0].lock);
...
[ 39675.176866]  <NMI>
[ 39675.176868]  dump_stack_lvl+0x3d/0xf0
[ 39675.176874]  lock_acquire+0x1ac/0x290
[ 39675.176879]  ? __register_nmi_handler+0x4f/0x140
[ 39675.176889]  _raw_spin_lock_irqsave+0x5a/0x90
[ 39675.176896]  ? __register_nmi_handler+0x4f/0x140
[ 39675.176901]  __register_nmi_handler+0x4f/0x140
[ 39675.176905]  ? kdump_nmi_shootdown_cpus+0x20/0x20
[ 39675.176915]  nmi_shootdown_cpus+0x6a/0xe0
[ 39675.176922]  kdump_nmi_shootdown_cpus+0x11/0x20
[ 39675.176928]  native_machine_crash_shutdown+0x46/0xc0
[ 39675.176936]  __crash_kexec+0xe4/0x120
[ 39675.176948]  ? dump_stack_lvl+0x3d/0xf0
[ 39675.176951]  ? __crash_kexec+0xce/0x120
[ 39675.176957]  ? panic+0x134/0x380
[ 39675.176967]  ? nmi_panic+0x27/0x40

Since taking this lock from NMI context should just succeed
anyway, use a trylock to make lockdep happy.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/kernel/nmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index ed163c8c8604..b7f759bb28ee 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -171,7 +171,17 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 	if (WARN_ON_ONCE(!action->handler || !list_empty(&action->list)))
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
+	if (in_nmi()) {
+		/*
+		 * We cannot take a spinlock from NMI code. This can happen
+		 * from nmi_panic. Only one CPU can panic, so the trylock
+		 * should normally succeed.
+		 */
+		if (!raw_spin_trylock_irqsave(&desc->lock, flags))
+			return 1;
+	} else {
+		raw_spin_lock_irqsave(&desc->lock, flags);
+	}
 
 	/*
 	 * Indicate if there are multiple registrations on the
-- 
2.45.2


