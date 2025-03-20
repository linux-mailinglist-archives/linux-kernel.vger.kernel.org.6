Return-Path: <linux-kernel+bounces-569650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC953A6A599
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6206B17F163
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BEB221D8E;
	Thu, 20 Mar 2025 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eb+dSReu"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DF22069A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471806; cv=none; b=LCSqrDof2DA0zJcSPD1wSTSmrrWRkDfFxMf/akpshKPay6q43Whkkr6/z9uhIcSStysMpZBTjvzBOtHlwZKlYtqKMEK5PLAh56b2aH/RbHdUidrjp0cogGSjsa3OX4Z9ofpFh3XIjMVn/pOOGMGxy1Z8UUoPrnamMh8t9N2Is7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471806; c=relaxed/simple;
	bh=T2PbRRhtQTGvQFtJCRLISmS81biLegmtD1AJKN9+90s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvVTH4GDL8xD16j4ODCy4xhnEKhIrdh+LT1MAuyyTTowlQSt5T4PNGfMcRGIHP0g2h/15ihUvx9blVyjAQopDldFBGvy0zcmCz++IKoboSSFbQX92FtV2LtLQo8+P2wQtuQYDQShFuBbLSt5nyKEM2kvBV5Ns9PZ4Jg4pbhBzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eb+dSReu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso4010045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742471803; x=1743076603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1gFShGL18VkNSl91DJ8JTM4WvU0/x0n8rRRT7Ut7zA=;
        b=Eb+dSReumpURahzlftk61pXmRcqqigcVMFIXqURuGaAMljy13eWSVgJd34XpPUAbXq
         /WVE3M3NhGKKG6NTfU8IIaIXGQrvhbMMF6ZNfJ9tiRW8XKNJ5DFZfXY2Y+zUn3VH9vH1
         k1TldGFpU+6MFOYaCSGrhlxuflL+fDqd/n+//tuEleUcbezdmbXSQE34BdbI6s2GvwYQ
         kU/P3CzJgO9k24vxRbfQ2wwQkfyBLAJI8ZAJFpp5wtCo0Hmt43e6fOeXUfIkJDiaqGKa
         WglRhe1+da1jAlCqdp28elRa6/negAcCS+g1dm7Q7ZW13oZZ+YZJvsA0TlKnwVCwnDN0
         ZMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471803; x=1743076603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1gFShGL18VkNSl91DJ8JTM4WvU0/x0n8rRRT7Ut7zA=;
        b=MfWg7PNHy5bUw6smW5F0ZEGhk9QwJi2AIgYAYF3cioARvUaXuu/s5pGCZGJWr0QVl3
         d6Gpp/be7zDxJJs4hj9Tw7rucs6cbUOCJ5YLIU+nQop4RxNG3D4vBgOBhkKYkLHcwU13
         B8bqpgmJQQt8YZQuofAiSWz1I4l7DprxVzeo/e+9QoApjM4ZXriR4JVA+qvZDl4oFG2g
         C/YLFChhqe/tn7gTwzfY7LAlHlDomrREGcFI+5h3amyF2CGAZOTVoj5FmnCs3l510omh
         HBqKRv4ZoOWzX70T3F42vrvuyEMVZ+F5WdDTqH8WbsaaFaL9O5jC0zAJjEtOP88ooJVF
         E2uw==
X-Forwarded-Encrypted: i=1; AJvYcCVtceQPjrezA2Wx8iLXMisYbtvXOxytxvFIUjeZ1A2eJ6v9+yVQzrV3t8vGEBWHSpPZ7Bsvh94j7j+dnyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH4UG5IxMn4bCiLOGCl/2iTNMZRGQWk79dW1kkHfWAW+5LHwuw
	Ehs2hiuFUeO5svX6W/4Bk4RpBGMJp/RjGb5SYscmkdOjGaPwGThmSOY9OgB7Rl4=
X-Gm-Gg: ASbGncvAPZ9/OdSimuoui9a/SmRjsWq3Ouf9spTS8FA2qR/39c9Vj9vzMMN0N5IhF5a
	2rbezBIPDFzJffnAw6GtyZpq2fJ88Qso/x4/tpOqfvs+R3bNYuL6skkFiPa1zTdh8joSec1ax1E
	3S+6xKcfhqEWasy2f2zE0TjgBPHJHSNx6Eje4wj8Af3AOLM/NAb63j7p/ACj4GULCG4euHvQ/QD
	r+FsR8uDM9uuPS/eTIdi8NtJpQBq90aNEW4dVMr2QevuVQetsIFpTJuElG+wHCNSGRC/O4pBHCA
	ktId0ef/LuJD08qixtm3HBhYlQ05EU2rKP106xySrOItq698mS3JA2x1o0y96mBgbR8Xlw==
X-Google-Smtp-Source: AGHT+IHDaRKUgc9HfZ/3hd0DCQIlmWkm3pZZLNqhOMPZvKa4KfAsekDz2fiYCxQmIc+NA2HX8qs4VQ==
X-Received: by 2002:a05:600c:468f:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-43d436c753fmr63116995e9.0.1742471803125;
        Thu, 20 Mar 2025 04:56:43 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888117csm23257857f8f.44.2025.03.20.04.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:56:42 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/5] mux: gpio: add optional regulator support
Date: Thu, 20 Mar 2025 11:56:30 +0000
Message-Id: <20250320115633.4248-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
References: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Some of the external muxes needs powering up using a regulator.
This is the case with Lenovo T14s laptop which has a external audio mux
to handle US/EURO headsets.

Add support to the driver to handle this optional regulator.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mux/gpio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index cc5f2c1861d4..12cd9b5c32fb 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -15,6 +15,7 @@
 #include <linux/mux/driver.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 
 struct mux_gpio {
 	struct gpio_descs *gpios;
@@ -82,6 +83,13 @@ static int mux_gpio_probe(struct platform_device *pdev)
 		mux_chip->mux->idle_state = idle_state;
 	}
 
+	ret = devm_regulator_get_enable_optional(dev, "mux");
+	if (ret && ret != -ENODEV) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Couldn't retrieve/enable gpio mux supply\n");
+		return ret;
+	}
+
 	ret = devm_mux_chip_register(dev, mux_chip);
 	if (ret < 0)
 		return ret;
-- 
2.39.5


