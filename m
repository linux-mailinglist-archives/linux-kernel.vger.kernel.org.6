Return-Path: <linux-kernel+bounces-227638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5FC9154DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FCB1C21164
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424919E7F7;
	Mon, 24 Jun 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ipFs9r1I"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B762F24;
	Mon, 24 Jun 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248156; cv=none; b=sSIcE252Uuv7phYcktjsBa/PMjIU6siVST7qSxr7c8NJbP2qmO+eAezlmWXBbOoLE/h3xNSAUu1ZrHvAoe9Pje1y4FxtuRs8raAQDll1A+x6glGoKXemj3azq1lbVgi65qZpPC1yna8ZdOU8CPzWz+1/MosPPcetjPyG6vwueTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248156; c=relaxed/simple;
	bh=OtnFWt7GuSx/+s3zheOa7vC9ohWCeJLAjCe0jvXtCIw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dqZSh5kfshCctN9SMyboK/25J9SkI73i63/4Gd3OLcqlO8HdKTiyKEIV6rgAKT7LedeDzTsEVUO46RIWfFLtDcJOfhl9QJb/NXbR9VXRYoExLjepvFRZQmcBSwLtCG87v+gwHcIOM6ZiCsLDyCzgl3rWHXgzARU4h+UeeFHsOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=ipFs9r1I; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1719248155; x=1750784155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=48rl6/jKAgjYmkDLF+VIhQW39kVTmSUknBkn3WlF1ZU=;
  b=ipFs9r1IYgQ/q8Dal45PgWbU5bDD17ou6geOGL0sh9ZtjsFF5Mymopr8
   xWDoOfJRCTaZyu8m2z4VrT4UwLUQuEIZY6gFriLyJ3BssgefQWh++Gfqg
   N9SIzYqjCsxPmxpSvMccNEQhtiIa3Q8ZVxFx4SXa5Z2NEl8mgctjV+AuU
   o=;
X-IronPort-AV: E=Sophos;i="6.08,262,1712620800"; 
   d="scan'208";a="415421077"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:55:50 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:21076]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.83.127:2525] with esmtp (Farcaster)
 id a9289de7-95f6-4105-81ec-4161d19e73db; Mon, 24 Jun 2024 16:55:49 +0000 (UTC)
X-Farcaster-Flow-ID: a9289de7-95f6-4105-81ec-4161d19e73db
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.108) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:55:44 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.106.82.9) by
 mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34 via Frontend Transport; Mon, 24 Jun 2024 16:55:42 +0000
From: Roman Kagan <rkagan@amazon.de>
To: <linux-arm-kernel@lists.infradead.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<nh-open-source@amazon.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/gicv3-its: Workaround for GIC-700 erratum 2195890
Date: Mon, 24 Jun 2024 18:55:41 +0200
Message-ID: <20240624165541.1286227-1-rkagan@amazon.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

According to Arm CoreLink GIC-700 erratum 2195890, on GIC revisions
r0p0, r0p1, r1p0 under certain conditions LPIs may remain in the Pending
Table until one of a number of external events occurs.

No LPIs are lost but they may not be delivered in a finite time.

The workaround is to issue an INV using GICR_INVLPIR to an unused, in
range LPI ID to retrigger the search.

Add this workaround to the quirk table.  When the quirk is applicable,
carve out one LPI ID from the available range and run periodic work to
do INV to it, in order to prevent GIC from stalling.

TT: https://t.corp.amazon.com/D82032616
Signed-off-by: Elad Rosner <eladros@amazon.com>
Signed-off-by: Mohamed Mediouni <mediou@amazon.com>
Signed-off-by: Roman Kagan <rkagan@amazon.de>
---
 drivers/irqchip/irq-gic-v3-its.c            | 70 ++++++++++++++++++++-
 Documentation/arch/arm64/silicon-errata.rst |  2 +
 arch/arm64/Kconfig                          | 18 ++++++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3c755d5dad6e..53cf50dd8e13 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -29,6 +29,7 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
+#include <linux/workqueue.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -49,6 +50,7 @@
 #define RD_LOCAL_MEMRESERVE_DONE                BIT(2)
 
 static u32 lpi_id_bits;
