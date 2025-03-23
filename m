Return-Path: <linux-kernel+bounces-572919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E72DA6D06C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B360B3B0267
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8979B192D97;
	Sun, 23 Mar 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LjcSvUt9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3PzVYMJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ADE190472
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752302; cv=none; b=GobPB7JC04EImhJgIItfdkJt1AGfRYeaxZLSplSYYiM7s0fwyfU5qidwuT/3ZLJJR+wDn3fQzicO08Im5Ye9s2itfUXDi0renEArmDRx9+/A0v1qLpS3yHBK2G57GAPQUkGA/k5RUrJhUnYvYx3GYHGdfZpVWp2ktmylEPVIxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752302; c=relaxed/simple;
	bh=T7VrwBWg0F7LBWAzljb+xXAEAbuXSjebr56Z0pWRmQg=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=SN763ZyWqlG5XFT+C/VRYmU5LU6bgCtz+4q4Es1ST+cPkS3mEgK5k0nH8jul5O3Rx0bUHxPg+qDTjzgfiBomg+dS3Fm3R3qi2U86qad+ADknvxy2aW55SZ++zjufd9NIsa0CL0AMrMJ50fr/mnb9Q7JobB7c4FwOX/V7aX/mBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LjcSvUt9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3PzVYMJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742752299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=QABjmyYXW7UonVblekjgMZNZZdeqU5ttqw9cB5KXoeQ=;
	b=LjcSvUt91Y1h6k2Hkwfrwj3T3mbAsakU3/wBBlT0gohNQw1Qwhf/xU752WeM1piLW7n8Dl
	MhQJ5+3w56LkWicRIQEDfd8VGyeqIHgzaKk+3kWQpJq1liYTIEld/Eh20sa+vphxVLG9cK
	VB8RJGjppG7WYyc/TbWvHsB5QHmb+AXELVOUaXOHyMShUzn5v6FYOb2x4uqnJQxXBApLdI
	GKtTqcIfl788MsBXMUPZLGvVGqvOP8giECy1KYnwx5ze/+ycL6LP4FmaUBRN9OXMSm9MUJ
	Mo41ZSoK9qhj8YPs3R+0Ue91pP7jGCOlW/UIfWhtxEd3ZObPqsrf8ZNJa7PiLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742752299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=QABjmyYXW7UonVblekjgMZNZZdeqU5ttqw9cB5KXoeQ=;
	b=n3PzVYMJZ3lgdpG8JL96TtvK3SYwu+LtKX8fYA0YILjy3btkKyuuX62G8MDEMOTAw7VptD
	B1Wf1hRSHzbXqaCg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/futex for v6.15-rc1
References: <174275225552.1561082.4969731002775597670.tglx@xen13>
Message-ID: <174275226072.1561082.5650620916174411892.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 18:51:38 +0100 (CET)

Linus,

please pull the latest locking/futex branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-futex-20=
25-03-23

up to:  e3924279e516: futex: Use a hashmask instead of hashsize


A single update for futexes:

  Use a precomputed mask for the hash computation instead of computing the
  mask from the size on every invocation.


Thanks,

	tglx

------------------>
Sebastian Andrzej Siewior (1):
      futex: Use a hashmask instead of hashsize


 kernel/futex/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 3db8567f5a44..cca15859a50b 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -50,10 +50,10 @@
  */
 static struct {
 	struct futex_hash_bucket *queues;
-	unsigned long            hashsize;
+	unsigned long            hashmask;
 } __futex_data __read_mostly __aligned(2*sizeof(long));
 #define futex_queues   (__futex_data.queues)
-#define futex_hashsize (__futex_data.hashsize)
+#define futex_hashmask (__futex_data.hashmask)
=20
=20
 /*
@@ -119,7 +119,7 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 	u32 hash =3D jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
=20
-	return &futex_queues[hash & (futex_hashsize - 1)];
+	return &futex_queues[hash & futex_hashmask];
 }
=20
=20
@@ -1127,27 +1127,28 @@ void futex_exit_release(struct task_struct *tsk)
=20
 static int __init futex_init(void)
 {
+	unsigned long hashsize, i;
 	unsigned int futex_shift;
-	unsigned long i;
=20
 #ifdef CONFIG_BASE_SMALL
-	futex_hashsize =3D 16;
+	hashsize =3D 16;
 #else
-	futex_hashsize =3D roundup_pow_of_two(256 * num_possible_cpus());
+	hashsize =3D roundup_pow_of_two(256 * num_possible_cpus());
 #endif
=20
 	futex_queues =3D alloc_large_system_hash("futex", sizeof(*futex_queues),
-					       futex_hashsize, 0, 0,
+					       hashsize, 0, 0,
 					       &futex_shift, NULL,
-					       futex_hashsize, futex_hashsize);
-	futex_hashsize =3D 1UL << futex_shift;
+					       hashsize, hashsize);
+	hashsize =3D 1UL << futex_shift;
=20
-	for (i =3D 0; i < futex_hashsize; i++) {
+	for (i =3D 0; i < hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
 		plist_head_init(&futex_queues[i].chain);
 		spin_lock_init(&futex_queues[i].lock);
 	}
=20
+	futex_hashmask =3D hashsize - 1;
 	return 0;
 }
 core_initcall(futex_init);


