Return-Path: <linux-kernel+bounces-228667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173EE916531
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40BEB21D84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2314A0BF;
	Tue, 25 Jun 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L/DsslZ1"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E7146A67
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310918; cv=none; b=Cjh9OzJf5NENTEE4faXF3h2zXYsjwHgVXSdUki+FrOwMDgIC7xfKeJJhM2Nus8cn6s4Mi5jWYioQ46ihdEoLNJSpMiYLT7YzK28mHSJbZpB1ygWn58rhJRSAGyMSoG9vTGY5/0qlZBtb+zRyQ1VHoKLoAhPVh8SSx6Of+h4+uJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310918; c=relaxed/simple;
	bh=7eV+FC8D6zjFgWnptjlUDQlEzJ1ee9CaqujklxBCwc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bue4/4fna3pfOr6sCqjiCxAVjeh6I/eo2T6hSYjbmVjW60bGz+QloiBrjxRbblIAF0Bk93g0+LjdxvPb5JHpngInNA0T7lOTSVv5mTnJKe6vgjYsqzU7HzXeah6skIDvdJwzp4pY7cQgnjgA2HYbRW9c2Ty+l+ZlrXGMCgQBb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L/DsslZ1; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1fa2782a8ccso16214785ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719310915; x=1719915715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+VjACVZoPp7eN7kJksXj5MfvnAImL5JxKUjwBijavO4=;
        b=L/DsslZ1xJ/RcgZWEc4OFvYGI9wRjWwxXzhejYpuLjnS7POewgUElXfrxZntPaE5PR
         Ja3ClYsYtcgZ2UkoK0N5VbfR64dV/slOPgJerqFKlo2IhArYLZ/sAOoHUAK3wP4gOSlB
         H/qSzk0q5H8BZy+UeSGvfJiem4mYTBKsDUhbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719310915; x=1719915715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VjACVZoPp7eN7kJksXj5MfvnAImL5JxKUjwBijavO4=;
        b=VIFcxW/JXOhz37fxJbt9qer25Dhj43JOQu/HMUToFYjpoDqxsCdf39ehqy1EC3pWDx
         SO8f01nN1KyiPIAYqTo7PSPnE421kSjkq+2nyKj+Nly/nxk0muREn60rPsVLvErIY+k+
         ydhB42e8+o+RzB+/bLGB6hBTqnU5kz+iGfPJZ5X1alGy+55YN4Q1Anm3AT4fHHe+TU1o
         jTTu1YOqobHqVbhFwLV6zFWAOCKsAfHbvGnx/zHO2spcr4n7uFLD8xS5bwLPRkkjBXgQ
         cEXIRK+on69ooQBY1yC005L6dM4jtu8R3FGpnFLgnld1CtNM1DIqCI2fENgGrOn761l3
         DAzg==
X-Forwarded-Encrypted: i=1; AJvYcCVQuDmWYSvP6tVncBYmVZ7cRamY8J6994BqQ8DsHUYCvgW95LXmByUNbvEbJw4MjwGQ1FujHAbh7T4iN6MXAAZoUvKq7yN0lEDIJBO2
X-Gm-Message-State: AOJu0YwZApIs5mK+io+h4zN0oynvcw4yyeWb0J15ASPWO4tvLE451x7A
	1Eu+PUC1OJ7uxJ/4srzpk2JOXE/dc8YqV7D+dB3JLZ5ibfP0a49RVQIq9D01RA==
X-Google-Smtp-Source: AGHT+IGncBwvYK00pVmw01gvxPmXxXQ/V/u6BoVJ3vRhjdCIb8ngRmdVTYU+9aqp9QEJNIvJV3icOw==
X-Received: by 2002:a17:902:d50b:b0:1f7:4ff:d03 with SMTP id d9443c01a7336-1fa23f4a0e0mr73386365ad.67.1719310915385;
        Tue, 25 Jun 2024 03:21:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ea5a:67dd:bd1e:edef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb328f57sm77590855ad.110.2024.06.25.03.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:21:54 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@kernel.org>
Subject: [PATCH] Bluetooth: btmtksdio: Lookup device node only as fallback
Date: Tue, 25 Jun 2024 18:21:45 +0800
Message-ID: <20240625102147.3496597-1-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the device tree is properly written, the SDIO function device node
should be correctly defined, and the mmc core in Linux should correctly
tie it to the device being probed.

Only fall back to searching for the device node by compatible if the
original device node tied to the device is incorrect, as seen in older
device trees.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This follows up on the MT7921S bluetooth binding and DT fixup patches [1].
This should not be backported.

[1] https://lore.kernel.org/linux-bluetooth/20240412073046.1192744-1-wenst@chromium.org/

 drivers/bluetooth/btmtksdio.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b4e560a17aa6..d81fa8dacb4e 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1330,6 +1330,8 @@ static int btmtksdio_probe(struct sdio_func *func,
 {
 	struct btmtksdio_dev *bdev;
 	struct hci_dev *hdev;
+	struct device_node *old_node;
+	bool restore_node;
 	int err;
 
 	bdev = devm_kzalloc(&func->dev, sizeof(*bdev), GFP_KERNEL);
@@ -1413,13 +1415,24 @@ static int btmtksdio_probe(struct sdio_func *func,
 	if (err)
 		bt_dev_err(hdev, "failed to initialize device wakeup");
 
-	bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
-						     "mediatek,mt7921s-bluetooth");
+	restore_node = false;
+	if (!of_device_is_compatible(bdev->dev->of_node, "mediatek,mt7921s-bluetooth")) {
+		restore_node = true;
+		old_node = bdev->dev->of_node;
+		bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
+							     "mediatek,mt7921s-bluetooth");
+	}
+
 	bdev->reset = devm_gpiod_get_optional(bdev->dev, "reset",
 					      GPIOD_OUT_LOW);
 	if (IS_ERR(bdev->reset))
 		err = PTR_ERR(bdev->reset);
 
+	if (restore_node) {
+		of_node_put(bdev->dev->of_node);
+		bdev->dev->of_node = old_node;
+	}
+
 	return err;
 }
 
-- 
2.45.2.741.gdbec12cfda-goog


