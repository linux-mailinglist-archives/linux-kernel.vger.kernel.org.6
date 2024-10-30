Return-Path: <linux-kernel+bounces-388847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7689B652A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D504328395B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E05C1F4FC7;
	Wed, 30 Oct 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvj10dmj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A71F12E3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297030; cv=none; b=mrW8C3FaIiukdJrdxeRms/HPC7eEFVT+uuemZTEIueobvv1J7DVdxZR1taIV3j0iFHG1AaEJIKmC2d6DjaOjKzIBuCyJIp/TnfZcXs8fv5rj0/UnDo0uLzBIKUmgDIkH9JvN29M6ZIL5V5P6s9pm7Vgrmsc+jRZt7NRGz9hr91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297030; c=relaxed/simple;
	bh=C3bJtR9diuH18eqjUdi29zhAIcp6Q7ygjs2tfTSsxQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPEKs5A0uMUWjqD3k41QigMl8Zrdp8jcmEp/uwMP98HiQCXBxiclwBkHx7G9/1N/TEwUk6HA5U57DV7tr3MKlQP7dKAc31N6aLvX0WVbIlQ0Z+a2s1A8F0Qeck1f/D7dDQxUXgvmH5idfTz5WvQqf/JkQu37il+PkVaq7GNoAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kvj10dmj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43152b79d25so59810675e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730297024; x=1730901824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwkL4mAYguam83Ok+cEyq0v5u5ofOSAY9dEpeOn5NeU=;
        b=kvj10dmjqFujLi1siCGWu32/pUYQVFM1xgHndInJafd3O+2kBJqiqF6TEausmr0P6q
         rd9tMw2t4vfekC5ZyYwpV01VzVKKqo8lQdccdcrzB4YAu2yPS8xGJK7NnSQCnEwcSouU
         8eYDd3RtcbVLL94XIEAEt7STwBSBCGqPI53McHGmPImqKZqt6WZUO8ay3pXfu/KuFLeh
         kWp1YOZvuQg17Sro2LYiZe5/lbZ/7zwka5yDY+L66gIQ6L7CIp9tVp/nH3x610Nxt5SS
         Dq7BgfWAs+RaF4edau3fqA15oKduLZRIK1jL3FvWvjmKlE9wecj4t7htPVM2/SI1M42S
         +nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297024; x=1730901824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwkL4mAYguam83Ok+cEyq0v5u5ofOSAY9dEpeOn5NeU=;
        b=mia4LZ5vJGbYgM2+jgZM2gSq4/REUuvcVRWWaXpyPBW3CD6po5rmAODYRX7QFBeqJV
         8fgMH9VYtv7alCDphWzS9CwPg0NFVsJT3lzKjHKf6WztnS4C721AbMt2yr/u0ahemi78
         6MrESrTl+w5g8RxEPinBFNgHQLHdSA24rH/uU0IizJU7S1tOy1NWl2YhNLrrZlfg7wDw
         ZqK4CxbTyPNfAWgcdUcRDzVE1tSf4RnnLpJmrtY4JRq/7w4gnRUcVvysJStufvMt49+r
         3R/36rm+raSEw1LIYNiT3ss6iNfsbF7qDcainUGfCxvVklicIIBbUCjO63xsxgTZENKA
         4OFQ==
X-Gm-Message-State: AOJu0YwJJ8erN+FmCVboPDME7uoQH5regFS7dMhVlH/LwplFZV3L5FAU
	Kw9X0Bo0D8+IJXVQXa0YAiQruIAzNYHT3pV965gI/sBMkt+mWjz9lu2dcS1vTco=
X-Google-Smtp-Source: AGHT+IFGXLal5RubxgMhHGt84dgKDEvdKETdj+wQV7sZc04VZh0qKDyp8KyRxrlNBXllpbMt9cf8fg==
X-Received: by 2002:a05:600c:5246:b0:431:5c17:d575 with SMTP id 5b1f17b1804b1-4319aca3f6cmr120565185e9.11.1730297022033;
        Wed, 30 Oct 2024 07:03:42 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm22498405e9.30.2024.10.30.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:41 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Shen Lichuan <shenlichuan@vivo.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/7] nvmem: Correct some typos in comments
