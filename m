Return-Path: <linux-kernel+bounces-242056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB5A928320
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE23B25DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B01474B6;
	Fri,  5 Jul 2024 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnx7+9Z5"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F4146A89
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165758; cv=none; b=EaTKoyoVZzFjCGCq+xeCRuZaxfYDGJ37WR6JRnn/XpLUumW3JsOGqkuGNDIPmKYJZ1N17fkcHT4j1vUBuEIiJAwZbOwFTAAIf9aEs1E1RQnX82nMyJzeFqx6M6UftNQtoXGPBZpAoNc8sjUhQ/+vRPEml74tpbgS98q8fRmeYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165758; c=relaxed/simple;
	bh=l/GxTqAD8seDDZ8vYnqY7iwINeLrU2wr+nQsZ3xxbR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaLDJ/bxoOxbwKrplR6kQp4nyQphpdLf7my6HCQ73Q9IfpWrXoFYBZ1xoaGxMKj+RUrT1iWKE3B9JIpOvAdeiawpkMnjDS6Zp+2FYb2d1Jt9ww7lFQrLDQzZalMEQgaPRiocC0Dx39KKlyMRC12kCuKlHB2AbXcn1kStPG9GmcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mnx7+9Z5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-425814992aeso9012675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165755; x=1720770555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o57SC4IYqYrnc2Cn5Q7DJYwc55Mhg5yPpsKF9dEPks=;
        b=mnx7+9Z5pqOfa9Pcy/0CyZGPAmAd4z82vzYIhIvFBYQ26X7jVtFLnazACF3IK/d/Go
         KevDKgOy+Mw/R5HpEC1wamz9UDl2EfLtUBIceOHDXZ7l0RGQWzPEn3Ol1YhTputgS6uD
         dDPiQKKwk9Rr1HvWT6ySpSKB56bqj5Hi9o7iX3HOThMf5Tszib2XeXzkUsMKXDdUFFF3
         G3joUQW3IwJPxyV1jOrzptszmL8UA757WUtrXDLpnDxbiNzp39CTYCHiNl+q5PrW2sdQ
         CLkuX7DdRSpYagsKjP+2tSedq1T45hihkGO8eSGQHgWstw4b3ZMk2wxi7+6E+u5M8x8f
         F+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165755; x=1720770555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o57SC4IYqYrnc2Cn5Q7DJYwc55Mhg5yPpsKF9dEPks=;
        b=LPPZOfd+TAW9xotUqlKFp3aBgfCN1QS6VylB2MgUECWE9chXwTA4ppagUsU8IrLLyf
         RqDZuz76XzN43iNqqoLOxxDIk8d4CAr6SZMVEM5PN3u+9/6H3NUcf53jwuWFh8Gozpce
         ZfTkK9B14jqkkVvzOKRTsCPUpy++gzeuwtmwEXZ6rMsTxlmP7My/gxdrn7kO2xsmFCab
         eAOXY+sFAzYRV3akk3B1cQYJsPsmHvh0XojUnH12ZRn4RokoJFo1Fz80QzlNl4st2cAW
         Ezwb+sLPoPywreyZ5/rm82QoQnxpfuF/5kwb2ZJUnII/r3UqVcuedMc1ddUzKd5jqVsE
         d9Kw==
X-Gm-Message-State: AOJu0YxZoqRCEdOmWAF6Om9y82dv00NozTX5JC9+vooGEiVTm3F9DFFb
	mdClCK67oFn/rev6RuIMXtD9+seGq4KBbFexnPTd9+vwynB8kE14b2vBqD8rgNOyuzK1TtkCcBf
	RMig=
X-Google-Smtp-Source: AGHT+IHcuyo1M2IjZX4Vx/+gzVUv8+/FrtO2jqQ983Kw/BI7ioW39feDy97kjAVcvTBtPCEh6DN0dw==
X-Received: by 2002:a05:600c:4608:b0:426:5269:9827 with SMTP id 5b1f17b1804b1-4265269994amr5901905e9.0.1720165755554;
        Fri, 05 Jul 2024 00:49:15 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:14 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/15] nvmem: core: add single sysfs group
Date: Fri,  5 Jul 2024 08:48:46 +0100
Message-Id: <20240705074852.423202-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

The sysfs core provides a function to easily register a single group.
Use it and remove the now unnecessary nvmem_cells_groups array.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e1ec3b7200d7..96e76d88204c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -367,11 +367,6 @@ static const struct attribute_group *nvmem_dev_groups[] = {
 	NULL,
 };
 
-static const struct attribute_group *nvmem_cells_groups[] = {
-	&nvmem_cells_group,
-	NULL,
-};
-
 static struct bin_attribute bin_attr_nvmem_eeprom_compat = {
 	.attr	= {
 		.name	= "eeprom",
@@ -478,7 +473,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 
 	nvmem_cells_group.bin_attrs = cells_attrs;
 
-	ret = device_add_groups(&nvmem->dev, nvmem_cells_groups);
+	ret = device_add_group(&nvmem->dev, &nvmem_cells_group);
 	if (ret)
 		goto unlock_mutex;
 
-- 
2.25.1


