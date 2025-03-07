Return-Path: <linux-kernel+bounces-551724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE168A56FD9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BFE189AC6A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E887B241663;
	Fri,  7 Mar 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxP8NuN6"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777F241673
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370286; cv=none; b=Yv0wXhoPqOXYLzQ6IX97PePCws45EobR7HllHMy8dbuPqKAbOjmzRJTSKp6AdWMhmTPh1xWgSg6CgL8/C8BBr0L1vdV9DidtQatf7zWIEescBsE4CcQr1/lH+9e2ml5LHt+zc2Zz/D1/xUZlmyviqkiMYycRnr0t62F1HTo5SpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370286; c=relaxed/simple;
	bh=3H31W12zPv2ha7Gz50I9LBwKnbP6kIyb2rBbsonHNsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qY4R2lSpewZNXS1JjpeX/j9OZ2vPi4Dv6ppWni1GtWRW449rTxZ/J1mnSYZw1FtH70KIJFXQC5K5pHJWxpnf02vIChIg6jt9zGiefSNKNwvw3c/gV8Rwzkpo5yALXCqoyry1YZMYm0cNoimb22LEAQQ8KmjpW2WxdKSqpoQiCKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HxP8NuN6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso3935335a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370282; x=1741975082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6jcAZ2+oS8/yz0rFFcTHKsuoW+XOedg0QBvOhLol5s=;
        b=HxP8NuN6dO+HkLHphe5KJtj7R4sUnAsi4vL0hWC7S1QVbi4CuEazczpf6uOlQyFYLg
         bEirlHn7g6udmrmmqePBJj6BO7zADGiD8yQWj6+zDLNUjRUeD5HG70F5S75NxUlya0/v
         GLvLKDUDuoWypMoxub/bsIYOYaXmvDFrNNWT6Q9pZyghjNRjRTXFYiez7zXdvmfixyVN
         oMAmOB+Npltgng5uGY7VNrY1Ii79m7eNOi+pQfWIVSxmKh0KKoP7PzxdA1RldUPdwJ6r
         ptK5Ah8nUZCIqfVaChFyEq9eaSBcRYXKnd/dAfY80taP4x0MTCOBZO/ipM/ucmiuAx79
         gDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370282; x=1741975082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6jcAZ2+oS8/yz0rFFcTHKsuoW+XOedg0QBvOhLol5s=;
        b=HuFX+f6c+u0HbL+RWf/CoA/PIvGby9Q2g4xdx56/OoHtn9L9xHKLq9wIYKJ7vLiuBn
         PNvznaQrk4/bSiw79KK7V2I+VQQkKgMoczwRuvEcSDdr8BqAFwCxZmwBU+dS7c3d0GHY
         KaQRpn08mQv+s/4sU6ILeJmeKce5AsBosO7A3BcDKe8shIbJlWmUx0XIhxkysKYsq7/W
         1oBWteeb3o+SrDZaA6YWkNRzDAAM3x5WJA7SKhoMeOcEk+AlnjTyT7jz8vhP3lvK+5Mi
         7WQrBckEyzAvW5wsW13ATzAECKSbbiOLJ8RUWYFwdQYHz64oLyNdJuxmyR0SD3eqGJpC
         rjCw==
X-Gm-Message-State: AOJu0YzgzBLJJiRhdd3xw4uRHwL/rCyLoATkj7cD8B9DStHnM4DYVsLT
	lHiyg9zQTyW1lnrEfP1LCeYgir+QXSG+slFgVC+k5IMmO42QZ9ZOzvnIjN7sXw8=
X-Gm-Gg: ASbGncvGoxn7zUO2sfVMKQXC5VReUbeBLrFJieOcZcQJuys8nQLPdLAvfxhtz9I0Nca
	byYEr8hWwcy6e8Se9rxhpmY0zTGyspsMlyHzbqQJY24SOq0AoYGHvpjOZ/kHSSrYcXBSA2KMres
	OPqp8TvvHctF7kuMCZp0MgjZw5LThH8GGnulcvVu8xzPZvSef/6BHil64hEZlumtqpig8WfSMqs
	NW7QuPgagWpZCpMAnFljtpjSeeTLjWLUdBiZT/5E1vNR6aPc90IykbLbdpfMRP8so+ucww/8oHp
	xj8UTmzuwyNTzGp02TGdy64Lq9gz389KHq+GnrJJeDVSRpUe9fZPDFmu3iytIUlTnOqVmQ==
