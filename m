Return-Path: <linux-kernel+bounces-263195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695F893D280
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3931C211F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB54117A59A;
	Fri, 26 Jul 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV8zsQ5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61113C661;
	Fri, 26 Jul 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994219; cv=none; b=tTLwXd+ypaSTYF6BramiBuj++xmTq9c7LkhPbmLFz3XRHgsWPBeCnUSN6jUxoQ4idC8kX8mlgogZ+92djkV970i60j+Zl14absPxpQbACydmJLAqVHqI0EMV0CSjhJGdHPV/JaJztVzxHr29mwV2bXZa6CNKEibmsR6YXMOcVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994219; c=relaxed/simple;
	bh=WdUjymIP39VlvhkEooBVJPNl6TOuY/bBBImj9JhMh7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MiWubmFCG6Wu93PdhaahzD2zxFOTnoK3W1m4/H8hzs+frRvbmj6G9SB/A5RuguqNIWQr8UvHWeMn4aMBjBYJGYspLd2HEjhrXrIK2dOeQrAd6USJ9lppjG8JcmBgUrvqJc0+KIvb4w9YrPl4A2rdODKbTtEyp8MnimfRv3EHNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV8zsQ5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617B2C32782;
	Fri, 26 Jul 2024 11:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721994218;
	bh=WdUjymIP39VlvhkEooBVJPNl6TOuY/bBBImj9JhMh7Q=;
	h=From:Date:Subject:To:Cc:From;
	b=jV8zsQ5U8Y1weOk1EGErPE2uC5RPNyvTmeeDoA7rffNcPctROd1GC3NnRMW8IWQot
	 cWoXj8gHA/DZiqx9osdHzfZW2TSLQYdw/+2WLJQhMl7DXTDh6bq+/j8VHyk7UtCDrL
	 SOLBB4e4Cl9Ab0tdacmVBbiQ3VBeuXRIdRz6k53lA7syIrj+3VJmpaGe8gqhi9U37n
	 zvRveq1gzKmf2zKSZNF6yri74iM8qTYFiU2JEnxsV1Hgx+31K5XFJ/R0FXL6PlATjA
	 CVMTLwwbTk/7Rudb2Ozr5bYOXnky+CLUCMryzfMjtrukbb2ZFSCHbvR0xACdpggJ5B
	 +PM5Ur9t1qADA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 26 Jul 2024 13:43:30 +0200
Subject: [PATCH v2] usb: typec: fsa4480: Check if the chip is really there
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOGLo2YC/32NQQrCMBAAv1JyNpINoRhP/kOKpOmmWSxJ2dSil
 P7d2Ad4nIFhNlGQCYu4NptgXKlQThX0qRE+ujSipKGy0EobpUHLJc/kZSjGXNTDR/RP6Z1T0Kr
 QgwJRw94VlD275GNN02uaqpwZA72P072rHKksmT/HeIWf/ftYQYIcrG0tmqEN1t0mSo7zOfMou
 n3fv7VTaQ7KAAAA
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721994216; l=2675;
 i=konradybcio@kernel.org; s=20230215; h=from:subject:message-id;
 bh=8qSJNF5RxEGsCuxH9KnuktPDNpABmmYxSCMU6sObgb8=;
 b=buujFb7m0yC01zQdPPWo22ySybuDNMXLBvkU1Mu0UManl7qLRVVQ1yuhskG0GMvpyznx6GE4e
 eTJLmLfciOTB/twgM1HlLEUNqHsB0nV3vQTt5SF+2HSbdDh2O6qD1EV
X-Developer-Key: i=konradybcio@kernel.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Currently, the driver will happily register the switch/mux devices, and
so long as the i2c master doesn't complain, the user would never know
there's something wrong.

Add a device id check (based on [1]) and return -ENODEV if the read
fails or returns nonsense.

Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
the ID mentioned in the datasheet does indeed show up:
 fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)

[1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf

Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
---
Changes in v2:
- Prepend the new defines with FSA4480_ to make them more obvious
- Link to v1: https://lore.kernel.org/r/20240212-topic-fs4480_check-v1-1-d9969e4d6f9a@linaro.org
---
 drivers/usb/typec/mux/fsa4480.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
index cb7cdf90cb0a..cd235339834b 100644
--- a/drivers/usb/typec/mux/fsa4480.c
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -13,6 +13,10 @@
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 
+#define FSA4480_DEVICE_ID	0x00
+ #define FSA4480_DEVICE_ID_VENDOR_ID	GENMASK(7, 6)
+ #define FSA4480_DEVICE_ID_VERSION_ID	GENMASK(5, 3)
+ #define FSA4480_DEVICE_ID_REV_ID	GENMASK(2, 0)
 #define FSA4480_SWITCH_ENABLE	0x04
 #define FSA4480_SWITCH_SELECT	0x05
 #define FSA4480_SWITCH_STATUS1	0x07
@@ -251,6 +255,7 @@ static int fsa4480_probe(struct i2c_client *client)
 	struct typec_switch_desc sw_desc = { };
 	struct typec_mux_desc mux_desc = { };
 	struct fsa4480 *fsa;
+	int val = 0;
 	int ret;
 
 	fsa = devm_kzalloc(dev, sizeof(*fsa), GFP_KERNEL);
@@ -268,6 +273,15 @@ static int fsa4480_probe(struct i2c_client *client)
 	if (IS_ERR(fsa->regmap))
 		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
 
+	ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
+	if (ret || !val)
+		return dev_err_probe(dev, -ENODEV, "FSA4480 not found\n");
+
+	dev_dbg(dev, "Found FSA4480 v%lu.%lu (Vendor ID = %lu)\n",
+		FIELD_GET(FSA4480_DEVICE_ID_VERSION_ID, val),
+		FIELD_GET(FSA4480_DEVICE_ID_REV_ID, val),
+		FIELD_GET(FSA4480_DEVICE_ID_VENDOR_ID, val));
+
 	/* Safe mode */
 	fsa->cur_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
 	fsa->mode = TYPEC_STATE_SAFE;

---
base-commit: 2347b4c79f5e6cd3f4996e80c2d3c15f53006bf5
change-id: 20240212-topic-fs4480_check-caa0160fb101

Best regards,
-- 
Konrad Dybcio <konradybcio@kernel.org>


