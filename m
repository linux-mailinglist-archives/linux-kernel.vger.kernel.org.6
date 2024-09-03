Return-Path: <linux-kernel+bounces-313507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F0C96A658
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBB0B2513E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B11191F68;
	Tue,  3 Sep 2024 18:20:10 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C3E19049A;
	Tue,  3 Sep 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387610; cv=none; b=qAgTsThna41vg30wQG25gagwhkf1hWB1hk+7QE20EzEmObak6OhG4vwG0ZTpLYv2hAvTCrtT5H2iPndVRQ+LNJZBfC8CWgwpTIYJF0X88hZ8APnMlcD5oiHg24SblKWmtNmYTQNf2PB8FAJqLGE34dvZf/ByPMPRpp+JrsO8pIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387610; c=relaxed/simple;
	bh=aHukWwifKUMWr1DYfuI1usnTDNDqNLcF/RF8jci/+pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C7XWrxJx09wn0yduSkEDKUJsl8dMqH9vN70yB9HqY95l2kRQKFNZKEZiYdH7GfNxHd6WnO0h5M13SMWh3CxFVlFUw40YP2wzmNXL1Zl/uwekrG1tZ/DMLIgb+gY/aw0MNHgZdGDWYGf3Bo1zrisTvwYtyMqJzPA+oX5b6r0y7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 9A50A14035E; Tue,  3 Sep 2024 20:19:56 +0200 (CEST)
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
Subject: [PATCH v3] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Date: Tue,  3 Sep 2024 20:19:17 +0200
Message-Id: <20240903181917.617400-1-lk@c--e.de>
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

Reported-by: Anurag Bijea <icaliberdev@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
Bisected-by: Christian Heusel <christian@heusel.eu>
Tested-by: Anurag Bijea <icaliberdev@gmail.com>
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


