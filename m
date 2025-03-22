Return-Path: <linux-kernel+bounces-572691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723DBA6CD42
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 00:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F2B3A69B9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D1B1F09B5;
	Sat, 22 Mar 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iElE6diM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429CE1EF370
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742686150; cv=none; b=LpNG+oMlfa+f5e+FsSusXpQmqXHvF/N1NiAc8BPIniT5WuNzo6wsMV1huKpL6n3NUkLceE3ptOj1roexE7rFzxbW35ap7Rqn2y5RgwCxXXrkC88nDO4QF+0M8FbqSjKbcdUcjMF0EQjHCw1pbIwtKtQdUrIKw8BK2QWL3dtDHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742686150; c=relaxed/simple;
	bh=7ihAxwPsAqpSNUyD+ZlZX4Bc8YSv1vgcmJ8XAXcCu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=c3eQzZw2MUzYbQEGNvmIhGlDM/lS4mBL3A8L4wNQEYg8MChUg1ZJRnd2ywzPKlMLzHVuV8xlS5KawzJbloyLrgB9tg0C703a2dUP6pdvc6Bbp8OgXGhiZvdYGh+qkdlMtMoNwyzNb6zIEdTS3sri51TZcgfwgHTWNc4QzepM1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iElE6diM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742686148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95vARJpK8cN2Fns4HX6JH0We9Ct8sqPV6rO+P5EgzGU=;
	b=iElE6diM+808jQ78SHaNzThp4csaAixoUIiOxErvSKIUWQD4AuEbINE9amBcxBCS5N4PPt
	xraFO6edG3wgoBKSiRPL9/UGOWrgJGMhOXvkRt6r2JtMUihnarAAp9u6sPcXod5SNgudhi
	BEn4JkTtvsSAlIA0Sgj/CmFUA2+0QJ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-TgRwl_51OHWc1S5qIG9mQw-1; Sat,
 22 Mar 2025 19:29:04 -0400
X-MC-Unique: TgRwl_51OHWc1S5qIG9mQw-1
X-Mimecast-MFC-AGG-ID: TgRwl_51OHWc1S5qIG9mQw_1742686143
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09EEA195E92A;
	Sat, 22 Mar 2025 23:29:03 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.80.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EAD7180A802;
	Sat, 22 Mar 2025 23:29:00 +0000 (UTC)
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
Subject: [PATCH v2 2/3] nvme-multipath: add the NVME_MULTIPATH_PARAM config option
Date: Sat, 22 Mar 2025 19:28:47 -0400
Message-ID: <20250322232848.225140-3-jmeneghi@redhat.com>
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

The new CONFIG_NVME_MULTIPATH_PARAM option controls the core_nvme.multipath
parameter. When CONFIG_NVME_MULTIPATH_PARAM=n the multipath parameter is
removed from the kernel and nvme multipathing is permanently enabled.
When NVME_MULTIPATH_PARAM=y the nvme multipath parameter is added to the
kernel and nvme multipath support is controlled by the
core_nvme.multipath parameter.

By default CONFIG_NVME_MULTIPATH_PARAM=y

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/Kconfig     | 13 +++++++++++++
 drivers/nvme/host/multipath.c |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index d47dfa80fb95..c8458b10c83f 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -28,6 +28,19 @@ config NVME_MULTIPATH
 
 	  If unsure, say Y.
 
+config NVME_MULTIPATH_PARAM
+	bool "NVMe multipath param"
+	depends on NVME_CORE && NVME_MULTIPATH
+	default y
+	help
+	  This option controls the inclusion of the NVMe core module
+	  "multipath" parameter. If this option is disabled the
+	  nvme_core.multipath parameter is excluded from the kernel.
+	  If this option is enabled the nvme_core.multipath parameter
+	  is included in the kernel.
+
+	  If unsure, say Y.
+
 config NVME_VERBOSE_ERRORS
 	bool "NVMe verbose error reporting"
 	depends on NVME_CORE
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6b12ca80aa27..cad76de2830a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -10,10 +10,11 @@
 #include "nvme.h"
 
 bool multipath = true;
+#ifdef CONFIG_NVME_MULTIPATH_PARAM
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


