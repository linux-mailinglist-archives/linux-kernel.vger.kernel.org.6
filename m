Return-Path: <linux-kernel+bounces-303011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2296061B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DFF1C20E26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6520619E7DF;
	Tue, 27 Aug 2024 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VwOvb7Jm"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA319CD08
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751877; cv=none; b=tIqdUWdLDjTdpuVs+WBB5jmkXupUJlbfscaZISQJK05RQ6/Yuxt/DqRr9qyy/uTPb/AxDHbRIKCmDxvvwyYsMhZqxDRC+YRoMH80zism9NypIAAVnVGOSQf7bBqcwtPUGJKLDAkHjrfSN/h7pX6gtuw56vOxxFN+QD1Ox9IG24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751877; c=relaxed/simple;
	bh=qgrAugm1rpQlY/ERueGMv3KYU9B+Bw/8sl4XuiG1TMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Caw64Y9hkpg3MYnI06qA/W16Un2bWZZZFhnoknh3rltoXyJ0+pTsmYWRwXQY6wgB1uabi6vfiaGPVYF15R9zBDWA8HhLq66mG8wxGj+rMJFLT+mIzYdAM2YvRerThDbdqFqf0dzEzeqEzUlN+1MJzEXc4E7WSnMqdDDr9ZCty2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VwOvb7Jm; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724751871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bY2tYcoqP1IclXATq0vpOQDMtlpZe3AUP5YkGxabc7w=;
	b=VwOvb7JmqRXgqPG/mcm+aBgK0ZZ4Qw+8y49Ofhr7t/DYJzfv7VNfppG6UPDhOYgkUk9pVv
	cgvOFU2wWTNkV6MEFiiiSc5aoseI/etlGn5vsEoiCI8GCqors9oaXxkK9Krhn9vQwHFUgU
	2hXK87cyEeu5oY4NB4PcUvuvpYDutx4=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: robh@kernel.org,
	saravanak@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] of/platform: Use dev_is_platform() to identify PCI devices
Date: Tue, 27 Aug 2024 17:44:02 +0800
Message-ID: <20240827094403.166238-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Use dev_is_platform() instead of checking bus type directly.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 86be4dfb9323..3696140bae9e 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -625,7 +625,7 @@ int of_platform_device_destroy(struct device *dev, void *data)
 	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 
-	if (dev->bus == &platform_bus_type)
+	if (dev_is_platform(dev))
 		platform_device_unregister(to_platform_device(dev));
 #ifdef CONFIG_ARM_AMBA
 	else if (dev->bus == &amba_bustype)
-- 
2.41.0


