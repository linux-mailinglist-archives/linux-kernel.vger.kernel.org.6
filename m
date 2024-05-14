Return-Path: <linux-kernel+bounces-179049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B078C5AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8361F22660
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61876181BB0;
	Tue, 14 May 2024 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a/kZLLM5"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FE181338
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710628; cv=none; b=Y3VHomRplAu7k3vR+AO6eNxirSjeqyFi9dQhh3kPiBeXztllaNFkzrlpIZ/mNpHFw06FOzLlg8Z2mopqYVpfVRjniWN3etDdx7h0Q026Bqh+W4gvGBH494bG4fsQmCD6SJ9FZpFLyO3TFaQUo3dWiLVP15wYn6E8+n7AAwSTSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710628; c=relaxed/simple;
	bh=06NnLt05SGFjSgAun+1jm25+g/itFDeuUtWow50prbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBZyld9RpSofcwh7ky7g3kpjvHTAw7mQP4bCNXk+E7WIXgTK3s8fEdUbQs+oi9t0d+BIeiye5emISgOCxPsdcwm6HplODjgIFhGiOsZIkaihBIg3wcB3ktRrtzh4FnvoFuFjGklv2P42hDRg+d7F8jtgTQXOTzXSiUYnpu90os4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a/kZLLM5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee12baa01cso48792195ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715710626; x=1716315426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCXu/G9/592i898mtWEeIMO1SmPGaJb0OnuEauaNIwg=;
        b=a/kZLLM5LYpkAmKT7eF5f3HI+rQRx2aQvk7i0+fG3DRsadYXdYImD1G/Lhpgo+rZi3
         8+4lNgvHXbw4AnsypXyqe7WfpUGftvPoOSYDMBmcLDjDnnSKltH2izVNscotDigzaXoT
         WG2ys2NfHrfVb0NytgjCk+NlVwQ3K/QqSYUX2yevreUjhbOQ24eF8WtWFB6wVlILLfcx
         8JHZIBO75ZrBqb5bdfHdyyFG5Av2Q+ctZLXhg+g+HC+ktmK3JFrHkPnbTNojrjffu7hH
         +DDfBOxGNwQ0Prwdpap9pStSBzpuzWkFxzEv4GJ1PuKivt8wPqOp4aNIJDXk5nGcjoHe
         Z+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715710626; x=1716315426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCXu/G9/592i898mtWEeIMO1SmPGaJb0OnuEauaNIwg=;
        b=RqUwZK3yI+HCqnj3VnwH/fAOZos0f2JYoqno93q8GkaYLHYsznAku9W5BTv+dCGrD5
         dmTLsEtbD0hsUaKS47JuqALLiRecLAyUwtJSnuI/50KK+5U1sJiHlTxdv7fx/u+ahVhZ
         91mLlCF0iKj04xRElzaXcWWIJkSHHk1mMBRid8+DeFRhWYhb/QmZCkBnhny/XvgSaHsR
         RJiFqrhVQQqU+sU0PCuYpZsvqrGG8CVe0O/EEzVVF3AACP5Hle35TmKvcoTUSdIICzII
         I95zMFLsYxItCC6Ep/mA12Kilx+E/YDDxE2L6YcneBnBfIWju4WltubDqrqikdyOPHJz
         3Q1g==
X-Forwarded-Encrypted: i=1; AJvYcCUfyEfS5XoRgKxEmcN61FHhNPiBDKLTTbOMqcDIsy53uU3Ne9BhW2gI2fD3FHIQvADiHdYQdvcrdygvKt8eWSnEBksVPsOSrfOVGEHs
X-Gm-Message-State: AOJu0YzoPKh0bT/lHefG1po315ZqKFXBrrc2HFzIqZkbU1Ju8oenXpyz
	3xVsvYXCALPX60wXWMi5/fPRY2g6gt3oe4/DpteJbdxFJj9T283VeGSSqf/Kj8E=
X-Google-Smtp-Source: AGHT+IEjcR+hFFOlW0MhggKlPLbvggrkKlNfHGY04pnOF7oiBWNIXsODAzdM+JrKRzCEZjmhStzAmQ==
X-Received: by 2002:a17:903:110d:b0:1dd:bf6a:2b97 with SMTP id d9443c01a7336-1ef4404b5c8mr153695635ad.60.1715710626241;
        Tue, 14 May 2024 11:17:06 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad6386sm100993625ad.80.2024.05.14.11.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 11:17:05 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 5/7] iommu/riscv: Device directory management.
