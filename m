Return-Path: <linux-kernel+bounces-201034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5091F8FB916
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108E0B32009
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04706148315;
	Tue,  4 Jun 2024 16:04:40 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A26148318
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517079; cv=none; b=aflczT4CbX5/AXCZOLwVE1H2NAs0eHfkh27rVV/rQ1/mIwWgkV9g5swlLoo1Chzkc92hP8kYe41JmTDXTI5KNhoCnzsdzXg29ToFjHdOciqAyWAb8r53gP4OBm2xqnfP1HoP7/B6apWo+hioTfIlkK/wqaELF+bxtVoxcJ5gdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517079; c=relaxed/simple;
	bh=xLrshINXFNdrylWYQWWaisBvYfqOz7VcgvqZYTDpaVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZWtr4KKhlvRu2bTP8gLipNznQJ71HzoMsMHsRJ0qDFZYf9yeTTvNoXWIweTDcMaznB2Nw6rMSCzASW57LPwrF3whtEfZqoRiHSWDfjravBZN8E21k8L1ilqFt+l5esmLGr8cyebZGKSqcy5OkpJd4v8e35tXJPZDw2sWuYgirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vtw2K1PGVz9v7Hq
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:47:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DBB04140F79
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:04:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
	by APP1 (Coremail) with SMTP id LxC2BwCHehP+Ol9mXzeKCQ--.59465S2;
	Tue, 04 Jun 2024 17:04:27 +0100 (CET)
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
Subject: [PATCHv2 2/4] tools/memory-model: Define applicable tags on operation in tools/...
Date: Tue,  4 Jun 2024 18:04:09 +0200
Message-Id: <20240604160409.498190-1-jonas.oberhauser@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwCHehP+Ol9mXzeKCQ--.59465S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48tr4xXr45XrWDJFy7ZFb_yoW8Xw43pr
	WkX3y5Kr17twn3Z397J34fuFWrWa1rGFy5GF92v3sxZryUJrs2ya1DWanIgF9aqrW3GayU
	Za1jqFWqkw4UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUos
	qXDUUUU
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
 tools/memory-model/linux-kernel.bell | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index dba6b5b6dee0..2f49993644ed 100644
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
-- 
2.34.1


