Return-Path: <linux-kernel+bounces-358192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C67997B40
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67901C2309B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A118DF9E;
	Thu, 10 Oct 2024 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kVI4AHUu"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126BBE57
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728530904; cv=none; b=Fy0/K0EeRGGb4vydEFNWMRtBdh90MO4qgeu8CvOzvGY/Do4pxVdQ1OyZbZhjMRxJTPS3vs0CCvOej0QEYTn1OGNRaxWH6uoyKlZFclThyCTisjQsU9Fb0R1OZmnAIgSqesjAjXELTJuAJT9oxU54ehNk5Ng+Yieisb+wNdMEYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728530904; c=relaxed/simple;
	bh=BeiKZCfb6gic7g21gsJUG6wcQ15qiSO4ojhCZyxgvJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Jxf6U9bvybZOcN8ahte7ER5njS92kD9cLCG1IBHa2S891zJlrkjJ6tXRUPzOBfsipkFYvSML1Yx/Af7IWcF8n4n1W1tUZ+vi7kahzA49d3eow6XCOZZryOfzltP87s9JWEHOwjTf9FFZgeBUlSTneyY4UUk/1cpxGnVFuG2smPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kVI4AHUu; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241010032819epoutp042d9ed90de3077f1e071b950c9d871cb7~8_bHSHOMU1586615866epoutp044
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:28:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241010032819epoutp042d9ed90de3077f1e071b950c9d871cb7~8_bHSHOMU1586615866epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728530899;
	bh=I7RolCLeqBo2pBQma+2QZ0VVfpaaaNjpkYkORQmzuAs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=kVI4AHUuJaYVvM7PM17e4wlUGsQxaQ9Sd6DhyyUooc+TQrSD0L5U5h7QKcrXObEES
	 SeCZyuM3mxlkh+QQIqIPiG212dQVAHtpe4ya82krpGFaYVQDY2zzWRoR5MCFY5FhHS
	 acI+sse+eCjxmMzAXMRU+9fPseX0tDLxvCCyb4fU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241010032818epcas5p1e437a4d0add3533deeaeb05d79fd7554~8_bGnq3SZ3083030830epcas5p1d;
	Thu, 10 Oct 2024 03:28:18 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.0C.09420.2D947076; Thu, 10 Oct 2024 12:28:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241010032751epcas5p1154533995a184be3fea39325c4d33740~8_at50hWO0644806448epcas5p1P;
	Thu, 10 Oct 2024 03:27:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241010032751epsmtrp160e8650b439aedc862468ceaee75d969~8_at5ESn31240512405epsmtrp1B;
	Thu, 10 Oct 2024 03:27:51 +0000 (GMT)
X-AuditID: b6c32a49-33dfa700000024cc-6a-670749d2b68d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.D5.08229.7B947076; Thu, 10 Oct 2024 12:27:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241010032749epsmtip2ffa644116bc183d40de7e41fe30f270e~8_arpNkOb2223822238epsmtip2b;
	Thu, 10 Oct 2024 03:27:49 +0000 (GMT)
From: Hariom Panthi <hariom1.p@samsung.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, r.thapliyal@samsung.com, Hariom Panthi
	<hariom1.p@samsung.com>, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] sched.h: silent false ATOMIC_SLEEP warning from
 cond_resched
