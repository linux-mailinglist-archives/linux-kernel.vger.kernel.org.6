Return-Path: <linux-kernel+bounces-536305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C5A47DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574D33B70F6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6CB233158;
	Thu, 27 Feb 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TTBTbf3p"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE7233157
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659842; cv=none; b=FTLADXTpIOAiBpXNhuXff4ixNcvGBerSWAmIUp+NozVELp8rcbEIn/KoOl6MMNj97mlQcHwqqdH+jW2QpypyU4Bb9UWRtQDLBICj1osYAMxE3YwKwPPEl+gyNDQUrf0Beg9ZSf2ycP7u5R+NDd+39vdkcGmQAfsUAfObhepcXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659842; c=relaxed/simple;
	bh=Q5uxxUx6KeY4zwC8bnmu7iQA3t7vZqPvLL2pQYA7C38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/t4V7d/3Gwufg96VQ/F+dVgw21/DywhETDO1Awkws83qla44T5nrBkTqext6qJ0VKZyitNQZf/h/qZfzjNm0Ni35a5InH2pYoXxaxlun6B4HzMCeFXq78js8d+qYPuisr7BInSHkqzketGCLyyba+lwsDdoCX2GvJYiwybjZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TTBTbf3p; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22185cddbffso34375915ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659840; x=1741264640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXVhLjcRoeCf2V/5WVQuQKEAR2qmhhl0hOLkmr0AsUA=;
        b=TTBTbf3p9mtat1hJOe3zuTTPvJL9QNYkfiejdQLuxo3foRymrjl6q3NvaSuNvubbz6
         lKZyeVVoOlpcIIfXDgMMfMCnfxliOYrzIKxqkN51GLfGNaDVBJYWV9SMk60h7HMAHbhR
         0VGpm5KvRUDppIElj36N1xcQd8HllUVWoiYFfKGdBHl3x1go1hAsvzOIX4bGA4ZXXOHh
         wM6aj6ZLpAJiAskOk8DLmmuhvSVGgJ0xJVh9+cQTLWQWslzViJa4SxgTgNQCIQr4ez0e
         xVHapLBSXizZLuBTcnrvfN7LKUZ0LA9TR70al96awVWiefgAOzMdekDbZSDR3uFo//TE
         y+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659840; x=1741264640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXVhLjcRoeCf2V/5WVQuQKEAR2qmhhl0hOLkmr0AsUA=;
        b=MGuukqLi4giqDzBro3dz+UXI8/OySgnW9ojzsbx0TCY2U6OPsToCuCZ8u+QkwOs+Cy
         Ir34MstjMMxidLQ8C6rIxXGEcJ+/fEUPLDsgUuTY/6RMgwaTf3T//wK/Q4ouJ1Jv1rR0
         I8UGZE6Xa5y4Np4jBXNU4Du78c2oZUJW3sNzh8EXVDz1Qqe/0S31du6J38WB2j0xDx4M
         DVA8QEXE5c+EySAVU1XKuOuP/zP+KoyPEfXtCaAXkRqKHoBTwurXCeLQc17FbKwSFsSK
         xL488OWLt+/M2wZ9qnikOn/k8kcn8DYlsu5E5KJZ2Vxss0uH02ei76ZO8I05/KzCCwRu
         5cYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwg6hQr7DXzxCnSBy22uCDA3gJ0i2DBAzkyMPOB0wjvUebJtChoRPlNYcuvoXP02XVGScCTCcL6iMyYls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcZ9Btn6zU4qA1t4NZR4YO2N2tWcdXNPiuWHkXbugi/Cx5KQz
	PCoxR3ro8i87jWKzcWEKw4rESwAI2yuomyiFB6fuFuojhF8sW08OsNJ5KR8dHJQ=
X-Gm-Gg: ASbGncsQLq+jqIXiHT9mhD0Ob225pftt+uPkExAmh8/c2ORvywdspY6mICoD7xDN9su
	gPf7gQG+Y0c048xhSXUmtwmZrLZCe0KomfjN/OgMlNYSfkYmP2tXOOFWl3BfTNofmI/ZHJWgVTz
	FZ2EIKRoE8fF6OHZHZ6SQM4CmW0uQEnYdZ/SCeAQoIkFoEoTYWNkEVD+KsHfW0BDeYyQiQS0Ij+
	Z52QIl7b48XmIHUTq3ixTbDCGrd/kU1BSHAhDD2LTBnC6k/ecePNSLKoQS9Kaf9JPOc7pS9AWYe
	hAtT9L+ovn9S5sTufSZoKStO5Ne/CSyCOp4L
