Return-Path: <linux-kernel+bounces-301259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B195EE4F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A619C1C204BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D4146A72;
	Mon, 26 Aug 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nj9aw4lz"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A441465BB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667428; cv=none; b=kWmXB/F4PAc+I5YBmVWAtM4zMrxW2ggCimDOCYFR7SzC62FWWauvHnoU9XhCRiSKj+rL+u6yCpC2fEFHsvwCmM+E+unwzYKk974XyeZ/O2dlRU/PKxcEWcIsOaRaxgTH/ELgxfc6ACPwhUUJzMF5f9Gqajxy28n2Be0XXXKsniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667428; c=relaxed/simple;
	bh=KBfQwLewyvP6KNpc8e1AId0s4PlpqFUiRzhSKGSgMd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZCk2V2SsP4SCegqJBC1asGky2aIsQ4pvf7UJPQIbn0Oh8r54Q9b7Ipc/4T2eTOdHZisfRtB+KecBhrXDCnksNeqA3iZQfrISDCQNhFvEGd19tk+xL4mGWxMI49JYwxgNtcYOeJpoO25pcze4pt56CajmunEaASWU/0mPAJunIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nj9aw4lz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7143ae1b560so2086709b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724667425; x=1725272225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLgW3Nno8j/HWiI/ORNdumHtmXTis5U7evz5O6UH5Ko=;
        b=nj9aw4lzlmgoerxN6uBkKX60W7QqWeJx+dQ6TE0x1a4d1cgojXm8vqrGgguYmhpnGN
         Y0u7MoncIsluHzhSvX2IUwqg2gDcfWcWiVacM/r7OKOiHBMMUD2U1mqRaVW9ctwi3++B
         5rln3GnnzikUziMrZNXIitnP8AiBQxDfNFafhAHbrS9uTL5ouYiBO2mj14PZScS18MCK
         +o4WnqUfYBBxpKuBZPxdxuqVhqdYAGf5prQWUbgMihpfgLm53zv3lIUDN0kjfhsy/hej
         4PEnG1HqsAfWIUTaVU9cwiR7TJBBgn9KkR3UG0jyZYda7pyWNKA9NfxCUr05bcanJ2yb
         0SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724667425; x=1725272225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLgW3Nno8j/HWiI/ORNdumHtmXTis5U7evz5O6UH5Ko=;
        b=cvaVgaBEElPMXA/i+jHeDIHToF2245qxb3y8dmunbEQRk/mUHmhozXnXEZUkGrQSLn
         r/Q7nMiTcIOCPqtpTHdbjXMEzajxRTQIN5QHVVlZn4J7trBtG2aQt9RUd+IyKMDy1unV
         uMqI1DdbL29juFA6W5VEHyGQdPLyNtuVgWQDps+W/d7gCffD+zVsKvkjuQP+Qms8XuaY
         vETb+1qmWEZD/xDN46qS4qtFJjpoXZh2xtzEyucgmEOKbwKr9mmi652kxy47kW+xLFj+
         ZE01G0+8VdWB605vcpB4Bg8JG9wyWBeX6DdV2OrH/zRVKR75J4Y92pdGnukbAJBWVDya
         sU8A==
X-Forwarded-Encrypted: i=1; AJvYcCWl6Txs+c5TeFr1EFFq496ZbqleQuytEsKZgECIU+B0/71BInM4z0AfEsuFzuf8upOBmTXusnBfHkBOlYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUQvJS4eIc45fJSyhv0xeWJgPALVvnDfUKPvr+ffRmanK8HcX
	9nebrJP3NWpI1ZjBBlYwD0JcFggBI1JgFwhbEph1skB8hWV9UScBzs8EW2rAfgs=
X-Google-Smtp-Source: AGHT+IHSsC0JqVh+geherMgxBVNXYODT22o0nph4S95PbbfN/+vFBujCiOXed2OLcAJMFXakXgbguA==
X-Received: by 2002:a05:6a21:3102:b0:1ca:dbda:48f7 with SMTP id adf61e73a8af0-1cc89d1980emr8761307637.1.1724667424785;
        Mon, 26 Aug 2024 03:17:04 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0e18sm6719920b3a.104.2024.08.26.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:17:04 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2] ACPI: CPPC: Fix MASK_VAL() usage
Date: Mon, 26 Aug 2024 12:16:44 +0200
Message-ID: <20240826101648.95654-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MASK_VAL() was added as a way to handle bit_offset and bit_width for
registers located in system memory address space. However, while suited
for reading, it does not work for writing and result in corrupted
registers when writing values with bit_offset > 0. Moreover, when a
register is collocated with another one at the same address but with a
different mask, the current code results in the other registers being
overwritten with 0s. The write procedure for SYSTEM_MEMORY registers
should actually read the value, mask it, update it and write it with the
updated value. Moreover, since registers can be located in the same
word, we must take care of locking the access before doing it. We should
potentially use a global lock since we don't know in if register
addresses aren't shared with another _CPC package but better not
encourage vendors to do so. Assume that registers can use the same word
inside a _CPC package and thus, use a per _CPC package lock.

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Clément Léger <cleger@rivosinc.com>

---
v2:
 - Remove label and unlock the spinlock earlier.

 drivers/acpi/cppc_acpi.c | 43 ++++++++++++++++++++++++++++++++++++----
 include/acpi/cppc_acpi.h |  2 ++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d857978f5f4..4a47e08704d9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -170,8 +170,11 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
-#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
+#define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &				\
 					GENMASK(((reg)->bit_width) - 1, 0))
+#define MASK_VAL_WRITE(reg, prev_val, val)						\
+	((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |		\
+	((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_offset)))	\
 
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
@@ -857,6 +860,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
+	spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
@@ -1062,7 +1066,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		*val = MASK_VAL(reg, *val);
+		*val = MASK_VAL_READ(reg, *val);
 
 	return 0;
 }
@@ -1071,9 +1075,11 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
 	int size;
+	u64 prev_val;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
+	struct cpc_desc *cpc_desc;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1106,8 +1112,34 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, size);
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		val = MASK_VAL(reg, val);
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+		if (!cpc_desc) {
+			pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+			return -ENODEV;
+		}
+
+		spin_lock(&cpc_desc->rmw_lock);
+		switch (size) {
+		case 8:
+			prev_val = readb_relaxed(vaddr);
+			break;
+		case 16:
+			prev_val = readw_relaxed(vaddr);
+			break;
+		case 32:
+			prev_val = readl_relaxed(vaddr);
+			break;
+		case 64:
+			prev_val = readq_relaxed(vaddr);
+			break;
+		default:
+			spin_unlock(&cpc_desc->rmw_lock);
+			return -EFAULT;
+		};
+		val = MASK_VAL_WRITE(reg, prev_val, val);
+		val |= prev_val;
+	}
 
 	switch (size) {
 	case 8:
@@ -1134,6 +1166,9 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		break;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		spin_unlock(&cpc_desc->rmw_lock);
+
 	return ret_val;
 }
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 930b6afba6f4..e1720d930666 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -64,6 +64,8 @@ struct cpc_desc {
 	int cpu_id;
 	int write_cmd_status;
 	int write_cmd_id;
+	/* Lock used for RMW operations in cpc_write() */
+	spinlock_t rmw_lock;
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
-- 
2.45.2