X-Google-Smtp-Source: AGHT+IEgp0jeE1277khL34/t48BwmetDTJIyn2aAx3CmRKTFsxGYmOBRc61jwvuN3lf4Ae4TeTT9SQ==
X-Received: by 2002:a05:6402:348f:b0:5e6:1352:c53d with SMTP id 4fb4d7f45d1cf-5e61352c6c6mr1125933a12.28.1741370282543;
        Fri, 07 Mar 2025 09:58:02 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:58:01 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/14] nvmem: qfprom: switch to 4-byte aligned reads
Date: Fri,  7 Mar 2025 17:57:21 +0000
Message-Id: <20250307175724.15068-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=JJiFhfRmHwPniUxF2lMkh5d/tp9H/TdB0Jvtor5rjlc=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN9UasBH7hrcLPZhwfh2HNMT1jUIAJKxwHVL 90k/z9bwgSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfQAKCRB6of1ZxzRV N1JPB/0X1dsL/WWy642Ohdh0aR/Ehq7DZGv3b+YLrpaBYUr0+xlzhEsLWthp6BpDYehwzgKROKm UcfNrw50vMbGdSgXyozmiQbLooSV1hjlcdUH/I3XiXMmtHua+ZXyM9e3Q19Q1HCOzaQ/IhAx03u +S7gHmonwvMPVCWIgtLK2Ob+FJmISDNhcmfqB8qZULqx97frqLifxbYFr3XuFQF/akpvSOyGJ10 dA6U6B7X25CKXhcEvNUwl03eYwkQHxSJO7kQdkYWjzDP/CUJdCzFGb+4XdrhBeM8KAmESHZIj68 ruTBz77pbc9JQmag1YDL5JWDUfz9j7xtjw/rp7uB+akHyNQV
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

All platforms since Snapdragon 8 Gen1 (SM8450) require using 4-byte
reads to access QFPROM data. While older platforms were more than happy
with 1-byte reads, change the qfprom driver to use 4-byte reads for all
the platforms. Specify stride and word size of 4 bytes. To retain
compatibility with the existing DT and to simplify porting data from
vendor kernels, use fixup_dt_cell_info in order to bump alignment
requirements.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 116a39e804c7..a872c640b8c5 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -321,19 +321,32 @@ static int qfprom_reg_read(void *context,
 			unsigned int reg, void *_val, size_t bytes)
 {
 	struct qfprom_priv *priv = context;
-	u8 *val = _val;
-	int i = 0, words = bytes;
+	u32 *val = _val;
 	void __iomem *base = priv->qfpcorrected;
+	int words = DIV_ROUND_UP(bytes, sizeof(u32));
+	int i;
 
 	if (read_raw_data && priv->qfpraw)
 		base = priv->qfpraw;
 
-	while (words--)
-		*val++ = readb(base + reg + i++);
+	for (i = 0; i < words; i++)
+		*val++ = readl(base + reg + i * sizeof(u32));
 
 	return 0;
 }
 
+/* Align reads to word boundary */
+static void qfprom_fixup_dt_cell_info(struct nvmem_device *nvmem,
+				      struct nvmem_cell_info *cell)
+{
+	unsigned int byte_offset = cell->offset % sizeof(u32);
+
+	cell->bit_offset += byte_offset * BITS_PER_BYTE;
+	cell->offset -= byte_offset;
+	if (byte_offset && !cell->nbits)
+		cell->nbits = cell->bytes * BITS_PER_BYTE;
+}
+
 static void qfprom_runtime_disable(void *data)
 {
 	pm_runtime_disable(data);
@@ -358,10 +371,11 @@ static int qfprom_probe(struct platform_device *pdev)
 	struct nvmem_config econfig = {
 		.name = "qfprom",
 		.add_legacy_fixed_of_cells = true,
-		.stride = 1,
-		.word_size = 1,
+		.stride = 4,
+		.word_size = 4,
 		.id = NVMEM_DEVID_AUTO,
 		.reg_read = qfprom_reg_read,
+		.fixup_dt_cell_info = qfprom_fixup_dt_cell_info,
 	};
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-- 
2.25.1


