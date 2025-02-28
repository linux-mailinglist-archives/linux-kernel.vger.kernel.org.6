Return-Path: <linux-kernel+bounces-538651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84DEA49B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB3C3B9FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B084274272;
	Fri, 28 Feb 2025 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOM1+0+E"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3726BDB4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751654; cv=none; b=G/ccLCL9UlLK1hxIT3vg5PRTWleUbJ1dg3OClIwFRvV/4Q8ajJPh2uFSD2K9OflrD1i4EPMDec+63LpXDKjDo/giKkOIA66It86z09zA8s54I5vykUtvIyJ0/ONNzwQ5oNI7MHNbAPqV5A5DwCJVvResvpFpaS7e911GeIAHJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751654; c=relaxed/simple;
	bh=csOMxrJ8DUKG8jZ2g+nC3altbQsJLgJ3nzkzZybq300=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhV09nphEfOKt+6HUePPouA0l7rd79RPr2sUmPYNNnu8lhWLPFh2nngP1ieuQViNq43qa1Np1JA7VXk8F6gEhyCpKOKjZWPluLz6iIb67u46LlwaW01FyceNnIeVmboQHrYWKXEDT/gsYu68QNIT3ZUocTxnzHcimYRkCQMjaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QOM1+0+E; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so3595945a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751650; x=1741356450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVgVdQhbC2YyNwH7K95+EhEh/kAvax64uDHN7A2amTM=;
        b=QOM1+0+EeNvhAM/TKJ0qctceEbRr0WzYClZbSW63L29B2imhJlMzgqCkKNBIfQtU+V
         QuQMZtwErSgGydIOWkB6SiQMHnZF1pcuu56uenHSO9qrXuHSg3RPOXwXDmvKt+LmsyfB
         MicOfm81eg7/+heDKjLcIdOmVp/bSiuVMQzUNRlWQ+h6puitUmpTkVbs4ZYgfbY9yzsd
         PNKKXw1ak/dEjH6ymbT2ye1HfL/7SA9PbCXOyZ/Aqw8pC/kZpVoWjDGFFbKmuvLcS6Aa
         dhqVIr+YKq4i9susfCX6KNHJxbwr7MsCCWgVg8T04QKNkSOCVdkhLlQpjvyDz4BtjEzc
         8Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751650; x=1741356450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVgVdQhbC2YyNwH7K95+EhEh/kAvax64uDHN7A2amTM=;
        b=XRQtGdJ5H+tlfacLvK6uzz5xBf9Uhn5NK+Ti+EowjwfNdN7NfOu8oM4SN+jL36aerT
         s2q5BhTfplUEh7WQT9g6Q5axGmNTZ79YIfsftYOKgD7onFau5xsatBa8VNjqCc1yd2fa
         Lnm98JDTOJTcgxE16JReiEdc8NHCRkFAWdGEQZVRy+Pv3FeowiDH+haFu3y21/IZ+es3
         yIcTbWl8VaUVV41OZ9gi4MYdHqxjcyobtExFyFMe+Ve09aji3uOtTReVHc8J/CuJskfe
         fy2abkOiAscbRQy1EPPmnIl8jkFI7GmysOz336RhU4/P9hvCESIPsylz50/m9LHrBcJ7
         BC8g==
X-Gm-Message-State: AOJu0YzdhyIauu7LQd6Q0SWVAkJ/ksdff5xP3rixpmKa7qj2nSyJjutk
	DR13uwx5FrZYAbHoeEBK8fCifzCsj2Jzg1kaO9jUMG8zqz14bhlX8i+ybbpOHgA=
X-Gm-Gg: ASbGncti5kiJBeGL0SNdbQe+jJhn89rZpzCAbsukchLBgl3MgxeuWtXp/vHICYBsSSD
	ZT6nYJI2kfUgt226N9HM7US/2t/CQNLifqyGrWzVGZiqcwBpTqX69vQj2Zf2z8VxSAMNc50oohs
	v8ImAnRPpi1XLvuvHDsUYM9MGicS52SeUEjQ8bZl2pWX2aYk3ZL5KpSQeD3VmK/rMospTnyq/SE
	XSrVWqDULX8YwIDKfybHtNSRlVf4GxuTlDKAcGz371gcV+GrR+lpSzTfgVjTvzcq3gQhEMiXLIR
	sL+anIeNw8ITRT7jMj1GCrezAOFArrC4r1BcnzOR3JcEk0XvgUn+S8hMLw7imMC35u6eznfDRZB
	DMLehlLOGwQ==
X-Google-Smtp-Source: AGHT+IHCyDQzEJ6kBhW3v4N+pYx5F1W3SqfuZOszPC9Ixk4jqjoqtVWckx72H2jiEWEF9nyPWj82Qw==
X-Received: by 2002:a05:6402:254d:b0:5e4:cfe8:3502 with SMTP id 4fb4d7f45d1cf-5e4d6afa314mr2938285a12.17.1740751649850;
        Fri, 28 Feb 2025 06:07:29 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:29 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:27 +0000
Subject: [PATCH 14/18] rtc: sd3078: drop needless struct sd3078::rtc member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-rtc-cleanups-v1-14-b44cec078481@linaro.org>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
In-Reply-To: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-sd3078.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
index fe27b54beaad1c06b70bf7f22e44c3f6da087267..ebb4d45ce2409982880affbc7a85d5e7410c8f42 100644
--- a/drivers/rtc/rtc-sd3078.c
+++ b/drivers/rtc/rtc-sd3078.c
@@ -37,7 +37,6 @@
 #define WRITE_PROTECT_EN	0
 
 struct sd3078 {
-	struct rtc_device	*rtc;
 	struct regmap		*regmap;
 };
 
@@ -167,6 +166,7 @@ static int sd3078_probe(struct i2c_client *client)
 {
 	int ret;
 	struct sd3078 *sd3078;
+	struct rtc_device *rtc;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -183,15 +183,15 @@ static int sd3078_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, sd3078);
 
-	sd3078->rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(sd3078->rtc))
-		return PTR_ERR(sd3078->rtc);
+	rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	sd3078->rtc->ops = &sd3078_rtc_ops;
-	sd3078->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-	sd3078->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->ops = &sd3078_rtc_ops;
+	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->range_max = RTC_TIMESTAMP_END_2099;
 
-	ret = devm_rtc_register_device(sd3078->rtc);
+	ret = devm_rtc_register_device(rtc);
 	if (ret)
 		return ret;
 

-- 
2.48.1.711.g2feabab25a-goog


