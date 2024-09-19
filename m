Return-Path: <linux-kernel+bounces-333507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFEB97C9C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5396B285844
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8919D096;
	Thu, 19 Sep 2024 13:07:46 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29A19DF6A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751265; cv=none; b=LWviZ+FQDN6TmFM3kr6YDs0H8st6mhiD9b6kmkWDrye2xreJEcrxZkJU/uMmK4AHGwruJhRlQAnZAzYEmeA1bjHCjAsvA/k2dQXuLzfW+smeQESTgB7c5155Np7/TbxX/02ewQvoIlrke6jLKY3BcEKzbjPixRVSzmslBJ0MRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751265; c=relaxed/simple;
	bh=ppigp21ZNg99k5SITpZMtUx3HYzasDubNk9q/zf7x3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNkT1sFCHTaYqTJ/cxbZYqehlWCrTlewEe7Rs+roSY5wCr6+zByU5dvje9PR5K9kjQTx8ZqkvTOl733m0aTie77w53ylrMV8K8I/F823IZZ25tW/SA8O5tXyPWFTddy4sNzWtSBbausDj1oRuhaztfYnebVxG0ppO3/BpbYIh+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X8b0L1T1Pz9v7Hq
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 20:48:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 434031407B1
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:07:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP2 (Coremail) with SMTP id GxC2BwBnFsfqIexmRoM8AQ--.55331S5;
	Thu, 19 Sep 2024 14:07:35 +0100 (CET)
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
Subject: [PATCH v3 3/5] tools/memory-model: Define effect of Mb tags on RMWs in tools/...
Date: Thu, 19 Sep 2024 15:06:32 +0200
Message-Id: <20240919130634.298181-4-jonas.oberhauser@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBnFsfqIexmRoM8AQ--.55331S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWUZry5tFWkCFW8JrWDurg_yoW8WFy3pr
	ZYgw15Gr4kKryUu3Z3ZanxZF1rWa1xtF13WFn7A34fZr43XrW7Z34rtan0qF9xXFsI9a45
	Zr4jv3WkCa4kAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI
	8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRuyxRDUUUU
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


