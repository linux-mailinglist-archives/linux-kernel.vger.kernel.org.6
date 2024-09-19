Return-Path: <linux-kernel+bounces-333505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8116197C9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35DA1C20981
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9919F113;
	Thu, 19 Sep 2024 13:07:25 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79719EEDF
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751245; cv=none; b=liD9orvjtyY/v0TTUBU14GHeNT2s57frVygqBx3HFSTQKSEk6lEEhZPUTO5mFIooBHKjCZwX3H7o9/wLOrkArhWJv9M/GEUSm6iEVipxS1/qTZhFNtoLmONJjYYyO7hWVB4HNUh62Mchvp+62M495BNDgpdim88VXf7hAYQygmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751245; c=relaxed/simple;
	bh=AuthoQ2SxkhYYlaXRjMt5sLm3Is9Iy5TFs8uQ/j6sJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/M8ddBVBZNV6xW1Q+GGdOv13n6lwJ6iDPTg12zaCzOyH+gwdRNKagWXcsu65dVgjBH9/DkJiSqNyxEblRhLVFGujBFQuZXn5cDH7LP5w6wIhFuHTDFjKZWxxxNqpIToxfTssoTr0GyoYXDiB9d59tKNAZggRLk6GUrWSRmIVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X8Zzq4DZ6z9v7Hy
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 20:47:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A7E1A140158
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:07:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP2 (Coremail) with SMTP id GxC2BwBnFsfqIexmRoM8AQ--.55331S3;
	Thu, 19 Sep 2024 14:07:14 +0100 (CET)
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
Subject: [PATCH v3 1/5] tools/memory-model: Legitimize current use of tags in LKMM macros
Date: Thu, 19 Sep 2024 15:06:30 +0200
Message-Id: <20240919130634.298181-2-jonas.oberhauser@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBnFsfqIexmRoM8AQ--.55331S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4xGr45tF4DGr43tF4ruFg_yoW8Ar4kpF
	ZrCw15GF4UXrZ8uwnrGrWUua4S9a93Jr45Gr9rJa43A34YvrnFy3WDXFnFqFZ3ZrWv9w12
	qr12qFn2q3WUArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRKBT5JUUUUU==
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
index ce068700939c..dba6b5b6dee0 100644
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
+		'mb (*xchg(),cmpxchg(),...*)
+instructions R[Accesses]
+instructions W[Accesses]
+instructions RMW[Accesses]
 
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
-- 
2.34.1


