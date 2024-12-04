Return-Path: <linux-kernel+bounces-432140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED6F9E463E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC273285419
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4F618E368;
	Wed,  4 Dec 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J95G9tgE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65B17BCA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346149; cv=none; b=s81G8XZJRMpauDE93nkV7AQyo7WLReIzVD58CHXXpkwze8lWlEZidwaBNNkTda3bZEULg5MYFatIJlBfWcNKim3sMRcXhlM+iYzhOPK+W9L29wmodMbLmMo45iEDUxj4SBmI0lIJE677qyM4RMUrpHKryNoOOYxNfG3Ib323qXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346149; c=relaxed/simple;
	bh=u4VyJpK6MXXcFnKD7G/4tRi+rJMPVFYEc6Czi1OwOqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TM+lpEgRamxaphPbtpQrmw4l8eRxCikJo2oPM3gnrPuJ+S+5ILBvAbrwoLRoNo/TFYvfODs9RQDVsgOc8iYhwjIX6xUJb6Coo+fkD2tXBpnG7QAk8EDB1p5161RiDwdaSM7WZTXWvWGrdJVvw89P/vOsNBPhOyDNaCYC/PTZg0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J95G9tgE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733346144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=568y80yrR8Yen23VkxUL8YqY/HLNnz3Zo36rWX9wOl0=;
	b=J95G9tgEMMTwmdN6l/QNZpbibJ0Q+t9GFho4xQMRG7KGlkIN1P5yDFq1jBGQCrspD2Q5rb
	VmjAEC9S1xoYbrZeX43I1M89dOvNhBqa5nQzrdAC3lLsGqnzciEA8fRLh2/7GiArDYUWqH
	WWcIpFnBOuRM+pBNBOfPrP6acVfZuNE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-GqJsvIEzNSa7Ia4K_Ow2mg-1; Wed,
 04 Dec 2024 16:02:21 -0500
X-MC-Unique: GqJsvIEzNSa7Ia4K_Ow2mg-1
X-Mimecast-MFC-AGG-ID: GqJsvIEzNSa7Ia4K_Ow2mg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05F0F1956051;
	Wed,  4 Dec 2024 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EFA619560AD;
	Wed,  4 Dec 2024 21:02:18 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: intel_soc_pmic_chtdc_ti: Remove invalid max_register from regmap-config
Date: Wed,  4 Dec 2024 22:02:09 +0100
Message-ID: <20241204210209.136976-1-hdegoede@redhat.com>
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
and a number of EEPROM registers at 0xF?. Drop the invalid max_register
setting so that these registers can be accessed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 992855bfda3e..686b84e33671 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -81,7 +81,6 @@ static struct mfd_cell chtdc_ti_dev[] = {
 static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = 128,
 	.cache_type = REGCACHE_NONE,
 };
 
-- 
2.47.0


