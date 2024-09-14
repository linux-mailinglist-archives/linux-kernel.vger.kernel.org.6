Return-Path: <linux-kernel+bounces-329268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48B978F66
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240721F23451
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7DB1CE70A;
	Sat, 14 Sep 2024 09:20:45 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C712BEBB
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305644; cv=none; b=L3Da0jHRllHAzOkeZB2k5XLSfm+Unp8y2lzRUx+xpS3ywUBFlF14qgHM9yNVx9rRLKvrfCgqtCnFbJvsMAip172ch5a0cQ4QdFCqaglKZj0Is9zbYvTcQjWnTli7w6HKtDLCvw7ia/rVINt096HmFBVPWa5ygweb8J/tUMmr7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305644; c=relaxed/simple;
	bh=rFcJ+JPR/+ReElPiZkLdBdT1aBVQHAYyA/sruWEMf+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9qhSsDSCYqp2TyfrS9sIwHCruQ0jnslXBG1t1Ke81RFcpaz5dbDmRQs77axN7nsVSx/EHN0YnnB+Ac7EaUsn/H5Hpel6r+2GIBm57uA2wNJq+DpdePG71nuMg6MEEIJRoX/CZqpGVVX85DjKz2n2YIvV3Lr/vWht40gZ3rAUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726305637-1eb14e31a91060e0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id b2RgN40ujzARFIbd (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 14 Sep 2024 17:20:37 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:37 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 17:20:36 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Sat, 14 Sep 2024 17:20:35 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
Received: from zx4.zhaoxin.com (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Sep
 2024 16:53:28 +0800
From: yongli-oc <yongli-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
Subject: [PATCH 2/4] locking/osq_lock: Turn to dynamic switch function from osq_lock/unlock.
Date: Sat, 14 Sep 2024 16:53:25 +0800
X-ASG-Orig-Subj: [PATCH 2/4] locking/osq_lock: Turn to dynamic switch function from osq_lock/unlock.
Message-ID: <20240914085327.32912-3-yongli-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/14/2024 5:20:34 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1726305637
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5488
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130433
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

To support numa-aware osq lock, the struct optimistic_spin_queue
is accessed as three members, numa_enable, index, tail16, by union.
The size of the struct is the same as before.
If dynamic numa-ware lock enable, turns to the crossing, x_osq_lock to
check contention level and starts dynamic switch.

Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
---
 include/linux/osq_lock.h  | 33 ++++++++++++++++++++-
 kernel/locking/osq_lock.c | 62 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
index ea8fb31379e3..37a7bc4ab530 100644
--- a/include/linux/osq_lock.h
+++ b/include/linux/osq_lock.h
@@ -12,14 +12,42 @@ struct optimistic_spin_queue {
 	 * Stores an encoded value of the CPU # of the tail node in the queue.
 	 * If the queue is empty, then it's set to OSQ_UNLOCKED_VAL.
 	 */
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
+	union {
+		atomic_t tail;
+		u32 val;
+#ifdef __LITTLE_ENDIAN
+		struct {
+			u16 tail16;
+			u8 index;
+			u8 numa_enable;
+		};
+#else
+		struct {
+			u8 numa_enable;
+			u8 index;
+			u16 tail16;
+		};
+#endif
+	};
+#else
 	atomic_t tail;
+#endif
 };
=20
 #define OSQ_UNLOCKED_VAL (0)
=20
 /* Init macro and function. */
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
+
+#define OSQ_LOCK_UNLOCKED { .tail =3D ATOMIC_INIT(OSQ_UNLOCKED_VAL) }
+
+#else
+
 #define OSQ_LOCK_UNLOCKED { ATOMIC_INIT(OSQ_UNLOCKED_VAL) }
=20
+#endif
+
 static inline void osq_lock_init(struct optimistic_spin_queue *lock)
 {
 	atomic_set(&lock->tail, OSQ_UNLOCKED_VAL);
@@ -28,9 +56,12 @@ static inline void osq_lock_init(struct optimistic_spin_=
queue *lock)
 extern bool osq_lock(struct optimistic_spin_queue *lock);
 extern void osq_unlock(struct optimistic_spin_queue *lock);
=20
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
+extern bool osq_is_locked(struct optimistic_spin_queue *lock);
+#else
 static inline bool osq_is_locked(struct optimistic_spin_queue *lock)
 {
 	return atomic_read(&lock->tail) !=3D OSQ_UNLOCKED_VAL;
 }
-
+#endif
 #endif
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 75a6f6133866..a7b516939e00 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -2,7 +2,10 @@
 #include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/osq_lock.h>
-
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
+#include "numa.h"
+#include "numa_osq.h"
+#endif
 /*
  * An MCS like lock especially tailored for optimistic spinning for sleepi=
ng
  * lock implementations (mutex, rwsem, etc).
@@ -12,12 +15,34 @@
  * spinning.
  */
=20
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
+DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
+/*
+ * We use the value 0 to represent "no CPU", thus the encoded value
+ * will be the CPU number incremented by 1.
+ */
+inline int encode_cpu(int cpu_nr)
+{
+	return cpu_nr + 1;
+}
+
+inline int node_cpu(struct optimistic_spin_node *node)
+{
+	return node->cpu - 1;
+}
+
+inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
+{
+	int cpu_nr =3D encoded_cpu_val - 1;
+
+	return per_cpu_ptr(&osq_node, cpu_nr);
+}
+#else
 struct optimistic_spin_node {
 	struct optimistic_spin_node *next, *prev;
 	int locked; /* 1 if lock acquired */
 	int cpu; /* encoded CPU # + 1 value */
 };
-
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node=
);
=20
 /*
@@ -40,6 +65,7 @@ static inline struct optimistic_spin_node *decode_cpu(int=
 encoded_cpu_val)
=20
 	return per_cpu_ptr(&osq_node, cpu_nr);
 }
+#endif
=20
 /*
  * Get a stable @node->next pointer, either for unlock() or unqueue() purp=
oses.
@@ -97,6 +123,14 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	int curr =3D encode_cpu(smp_processor_id());
 	int old;
=20
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
+	if (unlikely(enable_zx_numa_osq_lock > 1)) {
+		node->numa =3D 1;
+		return x_osq_lock(lock);
+	}
+	node->numa =3D 0;
+#endif
+
 	node->locked =3D 0;
 	node->next =3D NULL;
 	node->cpu =3D curr;
@@ -108,6 +142,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * the lock tail.
 	 */
 	old =3D atomic_xchg(&lock->tail, curr);
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
+	if (enable_zx_numa_osq_lock > 0)
+	//enable means all cpu cores are less tan 65534.
+		old =3D old & 0xffff;
+#endif
 	if (old =3D=3D OSQ_UNLOCKED_VAL)
 		return true;
=20
@@ -212,6 +251,14 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	struct optimistic_spin_node *node, *next;
 	int curr =3D encode_cpu(smp_processor_id());
=20
+	node =3D this_cpu_ptr(&osq_node);
+
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
+	if (unlikely(enable_zx_numa_osq_lock > 1 &&
+		node->numa =3D=3D 1))
+		return x_osq_unlock(lock);
+#endif
+
 	/*
 	 * Fast path for the uncontended case.
 	 */
@@ -222,7 +269,6 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	/*
 	 * Second most likely case.
 	 */
-	node =3D this_cpu_ptr(&osq_node);
 	next =3D xchg(&node->next, NULL);
 	if (next) {
 		WRITE_ONCE(next->locked, 1);
@@ -233,3 +279,13 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	if (next)
 		WRITE_ONCE(next->locked, 1);
 }
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
+bool osq_is_locked(struct optimistic_spin_queue *lock)
+{
+	if (unlikely(enable_zx_numa_osq_lock > 1))
+		return x_osq_is_locked(lock);
+	return atomic_read(&lock->tail) !=3D OSQ_UNLOCKED_VAL;
+}
+#endif
+
+
--=20
2.34.1


