Return-Path: <linux-kernel+bounces-557704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591CBA5DCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1CE3B5E35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048BE24419B;
	Wed, 12 Mar 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhrHYn2G"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CC24397A;
	Wed, 12 Mar 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782686; cv=none; b=j+0SXOZfDp28IMFyacfXfDkBa1FrFbU+Tl2NPLIA+HTgW9JRJGUWMcyQQAULP5IOpp6m42mhg05osSKv2a9NZ0BDEiUUAl7yBe/wkVU48UoDF61J05zyWtNf+8NRAKOE6GXYr+HTbPZUxxDyf3WIXnYX/hnMcjPq8CtGXzi4rz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782686; c=relaxed/simple;
	bh=swY102OjtPfX//4F5chrm/sI5ZZHg0Hxu7Gbh79ApJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6Vy2U57Dgg84fEPkkYOqLRKZnTKuUbQVh54t8Nsj7QbhGrz501NI7dv9mq35vZB4KlpFF3oDkecs7vTot+CxRim3q1HvZ7kw3E/LDGPp1YPqZ0XyYe7GcxA7MbaJON2Cp2WMr/7e/TXiybYpr5qz9K2atok7NGgMUuV/LFrQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhrHYn2G; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so3854687a91.0;
        Wed, 12 Mar 2025 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741782684; x=1742387484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEtyrInsggkjZtOumhqtqM5fexzmg56tq1lZYZJWFy0=;
        b=JhrHYn2GzAtQdcsWS98QT6SBBMqskAu7GOCRJ4sKDdy4HQ4dqUMtJXTNvelxx2620Z
         +2MNrK16Nq0X8iDX0wAcMtIgDXumV35WjflUd3U8cFI/HW6qCk9ATuxG5xcMCsSTJ0yn
         Yo5K3DzJ/yr79Jh3q6M2RxWS0lfua5WNZynyvXpkN4uFe+lZk9YOsY/tx+nu8Scw3dAg
         ta9hNqOwYs8rFn2rFcDTOLUYZg6Clvt2+D/P+IMO7svZOWE+dP+efLW22XKuqj0kfZmK
         f5uvpDiPzP9qhI7VTV8FDfsvmxNGTHFIAAAygY45Wu01o1j6TiGCTSI+/8BFSQUHA3N+
         ji+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782684; x=1742387484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEtyrInsggkjZtOumhqtqM5fexzmg56tq1lZYZJWFy0=;
        b=OWMAKhX1wAshx4BqTf6bbxaUb7j1NSFdUZVpMGYeraOPFa9DIJ5EwNEe0yUbw/u3FC
         p8FL6QBfvbBCZez2fc36yeF1x9zFvE6guridIAj///hZfZNraBQiFDlVBs4B7fyFLFjP
         t+Aeg4mWiK3fqE4careDpjizzzaZxZrkxQZ2egtpHtxWmG4veQn8gl9vZzV176ob0Row
         IBuPRO3Iad42uhWE9zUgeOYgFN+UdPzEOMWP3lgaalZVmcvzbBlwHRqwcOfrRxBJLG/k
         zXQrbRPRpU6366z/O31U0VHGb/RnqgeWYD06DmC/SFX7SXru3NYXuik9QAPTuM83Z6Jf
         G6fA==
X-Forwarded-Encrypted: i=1; AJvYcCU9D+a1MrIDwhHTfYpRKJljWS0qjTlqIR3Ityzu6dd3v5sn1/S2WP3eIT4MVTJJXGmsjz2NdamSVY4OwuJ9@vger.kernel.org, AJvYcCXPgwV/fMHmNNQkXKm4GlVtNiwFVXy491Pzoina7fh05TAFoUlb06NHiRmz3ztPI8oQbDwyZPI8RD+n0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnRQ1/B3svVeko9SskmgNzjq4F24MPIdrfuEX1r4M6TAomyz1
	scZcJFJW31S7MIU7VoMxuWYsyxfKm+xJCtbk0El58BzwVwMbPGcx
X-Gm-Gg: ASbGncsDHYfmL9PFs6Mcc1qfJPb626VAC9fixN5US1TrBL4YQngFnlmDFN0xNw9Nm41
	5PzoiQSUCriFnzweFrxsSoaClplRcb/aIuE3lgrugy10DXB8uQubRhzst/sba/ryDClffZXQ3/Y
	2gvkf2x1sGoHb9rMV4Mq6R48X3WLMddbF3fpkKHhL8nMvBZTzqEg4+cmT2bpuc46w9LFc2cUbcL
	77YLVXlLJz/bAk35ovN+QiHAR/id5l1NKiw4SdhtgSd1qHR2ARw+nMKDmH7B3qGZrSZ0Jx+Pt8M
	HRavYxEGkTk0Lgt9JmAyG2LMpB8GE3AO07flNFnijzKc4GfzGVQ5XXpTuadbFw7Y1nPR5zI8AQh
	M1ZhcKLie9xt4Kb3E9KuXZsY7p1+XJO75CQBxUw==
