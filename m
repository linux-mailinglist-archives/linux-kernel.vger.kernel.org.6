Return-Path: <linux-kernel+bounces-199077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68C38D81DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F902287D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A800E1272B5;
	Mon,  3 Jun 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wLoukTGL"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732241272A2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416418; cv=none; b=tdeYnlcv6/amso3VD/1VgZG17OlVg4d+xI0od1ip+7AFFzG9jZuQs8khpTiRCPipP7oPs1N2madfzozmz2N/KO/LlxhEAS2gr4aGDC7vLKTETgcWYCg3XLsBLgG01D1mU5HzQ2rJBHzLY7I7M5WNILei01nsbr/+ib8+CUe9zTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416418; c=relaxed/simple;
	bh=K0CDQC1akX83WqstZzLmNolRnOazVmg2PvHJe4bg5Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c3UbcahCN96tzpkntQGKaMSldaJ7mz+tRlfdEmvp5DvzbKuXD1gycE/W3e9zpAa7zZEMCfB96OjSB+YjBh6+6oGbdlg1wptTMjoVgJB/rsyVrXx/qWvmLje2WwQqHOHF3ZVHqaIoJKiCG5aBCr7OHGRppp8N91QVssZ6N7IXDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wLoukTGL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42121d27861so38326745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717416415; x=1718021215; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vzs/x1WCN5t2imfhC6zu+ZDUGVxVyZ0jYD0hK5bZuVY=;
        b=wLoukTGLJpEsD6AT16CgBdR3IGYZrQahG+3Eq2KvKJ8ID1yrZPZAVH2O6i4leZl/ED
         hAc0IycPPTiDu4VX/Zu+WGhl7f4DSB9vFd4HpmxcaweUzPzyWT0j+iQC2GuANebydUAF
         EicstHtLv2YmhoWo3gC/vc9qO2ybHU2tjZJ9jIgNWp0Fcjkm3oH7qHqet45zB+Kl/RZE
         iYV+od+GZVTcuS8jlorcnXNAnThB7oqFm7BiytBr9pQPDN49fQxULf3hPIUkHM45PoPB
         MAKQKAv4cvK3ocCwoSPDL+IC0iqCVNpxuTcsCrhc6anZV/IdJld1kIjbjfCe9rrr+3y+
         P3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717416415; x=1718021215;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzs/x1WCN5t2imfhC6zu+ZDUGVxVyZ0jYD0hK5bZuVY=;
        b=Vob/+YGc6uw9jTmUsl2wxVtxj5A14VKaKP3WBLav2iVaDnbDRieqGGKJQSEFTJ25el
         F/n+Odlgshbqq3AaEL0dHWdq8NVd8posKdHK2eNixQnFxOOTNofaKzd57TH8f0KE7kC2
         dnOg+cHaNyfUrEhQV1cBuHS5i1QM09qv/mZaVwIUCBDHOVNzssZ9xCWywOGG2NnYrvpS
         v5dTYaA/Rk25m8fh57wcSsSdEkQZargFnIC2UTUxNhprG0xLw8lMprH79lq4ch9MLwZ0
         rBZcEQWJcN+OEEIIcVK7H4x3ODTJrmlr40DxiJ1pV254UVlp7hMRjnjwfherZRDhp9rH
         F+yg==
X-Forwarded-Encrypted: i=1; AJvYcCVbPDDamI/103ZdUbp3I2Nzvu8UL3ZXtVlkyR9+gz6MfQ1+Bp6p9gUcqc+CXSvpQIdcYaUuRUkTt2cCKt+Mq0oqZBmYy2ExtMHL9Mux
X-Gm-Message-State: AOJu0Yxl1UKMrAsDtR6VcAv9ASyHX1n8kq96/sloZKhyzSCCWgyI3t2x
	oDMLvDnX5CSXVgaWR+ghMhCA54FcfuO070Ratqv1JApnEh9rWAMKtu/CUsfmQaI=
X-Google-Smtp-Source: AGHT+IHUt9RC5PnZgMhb+jbLRK9Usa/RFjFRgNU7nFyyp0EjKf8YEFj7904Gl2PsM4H49yscOAhb2A==
X-Received: by 2002:a05:600c:1e27:b0:41b:de8d:dcd7 with SMTP id 5b1f17b1804b1-4212e05f21dmr64794825e9.20.1717416414555;
        Mon, 03 Jun 2024 05:06:54 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8a758csm114805625e9.36.2024.06.03.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 05:06:54 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Mon, 03 Jun 2024 14:06:49 +0200
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANixXWYC/x3MPQqAMAxA4atIZgM1ioNXEYcYow3+0ooI4t0tj
 t/w3gNRg2mEJnsg6GXR9i2hyDMQz9ukaEMykKPK1a7E9Zzx9BpWXlB4sR7Fq8zYM6lQxYWUBKk
 +go52/+e2e98PFKMvwGkAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717416412; l=1350;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=K0CDQC1akX83WqstZzLmNolRnOazVmg2PvHJe4bg5Q0=;
 b=sKRmkGPrCbvTekNrVxBLMIUjflnb9FNPMqlYmPYKF9gHcSfU2hOCEY6bHSIh7DWFYzVrvifv+
 y++zucbPtypDRYxmAMdAcYHk+bJiO+sNe3XEydI64hVHnRlwdB73rxL
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch prevents from registering thermal entries and letting the
driver misbehave if efuse data is invalid. A device is not properly
calibrated if the golden temperature is zero.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Guard against invalid calibration data, following this discussion:
https://lore.kernel.org/all/ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com/
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0bb3a495b56e..185d5a32711f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -769,7 +769,11 @@ static int lvts_golden_temp_init(struct device *dev, u8 *calib,
 	 */
 	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
 
-	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
+	/* A zero value for gt means that device has invalid efuse data */
+	if (!gt)
+		return -ENODATA;
+
+	if (gt < LVTS_GOLDEN_TEMP_MAX)
 		golden_temp = gt;
 
 	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;

---
base-commit: 632483ea8004edfadd035de36e1ab2c7c4f53158
change-id: 20240603-mtk-thermal-calib-check-ba2ec24a1c32

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


