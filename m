Return-Path: <linux-kernel+bounces-303020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B939960643
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE4B1C22731
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA2A19CCED;
	Tue, 27 Aug 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wi8Pv6Ke"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9321714B8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752318; cv=none; b=NQCMsSGsOygr19tsjwgn9q7CapeuKrSAttqz7E/M+4bO8HhwcQI7mTppVBTP5KbJvamfH46RTwPZ8/YXH3bG9gFC23xl0LfZoC8GpiM1sGVlnzy7N+x1w7nIj1dPbCl9mnWCQ0B0NoBFLZDDRhOb0IO+1fZkeGRzRiaIjV3JkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752318; c=relaxed/simple;
	bh=1p6pmnqI7EqVba9pVVN8kdlQYzKrOCXpB5NqkCr/MMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCwMC18bV+9zh0G9fZUxOMHqY3zdSMh/mZY/Ul9PL1mRC/+lj14Y/48AK50ypp+qQ3TdF9dno1wxz2UXUZvxAJtxgdv5eNBGFy5CjZAAceW1frgqydCJ72RVhs9IqGUuo1jwGa2hBNtDXx5PSC1rO4o6ZmI3zx7pFTCK6IDo75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wi8Pv6Ke; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724752312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vwiC4I+wNAddjc4LjGQaDlHdkw/jV1rVA+GTUj5UF/c=;
	b=Wi8Pv6Ke2VGeL6TmDsMPzkzXQZAZ/EOXh8aPujr3uQ6ZpQEZS3t6uD8pI1jDgf47t2p+eA
	ThlhIF9DPKDMj/N2hjs1UK5/R5Bcn/v83rlVZEFDDKX9HOtYfVjUubXajrUiDf0SdckS4R
	uJSTyn6eevP6rCXNiWArJO15bzrkSzk=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] tools/testing/cxl: Use dev_is_platform()
Date: Tue, 27 Aug 2024 17:51:23 +0800
Message-ID: <20240827095123.168696-1-kunwu.chan@linux.dev>
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
 tools/testing/cxl/mock_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
index 55813de26d46..8da94378ccec 100644
--- a/tools/testing/cxl/mock_acpi.c
+++ b/tools/testing/cxl/mock_acpi.c
@@ -18,7 +18,7 @@ struct acpi_device *to_cxl_host_bridge(struct device *host, struct device *dev)
 		goto out;
 	}
 
-	if (dev->bus == &platform_bus_type)
+	if (dev_is_platform(dev))
 		goto out;
 
 	adev = to_acpi_device(dev);
-- 
2.41.0


