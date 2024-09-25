Return-Path: <linux-kernel+bounces-338554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2A985A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E121F21271
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096061B29CD;
	Wed, 25 Sep 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmS3VT37"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641131B29C1;
	Wed, 25 Sep 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264495; cv=none; b=r1Me4Gjfs7PlI5xpYG0cVw2BM4wFKfEj08BqPgECcjtiiMhfeC8sWd6AP5JPvziZtsS8Of4Evu04GO5p2XofiL7zW/bjkc+AF2/EF0a+AGEkLcnJ8NF8T50pTXO7A1Xjti37orBFLYshDhwr9j9b0gcXM32rFtZzPYDGSf0nO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264495; c=relaxed/simple;
	bh=ZYESEMUpErJ4ayIMU3hPmisXks/BT9GQ4NHkdXkKUlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDobW30Yuzq/MTyQTRZY/tPNpJEafP/sL3qWCmskrp26Itr2mBTvoOgZHpeZYCFtLFxLWfZvYdczwVmZi/kzTF1dVYDFH5PjqHl+a2dAdqpLXShceHHLiKNIP8vHKsDUrYXBRI4fZFnR379JyJVBBz5XnZcbLJnbESbq/mrGwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmS3VT37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A062FC4CEC7;
	Wed, 25 Sep 2024 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264495;
	bh=ZYESEMUpErJ4ayIMU3hPmisXks/BT9GQ4NHkdXkKUlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MmS3VT37yDiqgrF95kCX8+EF+kFBM4f6h+mNy5AzGQ3pfxtj4tBeXDq3utqOhL0CC
	 rhEVKaz9wPRq4QMPphCE4fHGU+DBNuCtK5iDbqpza3yIQB7+1lpuRhb/PWmdymPVxi
	 kdw1yQIojpwQnoKzm59yNBWti52sgqJ98IXc10l06t/yEgrQO4+VHixgz6u2aGrY1b
	 dyDa/jrV4ApNa4JS6rxZfxq91mODFpqh8WlqPqfuW7vXebOwyUvxC6HNafcR8ZoV4N
	 otRxmicITnbJPknZN0t/DjIlXA7vZ1qZe0qC9TR54Tn4MLaf9UYIgEmEADlyLEb7E+
	 qmmJrao2NDiZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	hjl.tools@gmail.com
Subject: [PATCH AUTOSEL 6.11 102/244] x86/pkeys: Restore altstack access in sigreturn()
Date: Wed, 25 Sep 2024 07:25:23 -0400
Message-ID: <20240925113641.1297102-102-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>

[ Upstream commit d10b554919d4cc8fa8fe2e95b57ad2624728c8e4 ]

A process can disable access to the alternate signal stack by not
enabling the altstack's PKEY in the PKRU register.

Nevertheless, the kernel updates the PKRU temporarily for signal
handling. However, in sigreturn(), restore_sigcontext() will restore the
PKRU to the user-defined PKRU value.

This will cause restore_altstack() to fail with a SIGSEGV as it needs read
access to the altstack which is prohibited by the user-defined PKRU value.

Fix this by restoring altstack before restoring PKRU.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802061318.2140081-5-aruna.ramakrishna@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/signal_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 8a94053c54446..ee9453891901b 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -260,13 +260,13 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-	if (restore_signal_shadow_stack())
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
-	if (restore_altstack(&frame->uc.uc_stack))
+	if (restore_signal_shadow_stack())
 		goto badframe;
 
 	return regs->ax;
-- 
2.43.0


