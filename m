Return-Path: <linux-kernel+bounces-333509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D8D97C9C4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B711F1F24A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5977119F113;
	Thu, 19 Sep 2024 13:08:08 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422819E7FB
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751287; cv=none; b=OcRFbdPIg7oMBVwSfrj5bkytqVr/gfItU8dLuTU8cJ5kLVoeBbZcx0MdpEx8OPGtoIKp7qqyNlV6ri1saVDp1DlcQlWHtYtbp9rjPQvTtjb75WtQqQhngBkSk3Vis6Q5k/AmWzvQfbutZseaEVwtVJq7xyfODoBvm18xOxDKAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751287; c=relaxed/simple;
	bh=RKS6mLXvzvddCtU/6TKVNWrzwwnXmUvvYTBWTN/9iD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxYQGkb2OSpEUfukZi+aHe8jRsyNlDQpMiAzQfUKpZz09VqTsp9otbLhJkakmk7mTphZXs/1TD/ykcPxCupunn8StmTCtG/wiJQoTm21sthTg47IFUD/eCC9JBMKAGt6hYC+5ruc1ojct2EpK3FYja33Gyw4uw9SIweOIoLYIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X8Zt50rTzz9v7JW
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 20:42:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 433C4140453
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:07:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP2 (Coremail) with SMTP id GxC2BwBnFsfqIexmRoM8AQ--.55331S7;
	Thu, 19 Sep 2024 14:07:56 +0100 (CET)
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To: paulmck@kernel.org
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	quic_neeraju@quicinc.com,
	frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH v3 5/5] tools/memory-model: Distinguish between syntactic and semantic tags
Date: Thu, 19 Sep 2024 15:06:34 +0200
Message-Id: <20240919130634.298181-6-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919130634.298181-1-jonas.oberhauser@huaweicloud.com>
References: <20240919130634.298181-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBnFsfqIexmRoM8AQ--.55331S7
X-Coremail-Antispam: 1UD129KBjvAXoWfGr1fuFyfGr4rAr1Dur17Jrb_yoW8XrWkto
	WrGryft3W8XryDWan8Kw1xJrWDWw4Iq3Z0gry8Gw1jvFy7ZayrXrnrG3WUt3yxJFy5Cwn8
	WrZ7Z3sxXay7Ar1kn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO97AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRZJ5oDUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

Not all tags that are always there syntactically also provide semantic
membership in the corresponding set. For example, an 'acquire tag on a
write does not imply that the write is finally in the Acquire set and
provides acquire ordering.

To distinguish in those cases between the syntactic tags and actual
sets, we capitalize the former, so 'ACQUIRE tags may be present on both
reads and writes, but only reads will appear in the Acquire set.

For tags where the two concepts are the same we do not use specific
capitalization to make this distinction.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 tools/memory-model/linux-kernel.bell |  22 +--
 tools/memory-model/linux-kernel.def  | 198 +++++++++++++--------------
 2 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 703028e5e091..dd49b987704d 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -13,18 +13,18 @@
 
 "Linux-kernel memory consistency model"
 
-enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
-		'release (*smp_store_release*) ||
-		'acquire (*smp_load_acquire*) ||
-		'noreturn (* R of non-return RMW *) ||
-		'mb (*xchg(),cmpxchg(),...*)
+enum Accesses = 'ONCE (*READ_ONCE,WRITE_ONCE*) ||
+		'RELEASE (*smp_store_release*) ||
+		'ACQUIRE (*smp_load_acquire*) ||
+		'NORETURN (* R of non-return RMW *) ||
+		'MB (*xchg(),cmpxchg(),...*)
 instructions R[Accesses]
 instructions W[Accesses]
 instructions RMW[Accesses]
 
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
-		'mb (*smp_mb*) ||
+		'MB (*smp_mb*) ||
 		'barrier (*barrier*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
