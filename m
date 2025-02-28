Return-Path: <linux-kernel+bounces-537688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEDCA48F18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478EF3B5006
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B3719DF99;
	Fri, 28 Feb 2025 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfVbsTJ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794515ECDF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713169; cv=none; b=s2u8gBaxRGfypghRn2NoV+uUTGiAgkIixhnzZSRay9IxFZrfi9w4NFPQf5ijd5tiKz4k0VwF9EeHFV9ugI2MBCRt7576vzLvHY+U+AZEw3nj9K35uaYdXL/iDsoR6qUnWijryqRA6PhlmcC8Xtu5UwtQPeg44YUMHOszOqaZJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713169; c=relaxed/simple;
	bh=8rOP13hhuE1G+Rgw9CwthL+SGr9IIYHK9Bo7EFRetCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=OOZS6BJTtuqxJbMaLKZsakhVOSuvLln4V8ux9pSIeC2DxaTYvj6K63MQDoAKlT5So+FzSM4KkM8sV2myyAf75aEKh2bw/DZZPq7jYi+op6vtRIh6asb/sPg/PlmwFFpCCGx+Kf8VAS2aqcnMU3m7Qo4SUCUdMXRBTyjVUnQQQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfVbsTJ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740713163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BE/DQRlr1UZMYjXT2iLkw402U/iU1veOuNJ4jK09ueU=;
	b=KfVbsTJ6O3gVhL/3yLefuLQblEq4SSsZTzS3y5GRrLSLUFYJsrfJy3AUMOFerKiPNKVFLn
	QyWaCdj6aLGA678UB4qbjsnc/8v8nSJolpzmv7miCccS0ADSBncTCuYV3S+9FueZjrdGJg
	eaoadpTMN99vo7gTwfoSZyKql7Wyj/U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-jEL8Oe1TNe2t2kg3JLj7rQ-1; Thu,
 27 Feb 2025 22:25:58 -0500
X-MC-Unique: jEL8Oe1TNe2t2kg3JLj7rQ-1
X-Mimecast-MFC-AGG-ID: jEL8Oe1TNe2t2kg3JLj7rQ_1740713157
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4429C18011E4;
	Fri, 28 Feb 2025 03:25:57 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.88.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B4BC18009AE;
	Fri, 28 Feb 2025 03:25:53 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: loberman@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	bgurney@redhat.com
Subject: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config option
Date: Thu, 27 Feb 2025 22:25:39 -0500
Message-ID: <20250228032541.369804-3-jmeneghi@redhat.com>
In-Reply-To: <20250228032541.369804-1-jmeneghi@redhat.com>
References: <20250228032541.369804-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The NVME_MULTIPATH_PARAM option controls the core.nvme_multipath module
parameter. When NVME_MULTIPATH_PARAM=n the multipath parameter is removed
and core nvme multipathing is enabled. When NVME_MULTIPATH_PARAM=y
the multipath parameter is added and multipath support becomes
configurable with the core.nvme_multipath parameter.

By default NVME_MULTIPATH_PARAM=y

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/Kconfig     | 15 +++++++++++++++
 drivers/nvme/host/multipath.c |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 91b0346ce65a..c4251504f201 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -28,6 +28,21 @@ config NVME_MULTIPATH
 
 	  If unsure, say Y.
 
+config NVME_MULTIPATH_PARAM
+	bool "NVMe multipath param"
+	depends on NVME_CORE && NVME_MULTIPATH
+	help
+	  This option enables configurable support for multipath access with
+	  NVMe subsystems. If this option is enabled NVMe multipath support is
+	  configured by the nvme core module parameter named "multipath". If
+	  this option is disabled the nvme core module "multipath" parameter
+	  is removed and support for NVMe multipath access can not be
+	  configured. When this option is disabled a single /dev/nvmeXnY
+	  device entry will be seen for each NVMe namespace, even if the
+	  namespace is accessible through multiple controllers.
+
+	  If unsure, say Y.
+
 config NVME_VERBOSE_ERRORS
 	bool "NVMe verbose error reporting"
 	depends on NVME_CORE
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2a7635565083..4536ad5fbb82 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -10,10 +10,11 @@
 #include "nvme.h"
 
 bool multipath = true;
+#ifdef NVME_MULTIPATH_PARAM
 module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
-
+#endif
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
-- 
2.48.1


