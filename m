Return-Path: <linux-kernel+bounces-333508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BE97C9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF6028595B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AB819EECD;
	Thu, 19 Sep 2024 13:07:56 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3319D09A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751276; cv=none; b=cqo/aums+WSJLEI8ViW3XC0FYCNu2DyzUHfXn4MpijzfWht+lHbn7U3Rh8ib+8nRbrVDxmv21eXF5FreryvsjabpSoQ1/e5DCpLDwkFhpSy8IuZk1+7NcnsX+TuotoTY7xPC3GtTi7w5Ds4wp5SZhfJEsFDnFIH5fOFLgqf52mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751276; c=relaxed/simple;
	bh=/rkVyM9JF+C6RjKYsQLKGdwZ9D4yvmmb8OaoTcuSkPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JRulvNfnIAk6p3Fvnc5YnBWIae0i+pRPeMl6CsyvY9zG8o2Il7Z1/KVmwlzTWp7B5rV+BwrGWvxtMmFnnjoqhzUBRmXg/GRVAK5eJMJahpc8R50taoMjKUCO3XM1NmtWWwcsQzcNOdd3hzQYlefepAFyFMIlg2xbfmRM84tixR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X8b0Z6kb1z9v7N8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 20:48:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B2864140451
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:07:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP2 (Coremail) with SMTP id GxC2BwBnFsfqIexmRoM8AQ--.55331S6;
	Thu, 19 Sep 2024 14:07:46 +0100 (CET)
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
Subject: [PATCH v3 4/5] tools/memory-model: Switch to softcoded herd7 tags
Date: Thu, 19 Sep 2024 15:06:33 +0200
Message-Id: <20240919130634.298181-5-jonas.oberhauser@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBnFsfqIexmRoM8AQ--.55331S6
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWxCF17ury3Xw45tr4UXFb_yoW3uw4xpr
	sxJrZrKr4UXw1UJ3ykGr4UC3WrWw40k3yUJFs2yryrZr12kr45A3W8tr1vqryUJry8Kw48
	Xr12gFyjkr1UJFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
	Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRTUDLUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

A new version of Herd7 provides a -lkmmv1 switch which overrides the old herd7
behavior of simply ignoring any softcoded tags in the .def and .bell files. We
port LKMM to this version of Herd7 by providing the switch in linux-kernel.cfg
and reporting an error if the LKMM is used without this switch.

To preserve the semantics of LKMM, we also softcode the Noreturn tag on atomic
RMW which do not return a value and define atomic_add_unless with an Mb tag in
linux-kernel.def.

We update the herd-representation.txt accordingly and clarify some of the
resulting combinations.

We also add a litmus test for atomic_add_unless which uncovered a bug in early
iterations of the Herd7 patch that implements the new switch.

(To be) Signed-off-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Signed-off by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 .../Documentation/herd-representation.txt     | 27 ++++++++++---------
 tools/memory-model/linux-kernel.bell          |  3 +++
 tools/memory-model/linux-kernel.cfg           |  1 +
 tools/memory-model/linux-kernel.def           | 18 +++++++------
 .../litmus-tests/add-unless-mb.litmus         | 27 +++++++++++++++++++
 5 files changed, 56 insertions(+), 20 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/add-unless-mb.litmus

diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
index ed988906f2b7..7ae1ff3d3769 100644
--- a/tools/memory-model/Documentation/herd-representation.txt
+++ b/tools/memory-model/Documentation/herd-representation.txt
@@ -18,6 +18,11 @@
 #
 # By convention, a blank line in a cell means "same as the preceding line".
 #
+# Note that the syntactic representation does not always match the sets and
+# relations in linux-kernel.cat, due to redefinitions in linux-kernel.bell and
+# lock.cat. For example, the po link between LKR and LKW is upgraded to an rmw
+# link, and W[acquire] are not included in the Acquire set.
+#
 # Disclaimer.  The table includes representations of "add" and "and" operations;
 # corresponding/identical representations of "sub", "inc", "dec" and "or", "xor",
 # "andnot" operations are omitted.
@@ -60,14 +65,13 @@
     ------------------------------------------------------------------------------
     |       RMW ops w/o return value |                                           |
     ------------------------------------------------------------------------------
-    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
+    |                     atomic_add | R*[noreturn] ->rmw W*[noreturn]           |
     |                     atomic_and |                                           |
     |                      spin_lock | LKR ->po LKW                              |
     ------------------------------------------------------------------------------
     |        RMW ops w/ return value |                                           |
     ------------------------------------------------------------------------------
-    |              atomic_add_return | F[mb] ->po R*[once]                       |
-    |                                |     ->rmw W*[once] ->po F[mb]             |
+    |              atomic_add_return | R*[mb] ->rmw W*[mb]                       |
     |               atomic_fetch_add |                                           |
     |               atomic_fetch_and |                                           |
     |                    atomic_xchg |                                           |
@@ -79,13 +83,13 @@
     |            atomic_xchg_relaxed |                                           |
     |                   xchg_relaxed |                                           |
     |    atomic_add_negative_relaxed |                                           |
-    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
+    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[acquire]             |
     |       atomic_fetch_add_acquire |                                           |
     |       atomic_fetch_and_acquire |                                           |
     |            atomic_xchg_acquire |                                           |
     |                   xchg_acquire |                                           |
     |    atomic_add_negative_acquire |                                           |
