Return-Path: <linux-kernel+bounces-250365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C12D92F6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64201F22D60
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805B01422B5;
	Fri, 12 Jul 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kZ6ICVUS"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4993BBF6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720772898; cv=none; b=gahGGDDatjoQMHlVB5KH7BtcBBY+wWhUWMlbUhud63qW5ti3DQRkHNcsaop20AURg3O2w9iJq/+NbBQVP0Xxr7q+CHpH+p43bZLsH1mTQo6KW74I9cgB6ttlti4GhWKTBbzGXK8P1b/2WfakAYIu45DZbwg/4XsewLu9O5rkFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720772898; c=relaxed/simple;
	bh=a9m1zjaq4LV77fAPkesH4ladjL21NUFf2xIpkhPo3y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bwpPJTvDOWyTqdYGoxxd+OP9HwgTz4HM5pbfyiEfiYj1uG3YyZDJ7A+puYOWd38e1k6IaWkCULdAUzqoZ4PVt2w3Ja8pmRc71VV9jY4811pRbXXVpdo7D+CGlPoz7bI6fKf9kbPjMSL29j1XeDo4R+fDjrEWysAzelxZcWzK7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kZ6ICVUS; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720772887; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=N7aJHwqiqCJi0t4/+kQXsTYMwz9HxmQ/g1e6LfOCtpM=;
	b=kZ6ICVUS+f3ZsOJJssvp3QCh5u2/eEsGK+fnb9djNl6kNeiO4uxtfawx0Q8FnD8Sf5JhaCnlHu8Rwc1gAZyzXvBvQxftfNNk2jBOS9FaiC5U1ciYGIiSxusA/l39V1dJ9w8fUqAAEQnO0/ckRBOTgtI1d+2W5AB8lr7rODO5vhw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WANTBc0_1720772886;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WANTBc0_1720772886)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 16:28:07 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: daniel@zonque.org
Cc: haojian.zhuang@gmail.com,
	robert.jarzmik@free.fr,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ARM: spitz: Remove duplicated include in spitz.c
Date: Fri, 12 Jul 2024 16:28:05 +0800
Message-Id: <20240712082805.98629-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files linux/property.h is included twice in spitz.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9519
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/arm/mach-pxa/spitz.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 452bf7aac1fa..97ecd79c9679 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -29,7 +29,6 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
-#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/memblock.h>
 
-- 
2.20.1.7.g153144c


