Return-Path: <linux-kernel+bounces-344147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E6298A566
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E66B1F246B4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D0E18F2CF;
	Mon, 30 Sep 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBhyRlDn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794318DF80
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703305; cv=none; b=EzJaogEZB236mrJRRiU8ktLJe4R+NHIYQkjdEVi4ogFS/5k4t0hPlGLhSsAANVrNVMyTc2ob0UP2Y2pOR+FOrGiP9EJFPnpaOf3UZ1i58HsYW4Upxb31qYqvxOv2spVZxPKp+zO5t2Ww2BrZeMN3Y+CcyUt1ZZWbp7Mz7vhpmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703305; c=relaxed/simple;
	bh=BiM2OmFLeUoR9r/EG0fb8PW9Wr23AnlatA3LWDsWNFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gcAljb9838VaxFZ/IMtEsv7LlQsQYt48wDejL3xDPrTrCk/pYfKeVghWfODiwycDNZrHRzoGtWPFUP4Ot0bgjwg78uLQ8Yg/TzY/a2A3AmQ5g2lKhddXbSF2vTyT7FclS4JeLuWxE8/DdLVzgeGC4cK9Giv30SDkZbI5sLfxv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBhyRlDn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727703304; x=1759239304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BiM2OmFLeUoR9r/EG0fb8PW9Wr23AnlatA3LWDsWNFI=;
  b=GBhyRlDnJ1eg7AOBRmVZMFhJltlQX7pMSK+v7WCAV6q42/LexrHaTrFQ
   53KeuE+KN8jNxz5slorCFiX30c3ZD9utrf0aUuEj427+idPjs07uG+9eL
   MqLVWm/5P9N5QvOJVcw52e9oX5Znb2JR5+iY459acdTmAw7IKZKGPtW7S
   RAwHHAkAUz9SshYt+7XTioHsoWqg/gE272cXtJpTP8Ly31Szw08BfTPU1
   wamVkhrMgo80m6xR5DZXTyXgib1OJwauNNkO/a4KP6dBLeS0dlOQKZlL/
   UX6cJVgJ7uwNbETdWk803auuRgTkvsZTZcHS62qqNvw2uP3eDZ8jtZgVZ
   Q==;
X-CSE-ConnectionGUID: 2e3JZxbES+KRIZk962iTkA==
X-CSE-MsgGUID: 5Obh7h05Teq2PI0Q1JtZjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26914931"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26914931"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:34:59 -0700
X-CSE-ConnectionGUID: ifpph7yzQJONU1YfLdPsZA==
X-CSE-MsgGUID: psEhO+49QUaT9nRUds31sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72980632"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2024 06:34:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DC022321; Mon, 30 Sep 2024 16:34:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Robin van der Gracht <robin@protonic.nl>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v1 1/1] auxdisplay: ht16k33: Make use of i2c_get_match_data()
Date: Mon, 30 Sep 2024 16:26:42 +0300
Message-ID: <20240930133453.3403318-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Get matching data in one step by switching to use i2c_get_match_data().
As a positive side effect the I²C ID table is in sync of OF one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

I believe this is correct update. And here is why.

1) The documentation of the I2C user space device instantiation does not
mention a compatible string. it relies on the term 'name', which I believe
has direct link to the field .name in the struct i2c_device_id.

2) The above mentioned documentation says explicitly when user space
instantiation should be used. And for this driver it seems the only last
piece might be the case, i.e. prototyping / DIY configuration. For this
we don't need to rely on vendor ID anyway as in new supported hardware
the DT/ACPI emumeration is assumed.

3) Moreover, the currently used i2c_of_match_device() seems never be
considered to be used outside of i2c subsystem. Note, that it's being
used for device matching and probe, meaning firmware tables and board
info.

Also note, that the other (yes, it's ONLY 2 drivers call this API)
user of that API is going to be updated as well. Taking 3) into account
I think soon we remove that API from bein exported to the modules.

 drivers/auxdisplay/ht16k33.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index b00012a556fb..96ad9e972bd7 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16bf3a36c62fd8k33.c
@@ -657,7 +657,6 @@ static int ht16k33_seg_probe(struct device *dev, struct ht16k33_priv *priv,
 static int ht16k33_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	const struct of_device_id *id;
 	struct ht16k33_priv *priv;
 	uint32_t dft_brightness;
 	int err;
@@ -672,9 +671,8 @@ static int ht16k33_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	priv->client = client;
-	id = i2c_of_match_device(dev->driver->of_match_table, client);
-	if (id)
-		priv->type = (uintptr_t)id->data;
+	priv->type = (uintptr_t)i2c_get_match_data(client);
+
 	i2c_set_clientdata(client, priv);
 
 	err = ht16k33_initialize(priv);
@@ -747,7 +745,9 @@ static void ht16k33_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ht16k33_i2c_match[] = {
-	{ "ht16k33" },
+	{ "3108", DISP_QUAD_7SEG },
+	{ "3130", DISP_QUAD_14SEG },
+	{ "ht16k33", DISP_MATRIX },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ht16k33_i2c_match);
-- 
2.43.0.rc1.1336.g36b5255a03ac


