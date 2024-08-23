Return-Path: <linux-kernel+bounces-298404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC2195C6D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC479285B13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA2713CFA1;
	Fri, 23 Aug 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="agU1Kt/T"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155413C9CD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398953; cv=none; b=Ir++Q/vV+hKwpzvVbSGbnMZDmIvMBr+9+OpmT07Efwr+DhqfWg09c/9QYRpim5gr0bZQrfZzjC/nffBnMFCguDxUnxIpHZF9e0X4utabCOOavQwagiMgXvWRlGhd2AiBSJsJzg25Fw/1Qa0bp6tACxmMwoQskQxGSm8TH9o84co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398953; c=relaxed/simple;
	bh=+iTQXUwIBLBhFtVqRuJCkJcyLhUGjB9cLPVfYUzIE2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYmWcjm0nrAoQz+HDQ+KRKF4/OdjnKhf9i52lL5m9IU8GRMXVia1YB+74iig3mw2SYjzZAEysHSmCa3qcGUty8zKgkUopM188LDnTW/uMqqC3EfQjZdsJk7d6yqe0u0M5NTEssHGEZpBQau9Y53QUb2IZxVw1vcHSBkbeMdu96w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=agU1Kt/T; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724398948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N2beJE9EA/48PC40RaXnoPjnKHno18ahUxZsE/ycqxg=;
	b=agU1Kt/TuLilClNG7PJAk+YBMoZ3iDmezR19bfprdXk7VSPmJOQzqDCvWwM3d4rFAE5VS5
	CJI8utNPU1ehsAKZ5A6/zPHaehdlM+gfJ/QkADxCFm/GjGkUz4210HhAXOqe6lgUySNlZe
	QXc4TvJx55sGG2fOE7gzWhWvysmOxS0=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] PCI: Make pci_bus_type constant
Date: Fri, 23 Aug 2024 15:42:01 +0800
Message-ID: <20240823074202.139265-1-kunwu.chan@linux.dev>
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
struct bus_type, move the pci_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/pci/pci-driver.c | 2 +-
 include/linux/pci.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f412ef73a6e4..35270172c833 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1670,7 +1670,7 @@ static void pci_dma_cleanup(struct device *dev)
 		iommu_device_unuse_default_domain(dev);
 }
 
-struct bus_type pci_bus_type = {
+const struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
 	.uevent		= pci_uevent,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4246cb790c7b..0d6c1c089aca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1098,7 +1098,7 @@ enum pcie_bus_config_types {
 
 extern enum pcie_bus_config_types pcie_bus_config;
 
-extern struct bus_type pci_bus_type;
+extern const struct bus_type pci_bus_type;
 
 /* Do NOT directly access these two variables, unless you are arch-specific PCI
  * code, or PCI core code. */
-- 
2.41.0