Date: Tue, 14 May 2024 11:16:17 -0700
Message-Id: <6668ff51bf5b751b311ffc25946db10862dd86bd.1715708679.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715708679.git.tjeznach@rivosinc.com>
References: <cover.1715708679.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce device context allocation and device directory tree
management including capabilities discovery sequence, as described
in Chapter 2.1 of the RISC-V IOMMU Architecture Specification.

Device directory mode will be auto detected using DDTP WARL property,
using highest mode supported by the driver and hardware. If none
supported can be configured, driver will fall back to global pass-through.

First level DDTP page can be located in I/O (detected using DDTP WARL)
and system memory.

Only simple identity and blocking protection domains are supported by
this implementation.

Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 397 +++++++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h |   5 +
 2 files changed, 392 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index b8e0e4b62585..9ca130505c96 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -16,15 +16,168 @@
 #include <linux/crash_dump.h>
 #include <linux/init.h>
 #include <linux/iommu.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
+#include "../iommu-pages.h"
 #include "iommu-bits.h"
 #include "iommu.h"
 
 /* Timeouts in [us] */
 #define RISCV_IOMMU_DDTP_TIMEOUT	50000
 
+/* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=> PPN[53:10] */
+#define phys_to_ppn(pa)  (((pa) >> 2) & (((1ULL << 44) - 1) << 10))
+#define ppn_to_phys(pn)	 (((pn) << 2) & (((1ULL << 44) - 1) << 12))
+
+#define dev_to_iommu(dev) \
+	iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
+
+/* Device resource-managed allocations */
+struct riscv_iommu_devres {
+	void *addr;
+	int order;
+};
+
+static void riscv_iommu_devres_pages_release(struct device *dev, void *res)
+{
+	struct riscv_iommu_devres *devres = res;
+
+	iommu_free_pages(devres->addr, devres->order);
+}
+
+static int riscv_iommu_devres_pages_match(struct device *dev, void *res, void *p)
+{
+	struct riscv_iommu_devres *devres = res;
+	struct riscv_iommu_devres *target = p;
+
+	return devres->addr == target->addr;
+}
+
+static void *riscv_iommu_get_pages(struct riscv_iommu_device *iommu, int order)
+{
+	struct riscv_iommu_devres *devres;
+	void *addr;
+
+	addr = iommu_alloc_pages_node(dev_to_node(iommu->dev),
+				      GFP_KERNEL_ACCOUNT, order);
+	if (unlikely(!addr))
+		return NULL;
+
+	devres = devres_alloc(riscv_iommu_devres_pages_release,
+			      sizeof(struct riscv_iommu_devres), GFP_KERNEL);
+
+	if (unlikely(!devres)) {
+		iommu_free_pages(addr, order);
+		return NULL;
+	}
+
+	devres->addr = addr;
+	devres->order = order;
+
+	devres_add(iommu->dev, devres);
+
+	return addr;
+}
+
+static void riscv_iommu_free_pages(struct riscv_iommu_device *iommu, void *addr)
+{
+	struct riscv_iommu_devres devres = { .addr = addr };
+
+	devres_release(iommu->dev, riscv_iommu_devres_pages_release,
+		       riscv_iommu_devres_pages_match, &devres);
+}
+
+/* Lookup and initialize device context info structure. */
+static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
+						 unsigned int devid)
+{
+	const bool base_format = !(iommu->caps & RISCV_IOMMU_CAP_MSI_FLAT);
+	unsigned int depth;
+	unsigned long ddt, old, new;
+	void *ptr;
+	u8 ddi_bits[3] = { 0 };
+	u64 *ddtp = NULL;
+
+	/* Make sure the mode is valid */
+	if (iommu->ddt_mode < RISCV_IOMMU_DDTP_MODE_1LVL ||
+	    iommu->ddt_mode > RISCV_IOMMU_DDTP_MODE_3LVL)
+		return NULL;
+
+	/*
+	 * Device id partitioning for base format:
+	 * DDI[0]: bits 0 - 6   (1st level) (7 bits)
+	 * DDI[1]: bits 7 - 15  (2nd level) (9 bits)
+	 * DDI[2]: bits 16 - 23 (3rd level) (8 bits)
+	 *
+	 * For extended format:
+	 * DDI[0]: bits 0 - 5   (1st level) (6 bits)
+	 * DDI[1]: bits 6 - 14  (2nd level) (9 bits)
+	 * DDI[2]: bits 15 - 23 (3rd level) (9 bits)
+	 */
+	if (base_format) {
+		ddi_bits[0] = 7;
+		ddi_bits[1] = 7 + 9;
+		ddi_bits[2] = 7 + 9 + 8;
+	} else {
+		ddi_bits[0] = 6;
+		ddi_bits[1] = 6 + 9;
+		ddi_bits[2] = 6 + 9 + 9;
+	}
+
+	/* Make sure device id is within range */
+	depth = iommu->ddt_mode - RISCV_IOMMU_DDTP_MODE_1LVL;
+	if (devid >= (1 << ddi_bits[depth]))
+		return NULL;
+
+	/* Get to the level of the non-leaf node that holds the device context */
+	for (ddtp = iommu->ddt_root; depth-- > 0;) {
+		const int split = ddi_bits[depth];
+		/*
+		 * Each non-leaf node is 64bits wide and on each level
+		 * nodes are indexed by DDI[depth].
+		 */
+		ddtp += (devid >> split) & 0x1FF;
+
+		/*
+		 * Check if this node has been populated and if not
+		 * allocate a new level and populate it.
+		 */
+		do {
+			ddt = READ_ONCE(*(unsigned long *)ddtp);
+			if (ddt & RISCV_IOMMU_DDTE_VALID) {
+				ddtp = __va(ppn_to_phys(ddt));
+				break;
+			}
+
+			ptr = riscv_iommu_get_pages(iommu, 0);
+			if (!ptr)
+				return NULL;
+
+			new = phys_to_ppn(__pa(ptr)) | RISCV_IOMMU_DDTE_VALID;
+			old = cmpxchg_relaxed((unsigned long *)ddtp, ddt, new);
+
+			if (old == ddt) {
+				ddtp = (u64 *)ptr;
+				break;
+			}
+
+			/* Race setting DDT detected, re-read and retry. */
+			riscv_iommu_free_pages(iommu, ptr);
+		} while (1);
+	}
+
+	/*
+	 * Grab the node that matches DDI[depth], note that when using base
+	 * format the device context is 4 * 64bits, and the extended format
+	 * is 8 * 64bits, hence the (3 - base_format) below.
+	 */
+	ddtp += (devid & ((64 << base_format) - 1)) << (3 - base_format);
+
+	return (struct riscv_iommu_dc *)ddtp;
+}
+
 /*
  * This is best effort IOMMU translation shutdown flow.
  * Disable IOMMU without waiting for hardware response.
@@ -37,10 +190,201 @@ static void riscv_iommu_disable(struct riscv_iommu_device *iommu)
 	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
 }
 
+#define riscv_iommu_read_ddtp(iommu) ({ \
+	u64 ddtp; \
+	riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
+				  !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
+				  RISCV_IOMMU_DDTP_TIMEOUT); \
+	ddtp; })
+
+static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
+{
+	u64 ddtp;
+	unsigned int mode;
+
+	ddtp = riscv_iommu_read_ddtp(iommu);
+	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
+		return -EBUSY;
+
+	/*
+	 * It is optional for the hardware to report a fixed address for device
+	 * directory root page when DDT.MODE is OFF or BARE.
+	 */
+	mode = FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp);
+	if (mode == RISCV_IOMMU_DDTP_MODE_BARE ||
+	    mode == RISCV_IOMMU_DDTP_MODE_OFF) {
+		/* Use WARL to discover hardware fixed DDT PPN */
+		riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
+				   FIELD_PREP(RISCV_IOMMU_DDTP_MODE, mode));
+		ddtp = riscv_iommu_read_ddtp(iommu);
+		if (ddtp & RISCV_IOMMU_DDTP_BUSY)
+			return -EBUSY;
+
+		iommu->ddt_phys = ppn_to_phys(ddtp);
+		if (iommu->ddt_phys)
+			iommu->ddt_root = devm_ioremap(iommu->dev,
+						       iommu->ddt_phys, PAGE_SIZE);
+		if (iommu->ddt_root)
+			memset(iommu->ddt_root, 0, PAGE_SIZE);
+	}
+
+	if (!iommu->ddt_root) {
+		iommu->ddt_root = riscv_iommu_get_pages(iommu, 0);
+		iommu->ddt_phys = __pa(iommu->ddt_root);
+	}
+
+	if (!iommu->ddt_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * Discover supported DDT modes starting from requested value,
+ * configure DDTP register with accepted mode and root DDT address.
+ * Accepted iommu->ddt_mode is updated on success.
+ */
+static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
+				      unsigned int ddtp_mode)
+{
+	struct device *dev = iommu->dev;
+	u64 ddtp, rq_ddtp;
+	unsigned int mode, rq_mode = ddtp_mode;
+
+	ddtp = riscv_iommu_read_ddtp(iommu);
+	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
+		return -EBUSY;
+
+	/* Disallow state transition from xLVL to xLVL. */
+	mode = FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp);
+	if (mode != RISCV_IOMMU_DDTP_MODE_BARE &&
+	    mode != RISCV_IOMMU_DDTP_MODE_OFF &&
+	    rq_mode != RISCV_IOMMU_DDTP_MODE_BARE &&
+	    rq_mode != RISCV_IOMMU_DDTP_MODE_OFF)
+		return -EINVAL;
+
+	do {
+		rq_ddtp = FIELD_PREP(RISCV_IOMMU_DDTP_MODE, rq_mode);
+		if (rq_mode > RISCV_IOMMU_DDTP_MODE_BARE)
+			rq_ddtp |= phys_to_ppn(iommu->ddt_phys);
+
+		riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, rq_ddtp);
+		ddtp = riscv_iommu_read_ddtp(iommu);
+		if (ddtp & RISCV_IOMMU_DDTP_BUSY) {
+			dev_err(dev, "timeout when setting ddtp (ddt mode: %u, read: %llx)\n",
+				rq_mode, ddtp);
+			return -EBUSY;
+		}
+
+		/* Verify IOMMU hardware accepts new DDTP config. */
+		mode = FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp);
+
+		if (rq_mode == mode)
+			break;
+
+		/* Hardware mandatory DDTP mode has not been accepted. */
+		if (rq_mode < RISCV_IOMMU_DDTP_MODE_1LVL && rq_ddtp != ddtp) {
+			dev_err(dev, "DDTP update failed hw: %llx vs %llx\n",
+				ddtp, rq_ddtp);
+			return -EINVAL;
+		}
+
+		/*
+		 * Mode field is WARL, an IOMMU may support a subset of
+		 * directory table levels in which case if we tried to set
+		 * an unsupported number of levels we'll readback either
+		 * a valid xLVL or off/bare. If we got off/bare, try again
+		 * with a smaller xLVL.
+		 */
+		if (mode < RISCV_IOMMU_DDTP_MODE_1LVL &&
+		    rq_mode > RISCV_IOMMU_DDTP_MODE_1LVL) {
+			dev_dbg(dev, "DDTP hw mode %u vs %u\n", mode, rq_mode);
+			rq_mode--;
+			continue;
+		}
+
+		/*
+		 * We tried all supported modes and IOMMU hardware failed to
+		 * accept new settings, something went very wrong since off/bare
+		 * and at least one xLVL must be supported.
+		 */
+		dev_err(dev, "DDTP hw mode %u, failed to set %u\n",
+			mode, ddtp_mode);
+		return -EINVAL;
+	} while (1);
+
+	iommu->ddt_mode = mode;
+	if (mode != ddtp_mode)
+		dev_dbg(dev, "DDTP hw mode %u, requested %u\n", mode, ddtp_mode);
+
+	return 0;
+}
+
+#define RISCV_IOMMU_FSC_BARE 0
+
+/*
+ * Update IODIR for the device.
+ *
+ * During the execution of riscv_iommu_probe_device(), IODIR entries are
+ * allocated for the device's identifiers.  Device context invalidation
+ * becomes necessary only if one of the updated entries was previously
+ * marked as valid, given that invalid device context entries are not
+ * cached by the IOMMU hardware.
+ * In this implementation, updating a valid device context while the
+ * device is not quiesced might be disruptive, potentially causing
+ * interim translation faults.
+ */
+static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
+				     struct device *dev, u64 fsc, u64 ta)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_dc *dc;
+	u64 tc;
+	int i;
+
+	/* Device context invalidation ignored for now. */
+
+	/*
+	 * For device context with DC_TC_PDTV = 0, translation attributes valid bit
+	 * is stored as DC_TC_V bit (both sharing the same location at BIT(0)).
+	 */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
+		tc = READ_ONCE(dc->tc);
+		tc |= ta & RISCV_IOMMU_DC_TC_V;
+
+		WRITE_ONCE(dc->fsc, fsc);
+		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
+		/* Update device context, write TC.V as the last step. */
+		dma_wmb();
+		WRITE_ONCE(dc->tc, tc);
+	}
+}
+
+static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
+					      struct device *dev)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
+	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+
+	return 0;
+}
+
+static struct iommu_domain riscv_iommu_blocking_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev = riscv_iommu_attach_blocking_domain,
+	}
+};
+
 static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev)
 {
-	/* Global pass-through already enabled, do nothing for now. */
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
+	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
+
 	return 0;
 }
 
