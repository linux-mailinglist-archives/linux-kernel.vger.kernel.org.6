Return-Path: <linux-kernel+bounces-572690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82435A6CD44
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 00:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453FD1889AA0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 23:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBD21EF097;
	Sat, 22 Mar 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhB73TIB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFF1DE3A7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742686148; cv=none; b=OmODdZwS9RsKg82DTsO8jHZ0j3+muDL4RY3OpjcWqoUgRNuMZZKq8POCnv8sgJWXkYrbU6txUCpYEIBSX0ir+yO5G7n0Y2o2OhAiq1bxN6z+RbvxILF69ngpWUAR+Wom60POP5V5LzSpLAsTswxOHjX0q4pL4iyrZ/7uebaF8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742686148; c=relaxed/simple;
	bh=OhhVGWpcSFG4gipijq1AzZCC0xlnH6g6N0gsuYd0QGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=jmPUKk3gaoLeTptOCTJVG8X9LvcAmUKfwlVH9SoUKlkuorH128QJ2AawCx52XRhxRsu//cz1lO2O3nRqK2lDQzGFrIIqvD27Ny3zG8aCM7wDHmW5N5/epkCgxZbA2Vxw6zJr3GtSEKV4l1SitoCGMvIUapL3S1/C3Wk6OulY5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhB73TIB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742686145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=625UNCZM4QGRK3cVKqtvQTiUqdD7+p90TqpeI7OzcGs=;
	b=BhB73TIBli0NY9sMi3BQKKqdDIQ5N7WjImPxgdXlfEPi2dPib+qgaQ6rYXIfCfL4H/ks8A
	jsEM5Ol+ZG7gaUgyyFlUz4vPIcCuAXcYIoHtvWxFbK+CjgXiXXOYZaVh1ktIQGrAJA0sig
	URN/yVxaiDRKIZVVbtm8OWaRs5jjDJ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-m2y5PiuGM1ybCcbv38OcJg-1; Sat,
 22 Mar 2025 19:29:02 -0400
X-MC-Unique: m2y5PiuGM1ybCcbv38OcJg-1
X-Mimecast-MFC-AGG-ID: m2y5PiuGM1ybCcbv38OcJg_1742686141
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF630180035C;
	Sat, 22 Mar 2025 23:29:00 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.80.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C31AF180A802;
	Sat, 22 Mar 2025 23:28:58 +0000 (UTC)
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
Subject: [PATCH v2 1/3] nvme-multipath: change the NVME_MULTIPATH config option
Date: Sat, 22 Mar 2025 19:28:46 -0400
Message-ID: <20250322232848.225140-2-jmeneghi@redhat.com>
In-Reply-To: <20250322232848.225140-1-jmeneghi@redhat.com>
References: <20250322232848.225140-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix up the NVME_MULTIPATH config description so that
it accurately describes what it does.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/Kconfig | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 10e453b2436e..d47dfa80fb95 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -18,10 +18,15 @@ config NVME_MULTIPATH
 	bool "NVMe multipath support"
 	depends on NVME_CORE
 	help
-	   This option enables support for multipath access to NVMe
-	   subsystems.  If this option is enabled only a single
-	   /dev/nvmeXnY device will show up for each NVMe namespace,
-	   even if it is accessible through multiple controllers.
+	  This option controls support for multipath access to NVMe
+	  subsystems. If this option is enabled support for NVMe multipath
+	  access is included in the kernel. If this option is disabled support
+	  for NVMe multipath access is excluded from the kernel. When this
+	  option is disabled each controller/namespace receives its
+	  own /dev/nvmeXnY device entry and NVMe multipath access is
+	  not supported.
+
+	  If unsure, say Y.
 
 config NVME_VERBOSE_ERRORS
 	bool "NVMe verbose error reporting"
-- 
2.48.1