+static u32 lpi_id_base __initdata = 8192;
 
 /*
  * We allocate memory for PROPBASE to cover 2 ^ lpi_id_bits LPIs to
@@ -2136,7 +2138,7 @@ static int __init its_lpi_init(u32 id_bits)
 	 * Initializing the allocator is just the same as freeing the
 	 * full range of LPIs.
 	 */
-	err = free_lpi_range(8192, lpis);
+	err = free_lpi_range(lpi_id_base, lpis - lpi_id_base + 8192);
 	pr_debug("ITS: Allocator initialized for %u LPIs\n", lpis);
 	return err;
 }
@@ -4763,6 +4765,61 @@ static bool its_set_non_coherent(void *data)
 	return true;
 }
 
+#define ITS_QUIRK_GIC700_2195890_PERIOD_MSEC 1000
+static struct {
+	u32 lpi;
+	struct delayed_work work;
+} its_quirk_gic700_2195890_data __maybe_unused;
+
+static void __maybe_unused its_quirk_gic700_2195890_work_handler(struct work_struct *work)
+{
+	int cpu;
+	void __iomem *rdbase;
+	u64 gicr_invlpir_val;
+
+	for_each_online_cpu(cpu) {
+		rdbase = gic_data_rdist_cpu(cpu)->rd_base;
+		if (!rdbase) {
+			continue;
+		}
+
+		/*
+		 * Prod the respective GIC with an INV for an otherwise unused
+		 * LPI.  This is only to resume the stalled processing, so
+		 * there's no need to wait for invalidation to complete.
+		 */
+		gicr_invlpir_val =
+			FIELD_PREP(GICR_INVLPIR_INTID,
+				   its_quirk_gic700_2195890_data.lpi);
+		raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+		gic_write_lpir(gicr_invlpir_val, rdbase + GICR_INVLPIR);
+		raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	}
+
+	schedule_delayed_work(&its_quirk_gic700_2195890_data.work,
+		msecs_to_jiffies(ITS_QUIRK_GIC700_2195890_PERIOD_MSEC));
+}
+
+static bool __maybe_unused its_enable_quirk_gic700_2195890(void *data)
+{
+	struct its_node *its = data;
+
+	if (its_quirk_gic700_2195890_data.lpi)
+		return true;
+
+	/*
+	 * Use one LPI INTID from the start of the LPI range for GIC prodding,
+	 * and make it unavailable for regular LPI use later.
+	 */
+	its_quirk_gic700_2195890_data.lpi = lpi_id_base++;
+
+	INIT_DELAYED_WORK(&its_quirk_gic700_2195890_data.work,
+			  its_quirk_gic700_2195890_work_handler);
+	schedule_delayed_work(&its_quirk_gic700_2195890_data.work, 0);
+
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4822,6 +4879,17 @@ static const struct gic_quirk its_quirks[] = {
 		.property = "dma-noncoherent",
 		.init   = its_set_non_coherent,
 	},
+#ifdef CONFIG_ARM64_ERRATUM_2195890
+	{
+		.desc	= "ITS: GIC-700 erratum 2195890",
+		/*
+		 * Applies to r0p0, r0p1, r1p0: iidr_var(bits 16..19) == 0 or 1
+		 */
+		.iidr	= 0x0400043b,
+		.mask	= 0xfffeffff,
+		.init	= its_enable_quirk_gic700_2195890,
+	},
+#endif
 	{
 	}
 };
diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index eb8af8032c31..67445075ae88 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -169,6 +169,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | GIC-700         | #2195890        | ARM64_ERRATUM_2195890       |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b5..9c330029131c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1279,6 +1279,24 @@ config ROCKCHIP_ERRATUM_3588001
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_2195890
+	bool "GIC-700: 2195890: LPIs may be held in Pending Table until specific external events happen"
+	default y
+	help
+	  This option adds a workaround for Arm GIC-700 erratum 2195890.
+
+	  In affected GIC-700 versions (r0p0, r0p1, r1p0) under certain
+	  conditions LPIs may remain in the Pending Table until one of a number
+	  of external events occurs.
+
+	  No LPIs are lost and this can happen on physical or virtual PEs but
+	  this erratum means they may not be delivered in a finite time.
+
+	  Work around the issue by inserting an INV command for an unused but
+	  valid LPI INTID every so often to retrigger the search.
+
+	  If unsure, say Y.
+
 config SOCIONEXT_SYNQUACER_PREITS
 	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
 	default y
-- 
2.34.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


