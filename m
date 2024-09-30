Return-Path: <linux-kernel+bounces-343477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D984989B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5F6B20DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8D815EFB9;
	Mon, 30 Sep 2024 07:24:58 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129215C144
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681097; cv=none; b=mxov5HWoxURFGAPumR5fe/0j1uE9xK8539AmI8wOHCgf/lN7xR2ufsTfczJACX4CqNggIGUUcK0ZT8n0tod+u96KoUZ6qHx9L3iO4FiEn9r0moES9XiejpHaZV9bE5lVuDzvkOXC4g7dwdxt354eNsdE+uOVPAozwfV+GRs6zEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681097; c=relaxed/simple;
	bh=+uvJ6Z1mH3Vm6gf+/ZfohVkJQqXKRQLlbW2a+frGpO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gee1yDKi1umU96fq/0noMMO5O/0bgOPzmkPwnWQJ6OjmXfXJarmET6epwVeflM2QpJI6JBcNyHc1wP86n+xw59GcncpQsQXMyYlW1cizN/XKv8KcBHx27IVdoT1Pxx2l8UemJvXNABwZbnDT8BilpW1QsYBXOrlVJnWsgwb9Xi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1727681082-1eb14e31a91269e0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id OxDCUWwJ2I2oeZ7u (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 30 Sep 2024 15:24:42 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 15:24:42 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 15:24:42 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Mon, 30 Sep 2024 15:24:41 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
Received: from zx4.zhaoxin.com (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 15:23:55 +0800
From: yongli-oc <yongli-oc@zhaoxin.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
Subject: [PATCH v2 2/3] locking/osq_lock: Define osq by union to support dynamic numa-aware lock.
Date: Mon, 30 Sep 2024 15:23:54 +0800
X-ASG-Orig-Subj: [PATCH v2 2/3] locking/osq_lock: Define osq by union to support dynamic numa-aware lock.
Message-ID: <20240930072355.2892-3-yongli-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930072355.2892-1-yongli-oc@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240930072355.2892-1-yongli-oc@zhaoxin.com>
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
X-Moderation-Data: 9/30/2024 3:24:40 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1727681082
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1947
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.131164
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

    To support numa-aware osq lock, the struct optimistic_spin_queue
    is accessed as three members, numa_enable, index, tail16, by union.
    The size of the struct is the same as before.

Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
---
 include/linux/osq_lock.h | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

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
--=20
2.34.1


