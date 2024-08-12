Return-Path: <linux-kernel+bounces-282460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C399D94E460
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0F5B2140E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ADD1BF38;
	Mon, 12 Aug 2024 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kWYK6Fq/"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96EB55896
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424472; cv=none; b=kGTwH9Bom4fuMcIYLtLdGk/l5qLouyMbAJiTPiBcbSwRxhx2JpFZAKnjSDzesehuVe9FdvJ5NtvqAVcp9TG136zskcA/GMS3iO+oBlKaU3rVhB84O21KrsS9E6MZX7AvncSXydikSySSCIg9u3/jASRohGDbXmbGBwjyIzSverw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424472; c=relaxed/simple;
	bh=kUGmilJtSEYHecokfsz1Dv8H4HmvP4hekzWOib2uw/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uC65DR9Fo+berxsvXEztXT9S4iS5P/C9D5UOsLb9P69SKNtitGS0XlyMlh9CiqTZQSucaJ2TigjinIIZFJ9yRV40AYiIYgVFMEtV7HbZPjI60fr6NwEVSOB2GTHJieWp4KnQ+Mwxw7bWMQ2j9nsrGOscgvThEpsMdREQBwKb/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kWYK6Fq/; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3dab336717fso2632603b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424469; x=1724029269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2F9HlOmYYBgfOGZ5Y5XAW+7ZHo7CSZJxIOIoseG4Ek=;
        b=kWYK6Fq/HwdwMPdSnaD01bOjKw/O3sxBsSzc06M8JflmeLCiw8H2wVKZUrovQGpVJX
         EvYk47MD/ieoRgy60gt2rTOGt4lKlZJ9u3Gd81wgmKf/lwLf+OePaorIjOOJsTfViZ5q
         dS4LX5DgvX+qlI91hDr7yz5nya1JUYpSfOO2puRfodzSWthO4CiKL/oztDEneEo+LOEo
         A3fKPwRDUXTMuMXw0H/slEJPCSA3C3WTrbgEfpnBPhztFp+xE/GnghQvmkpxLtIFN9tS
         1NubejwkX+KR1eaTead5IhTRpuYfmqklZKf52QEHs2x/lJsJWiJ+Mw3quCVE1FUejdu3
         eQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424469; x=1724029269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2F9HlOmYYBgfOGZ5Y5XAW+7ZHo7CSZJxIOIoseG4Ek=;
        b=AGMA8mlM3DgK0pmzyFPuZPGzO1lqTmG8G0c9sPadBhA7UZhY66WkHgG8jMsYQov+ns
         zqWHy6Gqhi/yYHvd7qockUexLMhxiBGK9HsL/5+BQZRIQ9lOIlEOPwUXE78xefZU0V62
         nfmpYJOGuyqzeF6F2N4fFOUTNO2u0LphGlN4tQ0fnG+3noiiSEGM4Zl+r8ACrJVDwgLI
         rZcS+i1DmBAXln9iQlu04Re/4TBVe1aLq5wcvEiDkVrU6npCE3lUekpLuaLKATNlFjMI
         Z8sgkJ/XHONdEkhyFtTQ2+DO1vRXys0LLzepqqyWeLlUaPkciH1sgAunNVg+aazY9DCL
         rFNA==
X-Gm-Message-State: AOJu0YzTMolaDfoniWn7pLnq0Ln6cee9lVSL4jFX5i9PvffqPO2bOAns
	x47kAUMEcdwxArdvZyzE91fdugcPMXhViZ94At+EROn5q5TLszSfPI9eOKcrma61HJu5hv5JbyQ
	5F6AgKw==
X-Google-Smtp-Source: AGHT+IHZXV1nZ3pGHtKOzIjfGzSIJM5PQQnjoEr5t/Q7EAetVkMKeElEktJkKAiBNFFJkWIu7MYWBg==
X-Received: by 2002:a05:6808:bcc:b0:3d9:35df:8f2 with SMTP id 5614622812f47-3dc4169de4bmr11444935b6e.28.1723424469384;
        Sun, 11 Aug 2024 18:01:09 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:01:08 -0700 (PDT)
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
Subject: [PATCH v8 14/17] irqchip/riscv-imsic-state: Create separate function for DT
Date: Mon, 12 Aug 2024 06:29:26 +0530
Message-ID: <20240812005929.113499-15-sunilvl@ventanamicro.com>
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

While populating IMSIC global structure, many fields are initialized
using DT properties. Make the code which uses DT properties as separate
function so that it is easier to add ACPI support later. No
functionality added/changed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 97 ++++++++++++++-----------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 5479f872e62b..f9e70832863a 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -510,6 +510,60 @@ static int __init imsic_matrix_init(void)
 	return 0;
 }
 
+static int __init imsic_populate_global_dt(struct fwnode_handle *fwnode,
+					   struct imsic_global_config *global,
+					   u32 *nr_parent_irqs)
+{
+	int rc;
+
+	/* Find number of guest index bits in MSI address */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,guest-index-bits",
+				  &global->guest_index_bits);
+	if (rc)
+		global->guest_index_bits = 0;
+
+	/* Find number of HART index bits */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,hart-index-bits",
+				  &global->hart_index_bits);
+	if (rc) {
+		/* Assume default value */
+		global->hart_index_bits = __fls(*nr_parent_irqs);
+		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
+			global->hart_index_bits++;
+	}
+
+	/* Find number of group index bits */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-bits",
+				  &global->group_index_bits);
+	if (rc)
+		global->group_index_bits = 0;
+
+	/*
+	 * Find first bit position of group index.
+	 * If not specified assumed the default APLIC-IMSIC configuration.
+	 */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
+				  &global->group_index_shift);
+	if (rc)
+		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
+
+	/* Find number of interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
+				  &global->nr_ids);
+	if (rc) {
+		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
+		return rc;
+	}
+
+	/* Find number of guest interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
+				  &global->nr_guest_ids);
+	if (rc)
+		global->nr_guest_ids = global->nr_ids;
+
+	return 0;
+}
+
 static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 					  u32 index, unsigned long *hartid)
 {
@@ -578,50 +632,9 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 		return -EINVAL;
 	}
 
-	/* Find number of guest index bits in MSI address */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,guest-index-bits",
-				  &global->guest_index_bits);
+	rc = imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
 	if (rc)
-		global->guest_index_bits = 0;
-
-	/* Find number of HART index bits */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,hart-index-bits",
-				  &global->hart_index_bits);
-	if (rc) {
-		/* Assume default value */
-		global->hart_index_bits = __fls(*nr_parent_irqs);
-		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
-			global->hart_index_bits++;
-	}
-
-	/* Find number of group index bits */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-bits",
-				  &global->group_index_bits);
-	if (rc)
-		global->group_index_bits = 0;
-
-	/*
-	 * Find first bit position of group index.
-	 * If not specified assumed the default APLIC-IMSIC configuration.
-	 */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
-				  &global->group_index_shift);
-	if (rc)
-		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
-
-	/* Find number of interrupt identities */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
-				  &global->nr_ids);
-	if (rc) {
-		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
 		return rc;
-	}
-
-	/* Find number of guest interrupt identities */
-	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
-				  &global->nr_guest_ids);
-	if (rc)
-		global->nr_guest_ids = global->nr_ids;
 
 	/* Sanity check guest index bits */
 	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
-- 
2.43.0


