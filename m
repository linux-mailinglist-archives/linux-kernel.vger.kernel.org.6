Return-Path: <linux-kernel+bounces-563208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DC2A6390D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167723AE119
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F71547C9;
	Mon, 17 Mar 2025 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEPwx1IQ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA438DF9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742171990; cv=none; b=HauWNNFKHb8TYV636vsRLrVdXTi52vOG0ezrjFXoglEYecyfAbvpLr9jEcuawinGFyk6ZkVITe7HuqlqO6ntLDhaOPxiUkI3UEjuIFIY62aJJxbCi9aKPQXYFl3ITLELZtyLPS6WkXaLRI7ZKtWJ/58/1GBuGRzhzqcD9jIXhA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742171990; c=relaxed/simple;
	bh=R9gQe3qP710QBxP5kvOsE7wmBexZNkhKVtIyauDUWSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0pSrZyctOf2LfwXek1WPMAU8djDyQXLj1P/1u0f6+WSLNpsVoYiosTGEwNPp4U4o0bDXEq4KFy/8ou1tWTwA+vdflzj+WIpGSNSoUVA34fYgS/TXh5dqrTYGWWRg8519J4bR3X/2UoKUpveLfKbUfYcxyeGap4rIngNMNk7J2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SEPwx1IQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so6690230a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 17:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742171987; x=1742776787; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa0+XG41AnTpCxI6rUtKEupAlgua8QfZ9lbTB2DppLg=;
        b=SEPwx1IQrSNh92hFzyoF5ugg/rFJjO5/LcvTcvLrdNeJ+C8jktKA3qESRRmhIiTaOS
         KkmtSfIM1FXE9tZvnk3dv+JtZ7II5acrZfS86f4rQaIj3YPGyZFIHbvF0IhWzJ3LIzsj
         TbdAHmcEQxT4EWb3jl5xEDEuKQTh3N1J18JVXcYEqniI35X9ftpMKOmWJa3X9gbOefQd
         4BGq6+aYpbxjvKzN5bejZ+b00+cT4AFWImikmpimD341JsXmALAK8Uj7G6a3tcmjRMIL
         sieH3k4rFNIyq4aLaaoTRgVFm8c+hpUSpg+gH+qZLVN39L6D39rvmwf40h1jv4/vWGb6
         btWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742171987; x=1742776787;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa0+XG41AnTpCxI6rUtKEupAlgua8QfZ9lbTB2DppLg=;
        b=G/RKbCONcj5cNx8erIgpsjun1hvoa42HinldLTY4XhGbAXMKwuzEIPVzuLkSowsoPL
         83dIIHz87PsW8NMnady046T8TGRqfklHVXZj1XaxvxufyJFbySM5573b0bvkeZNmQ9fq
         M9fW4Oxil9M3fFYVSruIqGUFEKqaSbgITtkrTVnObIkRMSJXSAfmhqsTcXyuJl6okYXU
         U3+DD72wIYdJ2zYUZyMzXGQehG658cYMzHXKud/nviHRlKOrZgPENPP6fa2+754voie0
         ZE/3r6T81jNbLbveGZbrkRNnz7260VG0NaQBHHFH8KT+36i12zFWSIhelC9e8S5jxCnA
         94CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUe38bpXwmx/QUZ19dbRUtAUOUq2TipAaKYEtrGBrFCmQBKbVKhpilAD7FA/C9+RTxaGRoH5Zc3BDnz7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGlFZu7N89nodHf8VW4nS6U6sSc5gwl5U/a8YJkgZuZ+/DIJZI
	EvSNbVg6wXrBqs+5Rac6b9D4CXN0iydLobKkTRoIWK8P71oP/geYzhdnN9ue2c4=
X-Gm-Gg: ASbGncudlYUW5ud+em+j7CZM+EIEjkW+INRx6KyVCJq7tBba4nAZe61VOGuOomIiViw
	VvEnPOESUvkWgzXRTTp+HbGzPtGjtxbBKLjZ4Cgz7YRhQuhHxw1B6cZMpiIpfkZr2hmN7QzuHkY
	Fxx5Dw2SBs1KEtrHYIndqY8GegzccZ5VFNmXGh1y3t/B7no525Pwm90Sdd7ZAbScEy4G6t5lA51
	3kjMhGlvA2nIYGtVNFNqrD6Oh8AjD4eakt0upayvoMQmcsODruNssfS050qcdB8z4WejZ2c7XLI
	f+/XMBsvcD06q1P48v4ro0sJROawkihNOizy1/Eo3qu+z1u1AfSWNeKdZdGPim0q8E5UVKCdos7
	oeJC/gIR18Xgyb27ZqfpvqLL908mp/ZttDnwAhDC0U069xsXbJxX/lmCd9z64qXzOmUd3
