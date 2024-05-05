Return-Path: <linux-kernel+bounces-168932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2B8BBFE6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 11:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2604B1F217A5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD279CA7A;
	Sun,  5 May 2024 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaybnDSd"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8BD7462
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714899995; cv=none; b=EkXc5VR1rtw+aHoDugS+4+sWnrZSzPeIsdX2FvPa0NOBZjHj7T1R7tMoiexSODue8Qv2Szr5zEJZL7tKk+G+2bD2NAWI5PsR7OM4s149Y8yCOafF4dE75cCGpEpiSo37Nw0wOFSWPwENLj8iTafE+EgTMRy48PSTZVUlYii5Zu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714899995; c=relaxed/simple;
	bh=qdReb408ivPwxm66qLDD4/I7wrw/SuqJSwzuohf9igY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qkp7OCD45K4W1OiyaXfyOmdjh+2+BiNqFt2Z5ZdNIi1oy5fn8QJ/OKd5jnoDL04wALLAD6c1vQAwPXQLCKVgRpNu8TmdLSSKoY+oN547MctZ6x2dyPtO0D9spuj4Ko7KQuHM9/qljXOOg+U0LuoPe3jbtcJHsA2Dp/EGgvwsh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaybnDSd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59ad344f7dso140276166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714899992; x=1715504792; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NqnhFoMuJwmpFt3ZxxBv08O79AyxDAnpNsiQ/YPbRPA=;
        b=KaybnDSd/uBXJED0gmGhKtAquW6SYWixfrYk5WDh6kF+Z5XL+z5JGLLPNV/TpgN1Je
         0313XP/i99CzKH7rejgkLdR9faJVcKcuMgCUEFlcv68mL/mrJDw0JcyNA5XUfqvJ/psz
         V20VI9iHkkyKTK3YTlEv0yOnJ0dgllTIEWOTcqd2E5QsTN5pTgHNRi+tAudnXLcFQZpg
         POK65syTtSoTg1js0fmTOml3w7P8pQhBPh7rdcozQ5pPFEFYLVgbW63tagaH7tgy87sR
         /Djkn340TA3XEE7KSff+P9WRKQ2JpreWmFRqkxX8UvD/7DMtz/9pND0bINFrLGaiVubD
         DHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714899992; x=1715504792;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqnhFoMuJwmpFt3ZxxBv08O79AyxDAnpNsiQ/YPbRPA=;
        b=cKyNf9BCO7tLE7eKlZISYKiJJQ+bIdnCoaz5ht4gjXCqCDfQW0S70Z3gxmlbiMuruK
         rMtYT6KKv0IL5p5PqApUOhymUzLran3LD+unJfpmG7x+uSHNQI11ps2jmdD5pQWW0Jtm
         bReIe7v6Gm2V1MQO3ArJXA2JQjdPjC9LV37fbqHN2ph47AGJqmHIi2Pb0zdRNbzWwhnN
         aNi2irDxLhGPiJrkAI8HctJgLBcoN1MJseK+UPG5yB7DOnIFZ8ePihN5IHYZrUmNNoPi
         sxRPkMJop4srjVk1MJZ33pOZlWWO6o8Gu5bXggTb+QKRA9SE0uXNVsc4/mP5FxipQ+4y
         sc7w==
X-Gm-Message-State: AOJu0Yyl9q20GG8vC/TDrWBRW4BuPjAhufS589b4O9r7RLPYmBDVtUjI
	K6a/AkIYu8LH2Bw6b6Sv6ysT34n4aFvq7yGGDv0D4FVdgQdftuyW
X-Google-Smtp-Source: AGHT+IFW7DLVZnMkMyptlpXf4g/P8g05ojjCqOzl2llnVV7NYFlH+mr1gVubAxf83sfnJKw+oBEnFw==
X-Received: by 2002:a50:9ea9:0:b0:572:459f:c7a1 with SMTP id a38-20020a509ea9000000b00572459fc7a1mr4376483edf.16.1714899991310;
        Sun, 05 May 2024 02:06:31 -0700 (PDT)
Received: from gmail.com (1F2EF54C.unconfigured.pool.telekom.hu. [31.46.245.76])
        by smtp.gmail.com with ESMTPSA id fj20-20020a0564022b9400b00572336c900asm3797550edb.74.2024.05.05.02.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 02:06:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 5 May 2024 11:06:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL] IRQ fix
Message-ID: <ZjdMFHuNHvUrncEv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest irq/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-05-05

   # HEAD: 1dd1eff161bd55968d3d46bc36def62d71fb4785 softirq: Fix suspicious RCU usage in __do_softirq()

Fix suspicious RCU usage in __do_softirq().

 Thanks,

	Ingo

------------------>
Zqiang (1):
      softirq: Fix suspicious RCU usage in __do_softirq()


 kernel/softirq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index b315b21fb28c..02582017759a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -563,8 +563,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -584,6 +583,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
+asmlinkage __visible void __softirq_entry __do_softirq(void)
+{
+	handle_softirqs(false);
+}
+
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		handle_softirqs(true);
 		ksoftirqd_run_end();
 		cond_resched();
 		return;

