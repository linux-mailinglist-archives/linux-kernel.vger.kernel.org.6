Return-Path: <linux-kernel+bounces-511184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F570A32759
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD4C188B09D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A730211462;
	Wed, 12 Feb 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DpvM/XPK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IqK5X32R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829620FA84
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367698; cv=none; b=l0vlp2MNvqBruDG38KaOPJn543HJUKNN0rO/sz0J+vK2Zk90AAvj5q6ITiDz4KMWostt2+M34fPAxCgSfRD4ZAMKn1BQaFyy09Q70cvSsv/XKwvrsoG+aziq8N0pMjrKtuzNisqo60hSkfGRpAr+K/0La17sXz57Jhx+YaMQRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367698; c=relaxed/simple;
	bh=hK1A6zIsrNJAovrrv0VlTMANs2MhQLrSeZf+N+Ilra4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYOB/VgURY3+MOT/a9XUHvgnXlunoA7rpZJZ9Er/JC3zNKOhYq5YStjv4PwXuvp+TdDAHPHFc/UX4+uJR1DlUlhVXm1yqCVAzBr2NnynuYUKzyMxvkv0eijKIMu6u3/gCQCaaQaJrQHY3exTcIVtc/OZHvCIX2rMcIdifiXoGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DpvM/XPK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IqK5X32R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739367693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1nmWywTWzJzDcPVwkzbvEHu1zvcPiY8k6qmYTOWby8=;
	b=DpvM/XPKgM376rMH3qIs5mYgJyPGTUARGF6ldxacLiujZFxe2fAIqz/txTYdOtDnAzifjo
	HRFw7j/AUphkFLiKgFW1727fIyD+xxR/QBTpmySZJZRNUBX87n5Rcbfr5EiMkMAwkpLHU0
	Djy9XC9upOHKTZn5vDYgkNrr8Us/7HuxpPESnNnm/KzHoweOu7Jtwj5vz2ATYZDQ3QnLZC
	D0AcCinSO35Q8xcz2VbDQh8uDbjFEvge41a6GR0hAtpq21FCP9RiIcG3sOgsRyQsn7Px57
	Dhw2mamu82G94XMludoK8qktpofO//0tsU+crWcEjwFJUIDTRC5UEnRCTHmpag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739367693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1nmWywTWzJzDcPVwkzbvEHu1zvcPiY8k6qmYTOWby8=;
	b=IqK5X32R2VC2aXTgncFrHDnROztJKexL1DvhN635Kz2aoQU7rlgJDoFRS9Q4dUhvHIhCmq
	+QfvwPA8tqSW0GBw==
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 7/9] x86: Rely on generic printing of preemption model.
Date: Wed, 12 Feb 2025 14:41:13 +0100
Message-ID: <20250212134115.2583667-8-bigeasy@linutronix.de>
In-Reply-To: <20250212134115.2583667-1-bigeasy@linutronix.de>
References: <20250212134115.2583667-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After __die_header(), __die_body() is always invoked. There we have
show_regs() -> show_regs_print_info() which prints the current
preemption model.
Remove it from the initial line.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/dumpstack.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index a7d562697e50e..91639d1e4ec2c 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -395,18 +395,13 @@ NOKPROBE_SYMBOL(oops_end);
=20
 static void __die_header(const char *str, struct pt_regs *regs, long err)
 {
-	const char *pr =3D "";
-
 	/* Save the regs of the first oops for the executive summary later. */
 	if (!die_counter)
 		exec_summary_regs =3D *regs;
=20
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		pr =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
-
 	printk(KERN_DEFAULT
-	       "Oops: %s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
-	       ++die_counter, pr,
+	       "Oops: %s: %04lx [#%d]%s%s%s%s\n", str, err & 0xffff,
+	       ++die_counter,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
--=20
2.47.2


