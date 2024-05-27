Return-Path: <linux-kernel+bounces-191062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED0E8D0621
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7651297168
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ADF17E912;
	Mon, 27 May 2024 15:23:50 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E617E8E0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823429; cv=none; b=D9lAE/YgGxXmqam/PSY9hhKEimvRTVi4DhZFRFnoZtXO/ll22akZE/1XmPlOm9+xZgbqFmTS48/DU4Jan39QF7xP5e2KH9ft36RoLWKNit+4vph9IujpZ/5rJ1k1h9Pe9r8J7MmqkNRbcBfxxXAQw3M5VKLHKRhlR854tN0046k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823429; c=relaxed/simple;
	bh=E12HbST7gVhui/vfd1239eOfyFPBo4oTSXW6Fz+MpH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UfH59MY3TXsyyzhGjmhMgwK5K5dLdPsOuMx3sO0dBRyPBE04vH9g9lTI/n5zCq7yN7vNQwQhydjltg3mcM3KSKyLZbSqYGYWqqCO/v5w2QGkSh67Jmwf8vfvdhRY51o0Nap5dz98kALKQc6vqifwt/GOqbzHsSeVtoJUdCJ7p+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VnzPb0h4Tz9v7JM
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:01:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D1CB314040D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:23:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP1 (Coremail) with SMTP id LxC2BwAHshpgpVRmXLgGCQ--.41702S3;
	Mon, 27 May 2024 16:23:35 +0100 (CET)
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
Subject: [RFC][PATCH 1/4] tools/memory-model: Legitimize current use of tags in LKMM macros
Date: Mon, 27 May 2024 17:22:50 +0200
Message-Id: <20240527152253.195956-2-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527152253.195956-1-jonas.oberhauser@huaweicloud.com>
References: <20240527152253.195956-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshpgpVRmXLgGCQ--.41702S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4xGr45tF4DGr43tF4ruFg_yoW8AryDpF
	ZrCw15GF4UXrZ8uwnrJrWUua4S9a93Jr45Gr9rta43A34YvrnFy3WqqFnF9FZ3ZrZ7uw17
	Xr12qFn2q3WUArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI
	8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUb7KsUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

The current macros in linux-kernel.def reference instructions such as
__xchg{mb} or __cmpxchg{acquire}, which are invalid combinations of tags
and instructions according to the declarations in linux-kernel.bell.
This works with current herd7 because herd7 removes these tags anyways
and does not actually enforce validity of combinations at all.

If a future herd7 version no longer applies these hardcoded
transformations, then all currently invalid combinations will actually
appear on some instruction.

We therefore adjust the declarations to make the resulting combinations
valid, by adding the 'mb tag to the set of Accesses and allowing all
Accesses to appear on all read, write, and RMW instructions.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 tools/memory-model/linux-kernel.bell | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index ce068700939c..1b2444cdf8d1 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -16,10 +16,11 @@
 enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
 		'release (*smp_store_release*) ||
 		'acquire (*smp_load_acquire*) ||
-		'noreturn (* R of non-return RMW *)
-instructions R[{'once,'acquire,'noreturn}]
-instructions W[{'once,'release}]
-instructions RMW[{'once,'acquire,'release}]
+		'noreturn (* R of non-return RMW *) ||
+		'mb (*xchg(),compare_exchange(),...*)
+instructions R[Accesses]
+instructions W[Accesses]
+instructions RMW[Accesses]
 
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
-- 
2.34.1


