Return-Path: <linux-kernel+bounces-512195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF60A33577
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17033A7EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EEB433AD;
	Thu, 13 Feb 2025 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jL9xfCTA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792E1FC0F9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413404; cv=none; b=ZXW97rxU0nR2xf8POybJgRQ+X9jwofqnhSunNiw5pkpbf3lka8woY/SwiH6lKaj5OQo3Qw3CAvdSirC2yurxzQ6ajMBR5udPocTex6J7Y1UphabFZ27FmzRUfrWXMRjX+aevbB1LPmQb57/4V3TO51VcB5QNH//ebx3zmyCT638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413404; c=relaxed/simple;
	bh=OoRRahpbVAMGBc5smn3oO0r6pe7EYSt98PqXKvnRLPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDCSRXBkGqOqC5gY3cvRYOfKKYVfc+Ly4a06H2KFul/Czf8g7Do19OgCU8z0+LU780ac/losiYmcjXbMFSKIxX3kV9drzzJ50/j5m62dvWgSobefAWeo7cKWnCvRaddoU0fp6qvNUnw1WRks810WFmime2Gi+oFFfFK6ZREYMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jL9xfCTA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739413403; x=1770949403;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=OoRRahpbVAMGBc5smn3oO0r6pe7EYSt98PqXKvnRLPs=;
  b=jL9xfCTAbT5LlzONz3fFlks9UfY1fxHbAiqkKsqJkvD9zMRIysdq3Tha
   3brSbVc052E1rrg758bsTjL8uu2boZoAwIycNSCHyRiX5QxNPqpG9J5n+
   rNdH5ECH+ZD+RyLSj0bUFSd6IlDKL4fWDh5U8t9/pioGVftLAuHMIBar8
   KhCTMsfdWh80MsibaajdF5tC2Qucf1lopHCwCNG1D7+lCOysOJjU5sCLS
   972m1NP4dA4s/6f0hTl4vYaPiwDBt5StHO7zbewzn1lEZK12j36M+zVNc
   AWBZGx6XuzaMUze2w4LAaTzTPRsLp2OEsCMIHTiEm9bvy3DHb0tyAg6ep
   w==;
X-CSE-ConnectionGUID: nM4cGYhqTI+BfnIq6UFtEg==
X-CSE-MsgGUID: Bf8jaMhTRTiFoUoekWjuuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62566631"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="62566631"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:23:23 -0800
X-CSE-ConnectionGUID: V79EQJG8TC+nOWnISTCyKg==
X-CSE-MsgGUID: TB8686oGQCmavOJ7X9um4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113905837"
Received: from rtice-desk1.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.116.160])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:23:22 -0800
From: Cedric Xing <cedric.xing@intel.com>
Date: Wed, 12 Feb 2025 20:23:05 -0600
Subject: [PATCH 2/4] tsm: Add TSM measurement sample code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-tdx-rtmr-v1-2-9795dc49e132@intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
In-Reply-To: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 Cedric Xing <cedric.xing@intel.com>
X-Mailer: b4 0.13.0

This sample kernel module demonstrates how to make MRs accessible to user
mode through TSM.

Once loaded, this module registers a virtual measurement provider with the
TSM core and will result in the directory tree below.

/sys/kernel/tsm/
└── tsm_mr_sample
    ├── config_mr
    │   └── sha512
    │       └── digest
    ├── report_digest
    │   └── sha512
    │       └── digest
    ├── rtmr0
    │   └── sha256
    │       └── digest
    ├── rtmr1
    │   └── sha384
    │       └── digest
    ├── rtmr_crypto_agile
    │   ├── sha256
    │   │   └── digest
    │   └── sha384
    │       └── digest
    └── static_mr
        └── sha384
            └── digest

Among the MRs in this example:

- `static_mr` and `config_mr` are *Readonly* (static) MRs.
- `rtmr0` is an RTMR with `TSM_MR_F_W` **cleared**, preventing direct
  extensions; as a result, `rtmr0/sha256/digest` is read-only.
- `rtmr1` is an RTMR with `TSM_MR_F_W` **set**, permitting direct
  extensions; thus, `rtmr1/sha384/digest` is writable.
- `rtmr_crypto_agile` demonstrates a "single" MR that supports multiple
  hash algorithms. Each supported algorithm has a corresponding digest,
  usually referred to as a "bank" in TCG terminology. In this specific
  sample, the 2 banks are aliased to `rtmr0` and `rtmr1`, respectively.
- `report_digest` contains the digest of the internal report structure
  living in this sample module's memory. It is to demonstrate the use of
  the `TSM_MR_F_L` flag. Its value changes each time an RTMR is extended.

More details can be found in `samples/tsm/tsm_mr_sample.c`.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 MAINTAINERS                 |   1 +
 samples/Kconfig             |  10 +++++
 samples/Makefile            |   1 +
 samples/tsm/Makefile        |   2 +
 samples/tsm/tsm_mr_sample.c | 107 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c129fccd3d5a..56d0d7fee91a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24100,6 +24100,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm
 F:	drivers/virt/coco/tsm*.c
 F:	include/linux/tsm.h
