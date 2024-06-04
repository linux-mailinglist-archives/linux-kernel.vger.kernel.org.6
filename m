Return-Path: <linux-kernel+bounces-201055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4358FB8B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A7C1F246AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2003114883C;
	Tue,  4 Jun 2024 16:18:42 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2D1474BC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517921; cv=none; b=UGx9LmzIoWfbvu6NsOguSU+CdiA3A2nWGuTitUXzAIpcsKVL44Ke6XODhiJOmIA5ISAl9iNZ0XMaDhK9J04up9YTXGjGL3t8WxlSMgcXm0y92Dqkzqqb+BapgTx+2D+NQFDOr41sKkwYcJ1UAdKKic6L1gX7rZ4UW2PhkbI2i9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517921; c=relaxed/simple;
	bh=AuthoQ2SxkhYYlaXRjMt5sLm3Is9Iy5TFs8uQ/j6sJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKl+tQQesIfKwemkRIXJz6NueW9Aez1nRVRpvfb59WlE/oLXYvm5ibGWrqGFAIfxcEKn6AIn0CyrsZUnXSMVQEDKLo8uA75guKYOmQP6kWd0hgjA7WT7dbjeAdocghIC1RX37cWVxtLD2yvicVwcgUg3tPt3mGgQv54ydWKwddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VtvyW4KT9z9v7JB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:43:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 64AF614078E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:01:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP2 (Coremail) with SMTP id GxC2BwAH9Cc4Ol9mnOuGCQ--.64982S2;
	Tue, 04 Jun 2024 17:01:08 +0100 (CET)
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
Subject: [PATCHv2 1/4] tools/memory-model: Legitimize current use of tags in LKMM macros
Date: Tue,  4 Jun 2024 18:00:51 +0200
Message-Id: <20240604160051.497856-1-jonas.oberhauser@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAH9Cc4Ol9mnOuGCQ--.64982S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4xGr45tF4DGr43tF4ruFg_yoW8Ar4kpF
	ZrCw15GF4UXrZ8uwnrGrWUua4S9a93Jr45Gr9rJa43A34YvrnFy3WDXFnFqFZ3ZrWv9w12
	qr12qFn2q3WUArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UAxhLUUUUU=
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