Date: Wed, 30 Oct 2024 14:03:11 +0000
Message-Id: <20241030140315.40562-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
References: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=V2VAzTEQvF1b5tjKZgsl4sYJ7yMYEqPhrpKXVYkqDuE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyiIU1R7xWSSoEm3o2LJ2BQmXZ1OM05nmyMw 18r8MFXPFaJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8ogAKCRB6of1ZxzRV N+QRCAC1R5fLS4vyRtBUT3Wn1oUoznnsAQVd6C6xGGw2+MCZwlN+RRHomgBAw8Sbp/MB4CUmR+u AoZrmnvSdIVo/vXWGO+O/z3BkxD071Lk5hZIsshesEHlmCBJl/S4najJXnFp+dbP6FVMc7ZFzIC kFQjjd6J2R5QKDQ2chzNdoss9yjzc3ifPJ5t460k+v+GpwhxpzLGzs3eZY0LNaSlyXhAuIjE63w exDlO2xGI5R2TzuHeF+ju5/Gp1honnetiym57OhZ24Utc5H4OEAE7kgFT0yOV1SJ1OY03O5Hek9 DcmZ8hE+U44DL8UTlBUxFNOjiIX9XzD91CFT/598SWidWq3q
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Shen Lichuan <shenlichuan@vivo.com>

Fixed some confusing typos that were currently identified with codespell,
the details are as follows:

-in the code comments:
drivers/nvmem/brcm_nvram.c:25: underlaying ==> underlying
drivers/nvmem/core.c:1250: alredy ==> already
drivers/nvmem/core.c:1268: alredy ==> already
drivers/nvmem/lpc18xx_otp.c:24: reseverd ==> reserved
drivers/nvmem/microchip-otpc.c:159: devide ==> divide

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/brcm_nvram.c     | 2 +-
 drivers/nvmem/core.c           | 4 ++--
 drivers/nvmem/lpc18xx_otp.c    | 2 +-
 drivers/nvmem/microchip-otpc.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 3d8c87835f4d..b810df727b44 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -22,7 +22,7 @@
  *
  * @dev:		NVMEM device pointer
  * @nvmem_size:		Size of the whole space available for NVRAM
- * @data:		NVRAM data copy stored to avoid poking underlaying flash controller
+ * @data:		NVRAM data copy stored to avoid poking underlying flash controller
  * @data_len:		NVRAM data size
  * @padding_byte:	Padding value used to fill remaining space
  * @cells:		Array of discovered NVMEM cells
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 33ffa2aa4c11..66eec1960801 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1247,7 +1247,7 @@ static void devm_nvmem_device_release(struct device *dev, void *res)
 }
 
 /**
- * devm_nvmem_device_put() - put alredy got nvmem device
+ * devm_nvmem_device_put() - put already got nvmem device
  *
  * @dev: Device that uses the nvmem device.
  * @nvmem: pointer to nvmem device allocated by devm_nvmem_cell_get(),
@@ -1265,7 +1265,7 @@ void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem)
 EXPORT_SYMBOL_GPL(devm_nvmem_device_put);
 
 /**
- * nvmem_device_put() - put alredy got nvmem device
+ * nvmem_device_put() - put already got nvmem device
  *
  * @nvmem: pointer to nvmem device that needs to be released.
  */
diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index adc9948e7b2e..c41a0c58bec7 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -21,7 +21,7 @@
  * LPC18xx OTP memory contains 4 banks with 4 32-bit words. Bank 0 starts
  * at offset 0 from the base.
  *
- * Bank 0 contains the part ID for Flashless devices and is reseverd for
+ * Bank 0 contains the part ID for Flashless devices and is reserved for
  * devices with Flash.
  * Bank 1/2 is generale purpose or AES key storage for secure devices.
  * Bank 3 contains control data, USB ID and generale purpose words.
diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index 7cf81738a3e0..df979e8549fd 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -156,7 +156,7 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
 	/*
 	 * We reach this point with off being multiple of stride = 4 to
 	 * be able to cross the subsystem. Inside the driver we use continuous
-	 * unsigned integer numbers for packet id, thus devide off by 4
+	 * unsigned integer numbers for packet id, thus divide off by 4
 	 * before passing it to mchp_otpc_id_to_packet().
 	 */
 	packet = mchp_otpc_id_to_packet(otpc, off / 4);
-- 
2.25.1


