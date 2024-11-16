Return-Path: <linux-kernel+bounces-411655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9379CFD75
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A02E1F22E38
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B854192D8F;
	Sat, 16 Nov 2024 09:26:25 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C216D9DF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731749184; cv=none; b=EsR+Jy2Y57QwdxPC0/CTf/SKnNILxu31+e4qz0w33tGHpV6D7GFLsRA7igL/Lx8hxczrOIHWwV/10X1z4z2GaruKAvnSbYhg+WJE3Kp5vaYWHBhIaT8sjwhZk0KiWSuWiS4WjQPCfk9yD8A6e5nFEbXqGtgRA4ka9gRFFpuSTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731749184; c=relaxed/simple;
	bh=Y4o6hWQYEWd3MyBtMl93Tmwu8wlGBh7XmphN3Mz9zf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iq6iBLxcJ66+3jvVpXJvlb6dP7iqWHaLOGqCqQ1UHMjxTdSPEqDUCz7VzO3km6PG5waOl6farAf2YioHEwnpN1ekVbOofSEW5Co4n3yKAHqnEjEXlPs4bwmM91mz0FZ+YRTuVE/UjrUNg+oChHTs/2s3Bg9hUmd7tB1SQtX9s2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xr7mS2y6Lz4f3kFL
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 17:26:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF1B81A06D7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 17:26:18 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDnDoMoZThnJYjBBw--.28482S2;
	Sat, 16 Nov 2024 17:26:16 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	david@redhat.com,
	willy@infradead.org,
	ryan.roberts@arm.com,
	baohua@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com,
	xieym_ict@hotmail.com
Subject: [RFC PATCH v2 0/1] mm/vmscan: move the written-back folios to the tail of LRU after shrinking
Date: Sat, 16 Nov 2024 09:16:57 +0000
Message-Id: <20241116091658.1983491-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnDoMoZThnJYjBBw--.28482S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYa7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The issue has been dissused [1]. This patch is following Barry's
suggestion to fix this issue.

---
v2:
 - detect folios whose writeback has done and move them to the tail
    of lru. suggested by Barry Song

v1:
[1] https://lore.kernel.org/linux-kernel/20241010081802.290893-1-chenridong@huaweicloud.com/


Chen Ridong (1):
  mm/vmscan: move the written-back folios to the tail of LRU after
    shrinking

 mm/vmscan.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

-- 
2.34.1


