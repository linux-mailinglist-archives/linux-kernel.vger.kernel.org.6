Return-Path: <linux-kernel+bounces-324633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F63974F08
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC44F1F22AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55801714DD;
	Wed, 11 Sep 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rf/G2R3n"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774FD14A606
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048171; cv=none; b=QE4pNsm6g74JkB4pKrTCgjyNi/8htDlDwih5BgGhZHkG4PJys3YTXHZDv2P/pkqP6TJC9/8IH4LmjRF22ZaVhpiltjzP4uf5PFrNOBYd+q6n6kWC22bhMAKW42v/+01eUv20jCnZv3N7ncBHQt0AIB/4yaYWzdZR15bMcrpiT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048171; c=relaxed/simple;
	bh=wJlGziGaumuOjH2y+e43xu9XYXx4HdOf46N28ylvc70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLwsAbHgAgXHY4DWvZNGQIiLe7BaemaCUjjuqoJUtcs1usq3tqFrJ1MOpX5QJnMaAKThQ3YPsma2oXzBZ3f/MsRwAQyPdla5Yau7L5rmKifeHxUT9NC92Vn9gVCsNhEJ+9DK7IT5fxht+tGMphZ9G5eQ++YjAX6RAEAZ3zF5l5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rf/G2R3n; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5i6kN7/7mt1CZQME4ohu+zmvdBkKCOjwhS59tzh3MUw=; b=Rf/G2R3nmHY44k+NYKebRLKEsL
	QaQ1erRxvC5TudsRzbxzgAify1ULGiygqHJmXiN44bxeAeTlKzX1Xe/4SuztCSNK+9wwrafO1fufR
	GBba5ZXb+CYtyESdmp7Mg+HQB9cEY3cA8ch79HEdGuX6CIlneEGjkWLORtlBfwqJQ3Du5ZitoA4X0
	DNx4pwSAVX412RPUz6wgvo5BImNSiRX0bW+sqPdmSVSWORO/OeQGAu44hRnPzvQN9m/cxngRilAPk
	xzxlCKllodV8Jp5qRrgxh/euPFWJcfrcxP9FISpr7ZIrbYCz7bIPGHi+NW9ZU3xc1OE0sIKdJ3i8k
	OhiuARMA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1soJyX-000000009Iy-3IZI;
	Wed, 11 Sep 2024 09:49:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6C434300642; Wed, 11 Sep 2024 11:49:25 +0200 (CEST)
Date: Wed, 11 Sep 2024 11:49:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PowerPC][linux-next-6.11-rc7-20240910] Kernel Warnings at
 kernel/jump_label.c:266
Message-ID: <20240911094925.GQ4723@noisy.programming.kicks-ass.net>
References: <ced64e0b-2ef7-48d6-b085-976aa878c017@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ced64e0b-2ef7-48d6-b085-976aa878c017@linux.vnet.ibm.com>

On Wed, Sep 11, 2024 at 12:33:01PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> I am observing kernel warnings while booting with
> linux-next-6.11-rc7-20240910 kernel. Below are the warnings.
> 

> 
> Issue is introduced by the commit: de752774f38bb766941ed1bf910ba5a9f6cc6bf7

That commit is now gone and should be replaced with the below on the
next next.

---
commit 1d7f856c2ca449f04a22d876e36b464b7a9d28b6
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Sep 9 12:50:09 2024 +0200

    jump_label: Fix static_key_slow_dec() yet again
    
    While commit 83ab38ef0a0b ("jump_label: Fix concurrency issues in
    static_key_slow_dec()") fixed one problem, it created yet another,
    notably the following is now possible:
    
      slow_dec
        if (try_dec) // dec_not_one-ish, false
        // enabled == 1
                                    slow_inc
                                      if (inc_not_disabled) // inc_not_zero-ish
                                      // enabled == 2
                                        return
    
        guard((mutex)(&jump_label_mutex);
        if (atomic_cmpxchg(1,0)==1) // false, we're 2
    
                                    slow_dec
                                      if (try-dec) // dec_not_one, true
                                      // enabled == 1
                                        return
        else
          try_dec() // dec_not_one, false
          WARN
    
    Use dec_and_test instead of cmpxchg(), like it was prior to
    83ab38ef0a0b. Add a few WARNs for the paranoid.
    
    Fixes: 83ab38ef0a0b ("jump_label: Fix concurrency issues in static_key_slow_dec()")
    Reported-by: "Darrick J. Wong" <djwong@kernel.org>
    Tested-by: Klara Modin <klarasmodin@gmail.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 6dc76b590703..93a822d3c468 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -168,7 +168,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 		jump_label_update(key);
 		/*
 		 * Ensure that when static_key_fast_inc_not_disabled() or
-		 * static_key_slow_try_dec() observe the positive value,
+		 * static_key_dec_not_one() observe the positive value,
 		 * they must also observe all the text changes.
 		 */
 		atomic_set_release(&key->enabled, 1);
@@ -250,7 +250,7 @@ void static_key_disable(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-static bool static_key_slow_try_dec(struct static_key *key)
+static bool static_key_dec_not_one(struct static_key *key)
 {
 	int v;
 
@@ -274,6 +274,14 @@ static bool static_key_slow_try_dec(struct static_key *key)
 		 * enabled. This suggests an ordering problem on the user side.
 		 */
 		WARN_ON_ONCE(v < 0);
+
+		/*
+		 * Warn about underflow, and lie about success in an attempt to
+		 * not make things worse.
+		 */
+		if (WARN_ON_ONCE(v == 0))
+			return true;
+
 		if (v <= 1)
 			return false;
 	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
@@ -284,15 +292,27 @@ static bool static_key_slow_try_dec(struct static_key *key)
 static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 {
 	lockdep_assert_cpus_held();
+	int val;
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	guard(mutex)(&jump_label_mutex);
-	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
+	val = atomic_read(&key->enabled);
+	/*
+	 * It should be impossible to observe -1 with jump_label_mutex held,
+	 * see static_key_slow_inc_cpuslocked().
+	 */
+	if (WARN_ON_ONCE(val == -1))
+		return;
+	/*
+	 * Cannot already be 0, something went sideways.
+	 */
+	if (WARN_ON_ONCE(val == 0))
+		return;
+
+	if (atomic_dec_and_test(&key->enabled))
 		jump_label_update(key);
-	else
-		WARN_ON_ONCE(!static_key_slow_try_dec(key));
 }
 
 static void __static_key_slow_dec(struct static_key *key)
@@ -329,7 +349,7 @@ void __static_key_slow_dec_deferred(struct static_key *key,
 {
 	STATIC_KEY_CHECK_USE(key);
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	schedule_delayed_work(work, timeout);