@@ -72,6 +416,9 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_device *iommu;
+	struct riscv_iommu_dc *dc;
+	u64 tc;
+	int i;
 
 	if (!fwspec || !fwspec->iommu_fwnode->dev || !fwspec->num_ids)
 		return ERR_PTR(-ENODEV);
@@ -80,12 +427,37 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * IOMMU hardware operating in fail-over BARE mode will provide
+	 * identity translation for all connected devices anyway...
+	 */
+	if (iommu->ddt_mode <= RISCV_IOMMU_DDTP_MODE_BARE)
+		return ERR_PTR(-ENODEV);
+
+	/*
+	 * Allocate and pre-configure device context entries in
+	 * the device directory. Do not mark the context valid yet.
+	 */
+	tc = 0;
+	if (iommu->caps & RISCV_IOMMU_CAP_AMO_HWAD)
+		tc |= RISCV_IOMMU_DC_TC_SADE;
+	for (i = 0; i < fwspec->num_ids; i++) {
+		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
+		if (!dc)
+			return ERR_PTR(-ENODEV);
+		if (READ_ONCE(dc->tc) & RISCV_IOMMU_DC_TC_V)
+			dev_warn(dev, "already attached to IOMMU device directory\n");
+		WRITE_ONCE(dc->tc, tc);
+	}
+
 	return &iommu->iommu;
 }
 
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
 	.identity_domain = &riscv_iommu_identity_domain,
