Return-Path: <linux-kernel+bounces-169224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B228BC529
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 03:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBD11F21B84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 01:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD04383B2;
	Mon,  6 May 2024 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n/NWWsZU"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3EE1A28D
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957894; cv=none; b=ZUm5si2RynndLO4NNSZ1MbpeuVjTS3DUtBtSppAWuTZ3ANjrllOL0ceV2FHhNlXsD8Z3AsnKeDbQZO+0uMi2Bmgx7adYThzcIo+KyA2qLJzV9Wy+eRlu4FLwiR1TktaZZiF0y96uW6NcsaGTkKJwiLdYWKVI71014fXUCLB7Oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957894; c=relaxed/simple;
	bh=/p7YUUW938hkm/WjoZddvXrUZA9IxWHC00ipPG7x+yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sbnbVUKm6NZ03FthaOpCPp2VbBhiR8Lortjxk1WO4J4tI87yaeLVV4sfi9hQ6KYtA6WaadKP93OVZ+z+xlJS4+vACz2NrObXLOmMR/566pI2VuN1nO0M54zUgah2NI2bWERmoDdudxRpN2jRygQtCQ5jWLIB9y8kuz9ZBNw4XZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n/NWWsZU; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714957883; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nfeEy764PjJmm2hNAZ96dBiIs1iOgWMjNMaCbgQ4Iz4=;
	b=n/NWWsZUcxqqx1Bv+Pcm+2YRg9gSz1c2fH/Th3KHDbc9OSJ71+BxHG6RnPEYkTUX3jb6D0gIBhd2FAZJvne7PfhRyPLp1KUDxD0ZO1dIu6OA7vaqtXgkcmIfNz8elDE6xrLJxVb1dgPa7hMMEsViVyBi2IguR6cEgzicbI0N6Jw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5pR6Ly_1714957881;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W5pR6Ly_1714957881)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 09:11:22 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: suzuki.poulose@arm.com,
	alexander.shishkin@linux.intel.com,
	mike.leach@linaro.org,
	james.clark@arm.com
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] coresight: tmc: Remove duplicated include in coresight-tmc-core.c
Date: Mon,  6 May 2024 09:11:21 +0800
Message-Id: <20240506011121.39179-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files linux/acpi.h is included twice in coresight-tmc-core.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8937
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hwtracing/coresight/coresight-tmc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 4f11a739ae4d..b54562f392f3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -26,7 +26,6 @@
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
 #include <linux/platform_device.h>
-#include <linux/acpi.h>
 
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
-- 
2.20.1.7.g153144c


