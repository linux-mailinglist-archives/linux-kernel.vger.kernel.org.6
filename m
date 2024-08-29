Return-Path: <linux-kernel+bounces-306585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C29640D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E21D285C06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12318E379;
	Thu, 29 Aug 2024 10:01:48 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992CA18E039;
	Thu, 29 Aug 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925708; cv=none; b=MvbO6qN0kK9XGtIV2EY3aV6l6rdtJSf54hC42342zyZ4T+EOpJoD4ueW+qAJ+6ce3H74PeiFSdzTzcHWv4LrU/rlpX+arClMxC0Qp5LhyKSZc79bP8Ptum+Af4Fu+Uj+Begv2/SQ/ySUuwiNjHUfwM4CKNESICwxEnbibE227QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925708; c=relaxed/simple;
	bh=dO9aGTEzHhiObaLZVHX6UxHyA7DmqONcFxkTgEUL38Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPPNnMSOFI19H7mUehfp7JhI6XKAYo9TvAgJO1lIwVGMe8v8IZyIF4D41swy90BPbbcRMt+HGbjWPswFTz8doofj8dS9vutIewpuZcmiJRE3AfqvgI5wO/iqu1d5SDsnw5cuiNreO8zyV8z4Z97ot8mw9r2qaVtbEdyUhjJ6AjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 9C03B1403C9; Thu, 29 Aug 2024 12:01:36 +0200 (CEST)
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
Subject: [PATCH v2 2/2] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Date: Thu, 29 Aug 2024 12:01:09 +0200
Message-Id: <20240829100109.562429-2-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240829100109.562429-1-lk@c--e.de>
References: <20240829100109.562429-1-lk@c--e.de>
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
 drivers/usb/typec/ucsi/ucsi_acpi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 7a5dff8d9cc6..aa586525ab4c 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -197,6 +197,13 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
 		},
 		.driver_data = (void *)&ucsi_zenbook_ops,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop"),
+		},
+		.driver_data = (void *)&ucsi_zenbook_ops,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
-- 
2.43.0


