Return-Path: <linux-kernel+bounces-403984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A269C3D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDAE1F2439E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B789D15B551;
	Mon, 11 Nov 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Es3UPYOS"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078C155CBD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324977; cv=none; b=Uj4gOp1YVUP5zU5+B69awUpj4VIahS3NHKYXxZNIIbt+7mQ1ggpoSNJgEY+xXf8zkXHWcPTxDOvItaDkjIahodtl+KBGUiZ0h8bbS9KYL1C5KCwTW36JIkDpn/LZjRf2PKs1lYbhZDzNfUReu8oqQ42WDIK821y4syqstZFR0ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324977; c=relaxed/simple;
	bh=WaefXHlt4BBEBmkcWMW9vgf9mUVaS1KSQwwwmgHZFzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AGuAO01/lBGnFRAAMmguO5LwUsdMH4F0WPdDStGbyK12GrxNox3h3ddAYEiFrhA4i/wPq6Y7Zjc2DoDKHtFPYQfwX+ctQLl4PZWxc/cKuOmRv75gK6fhf5jCyeG5t4320bzbSXib0H0Cx0ASUA2Z+rQ4IvHsL2f/mnZJ4Ge3WWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Es3UPYOS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so4227507f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731324974; x=1731929774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wY9o5kHC59ldDXNBq3Gky4O4TZiiwUsXswCh79e4DM=;
        b=Es3UPYOS5te8qpkTC06dHQQd/nT+3Bqg1F+35sDvPSnh+5CaPsfCi/ygZexE5MDcHf
         GZibjmAzBUwsCrSqRgqY3PelXihv9TDs17cP6SpEQOBadbNohXdPpV/jLW+5VnTkWbWl
         FXMnREFfVB+NEdHPMBSkhKsYqCs3puQkWG5/8vVO2q0TM7iu3r78YjeEDWzZ6uygEr+Z
         6pNllPRYvv4Kbutnhb/orUeLc6mPSE4t9iOZqMIfeqxr0hXNc+4RoSBPcw+a8sCOjQQY
         F6ZWLVbZJ7+xj2WBoTHTbUXf4N75e4ZORYwX1aw33PuQ+82p2BhHViYQogvGl0xe4blo
         JvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731324974; x=1731929774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wY9o5kHC59ldDXNBq3Gky4O4TZiiwUsXswCh79e4DM=;
        b=Nwsmc7kFGV8MbhLPhNskh2AuXB6mfOb1u2WyjBffFPswDgIbvpW90jOwF0qm233cl0
         ZJXvF+Nelzl849K2XzUwJca9XW0LUbEcs/Rx3LrjKUtQj++eb+LYps9SD7av8J1l9ZUj
         W9yDvS5iDrBoAxxU14ut27CYOpOi0wgwy2iDvk/45g7IiC/EaWXVsrAqMdQr/qD8aNjU
         hAtDK5mvmS3vedkl2iYB3VzV2UrE/JQ3ycg4NF7o4+QHSJiqDhnRAReV61hXniby8x9O
         MOCCy2MU1qg7AbjKxKVisJ0V6cHHwmLyLM9D0rlYi1rnlgRKqD3Ukg0IgLNtDtSiGbbC
         Hzkw==
X-Forwarded-Encrypted: i=1; AJvYcCXKJD82A0rQTu4dpGx3cVA2h+ry386j6HmfDVsoriZr0hnr9rzo4XYwnMjh6RBhs4PGKrgnemXz/fMUdGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+IjtFIbKHveu2SnxDnbmkk3BVwu/4pcAgwbolEgK6mhIPaV4P
	blk1/n+Z6KoT6Vgl/0zXm2LFHRJmW94U0gsZ2Wc3Jnlsqc2MsOVZKd/ML8DKFrI=
X-Google-Smtp-Source: AGHT+IE6tAy74N9OIqvP/VA3FCkS1J3pomW4FVro8EP9Ga3hGZTeODklr9RFOwmWgEQtDqjmYHSElw==
X-Received: by 2002:a05:6000:1fa1:b0:37d:3e6d:6a00 with SMTP id ffacd0b85a97d-381f1884805mr12220915f8f.47.1731324973682;
        Mon, 11 Nov 2024 03:36:13 -0800 (PST)
Received: from 1.. ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5d1bsm176266785e9.40.2024.11.11.03.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:36:13 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: alvinzhou.tw@gmail.com
Cc: mwalle@kernel.org,
	pratyush@kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: spi-nor: macronix: use nor->addr_nbytes
Date: Mon, 11 Nov 2024 13:36:09 +0200
Message-Id: <20241111113609.12093-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=tudor.ambarus@linaro.org; h=from:subject; bh=WaefXHlt4BBEBmkcWMW9vgf9mUVaS1KSQwwwmgHZFzI=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnMewpec4heVFALHnX0lAGLh/i7niDqwQauXdeh CJ12ZKIEamJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZzHsKQAKCRBLVU9HpY0U 6XlqCADDgS4/IL3FP1bzV3Ut85jXx8BzXL9Nj8YBiY5W2a2WK8tomymJKTO6alevUzYUeaCMwre GnOgMjtYS1abMKIZpmohDeNy1GRikfpYWB4LVOzd9DMhYjj2w6afL4q7fFJeLV3J0Y6lZ+GAyKR X3c4XNxwYidZZ6+Q+stI6vN+WDiZzNsJktU3xI4r8VE4yPLmfEGiTqiBcwib6qc45ErwkY+ljwF /JjrH1pyWf6x8hGlTSZrHVB/R0R7joxkm1f0sJjmyD0ws1Tc4r1z3ktelH3e0nMlmxjVxHtd9d2 vFp3yufLxF8F35H7C3gxgst6aE107VVuKWu3Lw/eJ+nCJOUi
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

Use the nor->addr_nbytes set by the core, we shouldn't use
magic numbers or states that are not tracked by the core.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Alvin claimed he tested this patch at:
https://lore.kernel.org/linux-mtd/CAPhrvRQrugRQgQcdHBdwid3_sUkCm0mZL9zhz1=TYzXg4qUTfw@mail.gmail.com/
Though a Tested-by tag would be nice. Thanks!

 drivers/mtd/spi-nor/macronix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 830da21eea08..57a40fa70c6a 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -230,7 +230,8 @@ static int macronix_nor_octal_dtr_en(struct spi_nor *nor)
 		return ret;
 
 	/* Read flash ID to make sure the switch was successful. */
-	ret = spi_nor_read_id(nor, 4, 4, buf, SNOR_PROTO_8_8_8_DTR);
+	ret = spi_nor_read_id(nor, nor->addr_nbytes, 4, buf,
+			      SNOR_PROTO_8_8_8_DTR);
 	if (ret) {
 		dev_dbg(nor->dev, "error %d reading JEDEC ID after enabling 8D-8D-8D mode\n", ret);
 		return ret;
-- 
2.34.1


