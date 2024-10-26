Return-Path: <linux-kernel+bounces-383017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3B9B163A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A747F282CDE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558F1D0178;
	Sat, 26 Oct 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yns03NL4"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388E1C9DDF;
	Sat, 26 Oct 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729929954; cv=none; b=C5QmRCGM0uE5kINFR4cBm/0B3qxHZXyWf68G4yaoYkRD4idLyEt3+8Muyc1fyHtVZFzwerlPgfcSTj4S8hq7bGaF6e0M323QLi2rCHEmUWPpxfkV+unVEyroDmB8qxStdEUas6XP/mPIYz6eEYWPd8JfuHkzWCb7kvFHWsm5zfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729929954; c=relaxed/simple;
	bh=BwxrL1qfKFawU3QJ6xoJQZmqclg6Oux2yN1BAtabzBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGe5/zWAFvucTxRjhZLlMBcnoPXeKTIqysClgNPDCx8DI1MAiofUJVerbDt4rEHA5Uq+THBBMuUj5xQ1mDKsVySJtDbZ/pj+ZUZrx320vcodZ942eXqjYx9qh4IpLrQT97IWVKaHQ3npLp8GQqYjbOSk9feYjwlxCQ4p4hs1ijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yns03NL4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72061bfec2dso539422b3a.2;
        Sat, 26 Oct 2024 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729929952; x=1730534752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGyXhyZ0qhgMndAEha3zA28oK1WkxjpxLLEx25ZN/D0=;
        b=Yns03NL4EYprQc4b0ReKzhbPU4Mb1dgU3lYegwK+gySmTvCiNJLd9yx3798Iaq9+5w
         IaKCdTHm5NIxW4vaIN0R4c28dXA45ecK//ZH7lKOuzbkKidWqcJsFfT52ZzH+mK38C+z
         d6+1a9w5GIAsQpqXjHgP+T/a/Msd+q/UcaQavdDsltUAqm6ZO09bFG6Y3Fvthi4Wpj0E
         PZuHPmmZZCrOMO20SXd7Vzxq9bv87dpOIRxie67m5GS8I2zkXLhg3igSV4aBqTHQ/kXO
         +yATPo9ELaiEGCpmMP/VWA8jIP4OdmEgY0G8ajfQoj4uEBqRbIPdQj2c/h5oNqAX1W4c
         zvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729929952; x=1730534752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGyXhyZ0qhgMndAEha3zA28oK1WkxjpxLLEx25ZN/D0=;
        b=munU24tCa0iZCVKYLa5PJ2iPJIrMWM7lSTaFAd8qKTzm5r0/9r0qJrY5jAbdHiDRE3
         +Nlv5SrTqCMj0jqtr5yVgnGsm4Zk6kRyxx/v5vI/9+iq72q3Wme98cGMqX0kuCanN/Vs
         lgvbQFPBRSzzfDXLIfA8Q6BsD+TVGAQw9wgb7Fj8Zr5eg8VWZygN1jC0eaL5OpeON/vs
         t1er/0vfG1VSjbKG34gDRH69za7wEpeoQQ81cwfbDFNOzalMfiUJwqT6UrZBWbWVdlSb
         +MBNCXbL6u8vXLeJrYn+H0SgeRAkuN4j+AKFINKZLk6Fcktbo9v2AuFqgIl/1E5dqIvL
         qfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNpu9UvWoGhK3N3XP4RCTkXLc/5E8Mu7J5OE7jRcX0po19Eipmb1aDGw4e3RRR8pIhPE+7zydbrvZQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yysv3jxiFRyS8jeOVT0NINTryOosjzg2dgY+n9bJaVzQuGLg2QZ
	We/ixrInAWTi8zXgvpGgYtDogsQFVPvrkyCadrqdONOUvnaa1kFyU0DXxA==
X-Google-Smtp-Source: AGHT+IH4Y18dVro4HB0ZiZ0y+2hlRite79QbXRhH0Zg8MHFtOU5ePf9sKvvqmtLEvTMu+9sL3T2+iQ==
X-Received: by 2002:a05:6a00:188e:b0:71d:eb7d:20e4 with SMTP id d2e1a72fcca58-72062f860f6mr3201598b3a.8.1729929951653;
        Sat, 26 Oct 2024 01:05:51 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:4618:4c6a:7feb:e53b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a46f68sm2288666a12.89.2024.10.26.01.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 01:05:51 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	akinobu.mita@gmail.com,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v2 1/2] hwmon: (pwm-fan) add option to leave fan on shutdown
Date: Sat, 26 Oct 2024 17:05:34 +0900
Message-Id: <20241026080535.444903-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241026080535.444903-1-akinobu.mita@gmail.com>
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds an optional property "retain-state-shutdown" as requested by
Billy Tsai.

Billy said:
 "Our platform is BMC that will use a PWM-FAN driver to control the fan
 on the managed host. In our case, we do not want to stop the fan when
 the BMC is reboot, which may cause the temperature of the managed host
 not to be lowered."

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/hwmon/pwm-fan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index c434db4656e7..dcb48a41f9f0 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -51,6 +51,7 @@ struct pwm_fan_ctx {
 	u32 *pulses_per_revolution;
 	ktime_t sample_start;
 	struct timer_list rpm_timer;
+	bool retain_state_shutdown;
 
 	unsigned int pwm_value;
 	unsigned int pwm_fan_state;
@@ -490,6 +491,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	mutex_init(&ctx->lock);
 
+	ctx->retain_state_shutdown = device_property_read_bool(dev, "retain-state-shutdown");
+
 	ctx->dev = &pdev->dev;
 	ctx->pwm = devm_pwm_get(dev, NULL);
 	if (IS_ERR(ctx->pwm))
@@ -655,7 +658,8 @@ static void pwm_fan_shutdown(struct platform_device *pdev)
 {
 	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
 
-	pwm_fan_cleanup(ctx);
+	if (!ctx->retain_state_shutdown)
+		pwm_fan_cleanup(ctx);
 }
 
 static int pwm_fan_suspend(struct device *dev)
-- 
2.34.1


