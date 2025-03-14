Return-Path: <linux-kernel+bounces-561763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB8CA615DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835FF3BE4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4C2046A7;
	Fri, 14 Mar 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oUvGicU9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BKlii9JD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433FF202F95
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968500; cv=none; b=V3ORvESDUzKY8zctB90MEJvn7meyPLMeXVLzRHjr4pb+sHDFLqy7Pdots2wgCYh5iJ5IQ643KDNCWLL/x57Uns1sy+NuOLOCvfQn/UCTo06xQpoAgfJaKEOPRE15c/xWuTEn1PrbUBzmewLhik3b0kmcV2deMbEvdH9lECWsfag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968500; c=relaxed/simple;
	bh=oQzX+7nGoxhkL+yQVBL7r8HDvb37Hr/zFK9BLTl9xrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZLILO2bSjkuTgFZwHwYx+YfxcmWKrq1BQR6jjdQ2Jwsrbhl/dxJjZPNIg6g+z3XJn82VOXxVFLksbu47vJAcIsN513f5yOmGLQWOSloE4xysUyhTJuK8rcHKCid4/mE2AwE9bzHkI2ug0FIRna7wun5MVVxcFcq+SrtF+69ePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oUvGicU9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BKlii9JD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UThOL2xYE+zlzWKKbLr4gFZbbNJ4JtHESm/nz/q22I=;
	b=oUvGicU9EzvDhQw6mwbX6KaWnwK85wGS1FqPabwF0NiVNPAIGHBx6LELfdu02mi4glujPm
	eolrnSGgQ7aoFzpdUkQwS/VN7Z25xOGvggToNLYhR4YEbuA79BU1D6PJmqtvGRmQFVIQ4e
	LKc6i51kdpZoP7fAFIAVgUFuP3VWMPZNe+kYoW+wgNifmq+7kYeS/QrCTEQpoEiilZ+f68
	QEW3WPnuOpiZRyh2NDsyzdZkWTyOmlUTXwr6cgEBqNEDeYV80+HVhajnFj4dZJTcZoNqX1
	DTsK2A1xouiZfunNcBz5zevTeJ9P3GY+g7sgstTKzqY8P8plPZurQeeQC1Sw9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UThOL2xYE+zlzWKKbLr4gFZbbNJ4JtHESm/nz/q22I=;
	b=BKlii9JDzCL1dJehRa3nId7N9nVNEeOzD6QG3T8tFCBuRpP4qdEZBdFXR1kby22VnhG37q
	NXHPULtxuG4UCeBQ==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 5/9] powerpc: Rely on generic printing of preemption model.
Date: Fri, 14 Mar 2025 17:08:06 +0100
Message-ID: <20250314160810.2373416-6-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the first printk in __die() there is show_regs() ->
show_regs_print_info() which prints the current
preemption model.

Remove the preempion model from the arch code.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/traps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index edf5cabe5dfdb..cb8e9357383e9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -263,10 +263,9 @@ static int __die(const char *str, struct pt_regs *regs=
, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
=20
-	printk("%s PAGE_SIZE=3D%luK%s%s%s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=3D%luK%s %s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=3D" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
--=20
2.47.2


