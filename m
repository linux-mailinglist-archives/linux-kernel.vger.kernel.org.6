Return-Path: <linux-kernel+bounces-343537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA5989C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D6D281117
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7717A58F;
	Mon, 30 Sep 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R5lf32x0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F26175D4C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683785; cv=none; b=E1lB1pawJSe+pI7/b+UeeLrnlafbcYKyKL0H5X+U/j+WG4VsbQZ00e2QrayZVahKeFYW4QUdketYPl8+pKCO9IM8/X4a2xLMb5+fhvfr0W3/HraReGmDES+aTPHtViZm/4KxBpn95j8WIgyo3CUOJmtog+fp4O1V/6iw1ej2Q1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683785; c=relaxed/simple;
	bh=eJWJ5O7IhSzIyCjxLeR9OylqZkh5gY0V+stMheEKz2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BU9aLH5IWmTkV7Ysh+UhbSjpb1W+OLaLtbq8zm7bZs1lmbk/N+sEieX6e4cpwNIVZo9c9GKresD0HLjbSGwc1Agqys4cNNThYQmHbTYv/ZrVFaUav9X3RasEUZDQuIAcMKJx4qi5UOGv2RfEFDQ8rwb8aWwz1r19JRoXM+Jryxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R5lf32x0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cdb6ebc1cso1187705f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727683782; x=1728288582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3cG+kWNy0aWF/w1xI6GPRKYc2TRij9cCl7c9R+dadU=;
        b=R5lf32x0rWEJ9SkjDTI9tNTFIfqZ4iBPKvcugL5mJPBg0cL1sCSAS6lXvNaUzRoggO
         RpHOeS1zHejl/AiB1MCs7RIdXC7sDyDOYX6Fa+wpOzbbLxK9yQtTvE2KjneceqVefSZa
         yqWqvw3FjtpDYURDvsETVSNXfFSMDJ1TgvjbYD8/+KTi4gPCisaX9tkqDzVgKYfbkmPJ
         rm6SltDAbTUhal1HJVksSGUQzlJrgxOgR3K4G/rSGgnyFVU+6b1chmrCazmm6IusggNS
         avCkPSmQ7RN4T30uxv8K7v5/xPCprxkKVXYj/1PhGcwS9Cyr2OrxpMKqCxmje5AZunUd
         /2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727683782; x=1728288582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3cG+kWNy0aWF/w1xI6GPRKYc2TRij9cCl7c9R+dadU=;
        b=tYEn14Scdnv1scM9rpw4/KwikWJfS2Q0mA7MjWqfNiXw6cRj8btaQA6iBMRulBYfUW
         Hqemv1W1g+mbGUpxlfNEbMsp87QDt+hzuR/WiE2iJq0O5rz8W6ywIDHyKtyFry0ohAiw
         8n2i3lgHRKg3afol4COe+xVmIjDsfjKAEjcPHCq4KGhZnKqIj6zAs2YGZVwno7vd/l5d
         3gAPCgPiHvAX9+0NS5eKILwvFpVvM/ThfepypAfM2Y2vzwJdXW6WFUzj5mouRztyA+Kc
         jr6VZadFgSCDmjiGGiyNswAfAZUllc4vJ7K+OqkewCRhrTs3Ajt7LvvJlOaJwGT8hfDb
         eb7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPjIqg/slVWPE/WqKStY1Z0JS1hLpIVFjxA0gLKTKxMS4TksTWAx7d1F7ZkKgypCQEva5MXE2ykvLfWaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MpeT6qAYIzV0avIIZAmgPAiA4IgOunuOtuQjAQgB2WfJcsjX
	++svyIvuGQDKokEIxBIAWmfx8ffUJbX0x+khfOzVmCmDlRxkyTYRAWOJHNcYsrU=
X-Google-Smtp-Source: AGHT+IGdNfSheQTh+ej2FO2pI5eUxUQadxS7l9tN6fT0khbGP+eIx+6Q+BdPZ4OvlzHCqNBKewtGng==
X-Received: by 2002:a5d:480e:0:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-37cd5b31988mr5870067f8f.45.1727683782297;
        Mon, 30 Sep 2024 01:09:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5742499sm8306463f8f.93.2024.09.30.01.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:09:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH] Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()
Date: Mon, 30 Sep 2024 10:09:38 +0200
Message-ID: <20240930080938.12505-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the new devm_clk_get_optional_enabled_with_rate() clock helper to
shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Resending now that devm_clk_get_optional_enabled_with_rate() is in
mainline.

 drivers/bluetooth/hci_qca.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 678f150229e7..ad40118c9f82 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2294,13 +2294,6 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
-static void qca_clk_disable_unprepare(void *data)
-{
-	struct clk *clk = data;
-
-	clk_disable_unprepare(clk);
-}
-
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2433,25 +2426,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (!qcadev->bt_en)
 			power_ctrl_enabled = false;
 
-		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
+		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
+					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_warn(&serdev->dev, "failed to acquire clk\n");
 			return PTR_ERR(qcadev->susclk);
 		}
-		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
-		if (err)
-			return err;
-
-		err = clk_prepare_enable(qcadev->susclk);
-		if (err)
-			return err;
-
-		err = devm_add_action_or_reset(&serdev->dev,
-					       qca_clk_disable_unprepare,
-					       qcadev->susclk);
-		if (err)
-			return err;
-
 	}
 	
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-- 
2.43.0


