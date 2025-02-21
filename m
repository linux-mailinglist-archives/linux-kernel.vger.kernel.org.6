Return-Path: <linux-kernel+bounces-525074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26263A3EA79
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB50189F0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2911C54AA;
	Fri, 21 Feb 2025 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VBR0hibT"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803270807;
	Fri, 21 Feb 2025 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103143; cv=none; b=XtszO+NbklXXRkGmVV1Wr/cLKnoj4KDctP2tyehRwAYgdmfcIWBxk2Gzk9g9tLlTvJ4LJBbG92FTRe9pwGebSKFsfzdtktlgRpMAhoE1/p7J5fBbK/hEV55m/P1Dh1RuwFYsdTTu3GRYOdi+yIR7y9PIXYdcqmSYqUhZ7Gsfb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103143; c=relaxed/simple;
	bh=dUz0fpj4eh0Jt7r7t7HQFUH3p+7TbTBQkoQ2o8zwkvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGP1htk97Jor2iAeI4eFgHLXzy4cUy5e9QOj1JNYwMYIPA/84TtTXyipcHxsgrOeOsM980Zr3fj5i9YmhNbHRtKa+8zhfSz92NIG8nnp9DawjMv4qGEu5kYlxlAjcFubx3RwLE19GNGZ+BTFZUT9FDtI9mc8iqR96nxtW+kmKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VBR0hibT; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=RE0swP2Wzvc6B+QYeA4rhrnC6HXoz4kWy/36+4IfuYw=; b=VBR0hibTWhUyTxjc
	pMtwBGTU/TEeatl19chew+QciXIGXH+lnevC4EYQxFxPT9YWlzC92O51zAufRWoNz8gJnWnRIStY9
	VcXELw/k5+fVInHMuFaM75LBzWwQwsTDpuvvFKr2RkcZAycKNAbYl8KcI6q9Br+yOAfcxeeKd0CTj
	NKKGdtYGaBEaJuAI0tr3Agq4UALUIPpv/90YfD0uKfQBihbBMMgkzRr+5mRNA//4rUSH7InJ4LKd5
	DVa6oiqTYlEo6SrdyF61kyA4ZNjyA/9CzjikXKIeRpYzlzOmblzsWJtxdz0vRF/qGNuWunxz4l/ep
	0v3Rjm4WKevbzxZm4w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tlIJP-00HM47-17;
	Fri, 21 Feb 2025 01:58:43 +0000
From: linux@treblig.org
To: srinivas.kandagatla@linaro.org
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] nvmem: core: Remove nvmem_(add|del)_cell_table
Date: Fri, 21 Feb 2025 01:58:40 +0000
Message-ID: <20250221015841.209458-3-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221015841.209458-1-linux@treblig.org>
References: <20250221015841.209458-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

nvmem_del_cell_table() was added in 2018's
commit b985f4cba6db ("nvmem: add support for cell info")
but remained unused.

nvmem_add_cell_table() was also added in that commit, however
it's last use was removed in 2022 by
commit 2af4fcc0d357 ("ARM: davinci: remove unused board support")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 Documentation/driver-api/nvmem.rst |  2 --
 drivers/nvmem/core.c               | 26 --------------------------
 include/linux/nvmem-provider.h     |  5 -----
 3 files changed, 33 deletions(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 595ee207d199..27534d5e8fba 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -76,8 +76,6 @@ nvmem_cell_table struct::
 	.ncells			= ARRAY_SIZE(foo_nvmem_cells),
   };
 
-  nvmem_add_cell_table(&foo_nvmem_cell_table);
-
 Additionally it is possible to create nvmem cell lookup entries and register
 them with the nvmem framework from machine code as shown in the example below::
 
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fd8f148b8aad..90fbfc00950e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2069,32 +2069,6 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
-/**
- * nvmem_add_cell_table() - register a table of cell info entries
- *
- * @table: table of cell info entries
- */
-void nvmem_add_cell_table(struct nvmem_cell_table *table)
-{
-	mutex_lock(&nvmem_cell_mutex);
-	list_add_tail(&table->node, &nvmem_cell_tables);
-	mutex_unlock(&nvmem_cell_mutex);
-}
-EXPORT_SYMBOL_GPL(nvmem_add_cell_table);
-
-/**
- * nvmem_del_cell_table() - remove a previously registered cell info table
- *
- * @table: table of cell info entries
- */
-void nvmem_del_cell_table(struct nvmem_cell_table *table)
-{
-	mutex_lock(&nvmem_cell_mutex);
-	list_del(&table->node);
-	mutex_unlock(&nvmem_cell_mutex);
-}
-EXPORT_SYMBOL_GPL(nvmem_del_cell_table);
-
 /**
  * nvmem_add_cell_lookups() - register a list of cell lookup entries
  *
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 515676ebe598..20c9fbd45b24 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -190,9 +190,6 @@ void nvmem_unregister(struct nvmem_device *nvmem);
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
 
-void nvmem_add_cell_table(struct nvmem_cell_table *table);
-void nvmem_del_cell_table(struct nvmem_cell_table *table);
-
 int nvmem_add_one_cell(struct nvmem_device *nvmem,
 		       const struct nvmem_cell_info *info);
 
@@ -223,8 +220,6 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 	return nvmem_register(c);
 }
 
-static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
-static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 static inline int nvmem_add_one_cell(struct nvmem_device *nvmem,
 				     const struct nvmem_cell_info *info)
 {
-- 
2.48.1


