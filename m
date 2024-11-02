Return-Path: <linux-kernel+bounces-393307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81869B9EEB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074AC2829A6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8223416F0EB;
	Sat,  2 Nov 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CTBgNHQf"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0382E40E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730543510; cv=none; b=o8HrO08yddkHHuWjl1Ivl6zv8uYcXRcp1z4fRophZPwUG9faRIb7kd1EoXVQa5Kvr0r/OGseZoaw8DVP0S/dGDoiIOGygI3Rg/VpSgv1G48z5y9PLYwUIRBf1XuzrXyZYSL2Sed0khCxCXuEIBtLv/xDIBaAfN4kqBJUgY1ev5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730543510; c=relaxed/simple;
	bh=yZPPUH6ue0EIgIQAaBu+MmEG5W4yaTJFey2BO3YITSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JO/KbzIrjkyaw1qM69XwxGEzy6387V8Z9IBb1ENH0xyxx7m1nTz0lgD25PfCctl4r8Lcg2f47H/gJx/3duuX9ycG2pT/xeFOaYHQ0+8WYWk7BfAIhpVp+EO9jo/5Awuohp4ePJ/WfsVnK6jUR5eJ8JImJeT6dFn+QQRJHFgqCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CTBgNHQf; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730543504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mdZ1ofPnDwIKGty1EFlJMkse4Ixx52CWfQM0ioZP/A4=;
	b=CTBgNHQf646DAnkeEr/vqxwIsbyCG3Zz+s6tDL7bG8NhrSmKcm8tJpkWoi1XmwDO2Qlnj4
	vqmG4XjsKydmI1vUiWh7kH/UWzm1U8wnIsCgXSJ2qOtDXB9V2IozzgCQs9Na9qwq33egKE
	pyBN26b638l0BtHed8/RXOUVyAj3k0c=
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
Subject: [PATCH] drm/etnaviv: etnaviv_cmdbuf.c: Drop the unneeded 'etnaviv_perfmon.h' header
Date: Sat,  2 Nov 2024 18:31:34 +0800
Message-Id: <20241102103134.3480050-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The etnaviv_perfmon.h header is about performance monitor, it can hardly
has something to do with command buffer suballocator. Drop it.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
index 7aa5f14d0c87..8c66715ee1c9 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c
@@ -9,7 +9,6 @@
 #include "etnaviv_gem.h"
 #include "etnaviv_gpu.h"
 #include "etnaviv_mmu.h"
-#include "etnaviv_perfmon.h"
 
 #define SUBALLOC_SIZE		SZ_512K
 #define SUBALLOC_GRANULE	SZ_4K
-- 
2.34.1


