Return-Path: <linux-kernel+bounces-512595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA62DA33B52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C183A48E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAE320DD66;
	Thu, 13 Feb 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0K3qtHM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22BD20AF87
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439478; cv=none; b=DdNlU75yY0qeNOHbVCnatJYKA6wTY2kYh3KkU0mxqqaguFXl714vNTcUnOLe9jtEwWn3yaKLK7ULva67KiJaL50yPYibXFMgVkqc5qqh8SCkf5ETm55Ytnl09e8pK7+m5qufIMGCjccEpHqbskHhcq1IPj9EZBeviuHN+a1e65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439478; c=relaxed/simple;
	bh=RiEAHZGnT5RZjUeFLeN6bZFizTjIq+JiREuWrzH7QL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uvMjLYKFVaWdErMy5sXYR4hOW41d+7pqe9aS+mineo7Z2h+Ijd9/vV814PbJOF78dUrvHge/IK7mF+svUpkgbSXQKW/Mufl6B9fd4PUdtcr41mnqeIXXl/phJFQvU4NRPncz/hF48WilBCC998CoyujzNjYULqBF0UUNQYNjgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0K3qtHM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7f9d87b96so108763466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739439475; x=1740044275; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/2XAYuXD7fsybMjqk59PT3L6d5BOK7J3miorlIRVn0Q=;
        b=s0K3qtHMRPjzYiypwczREBmqIa+laiD9CH6IIRLFyiQGPJAvTtIQfCY9de/KpH1efL
         bCeEWrfFkBqov374oau61fDkyVJS+/vNiGzLlyPLsesaOUjWO+4DcblOBy8Ih9GD+O4d
         aPPP94Er5b3f3Ja9qh2kzBKaZuK8+ehf0VQ4aVnUkFGZI9WeC04+xQ+BhNiJK+eLBBdD
         ax/NpY7d5X3W6tvQRfh2C7y9spLehBFMssAwtL77giABTmCXenIHUBFp9Y1fIG48LrAK
         HecGsYxuV6Nze0bWxfEfdOb+yEYDlE4YzpuEJw0M6tDSFTebsCaFEfQq1QIOb7ifqgkg
         Wthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739439475; x=1740044275;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2XAYuXD7fsybMjqk59PT3L6d5BOK7J3miorlIRVn0Q=;
        b=f9Dar0rOryyfOOVvB7LtO1sdLhXzfGqma+2YtgJJS4mQf89aCpKzUjACo91fQdOXNR
         nMe/WMeKPU5U1Wa93YeYMWKMeYfq54optMbhtZYKc4K2uuT9e0FbzNnTWQ0m7Ucu2Ih2
         0TDr/T5YNjox0LKQ5DTDFhJrq33cYclkcPRWPqwYMHpRp0NkYxqpNL0SqS2me0HH/ODu
         9U4s1LWTXjnTVfJrcmnvf53k9h6O7167m9shKHD34wxmdJM7B0F9DfmRJnvNizHTxES3
         0X18+oxBEMvdvd9ZNUnzmSxRPOuqmroqn49oNFh6KK3JrXgTscyLvlr+vx7raA4os26Z
         jobA==
X-Forwarded-Encrypted: i=1; AJvYcCUm0EtVwcOPfQ19eIeVu8a5AtJsiCpYX/IOzTP5NbUK3URCdDXedICK0h9sWJVVKajvHe9aiTdNHclUeYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyueEJ9/qPdxOkTKPs8ThFjzec47Uc4RmUlxL7CPVWtr8I0Kxwg
	hHDmmSgVj3BFAFAl1Tq76NU/3mCBTDWC2DvMAk5XwLcH8lZ/5dmafb89yBCS9EM=
X-Gm-Gg: ASbGnct+5s6QaGm6lxFMNPVuNyfFOkhZflNf7kw94r4abc4FIhjkFceCRaMcY2WmBQ8
	MtDrXj1QVkV3GoR7sgDAX5GKrSoUuKeScCZWhXR3TZHZX9lkBVVCpl5VNVoHvdbiZ7CFobuUwHv
	KDOKaqqJh32pQh942RZr6zvwRfLK2WqP/mDBzrjJNx9JObgK/o7u+3YtcvDx7QiE58ux6gm9Jix
	KTJ1VQqDi/KLLC0rZhMXKQh2vaH+jdaU3RpLngZhaFuDElenlj32eGP63KyXmq3OhTiYYtyneF+
	slZkZv4aNSfzsHxFHk1cKUurCGUEUE0+tSd9MY8TEARJ4YA3/An/NBbdvwfqYHu+aPOb8BXSks8
	=
X-Google-Smtp-Source: AGHT+IGSHlT76ESoFZYlChETipfyce+vKjhfMVr7jv201RI2UCweUCpjMlYnJ8WPbZICQbk40i9A6g==
X-Received: by 2002:a17:907:940f:b0:ab7:66d3:bc88 with SMTP id a640c23a62f3a-ab7f34e7134mr532680166b.52.1739439474964;
        Thu, 13 Feb 2025 01:37:54 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f59sm866370a12.6.2025.02.13.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:37:54 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 13 Feb 2025 09:37:54 +0000
Subject: [PATCH] usb: typec: tcpm/tcpci_maxim: better interrupt name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHG9rWcC/x3MTQqAIBBA4avIrBvwB6W6SrSwnGoWWSlEEN49a
 fkt3nshU2LK0IsXEt2c+YgVqhEwbz6uhByqQUttpVYGd/8YY2yHnC6MfieUztngJtdJ20LtzkQ
 LP/9zGEv5AA2HbAVjAAAA
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

This changes the output of /proc/interrupts from the non-descriptive:
    1-0025
(or similar) to a more descriptive:
    1-0025-max33359

This makes it easier to find the device, in particular if there are
multiple i2c devices, as one doesn't have to remember (or lookup) where
it is located.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index fd1b80593367..46fc626589db 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -420,12 +420,14 @@ static irqreturn_t max_tcpci_isr(int irq, void *dev_id)
 	return IRQ_WAKE_THREAD;
 }
 
-static int max_tcpci_init_alert(struct max_tcpci_chip *chip, struct i2c_client *client)
+static int max_tcpci_init_alert(struct max_tcpci_chip *chip,
+				struct i2c_client *client,
+				const char *name)
 {
 	int ret;
 
 	ret = devm_request_threaded_irq(chip->dev, client->irq, max_tcpci_isr, max_tcpci_irq,
-					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
+					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), name,
 					chip);
 
 	if (ret < 0)
@@ -485,6 +487,7 @@ static int max_tcpci_probe(struct i2c_client *client)
 	int ret;
 	struct max_tcpci_chip *chip;
 	u8 power_status;
+	const char *name;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -531,7 +534,11 @@ static int max_tcpci_probe(struct i2c_client *client)
 
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
 
-	ret = max_tcpci_init_alert(chip, client);
+	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%s",
+			      dev_name(&client->dev), client->name);
+	if (!name)
+		return -ENOMEM;
+	ret = max_tcpci_init_alert(chip, client, name);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret,
 				     "IRQ initialization failed\n");

---
base-commit: 808eb958781e4ebb6e9c0962af2e856767e20f45
change-id: 20250213-max33359-irq-name-0665d6b69058

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


