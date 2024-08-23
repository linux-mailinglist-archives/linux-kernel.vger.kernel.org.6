Return-Path: <linux-kernel+bounces-298446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBAA95C771
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4426B1F25E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12851474D7;
	Fri, 23 Aug 2024 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U8r8HRX+"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA513DDC3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400455; cv=none; b=dbSrIu6Bq/dN4PCuhfgME5n9NQ5Pbc7nDzIR/ffLx7bwciPph9EAofGMLWZTyDfLwGhTCB79N45r/jTCNwr3WaUY2zms8aPcqdlXT579sFv69pBC/BhHbJd+bTjXKKsgeyuTkt5/pf4/NGynms3CfKnA6RKGFGe7BQwwGYIWjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400455; c=relaxed/simple;
	bh=QURK93jpnDhdkzPAI21Rp1v/Jku3+w+7UPOptIm0Uro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjufNnT7mbnh6AXmXwTEca5EZQ+HxhZgWmWRyl367x8gP7aEzizui6+yEDpPTtY5OJ/PrTGjDIfrm7UoyIQX5RGHjm85UGlWApuJRf0/vK89Y+/jgh8zFhvr7hcwfbmQeOmCReHkCmgjIxmof+n7KJotynh5Jw1leGvJhyrGNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U8r8HRX+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724400450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q06oqOIsnlBXOPeX9QmHFvGk4DIwl/omFgxTtDgtIdY=;
	b=U8r8HRX+MecBuIaubX7KG/DiqadhPH9bhKB6ZsqgHjrqEPmVNOcWeKKALOFqm+jJJJ5q2q
	NM1/DahPLSsLPc8CzzmlNNtXKZE92L65cA5hYLe/8lLlZtSHhkPDuCExOrVEgE88ldZ671
	qe6c9qxPO+zPKVJx0llqA0qAevsRhfU=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: thierry.reding@gmail.com,
	mperttunen@nvidia.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] gpu: host1x: Make host1x_context_device_bus_type constant
Date: Fri, 23 Aug 2024 16:07:24 +0800
Message-ID: <20240823080724.148423-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the host1x_context_device_bus_type variable
to be a constant structure as well, placing it into read-only memory
which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/gpu/host1x/context_bus.c   | 2 +-
 include/linux/host1x_context_bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
index d9421179d7b4..7cd0e1a5edd1 100644
--- a/drivers/gpu/host1x/context_bus.c
+++ b/drivers/gpu/host1x/context_bus.c
@@ -6,7 +6,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 
-struct bus_type host1x_context_device_bus_type = {
+const struct bus_type host1x_context_device_bus_type = {
 	.name = "host1x-context",
 };
 EXPORT_SYMBOL_GPL(host1x_context_device_bus_type);
diff --git a/include/linux/host1x_context_bus.h b/include/linux/host1x_context_bus.h
index 72462737a6db..c928cb432680 100644
--- a/include/linux/host1x_context_bus.h
+++ b/include/linux/host1x_context_bus.h
@@ -9,7 +9,7 @@
 #include <linux/device.h>
 
 #ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
-extern struct bus_type host1x_context_device_bus_type;
+extern const struct bus_type host1x_context_device_bus_type;
 #endif
 
 #endif
-- 
2.41.0


