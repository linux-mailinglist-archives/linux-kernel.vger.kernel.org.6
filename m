Return-Path: <linux-kernel+bounces-242057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E95928321
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDED1F24978
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0535147C9E;
	Fri,  5 Jul 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNp3kadu"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB1146A70
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165760; cv=none; b=r6RQbV9zqLuMOHGTLYs7injtIROIZUMJn7Q8rtZsPMn4fweChHvbUnWh8BabIYehEgUGFo6SEMwnSu5ev74SJsKuAz0Cl9pf+fktippbRKQiZ8ZP3nOhJI61+fPvXPFhA+aHct5gxO4oLi1/Kn2cim+PQP+QGcx2pTy9Kgp7SkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165760; c=relaxed/simple;
	bh=kxUFx2Wg0lOziGZ8gs8uQqXjgNWaCXYxeGI3anasKfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxmWAO7oV9Ngrw1BXMtpE3y7N9X1Sgslje1zJH9F6GEpkGnp01R1bnfY8OpvCHahyYVwKQK0vmiLZSQFlY0mNSj/2qA4r5AEQpYE9gQy7WecJ05F9cMZZsGLzoX4IDlHFL+JyG2vjy4Q89rihQJ9tyQ079sEtVN9Cz9oBgzjkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tNp3kadu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4265921b0f6so757185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165757; x=1720770557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RE6L8u2/CCq/4WbIyqTEWOTaRPez1DDZwQksX4yhO4=;
        b=tNp3kaduy5uK9mUj5Tez+++5GbbYNNCAjBqjE+Z+pUBM0nreslcX5KBhnIF8Qnj7jo
         yI7Cta11IiODphF27b64jWYsyeEWtIyeCr5mWJr7DXaNJrRNSmTk9zQbv9W0sMV3QB3X
         CPYNvXWIDkxAt80p7vyVy6i13Q2v+jc+R6eizakAOwgOE3gmNVNiYx3zi1FVyibRyswY
         +k0N06KZF1he7KYByuU+UY832QO5CR6yC0UKyWHqzy5TNPnp6BfzbjlvpsYneBHeb92+
         1pAM9ztVjWWyaGU8LPm0uVGNUoudi/hWwwrZCXlSm7YLOOUU0Ma6om9wbzy2JHSqscLF
         apgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165757; x=1720770557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RE6L8u2/CCq/4WbIyqTEWOTaRPez1DDZwQksX4yhO4=;
        b=m3RYblBQwL52ielcHMVaoCnJ6SsAH3NGMsFZhaNUK9D0lPFhlReOmTB0ZMCCj212wu
         DjrEnMeFZaEueqtmHiWSg2LTXzSBvE64i40GUgCY6Ir9+tUndbkLPT3IaEQ7qYgYagTN
         ZriialgmE2Dx8QBntueIxT3uI0I10w5dFENw9McIprDbHbzPmvZMU+EdR0KFUD5ettYX
         PgdiIY4RVPoHgjz+9c887LbpwQRN7oOiildg9UfwuXXhJe/DxXXCIqmov8MJXv/MUJo9
         i1eLrMO6142wCGySX58EpME/jTUQ6UtHOyxX9+P9lNJRmV3P7LKPO2nqPKpfQR/jfUUY
         ZL2Q==
X-Gm-Message-State: AOJu0YwhLdUIwJgeErF2vUIM9qzaf7gqPzUqgdgkbziprWwVQDANaMz5
	DwsKOxcldlMKtWZSWc6RLPw3loTzgDT/vGHNTTB6rxOnUhRwDJsUp+GPalJRqp5nA0ikWYGrOMY
	+yxY=
X-Google-Smtp-Source: AGHT+IGm5C5VvdfepkDvB2LTv9P3biKt7tC7F1iN+qzIjSdkHN/IRSEDlolRAGsVfpFf0bH1WAsQsw==
X-Received: by 2002:adf:fc49:0:b0:367:89d5:e440 with SMTP id ffacd0b85a97d-3679dd24f66mr2336507f8f.20.1720165756869;
        Fri, 05 Jul 2024 00:49:16 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:15 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/15] nvmem: core: remove global nvmem_cells_group
Date: Fri,  5 Jul 2024 08:48:47 +0100
Message-Id: <20240705074852.423202-11-srinivas.kandagatla@linaro.org>
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

nvmem_cells_groups is a global variable that is also mutated.
This is complicated and error-prone.

Instead use a normal stack variable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 96e76d88204c..015e6b9e0b60 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -357,11 +357,6 @@ static const struct attribute_group nvmem_bin_group = {
 	.is_bin_visible = nvmem_bin_attr_is_visible,
 };
 
-/* Cell attributes will be dynamically allocated */
-static struct attribute_group nvmem_cells_group = {
-	.name		= "cells",
-};
-
 static const struct attribute_group *nvmem_dev_groups[] = {
 	&nvmem_bin_group,
 	NULL,
@@ -424,23 +419,24 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
 
 static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 {
-	struct bin_attribute **cells_attrs, *attrs;
+	struct attribute_group group = {
+		.name	= "cells",
+	};
 	struct nvmem_cell_entry *entry;
+	struct bin_attribute *attrs;
 	unsigned int ncells = 0, i = 0;
 	int ret = 0;
 
 	mutex_lock(&nvmem_mutex);
 
-	if (list_empty(&nvmem->cells) || nvmem->sysfs_cells_populated) {
-		nvmem_cells_group.bin_attrs = NULL;
+	if (list_empty(&nvmem->cells) || nvmem->sysfs_cells_populated)
 		goto unlock_mutex;
-	}
 
 	/* Allocate an array of attributes with a sentinel */
 	ncells = list_count_nodes(&nvmem->cells);
-	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
-				   sizeof(struct bin_attribute *), GFP_KERNEL);
-	if (!cells_attrs) {
+	group.bin_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
+				       sizeof(struct bin_attribute *), GFP_KERNEL);
+	if (!group.bin_attrs) {
 		ret = -ENOMEM;
 		goto unlock_mutex;
 	}
@@ -467,13 +463,11 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 			goto unlock_mutex;
 		}
 
-		cells_attrs[i] = &attrs[i];
+		group.bin_attrs[i] = &attrs[i];
 		i++;
 	}
 
-	nvmem_cells_group.bin_attrs = cells_attrs;
-
-	ret = device_add_group(&nvmem->dev, &nvmem_cells_group);
+	ret = device_add_group(&nvmem->dev, &group);
 	if (ret)
 		goto unlock_mutex;
 
-- 
2.25.1