X-Google-Smtp-Source: AGHT+IEbE9TlXSxbHL+cbfcZnBh6VmprY9Nab4ZIxBNearOCdzdGmphzUEe7dCI5V3HYD+VenQqDlw==
X-Received: by 2002:a17:90b:2792:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-300ff100773mr9317310a91.21.1741782683588;
        Wed, 12 Mar 2025 05:31:23 -0700 (PDT)
Received: from kernel-Apple-Virtualization-Generic-Platform.. ([2401:4900:8898:8129:deb0:598c:ebb7:dc81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301182181c3sm1621784a91.5.2025.03.12.05.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:31:23 -0700 (PDT)
From: Subu Dwevedi <messigoatcr7nop@gmail.com>
To: 
Cc: Subu Dwevedi <messigoatcr7nop@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon/applesmc: add MMIO for newer macs
Date: Wed, 12 Mar 2025 18:00:22 +0530
Message-ID: <20250312123055.1735-2-messigoatcr7nop@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312123055.1735-1-messigoatcr7nop@gmail.com>
References: <20250312123055.1735-1-messigoatcr7nop@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic MMIO support to AppleSMC for T2 Macs,
enabling it only when supported.
This replaces the legacy port-based method for
key reading, writing, and metadata operations
(retrieving keys by index and obtaining key information)

Signed-off-by: Subu Dwevedi <messigoatcr7nop@gmail.com>
---
 drivers/hwmon/applesmc.c | 223 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 213 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index fc6d6a9053ce..1be4a4026a6e 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -17,6 +17,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
@@ -142,7 +143,9 @@ static struct platform_device *pdev;
 static s16 rest_x;
 static s16 rest_y;
 static u8 backlight_state[2];
-
+static u8 *__iomem mmio_base;
+static bool is_mmio;
+static u32 mmio_base_addr, mmio_base_size;
 static struct device *hwmon_dev;
 static struct input_dev *applesmc_idev;
 
@@ -245,7 +248,108 @@ static int send_argument(const char *key)
 	return 0;
 }
 
-static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
+/*
+ * MMIO Impliementation
+ */
+
+static void clearArbitration(void)
+{
+	if (ioread8(mmio_base + 0x4005))
+		return iowrite8(0, mmio_base + 0x4005);
+}
+static int waitForKeyDone(void)
+{
+	int i = 1000; //millisecounds
+	u8 status;
+
+	while (i) {
+		msleep(1);
+		i--;
+
+		status = ioread8(mmio_base + 0x4005);
+		if (status & 0x20)
+			return 0;
+	}
+
+	return -EIO;
+}
+static int mmio_read_smc(u8 cmd, const char *key, u8 *buffer, u64 len)
+{
+	u8 i, u = 0;
+
+	clearArbitration();
+	iowrite32(*((u32 *)key), mmio_base + 0x78);
+	iowrite8(0x15, mmio_base + 0x7E);
+	iowrite8(cmd, mmio_base + 0x7F);
+
+	if (waitForKeyDone())
+		return -EIO;
+
+	i = ioread8(mmio_base + 0x7F);
+	if (i)
+		return -EIO;
+	if (cmd == APPLESMC_READ_CMD) {
+		i = ioread8(mmio_base + 0x7D);
+		if (i > len || !i)
+			return -EIO;
+
+		while (u < i) {
+			if ((i - u) < 4) {
+				if ((i - u) < 2) {
+					buffer[u] = ioread8(mmio_base + u);
+					u += 1;
+				} else {
+					*(u16 *)&buffer[u] = ioread16(mmio_base + u);
+					u += 2;
+				}
+			} else {
+				*(u32 *)&buffer[u] = ioread32(mmio_base + u);
+				u += 4;
+			}
+		}
+	} else
+		memcpy_fromio(buffer, mmio_base + 0x0, len);
+
+	return 0;
+}
+static int mmio_write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
+{
+	u8 i = 0;
+
+	clearArbitration();
+	iowrite32(*((u32 *)key), mmio_base + 0x78);
+	while (i < len) {
+		if (len - i < 4) {
+			if (len - i < 2) {
+				iowrite8(buffer[i], mmio_base + i);
+				i += 1;
+			} else {
+				iowrite16(*(u16 *)&buffer[i], mmio_base + i);
+				i += 2;
+			}
+		} else {
+			iowrite32(*(u32 *)&buffer[i], mmio_base + i);
+			i += 4;
+		}
+	}
+	iowrite8(len, mmio_base + 0x7D);
+	iowrite8(0x15, mmio_base + 0x7E);
+	iowrite8(cmd, mmio_base + 0x7F);
+	if (waitForKeyDone())
+		return -EIO;
+
+	i = ioread8(mmio_base + 0x7F);
+	if (i)
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * Port Based IO implementation
+ *
+ */
+static int port_read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 {
 	u8 status, data = 0;
 	int i;
@@ -289,7 +393,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 	return wait_status(0, SMC_STATUS_BUSY);
 }
 
-static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
+static int port_write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
 {
 	int i;
 	int ret;
@@ -317,7 +421,23 @@ static int write_smc(u8 cmd, const char *key, const u8 *buffer, u8 len)
 
 	return wait_status(0, SMC_STATUS_BUSY);
 }
+static int write_smc(u8 cmd, const char *key, const u8 *buffer,
+		u8 len)
+{
+	if (is_mmio)
+		return mmio_write_smc(cmd, key, buffer, len);
+
+	return port_write_smc(cmd, key, buffer, len);
+}
 
+static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
+{
+	if (is_mmio)
+		return mmio_read_smc(cmd, key, buffer, len);
+
+
+	return port_read_smc(cmd, key, buffer, len);
+}
 static int read_register_count(unsigned int *count)
 {
 	__be32 be;
@@ -379,18 +499,39 @@ static const struct applesmc_entry *applesmc_get_entry_by_index(int index)
 
 	if (cache->valid)
 		goto out;
+
 	be = cpu_to_be32(index);
-	ret = read_smc(APPLESMC_GET_KEY_BY_INDEX_CMD, (u8 *)&be, key, 4);
-	if (ret)
-		goto out;
-	ret = read_smc(APPLESMC_GET_KEY_TYPE_CMD, key, info, 6);
+	ret = read_smc(APPLESMC_GET_KEY_BY_INDEX_CMD, (const char *) &be, (u8 *) key, 4);
 	if (ret)
 		goto out;
 
+	if (is_mmio) {
+		clearArbitration();
+		iowrite32(*((u32 *)key), mmio_base + 0x78);
+		iowrite8(0, mmio_base + 0x7E);
+		iowrite8(APPLESMC_GET_KEY_TYPE_CMD, mmio_base + 0x7F);
+		ret = waitForKeyDone();
+		if (ret)
+			goto out;
+
+		ret = ioread8(mmio_base + 0x7F);
+		if (ret)
+			goto out;
+
+		*(u32 *)cache->type = ioread32(mmio_base + 0x7F);
+		cache->len = ioread8(mmio_base + 5);
+		cache->flags = ioread8(mmio_base + 6);
+
+	} else {
+		ret = read_smc(APPLESMC_GET_KEY_TYPE_CMD, key, info, 6);
+		if (ret)
+			goto out;
+
+		cache->len = info[0];
+		memcpy(cache->type, &info[1], 4);
+		cache->flags = info[5];
+	}
 	memcpy(cache->key, key, 4);
-	cache->len = info[0];
-	memcpy(cache->type, &info[1], 4);
-	cache->flags = info[5];
 	cache->valid = true;
 
 out:
@@ -558,7 +699,64 @@ static int applesmc_init_index(struct applesmc_registers *s)
 
 	return 0;
 }
+/*
+ * applesmc_init_mmio_try - Try to initialize MMIO
+ */
+static int applesmc_init_mmio_try(void)
+{
+	u8 ldkn_version;
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev;
+	struct acpi_resource *res;
+
+	adev = acpi_dev_get_first_match_dev("APP0001", NULL, -1);
+	if (!adev)
+		return -ENXIO;
+
+	status = acpi_get_current_resources(adev->handle, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENXIO;
+
+	res = buffer.pointer;
+	while (res->type != ACPI_RESOURCE_TYPE_END_TAG) {
+		if (res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
+			if (res->data.fixed_memory32.address_length < 0x4006)
+				return -ENXIO;
+
+			mmio_base_addr = res->data.fixed_memory32.address;
+			mmio_base_size = res->data.fixed_memory32.address_length;
+			is_mmio = true;
+			break;
+		}
+		res = ACPI_NEXT_RESOURCE(res);
+	}
+	kfree(buffer.pointer);
+	acpi_dev_put(adev);
+
+	if (!is_mmio)
+		return -ENXIO;
+
+	mmio_base = ioremap(mmio_base_addr, mmio_base_size);
+
+	if (!mmio_base)
+		return -ENXIO;
 
+	if (ioread8(mmio_base + 0x4005) == 0xFF)
+		goto out;
+
+	if (read_smc(APPLESMC_READ_CMD, "LDKN", &ldkn_version, 1))
+		goto out;
+
+	if (ldkn_version < 2)
+		goto out;
+
+	return 0;
+out:
+	pr_warn("cannot enable MMIO will use PMIO\n");
+	iounmap(mmio_base);
+	return -ENXIO;
+}
 /*
  * applesmc_init_smcreg_try - Try to initialize register cache. Idempotent.
  */
@@ -1321,6 +1519,8 @@ static int __init applesmc_init(void)
 		ret = -ENXIO;
 		goto out;
 	}
+	if (applesmc_init_mmio_try())
+		is_mmio = false;
 
 	ret = platform_driver_register(&applesmc_driver);
 	if (ret)
@@ -1407,6 +1607,9 @@ static void __exit applesmc_exit(void)
 	applesmc_destroy_smcreg();
 	platform_device_unregister(pdev);
 	platform_driver_unregister(&applesmc_driver);
+	if (is_mmio)
+		iounmap(mmio_base);
+
 	release_region(APPLESMC_DATA_PORT, APPLESMC_NR_PORTS);
 }
 
-- 
2.43.0


