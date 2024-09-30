Return-Path: <linux-kernel+bounces-343827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD9E989FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D542868CC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D218E37A;
	Mon, 30 Sep 2024 10:58:10 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE118D65C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693890; cv=none; b=C6/oHeUl6dTx0nViUBSToGvgbpC7ljwb5WQzqVroDi9h5Ot2xtDNOCfSAzZUm6CR7Oa4UO/vKOPj5I8/oCu6LKMVoi8so+T2dqGRtJ3TRJJAa3ssj+bAxZST7Iu1J2tuPjAKxVeFzNADNtmpWNnXkYaT2+z+9s/1iAV8NA7iyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693890; c=relaxed/simple;
	bh=ppigp21ZNg99k5SITpZMtUx3HYzasDubNk9q/zf7x3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMD+gQt98wqtN9rPiQ/XkvE1IzuiaOUZ2IunnidcCB+DKxjs6FlqrqCBhatrPkpWcL/2wDJ8JNeJl6DK5HX91dWwplvaPFO/yhXpaToFr9tmqsKGIxMNqh7h4WqVVW0Th9/JzEzbRPIAQ4MJXL2AvG4FborF56NxuOf49vy/8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XHHSj3l9Lz9v7JQ
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:32:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 96662140932
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:58:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP1 (Coremail) with SMTP id LxC2BwAHmC8OhPpmdITtAQ--.60189S5;
	Mon, 30 Sep 2024 11:58:00 +0100 (CET)
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
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Viktor Vafeiadis <viktor@mpi-sws.org>
Subject: [PATCH v4 3/5] tools/memory-model: Define effect of Mb tags on RMWs in tools/...
Date: Mon, 30 Sep 2024 12:57:08 +0200
Message-Id: <20240930105710.383284-4-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHmC8OhPpmdITtAQ--.60189S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWUZry5tFWkCFW8JrWDurg_yoW8WFy3pr
	ZYgw15Gr4kKryUu3Z3ZanxZF1rWa1xtF13WFn7A34fZr43XrW7Z34rtan0qF9xXFsI9a45
	Zr4jv3WkCa4kAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRl_MsUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

Herd7 transforms successful RMW with Mb tags by inserting smp_mb() fences
around them. We emulate this by considering imaginary po-edges before the
RMW read and before the RMW write, and extending the smp_mb() ordering
rule, which currently only applies to real po edges that would be found
around a really inserted smp_mb(), also to cases of the only imagined po
edges.

Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 tools/memory-model/linux-kernel.cat | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index adf3c4f41229..d7e7bf13c831 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -34,6 +34,16 @@ let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
 let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
+	(*
+	 * full-barrier RMWs (successful cmpxchg(), xchg(), etc.) act as
+	 * though there were enclosed by smp_mb().
+	 * The effect of these virtual smp_mb() is formalized by adding
+	 * Mb tags to the read and write of the operation, and providing
+	 * the same ordering as though there were additional po edges
+	 * between the Mb tag and the read resp. write.
+	 *)
+	([M] ; po ; [Mb & R]) |
+	([Mb & W] ; po ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
-- 
2.34.1


