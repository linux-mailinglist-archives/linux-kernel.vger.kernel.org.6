Return-Path: <linux-kernel+bounces-573044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90046A6D234
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ADC3B0555
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED291F91C5;
	Sun, 23 Mar 2025 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWooRd0l"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D01EB187
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769590; cv=none; b=BgVhwgZheveuAwtAyUkFV4eaoTCVBf45CBMURZywM15ZeY/N5wjKfCGl4mfl9mdeddtGSe5G/80lhVsKLMvDmRGNjL7rohmKPEsLYjKmkY/O+fRMArncBjJ/lwX4KXTMfuX34Pzrd8PeW0CIOpQ7T42Gae1LgV37vmjQM6KF56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769590; c=relaxed/simple;
	bh=JzkdkeBjoD27fDThowAsLW8EIMXc8+ZDmGc3PzCcN1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=diJccS1vT3ECQcHklZCCYvJo4k84d9OnU9/xtlLqgd1yjrTT74jYKGNKMFe/9svrDY8ceSE6LEw+Um8D9foc8J6oPUiQP2ynCiw1Sn7kqiEQ6TQVMy5R9ixLJ188oMqHY+tgo15otMJr6EYGTiml0rRTDDS68wtvkb0V3eFHUrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cWooRd0l; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso776705266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769577; x=1743374377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Z8QgNOGdyxdSVBJRkjlahCtXXFXCQYtK5J/GCQaRwI=;
        b=cWooRd0loMHH/8nAfMH/P78842SkwtNP2Rw5WfIHBTZf48+RqfYbZ//N3gRauhHM0I
         ITeVKOLt9YV1EJruvPZdpRGmrR79yg8Q7h5TATc7g6RCk7lTYNs/NQnRbds4Vuh8EdxQ
         q3FBoNGeTVyHuN03HTzYHddpPEeIDvoRISuiGCtVROc76p3XYyVyUmoCWMlvjPjZVJm4
         VTQkVnoYJVdg7E6ksa9mxXZM9X1KUm0QQm2Mu5flcs8QylKTU2PpBKbxRZoTXf4W0hLi
         xvw2ieHRVVqTd88zuf24XR+5Z2qnCDgQ+5coOJJnRfU0HBzpgso6R2nfX1QkRQr8qIcZ
         VHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769577; x=1743374377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Z8QgNOGdyxdSVBJRkjlahCtXXFXCQYtK5J/GCQaRwI=;
        b=X5/gF3koLNbJjmDfzR+eHiYp3japcG4DvA6gYvSBUojewV4z5y3P3ZIw/Bmkm+m+SR
         LTLjJkL6Iag1CS/WpFaxyQVoSG/8aI0ZFgAoiCwD8NX671OnFjVTepkrjPEO0Wl1tvHF
         OkNC35A5EsOPGr80AKfo6/T3tCcJozd+8meAaik6v0hcflXiT/2xI5/2mvt5hUyL8kNf
         pP9JCQ7j7H12Au7JZ54Kl0GwVW8tePQLbs8Hp4ZHBZfkBWa4ff8BmJtUPleh9Q9jy+j/
         7OF0ujCeHZHFE+snF9PjQPawr0HCHGbtNIGDZU+D8+QfEu6lw1hlmy7ehtSo4GsSHH02
         ZVfA==
X-Forwarded-Encrypted: i=1; AJvYcCW9VApwZgYuDiQWJBNHKjKviWt8LqeKFDWGR9zKkmRFNe20TpCbl20HU4cCxoVTw7dI5jssZS6iZXz3sdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHi9HSTycwh+Ev1/63nRzMWzn4jY5xhFdTVz2YMHaIbxuYr9M6
	BU1H2H4Iqw9igToFKAk6mGuPNidSAc1LqnfNdN4phIgtLrgkw6C8FlBPye53T10=
X-Gm-Gg: ASbGncuibjcF2RRnElu24W0THNWzUHCU0z4wdIfojHdOOt5qCZsCoB8YW3L7ech906U
	xe6P7smHxLRk5CMVrd3BNzaeIKDsm1ytqDx+4RbvEPlBjN09RhKKyTWwCjhRVd4aWLXTIEQ157i
	c3dgBzjr5M9oDYYXzIXO1GedvPc6qz5LNyOROfe7qsCcmmYrhVwgPBHcP42RkZylEpgaeYg521y
	4em1ulzEggU4YJLoC/Nonx2oUZ3FtNL3GBZq9qtsJqtQ29yFBKuKhfQCpbqIYDAbZd/DovHESk1
	HIKgSZn8pd9+fFrY5KaZq3FkB8pq+oNTwo4m3FCegT8kaXhCi4MQfDibPhTAuPFb/JiM1jC/zrp
	uk4x2KP4O8ZZkUHLd3upBtiO06jUc
X-Google-Smtp-Source: AGHT+IG1+wcYan4wIw2G87vBZ9kZLmE/4EPPJ6sSCzBbDr/N/WxDb6EjTSy7GHnKX+cpVY7JCrLHPw==
X-Received: by 2002:a17:907:3f9b:b0:ac2:63a9:df0b with SMTP id a640c23a62f3a-ac3f251f206mr898500466b.35.1742769576773;
        Sun, 23 Mar 2025 15:39:36 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:36 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:38 +0000
Subject: [PATCH 22/34] mfd: sec: don't compare against NULL / 0 for errors,
 use !
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-22-d08943702707@linaro.org>
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

Follow general style and use if (!arg) instead of comparing against
NULL.

While at it, drop a useless init in sec-irq.c.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-common.c | 2 +-
 drivers/mfd/sec-irq.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index 48d5c9a23230d0927b9dc610166ae3f8f1aec924..90225b683fa083d4df7a20dfaa4f47084051e250 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -140,7 +140,7 @@ int sec_pmic_probe(struct device *dev, int device_type, unsigned int irq,
 	int ret, num_sec_devs;
 
 	sec_pmic = devm_kzalloc(dev, sizeof(struct sec_pmic_dev), GFP_KERNEL);
-	if (sec_pmic == NULL)
+	if (!sec_pmic)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, sec_pmic);
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index cf1add30dcd0ff1ad149b483fe40edf82c2b57e1..084a40490979058b48640263ff5cdb38765b9ff1 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -449,8 +449,8 @@ static const struct regmap_irq_chip s5m8767_irq_chip = {
 
 int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 {
-	int ret = 0;
 	const struct regmap_irq_chip *sec_irq_chip;
+	int ret;
 
 	switch (sec_pmic->device_type) {
 	case S5M8767X:
@@ -497,7 +497,7 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 	ret = devm_regmap_add_irq_chip(sec_pmic->dev, sec_pmic->regmap_pmic,
 				       sec_pmic->irq, IRQF_ONESHOT,
 				       0, sec_irq_chip, &sec_pmic->irq_data);
-	if (ret != 0)
+	if (ret)
 		return dev_err_probe(sec_pmic->dev, ret,
 				     "Failed to add %s IRQ chip\n",
 				     sec_irq_chip->name);

-- 
2.49.0.395.g12beb8f557-goog


