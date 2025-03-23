Return-Path: <linux-kernel+bounces-573029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993FFA6D222
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C613AD08B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FFC1F3BAB;
	Sun, 23 Mar 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcQaQ/4W"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085D1D514A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769578; cv=none; b=XXw6KtCANEYgp6oPjqnYyOx3kEVqJnMNLGqnANL9cuI+5D2llf3y9jq5fvLMiPAqQcPNucppVYw4roxCS2TTwMaadS9HLOocYE/J8NyOO9K1tNCUHrRvryEGdn3KNDq4wn3c7rybEc4gZbzoSeyDmogSeIcIsufA5iMa8u/ZjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769578; c=relaxed/simple;
	bh=mYouhjAoSbLSn92zFo7mSaGFj9cCPHa2OyFJJEwMdw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leM3jTlvNCAm/PqVZdSvum8D97VYYSdYb+jHykRw93o+P0ADvJpPeeD5WhruR/9Rx2/i19zdIy/9b6ia8n86ut5YMBJNiVVcsLqd00TWEmXn+lMja9WOH13zIkQ/OtI3J6EE/dCDAY+eknz8twg0c+/S7UHQ/U5TvSRyhB/zFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QcQaQ/4W; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso560750266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769572; x=1743374372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmds4rrDLrfKJmwR2Z+ZSZKx1qRT0gZntXalkJpQH7Y=;
        b=QcQaQ/4WkIkk+hlhTXnQ2KRnW3VAX2TNN6AhASfAlkd9xfsucnkhv9KDGQ5Cp2obuC
         R88XvwFmR2f+zbcMhEgSngCGoWb9ruRURZT7BYQjfxRvU34FrGP3cyXvQEPbMYBp74xh
         +U+OaLjjzBiYT2br160bRnAcczHdwQCDTzIJqLozpiOXEmjPB00zaL1N1AVoEJTeZ99Y
         Eig4wBR9U7BLcSkNt0hOSqXH04CtIJNHMUBIpsjR+AUcGB4dDdvlYq+K8vRAbGhL+nm7
         VSz1PhJFLEPaWCDQLwG0vy0Q7Zdsa6XmkmhZtWxV6RBqZEZVncX1iaubDm757rEepJeV
         WRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769572; x=1743374372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmds4rrDLrfKJmwR2Z+ZSZKx1qRT0gZntXalkJpQH7Y=;
        b=QjeWuWZH5yw6gbipQ+l+Hlp/IPKhDLxlBjfjWJ3GmJ7uKbllCRwhgdIjco6yiiYm2V
         xjwaeXqGvBH8e5g9aXUB0z4M7XvGkaylqwDoxkFnsRKH+2iDXR0E1jvBmT/CPAKvA0Z9
         V0IZE+scfCmQezGUkT6vcdYnGRjlA++O+8eksRf56tQKwAbq7MTj41SLKj9cuxlqhywF
         MQfPzynniWiVNo61h4vD0tzz8f2x0+fgx3HUdYo9RQlvZS7KqW5pl6wvA51JGNNjlgt6
         xEoQSabnqw5W7KWSeT6JbyQiZR93yn9Nac0/kU1uoNpUSS5UdLz7jmPcXFbLYq3uyDeU
         DdHA==
X-Forwarded-Encrypted: i=1; AJvYcCU/W8Pk2gIy0xGfk5bLiwd+PpV+s+xS8qZQ7eOfCMEDMlCgaZ7HoIkdwjhQqqVwQczo7fl4AmPs0XYVR30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RF4cHZd+Zx0AccHn1tiW2rB/7jg7XUrAOfySdbs6UWv4+2/F
	0Z/Qt4pFBX62XeFJjkfDxfWGJ4OLi4/icvErBj/pXPAAc/9KCp8BZTxm5fgDgyE=
