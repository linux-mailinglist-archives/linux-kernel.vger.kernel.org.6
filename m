Return-Path: <linux-kernel+bounces-373016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02409A509D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 21:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F063F1C20CBE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8A191F78;
	Sat, 19 Oct 2024 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax//qO26"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA97DA68;
	Sat, 19 Oct 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729367930; cv=none; b=Tk9hqOeCHPC4Ao5SnvLoIRwo7Wg2VFXB4/6rATBdvtaLtub/TvTNsxcQZSqzTRT8FyrywXN6sdrgXlSIml525IKveCz6x1CuaTgAwCJ1YtlVu7hod771+r+pEliDcs3rmewkMpQ+Z75W1ediOpfXmpx5+AwNQxeZv7jKbDs7j0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729367930; c=relaxed/simple;
	bh=JMfW/Olr5z+i8+jK1A2z0kHZjCvYhRHWAE+BhT2sgCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QSM/O9zba+h+hu6pkKVB3HdbcqzknWob1dP4NRo5rZLVYNEPIzYi1TX412FF+faIi8JyDlQHyW/nNUjLvxHQKz7wdlgq+mO2uVUPOVdWyxYx2yjolvyfyBD/gH7buJwgoqjr0+iqESINHFNiQKUEg7JzBqWjec9Bz7Id9pE9+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax//qO26; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431481433bdso33064665e9.3;
        Sat, 19 Oct 2024 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729367926; x=1729972726; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFvW4rp/E9FJt5+sbvea9VrBg1T9Uy4KOb+9FJSOYK8=;
        b=ax//qO26GriYD8Bd6sfENcEQQSxz2EL+z5ZfcXYOMYdXm7lMbu1jllEHcBysMcQqoT
         6nke4/X7CKHAsn0dctEWoMt+4VT4eUvdTYS1RlnPCt3YcOwKS2XWl8HZR63ZLm9pOl3Y
         Q9/XJ2FQmt0dLpkHbsPNTgbCyLHBXCpQf3tA7CZa15kSXON+NnzmEHUGfT+wDN9rcDGm
         5VXVfgHGt5CAfYEjcWhACryase7oAvSZkKxXfVUTIZH5NGo0dPUCsW+aNRGELIzuWUOq
         C4wteibb3suND1Jx4y/WswwNBM6MFJyhrOSJko1VWMI4hxvc+EBWL+WWv0kNGmJ5IQ/L
         M+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729367926; x=1729972726;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFvW4rp/E9FJt5+sbvea9VrBg1T9Uy4KOb+9FJSOYK8=;
        b=DFGY/WFuN3IOmRh/BT3PcQ9C8UKeKW6LLacO3YLyDUhxMNChygjBbnkQGaMwOkL02+
         /6f+YWz5xrsUXgQnl6yzutp1ntwj7qBkuLuoWN2oPi6g3kmyHc6XDjdJhZb6LaZuTNDh
         Ezw10e48F+n2xoaxF3UmJ+KwIfNmd9r9k57j1Z72Q4ETQ4e2L92qJnRTtTVkF6b/NwvX
         oPW6hOPyQ1Lh8op4PEfr8LZjTaSbmdO/szOTekZICWKlq+pSQ6So0NsNCQ9luBKn0iAj
         XycxDMDc0oLSO5suxqyhTZVzx20iKltdXNBJ36Wdr9Hms0YxqqZVUr6qCcDWCS76/0Zb
         a8AA==
X-Forwarded-Encrypted: i=1; AJvYcCURXd4mqu1MQPBwBio9zM2u/YkaQe2uX46GKp5UkWbbc+QmPVMH2EvuedSqyeMeXLeGXSaNU6b1Gty3pyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxK/Xy7mouleUXgU3UHi4SrvQCe/5Hi9QuuI037oBS0Mlmtg/
	7Z5r/siVbv5x4yu8m9dt8HdRlqRX6nrKEZQO2WZ0ny/rmiidSgD7
X-Google-Smtp-Source: AGHT+IFRVIcMJbZZ4+J0EmJFgI2k2FQpPkd7RivZmQYF5u13kJkS2gdNpN3eQ/1kH3iSrkuKOxzCiA==
X-Received: by 2002:a05:600c:4687:b0:431:4f5e:1f61 with SMTP id 5b1f17b1804b1-43161637703mr58010105e9.14.1729367926335;
        Sat, 19 Oct 2024 12:58:46 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-f8f1-d6d3-1513-aa34.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f8f1:d6d3:1513:aa34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c3173sm2996885e9.33.2024.10.19.12.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 12:58:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 19 Oct 2024 21:58:43 +0200
