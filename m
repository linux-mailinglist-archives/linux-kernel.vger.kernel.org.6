Return-Path: <linux-kernel+bounces-532946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ABEA4540B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B10C7A774B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405AB25A34F;
	Wed, 26 Feb 2025 03:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vA3r6rui"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529725A321
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540940; cv=none; b=CXiawVfD9/5ZT39JjE/Je8sm9vgsX6ALHgYQmyjcN3mA52md4mj+GOTCK+IlFVhOH8idBdtP9jZyTr6naMsSozK1mBuh40C7O0nttaD6+aOGWgPdFevgu20ByR79wjMD1LA0muBLEd98a+JkwLd5wJtmslF7kfVPWi/RNDEHGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540940; c=relaxed/simple;
	bh=zuAavyPOyaGNoBaXMmycu2V5MlApCXpaDvViGEoLJiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGQsQauruFgF/4+Fl9mBKFhLtjpPXCURCAyJqomGvbdjSdK+GVTucNPD8BYFVAV+19BKQp4sUEd0EPd6TEUNfNIzA+6UbP3yCl93++decZrTD4QlZgsmx1r5G8RQhGB7DDgOBeIwN2cJ26SgY4XrK8Yv6lp/Ue07qS1sz7C9rmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vA3r6rui; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740540937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whTHU5N4NTfcQQqFGoeBdYpW8wfRJ2uxOJdRxlDXCiU=;
	b=vA3r6ruiJTSr89JEMoh3+EzKEKgtjoq8MhXKZ+AzS0HDumY9K/wH3T4ASEPqUkjhjZbueR
	u6kFBeDu+kAh1lFppyYwDertaimpeLJSIVptxIdfN4wgJ4wCuIyGpycALPScN65QdEziR0
	xPAwInqzdXZiOSO/IMEPTS0Pkb4U4g8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	Parav Pandit <parav@mellanox.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: RDMA: don't expose hw_stats into non-init net namespaces
Date: Wed, 26 Feb 2025 03:35:26 +0000
Message-ID: <20250226033526.2769817-2-roman.gushchin@linux.dev>
In-Reply-To: <20250226033526.2769817-1-roman.gushchin@linux.dev>
References: <20250226033526.2769817-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
accidentally exposed hw_counters to non-init net namespaces.

Fix this by hiding the IB_ATTR_GROUP_HW_STATS group when initializing
a non-init rdma device.

Fixes: 467f432a521a ("RDMA/core: Split port and device counter sysfs attributes")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>
Cc: Parav Pandit <parav@mellanox.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/infiniband/core/device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 8dea307addf1..bf4a016ccb9d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -528,6 +528,8 @@ static struct class ib_class = {
 static void rdma_init_coredev(struct ib_core_device *coredev,
 			      struct ib_device *dev, struct net *net)
 {
+	bool is_full_dev = net_eq(net, &init_net);
+
 	/* This BUILD_BUG_ON is intended to catch layout change
 	 * of union of ib_core_device and device.
 	 * dev must be the first element as ib_core and providers
@@ -539,6 +541,10 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
 
 	coredev->dev.class = &ib_class;
 	coredev->dev.groups = dev->groups;
+
+	if (!is_full_dev)
+		coredev->dev.groups[IB_ATTR_GROUP_HW_STATS] = NULL;
+
 	device_initialize(&coredev->dev);
 	coredev->owner = dev;
 	INIT_LIST_HEAD(&coredev->port_list);
-- 
2.48.1.658.g4767266eb4-goog


