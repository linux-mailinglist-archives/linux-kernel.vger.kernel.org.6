Return-Path: <linux-kernel+bounces-298184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9759595C39F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FDB28350C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D837165;
	Fri, 23 Aug 2024 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MV6UcXue"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184929406
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382780; cv=none; b=EnxmzSbsoWxHaM/0YnHYcZKQY1tUOV1+tVJsMGhNOd2kU+a6zsMVqFML9yEcTiIoAsjC+SiF6sFOOBC4+R3A681hSisw17Z/83cb4hTi5p0m8fOw2WSD02B1TTkyJNxS1uAfubhsrrB0nhTuZ/Y9lmakgVS4ndukwHzs5IqzrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382780; c=relaxed/simple;
	bh=e8M4hGn3F6HeLuW+kugt6mk213gGZGxeB9qx6qGGYJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+b1p518OHt3mt+Fd0hwmoxenY+UJORzjkkB9YzgFnnnfpDKs9BFB0qBXnckHtnUL57FNiOimAZQiLTUFbT4aLDQrL4DXP93z7zW9+nYqxduP7kalg1xmkxTkqSztl7OtJcpzb9y2k9FclX0BvFUPlBozHtBCuIznogY9iKLq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MV6UcXue; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724382775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=toen39aZXqfvfK7VRtTkKuy2dJycPw3LN43FvI2iTIE=;
	b=MV6UcXueObDmrw/ncEl82PBIJubanNZGiV4nPx2P93yD3hWnm7ijAT+NfjAqGDkPpPUQ0O
	BnBGfchKJwHNKAL/zxECDQLruoo7y6XdwUDwoZLthzhPgFT/c7iBBZGE33LWjcK8GpDrcS
	H++1nXvpJqc7m/uedA37OTtk5Pz+Eco=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: manivannan.sadhasivam@linaro.org
Cc: gregkh@linuxfoundation.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] bus: mhi: host: make mhi_bus_type const
Date: Fri, 23 Aug 2024 11:11:28 +0800
Message-ID: <20240823031129.49010-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Now that the driver core can properly handle constant struct bus_type,
move the mhi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/bus/mhi/host/init.c     | 2 +-
 drivers/bus/mhi/host/internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index ce7d2e62c2f1..a9b1f8beee7b 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -1464,7 +1464,7 @@ static int mhi_match(struct device *dev, const struct device_driver *drv)
 	return 0;
 };
 
-struct bus_type mhi_bus_type = {
+const struct bus_type mhi_bus_type = {
 	.name = "mhi",
 	.dev_name = "mhi",
 	.match = mhi_match,
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index aaad40a07f69..d057e877932e 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -9,7 +9,7 @@
 
 #include "../common.h"
 
-extern struct bus_type mhi_bus_type;
+extern const struct bus_type mhi_bus_type;
 
 /* Host request register */
 #define MHI_SOC_RESET_REQ_OFFSET			0xb0
-- 
2.41.0


