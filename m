Return-Path: <linux-kernel+bounces-347635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B614A98D874
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF411F211B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B921D0F55;
	Wed,  2 Oct 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oERhoMRU"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CE1D0DCB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877530; cv=none; b=RK6Q1Bw9cVnxzatYXFCtiLbbxKj4dNljROIUNEG6V2jx3sRZ1+0gDjKNE1B6zcowzBjdFcdYHwwe4HvAU4wglSp/sEGL6hlcpEhnyF54RVSlfc+GUTuYqNJerMpCOX+ngK+EP41INGlzvQhXIXSCHaYQE/GkmyM1A4u0+6xFZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877530; c=relaxed/simple;
	bh=vTwVvG8iZlHzHza+YS67mEwp2zyunt+kNzBDYWtFYWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLaegB/TmeXz+mCqquRAic1DmJjBsirg0amuzGTsCBWmx78rz5g2lzXtZvR6QGtanJP84/DAGgY/UvaNeEudsY4fRgpYs5rkApe4TT+Htiya1+kIvSOGLTvVhL0tUoX4QmMBSNkohX1D33+7BEOdXcg8Rcpzas0EsxoYrxO5Hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oERhoMRU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so6815536e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727877527; x=1728482327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7nKjwcfTxwC0PwN6GrPgJAgBaaTNk6QSx4URpDS/gc=;
        b=oERhoMRUNxjEaPh+A1eUzygiomkUAcQkBs/hl4Q8jCBsDhWVkvq86L3FZ1sCyRYEeE
         8WjMT3P0ZNuCbV9c8m3uwqavc9Yqvcao/A1BlKssJ7ew41ZUaqyi9RD0DEXs8ZYLV42X
         kvdHIZgFc9zuNQb3TTu86GdPm2fwXaFPssnUwerjpSL9PnqNHjOg+ETDGWi6zs9RhcZJ
         Nv3wH7OHOFsXoo8DGhBT96vqXe2TCHgCBJ66El4+H3QynUd4WxwLORmoAUFxMdHtCnq/
         3UzEdoLLZrRKQ7MBZVqHTPtgm+WztVG40fks5Dm1b3sobOtkmiAnnqa+keiSQbYkPFL6
         65gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877527; x=1728482327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7nKjwcfTxwC0PwN6GrPgJAgBaaTNk6QSx4URpDS/gc=;
        b=LL4uACt8Q+fVWXy+Edlk9oiN+HU1QUXqgE00aVLv8sojfsXhQSzLqIZX8k7/GqG/Ey
         hRIaHSJTqwlNvmULVzww3SIMOl9gn1TO8PV5FlQ9KkDoBw2BT1UcYCZZdNBH85hzq4fW
         jrx0JiOE/8Vz6GNiYDhvd3FTQPQTd/9TWFXp3OxYyYN73X/14eUALxwwlLkeeOXsCtTV
         MyKy21TShl0HZs3uhoR97mym4TJtNJZYsuTewaHuxzYAofDiblXUQVj2eGUpZAXgRXMn
         N5zlUYF0QiJrulYTEfAm8WRrtUdidZTtN/NuyIkcNQOy+oi8uVXNwltolUGKaUdUmc8b
         lEeg==
X-Forwarded-Encrypted: i=1; AJvYcCVmiSOCZYEJfY/s14793r+p6fo1smxVWsCX8XIbHPOZ1Bi37yitW1JMelFCEOiC5IPo1qJVkNBnCnsmAIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztXC7abGreMbEbWuHSFXuQ8Gk9wKFjpuzDiIXDTXuaXx27qp33
	nOIvikQJ8j7bZSI97dsVcP6m/Emk/VPmqHAn922Kb0AXr0eDGlbWt2pvTADPWL8=
X-Google-Smtp-Source: AGHT+IHw9KJJ4jKUtIw0HbXWpy5zod4qe3AGMUGvrOu/5zZkhX4Sj/h2kA+sotMO5YI0x7xXSCBSOA==
X-Received: by 2002:a05:6512:10d6:b0:535:6aa9:9868 with SMTP id 2adb3069b0e04-539a06637cdmr1877282e87.19.1727877526868;
        Wed, 02 Oct 2024 06:58:46 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405b19sm7577346a12.11.2024.10.02.06.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:58:46 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 02 Oct 2024 14:58:43 +0100
Subject: [PATCH v3 1/4] media: ov08x40: Fix burst write sequence
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-master-24-11-25-ov08x40-v3-1-483bcdcf8886@linaro.org>
References: <20241002-b4-master-24-11-25-ov08x40-v3-0-483bcdcf8886@linaro.org>
In-Reply-To: <20241002-b4-master-24-11-25-ov08x40-v3-0-483bcdcf8886@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jason Chen <jason.z.chen@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8

It is necessary to account for I2C quirks in the burst mode path of this
driver. Not all I2C controllers can accept arbitrarily long writes and this
is represented in the quirks field of the adapter structure.

Prior to this patch the following error message is seen on a Qualcomm
X1E80100 CRD.

[   38.773524] i2c i2c-2: adapter quirk: msg too long (addr 0x0036, size 290, write)
[   38.781454] ov08x40 2-0036: Failed regs transferred: -95
[   38.787076] ov08x40 2-0036: ov08x40_start_streaming failed to set regs

Fix the error by breaking up the write sequence into the advertised maximum
write size of the quirks field if the quirks field is populated.

Fixes: 8f667d202384 ("media: ov08x40: Reduce start streaming time")
Cc: stable@vger.kernel.org # v6.9+
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # x1e80100-crd
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov08x40.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index 48df077522ad0bb2b5f64a6def8844c02af6a193..be25e45175b1322145dca428e845242d8fea2698 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -1339,15 +1339,13 @@ static int ov08x40_read_reg(struct ov08x40 *ov08x,
 	return 0;
 }
 
-static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
-				   u16 last_reg,  u8 val)
+static int __ov08x40_burst_fill_regs(struct i2c_client *client, u16 first_reg,
+				     u16 last_reg, size_t num_regs, u8 val)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
 	struct i2c_msg msgs;
-	size_t i, num_regs;
+	size_t i;
 	int ret;
 
-	num_regs = last_reg - first_reg + 1;
 	msgs.addr = client->addr;
 	msgs.flags = 0;
 	msgs.len = 2 + num_regs;
@@ -1373,6 +1371,31 @@ static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
 	return 0;
 }
 
+static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
+				   u16 last_reg,  u8 val)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
+	size_t num_regs, num_write_regs;
+	int ret;
+
+	num_regs = last_reg - first_reg + 1;
+	num_write_regs = num_regs;
+
+	if (client->adapter->quirks && client->adapter->quirks->max_write_len)
+		num_write_regs = client->adapter->quirks->max_write_len - 2;
+
+	while (first_reg < last_reg) {
+		ret = __ov08x40_burst_fill_regs(client, first_reg, last_reg,
+						num_write_regs, val);
+		if (ret)
+			return ret;
+
+		first_reg += num_write_regs;
+	}
+
+	return 0;
+}
+
 /* Write registers up to 4 at a time */
 static int ov08x40_write_reg(struct ov08x40 *ov08x,
 			     u16 reg, u32 len, u32 __val)

-- 
2.46.2


