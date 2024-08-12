Return-Path: <linux-kernel+bounces-282452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AAB94E44E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9980D1C20A92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374DA17C7F;
	Mon, 12 Aug 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YHx7co6s"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E079F4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424421; cv=none; b=Ur/zes86f6a69QVOZf+D5ePBO1sNCVdtHg7RL76RU0rjN0JoPVyCqkXa/8Hm9Ny3za3Ku9BC/QJ8fEPx3rD7rQSGGf++I1pb1jUSWbTgttyw0Pz4clwpBT9xZ7hH30etxja9Wu6um5EZki4ZBsXbwzJzumY784elCrnHppPkk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424421; c=relaxed/simple;
	bh=zrv9AUs5Cq6Bk8OZWZZlXW2L//FNGQ0gb5DlOwPjduA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcL6tEcm64zkFJHhgc8ubqZypeaw3B9fUvo7zQ4dMvfYMkTkLfj7dmnG/wQqf1gIYzC3Jqd31xfHaaT8u09zmprHtqmrirDlaYCbajV6owUUN8psZDFBXQAaYdoRBp0TDwxCFMAYD2ylEqINW6IRveLAb+Z7zMIirO22WyS8Fis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YHx7co6s; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db1270da60so3095362b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424419; x=1724029219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVnO8D9tH0sab/WeUvbej3ReIYXoTsQSEaRkiw5yKWo=;
        b=YHx7co6sHpUhq1irkKooz/97Yu9EZO47IUDT09vvzthBbZbNLgxoi46eqnCIfsDwLc
         C/hoECDXahxGmjxdNhZ6PAUVS+rdR1dOhvKSocV0gh64niVOy44xAgIL3mGCqRCH1Xrd
         6Fiec4ORlELvXXCdMBd8x2EOuwhzGa1V8nPsQCrtd/wJpSMZEtkKwmhdGnJUCRBixI7y
         otUvO857yl00YeEDM336Gp8HC2LIMcN3Dg5ZLzswfMaT4AVUv1hgnX9Tyiqg3XyZpSp/
         WqCKqxlblEPvSbqYV5eX1NwYtkNe/cZsg8LmPsIvZpXy4QpYgea/K7YMFNMQ8W7QVUgF
         7KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424419; x=1724029219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVnO8D9tH0sab/WeUvbej3ReIYXoTsQSEaRkiw5yKWo=;
        b=sFecMkoik4dZ0KlY5O5FAOjtnfsvRT1n5tih5LpH4gBsH0ONTxKt2VhvxJmjemLetA
         OgnvnqY8/h9qHnFkk34OQnOfYynlfsLz4IxvX9oBCcXYBn2WryyKfLD+nk07ruWvnwFS
         uKi/yAdXFcY2qmkyo/uWzYY7oewrFApTHLiF5y8aAy2a/wEpIPdpCGtRKRSEV5wceDuk
         b6fOdEtOM9iiTNErO21hQp1Xaq3ZlfpLog3ogmvthMm8dIRTr9ciWlXpoY/wexfjKWlg
         l0mzwKCC+tQlgWYIDR5K3lC1EHpGvWomLeVQ1GEuTvKYL74bGY8tMxtoGDMVcibuEhAi
         uFZA==
X-Gm-Message-State: AOJu0YzmTXDErn7pOqVdsnvD0avMMGIbLuKINKv1j3Dtxen2dAWEZxFJ
	tM15hLKgEavT0TUETpfDVXbHAqBoxdW6ilX5YkY7yrYNDkQwm5Z7jv2eVoQ5q6dSPluA9mxvCly
	hVbmv/Q==
X-Google-Smtp-Source: AGHT+IGgnQrX14dxOj3yn291622Lxvm1iCgbP6yN6u9XpX8bxmUnRZf2Nt8a7HJ6YawHB1+ioO6EHA==
X-Received: by 2002:a05:6808:1513:b0:3dc:299d:c4fb with SMTP id 5614622812f47-3dc416ec02cmr12205900b6e.40.1723424418770;
        Sun, 11 Aug 2024 18:00:18 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:18 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
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
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 06/17] ACPI: scan: Define weak function to populate dependencies
Date: Mon, 12 Aug 2024 06:29:18 +0530
Message-ID: <20240812005929.113499-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

Some architectures like RISC-V need to add dependencies without explicit
_DEP. Define a weak function which can be implemented by the architecture.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/scan.c     | 11 +++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 39b3ccae9f79..28a221f956d7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2077,11 +2077,22 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 	}
 }
 
+u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
+
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
 	u32 count = 0;
 
+	/*
+	 * Some architectures like RISC-V need to add dependencies for
+	 * all devices which use GSI to the interrupt controller so that
+	 * interrupt controller is probed before any of those devices.
+	 * Instead of mandating _DEP on all the devices, detect the
+	 * dependency and add automatically.
+	 */
+	count += arch_acpi_add_auto_dep(handle);
+
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
 	 * 1. PCI devices.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index d6a4dd58e36f..af72a5d9de99 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -994,6 +994,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 int acpi_wait_for_acpi_ipmi(void);
 
 int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
+u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.43.0


