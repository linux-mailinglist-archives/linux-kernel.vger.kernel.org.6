Return-Path: <linux-kernel+bounces-194976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C869C8D453C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64679285C47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 06:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C8014372F;
	Thu, 30 May 2024 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YXUhH0kQ"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0687F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048967; cv=none; b=cffEm7ostbS0HaG4QEFlVloLNNM6/4Da6SMKO1NsHZKpc+/iLcUiYI7XpvO36G1FhGZuK3hmNAD2J51GHdPiMnQirJlBRroMZQnFis28fjpmFqzYP5/4/KjwdA6+FFtWj4OW36BT5c/NRe3uILwTFQLN/Nr+/XA6EiY28tru2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048967; c=relaxed/simple;
	bh=/i1m66s0EfCscMPh83u0s2InZy1Wj4FCUw7VnWimfgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S6UcuKn4LcYMAEcgl+5kinNSj6uHMNgo+7RG22xqrtisd0wxvFVzsdJIrhDh1rKi5yrpvH+p8s+4IvaTa6/B55AnlBZdvMop4eCAQHjuQ7wkXIUIyBRQ8wn4x+NOhcuogyp/JLQZxGuucULREaM/qDHjv94QOsyJt2eIEYwbfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YXUhH0kQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roy.pledge@nxp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717048962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oIBMH1m3ZhE+OQ4EQa7OLK0X4q+1xx+6DaOvj7nfR6c=;
	b=YXUhH0kQp6h+U2qVsMeMrBTVsfKQBFt0YL6U6891H9252W3fDBdnIVl1C1vvtChqmm2N3z
	os3xR/vo545lDdkDef6SNKJTjdpNsZmxVK1zB3Qgh9VgF32U+7xKV8n+MWbna7RPcFuuVR
	qlLH0Av5/7xjDii+zmUgeqVP51nau9s=
X-Envelope-To: leoyang.li@nxp.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: lkp@intel.com
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Roy Pledge <Roy.Pledge@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] soc: fsl: dpio: Add prefetch.h includes fixing potential build errors
Date: Thu, 30 May 2024 14:02:09 +0800
Message-Id: <20240530060209.1074031-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

If the architecture does not implement prefetch() specifically, the
following build error occurs:
   drivers/soc/fsl/dpio/dpio-service.c: In function 'dpaa2_io_store_next':
>> drivers/soc/fsl/dpio/dpio-service.c:745:17: error: implicit declaration of function 'prefetch'; did you mean 'prefetchw'? [-Werror=implicit-function-declaration]
     745 |                 prefetch(&s->vaddr[s->idx]);
         |                 ^~~~~~~~
         |                 prefetchw
   cc1: some warnings being treated as errors
--
   drivers/soc/fsl/dpio/qbman-portal.c: In function 'qbman_swp_dqrr_next_direct':
>> drivers/soc/fsl/dpio/qbman-portal.c:1213:17: error: implicit declaration of function 'prefetch'; did you mean 'prefetchw'? [-Werror=implicit-function-declaration]
    1213 |                 prefetch(qbman_get_cmd(s,
         |                 ^~~~~~~~
         |                 prefetchw
   cc1: some warnings being treated as errors

Include the correct header file to fix the problem.

Fixes: f1e250bf3659 ("soc: fsl: dpio: Add prefetch instruction")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405300328.eZmSYZrP-lkp@intel.com/
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 drivers/soc/fsl/dpio/dpio-service.c | 1 +
 drivers/soc/fsl/dpio/qbman-portal.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index b811446e0fa5..a4692b9ad8d7 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -9,6 +9,7 @@
 #include <soc/fsl/dpaa2-io.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/prefetch.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 0a3fb6c115f4..1c0bf04b101c 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -7,6 +7,7 @@
 
 #include <asm/cacheflush.h>
 #include <linux/io.h>
+#include <linux/prefetch.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <soc/fsl/dpaa2-global.h>
-- 
2.34.1


