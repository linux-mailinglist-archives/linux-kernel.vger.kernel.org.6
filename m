Return-Path: <linux-kernel+bounces-174457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907818C0F0C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4882C282225
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A71914AD1A;
	Thu,  9 May 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="qzztiXAk"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6C12FB3F;
	Thu,  9 May 2024 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715255766; cv=none; b=FuysAR942dOb0wHdbS24ONOOzEyfBZDkVa8IyQ/116TlSRdRniZq1H8nNhLuhdkkDh/zmFqAHpUGpPed7RvNi7XokeBwHrlZyKwbP7F/igU9OnU3OfTPUtwiXaZyUK7NWbEkWKcabdPuRzHzayB06ccS6WeCJjJtVTsJrJHHNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715255766; c=relaxed/simple;
	bh=2a4WGdNJa0aUKW/hYfKjmycnkRx12il4Ew/dHWz0o1M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o0rnj6iReT48bGy+Xhx/cgGt7YpvjRwq8l6Ij97ulkh2mmeO0O6JyZ014sqMPsJExoYnCblMu1dKeHn9QcTdcW8lYGpmKU0vsgZou6AwF+u/hdDxnDUUz9Yt65yX/4PwD6eb9LTJkDnP7rsKqR7lVbtCEC18W2ZKdpX+iYJ5TTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=qzztiXAk; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 38D836003C11;
	Thu,  9 May 2024 12:50:45 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id 7raz_5ZZ9ckV; Thu,  9 May 2024 12:50:43 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id EC5436003C0B;
	Thu,  9 May 2024 12:50:42 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1715255443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qrAMwJH6vJusA1DpEsGg7JE4BX5Fr4Y5uKHuSoJyReo=;
	b=qzztiXAktPgwcH0cvG5DQiw7pCSXr7pnLEo/H4wFuis4hsTEIlRWmiG5ggKiUntqAwWq4C
	8kpesgdKeQ+x1GuPA9Z2YwWhcESFLU3zqv8vRuoAg9OXnhXZ0+1oUdFjCUolVn0zf9+XMy
	Cb3ymyvaxy8QTw7Gy9jYjKc3bxvYyd8=
Received: from diogo-gram.home (unknown [IPv6:2a01:14:8070:dc60:4589:2164:1bc5:2670])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 170D13600A3;
	Thu,  9 May 2024 12:50:41 +0100 (WEST)
Date: Thu, 9 May 2024 12:50:36 +0100
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	lk@c--e.de, u.kleine-koenig@pengutronix.de, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: diogo.ivo@tecnico.ulisboa.pt
Subject: [RFC PATCH] usb: typec: ucsi_acpi: Add LG Gram quirk
Message-ID: <5qc55gruhn4pmutiukohauki5dehba6n2k22jgvpt7i3hafkon@v2ng2a33o7vv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some LG Gram laptops report a bogus connector change event after a
GET_PDOS command for the partner's source PDOs, which disappears from
the CCI after acknowledging the command. However, the subsequent
GET_CONNECTOR_STATUS in ucsi_handle_connector_change() still reports
this bogus change in bits 5 and 6, leading to the UCSI core re-checking
the partner's source PDOs and thus to an infinite loop.

Fix this by adding a quirk that signals when a potentially buggy GET_PDOS
command is used, checks the status change report and clears it if it is a
bogus event before sending it to the UCSI core.

[Sending as RFC both to see if this is a good idea and so that more
users can test it to gather all the models affected by this bug.]

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 60 ++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 8d112c3edae5..c67607f68b44 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -25,6 +25,7 @@ struct ucsi_acpi {
 	unsigned long flags;
 #define UCSI_ACPI_COMMAND_PENDING	1
 #define UCSI_ACPI_ACK_PENDING		2
+#define UCSI_ACPI_CHECK_BOGUS_EVENT	4
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
+	    ua->flags & UCSI_ACPI_CHECK_BOGUS_EVENT &&
+	    offset == UCSI_MESSAGE_IN) {
+		status = (struct ucsi_connector_status *)val;
+
+		/* Clear the bogus change */
+		if (status->change == bogus_change)
+			status->change = 0;
+
+		ua->flags &= ~UCSI_ACPI_CHECK_BOGUS_EVENT;
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
+		ua->flags |= UCSI_ACPI_CHECK_BOGUS_EVENT;
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
@@ -136,6 +189,13 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
 		},
 		.driver_data = (void *)&ucsi_zenbook_ops,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Z90Q"),
+		},
+		.driver_data = (void *)&ucsi_gram_ops,
+	},
 	{ }
 };
 
-- 
2.45.0


