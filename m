Return-Path: <linux-kernel+bounces-197910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 797FD8D709F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAFF2831C2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71690153597;
	Sat,  1 Jun 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GfAJeR4D"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95141152DF7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254299; cv=none; b=WeevNqBW5P9MkA5EtMz1TUiS+nOw+Ww1Ody1QRSNnFlI7NvERoHRpTb1RzaloH+vOpkFb+xtRdvLyeyfGgR12Bo8A/5EOXE6iA8aX4edg61a7IIfvDLlTOe+R496QR6TpK9kWUmRJnALt3KSTj/p7d3jr0/2Fx6Y9WDiRa4AnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254299; c=relaxed/simple;
	bh=5W07LWryv9sCiUT9t9LTI1vN2XJHVgygsyGcyP6/IGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWz/XoHxMej8sQmbXlwc6gDKZbD+/UhomSWSWzEYZDHxG+qDmaAp2jpB1WDyCWtQRIOqTzQAMDZYoTAo5Vd1Y2hUz2xjJVoIE64xxLRJ71BGYjpztOP2u3ayS0vPNpvAXZDz2JM00OWlY0Cv4tpTK+lKMKXdJRPvGisIkAQaV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GfAJeR4D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-702447766fdso1901630b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254297; x=1717859097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMraijh7EdibSWZk0AZcru1m7VB53gCU3iTUEc1cnAQ=;
        b=GfAJeR4DNd3ze1I/onHarHOUb80MzfFqOK47aHFCAnlCbXgyCAsezgUO+g5slf7gCv
         ohWLMd4HlRHy4vi13vVqJQikCrkYdkR1Ep1qDobsmc4VSBqsH2s/9qKo2SU9g6KZvRTX
         BC0ZXc2tPZKVRSNFUuhzheGpO1Esig9LnIpZDnv0ccn/nItMVuOfyXzpypVMecXb1zGC
         aqW+SK937MOegCerIwkYP+PldMEw6OP59LCnt1ux+DKeAw2d9kU5Hsgue03w3DCWLjtY
         l69z0auJU24etcFihoqUasRZ7CfPV1pSwxkHX7nOQBLaqUXAGSA/kCgEysWCqFTP2/0j
         aWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254297; x=1717859097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMraijh7EdibSWZk0AZcru1m7VB53gCU3iTUEc1cnAQ=;
        b=QCb08mV+YFsAQrLOXKfnk1uuvUudwNPVoM2OrHDtJe5PKszgalE9qPewIQjcYBR8Qu
         fBh1Ny1NG3U+Rf4mH0Ci1644sZIwejNxTtUO+4o3zYrpggjqeIVd2oQd9GK9WewZ6GZU
         jViJxqQrfhYJgPC6MuRXGYP0AUeJ+vfvRqC2qOznr7TXaj9bt6ELHARAyrzW6SkdvgrW
         wkc96DrHPNNLAezAr+CU7iZP7BI5QAR3FrDsgaUd9NdqkQeqWru6cg4nBQIBwK0h1T/k
         xfxCEw5PRPMPQ3fREEkQzehjOqXGw/hbjJ6+yIme7RZr/P0jyua8vW50vpmFV0NYBz4E
         ac4w==
X-Forwarded-Encrypted: i=1; AJvYcCUy2HC4y4N7+LmdxOLo/sQlgIK+1Qxh0HGdhap81k1vXwOm+MhzvRc/LAh0ltMJiS1dXNfpPEFxbrwqmuIEd8kmkLEOPoPB4kz/C3sf
X-Gm-Message-State: AOJu0YxgnYLHIt9cB9EnydJTyLLRG4yzoA0AZGAOfE99e84u5wzgwZ17
	rZo5h0+6eFDbXdMeRwL5kpvWCxH9NhKAMaR5sBEVwx/74BTHtvXuC58FDwhlGsw=
X-Google-Smtp-Source: AGHT+IEKmyacfHakdX0P9GQl4t/BNHOtB7jRjgspK3iaFW5wKEhTYgTuLeBLCF/OOGDElEGcu+f4Dw==
X-Received: by 2002:a05:6a21:32a1:b0:1af:ad46:cd4a with SMTP id adf61e73a8af0-1b26f16ea65mr5996794637.12.1717254296842;
        Sat, 01 Jun 2024 08:04:56 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:04:56 -0700 (PDT)
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
Subject: [PATCH v6 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Sat,  1 Jun 2024 20:33:59 +0530
Message-Id: <20240601150411.1929783-6-sunilvl@ventanamicro.com>
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

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 66038fc731fb..6f3152170084 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -832,6 +832,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.40.1


