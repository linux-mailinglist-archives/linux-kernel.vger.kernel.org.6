Return-Path: <linux-kernel+bounces-233803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFDF91BD9A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07F82857DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9462158859;
	Fri, 28 Jun 2024 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmzYwaw2"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6B156C65
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574636; cv=none; b=VzPDHv37Fa/3XIxufX4wzCZLJCvTXIbBZG0Xx4uj9WXVxCJnkDu7TGddFsyt9jch8AmI4cOJ4aqqJblbZtk1CESKXiquThC1uUOOxNrtyW9DL1Dilj/zoMOgKzbKRmp0wDo4qUnRexQAFLPGd5pIWckI90uGFw+VgQuESTUHvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574636; c=relaxed/simple;
	bh=ye6FSQS/NKpcJzutp03vkmto5rrZ7PNX1AcZMkv0NpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dj8H1ghtNbmitQviyyMENLsmZXDc27UhYyNh4h5WM5iAuKgiAY/08K9IjuvZ5U4SJVpejnjiWFfhOBwVMVpCnM04SY8hOY4u/zjIxzyD9eFAT3daonl8ultdRRSevkmKK5RXOAJb6X4ZvpONDI5hIsSH8Le9D/hb3YGgUGe18OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DmzYwaw2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42562fde108so4626525e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719574631; x=1720179431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dllfp3FX/5YC/zss7njE9Wc54i5SAUNqTlCZuQW2zLE=;
        b=DmzYwaw2xUgSvCDAvmLXW7CPP3rcRSemkJTBvJouieSyjZzVKZWBhBJRn3TXBvT/JY
         guuZANHYJVoITlnrOWKlFt5rG2hUpXweTIA+cwv56MOsKkEBwRfxVUdvp5F+UHmXWITn
         kutoY9FwRO4bJara2AaYeBA8twHvgM2eEIP65K8ZqplilyKXsNxcKlnTyoSHpMQPHhwy
         pVxFeRAjr4aLiJ0fdwp4Qh3kBtTYd2AO7NzYb6lLu/H5TdNKusqwWPXPi4328h0goG3z
         +kW4UXUnNCwphvZ+dZ7yAvZoC9srMRDGORXgaOTGp2jWbyodu8gOh5BO3/GsvasxMCTP
         7jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719574631; x=1720179431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dllfp3FX/5YC/zss7njE9Wc54i5SAUNqTlCZuQW2zLE=;
        b=q1ihVnHk5DzUZo0A+oruQVEBKBT3nJA+VtYZxNGpwBgxpQbhoS/6/SN7vRKEciPUy/
         fSPMxV4k7GwokCwqzD0OCu1orY9aQfr9ZsdTbIz9ffEU4O0oOUPR01sIb5lz3Cf5FJZE
         OdusH89DZZNLk0hexyvGTfxTpJxPIGaePHqFO77zdhnWOw5Q9RUWXN7nXCTqsaeedIeN
         M0SrrsDnc8MZJasHs+m81DVuRY2CATjzZEQxVs+F/Zh7FAyisgKb+mUBf0cT4IDfIgz1
         RLxvwlS8sdhf3M57BBsfBUZgwH9m28Q0IgPhuKaNpiIFvd9h1FL3AIHduyH8F+xUi5Yz
         d3nw==
X-Gm-Message-State: AOJu0YzenPovMmeXUgGkh2d+BQbVtu6pKTVGoY1xLXY/BclYfRTbz0eg
	MfQfZnzLwLEQYpJztM3UjY7If4RFrCAsOIkrlYFRxcFVGND5cgNt09A2i0jaY38=
X-Google-Smtp-Source: AGHT+IEP8mJtr2lv0WyW5t8xLXDlcpnPJ7I1nJsFkBFMY1oOTNaTcrHwH+OH4b6EySrpeAIuc5h5HA==
X-Received: by 2002:a05:600c:11:b0:425:6bea:8554 with SMTP id 5b1f17b1804b1-4256bea85ccmr13302165e9.27.1719574631518;
        Fri, 28 Jun 2024 04:37:11 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba5asm2048937f8f.71.2024.06.28.04.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:37:11 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] nvmem: core: only change name to fram for current attribute
Date: Fri, 28 Jun 2024 12:37:03 +0100
Message-Id: <20240628113704.13742-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
References: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=13iG1hG1MVP/pselTNqSmavmAZ1CPaJ78TUQIlJ1yGI=; b=owEBbAGT/pANAwAKAXqh/VnHNFU3AcsmYgBmfqBT+Em9xCEa/qzMWYgKZcaUN5HhiHE7IZ7SG u8x0i+hVciJATIEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6gUwAKCRB6of1ZxzRV N8ToB/dXE+xVIc6GnZPcsWPb/lhvpTL21aR57RHEvfNxHSbmruA24nYginOnvL+gts3KVBRoQcN oQ1tGr1HHc38SWuZRlKOnhPsAL0vUSbsSHI5sRleisOjXF+DJpYeermvcCY8yUqGnKgeWyqYdHD 2ago7IDeH+HXdMeRnz/OGDT0XQC/4/lSMdb3qor2pUWznpFb/Hhfrl8RtbnD1RmMmbJOxgY6OKn Ez3Zq3IBOkh2i+giS3u4+pW9/EdwfugCtmh7c1z8R2+K0YVTfBGzqZbf5KxtLgX/LRYkpU/bVBl Q0+OQ0DwItpB1DuM8wcSQgy1BxVb0mU9iCyAKekJvTa2mEk=
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

bin_attr_nvmem_eeprom_compat is the template from which all future
compat attributes are created.
Changing it means to change all subsquent compat attributes, too.

Instead only use the "fram" name for the currently registered attribute.

Fixes: fd307a4ad332 ("nvmem: prepare basics for FRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e1ec3b7200d7..1285300ed239 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -396,10 +396,9 @@ static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (config->type == NVMEM_TYPE_FRAM)
-		bin_attr_nvmem_eeprom_compat.attr.name = "fram";
-
 	nvmem->eeprom = bin_attr_nvmem_eeprom_compat;
+	if (config->type == NVMEM_TYPE_FRAM)
+		nvmem->eeprom.attr.name = "fram";
 	nvmem->eeprom.attr.mode = nvmem_bin_attr_get_umode(nvmem);
 	nvmem->eeprom.size = nvmem->size;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.25.1


