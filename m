Return-Path: <linux-kernel+bounces-242132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDE928405
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB4D2829D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4A1448FD;
	Fri,  5 Jul 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="luoWaTAu"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22124596E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169243; cv=none; b=qO7rst8OkYtFx+mv42LzKwbmlhjqPiZhySXCbHRd1zPlc/Y5/cyKXJnrhv5i39NTbPmPvUlf9TycE80oecSuPv2gbyK0K1CvM2trWvcZCsv2GjL1KDJQb9Gzb2oXJ5Q4GbrMbs9r3rpVcdudoAA+M9TMXwLybqfG5dviNHTL3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169243; c=relaxed/simple;
	bh=tEvumqwd3KGmnqz/DKjUD8+JIVJDhi1tLnPm2ljTvEM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YaWT1eBfDoIAALiBTaWJdj04KhbA5oQF9SSc8G7JhgZ8pETI38XhQv3wLxPPMx37JErwSnq9+rM7VPI8yJhpbcEQ0goLHibnjgfrH8jnncM0/enuTig+rZNohDjT6v8Hv3lFFMdwx2yKGfrqChRIS/l4j6GrJ2DqwUUE+bMjtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=luoWaTAu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7520820B7001;
	Fri,  5 Jul 2024 01:47:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7520820B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720169235;
	bh=bfHIOF5qZceUtl1oIJPlt2YVFrRSH8tcL6/+A6DJaig=;
	h=From:To:Cc:Subject:Date:From;
	b=luoWaTAub7dOVfSMiSaVW9kNkEDoUZU353+xdiflgox6ts30u/erv+a/ZBT9FiRnW
	 1HZndEJ/qabFrs3LNqb8mZjKR9InK3jLURmUTGDCGuGWd6zAgdFN4ncZ4CDdAElwwx
	 ff0b8vcXsFqpPkJ4+FWQkCjT1P2URzQmNVRfWlVo=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	wei.liu@kernel.org
Subject: [PATCH v2] tools: hv: suppress the invalid warning for packed member alignment
Date: Fri,  5 Jul 2024 01:47:07 -0700
Message-Id: <1720169227-20465-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Packed struct vmbus_bufring is 4096 byte aligned and the reporting
warning is for the first member of that struct which shouldn't add
any offset to create alignment issue.

Suppress the warning by adding -Wno-address-of-packed-member flag to
gcc.

Fixes: 45bab4d74651 ("tools: hv: Add vmbus_bufring")
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/all/202404121913.GhtSoKbW-lkp@intel.com/
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V2] Added 'Fixes' tag

 tools/hv/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index bb52871..2e60e2c 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -17,6 +17,7 @@ endif
 MAKEFLAGS += -r
 
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -Wno-address-of-packed-member
 
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
 ifneq ($(ARCH), aarch64)
-- 
1.8.3.1


