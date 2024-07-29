Return-Path: <linux-kernel+bounces-265361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F793F007
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B152C1C217FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE0A13CFBD;
	Mon, 29 Jul 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNdLHdTE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE541EA91;
	Mon, 29 Jul 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242585; cv=none; b=RclpEE7brnmJnek9vlLlK3Bw3UfecoVx1MGhbsfMqEXJAO02mBf7M6qXfGNC1tjZZkoNCtu55qeXXJ9eWmBEEj6DxkKIrO2GcmL0WZQP8cazKtKGTjyVND76AQL66wbaOX04/2HE3ZzwjNiju9IE8flXq7DnYDa7xfgV4iywO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242585; c=relaxed/simple;
	bh=fypkPEhNf+inbXHpJqx5hCwkWqrhyK/dOnswq2hYCvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kKgSrBn0zRCMBRbwfDFERb1sp7iqCGlbEQlOB3NewBX5HGh6Y5rGy1u2XiflA7wWOwg1Y+RCcryd0ZsTCVmBNjJI2K64Fn3R302IY4yAq1KlpCW9yo/6wgubRzHPSk8qCrSWGg8rw11tpRlyyfz/UBwzDtYpyuiFRV5KMcx0IY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNdLHdTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18929C32786;
	Mon, 29 Jul 2024 08:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722242584;
	bh=fypkPEhNf+inbXHpJqx5hCwkWqrhyK/dOnswq2hYCvg=;
	h=From:Date:Subject:To:Cc:From;
	b=tNdLHdTEpwXDqCCjaJnMH/lng+l4Sb8owN0q9FUumyjY5Xy05MrQZF3PLGViuWZp0
	 3KridpDX1hFxbnBlpsi85hA4BK5p8S1EUbxYYT2e8JHCHfaXYgtRblGtCf9ObK3aV8
	 ZGoutTFiw4RNr2/jCdYvYba0ZcOPX0HzjVZH2L42lC+TYDhIsHRVa+z8fiIY+yicgb
	 jr47fLgL9v6IxzZ/By9oLkGSNKD34nKL7bykN1624FOXvIj9K6RsyjSndN35EUCw2v
	 r5cjVZiMpdG0p/FB5v2uLdxOidLFHnlc9ZRFyA5LYJ3j3oJOR4PC0y6PjFbOGg1nka
	 T3MgwtKqzJBKw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 29 Jul 2024 10:42:58 +0200
Subject: [PATCH v3] usb: typec: fsa4480: Check if the chip is really there
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-topic-fs4480_check-v3-1-f5bf732d3424@kernel.org>
X-B4-Tracking: v=1; b=H4sIABFWp2YC/32NQQ7CIBQFr9KwFsNHRHHVexhjKP20pA00UBtN0
 7tL68KNcTkveTMzSRgdJnIpZhJxcskFn+GwK4hptW+Qujoz4YwLxoHTMQzOUJuEOLO7adF01Gj
 NQDJbAQOSj5VOSKuovWnz1T/6Po9DROueW+l6y9y6NIb42sITrOvfxgQUaK2UVChqaZUue+d1D
 PsQG7L6Jv51nLj86eDZoRgYLYSqKziWHUaP/cexLMsbloMdaw4BAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722242581; l=2844;
 i=konradybcio@kernel.org; s=20230215; h=from:subject:message-id;
 bh=yjGaNryhQQJ9sTn9aPk0my2gzcjnpbcxDfSBNsl29XI=;
 b=jYP20R7PIrLG6ATC0v6rXU+h76xOUyEBRFlJ2TaXNIgjRUE1mMHGDxUmgNcxLfGl98ABHP4m3
 K2oj43q000vD119mrLViKSNr6X72m2MCa5oFo9VFlJx2KENp6ehboNg
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
- Don't sign off twice
- Pick up Dmitry's rb
- Link to v2: https://lore.kernel.org/r/20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org

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


