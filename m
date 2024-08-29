Return-Path: <linux-kernel+bounces-306584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D89640D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB9A1C22294
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AFE18E340;
	Thu, 29 Aug 2024 10:01:44 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC6156875;
	Thu, 29 Aug 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925703; cv=none; b=eNgXf/18IbBZnQEUeDe8qcId07gpnwAKI01RbJe0l3IZjSEde8K3rxQYhKO8Q4bghbCNll0BvX9qFRLqlUvJUYOugFWp2iX2r7eJSH1IZZTP2Xoe0RzzTkKk7DbmmS5NS/IVIj/WYCpPiWUB0/WKa2Y1riKJXyHoVbUIdAiU1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925703; c=relaxed/simple;
	bh=H5YNwVtP2ecb0NW2WhOWu0cuIg14irWhjFgh+y/crAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=duH4C90lZJ8Oun9A/OXI5/EpGRdIC8/0nKxhbIr8TkuHnc2NaMD4UmVvos2K+ddb5PedW7sd3xQXNMTIiLE8MK3nc9LrqChwoOHw6hhbY9XvYR0mNclKQtOegrVhpBFfcwOa4qelba7aRGa7TVfUJ6SKIaPkPLwKlbQdXME58sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 5A9FA1403C1; Thu, 29 Aug 2024 12:01:31 +0200 (CEST)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v2 1/2] usb: typec: ucsi: Enable ASUS zenbook quirk for VivoBooks
Date: Thu, 29 Aug 2024 12:01:08 +0200
Message-Id: <20240829100109.562429-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The quirk for some ASUS zenbook models is required for
ASUS VivoBooks. Apply the quirk to these as well.

This is part of the fix for the builtin keyboard on ASUS
VivoBooks.

Reported-by: Anurag Bijea <icaliberdev@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
Bisected-by: Christian Heusel <christian@heusel.eu>
Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 4039851551c1..540cb1d2822c 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -38,6 +38,10 @@
 
 void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
 {
+	/* Ignore bogus data in CCI if busy indicator is set. */
+	if (cci & UCSI_CCI_BUSY)
+		return;
+
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
 
@@ -1249,6 +1253,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	mutex_lock(&con->lock);
 
+	if (!test_and_set_bit(EVENT_PENDING, &ucsi->flags))
+		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
+			     __func__);
+
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
 
 	ret = ucsi_send_command_common(ucsi, command, &con->status,
-- 
2.43.0


