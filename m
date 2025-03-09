Return-Path: <linux-kernel+bounces-553178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F52A5852B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551A63ADC39
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D85A1F4608;
	Sun,  9 Mar 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFiKZ0Ds"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D01DE88A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532268; cv=none; b=ZLt9ubOSvRAgqMlV5NjQnRY8/PPX6JecX3O0ix5UKLL9l4lhv3Y1bqLBaXGqwzX7dLEcUcYYK6LXXFIYeykSytIPXvUR/X2apCPkNT6R/KQeihC3yesRzG7n0hskqc7jWUG8oze00XGVwHNry9WC2h0jWuN0aOWH4EIfD222a60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532268; c=relaxed/simple;
	bh=3H31W12zPv2ha7Gz50I9LBwKnbP6kIyb2rBbsonHNsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ro3nAStp6eYXLdZDkJ5R3IRKYJhXloF4Dpqk4VAhEDB13zcsvN5Cv1D99CGjJcvgn34on5bv8Ay0c+yqqjMJlCY9mVSmDvSGl+mytPZWINYJrqAz9cVgbCtxl9IqN6geRitaIX9TRRMkrdXjILEt/89+RlRAIso5Z4eR1CD9gqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HFiKZ0Ds; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913b539aabso569870f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532265; x=1742137065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6jcAZ2+oS8/yz0rFFcTHKsuoW+XOedg0QBvOhLol5s=;
        b=HFiKZ0DsSt1QoIoYwpHEgi/2T/6huAapjN1bk7qZ6bfsbtiCA+czPwzG4IiwHRgdRo
         sOWu0l+H0erYVeLVixzx80ktMJT1JkbAKj7hGGiHJjGfmVTz56StQcvqVC87I3KV6LlE
         7+N8E3Y6CmmsIpEvbm/y/beFNuw6EG3d4NrHwi9UpwNertmrxMDDvLqYAwx7k6XrAvNX
         4XOgNHp3wn0AiWryESeBOYJ7u1TIR0ccmuSM17lONMQsdAT4ILKHq2AgfKmeydsaizYD
         wJ655xpadsoJZ1JlF8Ad3guHSu+Lhx0X5u4mKQkRZEO9f9U5ARu+JrGTyRDCvQRqkhLc
         pZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532265; x=1742137065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6jcAZ2+oS8/yz0rFFcTHKsuoW+XOedg0QBvOhLol5s=;
        b=Z+PfnTdXxd1BKHtgoCdNelQfmADrumNCzHb+sdYQmIp64BH8OLQ/tRR2sb0mk48GHn
         KeQ2v6sZrETxb6scpX+3ZUmyfv14aPhcBmqSjCiER67yPErnwtHPWtte1esbhrzSv5V2
         N/JCakuxJaatMsEcNkqwGr21LuY4fUQeJB3N6rcCJ54cknus4x8HTuKAjqSIIJ8eo0i6
         p/7yYt3iay3vHOrZMUCd9BaveYr7Nsw3LbPr73M5qMc3z8zCXN4x/6TrgKqoNmzLnEr2
         g2ApEWDSgYdglwZVqCHGW2sEHp4Q57joo1K9KJTizFIVJ7nV1ZmMFftNZOkV/OwjO3nF
         3vXQ==
X-Gm-Message-State: AOJu0Yzqu8gGT7Yv9Z8A0/mUjfHy4o/w/lOMqc0YBamfbU7jTp1tALyY
	J/0l9TDEysW9bi0ADlKWmxgMQn//FXLKThiIimfQkC+QYpXl9Qbv8/20XdgkHp4=
X-Gm-Gg: ASbGncsine0/1B3+dxCx3sMBlSe0A7mqEcs4BwRTQzcBir3cbAwUaHUqrB11ys9pXUm
	os3VuUPzu1D2JiyCn/RA2DUZlkMCWlw9E4lxpV5yqoorss3Pzb6V8nvlj33sLAPGDenpIzVKFGk
	bVPF1Vr3rUGZa2lioc0ibUNaccz5tTOL0WI2dXbXVXOT0CXuSUiRdKA8l+1m2kE0TJjJfj7D9KF
	zET96Y7ce4EI/XcbqRKNaBGyZZIFeU12LFNgjVUx/nzsWYeNdjrTzGpQwJZduRmOhEqTu88JjdE
	eb+0lVdVNeAVZLvoEsNxliD/Aw3cipb9l+1SLqmMvbKt2YSsr6wI+gZz6pNmS3w6xjpoxg==
X-Google-Smtp-Source: AGHT+IEurTu7bFIGLqaDtBw2f+0f2AjhipjTyq0mOWy9jVrFxDMLoOTzizN7txaTBnZWsotWFGEvPA==
X-Received: by 2002:a05:6000:1564:b0:390:f45e:c84a with SMTP id ffacd0b85a97d-39132db77acmr6709748f8f.48.1741532265091;
        Sun, 09 Mar 2025 07:57:45 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:43 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 11/13] nvmem: qfprom: switch to 4-byte aligned reads
Date: Sun,  9 Mar 2025 14:57:01 +0000
Message-Id: <20250309145703.12974-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=JJiFhfRmHwPniUxF2lMkh5d/tp9H/TdB0Jvtor5rjlc=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw6UasBH7hrcLPZhwfh2HNMT1jUIAJKxwHVL 90k/z9bwgSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOgAKCRB6of1ZxzRV N86cB/wL50hBgnJ+PXKay/wbaBAmnfS1vTizdhjCnL8z+ujfeBUeLFJrU/+zaVjBvdvj5e3k+uC rG+kXc3X/XKq51aSYCSMIoNr6uwj80IQilmvrZ5snMGVHs4IGWF9PW6DWnG+01JPltH5Z5uuEDu /V6zcN8TUSJEVgEV+4d/mvp4gG5g4pjm2LJ8A0AU0axa6qPdbrICDztKrWYtLkVNwXx5YBq+2/r BYXUU52qcYmyxHdgVCnGG+aoWkWd+cS4oXYxS6LGKa1ttu1Kl3S6kExXW8cWlO5H9VBaXZ70hQo ++xJ59OQb1MJF6Cy6Hlj8NxHFsXg8OczcFumi+7e84VtDPH4
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


