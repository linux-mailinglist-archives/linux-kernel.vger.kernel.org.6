Return-Path: <linux-kernel+bounces-222962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E437910ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6E41F22414
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD01B141D;
	Thu, 20 Jun 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FRLLkwlp"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38622616
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899252; cv=none; b=Be1gjR1PkAeU8BxAN1lvbSJ4sViQmAnRxLoQU+hTWOThTVNWwKh1riVlx4YML17kdGNiP2BK0k4LqCmfWY0YG30JnPUrKpMUFYHS3O7EIv8LLaaTLsf5uuuOh6KNb1nf5EPrZhWOh6Tly6HNYOShn+59k/00eAB/S558We7OzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899252; c=relaxed/simple;
	bh=Gcc362eWY4n7cee3vta15eZnYNy4hpzoodN7rfnx8iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/6ZLokfQ8pqxOb651rT1sWiO4W++mBFEUiEpZXAbsqZ/TuNPB/docz3qBbXZqI+lyDvIO1U8MHNeTjgq4vTfB4tFrH0X2f8t5sP/dWVOCzKR7n7qM5kQDx0x7aNewhCblq/QJ865PY79+BqUNticr0FpH9pRvxOzaAwITRv/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=FRLLkwlp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718899248;
	bh=Gcc362eWY4n7cee3vta15eZnYNy4hpzoodN7rfnx8iQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FRLLkwlpcpslOZukBJLio5kOSWuu5xS/87GPBRpd6/b3i/JW3C72uUDBRO2IhEl59
	 YDOJBQFQS9PJklSIlZua3ktboEP9UgVSrm6K55XeVZGskRghK/qqJ91tO3He9+u908
	 ix3rp5UEo0PhCIt0+F4MGXWZU86BVJcZi8GMYG9A=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 20 Jun 2024 18:00:35 +0200
Subject: [PATCH 3/5] nvmem: core: add single sysfs group
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240620-nvmem-compat-name-v1-3-700e17ba3d8f@weissschuh.net>
References: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
In-Reply-To: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718899247; l=1061;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Gcc362eWY4n7cee3vta15eZnYNy4hpzoodN7rfnx8iQ=;
 b=k5tPyOOf3DWI19Iaj7k9jRfYSvnjEW9m0Bul67LGz+mlhIeeJFyl4nQrHuaRqQfyOvA+09nF1
 JrgPEHQtEAlB5ZAB2GwgxCygWFIJUppkz/5lFI3BfqDDiYnetAXfKQl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core provides a function to easily register a single group.
Use it and remove the now unnecessary nvmem_cells_groups array.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/nvmem/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d74297d10631..4c250f0e55ef 100644
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
 static const struct bin_attribute bin_attr_nvmem_eeprom_compat = {
 	.attr	= {
 		.name	= "eeprom",
@@ -477,7 +472,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 
 	nvmem_cells_group.bin_attrs = cells_attrs;
 
-	ret = device_add_groups(&nvmem->dev, nvmem_cells_groups);
+	ret = device_add_group(&nvmem->dev, &nvmem_cells_group);
 	if (ret)
 		goto unlock_mutex;
 

-- 
2.45.2