-    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
+    |      atomic_add_return_release | R*[release] ->rmw W*[release]             |
     |       atomic_fetch_add_release |                                           |
     |       atomic_fetch_and_release |                                           |
     |            atomic_xchg_release |                                           |
@@ -94,17 +98,16 @@
     ------------------------------------------------------------------------------
     |            Conditional RMW ops |                                           |
     ------------------------------------------------------------------------------
-    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
-    |                                |                 ->rmw W*[once] ->po F[mb] |
-    |                                | On failure: R*[once]                      |
+    |                 atomic_cmpxchg | On success: R*[mb] ->rmw W*[mb]           |
+    |                                | On failure: R*[mb]                        |
     |                        cmpxchg |                                           |
     |              atomic_add_unless |                                           |
     |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
     |                                | On failure: R*[once]                      |
-    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
-    |                                | On failure: R*[once]                      |
-    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
-    |                                | On failure: R*[once]                      |
+    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[acquire] |
+    |                                | On failure: R*[acquire]                   |
+    |         atomic_cmpxchg_release | On success: R*[release] ->rmw W*[release] |
+    |                                | On failure: R*[release]                   |
     |                   spin_trylock | On success: LKR ->po LKW                  |
     |                                | On failure: LF                            |
     ------------------------------------------------------------------------------
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 7c9ae48b9437..703028e5e091 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -94,3 +94,6 @@ let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
 let addr = carry-dep ; addr
 let ctrl = carry-dep ; ctrl
 let data = carry-dep ; data
+
+flag ~empty (if "lkmmv1" then 0 else _)
+  as this-model-requires-variant-higher-than-lkmmv0
diff --git a/tools/memory-model/linux-kernel.cfg b/tools/memory-model/linux-kernel.cfg
index 3c8098e99f41..a5855363259a 100644
--- a/tools/memory-model/linux-kernel.cfg
+++ b/tools/memory-model/linux-kernel.cfg
@@ -1,6 +1,7 @@
 macros linux-kernel.def
 bell linux-kernel.bell
 model linux-kernel.cat
+variant lkmmv1
 graph columns
 squished true
 showevents noregs
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index a12b96c547b7..4281572732bd 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -63,14 +63,14 @@ atomic_set(X,V) { WRITE_ONCE(*X,V); }
 atomic_read_acquire(X) smp_load_acquire(X)
 atomic_set_release(X,V) { smp_store_release(X,V); }
 
-atomic_add(V,X) { __atomic_op(X,+,V); }
-atomic_sub(V,X) { __atomic_op(X,-,V); }
-atomic_and(V,X) { __atomic_op(X,&,V); }
-atomic_or(V,X)  { __atomic_op(X,|,V); }
-atomic_xor(V,X) { __atomic_op(X,^,V); }
-atomic_inc(X)   { __atomic_op(X,+,1); }
-atomic_dec(X)   { __atomic_op(X,-,1); }
-atomic_andnot(V,X) { __atomic_op(X,&~,V); }
+atomic_add(V,X) { __atomic_op{noreturn}(X,+,V); }
+atomic_sub(V,X) { __atomic_op{noreturn}(X,-,V); }
+atomic_and(V,X) { __atomic_op{noreturn}(X,&,V); }
+atomic_or(V,X)  { __atomic_op{noreturn}(X,|,V); }
+atomic_xor(V,X) { __atomic_op{noreturn}(X,^,V); }
+atomic_inc(X)   { __atomic_op{noreturn}(X,+,1); }
+atomic_dec(X)   { __atomic_op{noreturn}(X,-,1); }
+atomic_andnot(V,X) { __atomic_op{noreturn}(X,&~,V); }
 
 atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
 atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
@@ -144,3 +144,5 @@ atomic_fetch_andnot(V,X) __atomic_fetch_op{mb}(X,&~,V)
 atomic_fetch_andnot_acquire(V,X) __atomic_fetch_op{acquire}(X,&~,V)
 atomic_fetch_andnot_release(V,X) __atomic_fetch_op{release}(X,&~,V)
 atomic_fetch_andnot_relaxed(V,X) __atomic_fetch_op{once}(X,&~,V)
+
+atomic_add_unless(X,V,W) __atomic_add_unless{mb}(X,V,W)
\ No newline at end of file
diff --git a/tools/memory-model/litmus-tests/add-unless-mb.litmus b/tools/memory-model/litmus-tests/add-unless-mb.litmus
new file mode 100644
index 000000000000..72f76ff3f59d
--- /dev/null
+++ b/tools/memory-model/litmus-tests/add-unless-mb.litmus
@@ -0,0 +1,27 @@
+C add_unless_mb
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that a successful atomic_add_unless
+ * acts as a full memory barrier, ensuring that *x=1 propagates to P1
+ * before P1 executes *x=2.
+ *)
+
+{}
+
+P0(atomic_t *x, atomic_t *y, atomic_t *z)
+{
+	WRITE_ONCE(*x, 1);
+	int r0 = atomic_add_unless(z,1,5);
+	WRITE_ONCE(*y, 1);
+}
+
+P1(atomic_t *x, atomic_t *y)
+{
+	int r0 = READ_ONCE(*y);
+	if (r0 == 1)
+		WRITE_ONCE(*x, 2);
+}
+
+exists (1:r0=1 /\ x=1)
-- 
2.34.1


