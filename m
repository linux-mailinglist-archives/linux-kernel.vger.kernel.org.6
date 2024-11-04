Return-Path: <linux-kernel+bounces-395326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C40D9BBC61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E06282AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA4C1CEAAA;
	Mon,  4 Nov 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtXQIm89"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028771C729E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742637; cv=none; b=VvI8Ubi+egGMpC3YP+oHk0dskrKdOtxVjSNSIDRkX7eSGH8GZR+PVAzN67B+vQ73UVmT0U166sc4wUw9epwXL7YaIQ18BYigqs2aEk49PJpM1bfykdwYBfrBIJ75Sy3vCDS+tPCB3530YzhsrxVX3ny04gsHKOUImWXtyFHnVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742637; c=relaxed/simple;
	bh=pLnkhpeYKMc1lxFV3xV4m3dNh7n0yiuHjAX660xk0n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLpLNCenHAS6tPWSMeOUSfQxyt4mTIeFq4SAuCb2LQIHBTcRgp4Z9PCeUJUH4OnsMcQx1UlgoIbz4TJEFoAicG0WsxIOez+hN0+KZtU+FbSek6vqZHm+6zIhA3VLRBK6s9mFUImcdWjyW/FY0zIYcTH9mBFQ6pRnt5tJ42CC2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtXQIm89; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2591947f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742634; x=1731347434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4LeEghsieJmKHP01xof54mT4MI7YKin+O0LeMS7tsE=;
        b=YtXQIm89Tx0DBkALR60b71beL9sDmTWJLont7N8Vd25NzPipbJhN3l4u0fMxDVaXM4
         g+DMMM6DU/ubWnbl3Ve86BHdfOKKC3awYChNCZbXCcQlP7G1AkANc8uQiE4Hpd+HRXlB
         qaLF0GIHX/ct9v11dF1WAjfwWSXcSfKRwoVUlGQ+kb/uoxOIXifRUvf12Oc8U7N8I1WT
         9DsBJswbc3vlmWcdssoHzPtfO1bMVDlensKIDQ+X5I6vuc/KDCCoVA3f3CAI+67jzqXH
         SmFMllB6cB7Pmkcm6araoMbr6NGe0vB3SBOVVcWcqcUf0pAoGQ94opCXfHX7nxv+ENGK
         QODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742634; x=1731347434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4LeEghsieJmKHP01xof54mT4MI7YKin+O0LeMS7tsE=;
        b=aJwn0us1/BYuMSc0G/KtFM9lX7sooFEjrHZanfjMGGxT3KvQbBW98H4pOixaGfoq6R
         ANLnxYAsOZrwx4e7C9OrzW/b2Z642XTxCOJ970GpNMlPRhqePkrhvQbPhPVlEznvOk9i
         JmKIZMsGNtkH8UA4KworffDpicstWr9XtD5Bwjhws8f+PzwkqYVNaqswbI6L6rOggXo0
         GoAzFw1d8ZpRb5yHH7YcPOj+BmykOPBelbtGhs0mz2WvO2+RFfOWs6kWWHrGzQRN8Dqm
         VKAPIA6A4IE43OWUlfqKVyHo3MRRgYVTPLv25mtn3Gdq2Tz/VsD454ieDUWbaz3BhOFU
         +Diw==
X-Forwarded-Encrypted: i=1; AJvYcCWcXyyBLANtdqwJ5KJfLcgqwFxPQepo83lmKTcIQqI3D+VaBn+ljgqUjZbKg4PHIosyG0F3FQajblel5PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnyt/BKuuiaaRWLShZiODasgMYUhGKPiO2RD36JrM2AJ0IdYu
	RAR9+PUHUG93awLXn5btC7IwxqjfYTNLM/oGjMV7IyS+2osQO1k/
X-Google-Smtp-Source: AGHT+IGL8Hz6ldNQ7BGl+8qPvJkcLFeycE81fUs3UMeqJ1aqsq/l2/DaxtogxbGayXLaq0ktaorcQQ==
X-Received: by 2002:a5d:59af:0:b0:374:ca43:cda5 with SMTP id ffacd0b85a97d-381c796903amr9607821f8f.0.1730742634220;
        Mon, 04 Nov 2024 09:50:34 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:33 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 09/12] staging: gpib: Remove unneeded lookup table
Date: Mon,  4 Nov 2024 18:50:10 +0100
Message-ID: <20241104175014.12317-10-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>
References: <20241104175014.12317-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove bcm2837 table as the only difference is GPIO14 and GPIO15
which are not used with the current pin maps.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 33 ------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 8c03e91c01dc..fc8502379c28 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -234,38 +234,6 @@ static struct gpiod_lookup_table gpib_gpio_table_0 = {
 	},
 };
 
-static struct gpiod_lookup_table gpib_gpio_table_1 = {
-	.dev_id = "",	 // device id of board device
-	.table = {
-		// for bcm2837 based pis (3a+ 3b 3b+ )
-		GPIO_LOOKUP_IDX("GPIO_GCLK",  U16_MAX, NULL,  4, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO5",	  U16_MAX, NULL,  5, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO6",	  U16_MAX, NULL,  6, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_CE1_N",  U16_MAX, NULL,  7, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_CE0_N",  U16_MAX, NULL,  8, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_MISO",	  U16_MAX, NULL,  9, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_MOSI",	  U16_MAX, NULL, 10, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_SCLK",	  U16_MAX, NULL, 11, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO12",	  U16_MAX, NULL, 12, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO13",	  U16_MAX, NULL, 13, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("TXD1",	  U16_MAX, NULL, 14, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("RXD1",	  U16_MAX, NULL, 15, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO16",	  U16_MAX, NULL, 16, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO17",	  U16_MAX, NULL, 17, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO18",	  U16_MAX, NULL, 18, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO19",	  U16_MAX, NULL, 19, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO20",	  U16_MAX, NULL, 20, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO21",	  U16_MAX, NULL, 21, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO22",	  U16_MAX, NULL, 22, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO23",	  U16_MAX, NULL, 23, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO24",	  U16_MAX, NULL, 24, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO25",	  U16_MAX, NULL, 25, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO26",	  U16_MAX, NULL, 26, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO27",	  U16_MAX, NULL, 27, GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table gpib_gpio_table_2 = {
 	.dev_id = "",	 // device id of board device
 	.table = {
@@ -300,7 +268,6 @@ static struct gpiod_lookup_table gpib_gpio_table_2 = {
 
 static struct gpiod_lookup_table *lookup_tables[] = {
 	&gpib_gpio_table_0,
-	&gpib_gpio_table_1,
 	&gpib_gpio_table_2,
 	0
 };
-- 
2.46.2


