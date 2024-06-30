Return-Path: <linux-kernel+bounces-235122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F691D075
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062E2B21091
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD273AC0C;
	Sun, 30 Jun 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hQ4+nIOv"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1943F9D2
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719734654; cv=none; b=Auq+ssJd36QHir1QJGif15AVjAst89Q01cZnnKpSJh+nInvmI6wgVqaVQnS7qo+bisI3IY8rhLUk9fq2ab6lwTjTUimVndHQMLw3KvpjONqWqpPXcuehzfK4kMSD4ibS2W+HUX4vT5ahNYgEq+VZbueg++3K10MVLmk9sLJEU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719734654; c=relaxed/simple;
	bh=WYYyDe+PGZDGC6762tiMQ7n2gRKVRkw9J9qpPSca9Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RxS2y4b3N4KUmJ07sc58I3mbGZYvQsAVoct/7Gx4+h9JB6se/p+aVdPJblr+6iTDCnE2qhmNHGnTcm3ueWKKS5YqSNu/qTg6rkunYUsimwY98L9zU19tXNe26e9YmV0SjBbbCrDzeE4Js/rqnHulEpvfbVnFETNYs3HMEcu2tms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hQ4+nIOv; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=EkirPbUpx3jiuqgqAu4ILi1CfYfxgFiMB0O5iUzKH5g=;
	b=hQ4+nIOvp7Zenz6fa3aLPhZcVDVxM57Yt/efYm73rmAL+y3sdlVZQ+8r5zycLj
	POZfx+DEVJBJ6GD7MCkWvYl5nl7/lTV4VI/yO19D09C73X2G1Gbez9vL3qu+Irjh
	AIcnrh0dbWHB0FG53umUiPkiD0ZeVMEh4LDhTafRJKx/4=
Received: from 张春-pc.localdomain (unknown [183.160.104.53])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3v54zEYFmnuvWAA--.19433S2;
	Sun, 30 Jun 2024 16:02:59 +0800 (CST)
From: shaohaojize@126.com
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	jiaoxupo@h3c.com,
	berlin@h3c.com,
	zhang.zhansheng@h3c.com,
	wang.yul@h3c.com,
	linux-mm@kvack.org,
	"zhang.chun" <zhang.chuna@h3c.com>
Subject: [PATCH] mm: fix kmap_high deadlock
Date: Sun, 30 Jun 2024 16:02:55 +0800
Message-Id: <20240630080255.1901-1-shaohaojize@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v54zEYFmnuvWAA--.19433S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3Gr47uFW7Cr47Kw17KFg_yoWkuwc_JF
	93tw4xCrW5WFnIkwn0ya1fWF1Fkws5Zr4UWr90g3y3AryjqFyfuF95CFZ8Ar1DGFW8uayk
	Cr1YqFZ8Zr13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjWxRPUUUUU==
X-CM-SenderInfo: pvkd0xpdrmx6bh6rjloofrz/1tbimhYOQmVLcI6xSwAAsq

From: "zhang.chun" <zhang.chuna@h3c.com>

I work with zhangzhansheng(from h3c) find that some situation may casue
deadlock when we use kmap_highand kmap_XXX or kumap_xxx between
 differt cores at the same time.kmap_high->map_new_virtual->
flush_all_zero_pkmaps->flush_tlb_kernel_range->on_each_cpu,
On this condition, kmap_high
hold the kmap_lock， wait the other cores ack. But the others
may disable irq and wait kmap_lock， this is some deadlock condition.
I think it's necessary to give kmap_lock before call
flush_tlb_kernel_range.
Like this:
spin_unlock(&kmap_lock);
flush_tlb_kernel_range(xxx);
spin_lock(&kmap_lock);

Signed-off-by: zhang.chun <zhang.chuna@h3c.com>
---
 mm/highmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/highmem.c b/mm/highmem.c
index bd48ba445dd4..12d20e551579 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -221,7 +221,9 @@ static void flush_all_zero_pkmaps(void)
 		need_flush = 1;
 	}
 	if (need_flush)
+		spin_unlock(&kmap_lock);
 		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
+		spin_lock(&kmap_lock);
 }
 
 void __kmap_flush_unused(void)
-- 
2.34.1


