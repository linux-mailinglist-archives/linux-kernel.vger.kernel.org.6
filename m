Return-Path: <linux-kernel+bounces-407279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F6E9C6B41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA316B26470
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC51C8FBA;
	Wed, 13 Nov 2024 09:13:21 +0000 (UTC)
Received: from zxbjcas.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BF1C7B99
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.127.214.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489201; cv=none; b=BEOMmdrSlSJbJVesefKmkCws3MEBVOl38tBBvRVTXpRfX/SbWy7YV5Sqpm64u4FS8yY3F31TLzPWVEjjUay6TTJvMMDvUaMJ6+PT8MR3HYLkN2ifvwXojKv/h8qLIrd8V+hhx6Lx68Kl6VzLN9u8Qhj4gYvnMPVaOhBM2f0Z7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489201; c=relaxed/simple;
	bh=hmwIrDNHKzFxb3EM0X8go7su7pTAl2dTtmWubnqKNAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FIkRZVR7JMMldz0MggDdXmGk+j2BlPcWZkQ2bNEBW/MtEXyUqSNlYrcTcIeMeJP+HQ9Je11zxGrKYKBLIJ0mfcnV5ivW513y4vlZUXDMk9UDCKN58PE+ewkpQpT7stqpWsg3vJWLIR+0d5kax///jECcPJdiP+I5T0NtorJzTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=124.127.214.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zxbjcas.zhaoxin.com (localhost [127.0.0.2] (may be forged))
	by zxbjcas.zhaoxin.com with ESMTP id 4AD8wmLJ058567
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:58:48 +0800 (GMT-8)
	(envelope-from YongLi-oc@zhaoxin.com)
Received: from ZXBJMBX03.zhaoxin.com (ZXBJMBX03.zhaoxin.com [10.29.252.7])
	by zxbjcas.zhaoxin.com with ESMTP id 4AD8wWW5058549;
	Wed, 13 Nov 2024 16:58:32 +0800 (GMT-8)
	(envelope-from YongLi-oc@zhaoxin.com)
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 13 Nov
 2024 16:58:31 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Wed, 13 Nov 2024 16:58:31 +0800
Received: from zx1.zhaoxin.com (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 16:57:03 +0800
From: yongli-oc <yongli-oc@zhaoxin.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC: <yongli@zhaoxin.com>, <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <jiangbowang@zhaoxin.com>
Subject: [PATCH] Support lockref reference count if enable LOCK_STAT
Date: Wed, 13 Nov 2024 16:57:03 +0800
Message-ID: <20241113085703.148839-1-yongli-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
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
X-Moderation-Data: 11/13/2024 4:58:30 PM
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:zxbjcas.zhaoxin.com 4AD8wmLJ058567

Swap the positions of lock and count to support CMPXCHG_LOCKREF
if SPINLOCK_SIZE > 4 when enable LOCK_STAT. The reference count
can always be used regardless of the spinlock_t size.

Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
---
 include/linux/lockref.h | 17 ++++++++++++++++-
 lib/lockref.c           | 26 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index c3a1f78bc884..44ac754a029b 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -22,15 +22,30 @@
 	(IS_ENABLED(CONFIG_ARCH_USE_CMPXCHG_LOCKREF) && \
 	 IS_ENABLED(CONFIG_SMP) && SPINLOCK_SIZE <=3D 4)
=20
+#define USE_CMPXCHG_LOCKREF_ALTERNATIVE \
+	(IS_ENABLED(CONFIG_ARCH_USE_CMPXCHG_LOCKREF) && \
+	 IS_ENABLED(CONFIG_SMP) && SPINLOCK_SIZE > 4)
+
 struct lockref {
 	union {
 #if USE_CMPXCHG_LOCKREF
 		aligned_u64 lock_count;
-#endif
 		struct {
 			spinlock_t lock;
 			int count;
 		};
+#elif USE_CMPXCHG_LOCKREF_ALTERNATIVE
+		aligned_u64 lock_count;
+		struct {
+			int count;
+			spinlock_t lock;
+		} __packed;
+#else
+		struct {
+			spinlock_t lock;
+			int count;
+		};
+#endif
 	};
 };
=20
diff --git a/lib/lockref.c b/lib/lockref.c
index 2afe4c5d8919..e92606f66e9b 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -26,6 +26,32 @@
 	}									\
 } while (0)
=20
+#elif USE_CMPXCHG_LOCKREF_ALTERNATIVE
+
+/*
+ * Note that the "cmpxchg()" reloads the "old" value for the
+ * failure case.
+ */
+#define CMPXCHG_LOOP(CODE, SUCCESS) do {					\
+	int retry =3D 100;							\
+	struct lockref old;							\
+	BUILD_BUG_ON(offsetof(struct lockref, lock) !=3D 4);			\
+	BUILD_BUG_ON(offsetof(spinlock_t, rlock) !=3D 0);				\
+	BUILD_BUG_ON(offsetof(raw_spinlock_t, raw_lock) !=3D 0);			\
+	old.lock_count =3D READ_ONCE(lockref->lock_count);			\
+	while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {	\
+		struct lockref new =3D old;					\
+		CODE								\
+		if (likely(try_cmpxchg64_relaxed(&lockref->lock_count,		\
+						 &old.lock_count,		\
+						 new.lock_count))) {		\
+			SUCCESS;						\
+		}								\
+		if (!--retry)							\
+			break;							\
+	}									\
+} while (0)
+
 #else
=20
 #define CMPXCHG_LOOP(CODE, SUCCESS) do { } while (0)
--=20
2.34.1