+F:	samples/tsm/*
 
 TRUSTED SERVICES TEE DRIVER
 M:	Balint Dobszay <balint.dobszay@arm.com>
diff --git a/samples/Kconfig b/samples/Kconfig
index 820e00b2ed68..abbfd9547923 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -184,6 +184,16 @@ config SAMPLE_TIMER
 	bool "Timer sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
 
+config SAMPLE_TSM_MR
+	tristate "TSM measurement sample"
+	depends on TSM_REPORTS
+	help
+	  Build a sample module that emulates MRs (Measurement Registers) and
+	  exposes them to user mode applications through the TSM sysfs
+	  interface (/sys/kernel/tsm/tsm_mr_sample/).
+
+	  The module name will be tsm-mr-sample when built as a module.
+
 config SAMPLE_UHID
 	bool "UHID sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index f24cd0d72dd0..c4b6dcc81df6 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
 obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
+obj-$(CONFIG_SAMPLE_TSM_MR)		+= tsm/
diff --git a/samples/tsm/Makefile b/samples/tsm/Makefile
new file mode 100644
index 000000000000..587c3947b3a7
--- /dev/null
+++ b/samples/tsm/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SAMPLE_TSM_MR) += tsm_mr_sample.o
diff --git a/samples/tsm/tsm_mr_sample.c b/samples/tsm/tsm_mr_sample.c
new file mode 100644
index 000000000000..4c2c6cde36e1
--- /dev/null
+++ b/samples/tsm/tsm_mr_sample.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#define DEBUG
+#define pr_fmt(x) KBUILD_MODNAME ": " x
+
+#include <linux/module.h>
+#include <linux/tsm.h>
+#include <crypto/hash_info.h>
+#include <crypto/hash.h>
+
+struct {
+	u8 static_mr[SHA384_DIGEST_SIZE];
+	u8 config_mr[SHA512_DIGEST_SIZE];
+	u8 rtmr0[SHA256_DIGEST_SIZE];
+	u8 rtmr1[SHA384_DIGEST_SIZE];
+	u8 user_data[SHA512_DIGEST_SIZE];
+	u8 report_digest[SHA512_DIGEST_SIZE];
+} sample_report = {
+	.static_mr = "static_mr",
+	.config_mr = "config_mr",
+	.rtmr0 = "rtmr0",
+	.rtmr1 = "rtmr1",
+	.user_data = "user_data",
+};
+
+DEFINE_FREE(shash, struct crypto_shash *, if (!IS_ERR(_T)) crypto_free_shash(_T));
+
+static int sample_report_refresh(struct tsm_measurement *tmr,
+				 const struct tsm_measurement_register *mr)
+{
+	pr_debug("%s(%s,%s) is called\n", __func__, tmr->name, mr ? mr->mr_name : "<nil>");
+	struct crypto_shash *tfm __free(shash) =
+		crypto_alloc_shash(hash_algo_name[HASH_ALGO_SHA512], 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+	return crypto_shash_tfm_digest(tfm, (u8 *)&sample_report,
+				       offsetof(typeof(sample_report), report_digest),
+				       sample_report.report_digest);
+}
+
+static int sample_report_extend_mr(struct tsm_measurement *tmr,
+				   const struct tsm_measurement_register *mr, const u8 *data)
+{
+	SHASH_DESC_ON_STACK(desc, 0);
+	int rc;
+
+	pr_debug("%s(%s,%s) is called\n", __func__, tmr->name, mr->mr_name);
+
+	desc->tfm = crypto_alloc_shash(hash_algo_name[mr->mr_hash], 0, 0);
+	if (IS_ERR(desc->tfm))
+		return PTR_ERR(desc->tfm);
+
+	rc = crypto_shash_init(desc);
+	if (!rc)
+		rc = crypto_shash_update(desc, mr->mr_value, mr->mr_size);
+	if (!rc)
+		rc = crypto_shash_finup(desc, data, mr->mr_size, mr->mr_value);
+
+	crypto_free_shash(desc->tfm);
+	return rc;
+}
+
+#define MR_(mr, hash) .mr_value = &sample_report.mr, TSM_MR_(mr, hash)
+static const struct tsm_measurement_register sample_mrs[] = {
+	/* static MR, read-only */
+	{ MR_(static_mr, SHA384) },
+	/* config MR, read-only */
+	{ MR_(config_mr, SHA512) },
+	/* RTMR, direct extension prohibited */
+	{ MR_(rtmr0, SHA256) | TSM_MR_F_RTMR },
+	/* RTMR, direct extension allowed */
+	{ MR_(rtmr1, SHA384) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	/* RTMR, crypto agile, alaised to rtmr0 and rtmr1, respectively */
+	{ .mr_value = &sample_report.rtmr0,
+	  TSM_MR_(rtmr_crypto_agile, SHA256) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	{ .mr_value = &sample_report.rtmr1,
+	  TSM_MR_(rtmr_crypto_agile, SHA384) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	/* most CC archs allow including user data in attestation */
+	{ MR_(report_digest, SHA512) | TSM_MR_F_L },
+	/* terminating NULL entry */
+	{}
+};
+#undef MR_
+
+static struct tsm_measurement sample_mr_provider = {
+	.name = KBUILD_MODNAME,
+	.mrs = sample_mrs,
+	.refresh = sample_report_refresh,
+	.extend = sample_report_extend_mr,
+};
+
+static int __init tsm_mr_sample_init(void)
+{
+	return tsm_register_measurement(&sample_mr_provider);
+}
+
+static void __exit tsm_mr_sample_exit(void)
+{
+	tsm_unregister_measurement(&sample_mr_provider);
+}
+
+module_init(tsm_mr_sample_init);
+module_exit(tsm_mr_sample_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Sample tsm_measurement implementation");

-- 
2.43.0


