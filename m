Return-Path: <linux-kernel+bounces-382320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2377B9B0C51
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67111F26818
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8606320A5D0;
	Fri, 25 Oct 2024 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fCXgk42h"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16B206505
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878993; cv=none; b=Vg0GJ58bolL3sclR7d6do3bWyk5LCf0EZTCTIvQjrs9fr6TVCjFlSPuWJeKH5un6xAuvM+JzHaIwXguAuF6IP04Ox5BLSMYmWxeBMFJhmbid8LGxRdOW69Z6XPFZDH3UM6vcTIPBCxaVw/IxSi0QF9T79T0TBmxHA5cFCImMTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878993; c=relaxed/simple;
	bh=7HABu5UHyvNS5lHhlE+OtO+lTciqgbmZMwedje1qNdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GIZCGYaKlmHqKULE62vcJprUI0pN/MN/2yi2CfAVu7zxAo/y1USO5scAC5BckOdxKg7HGYOUOt0xdA1FuSVmyCzke1eU1n4VjHWz1AKbUxGMmc8xjqvimbkpd3N86ACcFqud6bom10rAWQuysth6SIsEQX1ZJBZgJ1jJMwTFDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fCXgk42h; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729878988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PiyqamZokvGQbMIllG7O8OFwcxqwj7PKjocQ08OcuZw=;
	b=fCXgk42hKmDm45qW6j6QPaXRUKy7M8bWP8SLOSqzQCGWUDrc81JQkg0EUudUGofAmAAP+m
	gl6zHifaPGjjosN74uDk5KKE7t6B6ccq8yz2VDN5YNVWXv6DQt2Dow7xNfm/kLDVfwscmh
	+nAnYyZFtWOPuMXe/hg05mx7m0O95Qw=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/etnaviv: etnaviv_cmdbuf.c: Drop the unneeded include of drm_mm.h
Date: Sat, 26 Oct 2024 01:56:20 +0800
Message-Id: <20241025175620.414666-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The etnaviv_cmdbuf.c doesn't reference any functions or data members
defined in drm_mm.h, remove unneeded headers may reduce kernel compile
times.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
index 66a407f1b3ee..7aa5f14d0c87 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
@@ -5,8 +5,6 @@
 
 #include <linux/dma-mapping.h>
 
-#include <drm/drm_mm.h>
-
 #include "etnaviv_cmdbuf.h"
 #include "etnaviv_gem.h"
 #include "etnaviv_gpu.h"
-- 
2.34.1


