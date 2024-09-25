Return-Path: <linux-kernel+bounces-338990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E9C985F23
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4224128874E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ABB21E2C5;
	Wed, 25 Sep 2024 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNZDq7S6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDE21E2E6;
	Wed, 25 Sep 2024 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266479; cv=none; b=NqWiHqhaY2R3eqIIWSW+OOdqSpqD1HcMs8Y/0skOfTOpKETIfyU7NpjTeURHB6DV9JLI/v/ZCHpzARFmgOhItJbUQvSfZ2tsbiIdG4YWIuTJAW93O9SO3vvvYX9Y0PUwTiHxeYdoAQTD6cZMPBPmp1LoSZ52uW37l6cAu+sdfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266479; c=relaxed/simple;
	bh=M+mgd4cM7OsGGfFdMBp3q+K3euJmfiR7jpjCRbxBjTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1pEQSG86Idmij2KqOfDlNfGR440oaTKVNoYxDyIEqh8fOFzexjMmuXd3jErbpxN2O5NA3O8MMpVrZYdCesTBdi19vg0bNwopXjZX6kKFQuSH1WgvQ2zkH/T9BTLFoMYw8F//BkcYWA8UulBzwohmN/xv5ykUBTuvaWgRtn+GVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNZDq7S6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48CBC4CECD;
	Wed, 25 Sep 2024 12:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266479;
	bh=M+mgd4cM7OsGGfFdMBp3q+K3euJmfiR7jpjCRbxBjTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNZDq7S6X7yDkOiLkb4r0KGsd0X6lDNqrvelDr5d0zpLDtbzaw1+Avz2Mr1T5/gI3
	 avpB9IUw3r6zTYkMQlHUs80jCpATdT3olCgOxhO52/XPmy+CXODtlv5yTnWYnz0ZHr
	 Lu4WnhJovSOB1QoeQKsgAohvSNHYFK/oW7cA4XIIxMj7G6StCXs1xLgwJM4T1hmBhr
	 SGSB/zqtpa0u9KjDFhtsXw6EVnjQPDXrtzKTuvvODIEDPV8gTS7TqkKCero+9Df4/E
	 KqwoUoUlxIUlN/stF0b4aHEWYa9LKRlN0WQ4WciEQMolurSzlLIZpOycp2qO/sJeb/
	 zwezOUGTpQUTg==
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
	hjl.tools@gmail.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH AUTOSEL 6.6 066/139] x86/pkeys: Restore altstack access in sigreturn()
Date: Wed, 25 Sep 2024 08:08:06 -0400
Message-ID: <20240925121137.1307574-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 23d8aaf8d9fd1..449a6ed0b8c98 100644
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


