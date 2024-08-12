Return-Path: <linux-kernel+bounces-282454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7102394E452
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FD81C213AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C900811725;
	Mon, 12 Aug 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OtWndrTe"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE8225CE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424435; cv=none; b=qArYgg9DRSuf52R65Z8TAQYTa7L2J4EIokRTV1iiZYNLf8Oz/xutjyPw7GOZcBm2Ld5jVYO19wH3eapottJGpMXwzw0ioeFTaPhGlhmL+A+XWXVnCFQG/+06SRhN1CW3S7oQdHkO+3V7yICmApj/CD0DBHL0gnR+b4CFVAprw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424435; c=relaxed/simple;
	bh=ju78PKw5X3jrPkd4u5aoarH1747E7AoqhDQWmGlAe6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J52dilPCnAn3YcTDiJw4AGA6AN4XcEP9FNXqq+Ii8OtHGMyv1CuePjbzYNOoq7cuiTILj5IFf4WxUBsb4VVzgEYjco7+afyL14lApLXuR0af8jrRojzZea/JxkAb76WpavoZq2NFVhKd4Mz7EWGoIY4RidTcPxGntwYC+OXJ6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OtWndrTe; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db51133978so2811233b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424431; x=1724029231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZXNFNaxM8vBPLxvkIIPrWaUY6tMJ6nPhDNbuDGhUyQ=;
        b=OtWndrTeqolnNYuTu6lPAIYMFnRg5PZakcxBfsOpi+NIElZATnRkmDvW3OGrNpy7xA
         3sOuakefAJoWE84807tU8zBzZImG+WtGp+zujugqZIG4L8pfJ1Xw2sRzTwLoHXYyhJam
         pCu/GfRm2sCdT1kzBgK+zC0Jr3vkfg2xcphVnGjvTJ1v7beqjqbA+pjjyHHdMO+wG/Ju
         1Gm9aMt9H/phrIoOxfWDCuoVPTrLqGLSnk7e4ChWZwmtbR34oLqvnVCCKDv8+x4wjXmQ
         2KZIhf5wKxGd1/hsSakaP8asqAwzfzrykFv3eHHsS+Td9Tx2NsdSBKF5U8XES3TRKfSk
         za8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424431; x=1724029231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZXNFNaxM8vBPLxvkIIPrWaUY6tMJ6nPhDNbuDGhUyQ=;
        b=PCsAT7hjxbDdZca9RUuaCqOGfwc21lXP10sttSq2qECaOWfO9emUapsSTUOuP01PAy
         yz3vn2RDQIKxzC3Dx+Eq2rSDnc6ShF72QSlXh0g8b6h8Kk0Jb3cbxh5VMhbvwHDtVM/F
         FirPATvww6QuTJz2Wxr7j2h3qTjbX2uAf2eSd7FEBQblnLqI7zUfMQ568TZ2HNvi3LIC
         v0HW/KRq4cYSSZCBNKRCtxExfhKXbKE8yKUf1sntteSFduqI8ViWVPasarsbJRZQQsuS
         rYim0LgDuhP4as+CVPEsR2qGEWWlBlWmwajdLKb+ICgeO0Gp0LJmF76yWrSXvKi9BlbC
         EIDw==
X-Gm-Message-State: AOJu0Yx9SnhUCna5eZ9TZG/xxxkIwr9PKKTKa9t//lQhN5vjIT/ci1aw
	jZVziKttGZnidUJrQUoqXssM3BGRLrWhoJGH+7mdxcmG+WOpFeM6EqtSlRoBkqvxqsrl0+QS/yV
	Lysp4tQ==
X-Google-Smtp-Source: AGHT+IE9UN/eFl1Fb5sxAtzGTPfmVg74o1vo9nXqbGis0UuD39tez7iI9A3QbSPr+XUfKWTJWNIKOQ==
X-Received: by 2002:a05:6808:2f10:b0:3d9:40c2:eb54 with SMTP id 5614622812f47-3dc416688bdmr13217183b6e.5.1723424431425;
        Sun, 11 Aug 2024 18:00:31 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:30 -0700 (PDT)
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
Subject: [PATCH v8 08/17] ACPI: pci_link: Clear the dependencies after probe
Date: Mon, 12 Aug 2024 06:29:20 +0530
Message-ID: <20240812005929.113499-9-sunilvl@ventanamicro.com>
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

RISC-V platforms need to use dependencies between PCI host bridge, Link
devices and the interrupt controllers to ensure probe order. The
dependency is like below.

Interrupt controller <-- Link Device <-- PCI Host bridge.

If there is no dependency between Link device and PCI Host Bridge,
then PCI devices may be probed prior to Link devices.  If a PCI
device is probed before its Link device, we won't be able to find
its INTx mapping.

So, add the link device's HID to dependency honor list and clear the
dependency after probe is done so that the dependent devices are
unblocked to probe.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/pci_link.c | 2 ++
 drivers/acpi/scan.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index aa1038b8aec4..b727db968f33 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -748,6 +748,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
 	if (result)
 		kfree(link);
 
+	acpi_dev_clear_dependencies(device);
+
 	return result < 0 ? result : 1;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 28a221f956d7..753539a1f26b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -863,6 +863,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
 
-- 
2.43.0


