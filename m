Return-Path: <linux-kernel+bounces-191064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0E78D0616
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB771C2048D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0488473462;
	Mon, 27 May 2024 15:24:03 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7661FFB
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823442; cv=none; b=rnCtg501sHCZCIScf8L6a9Ag+0HNnr0Hnc7XSP9peOazA2zSSakHpSbrYAEffU2Hvfpr8DvQwC2jEm0UV2ZR3b5r6pFx4LnpzLfu4AKqjH+YjdufPZRWlpUiagx+YC+esLm1YpUau8xLv4uzSGl291fszQA4rVDYml51kwNDiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823442; c=relaxed/simple;
	bh=zbu6nmCHUO93zt/7OgCtge0gcv5wVCjbKVEbJTIMhAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffBh8oKvTfZoCxj17htNeLOSI37v+5X02lbP1BQaEIuOMrc9OsHbYep4im7xYLAMAnQAi9GZCKJ5I5iFW1TEgTHDFfqYttBSrOubs7xsNfUxZcVhkGm0WluUuI+qN22NrP87Em5b1MmoyPnGX0JqZaguhE+L7dNKd6eLTTtFJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VnzWN54T0z9v7Hn
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:06:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D495D140133
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:23:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP1 (Coremail) with SMTP id LxC2BwAHshpgpVRmXLgGCQ--.41702S5;
	Mon, 27 May 2024 16:23:57 +0100 (CET)
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
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Viktor Vafeiadis <viktor@mpi-sws.org>
Subject: [RFC][PATCH 3/4] tools/memory-model: Define effect of Mb tags on RMWs in tools/...
Date: Mon, 27 May 2024 17:22:52 +0200
Message-Id: <20240527152253.195956-4-jonas.oberhauser@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHshpgpVRmXLgGCQ--.41702S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWUZry5tFWkCFW8JrWDurg_yoW8WFWkpr
	Z0g345GrWvgryj9as7ZanxZFyrWa1xKF13WFs7Cw1fZr43XrW7Z34rtanIqr9IqFsa9a45
	Zr4jva4vya4kAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9J5rUUUUU=
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
 tools/memory-model/linux-kernel.cat | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index adf3c4f41229..3a6e9677abe4 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -34,6 +34,15 @@ let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
 let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
+	(* full-barrier RMWs (successful cmpxchg(), xchg(), etc.) act as
+	 * though there were enclosed by smp_mb().
+	 * The effect of these virtual smp_mb() is formalized by adding
+	 * Mb tags to the read and write of the operation, and providing
+	 * the same ordering as though there were additional po edges
+	 * between the Mb tag and the read resp. write.
+	 *)
+	([M] ; po ; [Mb] ; (* po ; *) [R]) |
+	([W] ; (* po ; *) [Mb] ; po ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
-- 
2.34.1