Subject: [PATCH] soundwire: mipi_disco: fix unreleased fwnode_handle in
 error paths
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-mipi_disco-of_node_put-v1-1-1de27e6852c4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHIPFGcC/x3MTQqAIBBA4avErBNSkn6uEiGWY80iFa0IwrsnL
 b/Fey8kjIQJxuqFiDcl8q6A1xWsu3YbMjLFIBrR8oYP7KBAylBaPfNWOW9Qhetk/SDbbtFWcNl
 BiUNES88/nuacPymaTuNoAAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729367925; l=4860;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=JMfW/Olr5z+i8+jK1A2z0kHZjCvYhRHWAE+BhT2sgCw=;
 b=ussTsiacsGNRi7rvonOlP6GEWhYfM2T1OHmi8sW9gDp6Rs9SOEa8JTvYuysXYeVrH8oPUOmKT
 2IhijB2yURbAndYk35cx9iMJjTtUJqtrtc6eESTNUMcG2eotDB3/yZ9
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Multiple error paths have been added after initializing 'link' and
'node' via device_get_named_child_node(), which requires explicit calls
to fwnode_handle_put() when the variable is not longer required.

Instead of adding the missing calls to fwnode_handle_put(), and
considering that the bug was recently introduced, use the __free() macro
to automatically release the nodes when they go out of scope. This
approach removes the need for explicit calls to fwnode_handle_put() and
is more robust in case new error paths are added again.

Fixes: a489afc105ed ("soundwire: mipi-disco: add error handling for property array read")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/soundwire/mipi_disco.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 9d59f486edbe..cd1f0f8d07da 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -50,7 +50,6 @@ static bool mipi_device_property_read_bool(const struct device *dev,
 int sdw_master_read_prop(struct sdw_bus *bus)
 {
 	struct sdw_master_prop *prop = &bus->prop;
-	struct fwnode_handle *link;
 	const char *scales_prop;
 	char name[32];
 	int nval;
@@ -65,7 +64,8 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	snprintf(name, sizeof(name),
 		 "mipi-sdw-link-%d-subproperties", bus->link_id);
 
-	link = device_get_named_child_node(bus->dev, name);
+	struct fwnode_handle *link __free(fwnode_handle) =
+		device_get_named_child_node(bus->dev, name);
 	if (!link) {
 		dev_err(bus->dev, "Master node %s not found\n", name);
 		return -EIO;
@@ -89,10 +89,8 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		prop->clk_freq = devm_kcalloc(bus->dev, prop->num_clk_freq,
 					      sizeof(*prop->clk_freq),
 					      GFP_KERNEL);
-		if (!prop->clk_freq) {
-			fwnode_handle_put(link);
+		if (!prop->clk_freq)
 			return -ENOMEM;
-		}
 
 		ret = fwnode_property_read_u32_array(link,
 				"mipi-sdw-clock-frequencies-supported",
@@ -124,10 +122,8 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		prop->clk_gears = devm_kcalloc(bus->dev, prop->num_clk_gears,
 					       sizeof(*prop->clk_gears),
 					       GFP_KERNEL);
-		if (!prop->clk_gears) {
-			fwnode_handle_put(link);
+		if (!prop->clk_gears)
 			return -ENOMEM;
-		}
 
 		ret = fwnode_property_read_u32_array(link,
 					       scales_prop,
@@ -152,8 +148,6 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	fwnode_property_read_u32(link, "mipi-sdw-command-error-threshold",
 				 &prop->err_threshold);
 
-	fwnode_handle_put(link);
-
 	return 0;
 }
 EXPORT_SYMBOL(sdw_master_read_prop);
@@ -220,7 +214,6 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 			      struct sdw_dpn_prop *dpn, int count, int ports,
 			      char *type)
 {
-	struct fwnode_handle *node;
 	u32 bit, i = 0;
 	unsigned long addr;
 	char name[40];
@@ -237,7 +230,8 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 		dpn[i].num = bit;
 
-		node = device_get_named_child_node(&slave->dev, name);
+		struct fwnode_handle *node __free(fwnode_handle) =
+			device_get_named_child_node(&slave->dev, name);
 		if (!node) {
 			dev_err(&slave->dev, "%s dpN not found\n", name);
 			return -EIO;
@@ -255,10 +249,8 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 						    dpn[i].num_words,
 						    sizeof(*dpn[i].words),
 						    GFP_KERNEL);
-			if (!dpn[i].words) {
-				fwnode_handle_put(node);
+			if (!dpn[i].words)
 				return -ENOMEM;
-			}
 
 			ret = fwnode_property_read_u32_array(node,
 					"mipi-sdw-port-wordlength-configs",
@@ -298,10 +290,8 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 						       dpn[i].num_channels,
 						       sizeof(*dpn[i].channels),
 						 GFP_KERNEL);
-			if (!dpn[i].channels) {
-				fwnode_handle_put(node);
+			if (!dpn[i].channels)
 				return -ENOMEM;
-			}
 
 			ret = fwnode_property_read_u32_array(node,
 					"mipi-sdw-channel-number-list",
@@ -317,10 +307,8 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 					dpn[i].num_ch_combinations,
 					sizeof(*dpn[i].ch_combinations),
 					GFP_KERNEL);
-			if (!dpn[i].ch_combinations) {
-				fwnode_handle_put(node);
+			if (!dpn[i].ch_combinations)
 				return -ENOMEM;
-			}
 
 			ret = fwnode_property_read_u32_array(node,
 					"mipi-sdw-channel-combination-list",
@@ -358,8 +346,6 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 				return ret;
 		}
 
-		fwnode_handle_put(node);
-
 		i++;
 	}
 

---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241019-mipi_disco-of_node_put-89547baf2157

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


