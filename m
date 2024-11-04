Return-Path: <linux-kernel+bounces-395101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218969BB88E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E331F22133
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3016F1BD018;
	Mon,  4 Nov 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTpCLrlm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB91AC88B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732829; cv=none; b=YmLnun7NYapYnh5rQYpi9O92scgsU8YK6yfTEckZ46/r2st4UZZtRGgQqjLlbk+tgZrB9eDONiUCnFYgz02xGnHdfFgUySlsdUjB7zbggN8YCQVUS8Q0gELbIjhD79iYN8ccvySOzCCv7HEHMtH6YCnDhZuFj4HEahtVTIGYqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732829; c=relaxed/simple;
	bh=G1AA9la5vBR/OxEPVIHnGxXm4O+/VxKUuk0cullJgXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFhh+m5VEmJ5m3k/tkHTjh9DoIkuT3eXN4PrcQmSqDVLwt/yawGojGW4rnFuAlbUdI603FyPh7zndRDBB/eWdO/ZbqhpbmSnJZR8Pnp+1GnIuMjH9SNVo753PhrWEwkmkGsuaY/TgBCZuxziFsMCyb6EkV210XIXRmxFqJjOA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTpCLrlm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730732826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0563wELTpLhHaBqIqmlGhhdtb0RZ9tv3yCJloBBym8=;
	b=QTpCLrlme70QP1FglKVqG/kHrZYPd+yK16owGONUace+j2Y3TrSaaJ5NsCBmUdOgMnAhdI
	leiH1bjaVxDxtwu8PCOuoqe9hrGY3U3SiJVfcHwAPnSTTuegjanuq/qKvLyJ9akAyWcbnN
	H8ZGbgLDxIisphPvKnFbnvee2nQprYc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-eh-GsTiEPUGBKY20bLq0jA-1; Mon,
 04 Nov 2024 10:07:04 -0500
X-MC-Unique: eh-GsTiEPUGBKY20bLq0jA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 598231956057;
	Mon,  4 Nov 2024 15:07:01 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 667E03000198;
	Mon,  4 Nov 2024 15:06:59 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mfd: intel_soc_pmic_*: Consistently use filename as driver name
Date: Mon,  4 Nov 2024 16:06:54 +0100
Message-ID: <20241104150655.41402-2-hdegoede@redhat.com>
In-Reply-To: <20241104150655.41402-1-hdegoede@redhat.com>
References: <20241104150655.41402-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently the intel_soc_pmic_bxtwc, intel_soc_pmic_chtwc and
intel_soc_pmic_crc PMIC drivers use more or less free form strings
for their driver name.

Where as intel_soc_pmic_chtdc_ti and intel_soc_pmic_mrfld use the driver's
filename as driver name.

Update the 3 others to also use the driver's filename to make the naming
consistent.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
 drivers/mfd/intel_soc_pmic_chtwc.c | 2 +-
 drivers/mfd/intel_soc_pmic_crc.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index ccd76800d8e4..db98675f7ffa 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -571,7 +571,7 @@ static struct platform_driver bxtwc_driver = {
 	.probe = bxtwc_probe,
 	.shutdown = bxtwc_shutdown,
 	.driver	= {
-		.name	= "BXTWC PMIC",
+		.name	= "intel_soc_pmic_bxtwc",
 		.pm     = pm_sleep_ptr(&bxtwc_pm_ops),
 		.acpi_match_table = bxtwc_acpi_ids,
 		.dev_groups = bxtwc_groups,
diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 2a83f540d4c9..aa71a7d83fcd 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -267,7 +267,7 @@ static const struct acpi_device_id cht_wc_acpi_ids[] = {
 
 static struct i2c_driver cht_wc_driver = {
 	.driver	= {
-		.name	= "CHT Whiskey Cove PMIC",
+		.name	= "intel_soc_pmic_chtwc",
 		.pm     = pm_sleep_ptr(&cht_wc_pm_ops),
 		.acpi_match_table = cht_wc_acpi_ids,
 	},
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 876d017f74fe..663a9e93ce87 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -261,7 +261,7 @@ MODULE_DEVICE_TABLE(acpi, crystal_cove_acpi_match);
 
 static struct i2c_driver crystal_cove_i2c_driver = {
 	.driver = {
-		.name = "crystal_cove_i2c",
+		.name = "intel_soc_pmic_crc",
 		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
 		.acpi_match_table = crystal_cove_acpi_match,
 	},
-- 
2.47.0


