Return-Path: <linux-kernel+bounces-537686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E69A48F16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D8D16DE26
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723F21922C0;
	Fri, 28 Feb 2025 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFr2Yer6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1426E14A4DF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713159; cv=none; b=Vecnvo5olNn/w69EggDsH+jJGygXiAz6tSOhRbV+y6Rb3pZKJyaRJVz59/iSHv+DQM67o0sWzEd83S/ZEjrXiKNDLVvcnE98+ek82CHS9FHnLiXroLnUV2rtmSCql3nULPgJQYh5qya0wK+zV/b1VKGOMwLL7I0oQfPdiENGHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713159; c=relaxed/simple;
	bh=BfoWirKBssgrKY8ocekDTILHuJjp+NkwLX+7TGVyNhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=uHDHpK2DTJ9idLn6SJ7n+OJCXzfaxyEoILcd10g9mzR7AoqpabaGIxIWl4cFMKM+v9hYt37XnhJQTBserMAJVe11fzmenLfmney3lkidKMsuP57o96WUgd/QT4N8J1IAkUMSjAV2o77hg/JdD826IQEDR/rAxiacjmnoGosbXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFr2Yer6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740713156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vefzqVchTzg4OUcLEG5G0ex/Mo/H0nqRf+9HiCYTGY=;
	b=UFr2Yer6yywdK4NOVspfAFYiTbYGWeSP2PKUatsaIArF97uI7e6/XSHBiZH3NbmbCjphUU
	vym66t5aekSz+vClzf0SQ/awzXzQnstBTDHebWPwLQDWsTv0VlmhTI4gxxfHfZApd2UgPu
	HOWZgZDAWo1it7hW1dZavLlvhpye7Zs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-ul5x38IrMUC19Vl42Twh0g-1; Thu,
 27 Feb 2025 22:25:54 -0500
X-MC-Unique: ul5x38IrMUC19Vl42Twh0g-1
X-Mimecast-MFC-AGG-ID: ul5x38IrMUC19Vl42Twh0g_1740713153
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC5E81954B1A;
	Fri, 28 Feb 2025 03:25:52 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.88.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFD391800988;
	Fri, 28 Feb 2025 03:25:50 +0000 (UTC)
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
Subject: [PATCH 1/4] nvme-multipath: change the NVME_MULTIPATH config option
Date: Thu, 27 Feb 2025 22:25:38 -0500
Message-ID: <20250228032541.369804-2-jmeneghi@redhat.com>
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

Fix up the NVME_MULTIPATH config description so that
it accurately describes what it does.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/Kconfig | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 486afe598184..91b0346ce65a 100644
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


