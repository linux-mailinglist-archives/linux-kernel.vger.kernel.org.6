Return-Path: <linux-kernel+bounces-318292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2220896EB3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6768289200
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7593714831F;
	Fri,  6 Sep 2024 06:59:16 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB966141987;
	Fri,  6 Sep 2024 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605956; cv=none; b=Xe2RoSDXo9VS/snibbv4geHEPUZ7haQ2+HT1aNmc9Ib6+3aeishuYumO5XKeF6C40FfgdfTOq4ZNlVviXnleTP6LQUxZlp85TxHPOX8bPRpoa/c2Ii/JoAuz2f2pH9JBGtAyYJkaP9OjoWXnZ1jhaRjbX6jiMOW0WetArPLJX94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605956; c=relaxed/simple;
	bh=mnUu2HyKbLvtOYL9epi6A7gg7rKyVXS4ja6D7jENLhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R8roNNkmRKih3dLp/9ujFAQA1c7BimEyyA6m/EUrC1aDuFr1kSO67l137mUs6jbDNZiQraZ9GmGjMwLIwUUvThZSv2LJwzMdSFvUUuAugsQmfw0tY0hy7ybMdNpEHFBLM9cCRYiPV1EaaVP8w+CS99OXt7JeVFXtm0zrRBh9xSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 438B814035E; Fri,  6 Sep 2024 08:59:04 +0200 (CEST)
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
Subject: [PATCH v4] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Date: Fri,  6 Sep 2024 08:58:53 +0200
Message-Id: <20240906065853.637205-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the busy indicator is set, all other fields in CCI should be
clear according to the spec. However, some UCSI implementations do
not follow this rule and report bogus data in CCI along with the
busy indicator. Ignore the contents of CCI if the busy indicator is
set.

If a command timeout is hit it is possible that the EVENT_PENDING
bit is cleared while connector work is still scheduled which can
cause the EVENT_PENDING bit to go out of sync with scheduled connector
work. Check and set the EVENT_PENDING bit on entry to
ucsi_handle_connector_change() to fix this.

Finally, check UCSI_CCI_BUSY before the return code of ->sync_control.
This ensures that the command is cancelled even if ->sync_control
returns an error (most likely -ETIMEDOUT).

Reported-by: Anurag Bijea <icaliberdev@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
Bisected-by: Christian Heusel <christian@heusel.eu>
Tested-by: Anurag Bijea <icaliberdev@gmail.com>
Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 4039851551c1..d6d61606bbcf 100644
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
 
@@ -107,15 +111,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 		size = clamp(size, 0, 16);
 
 	ret = ucsi->ops->sync_control(ucsi, command);
-	if (ret)
-		return ret;
-
-	ret = ucsi->ops->read_cci(ucsi, cci);
-	if (ret)
-		return ret;
+	if (ucsi->ops->read_cci(ucsi, cci))
+		return -EIO;
 
 	if (*cci & UCSI_CCI_BUSY)
 		return -EBUSY;
+	if (ret)
+		return ret;
 
 	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
@@ -1249,6 +1251,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	mutex_lock(&con->lock);
 
+	if (!test_and_set_bit(EVENT_PENDING, &ucsi->flags))
+		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
+			     __func__);
+
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
 
 	ret = ucsi_send_command_common(ucsi, command, &con->status,
-- 
2.43.0


