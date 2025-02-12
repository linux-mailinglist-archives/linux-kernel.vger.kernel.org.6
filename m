Return-Path: <linux-kernel+bounces-511728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EDEA32ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AC81647CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6E25B689;
	Wed, 12 Feb 2025 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIgMoadS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82D1F76A5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385964; cv=none; b=np5CYyMsJrY7p0hUzobuwsHZZZ/cRG+qqtySDEBw9yyQ/ckuvRzn1gXFNuyM44mcJCnnr8KdDcuv/ZPzn76I/LCFu7QXcGeN13ohZ/zS/PnV4qoAXypW6HhZsLcCNHfxslZ/asXCV4L+ZEfYHKLprRYnw54HzUf0WDEcw/U/UDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385964; c=relaxed/simple;
	bh=wAOZMIhiGMIEi2aD9GJtJG0E+ySfUU446TQW670pBYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRUUKkwI2qg+bYCWb8jmJIYG+WZl0MM1ayt5z/uY8NMhSqloH4Ctn+5JEyw68bA/HNAuftryAguM7kZd6hUCdATnY8TrO0Drqgu3GbaJ9KvPEi6/oMFcC8u3waKtfbPoFWqbpJGg2mx/sBXfx7wIRP+Tl1wifD/T0ZpjzuyHJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIgMoadS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739385961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OHwD8oIyWjiZbHgTmrmU/fIDtoVTu5QUxo5ey7uw4jM=;
	b=ZIgMoadSWBsnImkOB8ERnklVNB0V13Y3qy5PoOx8pfp/cpFt0zzwoV/PK2XiRO2T5vp9q7
	IEkqALl51jyxNvsgKbzzKRAIbaLoe6XBelRCCa9Ml9WOmcGuh+oZfOKODsahxJW1kSSeD0
	d2G1J3mRXd7obipXKPnZla1/pODGd5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-t3OSx8mmPA2cxgeFosGNHQ-1; Wed,
 12 Feb 2025 13:46:00 -0500
X-MC-Unique: t3OSx8mmPA2cxgeFosGNHQ-1
X-Mimecast-MFC-AGG-ID: t3OSx8mmPA2cxgeFosGNHQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3E7219560A1;
	Wed, 12 Feb 2025 18:45:58 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.45.225.221])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBDE319560A3;
	Wed, 12 Feb 2025 18:45:56 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: lee@kernel.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org
Cc: Eder Zulian <ezulian@redhat.com>,
	Mark Langsdorf <mlangsdo@redhat.com>
Subject: [PATCH] mfd: syscon: Add check for invalid resource size
Date: Wed, 12 Feb 2025 19:45:24 +0100
Message-ID: <20250212184524.585882-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a consistency check to avoid assigning an invalid value to
max_register due to a possible DT misconfiguration.

Suggested-by: Mark Langsdorf <mlangsdo@redhat.com>
Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 drivers/mfd/syscon.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 226915ca3c93..362824a7e350 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	struct regmap_config syscon_config = syscon_regmap_config;
 	struct resource res;
 	struct reset_control *reset;
+	resource_size_t res_size;
 
 	WARN_ON(!mutex_is_locked(&syscon_list_lock));
 
@@ -96,6 +97,12 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 		}
 	}
 
+	res_size = resource_size(&res);
+	if (res_size < reg_io_width) {
+		ret = -EFAULT;
+		goto err_regmap;
+	}
+
 	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%pa", np, &res.start);
 	if (!syscon_config.name) {
 		ret = -ENOMEM;
@@ -103,7 +110,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	}
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
-	syscon_config.max_register = resource_size(&res) - reg_io_width;
+	syscon_config.max_register = res_size - reg_io_width;
 	if (!syscon_config.max_register)
 		syscon_config.max_register_is_0 = true;
 
-- 
2.48.1