+	.blocked_domain = &riscv_iommu_blocking_domain,
+	.release_domain = &riscv_iommu_blocking_domain,
 	.def_domain_type = riscv_iommu_device_domain_type,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
@@ -128,6 +500,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
 	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
+	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -138,18 +511,20 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	if (rc)
 		return dev_err_probe(iommu->dev, rc, "unexpected device state\n");
 
-	/*
-	 * Placeholder for a complete IOMMU device initialization.  For now,
-	 * only bare minimum: enable global identity mapping mode and register sysfs.
-	 */
-	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
-			   FIELD_PREP(RISCV_IOMMU_DDTP_MODE, RISCV_IOMMU_DDTP_MODE_BARE));
+	rc = riscv_iommu_iodir_alloc(iommu);
+	if (rc)
+		return rc;
+
+	rc = riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_MAX);
+	if (rc)
+		return rc;
 
 	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
 				    dev_name(iommu->dev));
-	if (rc)
-		return dev_err_probe(iommu->dev, rc,
-				     "cannot register sysfs interface\n");
+	if (rc) {
+		dev_err_probe(iommu->dev, rc, "cannot register sysfs interface\n");
+		goto err_iodir_off;
+	}
 
 	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
 	if (rc) {
@@ -161,5 +536,7 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
+err_iodir_off:
+	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
 	return rc;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 700e33dc2446..f1696926582c 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -34,6 +34,11 @@ struct riscv_iommu_device {
 	/* available interrupt numbers, MSI or WSI */
 	unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
 	unsigned int irqs_count;
+
+	/* device directory */
+	unsigned int ddt_mode;
+	dma_addr_t ddt_phys;
+	u64 *ddt_root;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
-- 
2.34.1


