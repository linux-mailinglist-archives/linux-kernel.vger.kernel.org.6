Return-Path: <linux-kernel+bounces-197907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC658D7095
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB501C21351
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA753152799;
	Sat,  1 Jun 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZuGtaxMt"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3E1527A2
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254278; cv=none; b=ewYB2z+V90Xe1SKfNLEYDJFzbrKOuymQbI1xYO01a9NmyfeAxU6Y9al+6Ux7+oKHuAODdXZwm24j79TMCHWQx/PjuPrWGhZ0O3hdaSJuUeXcOwl5B9cswf2odW3WZ7DiqmeDVWQ+5IR7ijEa2b98D9YoXY+wJSUOG+OQGtK/KM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254278; c=relaxed/simple;
	bh=4+LD9bLmMNzkLdqkJ6X6xTzm3/rW211clcBLvkKYJPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9uNY+r6aGveZu133myd2oQ4dBcxqjuj8ALrIsuXzHDUI+0maYUx18IkuqBdC4O9enh6+pyVtgA9i9Rij1rj0l2Y7yT87eE5Bku2Oe4XCNyFMqdWw1eXEEib4L9J/G2mffjVu8+ru3ONbJFi1PcLPeT5dvdKKifFtvpRfZFkI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZuGtaxMt; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b3241373adso2056399eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254276; x=1717859076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2w7EI3TeN2iCf/DRtg4G2EgwNqxdEr1hmfQbDfWRcM=;
        b=ZuGtaxMtExJHXO9tsaJ4YXaFdL0I0eTAaWh4Dc8xzboIfAdBDvqh2YLVMLVj+GJGni
         krIIwnrz3THu8bHtTxMzWDHcdNnwkTee/wdpQdEdy2LkgTxNdD4LTgzNMhUzlUIP7lI9
         +44M3LLlzdknq//+VrGe2MUkfFdcHIY77iBHjYSqKvpdoMP0Uzoj/T0y9TIltIHmWOlp
         6quPOC7HtCBpyo41rtZw9wbfyu8oeTuUlmH52jCHg5p2puBJitZ6T9PiGA4EJkZeTHg5
         InuyqoK80xmdW+3RviN2iPduu9vJWEv9zFcaPSQhBAiFMfuw5uuULIc8GmmXAE4vA6J9
         gU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254276; x=1717859076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2w7EI3TeN2iCf/DRtg4G2EgwNqxdEr1hmfQbDfWRcM=;
        b=UVJBnsJQa5JOu/vWlD8Pk1l7mTdGrnh/p1Cza10Yv1oovfiPM/HRTxEn5FLloXO2il
         L8mhwypPmu1zdr2basgkxOynfeKpLagqTaStcQfGnr9Z0lgIkuTuoAsQABD1Loxk2GCx
         C0TVFoVPCcpA/6MZKYnLVNdsGeluDFkiSpMNcGJJzbyAmsek25Iv/57OrAlpOuU+1phz
         VK4TS1op7jd/Sfek8pIXw3MZUtROTB2PHZ6+sRGvpgeVcuDO6IB/VetdlVk+4M1XxEBK
         k/eszbnf4UElchGVXGkpc8XeFvcNneusUOGxEKOBu62putVGBT9ZIEMnvvLtG7AS3P75
         qnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSynpxpsrFWncTmzSy5kLAuKXN4BAIvR8yhYNqsFEteV4fgM7CJmGurNrTjd8+ACmTNH3ESFy0U3V9gIsOOVWtmtYP7xzj75QXsS7C
X-Gm-Message-State: AOJu0YxitOcQ5whTzVe3mGB3+Ua9Q46qiNT7R4j0rQiDNKl0hBD2pxmm
	XQCJ57dPiRgH7ZsQcq52G5RHJi9aECgHEQv9j5w8gTUaH1rHBGG2NqaUTv1CSI8=
X-Google-Smtp-Source: AGHT+IGJwcsK8POtH2BMJmphYPRD+c46tpmn1qQdcpXrg0lGYUhORZGvMPcRjxjR7R/vaRNToWclfw==
X-Received: by 2002:a05:6358:7601:b0:19b:8988:4f48 with SMTP id e5c5f4694b2df-19b898851f3mr287174455d.21.1717254275702;
        Sat, 01 Jun 2024 08:04:35 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:04:35 -0700 (PDT)
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
Subject: [PATCH v6 02/17] ACPI: scan: Add a weak function to reorder the IRQCHIP probe
Date: Sat,  1 Jun 2024 20:33:56 +0530
Message-Id: <20240601150411.1929783-3-sunilvl@ventanamicro.com>
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

Unlike OF framework, the irqchip probe using IRQCHIP_ACPI_DECLARE has no
order defined. Depending on the Makefile is not a good idea. So,
usually it is worked around by mandating only root interrupt controller
probed using IRQCHIP_ACPI_DECLARE and other interrupt controllers are
probed via cascade mechanism.

However, this is also not a clean solution because if there are multiple
root controllers (ex: RINTC in RISC-V which is per CPU) which need to be
probed first, then the cascade will happen for every root controller.
So, introduce a architecture specific weak function to order the probing
of the interrupt controllers which can be implemented by different
architectures as per their interrupt controller hierarchy.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c  | 3 +++
 include/linux/acpi.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 503773707e01..b325b297bf77 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2744,6 +2744,8 @@ static int __init acpi_match_madt(union acpi_subtable_headers *header,
 	return 0;
 }
 
+void __weak arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr) { }
+
 int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 {
 	int count = 0;
@@ -2752,6 +2754,7 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 		return 0;
 
 	mutex_lock(&acpi_probe_mutex);
+	arch_sort_irqchip_probe(ap_head, nr);
 	for (ape = ap_head; nr; ape++, nr--) {
 		if (ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id)) {
 			acpi_probe_count = 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 28c3fb2bef0d..ab3f2880d209 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1332,6 +1332,8 @@ struct acpi_probe_entry {
 	kernel_ulong_t driver_data;
 };
 
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr);
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,	\
 				 valid, data, fn)			\
 	static const struct acpi_probe_entry __acpi_probe_##name	\
-- 
2.40.1