@@ -42,10 +42,10 @@ instructions F[Barriers]
  * semantic ordering, such as Acquire on a store or Mb on a failed RMW.
  *)
 let FailedRMW = RMW \ (domain(rmw) | range(rmw))
-let Acquire = Acquire \ W \ FailedRMW
-let Release = Release \ R \ FailedRMW
-let Mb = Mb \ FailedRMW
-let Noreturn = Noreturn \ W
+let Acquire = ACQUIRE \ W \ FailedRMW
+let Release = RELEASE \ R \ FailedRMW
+let Mb = MB \ FailedRMW
+let Noreturn = NORETURN \ W
 
 (* SRCU *)
 enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
@@ -85,7 +85,7 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
 
 (* Compute marked and plain memory accesses *)
-let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
+let Marked = (~M) | IW | ONCE | RELEASE | ACQUIRE | MB | RMW |
 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
 let Plain = M \ Marked
 
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 4281572732bd..2b3a12c55f93 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -6,18 +6,18 @@
 // which appeared in ASPLOS 2018.
 
 // ONCE
-READ_ONCE(X) __load{once}(X)
-WRITE_ONCE(X,V) { __store{once}(X,V); }
+READ_ONCE(X) __load{ONCE}(X)
+WRITE_ONCE(X,V) { __store{ONCE}(X,V); }
 
 // Release Acquire and friends
-smp_store_release(X,V) { __store{release}(*X,V); }
-smp_load_acquire(X) __load{acquire}(*X)
-rcu_assign_pointer(X,V) { __store{release}(X,V); }
-rcu_dereference(X) __load{once}(X)
-smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
+smp_store_release(X,V) { __store{RELEASE}(*X,V); }
+smp_load_acquire(X) __load{ACQUIRE}(*X)
+rcu_assign_pointer(X,V) { __store{RELEASE}(X,V); }
+rcu_dereference(X) __load{ONCE}(X)
+smp_store_mb(X,V) { __store{ONCE}(X,V); __fence{MB}; }
 
 // Fences
-smp_mb() { __fence{mb}; }
+smp_mb() { __fence{MB}; }
 smp_rmb() { __fence{rmb}; }
 smp_wmb() { __fence{wmb}; }
 smp_mb__before_atomic() { __fence{before-atomic}; }
@@ -28,14 +28,14 @@ smp_mb__after_srcu_read_unlock() { __fence{after-srcu-read-unlock}; }
 barrier() { __fence{barrier}; }
 
 // Exchange
-xchg(X,V)  __xchg{mb}(X,V)
-xchg_relaxed(X,V) __xchg{once}(X,V)
-xchg_release(X,V) __xchg{release}(X,V)
-xchg_acquire(X,V) __xchg{acquire}(X,V)
-cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
-cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
-cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
-cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
+xchg(X,V)  __xchg{MB}(X,V)
+xchg_relaxed(X,V) __xchg{ONCE}(X,V)
+xchg_release(X,V) __xchg{RELEASE}(X,V)
+xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
+cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
+cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
+cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
+cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
 
 // Spinlocks
 spin_lock(X) { __lock(X); }
@@ -63,86 +63,86 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
 atomic_read_acquire(X) smp_load_acquire(X)
 atomic_set_release(X,V) { smp_store_release(X,V); }
 