X-Gm-Gg: ASbGncvo1TKS0KpMmbyOtg0FfDH7CF1Gmuj0YVPnJdmdDzHSpzKbucD8YckqKX6xpoL
	/phwQFd9s9jBIo+G1hFFjfCWbDB7x7KnYXRw7WFh/g3xPXkKHQ1X/x3vuyW4hgd2ze9D2IQdQY2
	XH6xRpwJNQ2rysLz+ofvz6NhhVRWaW9x/acTdO3cBpua+UC9ZwR77vlMkSkJzZKN48p7sKP12UB
	BHOxX0OkOe2wKoYsHIBvNwvNXvDQp4dtfuk0ApBR/V2iryVfHGOUpRGcN9oroCejklQ7Bs8pudF
	L1JERroNjHY9z4R2ZBN3VcyZ5XfiWZGvTLnoMljHCJ+ZPMFd7cqUhBiPEJ86z/QqviMz07uKYtX
	YE2wnQ6qpzoQR7Oi7RZrA48fIIURZ
X-Google-Smtp-Source: AGHT+IEN5dOxnNTTla9a5uamRe8PZKZsb3egHapeEJMQ/eCTIADM/0J2Xb8LBoxvBHWdtuRNYkVBpg==
X-Received: by 2002:a17:907:bd88:b0:ac4:2ae:c970 with SMTP id a640c23a62f3a-ac402aec9f2mr753664066b.21.1742769571904;
        Sun, 23 Mar 2025 15:39:31 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:31 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:30 +0000
Subject: [PATCH 14/34] mfd: sec: sort struct of_device_id entries and the
 device type switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-14-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Sort struct of_device_id entries and the device type switch in _probe()
alphabetically, which makes it easier to find the right place where to
insert new entries in the future.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-i2c.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
index 803a46e657a5a1a639014d442941c0cdc60556a5..ba0efb30877bf668fed7476a5e247e0dd4095806 100644
--- a/drivers/mfd/sec-i2c.c
+++ b/drivers/mfd/sec-i2c.c
@@ -174,12 +174,12 @@ static int sec_pmic_i2c_probe(struct i2c_client *client)
 	case S2MPS15X:
 		regmap = &s2mps15_regmap_config;
 		break;
-	case S5M8767X:
-		regmap = &s5m8767_regmap_config;
-		break;
 	case S2MPU02:
 		regmap = &s2mpu02_regmap_config;
 		break;
+	case S5M8767X:
+		regmap = &s5m8767_regmap_config;
+		break;
 	default:
 		regmap = &sec_regmap_config;
 		break;
@@ -204,11 +204,11 @@ static void sec_pmic_i2c_shutdown(struct i2c_client *i2c)
 
 static const struct of_device_id sec_pmic_i2c_of_match[] = {
 	{
-		.compatible = "samsung,s5m8767-pmic",
-		.data = (void *)S5M8767X,
-	}, {
 		.compatible = "samsung,s2dos05",
 		.data = (void *)S2DOS05,
+	}, {
+		.compatible = "samsung,s2mpa01-pmic",
+		.data = (void *)S2MPA01,
 	}, {
 		.compatible = "samsung,s2mps11-pmic",
 		.data = (void *)S2MPS11X,
@@ -221,15 +221,15 @@ static const struct of_device_id sec_pmic_i2c_of_match[] = {
 	}, {
 		.compatible = "samsung,s2mps15-pmic",
 		.data = (void *)S2MPS15X,
-	}, {
-		.compatible = "samsung,s2mpa01-pmic",
-		.data = (void *)S2MPA01,
 	}, {
 		.compatible = "samsung,s2mpu02-pmic",
 		.data = (void *)S2MPU02,
 	}, {
 		.compatible = "samsung,s2mpu05-pmic",
 		.data = (void *)S2MPU05,
+	}, {
+		.compatible = "samsung,s5m8767-pmic",
+		.data = (void *)S5M8767X,
 	},
 	{ },
 };

-- 
2.49.0.395.g12beb8f557-goog


