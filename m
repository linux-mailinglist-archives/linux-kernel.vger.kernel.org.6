Return-Path: <linux-kernel+bounces-222963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CC4910AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8113D1C23268
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABFC1B013C;
	Thu, 20 Jun 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="g0XlvPs9"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E01AB8E0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899252; cv=none; b=PbLI4J75bLulAoRv22/xF03LP0k3Ki5YlKgzTbxUkxluKEkcIfxGsd9akGW0fattBzeB7EIF+UFJYCP/D3+5A8DvXgPUqOk9lJv310uu+U0fBbQpoQ+RhWwMsTwxvnzyueb3DOsNiNZm98XRVL+kwHVTyMDUN4/edXI+0zG6kZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899252; c=relaxed/simple;
	bh=N/VZfFN6kZVrxoszRPwVjrlv9D+r7XRzwq1GlkpJB5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGUMQGtGTBaGc3WndVg7jazwwVUHMHFeo0tCQqAXEuEZYSyRnM8W1HTuT81iOGI5Hjh5YcCsnqeFyDWTG63Rc+jVwBps7dHcHfXqtJQQX8NamOSpOAPOUSoEGVFAUuO3oIIbMWBj5WJolBkvk8AO4slXumehaPyxnxpNz9pI+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=g0XlvPs9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718899248;
	bh=N/VZfFN6kZVrxoszRPwVjrlv9D+r7XRzwq1GlkpJB5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g0XlvPs9AXa9H7LVGo4+11T0Z8D0DiBxmtiK/8thbXQ1gLM7dW372zhZ5SwD7R0fa
	 TKqn7C+T1TJeqkSCREdIUp0OfQeI3aukbIw1RMd4Tme9dAZ0sfESfd/BszdGRJyiDY
	 VoQNi6YgcpdLDIYjLshpjXpFhOgbzD85qLop9Jvg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 20 Jun 2024 18:00:36 +0200
Subject: [PATCH 4/5] nvmem: core: remove global nvmem_cells_group
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240620-nvmem-compat-name-v1-4-700e17ba3d8f@weissschuh.net>
References: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
In-Reply-To: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718899247; l=2306;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=N/VZfFN6kZVrxoszRPwVjrlv9D+r7XRzwq1GlkpJB5Q=;
 b=TtReZlujBvg3HGVHYyMJYKG/n4kcvHbufhUhT6l65J56AfPOkvcyG9F9ZsjWoIeCigt54GSzE
 +/f+SIDCv19DoxRvb0O3QPEkJRKyoCOVQVoQzpzcNiu/elRtAE+D1S4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

nvmem_cells_groups is a global variable that is also mutated.
This is complicated and error-prone.

Instead use a normal stack variable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/nvmem/core.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4c250f0e55ef..ed077d7e3998 100644
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
@@ -423,23 +418,24 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
 
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
@@ -466,13 +462,11 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
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
2.45.2