-atomic_add(V,X) { __atomic_op{noreturn}(X,+,V); }
-atomic_sub(V,X) { __atomic_op{noreturn}(X,-,V); }
-atomic_and(V,X) { __atomic_op{noreturn}(X,&,V); }
-atomic_or(V,X)  { __atomic_op{noreturn}(X,|,V); }
-atomic_xor(V,X) { __atomic_op{noreturn}(X,^,V); }
-atomic_inc(X)   { __atomic_op{noreturn}(X,+,1); }
-atomic_dec(X)   { __atomic_op{noreturn}(X,-,1); }
-atomic_andnot(V,X) { __atomic_op{noreturn}(X,&~,V); }
-
-atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
-atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
-atomic_add_return_acquire(V,X) __atomic_op_return{acquire}(X,+,V)
-atomic_add_return_release(V,X) __atomic_op_return{release}(X,+,V)
-atomic_fetch_add(V,X) __atomic_fetch_op{mb}(X,+,V)
-atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{once}(X,+,V)
-atomic_fetch_add_acquire(V,X) __atomic_fetch_op{acquire}(X,+,V)
-atomic_fetch_add_release(V,X) __atomic_fetch_op{release}(X,+,V)
-
-atomic_fetch_and(V,X) __atomic_fetch_op{mb}(X,&,V)
-atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{once}(X,&,V)
-atomic_fetch_and_acquire(V,X) __atomic_fetch_op{acquire}(X,&,V)
-atomic_fetch_and_release(V,X) __atomic_fetch_op{release}(X,&,V)
-
-atomic_fetch_or(V,X) __atomic_fetch_op{mb}(X,|,V)
-atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{once}(X,|,V)
-atomic_fetch_or_acquire(V,X) __atomic_fetch_op{acquire}(X,|,V)
-atomic_fetch_or_release(V,X) __atomic_fetch_op{release}(X,|,V)
-
-atomic_fetch_xor(V,X) __atomic_fetch_op{mb}(X,^,V)
-atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{once}(X,^,V)
-atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{acquire}(X,^,V)
-atomic_fetch_xor_release(V,X) __atomic_fetch_op{release}(X,^,V)
-
-atomic_inc_return(X) __atomic_op_return{mb}(X,+,1)
-atomic_inc_return_relaxed(X) __atomic_op_return{once}(X,+,1)
-atomic_inc_return_acquire(X) __atomic_op_return{acquire}(X,+,1)
-atomic_inc_return_release(X) __atomic_op_return{release}(X,+,1)
-atomic_fetch_inc(X) __atomic_fetch_op{mb}(X,+,1)
-atomic_fetch_inc_relaxed(X) __atomic_fetch_op{once}(X,+,1)
-atomic_fetch_inc_acquire(X) __atomic_fetch_op{acquire}(X,+,1)
-atomic_fetch_inc_release(X) __atomic_fetch_op{release}(X,+,1)
-
-atomic_sub_return(V,X) __atomic_op_return{mb}(X,-,V)
-atomic_sub_return_relaxed(V,X) __atomic_op_return{once}(X,-,V)
-atomic_sub_return_acquire(V,X) __atomic_op_return{acquire}(X,-,V)
-atomic_sub_return_release(V,X) __atomic_op_return{release}(X,-,V)
-atomic_fetch_sub(V,X) __atomic_fetch_op{mb}(X,-,V)
-atomic_fetch_sub_relaxed(V,X) __atomic_fetch_op{once}(X,-,V)
-atomic_fetch_sub_acquire(V,X) __atomic_fetch_op{acquire}(X,-,V)
-atomic_fetch_sub_release(V,X) __atomic_fetch_op{release}(X,-,V)
-
-atomic_dec_return(X) __atomic_op_return{mb}(X,-,1)
-atomic_dec_return_relaxed(X) __atomic_op_return{once}(X,-,1)
-atomic_dec_return_acquire(X) __atomic_op_return{acquire}(X,-,1)
-atomic_dec_return_release(X) __atomic_op_return{release}(X,-,1)
-atomic_fetch_dec(X) __atomic_fetch_op{mb}(X,-,1)
-atomic_fetch_dec_relaxed(X) __atomic_fetch_op{once}(X,-,1)
-atomic_fetch_dec_acquire(X) __atomic_fetch_op{acquire}(X,-,1)
-atomic_fetch_dec_release(X) __atomic_fetch_op{release}(X,-,1)
-
-atomic_xchg(X,V) __xchg{mb}(X,V)
-atomic_xchg_relaxed(X,V) __xchg{once}(X,V)
-atomic_xchg_release(X,V) __xchg{release}(X,V)
-atomic_xchg_acquire(X,V) __xchg{acquire}(X,V)
-atomic_cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
-atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
-atomic_cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
-atomic_cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
-
-atomic_sub_and_test(V,X) __atomic_op_return{mb}(X,-,V) == 0
-atomic_dec_and_test(X)  __atomic_op_return{mb}(X,-,1) == 0
-atomic_inc_and_test(X)  __atomic_op_return{mb}(X,+,1) == 0
-atomic_add_negative(V,X) __atomic_op_return{mb}(X,+,V) < 0
-atomic_add_negative_relaxed(V,X) __atomic_op_return{once}(X,+,V) < 0
-atomic_add_negative_acquire(V,X) __atomic_op_return{acquire}(X,+,V) < 0
-atomic_add_negative_release(V,X) __atomic_op_return{release}(X,+,V) < 0
-
-atomic_fetch_andnot(V,X) __atomic_fetch_op{mb}(X,&~,V)
-atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{acquire}(X,&~,V)
-atomic_fetch_andnot_release(V,X) __atomic_fetch_op{release}(X,&~,V)
-atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{once}(X,&~,V)
-
-atomic_add_unless(X,V,W) __atomic_add_unless{mb}(X,V,W)
\ No newline at end of file
+atomic_add(V,X) { __atomic_op{NORETURN}(X,+,V); }
+atomic_sub(V,X) { __atomic_op{NORETURN}(X,-,V); }
+atomic_and(V,X) { __atomic_op{NORETURN}(X,&,V); }
+atomic_or(V,X)  { __atomic_op{NORETURN}(X,|,V); }
+atomic_xor(V,X) { __atomic_op{NORETURN}(X,^,V); }
+atomic_inc(X)   { __atomic_op{NORETURN}(X,+,1); }
+atomic_dec(X)   { __atomic_op{NORETURN}(X,-,1); }
+atomic_andnot(V,X) { __atomic_op{NORETURN}(X,&~,V); }
+
+atomic_add_return(V,X) __atomic_op_return{MB}(X,+,V)
+atomic_add_return_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V)
+atomic_add_return_acquire(V,X) __atomic_op_return{ACQUIRE}(X,+,V)
+atomic_add_return_release(V,X) __atomic_op_return{RELEASE}(X,+,V)
+atomic_fetch_add(V,X) __atomic_fetch_op{MB}(X,+,V)
+atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{ONCE}(X,+,V)
+atomic_fetch_add_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,+,V)
+atomic_fetch_add_release(V,X) __atomic_fetch_op{RELEASE}(X,+,V)
+
+atomic_fetch_and(V,X) __atomic_fetch_op{MB}(X,&,V)
+atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{ONCE}(X,&,V)
+atomic_fetch_and_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,&,V)
+atomic_fetch_and_release(V,X) __atomic_fetch_op{RELEASE}(X,&,V)
+
+atomic_fetch_or(V,X) __atomic_fetch_op{MB}(X,|,V)
+atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{ONCE}(X,|,V)
+atomic_fetch_or_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,|,V)
+atomic_fetch_or_release(V,X) __atomic_fetch_op{RELEASE}(X,|,V)
+
+atomic_fetch_xor(V,X) __atomic_fetch_op{MB}(X,^,V)
+atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{ONCE}(X,^,V)
+atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,^,V)
+atomic_fetch_xor_release(V,X) __atomic_fetch_op{RELEASE}(X,^,V)
+
+atomic_inc_return(X) __atomic_op_return{MB}(X,+,1)
+atomic_inc_return_relaxed(X) __atomic_op_return{ONCE}(X,+,1)
+atomic_inc_return_acquire(X) __atomic_op_return{ACQUIRE}(X,+,1)
+atomic_inc_return_release(X) __atomic_op_return{RELEASE}(X,+,1)
+atomic_fetch_inc(X) __atomic_fetch_op{MB}(X,+,1)
+atomic_fetch_inc_relaxed(X) __atomic_fetch_op{ONCE}(X,+,1)
+atomic_fetch_inc_acquire(X) __atomic_fetch_op{ACQUIRE}(X,+,1)
+atomic_fetch_inc_release(X) __atomic_fetch_op{RELEASE}(X,+,1)
+
+atomic_sub_return(V,X) __atomic_op_return{MB}(X,-,V)
+atomic_sub_return_relaxed(V,X) __atomic_op_return{ONCE}(X,-,V)
+atomic_sub_return_acquire(V,X) __atomic_op_return{ACQUIRE}(X,-,V)
+atomic_sub_return_release(V,X) __atomic_op_return{RELEASE}(X,-,V)
+atomic_fetch_sub(V,X) __atomic_fetch_op{MB}(X,-,V)
+atomic_fetch_sub_relaxed(V,X) __atomic_fetch_op{ONCE}(X,-,V)
+atomic_fetch_sub_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,-,V)
+atomic_fetch_sub_release(V,X) __atomic_fetch_op{RELEASE}(X,-,V)
+
+atomic_dec_return(X) __atomic_op_return{MB}(X,-,1)
+atomic_dec_return_relaxed(X) __atomic_op_return{ONCE}(X,-,1)
+atomic_dec_return_acquire(X) __atomic_op_return{ACQUIRE}(X,-,1)
+atomic_dec_return_release(X) __atomic_op_return{RELEASE}(X,-,1)
+atomic_fetch_dec(X) __atomic_fetch_op{MB}(X,-,1)
+atomic_fetch_dec_relaxed(X) __atomic_fetch_op{ONCE}(X,-,1)
+atomic_fetch_dec_acquire(X) __atomic_fetch_op{ACQUIRE}(X,-,1)
+atomic_fetch_dec_release(X) __atomic_fetch_op{RELEASE}(X,-,1)
+
+atomic_xchg(X,V) __xchg{MB}(X,V)
+atomic_xchg_relaxed(X,V) __xchg{ONCE}(X,V)
+atomic_xchg_release(X,V) __xchg{RELEASE}(X,V)
+atomic_xchg_acquire(X,V) __xchg{ACQUIRE}(X,V)
+atomic_cmpxchg(X,V,W) __cmpxchg{MB}(X,V,W)
+atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{ONCE}(X,V,W)
+atomic_cmpxchg_acquire(X,V,W) __cmpxchg{ACQUIRE}(X,V,W)
+atomic_cmpxchg_release(X,V,W) __cmpxchg{RELEASE}(X,V,W)
+
+atomic_sub_and_test(V,X) __atomic_op_return{MB}(X,-,V) == 0
+atomic_dec_and_test(X)  __atomic_op_return{MB}(X,-,1) == 0
+atomic_inc_and_test(X)  __atomic_op_return{MB}(X,+,1) == 0
+atomic_add_negative(V,X) __atomic_op_return{MB}(X,+,V) < 0
+atomic_add_negative_relaxed(V,X) __atomic_op_return{ONCE}(X,+,V) < 0
+atomic_add_negative_acquire(V,X) __atomic_op_return{ACQUIRE}(X,+,V) < 0
+atomic_add_negative_release(V,X) __atomic_op_return{RELEASE}(X,+,V) < 0
+
+atomic_fetch_andnot(V,X) __atomic_fetch_op{MB}(X,&~,V)
+atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{ACQUIRE}(X,&~,V)
+atomic_fetch_andnot_release(V,X) __atomic_fetch_op{RELEASE}(X,&~,V)
+atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{ONCE}(X,&~,V)
+
+atomic_add_unless(X,V,W) __atomic_add_unless{MB}(X,V,W)
\ No newline at end of file
-- 
2.34.1


