Return-Path: <linux-kernel+bounces-561765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A9A615DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28FB7AEB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1312204C1F;
	Fri, 14 Mar 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZvK6hJT5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yfl8hWwW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2121204582
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968501; cv=none; b=t90J4XtsI0xraoeHziBe8H1NRaR1c13jbN3zSCPTQgA2VLEZlGb/fpzPhHEkYDo2ieP6wmFwClFb7qOw2cqE5Tuh5IFUYs1nfRKgSBoRE+2cp49jmfdRB671ox2mwJx1+FmLne6UtQ+IUxy8A0Cwr1B8F6W4TcZRXqyF4GS0jiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968501; c=relaxed/simple;
	bh=gGb/OyT7jhkkZcgfbVXYiOC/FC+mlgfYhs9YSdsU7LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPHpEPY7QxCE2JeTvRRfkioC08vsak6tRubwTbwumvnUGLuAjXtT9srhp3X2CR1b7OhJd38rw/ZIvmhPBYB7fn0Iomg4V2s3XD1pJiWbXNAfdNpXM8a2DiIFap2m8TxFgx9ezLEdnaw1t+7HtfQh1ro+br/RZsTAnJ/dSrTcb/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZvK6hJT5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yfl8hWwW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq85oAGLNvsLdfX4aOkNtdAWkEjwBtePNGBdu04muYU=;
	b=ZvK6hJT5Vs73cBoJp4vzN1mh3DyHGy0kyDXs6pjiIdaU1Vy4IJeuYa5f6pl9M3V22bYu3t
	hLtm11jH0jJ+KCbTUPfb2wVKvAAwc+AL36AeeCHLbMz2S06WJZV4jqr/XytyeF1ECsY/Lh
	NxANFpdOqFCouLzQjJhGNL8SsPzt26ZJsp25MZZgsaZZ1jJwzfaWa7Ls1uC27W58DjY0+t
	RL7xvwSr5Ww06VjDrjjDSFEvBORvRNB/ngrA6l9jQvM9dCYvjaGQviJqsiVrmbXC2OsK/p
	Elxw+UrN1071rfz8d/yRi4g8iT4dhxIFPx6LTiIlRlQHp4djKiiuDialqaSnGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq85oAGLNvsLdfX4aOkNtdAWkEjwBtePNGBdu04muYU=;
	b=Yfl8hWwW/8QJwKVMTV3xsmihTq97WQohLm+RCs+mhEobWnS86MJbkFCgOp3VG/X10UkPXx
	gzGGBzgGzoYL8mBQ==
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
Subject: [PATCH v4 7/9] x86: Rely on generic printing of preemption model.
Date: Fri, 14 Mar 2025 17:08:08 +0100
Message-ID: <20250314160810.2373416-8-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
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
Cc: H. Peter Anvin <hpa@zytor.com>
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


