Return-Path: <linux-kernel+bounces-339154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7269860DC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8952D1C269D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472EE18DF60;
	Wed, 25 Sep 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJhg+jOY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B917C9BE;
	Wed, 25 Sep 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271598; cv=none; b=WJYgw2jJbkldSXMhl7btvCPljTf9VH0BXNdZKtQMBEIV/m/sDfUQkfKOUISOeCFAJdk3elbiZaVMFbAEFckdeco37jXhiOowE/G0bS3zB5vl7cNhXUe1usa1bJuIHigvDwDODxYf30mGMpO50pgBZyvq2Za0wkOaKXTw2Lt3ZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271598; c=relaxed/simple;
	bh=qQ9PFxh7oX+jQ+NfJN3u+krxou/A4A3PvXZLpj4Fbgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iw80+cyBXk408BFkocTa+Wu2CWpZawE6+KBVnF4+N5hnUvQ129a+Oi1quJ8Bk1uYQTCuwodVSvfrGSyZGgaXyl6asipGky5kS6Fetv8MWii5tgU8KirEMvOm08viW2QW8icO1rYuqnKYA3QOPp+s+w0J2UthIDX7L4KK/U0D5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJhg+jOY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727271597; x=1758807597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qQ9PFxh7oX+jQ+NfJN3u+krxou/A4A3PvXZLpj4Fbgc=;
  b=EJhg+jOYK3bM4u2BVW/uAMBBlLqppAHoejNjNB+RZPv7caTC1WPstBcy
   XmWFb8iNLMRTDXAq35JsKZO+j1KSwNZcaviIhcTu8FrmQoBC90gwtjBcT
   6+FO2jVfq9b/HUZGrq8x8CGe3/CqEx9Ks/n886dUBih2msHGfHYCzDciP
   mMjrBhYHS4W8Ax8k1kImzxWIrSrTvsg7OJSDgBXux4b0WYXRURx+vpK2F
   iVtuNO+pYGFx5UzQlZm8AN4JIWoLXz/8LzCsg6vVBG5YGy4S0aoxrcbvr
   HmE5UDZRDBvEclpxBO0Ji8SsBrIL0qXNBob33YDZCfSRl8Q0sYkfSMsf/
   g==;
X-CSE-ConnectionGUID: 2ssszbHjQOO2OmE4RFwSGA==
X-CSE-MsgGUID: iiMTH3V/SUC63aKHGl3Wiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26188065"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26188065"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 06:39:56 -0700
X-CSE-ConnectionGUID: VQ7Y7CU+TuqM1QC7ygGs7Q==
X-CSE-MsgGUID: gl34tzM9RMWvhumE+aWn1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="102604453"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 25 Sep 2024 06:39:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9AF64565; Wed, 25 Sep 2024 16:39:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] usb: typec: stusb160x: Make use of i2c_get_match_data()
Date: Wed, 25 Sep 2024 16:39:52 +0300
Message-ID: <20240925133952.1067949-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get matching data in one step by switching to use i2c_get_match_data().
As a positive side effect the matching data is qualified as a constant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/typec/stusb160x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index f3140fc04c12..9ed1fc668a3f 100644
--- a/drivers/usb/typec/stusb160x.c
+++ b/drivers/usb/typec/stusb160x.c
@@ -633,9 +633,8 @@ MODULE_DEVICE_TABLE(of, stusb160x_of_match);
 
 static int stusb160x_probe(struct i2c_client *client)
 {
+	const struct regmap_config *regmap_config;
 	struct stusb160x *chip;
-	const struct of_device_id *match;
-	struct regmap_config *regmap_config;
 	struct fwnode_handle *fwnode;
 	int ret;
 
@@ -645,8 +644,8 @@ static int stusb160x_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, chip);
 
-	match = i2c_of_match_device(stusb160x_of_match, client);
-	regmap_config = (struct regmap_config *)match->data;
+	regmap_config = i2c_get_match_data(&client->dev);
+
 	chip->regmap = devm_regmap_init_i2c(client, regmap_config);
 	if (IS_ERR(chip->regmap)) {
 		ret = PTR_ERR(chip->regmap);
-- 
2.43.0.rc1.1336.g36b5255a03ac


