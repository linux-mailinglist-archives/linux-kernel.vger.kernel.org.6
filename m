Return-Path: <linux-kernel+bounces-300430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8014495E399
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCCC1F215C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E437515443F;
	Sun, 25 Aug 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVdiV5xo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1F1E492
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724592395; cv=none; b=T+hQddKS7kXljqB1pvkMZJiDXoNWKiv88+nZa0wgSfcIxID7imYZlc0mxoKzobyMonVFwS3KEg2zAEc/pIlHCkVVjkfji8mm7J6+oX2jP2W36ZypKDr9g7cq5RgN7LcaU+m9sWRKZwEacF5vNTIhgcV2NrTX3cCxiiEC/zPd0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724592395; c=relaxed/simple;
	bh=KhmWYnbGRGxu/n8UYc8uHxKQs+J+r3f7a0HIkBCJi4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKvafj3Hd5ePThgpsBjn3XCgmwei+WPCnfhjFuRZwtUK/MaabljIt3p1pPAqIGhrwGT0PF8ZHNc39HLGCCmRpWtdVk1sAJqQqamABEIANsaA4imCeeGZH/ITS2DOHxCQclKZms2jpjHyVAYbKSrDAkI+/RJaimEs2zWh9Lbgg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVdiV5xo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724592392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dmptXzv+NszuV7lHRXmcxRsMcHlGT0zAY4pUOHeamfs=;
	b=gVdiV5xoy6IeDHfEo29WYklTah21QdeGM1rIH0Hi74BYP9K8elopOEvm/shGe19Qpv1epm
	JkS0zk2FcBOky9PCAoqUj+kIv1RPw9qBFWuiOoor8niRgs8ZDzmbSCgR9F2A2iVT+huK42
	JSXi/2939pHuoY5mBpSXafoJo8NcqB0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-ymhGWPIOMP2CLhsLme_X6g-1; Sun,
 25 Aug 2024 09:26:29 -0400
X-MC-Unique: ymhGWPIOMP2CLhsLme_X6g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79CF71955D4C;
	Sun, 25 Aug 2024 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.45])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0EE5300019C;
	Sun, 25 Aug 2024 13:26:26 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Sun, 25 Aug 2024 15:26:17 +0200
Message-ID: <20240825132617.8809-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
turns out that the 2G version has a DMI product name of
"CHERRYVIEW D1 PLATFORM" where as the 4G version has
"CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
unique enough that the product-name check is not necessary.

Drop the product-name check so that the existing DMI match for the 4G
RAM version also matches the 2G RAM version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 7fce3ef7ab45..2a83f540d4c9 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -178,7 +178,6 @@ static const struct dmi_system_id cht_wc_model_dmi_ids[] = {
 		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YT3_X90,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 	},
-- 
2.46.0


