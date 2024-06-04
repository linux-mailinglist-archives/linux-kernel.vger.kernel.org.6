Return-Path: <linux-kernel+bounces-201039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370398FB8C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBE2B33204
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD214830B;
	Tue,  4 Jun 2024 16:05:38 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA023146D6E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517137; cv=none; b=ZSBIpi3ft4BgDw6QX6SJvmJhBsGcjLTGVgDJCuy/mOTjNkREOvm44++yRsKT/sGTMzbqjXGr9mbeKvqJUO9dPx/qCR9lADxqH37owtKlH0TdAQoknraGlqokjEdXL0c9WSjMO2SADMWEUDWKE/oD1PU8NPzTHnRkcptxuzoXuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517137; c=relaxed/simple;
	bh=FU6GNh4XzJLuiE9LuDyFg65wWv21DyTlcYGDZen0blc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vDBjb+QoAdaB8Ewb1wUmiEL6OTvZFWDf1BYJClUUaC1rrDiPuirWEnu4+HQhnpaT5WCYVMx7es2tJp0UrmYNLxuJd0GY6UQAiOu5D5Sfy+YVr4uj9UjlMLx4QEwstiOxC1rVSr6AUFm6YZdatu667ndITRlQOu7+FqfVh7DEYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vtvxr1wC5z9v7JW
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:43:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 66F8B140717
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:05:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP2 (Coremail) with SMTP id GxC2BwCn4CQ2O19mAfiGCQ--.12002S2;
	Tue, 04 Jun 2024 17:05:22 +0100 (CET)
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
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCHv2 4/4] tools/memory-model: Distinguish between syntactic and semantic tags
Date: Tue,  4 Jun 2024 18:05:06 +0200
Message-Id: <20240604160506.498429-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCn4CQ2O19mAfiGCQ--.12002S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGr1kJw18Aw4ftrWDAF13Jwb_yoW8GF1fCo
	WrGr1ft3W8XFyDWan8Kw1xJrWDW3y2q3Z0gry8Gw1jvFy7Za95XrnrG3Wjq34xtFy5Cw15
	WrZ7Z3sxXay7Jr1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYc7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
	JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AK
	xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	fUo8nYUUUUU
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
 tools/memory-model/linux-kernel.bell |  22 ++--
 tools/memory-model/linux-kernel.def  | 176 +++++++++++++--------------
 2 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 2f49993644ed..a27757470d29 100644
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
@@ -38,10 +38,10 @@ instructions F[Barriers]
 
 (* Remove impossible tags, such as Acquire on a store or failed RMW *)
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
@@ -81,7 +81,7 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
 
 (* Compute marked and plain memory accesses *)
-let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
+let Marked = (~M) | IW | ONCE | RELEASE | ACQUIRE | MB | RMW |
 		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
 let Plain = M \ Marked
 
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index a12b96c547b7..001366ff3fb4 100644
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
@@ -72,75 +72,75 @@ atomic_inc(X)   { __atomic_op(X,+,1); }
 atomic_dec(X)   { __atomic_op(X,-,1); }
 atomic_andnot(V,X) { __atomic_op(X,&~,V); }
 
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
-- 
2.34.1


