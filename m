Return-Path: <linux-kernel+bounces-201037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BC08FB878
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D6F28029B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF68E1482FC;
	Tue,  4 Jun 2024 16:05:23 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481D145A03
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517123; cv=none; b=Le37VeW0myioU7Mwn1QeOOhaPRcYFROQMqQN31d6dc25mmHxTqDAZQo6/7ZlVITqPyF5QgWvSc+c9Od6JAYMl4MDkrc1b/DkOxqyfSVDMCluqoe/kYH2Yx51t5wYzVcOW6uZWUrn+GpA3V8ng9l8+eT47Hlw9qDss6T3ryq2SWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517123; c=relaxed/simple;
	bh=ppigp21ZNg99k5SITpZMtUx3HYzasDubNk9q/zf7x3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aif8CwIG9FauVwBYO825DdVVv/7u30j1Fcr/gFPFhgV8+IRgifNNieN8isdm5I+k5kOxSSBehoNVPlXsPSpy+kxR4R/7++WYMU+8hoAFraoACJNQuDppDmeYzC0HuCUOELPqxc41yvfxpLpALy+4EMw8AHVCzAd1GUCQIDz35qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VtvxQ6GRkz9v7JM
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:42:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E4982140FAA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:04:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP2 (Coremail) with SMTP id GxC2BwBnoCQdO19myvaGCQ--.14358S2;
	Tue, 04 Jun 2024 17:04:58 +0100 (CET)
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
Subject: [PATCHv2 3/4] tools/memory-model: Define effect of Mb tags on RMWs in tools/...
Date: Tue,  4 Jun 2024 18:04:40 +0200
Message-Id: <20240604160440.498332-1-jonas.oberhauser@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBnoCQdO19myvaGCQ--.14358S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWUZry5tFWkCFW8JrWDurg_yoW8WFy3pr
	ZYgw15Gr4kKryUu3Z3ZanxZF1rWa1xtF13WFn7A34fZr43XrW7Z34rtan0qF9xXFsI9a45
	Zr4jv3WkCa4kAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	CPfPUUUUU==
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


