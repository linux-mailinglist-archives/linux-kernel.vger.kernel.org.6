Return-Path: <linux-kernel+bounces-247443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582492CF83
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5775C1C2227B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8365C19538A;
	Wed, 10 Jul 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtbYkouH"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2519408E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607794; cv=none; b=fYWO1XzA1slZk8SGHWiDC5N/0KTRyrfZ2HweKI+LmS6ZkG1Dm+Uz0qD/KAh6jfLLrKPS+sKPuBWY/DP+WmAfkZoBCFs8VD6dPH1arWcRRJkW7xC3Wpdd8frgZlow+uEHaqrF+bJJc0Oa8NRMePeu7UQlzx+kgJ0z1gopAOUBoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607794; c=relaxed/simple;
	bh=v+I5fZKIK+3f31tZX+uZTfNTTOvQkNNPPT3FGfrJxo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B89jn2xzuH1YGFzvFwlXlkvsiJ+ZzjT2Sy+qvU3IBAew0OJB/xCj7QrKkWCBzyZk+1JKRNT+VxxU8GxrXrT59lEOap67FPlYuRmv0VXyke2pITvf49BwGsDEI0qwFJi/PFPLw8CUmptSkzXW3bQLQY+zVLOzjP6rttAY0mb2cB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtbYkouH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58c947a6692so7767830a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607791; x=1721212591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EHz6jGnv+MSlXLIFJTYz0j3V4QrlhRk5xlWpqxujXQ=;
        b=GtbYkouH9DhQu2BJZIWgcBQ4f0ismW72b1jmrRUmxnpCiiZy2uwhg8I9gg8LCvGRbv
         /+/yqIb9CykbiIhZx17d0Zxm1KNqRVu9CagxlPg6dEws/PYB9xIxQHTBYLxyAQE88thl
         7+0DynZW4zNv0iHD56phWgIOWJdvFVBR+UzakpaF9Pf+9ZF1PZl874vtvKQdY2kzd4nV
         8QXRZj+njSC3RSlC4KTbehFkuzQbXOK6HPeeJWkd8c75IClf2/E7Xuod2WFsDmyRGEcX
         8hXGknAPyciJYOcA8y8fpaPWElHzOgWG7TOBCfMDAfxI1Zii3Zeco8untVBxASf88mzs
         /exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607791; x=1721212591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EHz6jGnv+MSlXLIFJTYz0j3V4QrlhRk5xlWpqxujXQ=;
        b=teS6f4vDLVgvpVD9WHwEMstVXohiuJDoQVCuYkpEhc5OtLZWrvGdWAATl5knIq4Xjx
         02s4SjEPMMVlYXN5woE8o7tBNtMTZrch7OsMfTRQEpigBkbaaw6MqQpfZ/87Oc/nVW/Q
         goHyUMJUJvuZ5W0jwb4oMHpmy/ISbAJKIjNRFQNdfEbR8zV9teirBmTwTf/YhHFbbcj0
         d2L7wKfWzjBfJ1pqydNBr0i2MCiwqB7pC1tSPSPmySAIrwficCRydvNRDchYx9SfOkPB
         pB63xwOUErm7UXTkL9ItZdE8VLE0vgL3Ox/hdLzu9wHGu0jZsSaNFY1gO7MudqFjXmd1
         c0EA==
X-Forwarded-Encrypted: i=1; AJvYcCVwRr5Ah5+R1ESnYnD+mHKvWt+JrYhtQ9F9sxIQcJ1Cd37QHHR9DIXRX4upVp2cQqb5g8/bz3OBUMWiK364h+kSA0/sFVKGuInA/Bqk
X-Gm-Message-State: AOJu0YwU33zNqSBUHD2RI8NsE6N0y8Y9/yXPhZ1y73AT2H4FdlFzCU+M
	Lm58EMbivMa02ustVv7c1bKkF5LYXPaWyuA5atPuD0uuUvRgy3y7TRH6XrK4eIKpww+IgRFvmcu
	0tFc=
X-Google-Smtp-Source: AGHT+IHONz7ukaXxFyPTjynNVCKibzciLGDtNH5tc/vYHzKXbY/8i2tsQWiv7EwjCwlhWObWe5BgqA==
X-Received: by 2002:a17:907:2d2b:b0:a75:2d52:8ca8 with SMTP id a640c23a62f3a-a780b89f457mr441045866b.75.1720607790824;
        Wed, 10 Jul 2024 03:36:30 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:30 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:22 +0100
Subject: [PATCH 15/15] usb: typec: tcpm/tcpci_maxim: use device managed
 TCPCI port deregistration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-15-0ec1f41f4263@linaro.org>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
In-Reply-To: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Instead of open-coding the call to tcpci_unregister_port() in various
places, let's just register a hook using devm_add_action_or_reset() so
that it gets called automatically as and when necessary by the device
management APIs.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index ee3e86797f17..7abfd29b4b01 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -472,6 +472,11 @@ static bool max_tcpci_attempt_vconn_swap_discovery(struct tcpci *tcpci, struct t
 	return true;
 }
 
+static void max_tcpci_unregister_tcpci_port(void *tcpci)
+{
+	tcpci_unregister_port(tcpci);
+}
+
 static int max_tcpci_probe(struct i2c_client *client)
 {
 	int ret;
@@ -515,27 +520,21 @@ static int max_tcpci_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(chip->tcpci),
 				     "TCPCI port registration failed\n");
 
+        ret = devm_add_action_or_reset(&client->dev,
+				       max_tcpci_unregister_tcpci_port,
+				       chip->tcpci);
+        if (ret)
+                return ret;
+
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
+
 	ret = max_tcpci_init_alert(chip, client);
 	if (ret < 0)
-		goto unreg_port;
+		return dev_err_probe(&client->dev, ret,
+				     "IRQ initialization failed\n");
 
 	device_init_wakeup(chip->dev, true);
 	return 0;
-
-unreg_port:
-	tcpci_unregister_port(chip->tcpci);
-
-	return dev_err_probe(&client->dev, ret,
-			     "Maxim TCPCI driver initialization failed\n");
-}
-
-static void max_tcpci_remove(struct i2c_client *client)
-{
-	struct max_tcpci_chip *chip = i2c_get_clientdata(client);
-
-	if (!IS_ERR_OR_NULL(chip->tcpci))
-		tcpci_unregister_port(chip->tcpci);
 }
 
 static const struct i2c_device_id max_tcpci_id[] = {
@@ -558,7 +557,6 @@ static struct i2c_driver max_tcpci_i2c_driver = {
 		.of_match_table = of_match_ptr(max_tcpci_of_match),
 	},
 	.probe = max_tcpci_probe,
-	.remove = max_tcpci_remove,
 	.id_table = max_tcpci_id,
 };
 module_i2c_driver(max_tcpci_i2c_driver);

-- 
2.45.2.803.g4e1b14247a-goog


