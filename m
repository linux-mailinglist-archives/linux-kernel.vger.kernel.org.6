Return-Path: <linux-kernel+bounces-395100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6507C9BB88D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970D11C21F79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15A51BC077;
	Mon,  4 Nov 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQT/BjMP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E41509B6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732829; cv=none; b=PQZG7g0hc7rENN3xUQq5AQc4U19DLZYbN7r6jr3uNAk6VvF5BExHCiCmziP1q0BT7ISWF8drUjBoRn+qmq9O3+8GVvzCh7ubINSJZZZ1m8YZNa/kh3bDLKSNprYEPoGo5unlj+6pctim1+5/5SbuLTwCpJGKMGn7LwDiDVd+i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732829; c=relaxed/simple;
	bh=3xyYZxg4lmlZzzdDxLEO5D2JkvmaD2B7S6bp9KuR+Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8R+L0NYmPmAVuRld96oqc27pt8KjCEphzyhIzlF89GFDZ3fiZtyS8ZOqa4HwsRwMyEu6flZ5BxQwc9eTIIU/PIUi49yPqHoEPm2Yjv2DZq/UyQWQUEwr5ZNXdeWuwb61C97a7nDZq9ikN7qrO+hD5ZRPh/4VIk6GCyHyUIb5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQT/BjMP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730732826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPQhGnPSTmS2kBjV62LoV/wfw2Nfa2HraM3xV6UW4Jg=;
	b=JQT/BjMPIKT+6Z+CGysD8JGeWNXze2oMNVW0tEI+HkfLOGokFb9o3Lyu17eUeEkdtxL3n2
	X2aI309eodHk+xIhX9jUlHgSKxtPTXddNW6YarHMcA4SuTdpbcF+UZJGIMjemryZW58iFB
	yFxoZDaViwnLXfQ9AIpjVf2HxtUjTfs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-rLMJPHJuMvewRfRrK45hOg-1; Mon,
 04 Nov 2024 10:07:05 -0500
X-MC-Unique: rLMJPHJuMvewRfRrK45hOg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E55401955F4A;
	Mon,  4 Nov 2024 15:07:03 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1429A300018D;
	Mon,  4 Nov 2024 15:07:01 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mfd: intel_soc_pmic_crc: Add support for non ACPI instantiated i2c_client
Date: Mon,  4 Nov 2024 16:06:55 +0100
Message-ID: <20241104150655.41402-3-hdegoede@redhat.com>
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

On some x86 Bay Trail tablets which shipped with Android as factory OS,
the DSDT is so broken that the PMIC needs to be manually instantiated by
the special x86-android-tablets.ko "fixup" driver for cases like this.

Add an i2c_device_id table so that the driver can match on manually
instantiated i2c_client-s (which lack an ACPI fwnode to match on).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use "intel_soc_pmic_crc" as i2c_device_id.name
---
 drivers/mfd/intel_soc_pmic_crc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 663a9e93ce87..879fbf5cd162 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -259,12 +259,19 @@ static const struct acpi_device_id crystal_cove_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, crystal_cove_acpi_match);
 
+static const struct i2c_device_id crystal_cove_i2c_match[] = {
+	{ "intel_soc_pmic_crc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, crystal_cove_i2c_match);
+
 static struct i2c_driver crystal_cove_i2c_driver = {
 	.driver = {
 		.name = "intel_soc_pmic_crc",
 		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
 		.acpi_match_table = crystal_cove_acpi_match,
 	},
+	.id_table = crystal_cove_i2c_match,
 	.probe = crystal_cove_i2c_probe,
 	.remove = crystal_cove_i2c_remove,
 	.shutdown = crystal_cove_shutdown,
-- 
2.47.0


