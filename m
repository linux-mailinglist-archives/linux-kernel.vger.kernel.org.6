Return-Path: <linux-kernel+bounces-575219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B10A6F46C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABB93AE790
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29307256C83;
	Tue, 25 Mar 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="usKXiX65"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3912566C0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902869; cv=none; b=RTuVtu68NlIfcsHtQ0nPjYG0vKwTrka2LxjNyBYtCoTCujI4tsaEmQGP1EkQS5C8hNutOJSfVstoH6a59XOMjTzA4QQuWVuxU0dlnkVQsm7Pqg/HIYAWlYDSakkz4cFif31d2R6CWrxERxJ5IpdMpy8z0//dA6U/v+xjaI/Efpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902869; c=relaxed/simple;
	bh=5X1aPO2z0jUPOmAmxxbRnG88+AZ4I5yT718/OM1HQtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEgYNc1octY0khcqU/d4DfFtUXRC2ng+Z9AH0mXVewq7rRSGfMG5i3RudXfJCcdlui5Z5rRrsot6ynzqMbC0Hao5bV8SJcPoOyIFdwT00ZtCgYlafqpSR3s5CCUuKF7Hy1LIppSSA+yWtvhLcS5maScV44OkiHzANEk0YQPn0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=usKXiX65; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ac9aea656so424556f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742902865; x=1743507665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPfdok1uXbCV3fbB68Oh0kuMKD9EmCqvBmSN9d5b64A=;
        b=usKXiX65vIWe7q2d7htqljwhlLNAbcNC8d+RPpW0XIPTuELCE68RrY/B7D0vW3fIU0
         HR5a93xtJBjJRre9zzsTSbTA+JOPmc08bAVizY1fVVD8CEvo25qR7kTk3iDndWEm9trn
         NbF/Bquob1YR23U3anxQ4jKhoGuB+NIOhXraQWoRL70luThMNDKWJafMMvpOVtVsTtQx
         QMR0I5eChNE9dl2wSy19R8u9W9yeSaIWlyjCuzYUTGPYf5PUc9+VifBc0teGazFPUXzc
         DhlglhqJWE3+CSQs5fr8drisvfzv8oQf/m+6uAWHEDuZ0L/fvm+G1k+R+IOrIc1EgQL5
         f+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902865; x=1743507665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPfdok1uXbCV3fbB68Oh0kuMKD9EmCqvBmSN9d5b64A=;
        b=F9zGlwK8Wkv+s1y9f8YkJgDkEoIISOowT/dF6iuFJQvahKD7W1UVDeN3vwI64i7FI1
         55k90ngL0Nj+tgk0n7L14j9Lg0yGKiWUC8tNIJ05Ia75GJNl8UAJ70aVIKZY9DD2Pv9Y
         x3VxVbVL+1Lba0pfQ86uGtTId8Wg42KjHz1usfZA6zcuQBD++8/uUWSix98pyZ3I4L4f
         vMek0/u/KBCeQBHPfSRx2PgEGWnaP/srt+rz8HwnBE8rJaIkDMcdQjKcnZ81ZgS152Ik
         Gu3E8ThI05Y+TgVNK9hvG97oFbZcEz57SqgTa08/KtxK/HmKo9RBFZ7/2bieQkE6W0Y9
         5wNg==
X-Forwarded-Encrypted: i=1; AJvYcCWkPqc3X80sI4ZyW7j6Epu6e4y5RmmmQKWm8Oi6z52V7CnJrjg2451KU3OJrvQvDtPtY1rcK2xHkYcqT84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9QA3xi0oPh0znC9RNyvYUbT16mWjVBQNx/Dg7RoKXRc7UFANB
	LH0Zr5jMhpSmSsWBE45e8Yfwnu9RxpeP0MuHFqPKhCHWQYZ3evlWcOoEQ00FTDs=
X-Gm-Gg: ASbGncspnO/XWO9LIbDM0q0zPwJjV9Jk+jGhBWddc0VL6Ja69H500nkp/zN54GQ5HuF
	tGZ3b/wgKSuiq56j7Go7WhGFl6f/OSfxDC20YmExZJDihm+gMftxlrB8jpcyso7hBcGS1ErTB3O
	B8DnRWkO0J7YY4Swm0MOEmPkNJsdkFuOfvuwX4L7wJnRqjZ1RJHyPYceZNmcYEbSVfEiylVCtXD
	9riW+R/et+roMgcPSSzkjmKk2gRnOv5h/y8LVP1FG2sxtqHjsbxCtaE2JAwA8RmjNpWz4b6yUYy
	e5ACHZpziBuNYzeHaa9j3H/4dXJOsIK30okALdAjOuekM21ZrnUopT/Gj4fNtfCWOYSGyA==
X-Google-Smtp-Source: AGHT+IGX+E1xFo91m0AYrkO4kkEoY2JQnq0F/cboQi3QOCvL7ex9DY7qp1H7fIxNEBp+thnIa9ixkA==
X-Received: by 2002:a5d:648e:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-3997f91287emr14148949f8f.24.1742902865471;
        Tue, 25 Mar 2025 04:41:05 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13213330f8f.29.2025.03.25.04.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:41:04 -0700 (PDT)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Christopher Obbard <christopher.obbard@linaro.org>
Subject: [PATCH v5 2/6] mux: gpio: add optional regulator support
Date: Tue, 25 Mar 2025 11:40:54 +0000
Message-Id: <20250325114058.12083-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
References: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
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
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 drivers/mux/gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index cc5f2c1861d4..d1607f287755 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -15,6 +15,7 @@
 #include <linux/mux/driver.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 
 struct mux_gpio {
 	struct gpio_descs *gpios;
@@ -82,6 +83,10 @@ static int mux_gpio_probe(struct platform_device *pdev)
 		mux_chip->mux->idle_state = idle_state;
 	}
 
+	ret = devm_regulator_get_enable_optional(dev, "mux");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Couldn't retrieve/enable gpio mux supply\n");
+
 	ret = devm_mux_chip_register(dev, mux_chip);
 	if (ret < 0)
 		return ret;
-- 
2.39.5