X-Google-Smtp-Source: AGHT+IE/pZ3e6JonJxeQe62tq8o12LGMwm5f6Ts5InGRCEUeYVZmSfCnd9ZWVdPIH36ibrRnGp55zA==
X-Received: by 2002:a17:902:d507:b0:21f:1348:10e6 with SMTP id d9443c01a7336-2234a57fd4fmr60713595ad.13.1740659839830;
        Thu, 27 Feb 2025 04:37:19 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:19 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 08/10] riscv: Introduce HEST SSE notification handlers
Date: Thu, 27 Feb 2025 18:06:26 +0530
Message-ID: <20250227123628.2931490-9-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Functions to register a ghes entry with SSE
- Add Handlers for low/high priority events
- Call ghes common handler to handle an error event

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 100 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8a1029163799..59abb89d3547 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -17,6 +17,7 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/riscv_sse.h>
 #include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -97,6 +98,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#ifndef CONFIG_RISCV_SSE
+#define FIX_APEI_GHES_SSE_LOW_PRIORITY	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SSE_HIGH_PRIORITY	__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1405,6 +1411,63 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
 	return sdei_unregister_ghes(ghes);
 }
 
+#if defined(CONFIG_ACPI_APEI_SSE)
+/* SSE Handlers */
+static int __ghes_sse_callback(struct ghes *ghes,
+			       enum fixed_addresses fixmap_idx)
+{
+	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+		irq_work_queue(&ghes_proc_irq_work);
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/* Low priority */
+static int ghes_sse_lo_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_lo);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_lo);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_LOW_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_lo);
+
+	return err;
+}
+
+/* High priority */
+static int ghes_sse_hi_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_hi);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_hi);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_HIGH_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_hi);
+
+	return err;
+}
+
+static int apei_sse_register_ghes(struct ghes *ghes)
+{
+	return sse_register_ghes(ghes, ghes_sse_lo_callback,
+				 ghes_sse_hi_callback);
+}
+
+static int apei_sse_unregister_ghes(struct ghes *ghes)
+{
+	return sse_unregister_ghes(ghes);
+}
+#else /* CONFIG_ACPI_APEI_SSE */
+static int apei_sse_register_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+static int apei_sse_unregister_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+#endif
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
@@ -1451,6 +1514,15 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			generic->header.source_id);
 		goto err;
+	case ACPI_HEST_NOTIFY_SSE:
+		if (!IS_ENABLED(CONFIG_ACPI_APEI_SSE)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d "
+				"notified via SSE is not supported\n",
+				generic->header.source_id);
+			rc = -ENOTSUPP;
+			goto err;
+		}
+		break;
 	default:
 		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
 			generic->notify.type, generic->header.source_id);
@@ -1514,6 +1586,18 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		if (rc)
 			goto err;
 		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		rc = apei_sse_register_ghes(ghes);
+		if (rc) {
+			pr_err(GHES_PFX "Failed to register for SSE notification"
+			       " on vector %d\n",
+			       generic->notify.vector);
+			goto err;
+		}
+		pr_err(GHES_PFX "Registered SSE notification on vector %d\n",
+		       generic->notify.vector);
+		break;
 	default:
 		BUG();
 	}
@@ -1543,7 +1627,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static void ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1577,16 +1660,11 @@ static void ghes_remove(struct platform_device *ghes_dev)
 		ghes_nmi_remove(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
-		rc = apei_sdei_unregister_ghes(ghes);
-		if (rc) {
-			/*
-			 * Returning early results in a resource leak, but we're
-			 * only here if stopping the hardware failed.
-			 */
-			dev_err(&ghes_dev->dev, "Failed to unregister ghes (%pe)\n",
-				ERR_PTR(rc));
-			return;
-		}
+		apei_sdei_unregister_ghes(ghes);
+		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		apei_sse_unregister_ghes(ghes);
 		break;
 	default:
 		BUG();
-- 
2.43.0