Date: Thu, 10 Oct 2024 08:56:53 +0530
Message-Id: <20241010032653.1922214-1-hariom1.p@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CLcRzH7/s8T9tTGo8pvuXIjS4bFSc85zrcoXtSyPkPpV09Vqq129ZP
	P65IOtWKSlcqy6+xza/V0g9bWZLKReXHSRKmq5xQrshp2p45/nt93p8f7/t87oOjXL2DOx4t
	ltNSsTCWx3LCapr5fO/uQLZoVdUlF7J4OB0jP+brUdKcacLIN3lFGNlTX8Yimy9kYmTB6CAg
	u5uUCNma24SQd/pjSGPWAEJmPZhASX3LJHszh9JWaAGVYexlU0pdAlV1TUD1vbjHor4Yn7Mo
	RbUaUFUdh6lx3eIQx71O/pF0bHQiLfXdGO4U9fXqFCLpdElu106gaUA79zTAcUj4wRztktPA
	CecSDQAW/epEmGAMwN9lFnswAeB9S95M4GjrePG4kc0kDACaTg2h1gSX+A5g+vVo61gWsQK2
	jm2w1rgQ7QDq+qdtk1AiZ2Zs4QlbwzxiD7ytt7CtjBGesDdDY2MO4Q+vaDNZjJsHLOmetOtz
	YVuJGbMyOqOf0J9HmZozONQULmN4K9SkT7MZngdHWqvt7A6H8zLtnASzldkODKcBWK4KZngT
	NHdVOlgXQAk+vFXvy8iLYFH7TYSxnQ1zf5nth+DA2oq/vBSWP9BhDLvB2gtZdqZgi6oJY+4T
	Ct/qW9j5wKP0v21K/9um9J+zEqBq4EZLZHEiWrZWslpMJ/nIhHGyBLHIJyI+TgdsnyUIrAVv
	Br76mACCAxOAOMpz4XhXOoi4nEhhSiotjT8gTYilZSawEMd4CzifTpZHcgmRUE7H0LSElv7N
	IrijexrCz9q2/OW+QLry2o8NXXUx8pH5uxS8oLqznckPIy63TW3PUOAthak/j2bv0OfefWU2
	3DDU+amHLr5OXvmtWHDIr8T8mTxXnzAr7ZJhXBEAwiQHBifDTZ6JZ88c6Q5VBSxmmb20xyXT
	MIlgJz9Kcr3p2vwhsDhjvRu/kRs8uPWnl7Rgi3TJFfeQ8B6VYPfDBYlePQv9hkYHUt4ZP4yF
	jL83WxpSoFJLTRVFzxli7T/IjS/Y3eUdZhRouPsqchuWbTkl0yiekMfIbYKOvo6gNaqd/cM9
	ljFjeI7HKrUzUrbRK3LEeZ086LhaPFJz3e2WQX7Ss/Oov/qZRr7zafATwbMGHiaLEq4WoFKZ
	8A/C1tmbyAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSvO52T/Z0g8nTdSymv2xksXg6YSuz
	xZO2QywWd/unslhc3jWHzeLw/DYWi8nvnjFaXDqwgMnieO8BJouN97It9nU8YLLoOPKN2WLr
	0e/sDrwea+atYfRo2XeL3WPBplKPzSu0PO5c28Pm8X7fVTaPvi2rGD02n672+LxJLoAzissm
	JTUnsyy1SN8ugSvjw7JfTAXnRCpOrfnG3MC4RrCLkZNDQsBE4tqZ/exdjFwcQgK7GSUuPehh
	hkhISqyb/wXKFpZY+e85VNEnRone3jNADgcHm4C2xPFPViBxEYFrjBI7T85gA3GYBSYwSnz/
	sIwFpFtYIFBi29UtYDaLgKrErZbV7CA2r4CNxNI1bWwQG+QlZl76DhUXlDg58wlYPTNQvHnr
	bOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHAVamjsYt6/6
	oHeIkYmD8RCjBAezkgiv7kLWdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNT
	UwtSi2CyTBycUg1M8cGrncT/bXo1xVRRrMVg1bQ8FqFHmTNilr6pTWB+Mv3qY5lTysXuBTL5
	0X4/N728HWvA+fCU544DbcmBLL/ZojYde8jf8p9L1Ca2+vL2m/tjbfMcpsbbVjIpaaxZLce0
	2GJbR0HTppSGS4uevIvPLrr7Tv+5xDKD2yoO1oFzAyqu7c6LX7G+b03TgvDlTPpRPe/3dl5f
	+K7qtLOnUthZvt8qbyRLk7cr9q6Se/nIM2alRa6hPYfI37zZR5bot3ZV9FRoTPhzRb3x+59L
	9p++H2H+r18ecHpzoVRL4K51rnw/Ju7Zc+34x6Qrc6ZIlG2RY+CfzWtuoWIZvdQs5/vESdsX
	VufsMT7B8dbxT4upEktxRqKhFnNRcSIAYhtb9PECAAA=
X-CMS-MailID: 20241010032751epcas5p1154533995a184be3fea39325c4d33740
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20241010032751epcas5p1154533995a184be3fea39325c4d33740
References: <CGME20241010032751epcas5p1154533995a184be3fea39325c4d33740@epcas5p1.samsung.com>

In case of (CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC),
cond_reched() is not sleeping.

Thus remove __might_resched in that cases.

Co-developed-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Hariom Panthi <hariom1.p@samsung.com>
---
 include/linux/sched.h | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c6009faf8da5..a748ea8a435c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2067,6 +2067,7 @@ static inline int _cond_resched(void)
 
 #endif /* PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
 
+#define __might_resched_possible	__might_resched
 #else /* CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC */
 
 static inline int _cond_resched(void)
@@ -2075,11 +2076,13 @@ static inline int _cond_resched(void)
 	return 0;
 }
 
+static inline void __might_resched_possible(const char *file, int line, unsigned int offsets) {}
+
 #endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
 
-#define cond_resched() ({			\
-	__might_resched(__FILE__, __LINE__, 0);	\
-	_cond_resched();			\
+#define cond_resched() ({					\
+	__might_resched_possible(__FILE__, __LINE__, 0);	\
+	_cond_resched();					\
 })
 
 extern int __cond_resched_lock(spinlock_t *lock);
@@ -2105,19 +2108,19 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	(PREEMPT_LOCK_OFFSET + (1U << MIGHT_RESCHED_RCU_SHIFT))
 #endif
 
-#define cond_resched_lock(lock) ({						\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
-	__cond_resched_lock(lock);						\
+#define cond_resched_lock(lock) ({							\
+	__might_resched_possible(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_lock(lock);							\
 })
 
-#define cond_resched_rwlock_read(lock) ({					\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
-	__cond_resched_rwlock_read(lock);					\
+#define cond_resched_rwlock_read(lock) ({						\
+	__might_resched_possible(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_rwlock_read(lock);						\
 })
 
-#define cond_resched_rwlock_write(lock) ({					\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
-	__cond_resched_rwlock_write(lock);					\
+#define cond_resched_rwlock_write(lock) ({						\
+	__might_resched_possible(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_rwlock_write(lock);						\
 })
 
 static __always_inline bool need_resched(void)
-- 
2.25.1


