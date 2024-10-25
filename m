Return-Path: <linux-kernel+bounces-381267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B59AFCB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21E0282654
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C51D2202;
	Fri, 25 Oct 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CH++LPeE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C01D1F54
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845445; cv=none; b=mEU9EBHtNKe+rTAHe1k532ZC2lYXK2u4FhXXAG4C7e8jRQnxwB5vNRKm0/gkFVs7PGxCYsuXBek+KiWu9VrFEPCzRR1R00uK8v6/rNqsIYZyhjSKu+n7KYTdaknJEV4gW5QUPQSriU9esib7Mvb15EpN3BWjDWOMOpVNxCwzPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845445; c=relaxed/simple;
	bh=F4TLDDhAiH6cnFwRhy3E/iXZE/qtxyK7s992MZoPM20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFFDwwb59JIz58Ldc5DJadbkCkuK4gYkjcgMEOC3aQZPCImJxRcwUgOCSaff6lTqhk9Cj/+8vhh5/+PqkMoOTv+PiwO/W4QZ3RFRFPL5faY7GIOSg0FnXrRRcucT92wCwgg404cBMDsJCE9hVmCbONI5eEg02jnaNh5Ho76r2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CH++LPeE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RdEuq87LNkRUdD8B3NScP1/oBuj/ADNnMLystB60kvI=;
	b=CH++LPeELeA7QeGVB5K0B+zmrHZ5/9q8teqH6VQRbrFmuWNAqe/vHMmmChKVyue5HIbRHk
	kFyBN4Kg3Y5LP8UgaeeKWM0xxwM0gW0B7kqD+6C2ZrD6lKIC1E2B4kc0lD7dEeZwXKXAUu
	PeHII1j/Je9aT3wKRKJnRgVAD3c1l6w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-usJorgdnNcuRQQCLsYqKGw-1; Fri,
 25 Oct 2024 04:37:21 -0400
X-MC-Unique: usJorgdnNcuRQQCLsYqKGw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0C761956069;
	Fri, 25 Oct 2024 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.162])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9038C195607C;
	Fri, 25 Oct 2024 08:37:18 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: intel_soc_pmic_crc: Add support for non ACPI instantiated i2c_client
Date: Fri, 25 Oct 2024 10:37:12 +0200
Message-ID: <20241025083712.15070-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On some x86 Bay Trail tablets which shipped with Android as factory OS,
the DSDT is so broken that the PMIC needs to be manually instantiated by
the special x86-android-tablets.ko "fixup" driver for cases like this.

Add an i2c_device_id table so that the driver can match on manually
instantiated i2c_client-s (which lack an ACPI fwnode to match on).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 876d017f74fe..ba22458ccb84 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -259,12 +259,19 @@ static const struct acpi_device_id crystal_cove_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, crystal_cove_acpi_match);
 
+static const struct i2c_device_id crystal_cove_i2c_match[] = {
+	{ "intel-crystal-cove" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, crystal_cove_i2c_match);
+
 static struct i2c_driver crystal_cove_i2c_driver = {
 	.driver = {
 		.name = "crystal_cove_i2c",
 		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
 		.acpi_match_table = crystal_cove_acpi_match,
 	},
+	.id_table = crystal_cove_i2c_match,
 	.probe = crystal_cove_i2c_probe,
 	.remove = crystal_cove_i2c_remove,
 	.shutdown = crystal_cove_shutdown,
-- 
2.47.0


