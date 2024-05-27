Return-Path: <linux-kernel+bounces-191063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1674A8D062B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE48298B51
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743161FF9;
	Mon, 27 May 2024 15:23:57 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F461FF6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823437; cv=none; b=MrOmFVFdxO7dV0/fYpyPzQvIpR0/wC8vaNC07uCNXk5Gqv5uyY2lQm+gvRI1N/jO6b08I9/MK4CmzKf2hXz0QnENUU+vxiNO4NsNFEcbgZ06JoEpgYOdUiU7+e654gIzA0C/kGLNFD2aFmLONgLMJV6lrDkS3s9RnanO1uBnWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823437; c=relaxed/simple;
	bh=0xHMFCV5yP3qe4unc9YAGElnXn9fL7ClqpQqFLGvio8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSdem08gC/27ggVptZ8V/zzSvUnfKjA+5yiN9TPifWo23hrELjfRQtZZainWpdD+TSiFpvW0iSpmgX4NMitOSnsYV4o2cGRhs4Lj9su0TwN4HTNPCq/Mgnp6iOEF9rUpzqONFLo6ILR1s6MhpMO0b9/tewx8yLhE37SFJVVvpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VnzPk5WD3z9v7JM
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:01:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 925C2140485
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:23:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP1 (Coremail) with SMTP id LxC2BwAHshpgpVRmXLgGCQ--.41702S4;
	Mon, 27 May 2024 16:23:46 +0100 (CET)
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
Subject: [RFC][PATCH 2/4] tools/memory-model: Define applicable tags on operation in tools/...
Date: Mon, 27 May 2024 17:22:51 +0200
Message-Id: <20240527152253.195956-3-jonas.oberhauser@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHshpgpVRmXLgGCQ--.41702S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48tr4xXr45XrWDJFy7ZFb_yoW8Aw45pr
	Z7X3y5KryUtwn3Z39rJ34fua4rWayrGFW5Gr92k3srZr98XrnFya1DXan0vFZaqrW3JayU
	Za1jvFWqkw4UCrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5OJ5DUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

Herd7 transforms reads, writes, and read-modify-writes by eliminating
'acquire tags from writes, 'release tags from reads, and 'acquire,
'release, and 'mb tags from failed read-modify-writes. We emulate this
behavior by redefining Acquire, Release, and Mb sets in linux-kernel.bell
to explicitly exclude those combinations.

Herd7 furthermore adds 'noreturn tag to certain reads. Currently herd7
does not allow specifying the 'noreturn tag manually, but such manual
declaration (e.g., through a syntax __atomic_op{noreturn}) would add
invalid 'noreturn tags to writes; in preparation, we already also exclude
this combination.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 tools/memory-model/linux-kernel.bell | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 1b2444cdf8d1..08fa1ccb1328 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -36,6 +36,13 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'after-srcu-read-unlock (*smp_mb__after_srcu_read_unlock*)
 instructions F[Barriers]
 
+(* Remove impossible tags, such as Acquire on a store or failed RMW *)
+let FailedRMW = RMW \ (domain(rmw) | range(rmw))
+let Acquire = Acquire \ W \ FailedRMW
+let Release = Release \ R \ FailedRMW
+let Mb = Mb \ FailedRMW
+let Noreturn = Noreturn \ W
+
 (* SRCU *)
 enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
 instructions SRCU[SRCU]
@@ -82,4 +89,4 @@ let Plain = M \ Marked
 let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
 let addr = carry-dep ; addr
 let ctrl = carry-dep ; ctrl
-let data = carry-dep ; data
+let data = carry-dep ; data
\ No newline at end of file
-- 
2.34.1


