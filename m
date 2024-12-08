Return-Path: <linux-kernel+bounces-436423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53739E85B4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8758164C64
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09C217BA5;
	Sun,  8 Dec 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g215Dprl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54F12D758
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733670044; cv=none; b=dbKcJjb0xkwbp3yY2OyAkvkM0FpFyTsMTfnekv3R92cU5ojwRFvE6ueal8FPxOu1P2L/AOe/gSrYQCvRIXdkxaDNM76wQDCgEgbXOImrKKABWfAg0BUtHAGKIXsIjChci51QYQ+rlVe/8m8kfa5ClytU7r2d580rVbVWPPM8mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733670044; c=relaxed/simple;
	bh=55F+hL3usiSHNnYwf6ZXW07GxLytHZPhhgXzL62kAJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6H6UjYC5IQMFth6Clonx1xrEi+FzzHgjpMqJI9Ayyb+mu/9G9mJeZ32kua7ye2ZsmLm9CEvLrIHJWmxk0zgFPReewLAT/twUBE/gAw49k+/qxDQ9Mq+6cnOg4g/bKJn4/L9yB+aEBiu8QUB5ErP3Y/eWF2Q5FVLugA20xi24H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g215Dprl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733670041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fa/Hv38FUbXjszUgtRFX0d+Hs8wlOYzBgFSBxQBkI7s=;
	b=g215Dprls2wvtPBEetodRKVIN9PafiWiej3geh7dBoBkVJbQvBeZubbd4zlBzUrgAQZJXQ
	VLkZ1z5bP6zbjd4NK8Da9rneZKD/gFR1M1L1785Y5HRQ5fi5T4srbkkqtyPT+aN5pTozbi
	Cun2LUd1Rg0QxIxMVzxFj16JoJUVRoM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-ea9RE4CSMfCrYzWOhYZE-A-1; Sun,
 08 Dec 2024 10:00:37 -0500
X-MC-Unique: ea9RE4CSMfCrYzWOhYZE-A-1
X-Mimecast-MFC-AGG-ID: ea9RE4CSMfCrYzWOhYZE-A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6B9D1955F45;
	Sun,  8 Dec 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.68])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 83A1F19560A2;
	Sun,  8 Dec 2024 15:00:34 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
Date: Sun,  8 Dec 2024 16:00:27 +0100
Message-ID: <20241208150028.325349-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The max_register = 128 setting in the regmap config is not valid.

The Intel Dollar Cove TI PMIC has an eeprom unlock register at address 0x88
and a number of EEPROM registers at 0xF?. Increase max_register to 0xff so
that these registers can be accessed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Increase max_register to 0xff instead of dropping it so that
  all the registers are shown in debugfs
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 992855bfda3e..8582ae65a802 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -81,7 +81,7 @@ static struct mfd_cell chtdc_ti_dev[] = {
 static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = 128,
+	.max_register = 0xff,
 	.cache_type = REGCACHE_NONE,
 };
 
-- 
2.47.1


