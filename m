Return-Path: <linux-kernel+bounces-197912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E2A8D70A6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DC41F23AE9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD01534EF;
	Sat,  1 Jun 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Kjz2fM/L"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47F1534EA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254312; cv=none; b=pN/HNEU9TxISCwiQ1LqRghvCbbxXdFQ4UWF0C/LxC5mCEUg3Ayl/1zr7wDb/FCc91evtPkVIgywS5YvSsGYXDNMG+TsIFcwCeM/+mDzfmqSzWr7n9BU1KYUOV1oib8Rr3KIVyvj0P7yuE//7NeqG9APA0Ek51i1uwA515o/EtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254312; c=relaxed/simple;
	bh=MS3pYncxgjtaz9tqccBN5FjLqLx8afnodSL+vXxHJSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qh07ELgwGrCCAPNb3BoL2bt0+qjeelXxIblfGsVuZRwhDuvXQ8PdVYqpuzmOE0JaA+flp543d3VTX1jvG7r8h7z6um8Dlh3DCukV2bj+T/fvbf6ooAWoEqiL9oxW+wpCdUhyTPK0PQPI1jSUjVM78UWmw8qMWRGZ9/fKCMduEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Kjz2fM/L; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c1e6fcb2f1so1139053a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254311; x=1717859111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4M/mYQsiafz27308Ygh9HE2jpjvmPpXdwbsDZU0p4U=;
        b=Kjz2fM/LXEMXrWPgy3sD+Wi5PZRi93ASTcmKlDmLh3ZGN0oPWD1oeZdpMNCKrd2QMN
         MrhFdYfjFFM3RS6qtHorNm7M7CfuypUyrkZpnY3FD68PI//gs0qtSjwEAPQXu0Ng/2sw
         nOFWvBQcnJVJyLituErWYCrzA8IYz68IyEoyckiu1lQaWO6JaHD5zABHo1wuAil2TJ2K
         04h89Uk4D+8+/SfPXscz1RzEE5gIDVeJVqVs6+Fy7FYIIKcTr47CPgOPe/ZIxpHzlKWT
         1KQw3Z6ESHZu/i9lNKHViesBqeju7+vOBZFy5DfS5K7KzhQavvh60k5MvtXtsM95WffU
         SwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254311; x=1717859111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4M/mYQsiafz27308Ygh9HE2jpjvmPpXdwbsDZU0p4U=;
        b=MBFrv6Q1jGBSCyEfW10oL/4wPMz+oR/ReoWIN6UR5boBG7qjy8iAYUnobadDyZXB/i
         7nY6AHyd6bfCvJr2hCZJjrgzBTRmaUUCEMJPq8xwDpAAKSFQJVupeQyr1McW1/L6LG2w
         ur9/QWiedhnkKovGJpHVtjbThkxJ89WdV3owDq2M4Jy8eK8LBA3XFqxWynRtUU4UgqzH
         mJkUH5W22mWN5IGyNaIedd3OE68Qi+SPHt6Li4etAXML0SNfWrIG+AXno3NcqONyy1iL
         rs1ot+QlzQTrJjhyi6w/Fqdh3S0xt8xan72a02Sz/RsK3AnFMhoroAieObBPkYEMvNtp
         AJfw==
X-Forwarded-Encrypted: i=1; AJvYcCUI/wnr1o/VLaHUIKyUGr5P0CIgkF4PnbY5GPtAVyhumEgXBAXNfq+VVcBtvldu2TFGS/YSJtOUH4lOOFqf9w40gnoBMBKIPyq7Tf0j
X-Gm-Message-State: AOJu0YxFOtucZCeYn+UXLDleVLXNKUg2BsUtc/kPP4YorUijZhw1JxVE
	7tI6uFmYNCa4zDls22tCMYhuYQKh1qJG+b0aFIOTmBWQujFcu/HGxXWpcVf3svY=
X-Google-Smtp-Source: AGHT+IH8CUtTilyts1LQmIwjtfiqczpJ90H7WVJzan1b3vUk1N8n0tjhHWRHLwYTOBrAh4nFvjs79Q==
X-Received: by 2002:a17:90b:1bcd:b0:2c2:a2a:6151 with SMTP id 98e67ed59e1d1-2c20a2a631emr797621a91.39.1717254310835;
        Sat, 01 Jun 2024 08:05:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:10 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Sat,  1 Jun 2024 20:34:01 +0530
Message-Id: <20240601150411.1929783-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 8d0710ade8c6..d5286e39668e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1201,6 +1201,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_LPIC:
 		message = "LPIC";
 		break;
+	case ACPI_IRQ_MODEL_RINTC:
+		message = "RINTC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0c6d9539f737..3dd67ee09c39 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -107,6 +107,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.40.1


