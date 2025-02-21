Return-Path: <linux-kernel+bounces-525073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30242A3EA76
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B089189F7F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7291D5CC2;
	Fri, 21 Feb 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KdgEbwD8"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6E1C5D62;
	Fri, 21 Feb 2025 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103136; cv=none; b=YAgMWLK86WU5ZtyCDViOxCELiuuDPk3LZ7nba/rKHseRN9CTxr1fnyCq57pIj5GUEWO4Zb4Xd0KpjwSvZ8KdD6OD5S6T9xU8e6wcFGhT1rtVs9DQcAPq/YaLvUpzERjL02er9NBbL55w87Uce6ADyw2uYHL3eh14AetP4O+NJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103136; c=relaxed/simple;
	bh=kuwZAXnDhi8oFxJ4zGb0CaKAYDBPUHWegyZNj4qPq+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isz+HffM2v1VIq3afR3Qm+F3GF3Gi5yIXQ4aDMQvVf4nZMdSmKbg30PEtovm0dh2/oqSQx4stKWlM3Whh2eeSH2ibZW2MbIOnWpWkdqIEzheRSHzVNgTO580LynCztZW7jxi8qtyZVm95qSM6Eo4dxAe7J5CXYEvs8gJm9MoNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KdgEbwD8; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=m/jE4qIhnC6caQFA0Xtcbb7PC0pyypEHQD9ahc627P4=; b=KdgEbwD8Zph91Yf5
	g4qFvENAQOp8G36a/PQSAWnxZOWNF09hm79KPwBuaJy8HZy3IyBDuvTIoYUXsNyyYLtxyJvhNTpur
	kCMcyvxrCDEU6eNLU+bWbzeLF0/ni1QxtAt3ApFJMoEW3d2fUm8NSA3uoFlnMwanlBDFicXrDYJsW
	r1t/93gJlLgxvm/4ZqUdUfvx5Zo9r8Za5G8jlo4L8563O9CdidRC0QXroE4YEcpepvypAMjkEqEmB
	cGzIhcS1jFYBB+P9Er/elxriig37GffBQBTU2yKJLlUjPkbPHGJCYSqc0tAd0AANITTioVosR6rmG
	yByvsxeRQaW4apcUFQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tlIJO-00HM47-2M;
	Fri, 21 Feb 2025 01:58:42 +0000
From: linux@treblig.org
To: srinivas.kandagatla@linaro.org
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] nvmem: core: Remove unused nvmem_device_cell_(read|write)
Date: Fri, 21 Feb 2025 01:58:39 +0000
Message-ID: <20250221015841.209458-2-linux@treblig.org>
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

nvmem_device_cell_read() and nvmem_device_cell_write() were
added in 2015's
commit e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
but have remained unused.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 Documentation/driver-api/nvmem.rst |  4 ---
 drivers/nvmem/core.c               | 58 ------------------------------
 include/linux/nvmem-consumer.h     |  4 ---
 3 files changed, 66 deletions(-)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index 5d9500d21ecc..595ee207d199 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -132,10 +132,6 @@ To facilitate such consumers NVMEM framework provides below apis::
 		      size_t bytes, void *buf);
   int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 		       size_t bytes, void *buf);
-  int nvmem_device_cell_read(struct nvmem_device *nvmem,
-			   struct nvmem_cell_info *info, void *buf);
-  int nvmem_device_cell_write(struct nvmem_device *nvmem,
-			    struct nvmem_cell_info *info, void *buf);
 
 Before the consumers can read/write NVMEM directly, it should get hold
 of nvmem_controller from one of the `*nvmem_device_get()` api.
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fff85bbf0ecd..fd8f148b8aad 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2011,64 +2011,6 @@ int nvmem_cell_read_variable_le_u64(struct device *dev, const char *cell_id,
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_read_variable_le_u64);
 
-/**
- * nvmem_device_cell_read() - Read a given nvmem device and cell
- *
- * @nvmem: nvmem device to read from.
- * @info: nvmem cell info to be read.
- * @buf: buffer pointer which will be populated on successful read.
- *
- * Return: length of successful bytes read on success and negative
- * error code on error.
- */
-ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
-			   struct nvmem_cell_info *info, void *buf)
-{
-	struct nvmem_cell_entry cell;
-	int rc;
-	ssize_t len;
-
-	if (!nvmem)
-		return -EINVAL;
-
-	rc = nvmem_cell_info_to_nvmem_cell_entry_nodup(nvmem, info, &cell);
-	if (rc)
-		return rc;
-
-	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL, 0);
-	if (rc)
-		return rc;
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(nvmem_device_cell_read);
-
-/**
- * nvmem_device_cell_write() - Write cell to a given nvmem device
- *
- * @nvmem: nvmem device to be written to.
- * @info: nvmem cell info to be written.
- * @buf: buffer to be written to cell.
- *
- * Return: length of bytes written or negative error code on failure.
- */
-int nvmem_device_cell_write(struct nvmem_device *nvmem,
-			    struct nvmem_cell_info *info, void *buf)
-{
-	struct nvmem_cell_entry cell;
-	int rc;
-
-	if (!nvmem)
-		return -EINVAL;
-
-	rc = nvmem_cell_info_to_nvmem_cell_entry_nodup(nvmem, info, &cell);
-	if (rc)
-		return rc;
-
-	return __nvmem_cell_entry_write(&cell, buf, cell.bytes);
-}
-EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
-
 /**
  * nvmem_device_read() - Read from a given nvmem device
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26..1222b3f9819d 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -75,10 +75,6 @@ int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
 		      size_t bytes, void *buf);
 int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 		       size_t bytes, void *buf);
-ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
-			   struct nvmem_cell_info *info, void *buf);
-int nvmem_device_cell_write(struct nvmem_device *nvmem,
-			    struct nvmem_cell_info *info, void *buf);
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 size_t nvmem_dev_size(struct nvmem_device *nvmem);
-- 
2.48.1


