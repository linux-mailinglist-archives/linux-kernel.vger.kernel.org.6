Return-Path: <linux-kernel+bounces-211552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815E49053AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E801C20757
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9817B42A;
	Wed, 12 Jun 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="qG+md0Fp"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D0153BFA;
	Wed, 12 Jun 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198591; cv=none; b=oYTjdZauACT8HMRayMgQgk8So39EZoNNO2hzRZh5CUATvjGlYdOugg/6Bh+/VgvL+8bMZtHL1M+DzI6NTWzkDU0IsIDpraJnhpFYV10g8KKJfyaehQ73BTOt+6HHJuuUwq59G5kbMarsSGRfPPRp1gRWXRTFAeTHisWwYTcGbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198591; c=relaxed/simple;
	bh=LU4Ex0c19yd2n5aDC24lwUC4E3uI/9CYV2LjGKS7R7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nGcE8UMoV4VtLiMS+gxoni73Hs0LV84BqwqXbzwg4VBvCUz458kVmGPrKrhW/Zw2yCt9iEnXA42QjNnvE2SFEQ+wmuYjCFJmPyxJFomap6XnpB3S1NYSbTLVKwgfdcDPipyBVXv+ZpDc+9A112zEEWmqrbJdCiKQBBt6oJxRKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=qG+md0Fp; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 82C8E6000871;
	Wed, 12 Jun 2024 14:13:27 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id D5TUq_B7VFPf; Wed, 12 Jun 2024 14:13:25 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 3CCD360022EC;
	Wed, 12 Jun 2024 14:13:25 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1718198005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EndnLYNCiF0bEFLBj6ypoVHvLGji1T/luzXJeq0p5iE=;
	b=qG+md0Fpy20B8uhbJptDViyIXNwDVgtTYVz+LFHvUlhRZnkexGMGA+76Br9V+eHITRMCKP
	1zyzaPKB37gZEbM9cbgWeizndZFLFESPJiXBvriHnT2HfemtDAD54e/ovBCRhtUbvVSLJE
	2iVzbkQUm36NsLvZ34CvihFT0pehI4g=
Received: from [192.168.1.53] (unknown [IPv6:2a01:14:8073:1e10:c362:ff08:aa85:54c6])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id E0AEA36008D;
	Wed, 12 Jun 2024 14:13:24 +0100 (WEST)
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Date: Wed, 12 Jun 2024 14:13:10 +0100
Subject: [PATCH] usb: typec: ucsi_acpi: Add LG Gram quirk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-gram_quirk-v1-1-52b0ff0e1546@tecnico.ulisboa.pt>
X-B4-Tracking: v=1; b=H4sIAOWeaWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Mj3fSixNz4wtLMomzdxGRDUwMjU/NkE0NTJaCGgqLUtMwKsGHRsbW
 1AMstTy9cAAAA
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718198004; l=3786;
 i=diogo.ivo@tecnico.ulisboa.pt; s=20240529; h=from:subject:message-id;
 bh=LU4Ex0c19yd2n5aDC24lwUC4E3uI/9CYV2LjGKS7R7Q=;
 b=/wMoBUlbLnYhsYGDdmkVrhiAKN1jd11Kcbxd6ww1WqLjHCITUpALS5Zf3rr7khf6My1ycL/qw
 HblFxMpznxOCNg53rrzOd8zIC9VKAE+Pqsh9Y1xeOp7k45vNQJCtktU
X-Developer-Key: i=diogo.ivo@tecnico.ulisboa.pt; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=

Some LG Gram laptops report a bogus connector change event after a
GET_PDOS command for the partner's source PDOs, which disappears from
the CCI after acknowledging the command. However, the subsequent
GET_CONNECTOR_STATUS in ucsi_handle_connector_change() still reports
this bogus change in bits 5 and 6, leading to the UCSI core re-checking
the partner's source PDOs and thus to an infinite loop.

Fix this by adding a quirk that signals when a potentially buggy GET_PDOS
command is used, checks the status change report and clears it if it is a
bogus event before sending it to the UCSI core.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
The models affected by this bug have been reported to be of several forms:
1xZ90Q, 1xZD90Q, 1xZB90Q, x = {5, 6, 7}, and as such this patch matches
only on the final 90Q as well as the product family since the "90Q" string
may collide with other LG models by being too short. If there are other
better ways of achieving this match I would be happy to hear about them.
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 61 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 8d112c3edae5..adf32ca0f761 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -25,6 +25,7 @@ struct ucsi_acpi {
 	unsigned long flags;
 #define UCSI_ACPI_COMMAND_PENDING	1
 #define UCSI_ACPI_ACK_PENDING		2
+#define UCSI_ACPI_CHECK_BOGUS_EVENT	3
 	guid_t guid;
 	u64 cmd;
 };
@@ -128,6 +129,58 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
 	.async_write = ucsi_acpi_async_write
 };
 
+static int ucsi_gram_read(struct ucsi *ucsi, unsigned int offset,
+			  void *val, size_t val_len)
+{
+	u16 bogus_change = UCSI_CONSTAT_POWER_LEVEL_CHANGE |
+			   UCSI_CONSTAT_PDOS_CHANGE;
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	struct ucsi_connector_status *status;
+	int ret;
+
+	ret = ucsi_acpi_read(ucsi, offset, val, val_len);
+	if (ret < 0)
+		return ret;
+
+	if (UCSI_COMMAND(ua->cmd) == UCSI_GET_CONNECTOR_STATUS &&
+	    test_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags) &&
+	    offset == UCSI_MESSAGE_IN) {
+		status = (struct ucsi_connector_status *)val;
+
+		/* Clear the bogus change */
+		if (status->change == bogus_change)
+			status->change = 0;
+
+		clear_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags);
+	}
+
+	return ret;
+}
+
+static int ucsi_gram_sync_write(struct ucsi *ucsi, unsigned int offset,
+				const void *val, size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
+	if (ret < 0)
+		return ret;
+
+	if (UCSI_COMMAND(ua->cmd) == UCSI_GET_PDOS &&
+	    ua->cmd & UCSI_GET_PDOS_PARTNER_PDO(1) &&
+	    ua->cmd & UCSI_GET_PDOS_SRC_PDOS)
+		set_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags);
+
+	return ret;
+}
+
+static const struct ucsi_operations ucsi_gram_ops = {
+	.read = ucsi_gram_read,
+	.sync_write = ucsi_gram_sync_write,
+	.async_write = ucsi_acpi_async_write
+};
+
 static const struct dmi_system_id ucsi_acpi_quirks[] = {
 	{
 		.matches = {
@@ -136,6 +189,14 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
 		},
 		.driver_data = (void *)&ucsi_zenbook_ops,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "LG gram PC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "90Q"),
+		},
+		.driver_data = (void *)&ucsi_gram_ops,
+	},
 	{ }
 };
 

---
base-commit: 5821bf2dffbe18fe1f097dbb027415fa15a38e9a
change-id: 20240612-gram_quirk-ac150257c415

Best regards,
-- 
Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>