X-Google-Smtp-Source: AGHT+IFGB/6ELCetEqsulbq9XYDj362qmt+yhgOiXelWC2RLXXmy8I2ZSYJBdVHdEvtB3cFlQPysAQ==
X-Received: by 2002:a17:907:6ea9:b0:abf:52e1:2615 with SMTP id a640c23a62f3a-ac3301db85emr1179198966b.7.1742171987230;
        Sun, 16 Mar 2025 17:39:47 -0700 (PDT)
Received: from [192.168.178.107] (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aefadsm562407166b.8.2025.03.16.17.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 17:39:46 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 17 Mar 2025 00:39:37 +0000
Subject: [PATCH 5/8] media: i2c: ov02e10: Rework MCLK clock get logic to
 facilitate OF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-5-bd924634b889@linaro.org>
References: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
In-Reply-To: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jingjing Xiong <jingjing.xiong@intel.com>, Hao Yao <hao.yao@intel.com>, 
 Jim Lai <jim.lai@intel.com>, You-Sheng Yang <vicamo.yang@canonical.com>, 
 Alan Stern <stern@rowland.harvard.edu>, Hans de Goede <hdegoede@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2

Move the MCLK validation logic to check_hwcfg() and move check_hwcfg() to
after devm_kzalloc() so that we can pass a struct ov02e pointer to
check_hwcfg() to begin to enumerate that structure.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov02e10.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/media/i2c/ov02e10.c b/drivers/media/i2c/ov02e10.c
index 0a016cb23cbe98d8af371c6a35db2f1d8c699d68..9ad70671a718ea0aaf80ad3adcc5738ee57a7ff6 100644
--- a/drivers/media/i2c/ov02e10.c
+++ b/drivers/media/i2c/ov02e10.c
@@ -538,11 +538,6 @@ static int ov02e10_get_pm_resources(struct device *dev)
 		return dev_err_probe(dev, PTR_ERR(ov02e10->reset),
 				     "failed to get reset gpio\n");
 
-	ov02e10->img_clk = devm_clk_get_optional(dev, NULL);
-	if (IS_ERR(ov02e10->img_clk))
-		return dev_err_probe(dev, PTR_ERR(ov02e10->img_clk),
-				     "failed to get imaging clock\n");
-
 	for (i = 0; i < ARRAY_SIZE(ov02e10_supply_names); i++)
 		ov02e10->supplies[i].supply = ov02e10_supply_names[i];
 
@@ -774,7 +769,7 @@ static int ov02e10_identify_module(struct ov02e10 *ov02e10)
 	return 0;
 }
 
-static int ov02e10_check_hwcfg(struct device *dev)
+static int ov02e10_check_hwcfg(struct device *dev, struct ov02e10 *ov02e10)
 {
 	struct v4l2_fwnode_endpoint bus_cfg = {
 		.bus_type = V4L2_MBUS_CSI2_DPHY
@@ -795,10 +790,28 @@ static int ov02e10_check_hwcfg(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "parsing endpoint failed\n");
 
-	ret = fwnode_property_read_u32(dev_fwnode(dev), "clock-frequency",
-				       &ext_clk);
-	if (ret) {
-		dev_err(dev, "can't get clock frequency\n");
+	ov02e10->img_clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(ov02e10->img_clk)) {
+		ret = dev_err_probe(dev, PTR_ERR(ov02e10->img_clk),
+				    "failed to get imaging clock\n");
+		goto out_err;
+	}
+
+	if (ov02e10->img_clk) {
+		ext_clk = clk_get_rate(ov02e10->img_clk);
+	} else {
+		ret = fwnode_property_read_u32(dev_fwnode(dev), "clock-frequency",
+					       &ext_clk);
+		if (ret) {
+			dev_err(dev, "can't get clock frequency\n");
+			goto out_err;
+		}
+	}
+
+	if (ext_clk != OV02E10_MCLK) {
+		dev_err(dev, "external clock %d is not supported\n",
+			ext_clk);
+		ret = -EINVAL;
 		goto out_err;
 	}
 
@@ -853,15 +866,15 @@ static int ov02e10_probe(struct i2c_client *client)
 	struct ov02e10 *ov02e;
 	int ret;
 
-	/* Check HW config */
-	ret = ov02e10_check_hwcfg(&client->dev);
-	if (ret)
-		return ret;
-
 	ov02e = devm_kzalloc(&client->dev, sizeof(*ov02e), GFP_KERNEL);
 	if (!ov02e)
 		return -ENOMEM;
 
+	/* Check HW config */
+	ret = ov02e10_check_hwcfg(&client->dev, ov02e);
+	if (ret)
+		return ret;
+
 	/* Initialize subdev */
 	ov02e->regmap = devm_cci_regmap_init_i2c(client, 8);
 	if (IS_ERR(ov02e->regmap))

-- 
2.48.1


