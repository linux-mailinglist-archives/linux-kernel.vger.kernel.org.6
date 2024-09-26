Return-Path: <linux-kernel+bounces-340450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EDE987395
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4151F272B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B9517BB17;
	Thu, 26 Sep 2024 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TF3BC4rZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F89474;
	Thu, 26 Sep 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353790; cv=none; b=uzVIQh4h0+P6y4DHy2U3d9Mul8cpIrKxA56snNqhLhKbeEkkVqoz5I6BieQ3TosNd0QMVCR8jgFwkfZ4q7dMzCr7fb+lccB2zCrt+x5btd0KaF++8lFaUH+VUKVPb7f1kUDJMka5qNE2R0qUGV+zUsGq8+2G7SDAR60mkGMcrjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353790; c=relaxed/simple;
	bh=4o9N701hsXjuJDGiYmXoSpYXfkYkrSo/UF/Lil/I1PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBXEYIOZOyjDuZO4z4Ma/F4IIYZ7mu8mmT6cJyGG8xbbzmWMsIM+eGXe7wqTXds7G1WFpZXq1faBbshVP3jFHdjRkSrsqly97Aba6o9fRNTIypxqHdWL4sG0VnIqsFp6OAe8bnF297LPlKTTLLCnFen0f1HT2wetjNRsvehaKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TF3BC4rZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727353789; x=1758889789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4o9N701hsXjuJDGiYmXoSpYXfkYkrSo/UF/Lil/I1PU=;
  b=TF3BC4rZzMaHhDX50qtxBsKvXC/shSlZgiE35YXFwwLHHBLXXeeyEReD
   HDFL+VrtEZJH53jcwgyeqrh0TFskTmRlI0T379SiEOmD9qMz4riQQWowB
   YuARDyEIqjeWQ57hmXd+hMmF9mm81fw53B9/YLW4PN2Piw1soRwYXIRPv
   vfukodpcWvL1s8bbG92Z6maUMkaVZGMdE3b0bfap48Xza5D0ceG22qhEV
   nsBAn2rv5nEgXbjARUzCXp9rrnzzwbYHL3/kilu2iA6YJd5P1NuiA4o5g
   N8SN+0WTmwCUqsSoNJKK3Ks7orz5KNy1atrzkQg0FAl52dnWEv3hredug
   A==;
X-CSE-ConnectionGUID: Tlj2SzzcTuKWrU8k+cFTYA==
X-CSE-MsgGUID: FFpPgyPJQaK6t6JsveEcow==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26566823"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26566823"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 05:29:49 -0700
X-CSE-ConnectionGUID: JS51xHClSNSl5Xfh1EO8tw==
X-CSE-MsgGUID: sJtWsRhHRY2L7oL2CusJ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="102949819"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 26 Sep 2024 05:29:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2CC03432; Thu, 26 Sep 2024 15:29:46 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/1] usb: typec: stusb160x: Make use of i2c_get_match_data()
Date: Thu, 26 Sep 2024 15:29:15 +0300
Message-ID: <20240926122944.1251923-1-andriy.shevchenko@linux.intel.com>
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
v2: fixed rebase issue which led to the compilation error (LKP)
 drivers/usb/typec/stusb160x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/stusb160x.c b/drivers/usb/typec/stusb160x.c
index f3140fc04c12..6d85b25b40bc 100644
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
+	regmap_config = i2c_get_match_data(client);
+
 	chip->regmap = devm_regmap_init_i2c(client, regmap_config);
 	if (IS_ERR(chip->regmap)) {
 		ret = PTR_ERR(chip->regmap);
-- 
2.43.0.rc1.1336.g36b5255a03ac


