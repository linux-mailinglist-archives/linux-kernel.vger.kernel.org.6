Return-Path: <linux-kernel+bounces-326121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542EC976324
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EE3B23A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CF19069B;
	Thu, 12 Sep 2024 07:42:02 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920FD186E58;
	Thu, 12 Sep 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126922; cv=none; b=uEB7MivIW+WlzN0daTb4V/eKBy0/v+klWcijkj+BYS4exj38VAd6jHpVxvBGkt0UFMK8CGPSlv82qLQkX74i9mw8E5bCYp7P19wnhSWCx5Rwvm1wPObc7PeQ0QBDhTxCnoVol997K3WSy0Klm9HLK0Hk5LuGnhEoSC/MImp2IfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126922; c=relaxed/simple;
	bh=qCqYFttykGHahVVtMisMWvxk28hUdSktJEz0yRCXa4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZxEAqDLfIWVkh4X/fq64jQ8QPe5Be20X4wbxDPimtAiwUl8Oc5qxkVveqv0XlJ0baJwDeZrWpmQsVt26ZtAbWA1dz3VWranBDoJr7/jGbto2h/dhdbypgUCBtCFAQf/crOOkBUVvl0yO3jw8MlbGwSVA07CNhXhZyy4ne3WMdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 07A621402BA; Thu, 12 Sep 2024 09:41:57 +0200 (CEST)
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
Subject: [PATCH v5] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Date: Thu, 12 Sep 2024 09:41:32 +0200
Message-Id: <20240912074132.722855-1-lk@c--e.de>
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
 V1 -> V2: Split out the ucsi_acpi.c part
 V2 -> V3: Dropped the ucsi_acpi.c part due to conflicts
 V3 -> V4: Additional fix for command cancelling
 V4 -> V5: Rebased onto usb-next

 drivers/usb/typec/ucsi/ucsi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 35dce4057c25..e0f3925e401b 100644
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
 
@@ -103,15 +107,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 		return -EINVAL;
 
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
 		return ucsi_run_command(ucsi, UCSI_CANCEL, cci, NULL, 0, false) ?: -EBUSY;
+	if (ret)
+		return ret;
 
 	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
@@ -1197,6 +1199,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	mutex_lock(&con->lock);
 
+	if (!test_and_set_bit(EVENT_PENDING, &ucsi->flags))
+		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
+			     __func__);
+
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
 
 	ret = ucsi_send_command_common(ucsi, command, &con->status,
-- 
2.43.0


