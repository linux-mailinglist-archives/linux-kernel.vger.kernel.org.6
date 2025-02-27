Return-Path: <linux-kernel+bounces-536299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B888EA47DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0173E174264
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF423026D;
	Thu, 27 Feb 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gJjdIbz2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A422E011
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659811; cv=none; b=IEiL1s3ATqM5Rr3dG/jEAGwTaivweKsKnz9U8/bPZS/lDhWSMsB0ESpY6yPdrN4yKmy/O9FtWrXcOhTqQvMniMg1JQlFD3X2iSF6o7DiwwcB/vvdc9aIL4A7ipo/6WGt6XOh5WCsgfYQtnXD0WYE2PiQAGKJc1CIXyz4SIxtYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659811; c=relaxed/simple;
	bh=TlIOJZgzYRa0uSdvlZ7h4NFliLwrLJg52Wgu33BrOfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwbeIXe8ph9QwIenEW3Eet43TExLR4deHgOUHPAnqeaNGTHCWedRQwrNBj7I05F65Oze+LJ6scP/GvYRYZ79uZ9qNBMJ6jNx22FPVotHo6CZojBJUjjFRev5DbHdTGt/beg3xu1KSj+huHFw8Ec8ilnGcxqYtxDyMIIynMQRRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gJjdIbz2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e83d65e5so14285105ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659809; x=1741264609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=gJjdIbz2EjD91RRxj+IUpT6zqd+Cccc1k4kTMQ1C20i+bS6x+pLAIWglGh3MkboIYm
         2ALG1E2Z2SrdPGq74iq4w+WwKHyvUWijaBmivZae96ExuCIUoToTYKuNhiH4aIuBqEG/
         z5AnFZHqLzwxvyXfYX+sZcJ1FVqehJnH9Q5f0AYLH2mJzdlporhyiGTbjwhUdO7PUcrd
         VRs6e9p05LfHI+dbFl4G2uLjz97PjzgYVaujMGoHl0OgatV6g5NRLfxIrBtsb7slPfvq
         ZjtLr2O1CAoYDODgWsgCfW7H6WkAPvdos/01aw9TOeVgxr7qHsrDtUAR9ZKmWcIB10ko
         DX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659809; x=1741264609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=ZSa7sUWme0K1r/2LstLfzwI1C2FYd68iJYwBedvnKAM2Fs2rPzew/Z/qY6SWEusN4Z
         BW7BNR0wtrSiJd1V+ZJkMfi+64NUzFj+XkJWVluwWwAMiexssqGofWRTrVf9yNAORyam
         3rB+nqifRMxeIA0BE8LIZe2L9+N++XUkHazDBLPp+8qzL3b2i7WUDbLViSQA6+wT5TkZ
         xrEb38/cx1coVkUkbmrD9EKgv94Hur4/fTnycH0t4SMk6KS6OLNyblQUqxksVGQQCoXD
         dJAMTLKHEDFey6TahugGKBTisP0AnMLV1svn3C66Rv9Ju357RjrMOkLWaKDPwmSTL1dr
         xN2w==
X-Forwarded-Encrypted: i=1; AJvYcCW9SbKUiBSYHWwnn65KVGmyKw4Tu2Bug20UxtzMn69GyL1oVSwkBW3xunciGA0P4dbYUtX7VlezPUH63kY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rtrjEPclNbSQTz0Wym0UOgoDNi2SP4xT1J+JHeCLK67ncplV
	aM+7rvAPJKUiwXP1Mk6KK1y/rVH3x7ygICU8QMG8EUUs8b8U7tjrYaOMKHdSb7Q=
X-Gm-Gg: ASbGncs8N3ybf00f/zYCgQ5RUcAALtWNTBFDyzbsVetMYIUBkiir7QdaxgaWx+NsQAI
	hzBndoHAdWFTuj2VbbPlPLnEidoiO1np4J8sUHhGVtYTYpnR872WKWQ7J938o/Pt4CMsktFmv2d
	TU1NZwyHQbz+0V0mgYWUOL6jjboOiwXjtP+k5EcNKTEmPcNPTbcGsU9GqTawvygnruAMQ8UZT14
	C/DgWIdzxsXFIdUECDg27Elqw5tZJoEZlBJst9pqAVxyFqqVBTpdc/5Oj3P6ZZVnoyuRJncJQw1
	RWrQdezoB2OHQYJHm94HTjjVU/rFRO8eLcbw
X-Google-Smtp-Source: AGHT+IGIh9E0vXJbqDwy2DSU2gnNrcolcT0Umoa7eQqwP9lNhXHlny+mB50OGnl9ch8jNaDBTVMb8Q==
X-Received: by 2002:a17:902:f706:b0:215:b058:289c with SMTP id d9443c01a7336-22320061fd6mr98812585ad.8.1740659809295;
        Thu, 27 Feb 2025 04:36:49 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:49 -0800 (PST)
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
Subject: [RFC PATCH v1 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Thu, 27 Feb 2025 18:06:20 +0530
Message-ID: <20250227123628.2931490-3-hchauhan@ventanamicro.com>
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

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..0c599452ef48 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -27,6 +27,26 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
+ * with a kernel command line parameter "acpi=nocmcoff". But we don't
+ * have this IA-32 specific feature on ARM64, this definition is only
+ * for compatibility.
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	/*
+	 * Until we have a way to look for EFI memory attributes.
+	 */
+	return PAGE_KERNEL;
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
-- 
2.43.0


