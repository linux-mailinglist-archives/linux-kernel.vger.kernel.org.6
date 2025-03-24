Return-Path: <linux-kernel+bounces-573683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E382A6DAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB443AE05D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEB725F962;
	Mon, 24 Mar 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgcFYcYA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A325F79F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821271; cv=none; b=iny89K1KpSMv9xLEAKgdGLFBeMl/AqSrEKg4+g7vkwklqHMigMB+zAQ58utxBB9MNRk0D+fdgHDZLila9vrq5V2JnI7tL2RWDEydqDdMmXeFZQz74XqhD0iG/XJehC4Nz0m8kfiOII8PzqVEn7EC5uCIlsVGoDaNZ6waJ4Ub1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821271; c=relaxed/simple;
	bh=5X1aPO2z0jUPOmAmxxbRnG88+AZ4I5yT718/OM1HQtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qy+VqvH9D75SZacE+dFFcTzkHEtj8soroy10uKNWUoXArCYqHZ7JG/FDsFPU95p03EjuyifuNVngGLMqGUjIu7Dbyalw6RQjVaKQXSu3ZwcThs0dovZxyj1W4dqZbO9b5d0OLMpsnYjA3JZgzOaxP2qnW8tCOl7ripklvt3xob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RgcFYcYA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0782d787so30997875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742821268; x=1743426068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPfdok1uXbCV3fbB68Oh0kuMKD9EmCqvBmSN9d5b64A=;
        b=RgcFYcYAqI/Rueu0Gg1gB9noHvAZ4YhyivVcGabUH88aDS3nwsElnyCFrfI0SWyuWz
         I3sqzD5s2Ti3tgIXfXKijsEgW8dJd2KiOv4BPbwWgZ2QCclO7dbhdEA5cZFh8jhhaLxu
         Ja2DrOWbHfb3d1+CP8TKH73CGCoExtZCV5QiaedEkZ0EamVOZ0pHiDGwtPVvoreJOLcb
         xbsPhyvSbncXJScGe8ttIDnXOcnjFOfNhQnrdWTBSujV9AW19le12jMUscktZMzOVDBa
         W0CTAFnQIOLltQWaSOlN5kL1uEoWG4v4nmN5S07G6TPxt4z02aTD1dszVtjCbxulo1bh
         CAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821268; x=1743426068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPfdok1uXbCV3fbB68Oh0kuMKD9EmCqvBmSN9d5b64A=;
        b=cMVy0W0jt2zOowhiyKAzJjKRxyZmauTdxur0gVpj/CLxOnVj/EtklSzWOo0IhjCSKJ
         n9luxf6sQy/MBQVXhNhmyD9OOU58d+KL+PlZd0cY2nM5Y6b8EU5l+pgnjrxPPUHVTokh
         T2IGiaC/pRgZ6wuBCQKEQF6ijIvORem7R5FPzYAfPrRyDgGEROZdU81qVqo3u/HZm/bz
         aR7KladBB/hJ0OMrGgAfby2P24ki/tCV79eqCMhqzGl64380OfKVYdcP044i1nkyoeBN
         23x5FBs/dzU3u8OMiFHcgxRWShboMMWuWkgGuo0taJ5xGrZk/Ivao5ZEfeYzB7PtuTxp
         jixg==
X-Forwarded-Encrypted: i=1; AJvYcCUoeMk2Gg+D+YtFW2Pw4L82e8kFCQM67v5GtHE7gT0ArKx7Plsbr2z/iP8V220JOaXoDXjvldtThiNat+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyatdPjK//+4tyoqghcYDXCgVCaIp2ltsLf9yWjLIgKykx+lwkR
	JmLdfASnUfC8qA5dBdOp4Z3RLpAWRQtGlvdZvDNrmvJBRFSvjpJWZ2s18z4l7GU=
X-Gm-Gg: ASbGncuxdAGTIXPl6IQxbxHVyll+9714JgVGOlaFmNjZ80q96qm6U3wcmi+i2bKpZFU
	7bxl0L6N97vvVFfi2fPipIMGEzwK6WctPhonidtWNjY0odTsAlV7I0sg51SSX+hL11rh2CrIv37
	TQJRf9VrjmTDjH+g5QHb1bH1JnKaH8qy/ftVJnTSWmjfOaNgM/652EQNHA9nZ0G8OMxS5H1v6d+
	2Zl1EWYEA6dP+pHebbVSngvc18sxXKRxhF2LNhAdBkxJoIcyTV8sqyGvLYBn1gUfqBYlGOI7TJl
	x7AcApaSC7n3r7AdVB8ymdsZuCpKYSiBnFc1q5GAaWhjCceOD0mIYOj1BvTI/uH61BZoMLPMm1L
	IW1eP
X-Google-Smtp-Source: AGHT+IH/LCQKWak9xUpo8rkhPabLxUJyhK8s6nWMq3T7RoU4G1wdnEPytthIr96D0+PMYfRTxPKOwQ==
X-Received: by 2002:a05:6000:178c:b0:391:47f2:8d90 with SMTP id ffacd0b85a97d-3997f9017e3mr10499945f8f.20.1742821264799;
        Mon, 24 Mar 2025 06:01:04 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd1c7sm122275975e9.40.2025.03.24.06.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:01:04 -0700 (PDT)
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
Subject: [PATCH v4 2/6] mux: gpio: add optional regulator support
Date: Mon, 24 Mar 2025 13:00:53 +0000
Message-Id: <20250324130057.4855-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
References: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
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


